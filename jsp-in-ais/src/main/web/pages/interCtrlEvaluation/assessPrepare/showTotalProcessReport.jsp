<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-总体流程</title>
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
var activeTabId = '${activeTabId}'; // 父  Teb 的id
var formId = '${formId}';
//是否选中一条记录
function isSingle(rows){
	if(rows!=null && rows.length>0){
		if(rows.length==1){
			return true;
			}else{
			showMessage1('请选择一条记录!');
			return false;	     			
			}				
	}else{
		showMessage1('请选择一条记录!');
		return false;
	}	
}

function  saveRow(){

	
//	var  win  = aud$getTabIframByTabId(activeTabId)
//	win.$('#controlName').val()
/*  	$.ajax({
				url : "${contextPath}/intctet/prepare/assessScheme/saveProControlPoint.action?view=${view}&mpCode="+mpCode+"&cpId="+cpId+"&formId="+formId,
				dataType:'json',
				type: "post",
				success: function(data){
					data.msg ? showMessage1(data.msg) : null;
	       			if(data.type = 'info'){
	       				top.$.messager.show({title:'提示信息',msg:'保存成功！'});
	       			}
				},
				error:function(data){
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			}); 
 */
		//	parent.mao();
	}
	
$(function(){
	var isView = "${view}";
	//内控矩阵选择
	var isSelectCp = true;
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "totalProcessTable";
	
	var addBtn = {
	         text:'保存',
	         iconCls:'icon-save',
	         handler:function(){
	        	 var rows = $('#totalProcessTable').datagrid('getChecked');//返回是个数组
	        	 if(isSingle(rows)){
	        	 	var row = rows[0];    
	        	 	    var activeTabId = aud$getActiveTabId();
	        	 		var  win  = aud$getTabIframByTabId(activeTabId)
	                     win.$('#controlName').val(row.cpName);
	        	 		  win.$('#controlCode').val(row.cpCode)
	                     
	                     win.$('#circuitName').val(row.mpName); //主流程
	        	 		 win.$('#circuitCode').val(row.mpCode);
	        			 win.$('#sonCircuitName').val(row.superiorNames); // 子流程
	        	 		 win.$('#sonCircuitCode').val(row.superiorCodes);
	        	 		
	        			 win.$('#manuscriptIndex').val(row.manuIndex); // 底稿索引
	        			 var tId = "#superior_";
	    	        	       if ( row.superiorNames != null ){
	    	        	        	var superiorNames = row.superiorNames;
	    	        	        	 var suNames =  superiorNames.split(","); // 
	    	        	         	var suLen = suNames.length;
	    	        	        	$.each(suNames,function(i,suName){
	    	        	        		 win.$(tId+i).text(suName);
	    	        	        	});  
	    	        	        } 
	                     
	        	 		top.$.messager.show({title:'提示信息',msg:'添加成功！'});
	                 //    aud$closeTab(activeTabId, activeTabId);
	        	 	//	 win.$('#sonCircuitName').val(row.riskName); // 子流程
	        	 	//	 win.$('#riskCode').val(row.superiorCodes);
	        	 		         
	        	 }
	         }
	};
	
	var reloadBtn = {   
	         text:'刷新',
	         iconCls:'icon-reload',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/prepare/assessScheme/showTotalProcessReport.action?view=${view}";
	         }
	     };
	var cusToolbar = isView ? [reloadBtn,"-", addBtn,"-"] : [ reloadBtn,"-",addBtn, "-"];
	
	var fzDefinedColumns = [];
	
	//if(！isView){
		fzDefinedColumns.push({field:'cpId',  
			title:'选择',       
			width:'10px', 
			checkbox:true,  
			align:'center', 
			halign:'center', 
			hidden:!isSelectCp,
			show:'false'}) 
//	}
	
	var matrixLevelNames = '${matrixLevelNames}';
	if(matrixLevelNames){
		var mlnArr = matrixLevelNames.split(",");
		var mlnArrLen = mlnArr.length;
		for(var i = 0; i < mlnArrLen; i++){
			var ln = mlnArr[i];
			var colField = i == mlnArrLen - 1 ? "cpCode" : "nodeName_"+i, colTitle = ln;
			var colWidth = i == mlnArrLen - 1 ? "180px" : "100px";
            var col = {field:colField, title:colTitle, width:colWidth,align:'center', halign:'center', sortable:false,
   				formatter:function(value,row,index){
					if(this.field == 'cpCode'){
						return ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
					}else{
	            		var superiorNames = row['superiorNames'];
	            		var arr = superiorNames.split(",");
	            		return arr[this.field.split("_")[1]];
					}
   				}
            }
            fzDefinedColumns.push(col);
		}
	}
	
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ControlPoint',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'cpId',
        order :'asc',
        sort  :'cpCode',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    associate:true,
        gridJson:{
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		toolbar:cusToolbar,
    		//添加查询条件
    		queryParams:{'query_eq_mpCode':"${mpCode}"},
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'cpCode'){
					var ctrlPointEditUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=${view}&cpId="+row['cpId'];
   					aud$openNewTab("控制点" + tabTitle, ctrlPointEditUrl,true);
                }else if(field == 'manuIndex'){
					//var manuEditUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=${view}&cpId="+row['nodeId'];
   					//aud$openNewTab("底稿" + tabTitle, manuEditUrl);
                } 
            },
            onLoadSuccess:function(data){
				aud$mergeGridCells(gridTableId, data)
			},
            frozenColumns:[fzDefinedColumns],
    		columns:[[
    			{field:'cpName', title:"控制点说明", width:'200px', align:'center', halign:'center', show:false},
				{field:'ctrlImportName', title:"控制重要程度", width:'120px', align:'center', halign:'center', show:false},
				{field:'indtSectorName', title:"适用板块", width:'120px', align:'center', halign:'center', show:false},
				{field:'levelName', title:"适用层级", width:'120px', align:'center', halign:'center', show:false}/* ,
				{field:'manuIndex',      title:"底稿索引", width:'200px', align:'center', halign:'center',
	   				formatter:function(value,row,index){
	   					return ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
	   				}
				} */
          ]]
        }
    });
	
    // 合并datagrid的单元格
	function aud$mergeGridCells(gridId, data){
		try{
			if(gridId, data){
            	var rows = data.rows;          
				if(rows && rows.length){
					var fieldsName = [];
					var fieldsCode = [];
	            	$.each(rows, function(i, row){
	            		var superiorNames = row['superiorNames'];
	            		var arr = superiorNames.split(",");
	            		$.each(arr, function(j, d1){
	            			var mCol = "nodeName_"+j;
	            			row[mCol] = d1;
	            			fieldsName.push(mCol);
	            		});
	            		
	            		var superiorCodes = row['superiorCodes'];
	            		var arr2 = superiorCodes.split(",");
	            		$.each(arr2, function(j, d2){
	            			var mCol2 = "nodeCode_"+j;
	            			row[mCol2] = d2;
	            			fieldsCode.push(mCol2);
	            		});
	            	});
					//fieldsName = ["nodeName_0"];
					//fieldsCode = ["nodeCode_0"];
					var len = rows.length;
					$.each(fieldsCode, function(i, field){
						var preVal = "";
						var samecount = 1;
						var beginIndex = 0;
						var isStart = true;
						$.each(rows, function(j, row){
							var val = row[field];
							//alert('val='+val+"\npreVal="+preVal)
							if(isStart){
								preVal = val;
								isStart = false;
								return true;
							}else if(val == preVal){
								samecount++;
								preVal = val;
								//alert('2.samecount='+samecount+"\nbeginIndex="+beginIndex+"\nj="+j+"\nval="+val+"\npreVal="+preVal);
							}
							
							if((val != preVal || j == len - 1) && samecount){ 
								//alert('3.samecount='+samecount+"\nbeginIndex="+beginIndex)
								$('#'+gridId).datagrid('mergeCells',{
									index  : beginIndex,
									field  : fieldsName[i],
									rowspan: samecount,
									colspan: 1
								});
								beginIndex = j;
								samecount = 1;
								preVal= val;
							}
							
						})
					});
				}
			}
		}catch(e){
			alert('aud$mergeGridCells:\n'+e.message);
		}
	}
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<input type='hidden' id="mpCode" name="mpCode"  class="noborder editElement clear" value="${mpCode}"/>
	<input type='hidden' id="projectId" name="projectId"  class="noborder editElement clear" value="${formId}"/>
	<div region="center"  border="0">	
		<table id="totalProcessTable"></table>
	</div>
</body>
</html>