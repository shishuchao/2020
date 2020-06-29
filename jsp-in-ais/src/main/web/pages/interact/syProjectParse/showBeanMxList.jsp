<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>审易项目信息解析-bean字段明细维护</title>
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
				ed = $('#'+busGridTableId).datagrid('getEditor', {index:index,field:'syFieldName'});
				$(ed.target).select()[0].focus();
			}	     
    	}catch(e){
    		//alert('editAndSelect:\n'+e.message);
    	}
    }
    
	// 新增一条记录
    function addNewRow(isCopy) {
        var isEndEdit = false;
        if (endEditing()) {
            isEndEdit = true;
            appendNewRow(isCopy);
        } else {
        	
        }
        var ed = $('#' + busGridTableId).datagrid('getEditor', {
            index: editIndex,
            field: 'syFieldName'
        });
        if (ed) {
            $(ed.target).select().focus();
        }
    }
    // 添加一个新行
    function appendNewRow(isCopy) {
    	var rowData = {
       		busName:'${busName}',
       		xh:editIndex ? editIndex + 1 : $('#' + busGridTableId).datagrid('getRows').length + 1,
       		qy:'1',
       		required:'2',
       		specialHandle:'2',
       		fieldPk:'2'
       	};
    	
    	if(isCopy){
    		var chkRows = $('#' + busGridTableId).datagrid('getChecked');
    		var crow = chkRows && chkRows.length ? chkRows[0] : null;
    		if(crow){
    			rowData.busName = crow.busName;
    			rowData.fieldZhName = crow.fieldZhName;
    			rowData.syFieldName = crow.syFieldName;
    			rowData.audFieldName = crow.audFieldName;
    			rowData.callbackMethod = crow.callbackMethod;
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
			    	sendData = $.extend({
						"beanName":"SyProjectParseMx",
						"busId":"${busId}"

			    	}, insertRowsJson, updateRowsJson);	
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
	
	var closeBtn = {
	    text: '关闭',
	    iconCls: 'icon-cancel',
	    handler: function() {
	        aud$closeTab();
	    }
	}
	
	var cusToolbar = [];
	var subToolbar = [];
	if(isView){
		subToolbar = ['search','-','export','-','reload','-',closeBtn];
	}else{
		subToolbar = ['search','-',saveBtn,'-',addBtn,'-',copyBtn,'-','delete','-','export','-','reload','-',closeBtn];
	}
	cusToolbar = [];
	$.merge(cusToolbar, subToolbar);	
	
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
	
	var gqueryParamsJson = "${all}" ? {} : {
		query_eq_spId:'${busId}'
	};
	
    var qyArr = [{
        'code':'1',
        'name':'启用'
    },{
        'code':'2',
        'name':'禁用'
    }];
    
    var requiredArr = [{
        'code':'2',
        'name':'否'
    },{
        'code':'1',
        'name':'是'
    }];

	var busGridTableId = "busTable";
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+busGridTableId)[0],
        // 自定义查询服务和方法
        //serviceInstance:'saProjectPlanService',
      	//serviceMethod:'queryPpCustomParam',
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SyProjectParseMx',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'mxId',
        //order :'desc',
        sort  :'spId,xh',
		winWidth:850,
	    winHeight:300,
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
					var pkId = row['mxId'];
					pkId ? idArr.push(pkId) : null;
				}
			}
			return idArr;
		},
		associate:true,
        gridJson:{
		    pageSize:30,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		nowrap:false,
    		toolbar:cusToolbar,
    		pagination:true,
    		//idField:'tpId',
        	onClickCell:function(index, field){
        		clickCell(index, field);
    		},
            onLoadSuccess:function(data){

			},
			frozenColumns:[[				
    			{field:'mxId', title:"选择", width:'10px',  align:'center', halign:'center', checkbox:true, show:'false'},
    			{field:'busName', title:"业务名称",width:'150px',align:'left', halign:'center', sortable:true, show:false,
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
    				}
    			},
    			{field:'fieldZhName', title:"字段中文名称",width:'200px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:false,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			}  			
			]],
    		columns:[[
    			{field:'syFieldName', title:"审易bean字段名称",width:'200px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:true,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			},
    			{field:'audFieldName', title:"审计bean字段名称",width:'200px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:false,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			},
    			{field:'callbackMethod', title:"回调方法",width:'200px',align:'left', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
    				},
                    editor:{type:'validatebox', options:{
                		required:false,
                    	missingMessage:'长度不超过100',
               			validType:'length[0,100]'
                    }}
    			},
    			{field:'qy', title:"是否启用",width:'65px',align:'center', halign:'center', sortable:true, 
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
    	                row['qyName'] = rtVal
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
    			{field:'fieldPk', title:"是否主键",width:'65px',align:'center', halign:'center', sortable:true, 
    				type:'custom', target:$('#queryCond3')[0], exportField:'fieldPkName',
    	            formatter:function(value,row,index){
    	                var vtext = "";
    	                $.each(requiredArr, function(i, jdata){
    	                    if(jdata['code'] == value){
    	                        vtext = jdata['name'];
    	                        return false;
    	                    }
    	                });
    	                // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
    	                var rtVal = vtext ? vtext : value;
    	                row['fieldPkName'] = rtVal;
    	                return value == '1' ? "<font color='green'><strong>"+rtVal+"</strong></font>" : rtVal;
    	            },
    	            editor:{type:'combobox', options:{
    	                required:false,
    	                editable:false,
    	                panelHeight:'auto',
    	                valueField: 'code',
    	                textField: 'name',
    	                data: requiredArr
    	            }}
    			},
    			/*
    			{field:'required', title:"是否必填",width:'65px',align:'center', halign:'center', sortable:true, 
    				type:'custom', target:$('#queryCond1')[0], exportField:'requiredName',
    	            formatter:function(value,row,index){
    	                var vtext = "";
    	                $.each(requiredArr, function(i, jdata){
    	                    if(jdata['code'] == value){
    	                        vtext = jdata['name'];
    	                        return false;
    	                    }
    	                });
    	                // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
    	                var rtVal = vtext ? vtext : value;
    	                row['requiredName'] = rtVal;
    	                return value == '1' ? "<font color='#A020F0'><strong>"+rtVal+"</strong></font>" : rtVal;
    	            },
    	            editor:{type:'combobox', options:{
    	                required:false,
    	                editable:false,
    	                panelHeight:'auto',
    	                valueField: 'code',
    	                textField: 'name',
    	                data: requiredArr
    	            }}
    			},
    			{field:'specialHandle', title:"是否特殊处理",width:'100px',align:'center', halign:'center', sortable:true, 
    				type:'custom', target:$('#queryCond2')[0], exportField:'specialHandleName',
    	            formatter:function(value,row,index){
    	                var vtext = "";
    	                $.each(requiredArr, function(i, jdata){
    	                    if(jdata['code'] == value){
    	                        vtext = jdata['name'];
    	                        return false;
    	                    }
    	                });
    	                // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
    	                var rtVal = vtext ? vtext : value;
    	                row['specialHandleName'] = rtVal;
    	                return value == '1' ? "<font color='blue'><strong>"+rtVal+"</strong></font>" : rtVal;
    	            },
    	            editor:{type:'combobox', options:{
    	                required:false,
    	                editable:false,
    	                panelHeight:'auto',
    	                valueField: 'code',
    	                textField: 'name',
    	                data: requiredArr
    	            }}
    			},
    			*/
    			{field:'xh', title:"排序",width:'40px',align:'center', halign:'center', sortable:true, oper:'like',
    				formatter:function(value,row,index){
    					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
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
    			{field:'remarks', title:"备注",width:'35%',align:'left', halign:'center', sortable:true, oper:'like',
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
    <!--	
    <div id="queryCond1">
         <select  name='query_eq_required'  id="queryRequired" class="easyui-combobox" 
         	data-options="panelHeight:80" editable="false" >
               <option value="" selected>全部</option>
               <option value="2">否</option>
               <option value="1">是</option>
         </select>
    </div>	
      
    <div id="queryCond2">
         <select  name='query_eq_specialHandle'  id="querySpecialHandle" class="easyui-combobox" 
         	data-options="panelHeight:80" editable="false" >
               <option value="" selected>全部</option>
               <option value="2">否</option>
               <option value="1">是</option>
         </select>
    </div>	
    -->  
    <div id="queryCond3">
         <select  name='query_eq_fieldPk'  id="queryFieldPk" class="easyui-combobox" 
         	data-options="panelHeight:80" editable="false" >
               <option value="" selected>全部</option>
               <option value="2">否</option>
               <option value="1">是</option>
         </select>
    </div>	 
    
</body>
</html>