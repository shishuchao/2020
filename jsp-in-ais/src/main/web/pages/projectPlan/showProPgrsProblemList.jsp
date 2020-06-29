<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>上报项目进度-监督问题列表</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script> 
<script type="text/javascript">
$(function(){
	var bCustomerChanged = false;
	var selectNode = null;
	if("${errMsg}"){
		top.$.messager.alert("提示信息","${errMsg}","error", function(){
			aud$closeTab();
		});
		return;
	}

	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var busGridTableId = "traceProblemTable";
	var editIndex = undefined;
	var saveBtn = {
	        text:'保存',
	        iconCls:'icon-save',
	        handler:function(){
	        	saveRows(false);
	        }
	};
	var addBtn = {
	        text:'新增',
	        iconCls:'icon-add',
	        handler:function(){
	        	if(endEditing()){
		        	$('#'+busGridTableId).datagrid('appendRow',{
						// 增删行时，业务对象需要的一些不需编辑字段的默认值
						'project_id':"${unlinePro.formId}",
						'project_code':"${unlinePro.w_plan_code}",
						'project_name':"${unlinePro.w_plan_name}",
						'pro_year':"${unlinePro.w_plan_year}",
						'pro_type':"${unlinePro.w_plan_type}",
						'pro_type_name':"${unlinePro.w_plan_type_name}",
						'audit_dept':"${unlinePro.audit_dept}",
						'audit_dept_name':"${unlinePro.audit_dept_name}"
		        	});
		        	var rowLen = $('#'+busGridTableId).datagrid('getRows').length;
					editIndex = rowLen - 1;
					$('#'+busGridTableId).datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	        	}
				var ed = $('#'+busGridTableId).datagrid('getEditor', {index:editIndex,field:'etName'});
				if(ed){
					$(ed.target).select().focus();
				}
	        }
	};
	var rejectBtn = {
            text:'撤销',
            iconCls:'icon-undo',
            handler:function(){
    			$('#'+busGridTableId).datagrid('rejectChanges');
    			editIndex = undefined;
            }
    };
	var importBtn = {
            text:'导入问题',
            iconCls:'icon-import',
            handler:function(){
            	$('#importTemplateWin').window('open');
            }
    };
	var closeBtn = {
            text:'关闭',
            iconCls:'icon-cancel',
            handler:function(){
            	aud$closeTab();
            }
	}
/*	var barView = ['export','-','reload','-',closeBtn];
	var barEdit = [saveBtn,'-',addBtn,'-','delete','-',rejectBtn,'-',importBtn,'-','export','-','reload','-',closeBtn];*/
	var barView = ['export','-','reload'];
	var barEdit = [saveBtn,'-',addBtn,'-','delete',/* '-',rejectBtn, */'-',importBtn,'-','export'/* ,'-','reload' */];
	var cusToolbar = isView ? barView : barEdit;


    // 结束上次编辑的行
	function endEditing(){
		if(editIndex == undefined){
			return true;
		}
		if($('#'+busGridTableId).datagrid('validateRow', editIndex)){//判断行是否校验成功，成功后结束编辑
			$('#'+busGridTableId).datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		}else{
			return false;
		}
	}

    //编辑and选中行
    function editAndSelect(index, field){
    	try{
			$('#'+busGridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);
			var ed = $('#'+busGridTableId).datagrid('getEditor', {index:index,field:field});
			if(ed){
				if(field == "scoreRatio"){
					$(ed.target).next('span').find("input:text").select()[0].focus();
				}else{
					$(ed.target).select()[0].focus();
				}
			}else{
				ed = $('#'+busGridTableId).datagrid('getEditor', {index:index,field:'etName'});
				$(ed.target).select()[0].focus();
			}
			//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
			editIndex = index;
    	}catch(e){
    		alert('editAndSelect:\n'+e.message);
    	}
    }

    // 监督问题
    var pbTypeArr = [];
    var pbTypeIds = "${pbTypeIds}".split(","), pbTypeNames = "${pbTypeNames}".split(",");
    $.each(pbTypeIds, function(i, pbTypeId){
    	pbTypeArr.push({
    	    'code':pbTypeId,
    	    'name':pbTypeNames[i]
    	});
    });
    //被监督单位
    var auditObjectArr = [];
    var auditObjectIds = "${auditObjectIds}".split(","), auditObjectNames = "${auditObjectNames}".split(",");
    $.each(auditObjectIds, function(i, auditObjectId){
        auditObjectArr.push({
            'code':auditObjectId,
            'name':auditObjectNames[i]
        });
    });
    // 保存问题,保存修改、新增的行
    function saveRows(noMsg){
		var rows = $('#'+busGridTableId).datagrid('getRows');
		if(rows && rows.length){
			var rt = true;
			for(var j = 0; j < rows.length; j++){
				var row = rows[j];
				var rowsIndex = $('#'+busGridTableId).datagrid('getRowIndex', row);
				if($('#'+busGridTableId).datagrid('validateRow', rowsIndex)){
					$('#'+busGridTableId).datagrid('endEdit', rowsIndex);
				}else{
					rt = false;
					var ed = $('#'+busGridTableId).datagrid('getEditor', {index:rowsIndex,field:"etName"});
					if(ed){
						$(ed.target).select().focus();
					}
					noMsg ? "" : showMessage1("第【"+parseInt(rowsIndex + 1)+"】行数据校验未通过，请检查填写数据！");
					break;
				}
				if (row.audit_con==null || row.audit_con==''){
					rt = false;
					noMsg ? "" : showMessage1("第【"+parseInt(rowsIndex + 1)+"】行数据校验未通过，请检查填写数据！");
					break;
				}
				if (!(new RegExp(/^[0-9]{1}\d*(\.\d{1,2})?$|^0\.\d{1,2}$/).test(row.problem_money))){
					rt = false;
					showMessage1("第【"+parseInt(rowsIndex + 1)+"】行涉及金额格式错误，请输入小数位数不超过2位的数值！");
					break;
				}
			}
			if(rt){
		    	var sendData = null;
		    	var insertRows = $('#'+busGridTableId).datagrid('getChanges','inserted');
		    	var updateRows = $('#'+busGridTableId).datagrid('getChanges','updated');
		    	//alert("insertRows="+insertRows.length+"\nupdateRows="+updateRows.length);
		    	var insertRowsJson = insertRows.length ? aud$rows2Json("insertRow", insertRows) : {};
		    	var updateRowsJson = updateRows.length ? aud$rows2Json("updateRow", updateRows) : {};
		    	sendData = $.extend({'projectId':"${unlinePro.formId}"}, insertRowsJson, updateRowsJson);
				$.ajax({
					url : "${contextPath}/projectPlan/saveProProblem.action",
					dataType:'json',
					type: "post",
					data: sendData,
					beforeSend:function(){
						var check = sendData != null ? true : false;
						check ? aud$loadOpen() : null;
						return check;
					},
					success: function(data){
						aud$loadClose();
						data.msg && !noMsg ? showMessage1(data.msg) : null;
		       			if(data.type = 'info'){
		       				$('#'+busGridTableId).datagrid('acceptChanges');
		       				busGridObj.refresh();
		       			}
					},
					error:function(data){
						aud$loadClose();
						top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
					}
				});
			}
		}else{
			noMsg ? "" : showMessage1("数据没有修改，不需保存");
		}
    }

    //自定义datagrid行editor
    $.extend($.fn.datagrid.defaults.editors, {
        editBox: {
            init: function(container, options){
            	var title = options.title ? options.title : "文本编辑/查看";
                var wrap = $('<div></div>').appendTo(container);
                var input = $('<input type="text" title="大文本框编辑/查看" style="width:80%;cursor:pointer;">')
                .attr('editWinTitle', title).appendTo(wrap[0]).bind('click', function(){
                    trigger.trigger('click');
                }).addClass("datagrid-editable-input").validatebox(options);
                var textarea = $('<textarea style="padding:10px;width:100%;height:100%;border-width:0px;font-size:16px!important;">');
                var trigger = $("<label ></label>").appendTo(wrap[0]).bind('click', function(){
                        textarea.val(input.val());
                        //alert(input.attr('editWinTitle'))
                        new aud$createTopDialog({
                            'title':input.attr('editWinTitle'),
                            'content':textarea,
                            'showProgress':'false',
							'width': 800,
							'height': 400,
							'zIndex':9020,
                            onClose:function(){
                                var value = textarea.val().substr(0,200);
                                 
                                input.val(value);
                            }
                        }).open();
                        try{
	                        setTimeout(function(){
	                        	textarea.select().focus();
	                        }, 10)
                        }catch(e){}
                    });
                return input;
            },
            getValue: function(target){
                return $(target).val();
            },
            setValue: function(target, value){
                $(target).val(value);
            },
            resize: function(target, width){
                var input = $(target);
                if ($.boxModel == true){
                    input.width(width - (input.outerWidth() - input.width()));
                } else {
                    input.width(width);
                }
            }
        }
    });

	$.extend($.fn.combotree.defaults.keyHandler,{
		/*up:function(){
			console.log('up');
		},
		down:function(){
			console.log('down');
		},
		enter:function(){
			console.log('enter');
		},*/
		query:function(q){
			bCustomerChanged = true;//记录是否有改变（当手动输入时发生)
			var t = $(this).combotree('tree');
			var nodes = t.tree('getChildren');
			for(var i=0; i<nodes.length; i++){
				var node = nodes[i];
				if (node.text.indexOf(q) >= 0){
					$(node.target).show();
				} else {
					$(node.target).hide();
				}
			}
			var opts = $(this).combotree('options');
			if (!opts.hasSetEvents){
				opts.hasSetEvents = true;
				var onShowPanel = opts.onShowPanel;
				opts.onShowPanel = function(){
					var nodes = t.tree('getChildren');
					for(var i=0; i<nodes.length; i++){
						$(nodes[i].target).show();
					}
					onShowPanel.call(this);
				};
				$(this).combo('options').onShowPanel = opts.onShowPanel;
			}
		}
	});

	// 监督问题列表
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+busGridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'LedgerProblem',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        order :'asc',
        sort  :'serial_num',
		winWidth:800,
	    winHeight:300,
	    myToolbar:['export'],
	    gqueryParams:{
	    	'query_eq_project_id':'${projectId}'
	    },
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:isView ? ['export', 'reload'] : ['delete', 'export'],
	    delRefresh:false,
		removeFilter:function(rows){
			var idArr = [];
			if(rows && rows.length){
				for(var i = 0; i < rows.length; i++){
					var row = rows[i];
					var rowIndex = $('#'+busGridTableId).datagrid('getRowIndex', row);
					$('#'+busGridTableId).datagrid('cancelEdit', rowIndex).datagrid('deleteRow', rowIndex);
					var pkId = row['id'];
					pkId ? idArr.push(pkId) : null;
				}
			}
			return idArr;
		},
        gridJson:{
			rownumbers:false,
		    pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		toolbar:cusToolbar,
        	onDblClickCell:function(index, field, value){
        		if(isView || field == 'id' || field == 'serial_num' || field == 'audit_object_name') return;
       			if(endEditing()){
       				editAndSelect(index, field);
       			}else{
       				$('#'+busGridTableId).datagrid('selectRow', editIndex);
       			}
    		},
    		onLoadSuccess:function(data){

    		},
    		frozenColumns:[[

    			{field:'id', title:"选择",  width:'10px',  align:'center', halign:'center', checkbox:true, show:'false'},
    			{field:'serial_num',title:"问题编号", width:'230px',align:'center',halign:'center', sortable:true},
    			{field:'audit_object',title:"<font color='red'>*</font>被监督单位名称", width:'200px',align:'left',halign:'center',
					formatter:viewLongName,exportField:'audit_object_name', exportTitle:'被监督单位名称',
					editor:{type:'combobox', options:{
                            editable:false,
							required:true,
                            valueField: 'code',
                            textField: 'name',
                            data: auditObjectArr
                        }},
                    formatter:function(value,row,index){
                        var vtext = "";
                        $.each(auditObjectArr, function(i, jdata){
                            if(jdata['code'] == value){
                                vtext = jdata['name'];
                                return false;
                            }
                        });
                        var rtVal = vtext ? vtext : value;
                        row['audit_object_name'] = rtVal;
                        return rtVal
                    }
    			}
    		]],

            columns:[[
                // {field:'sort_big_code', title:'问题类别', width:'250px',align:'center', halign:'center', formatter:viewLongName,
                //     show:false, sortable:true,exportField:'sort_big_name',
                //     editor:{type:'combobox', options:{
                //     	editable:false,
                //     	valueField: 'code',
                //     	textField: 'name',
                //     	data: pbTypeArr
                //     }},
                //     formatter:function(value,row,index){
                //         var vtext = "";
                //         $.each(pbTypeArr, function(i, jdata){
                //             if(jdata['code'] == value){
                //                 vtext = jdata['name'];
                //                 return false;
                //             }
                //         });
                //         var rtVal = vtext ? vtext : value;
                //         row['sort_big_name'] = rtVal;
                //         return rtVal
                //     }
                //
                // },
                // {field:'sort_big_name',title:"问题类别Name", width:'100px',align:'center',halign:'center',  hidden:true},

                {field:'problem_code', title:"<font color='red'>*</font>问题点", width:'250px',align:'left', halign:'center', formatter:viewLongName,
                	show:false, sortable:true, exportField:'problem_name',exportTitle:'问题点',
                    editor:{type:'combotree', options:{
							editable:false,
                            required:true,
							url: '/ais/ledger/problemledger/treeExpand.action',
                            valueField: 'id',
                            textField: 'text',
                            onLoadSuccess: function (node, data) {
								var ed =$('#'+busGridTableId).datagrid('getEditor', {index:editIndex,field:'problem_code'});
								var t = $(ed.target).datebox('getValue');
								if (t){
									var myNode = $(this).tree("find", t);
									$(this).tree("expandAll");
									$(this).tree("collapseAll");
									$(this).tree("expandTo", myNode.target);
								}
                             },
                            onBeforeSelect : function(node){
                                if(!$(this).tree("isLeaf", node.target)){//如果不是叶子节点，不让选择
                                    if(node.state == 'closed'){
                                        $(this).tree("expand",node.target);  //展开点击的文本的子节点
                                    }else{
                                        $(this).tree('collapse', node.target);
                                    }
                                    if ($(this).prev().combobox("panel").is(":visible")) {
                                        $(this).prev().combobox("hidePanel");
                                    } else {
                                        $(this).prev().combobox("showPanel");
                                    }
                                    //showMessage1("不能选择问题类别，请选择问题点");
                                    //return false;
                                }
                            }
							,onSelect: function (node) {
                            	selectNode = node;
								var ed = $('#'+busGridTableId).datagrid('getEditor', {index:editIndex,field:'audit_con'});
								var audit_con = $(ed.target).select()[0];
								if (audit_con!=null && $(audit_con).val()==''){
									$(audit_con).val(node.text);
								}
							}
                        }},
                        formatter:function(value,row,index){
                            var vtext = "";
                            $.each(pbTypeArr, function(i, jdata){
                                if(jdata['code'] == value){
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            var rtVal = vtext ? vtext : value;
                            row['problem_name'] = rtVal;
/*                            if (row['audit_con']==null || row['audit_con']==''){
								row['audit_con'] = rtVal;
							}*/
                            return row.problem_name;
                        }
                },
				{field:'audit_con',title:"<font color='red'>*</font>问题标题", width:'100px',align:'center',halign:'center',exportTitle:'问题标题'
					, editor:{
						type: 'text',
						options:{
							required:true,
							missingMessage:"该输入项为必输项！"
						}
					}},
                {field:'problem_name',title:"问题点Name", width:'100px',align:'center',halign:'center',  hidden:true},
                {field:'audit_object_name',title:"被监督单位Name", width:'100px',align:'center',halign:'center',  hidden:true},
    			{field:'describe',title:"<font color='red'>*</font>问题事实描述(200字限制)", width:'200px',align:'left',halign:'center', formatter:viewLongName,
                	exportTitle:'问题事实描述',
					editor:{type:'editBox', options:{
						required:true,
                        missingMessage:'问题事实描述文本类型必填(不大于200字)!',
						validType:'length[0,200]',
						'title':'问题事实描述(不大于200字)'
					}}
    			},
    			{field:'audit_law',title:"问题定性依据(200字限制)", width:'18%',align:'left',halign:'center', formatter:viewLongName, exportTitle:'问题定性依据',
    				editor:{type:'editBox', options:{
						missingMessage:'问题定性依据文本类型(不大于200字)',
						validType:'length[0,200]',
    					'title':'问题定性依据(不大于200字)'
    				}}
    			},
    			{field:'audit_advice',title:"<font color='red'>*</font>整改要求(或者管理意见(200字限制))", width:'15%',align:'left',halign:'center', formatter:viewLongName,
    				exportTitle:'整改要求(或者管理意见)',
    				editor:{type:'editBox', options:{
    					required:true,
						missingMessage:'整改要求(或者管理意见)文本类型必填(不大于200字)',
						validType:'length[0,200]',
    					'title':'整改要求(或者管理意见)(不大于200字)'
    				}}
    			},
    			{field:'problem_money',title:"<font color='red'>*</font>涉及金额(万元)", width:'140px',align:'right',halign:'center',
    				exportTitle:'涉及金额(万元)', sortable:true,
    				//editor:{type:'numberspinner', options:{
					editor:{type:'text', options:{
						//min:0,
						//max:10000000,
						//value:0,
						//precision:2,
						required:true,
						//missingMessage:'0-10000000范围数字',
						inputEvents:{
				            blur: function(e) {
				            	var tg = e.data.target;
				                $(tg).numberbox("setValue", $(tg).numberbox("getText"));
				                endEditing();
				            }
						}
					}},
    			}
    		]]
        }
    });

    window.problemGid = busGridObj;

	function viewLongName(value,row,index){
		if(value){
			return "<label title='"+value+"'>"+value+"</label>"
		}else{
			return "";
		}
	}

	$('#importTemplateWin').dialog({
	    title: "监督问题批量导入",
	   // width:  "700px",
	   // height: "150px",
	    closed: true,
	    cache:  false,
	    shadow: false,
	    modal: true,
	    resizable:true,
	    minimizable:false,
	    maximizable:true,
	    iconCls:'icon-import',
	    top: $(parent.window).height()*0.1,
	    left: $(parent.window).width()*0.2,
		width:$(parent.window).width()/2,
		height:$(parent.window).height()/2,

	    onOpen:function(){
	    	clearTemplateFile();
	    },
	    buttons:[{
			text:'下载模板',
			iconCls:'icon-export',
			handler:function(){
				downloadTemplate();
			}
		},{
			text:'导入文件',
			iconCls:'icon-save',
			handler:function(){
				importTemplate();
			}
		},{
			text:'清空',
			iconCls:'icon-empty',
			handler:function(){
				clearTemplateFile();
			}
		},{
			text:'关闭',
			iconCls:'icon-cancel',
			handler:function(){
				clearTemplateFile();
				$('#importTemplateWin').dialog('close');
			}
		}]
	});

	// 清空文件选择框
	function clearTemplateFile(){
		$('#fileSuffix').val('');
		var proTemplateFile = $('#proTemplateFile')[0];
		proTemplateFile.outerHTML = proTemplateFile.outerHTML;
		$('#proTemplateFile').unbind('change').bind('change', function(){
			 aud$checkFile();
		});
	}

	// 下载模板响应事件
	function downloadTemplate(){
		aud$loadOpen();
		window.location.href = "${contextPath}/templatedownload?file=proProgressProblem.xls&type=proProgressProblem&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid&projectId=${unlinePro.formId}";
		setTimeout(function(){
			aud$loadClose();
		},2000);
	}

	// 导入模板响应事件
	function importTemplate(){
		var proTemplateFile = $('#proTemplateFile').val();
		if(proTemplateFile == ''){
			top.$.messager.alert('系统提示',"请先选择要导入的文件",'warning');
			return;
		}
		if(!aud$checkFile()){
			return;
		}
		$("#importForm").form('submit',{
			url:'${contextPath}/projectPlan/importProProblemTemplate.action',
			onSubmit:function(){
				try{
					aud$loadOpen();
				}catch(e){}
			},
			success:function(data){
				try{
					aud$loadClose();
				}catch(e){}
			}
		});
	}



	function aud$checkFile(){
		var filePath = $('#proTemplateFile').val();
    	var arr = filePath.split('.');
    	var suffix = arr[arr.length - 1];
    	if(suffix && suffix.toLowerCase() != 'xls'){
    		top.$.messager.alert('系统提示','导入文件后缀名错误，请导入 后缀为xls的Excel文件！','warning');
    		return false;
    	}else{
    		$('#fileSuffix').val(suffix);
    		return true;
    	}
	}

});

// 导入成功后，回调函数
function aud$ImportExcelCallbackFn(resultType){
	if(resultType && resultType == 'info'){
		problemGid.refresh();
		try{
			$('#importTemplateWin').dialog('close');
		}catch(e){}
	}
}
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">
		<table id="traceProblemTable"></table>
	</div>

	<!-- 问题模板下载和问题导入 -->
	<div id="importTemplateWin">
		<iframe id="tmpIframe" name="tmpIframe" style='display:none'></iframe>
		<form id="importForm"  method="post"  enctype="multipart/form-data" target='tmpIframe'>
			<input type='hidden' name='projectId' value="${unlinePro.formId}"/>
			<input type='hidden' name='fileSuffix' id='fileSuffix' value=''/>
			<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
				<tr>
					<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
					<td class="editTd" align="left">
						<s:file name="templateFile" id='proTemplateFile' size="66%" cssStyle="font-size:15px" accept="application/vnd.ms-excel"/>
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>
