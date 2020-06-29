<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>满意度评价模板-评价项维护</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">

$(function(){
	// 基础信息
	var busBaseUrl = "${contextPath}/satisfctEva/";
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "busTable";
	
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
	    handler:addNewRow	
	};
	var closeBtn = {
	    text:'关闭',
	    iconCls:'icon-cancel',
	    handler:aud$closeTab
	};
	
    // 新增一条记录
    function addNewRow(){
    	if(endEditing()){
        	var rowLen = $('#'+gridTableId).datagrid('getRows').length;
    		editIndex = rowLen;
        	$('#'+gridTableId).datagrid('appendRow',{
    			'templateId':"${templateId}",
    			'sortNum':editIndex + 1,
    			'required':'是',
    			'requiredCode':'1'
    	   	});
    		$('#'+gridTableId).datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    	}else{
    		showMessage1("行数据校验未通过");
    	}
		var ed = $('#'+gridTableId).datagrid('getEditor', {index:editIndex,field:'item'});
		if(ed){
			$(ed.target).select().focus();
		}
    }	
    
    var editIndex = undefined;
	
    // 结束上次编辑的行
	function endEditing(){
		if(editIndex == undefined){
			return true;
		}
		if($('#'+gridTableId).datagrid('validateRow', editIndex)){//判断行是否校验成功，成功后结束编辑
			$('#'+gridTableId).datagrid('endEdit', editIndex);
			editIndex = undefined;
			reloadFooter();
			return true;
		}else{
			return false;
		}
	}
    
    //编辑and选中行
    function editAndSelect(index, field){
    	try{
			$('#'+gridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);	       				
			var ed = $('#'+gridTableId).datagrid('getEditor', {index:index,field:field});
			if(ed){
				if(field == "required" || field == "fullMarks" || field == "sortNum"){
					$(ed.target).next('span').find("input:text").select()[0].focus();
				}else{				
					$(ed.target).select()[0].focus();
				}				
			}else{
				ed = $('#'+gridTableId).datagrid('getEditor', {index:index,field:field});
				$(ed.target).select()[0].focus();
			}	       				
			//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
			editIndex = index; 
    	}catch(e){
    		alert('editAndSelect:\n'+e.message);
    	}
    }    
    
	// 刷新表格foot
	function reloadFooter(){
		var t = 0;
		var rows = $('#'+gridTableId).datagrid('getRows');
		if(rows && rows.length){
			for(var i = 0; i < rows.length; i++){
				var s = parseInt(rows[i].fullMarks)
				if(s){
					t += parseInt(s);
				}
			}
		}
		$('#'+gridTableId).datagrid('reloadFooter',[{
			"requiredCode":"合计",
			"fullMarks" :t
		}]);
	}
    
	var barView = ['export','-','reload'];
	var barEdit = [addBtn,'-','delete','-',saveBtn,'-','export','-','reload','-',closeBtn];
	var cusToolbar = isView ? barView : barEdit;

    // 保存问题,保存修改、新增的行
    function saveRows(noMsg){
		var rows = $('#'+gridTableId).datagrid('getRows');
		if(rows && rows.length){
			var rt = true;
			for(var j = 0; j < rows.length; j++){
				var row = rows[j];
				var rowsIndex = $('#'+gridTableId).datagrid('getRowIndex', row);
				if($('#'+gridTableId).datagrid('validateRow', rowsIndex)){								
					$('#'+gridTableId).datagrid('endEdit', rowsIndex);
				}else{
					rt = false;
					var ed = $('#'+gridTableId).datagrid('getEditor', {
						index:rowsIndex,
						field:"item"
					});
					if(ed){
						$(ed.target).select().focus();
					}
					noMsg ? "" : showMessage1("第【"+parseInt(rowsIndex + 1)+"】行数据校验未通过");
					break;
				}
			}
			reloadFooter();
			if(rt){		
		    	var sendData = null;
		    	var insertRows = $('#'+gridTableId).datagrid('getChanges','inserted');
		    	var updateRows = $('#'+gridTableId).datagrid('getChanges','updated');
		    	var insertRowsJson = insertRows.length ? aud$rows2Json("insertRow", insertRows) : {};   
		    	var updateRowsJson = updateRows.length ? aud$rows2Json("updateRow", updateRows) : {};
		    	sendData = $.extend({}, insertRowsJson, updateRowsJson);
				$.ajax({
					url : busBaseUrl + "/saveEvaItem.action",
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
		       			if(data.type == 'info'){
		       				$('#'+gridTableId).datagrid('acceptChanges');
		       				busGridObj.refresh();
		       				reloadFooter();
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
    var statusArr = [{
    	'code':'0',
    	'name':'否'
    },{
    	'code':'1',
    	'name':'是'
    }];
	var gridColums = [];
    $.merge(gridColums, [
    	{field:'itemId',title:'选择',checkbox:true,align:'center',halign:'center',hidden:isView,show:'false'},
		{field:'item', title:"<font color='red'>*</font>评价项", exportTitle:'评价项',
			width:'20%',align:'left', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			editor:{type:'validatebox', options:{required:true, validType:'length[1,100]'}}
		},
		{field:'subItem', title:"子项", exportTitle:'字项',
			width:'20%',align:'left', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			editor:{type:'validatebox', options:{required:false, validType:'length[1,100]'}}
		},
		{field:'requiredCode', title:"<font color='red'>*</font>是否必评",
			exportField:"required", exportTitle:'是否必评',
			width:'90px',align:'center', halign:'center', sortable:true, 
			editor:{type:'combobox', options:{
				required:true, 
				editable:false,
				panelHeight:'auto',
				valueField: 'code',
				textField: 'name',
				data: statusArr
			}},
			formatter:function(value,row,index){
				var vtext = "";
				$.each(statusArr, function(i, jdata){
					if(jdata['code'] == value){
						vtext = jdata['name'];
						return false;
					}
				});
				// 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
				var rtVal = vtext ? vtext : value;
				row['required'] = rtVal;
				return rtVal;
			}
		},
		{field:'fullMarks', title:"<font color='red'>*</font>标准满分", exportTitle:'标准满分',
			width:'120px',align:'right', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			editor:{type:'numberbox', options:{
				required:true, 
				min:0,
				max:100,
				precision:0,
				missingMessage:'0-100正整数，必填',
				onChange:function(newValue,oldValue){
					//alert(newValue+":"+oldValue)
					reloadFooter();
				},
				inputEvents:{
		            blur: function(e) {
		            	var tg = e.data.target;
		                $(tg).numberbox("setValue", $(tg).numberbox("getText"));
		                endEditing();
		            }
				}
			}}
		},
		{field:'sortNum', title:"排序序号",width:'90px',align:'right', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			editor:{type:'numberbox', options:{
				required:false, 
				min:0,
				max:100,
				precision:0,
				missingMessage:'0-100正整数',
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
		{field:'gradeDesc', title:"评分标准说明",width:'30%',align:'right', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			editor:{type:'validatebox', options:{validType:'length[1,500]'}}
		}
	]);
	
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 自定义查询服务和方法
        serviceInstance:'satisfctEvaService',
      	serviceMethod:'queryGridCustomParam',
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SatisfctEvaItem',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'itemId',
        order :'asc',
        sort  :'sortNum',
		winWidth:800,
	    winHeight:300,
	    gqueryParams:{
	    	'addNewRowIfNull':'2',
	    	'query_eq_templateId':'${templateId}'
	    	
	    },
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],    
	    //associate:true,
	    //删除前执行（提示前）
	    beforeRemoveRowsFn:function(rows, gridObject){ 
	    	//$('#'+gridTableId).datagrid('acceptChanges');
	    	return true;
	    },
	    //删除前执行（提示后）
		removeFilter:function(rows){
			var idArr = [];
			if(rows && rows.length){
				var fileGuidArr = [];
				var len = rows.length;
				for(var i = len - 1; i >= 0; i--){
					var row = rows[i];
					var pkId = row['itemId'] 
					if(pkId){
						idArr.push(pkId);
					}
					var rowIndex = $('#'+gridTableId).datagrid('getRowIndex', row);
					$('#'+gridTableId).datagrid('deleteRow', rowIndex);
				}

			}
			return idArr;
		},
		// 删除后不刷新表格，防止行编辑选择的删除行包含新增行时，如果刷新grid会把新增行给刷掉
		delRefresh:false,
        gridJson:{
			rownumbers:true,
		    pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		showFooter:true,
    		//自定义工具栏按钮
    		toolbar:cusToolbar,
        	onClickCell:function(index, field, value){
        		if(isView || field == 'itemId'){
        			return;
        		}
       			endEditing() ? editAndSelect(index, field) : $('#'+gridTableId).datagrid('selectRow', editIndex);
    		},
    		onLoadSuccess:function(data){
    			reloadFooter();
    			/*
	    			解决新增加的记录序号为负数:
	    			1.后台在grid查询时list如果为空没有数据，则增加一条空数据到前台;
	    			2.前台判断为空数据时，删除这条数据后再增加数据，就可以解决新增行，序号为负值问题
    			*/
				if(data.total == 1){
					var rows = data.rows;
					var row = rows[0];
					if(row['itemId'] && !row['item']){
						$('#'+gridTableId).datagrid('cancelEdit', 0).datagrid('deleteRow', 0);
					}
				}
    		},
    		columns:[gridColums],
    		rowStyler: function(index, row){
    			// 新增加的行，改变行背景颜色
    			if (row['itemId'] == null){
    				return 'background-color:#FFFFE0;';
    			}
    		}
        }
    });	
	
});
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>
</body>
</html>
