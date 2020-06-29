<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>审易项目信息解析-bean维护</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var busBaseUrl = "${contextPath}/syProjectParse/";
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var tabTitle = isView ? "查看" : "编辑";
	var isType = true;
	
	if("${errMsg}"){
		top.$.messager.alert('提示信息','${errMsg}', 'warning');
		isView = true;
	}
	
	// 行编辑
	var editIndex = undefined;
    // 结束上次编辑的行
	function endEditing(){
    	try{    		
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
    	}catch(e){
    		//alert('endEditing:\n'+e.message);
    	}
	}
    
    //编辑and选中行
    function editAndSelect(index, field){
    	try{			
    		//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
			editIndex = index; 
    		//var arr = ['addScore','addScoreReason'];
    		//field = $.inArray(arr, field) ? field : 'addScore';
			$('#'+busGridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);	       				
			var ed = $('#'+busGridTableId).datagrid('getEditor', {index:index,field:field});
			if(ed){                  
				if($(ed.target).next('span').length){					
		            $(ed.target).next('span').find("input:text").select()[0].focus();
				}else{					
	            	$(ed.target).select()[0].focus();
				}
			}else{
				ed = $('#'+busGridTableId).datagrid('getEditor', {index:index,field:'busName'});
				$(ed.target).select()[0].focus();
			}	     
    	}catch(e){
    		//alert('editAndSelect:\n'+e.message);
    	}
    }
    
	// 新增一条记录
    function addNewRow(isCopy){
        var isEndEdit = false;
        if (endEditing()) {
            isEndEdit = true;
            appendNewRow(isCopy);
        } else {
        	
        }
        var ed = $('#' + busGridTableId).datagrid('getEditor', {
            index: editIndex,
            field: 'busName'
        });
        if (ed) {
            $(ed.target).select().focus();
        }
    }
    // 添加一个新行
    function appendNewRow(isCopy){
    	var rowData = {
    		xh:editIndex ? editIndex + 1 : $('#' + busGridTableId).datagrid('getRows').length + 1,
    		qy:'1'
    	};
    	if(isCopy){
    		var chkRows = $('#' + busGridTableId).datagrid('getChecked');
    		var crow = chkRows && chkRows.length ? chkRows[0] : null;
    		if(crow){
    			rowData.busName = crow.busName;
    			rowData.xmlName = crow.xmlName;
    			rowData.audBeanName = crow.audBeanName;
    		}
    	}
        $('#' + busGridTableId).datagrid('appendRow', rowData);
        var rowLen = $('#' + busGridTableId).datagrid('getRows').length;
        editIndex = rowLen - 1;
        $('#' + busGridTableId).datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
    
	//保存行
    function saveRows(noMsg){
		try{
			//alert('noMsg:'+noMsg)
			var rows = $('#'+busGridTableId).datagrid('getRows');
			if(rows && rows.length){
				var rt = true;
				for(var j = 0; j < rows.length; j++){
					var row = rows[j];
					var rowsIndex = $('#'+busGridTableId).datagrid('getRowIndex', row);
					editIndex = rowsIndex;
					var isOk = $('#'+busGridTableId).datagrid('validateRow', rowsIndex);	
					//alert('editIndex='+editIndex+'\nisOk='+isOk)
					if(isOk){								
						$('#'+busGridTableId).datagrid('endEdit', rowsIndex);
					}else{
						rt = false;
						showMessage1("第【"+(editIndex+1)+"】行数据校验未通过");
					}
				}
				if(rt){
			    	var sendData = {};
			    	var insertRows = $('#'+busGridTableId).datagrid('getChanges','inserted');
			    	var updateRows = $('#'+busGridTableId).datagrid('getChanges','updated');	
			    	var insertRowsJson = insertRows.length ? aud$rows2Json("insertRow", insertRows) : {};   
			    	var updateRowsJson = updateRows.length ? aud$rows2Json("updateRow", updateRows) : {};
			    	sendData = $.extend({"beanName":"SyProjectParse"}, insertRowsJson, updateRowsJson);	
					$.ajax({
						url : busBaseUrl+"saveRows.action",
						dataType:'json',
						type: "post",
						data: sendData,
						beforeSend:function(){
							var check = sendData != null ? true : false;
							check ? aud$loadOpen() : null;
							return check;
						},
						success: function(data){
							try{
								aud$loadClose();
							}catch(e){
								
							}
							data.msg && !noMsg ? showMessage1(data.msg) : null;
							// 保存/修改成功后，刷新表格数据；
			       			if(data.type == 'info'){
			       				$('#'+busGridTableId).datagrid('acceptChanges');
			       				busGridObj.refresh();
			       			}
						}
					});
				}
			}else{
				noMsg ? "" : showMessage1("表格没有数据");
			}			
		}catch(e){
			alert('saveRows:\n'+e.message);
		}
    }   
	// 暴露给外面，使最外层页面可以调用子页面的保存方法
    window.aud$saveRows = saveRows;
	
	var saveBtn = {   
	    text:'保存',
	    iconCls:'icon-save',
	    handler:function(){
	    	saveRows(false);
	    }
	};
	
	var addBtn = {   
	    text:'添加',
	    iconCls:'icon-add',
	    handler:function(){
	    	addNewRow();
	    }
	};
	
	var copyBtn = {   
	    text:'复制',
	    iconCls:'icon-copy',
	    handler:function(){
	    	addNewRow(true);
	    }
	};
	
	var mxAllBtn = {
	    text: '所有明细',
	    iconCls: 'icon-view',
	    handler: function() {
        	var winUrl = busBaseUrl+"showBeanMxList.action?all=1";
            new aud$createTopDialog({
              	title:"审易(审计)字段明细维护",
              	url  :winUrl
            }).open();
	    }
	}
	
	var parseZipBtn = {   
	    text:'导入审易zip',
	    iconCls:'icon-import',
	    handler:function(){
	    	$('#importSyZipWin').window('open');
	    }
    };
	
	var cusToolbar = [];
	var subToolbar = [];
	if(isView){
		subToolbar = ['search','-','export','-','reload',helpBtn];
	}else{
		subToolbar = ['search','-',mxAllBtn,'-',saveBtn,'-',addBtn,'-',copyBtn,'-','delete','-','export','-',parseZipBtn,'-','reload',helpBtn];
	}
	cusToolbar = [];
	$.merge(cusToolbar, subToolbar);
	
	$('#importSyZipWin').dialog({
	    title: "审易Zip导入",    
	    width:  "700px",    
	    height: "150px",    
	    closed: true,    
	    cache:  false, 
	    shadow: false, 
	    modal: true,
	    resizable:true,
	    minimizable:false,
	    maximizable:true,
	    iconCls:'icon-import',
	    onOpen:function(){
	    	clearTemplateFile();
	    },
	    buttons:[{
			text:'导入文件',
			iconCls:'icon-save',
			handler:function(){
				importZipFile();
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
				$('#importSyZipWin').dialog('close');
			}
		}]
	});
	
	// 清空文件选择框
	function clearTemplateFile(){
		$('#fileSuffix').val('');
		var syZipFile = $('#syZipFile')[0];
		syZipFile.outerHTML = syZipFile.outerHTML;
		$('#syZipFile').unbind('change').bind('change', function(){
			 aud$checkFile();
		});
	}
	
	// 上传文件检查
	function aud$checkFile(){
		var filePath = $('#syZipFile').val();
    	var arr = filePath.split('.');
    	var suffix = arr[arr.length - 1];
    	if(suffix && suffix.toLowerCase() != 'zip'){
    		top.$.messager.alert('系统提示','导入文件后缀名错误，请导入 后缀为zip的文件！','warning');		
    		return false;
    	}else{
    		$('#fileSuffix').val(suffix);
    		return true;
    	}
	}
	
	// zip文件导入响应事件
	function importZipFile(){
		var syZipFile = $('#syZipFile').val();
		if(syZipFile == ''){
			top.$.messager.alert('系统提示',"请先选择要导入的文件",'warning');			
			return;
		}
		if(!aud$checkFile()){
			return;
		}
		$("#importForm").form('submit',{
			url:'${contextPath}/syProjectParse/parseSyZip.action',
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
	
	
	function clickCell(index, field){
		var subView = parent.isView;
		subView = subView != null ? subView : isView;
		isView = subView;
		if(!isView){
			if(endEditing()){
				editAndSelect(index, field);				
			}else{
				$('#'+busGridTableId).datagrid('selectRow', editIndex);
			}
		}
	}
	

    var qyArr = [{
        'code':'1',
        'name':'启用'
    },{
        'code':'2',
        'name':'禁用'
    }];
	
	var gqueryParamsJson = {};

	var busGridTableId = "busTable";
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+busGridTableId)[0],
        // 自定义查询服务和方法
        //serviceInstance:'saProjectPlanService',
      	//serviceMethod:'queryPpCustomParam',
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SyProjectParse',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'spId',
        //order :'desc',
        sort  :'xh,createTime',
		winWidth:750,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    // 全局基础查询参数
        gqueryParams:gqueryParamsJson,
	    // 初始化时只执行一次的参数
	    onceParams:{ },
		// 默认删除按钮单击前执行, return ture:继续； false：停止；可选
		beforeRemoveRowsFn:function(rows, gridObj){
			return true;
		},
		//定制查询条件
		//whereSql:queryWhere,
		//删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject)
		afterRemoveRowsFn:function(rows, gridObject){
			
		},
		// 删除记录后，不刷新grid
	    delRefresh:false,
	    // 行编辑时，对已保存和未保存的记录分别处理；前台js删除记录，并把已经保存的有id的捡出来
		removeFilter:function(rows){
			var idArr = [];
			if(rows && rows.length){
				for(var i = 0; i < rows.length; i++){
					var row = rows[i];
					var rowIndex = $('#'+busGridTableId).datagrid('getRowIndex', row);
					$('#'+busGridTableId).datagrid('cancelEdit', rowIndex).datagrid('deleteRow', rowIndex);
					var pkId = row['spId'];
					pkId ? idArr.push(pkId) : null;
				}
			}
			return idArr;
		},
		associate:true,
		onBeforeLoad:function(data){
			initHelpBtn();
		},
        gridJson:{
		    pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		toolbar:cusToolbar,
    		nowrap:false,
    		pagination:true,
    		//idField:'tpId',
        	onClickCell:function(index, field){
        		field != 'operation' ? clickCell(index, field) : null;
    		},
            onLoadSuccess:function(data){

			},
			frozenColumns:[[
    	        {field:'operation', title:'操作', width:'70px',align:'center',halign:'center',  sortable:true, show:'false',
    	            hidden:isView,
    	            formatter:function(value,row,index){
    	                if(row['spId']){                    
    	                    window.setTimeout(function(){
    	                        $('#editItem_'+index).linkbutton({    
    	                            iconCls: 'icon-view',
    	                            text:'明细'
    	                        }).bind('click', function(){
    	                        	var busName = row['busName'];
    	                        	var winUrl = busBaseUrl+"showBeanMxList.action?busId="+row['spId']+"&busName="+encodeURIComponent(encodeURIComponent(busName));
    	                        	//alert(winUrl)
    	                            new aud$createTopDialog({
  	                                	title:busName+"["+row['xmlName']+"]["+row['audBeanName']+"]字段明细维护",
  	                                	url  :winUrl
    	                            }).open();
    	                        });
    	                    },0)
    	                    return "<span id='editItem_"+index+"' title='单击进行明细维护/查看' style='border-width:0px;color:blue;cursor:pointer;'></span>";
    	                }else{
    	                    return '';
    	                }
    	            }
    	        },
    			{field:'spId', title:"选择", width:'10px',  align:'center', halign:'center', checkbox:true, show:'false'},
    			{field:'busName', title:"业务名称",width:'200px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:true,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			}			
			]],
    		columns:[[    
    			{field:'xmlName', title:"审易xml名称",width:'250px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:true,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			},
    			{field:'audBeanName', title:"审计bean名称",width:'200px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:false,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			},
    			{field:'callbackMethod', title:"回调方法",width:'200px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:false,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			},
    			{field:'qy', title:"是否启用",width:'70px',align:'center', halign:'center', sortable:true, 
    				type:'custom', target:$('#queryCond0')[0], exportField:'qyName',
    	            formatter:function(value,row,index){
    	                var vtext = "";
    	                $.each(qyArr, function(i, jdata){
    	                    if(jdata['code'] == value){
    	                        vtext = jdata['name'];
    	                        return false;
    	                    }
    	                });
    	                // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
    	                var rtVal = vtext ? vtext : value;
    	                row['qyName'] = rtVal;
    	                return value == '2' ? "<font color='red'><strong>"+rtVal+"</strong></font>" : rtVal;
    	            },
    	            editor:{type:'combobox', options:{
    	                required:true,
    	                editable:false,
    	                panelHeight:'auto',
    	                valueField: 'code',
    	                textField: 'name',
    	                data: qyArr
    	            }}
    			},
    			{field:'xh', title:"排序",width:'40px',align:'center', halign:'center', sortable:true, show:false,
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
    	            editor:{type:'numberbox', options:{
    	                required:true,
    	                min:0,
    	                max:1000,
    	                precision:0,
    	                missingMessage:'0-1000正整数，必填',
    	                onChange:function(newValue,oldValue){
    	         
    	                },
    	                inputEvents:{
    	                    blur: function(e) {
    	                        var tg = e.data.target;
    	                        $(tg).numberbox("setValue", $(tg).numberbox("getText"));
    	                        //endEditing();
    	                    }
    	                }
    	            }}
    			},
    			{field:'remarks', title:"备注",width:'20%',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:false,
                    	missingMessage:'长度不超过200',
               			validType:'length[0,200]'
                    }}
    			}
    		]]
        }
    });
    window.aud$memberEvaSumGrid = busGridObj;
  
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<div region="center"  border="0">	
		<table id="busTable"></table>
	</div>
	
	<!-- datagrid自定义查询 -->
    <div id="queryCond0">
         <select  name='query_eq_qy'  id="queryQy" class="easyui-combobox" 
         	data-options="panelHeight:80" editable="false" >
               <option value="" selected>全部</option>
               <option value="1">启用</option>
               <option value="2">禁用</option>
         </select>
    </div>	
    
	<!-- 审易zip压缩包导入 -->
	<div id="importSyZipWin">
		<iframe id="tmpIframe" name="tmpIframe" style='display:none'></iframe>	
		<form id="importForm"  method="post"  enctype="multipart/form-data" target='tmpIframe'>
			<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
				<input type='hidden' name='fileSuffix' id='fileSuffix' value=''/>
				<tr>
					<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
					<td class="editTd" align="left">
						<s:file name="syZipFile" id='syZipFile' size="66%" cssStyle="font-size:15px" accept="application/zip"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
		
</body>
</html>