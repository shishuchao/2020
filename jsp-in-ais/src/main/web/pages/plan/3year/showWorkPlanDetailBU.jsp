<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<script type="text/javascript">

//样本量初始化
var scGridTableId = "detailTable";
$(function(){

    $.fn.datebox.defaults.formatter=function(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        return y+'-'+(m > 9?m:('0'+m));
    }

	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';
	var yearPlanId = '${crudObject.formId}';
	var editIndex = undefined;
	//自定义datagrid行editor
    $.extend($.fn.datagrid.defaults.editors, {
        qtree: {
            init: function(container, options){
                var wrap = $('<div></div>').appendTo(container);
                var input = $('<input type="text" style="width:80%" readonly>').appendTo(wrap[0]).bind('click', function(){
                    trigger.trigger('click');
                });
                input.validatebox(options);

                $('<input type="hidden" readonly>').appendTo(wrap[0]);
                var trigger = $("<label></label>")
                    .appendTo(wrap[0]).bind('click', function(){
                        aud$editorQtree(this,options.sourceType);
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

    function aud$editorQtree(target,sourceType){
        var row = {};
        if(editIndex != undefined){
            var rows = $('#'+scGridTableId).datagrid('getRows');
            if(rows && rows.length > 0){
                row = rows[editIndex];
            }
        }
        if(sourceType == 'auditDept'){
            showSysTree(target,
                { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                    title:'请选择审计单位',
                    param:{
                        'p_item':1,
                        'orgtype':1
                    },
                    defaultDeptId:'${user.fdepid}',
                    onAfterSure:function(dms, mcs){
                        if(row){
                            row['auditDept'] = dms[0];
                            row['auditObject'] = '';
                            row['auditObjectName'] = '';
                          /*   $('#'+scGridTableId).datagrid('updateRow',{
                            	index: editIndex,
                            	row: {
                            		auditObjectName: '',
                            		auditObject: ''
                            	}
                            }); */
                        }
                    }
                });
        }else if(sourceType == 'auditObject'){
            if(row['auditDept'] == ''||row['auditDept'] == null){
                showMessage1('请先选择审计单位！');
            }else{
            	showSysTree(target,
					{ url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
						param:{
							'departmentId':row['auditDept']
						},
						cache:false,
						checkbox:true,
						title:'请选择被审计单位',
						onAfterSure:function(dms, mcs){
							if(row){
								row['auditObject'] = dms.join(',');
							}
						}
					});
			}
        }else if(sourceType == 'proType'){
            showSysTree(target,{
                title:'项目类型',
                noMsg:true,
                queryBox:false,
                onlyLeafClick:true,
                param:{
                    'plugId':'1003',
                    'whereHql':'type=\'1003\'',
                    'customRoot':'项目类型',
                    'rootParentId':'0',
                    'beanName':'CodeName',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeAtrributes':'code,status',
                    'treeOrder':'name',
					'serverCache':false
                },
                onAfterSure:function(dms, mcs){
                    var treeObj = $(this);
                    var node = treeObj.tree('find',dms[0]);
                    if(node){
                        var parentNode = treeObj.tree('getParent',node.target);
                        if(parentNode&&parentNode.text != '项目类型'){
                            var attributes = parentNode.attributes;
                            if(attributes){
                                var json = $.parseJSON(attributes);
                                row['proType'] = json.code;
							}
                            row['proTypeName'] = parentNode.text;
                            attributes = node.attributes;
                            if(attributes){
                                var json = $.parseJSON(attributes);
                                row['proChildType'] = json.code;
                            }
                            row['proChildTypeName'] = mcs[0];
						}else{
                            var attributes = node.attributes;
                            if(attributes){
                                var json = $.parseJSON(attributes);
                                row['proType'] = json.code;
                            }
                            row['proTypeName'] = mcs[0];
                        }
					}
                }
            });
        }

    }

    // 结束编辑
    function endEditing(){
        if(editIndex == undefined){return true}
        if($('#'+scGridTableId).datagrid('validateRow', editIndex)){
            $('#'+scGridTableId).datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        }else{
            return false;
        }
    }

    //曾删行保存时校验数据是否完整
    function aud$validRows(gridId){
        var rt = true;
        if(gridId){
            var rows = $('#'+gridId).datagrid('getRows');
            var rowLen = rows.length;
            for(var i = 0; i < rowLen; i++){
                var ed = $('#'+gridId).datagrid('selectRow', i).datagrid('beginEdit', i);
                if(ed){
                    $(ed.target).select().focus();
                }
                if(!$('#'+gridId).datagrid('validateRow', i)){
                    editIndex = i;
                    rt = false;
                    break;
                }
                $('#'+gridId).datagrid('endEdit', i);
            }
        }
        return rt;
    }

    //编辑and选中
    function editAndSelect(index, field){
        try{

            $('#'+scGridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);

            var ed = $('#'+scGridTableId).datagrid('getEditor', {index:index,field:field});
            if(ed){
                $(ed.target).select().focus();
            }
            //记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
            editIndex = index;
        }catch(e){
            alert('editAndSelect:\n'+e.message);
        }
    }

    function addRows(count, yearPlanId){
        if(yearPlanId == ''){
            showMessage1('请先保存三年计划再增加审计项目！');
        }else {
            var row = {
                'yearPlanId':yearPlanId,
				'planStatus':'8888',
				'planStatusName':'草稿',
				'planGrade':'1000'
            };
            $('#'+scGridTableId).datagrid('appendRow',row);
        }
    }
    //保存修改数据
    function updateRow(rows){
        var sendData = aud$rows2Json("updateRow", rows);
        $.ajax({
            url : "${contextPath}/plan/3year/savePlanDetail.action",
            dataType:'json',
            type: "post",
            data: sendData,
			cache:false,
            beforeSend:function(){
                var check = sendData != null ? true : false;
                if(!check){
                    showMessage1("没有数据发生变化，不需保存");
                }
                return check;
            },
            success: function(data){
                data.msg ? showMessage1(data.msg) : null;
                if(data.type = 'info'){
                    scGridObj.refresh();
                }
            },
            error:function(data){
                top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
            }
        });
    }

	function saveDetailPlan(noMsg){
		if(!aud$validRowsTj(scGridTableId)){
			return false;
		}
        if(aud$validRows(scGridTableId) && endEditing()){
        	var rows = $('#'+scGridTableId).datagrid('getChanges','inserted');
        	var updatedRows = $('#'+scGridTableId).datagrid('getChanges','updated');
        	if((rows && rows.length)||(updatedRows && updatedRows.length)){
        	    if(updatedRows && updatedRows.length){
        	        if(rows && rows.length){
                        rows.concat(updatedRows);
                    }else{
                        rows = updatedRows;
                    }
                }
        		updateRow(rows);
        		$('#'+scGridTableId).datagrid('acceptChanges');
        	}else{
        		noMsg ? "" : showMessage1("数据没有改变！不需保存！");
        	}
        	return true;
        }else{
			$('#'+scGridTableId).datagrid('selectRow', editIndex);
			showMessage1('表格数据校验未通过', function(){
				var gridY = QUtil.getElementPos($('#'+scGridTableId).parent().get(0)).y;
				if(gridY){
					$('#layoutCenter').scrollTop(gridY - 150);
				}
			});
			return false;
		}
	} 

	function delPlanDetail() {
        var rows = $('#' + scGridTableId).datagrid('getChecked');
        if(rows && rows.length){
            top.$.messager.confirm('确认','确定要删除所选的审计项目吗？',function (r) {
				if(r){
				    var detailIds = [];
				    for(var i = 0;i < rows.length;i++){
				        var row = rows[i];
				        if(row['planId'] != null&&row['planId'] != ''){
				            detailIds.push(row['planId']);
						}else{
				            var rowIndex = $('#' + scGridTableId).datagrid('getRowIndex',row);
                            $('#' + scGridTableId).datagrid('deleteRow',rowIndex);
						}
					}
					if(detailIds.length > 0){
                        $.ajax({
                            url:'${contextPath}/plan/3year/deletePlanDetail.action',
                            type:'post',
                            cache:false,
                            dataType:'json',
							data:{
                              'detailIds':detailIds.join(',')
                            },
                            success:function(data){
                                showMessage1(data.msg);
                                scGridObj.refresh();
                            }
                        });
					}
				}
            });
        }else{
            showMessage1('请选择要删除的审计项目！');
        }
    }

	var saveBtn = {
	        text:'保存',
	        iconCls:'icon-save',
	        handler:function(){
	        	saveDetailPlan(false);
	        }
	    };
	
	var addBtn = {
	        text:'新增',
	        iconCls:'icon-add',
	        handler:function(){
	        	addRows(1,yearPlanId);
	        }	
	}

    var delBtn = {
        text:'删除',
        iconCls:'icon-delete',
        handler:function(){
            delPlanDetail();
        }
    }

    var impBtn = {
        text:'导入',
        iconCls:'icon-import',
		id:'impBtn'
    }

	var cusToolbar = isView ? [] : [addBtn,'-',saveBtn,'-',delBtn,'-',impBtn];
	var coverRate = encodeURI('${coverRate}');
	var tableTile = '${crudObject.formId}' == '' ? '三、未来三年审计项目汇总':'三、未来三年审计项目汇总  &nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="aud$openNewTab(\'审计计划单位覆盖情况\',\'${contextPath}/plan/3year/queryCoverUncoverAuditObject.action?yearPlanId=${crudObject.formId}&covered=${covered}&uncovered=${uncovered}&coverRate='+coverRate+'\',true)">审计计划单位数量覆盖率${coverRate}，未覆盖单位：${uncovered}个</a>';
	window.scGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+scGridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'WorkPlan3YearDetail',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'planId',
        order :'asc',
        sort  :'planGrade,auditPerformStart',
		winWidth:500,
	    winHeight:250,
	    associate:true,
		myToolbar:[],
		//定制查询
		whereSql: " yearPlanId='"+yearPlanId+"' and auditDept='${user.fdepid}'",
        gridJson:{
			title:tableTile,
		    pageSize:10,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		fit:true,
    		toolbar:cusToolbar,
        	onClickCell:function(index, field){
        		if(!isView && (field != 'planId')){
        			if(endEditing()){
        				editAndSelect(index, field);     				
        			}else{
        				$('#'+scGridTableId).datagrid('selectRow', editIndex);
        			}
        		}
    		},
    		columns:[[
				{field:'planId',    title:"选择",     width:'5px', align:'center', halign:'center', checkbox:true, show:'false', hidden:isView},
    			{field:'planStatusName',    title:"计划状态",  width:'100px', align:'center', halign:'center',sortable:true},
				{field:'proTypeNameDisplay',   title:"项目类型",  width:'150px', align:'left', halign:'center',sortable:true,
    				editor:{type:'qtree',options:{required:true,sourceType:'proType'}},
					formatter:function (value,row,index) {
				    	row['proCode'] = row['proCode'];
						if(row['proChildTypeName'] != null && row['proChildTypeName'] != ''){
						    return row['proChildTypeName'];
                        }
                        return row['proTypeName'];
                    }
				},
				{field:'proName', title:"项目名称",  width:'150px', align:'center', halign:'center',
                    editor:{type:'validatebox', options:{required:true, validType:'length[1,100]'}} },
				{field:'auditDeptName',title:"审计单位",width:'200px', align:'left', halign:'center',
					editor:{type:'qtree',options:{required:true,sourceType:'auditDept'}}},
                {field:'auditObjectName',title:"被审计单位",width:'200px', align:'left', halign:'center',
                    editor:{type:'qtree',options:{required:true,sourceType:'auditObject'}}},
                {field:'auditScopeStart',title:"审计期间开始",width:'200px', align:'left', halign:'center',
                    editor:{type:'datebox',options:{
                        	required:true,
                            editable:false
						}
                	}
				},
                {field:'auditScopeEnd',title:"审计期间结束",width:'200px', align:'left', halign:'center',
                    editor:{type:'datebox',options:{
                            required:true,
                            editable:false
                        }
                    }
                },
                {field:'planGrade',title:"计划等级",width:'200px', align:'left', halign:'center',
                    editor:{type:'combobox',options:{
                        	data:${planGradeList},
							valueField:'planGrade',
							textField:'planGradeName',
							panelHeight:'auto',
							required:true,
							editable:false
						}
                	},
					formatter:function(value,row,index){
                    	if(value == '1000'){
                    	    return '重要项目';
                        }else if(value == '1001'){
                    	    return '一般项目';
                        }
                    }
				},
                {field:'auditPerformStart',title:"项目开始时间",width:'200px', align:'left', halign:'center',
                    editor:{type:'datebox',options:{
                            required:true,
							editable:false
                        }
                    }
                },
                {field:'auditPerformEnd',title:"项目结束时间",width:'200px', align:'left', halign:'center',
                    editor:{type:'datebox',options:{
                            required:true,
                            editable:false
                        }
                    }
                 },
 				{field:'auditResource', title:"审计资源配备",  width:'200px', align:'center', halign:'center',
                     editor:{type:'textbox', options:{validType:'length[0,100]'}} }

          ]]
        }
    });
    
    setTimeout(function(){    	
	  $('#parseExcelContainer').parseExcel({
			topWin:true,
	        triggerId:'impBtn',
	        title:'三年计划审计项目导入',
	        beanName:'WorkPlan3YearDetail',
	        boPk:'planId',
	        //上传成功后，要刷新的datagrid id
	        datagridId:'detailTable',
	        //下载模板的名字
	        templateFileName:'snjhsjxmdrmb.xlsx', // modified by sunny 三年计划审计项目导入模板
	        data:{
	            relation:true,
	            'parentTabId':$('body').attr('topDialogTargetId'),
	            'yearPlanId':'${crudObject.formId}'
	        },
	        onBeforeOpen:function(target, options){
	        	//alert('yearPlanId='+yearPlanId)
	      		if(!yearPlanId){
	            	showMessage1('请先保存三年计划再增加审计项目！');
	            	return false;
	            }
	      		return true;
	        }

	    });    
    },200);
    
  //三年计划中时间没有校验，1、项目开始时间可以超出计划年代；2、项目结束时间可以早于项目开始时间。
    function aud$validRowsTj(gridId){
        var result = true;
        var planYearStart = $("#crudObject_planYearStart").val();
    	var planYearEnd = $("#planYearEnd").val();
        if(gridId){
        	endEditing();
            var rows = $('#'+gridId).datagrid('getRows');
            var rowLen = rows.length;
            for(var i = 0; i < rowLen; i++){
            	var row = rows[i];
            	var auditPerformStart = row.auditPerformStart;//项目开始时间
            	var auditPerformEnd = row.auditPerformEnd;//项目结束时间
            	var start= new Array(); 
            	start=auditPerformStart.split("-");
            	var end= new Array(); 
            	end=auditPerformEnd.split("-");
            	
            	if(start[0] !=null && start[0]!=''){
            		if(start[0] > planYearEnd){ 
            			showMessage1("项目开始时间必须属于三年计划["+planYearStart+"-"+planYearEnd+"]期间！"); 
            			result = false;
            		}
            		
            		if(start[0] < planYearStart){
            			showMessage1("项目开始时间必须属于三年计划["+planYearStart+"-"+planYearEnd+"]期间！");
            			result = false;
            		}
            		
            		if(end[0] < start[0]){
            			showMessage1("项目结束时间不可以早于项目开始时间！");
            			result = false;
            		}
            		
            	}
            }
        }
        return result;
    }
});


</script>

<div style="height:300px;padding:0px;margin:0px;">
	<div id="parseExcelContainer"></div>
	<table id="detailTable"></table>
</div>
