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
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	//内控矩阵选择
	var isSelectCp = "${selectCp}";
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "totalProcessTable";
	
	var addBtn = {
	         text:isView ? "矩阵查看" :'矩阵维护',
	         iconCls:'icon-add',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/mainProcess/showMainProcessList.action?view=${view}";
	         }
	};
	var reloadBtn = {   
	         text:'刷新',
	         iconCls:'icon-reload',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/mainProcess/showTotalProcess.action?view=${view}";
	         }
	     };
	var cusToolbar = isView ? [reloadBtn,"-", addBtn,"-"] : [ reloadBtn,"-",addBtn, "-"];
	
	var fzDefinedColumns = [];
	
	if(!isView){
		fzDefinedColumns.push({field:'cpId',  
			title:'选择',       
			width:'10px', 
			checkbox:true,  
			align:'center', 
			halign:'center', 
			hidden:!isSelectCp,
			show:'false'}) 
	}
	
	//alert('${mtlIdList}')
	var matrixLevelNames = '${matrixLevelNames}';
	if(matrixLevelNames){
		var mlnArr = matrixLevelNames.split(",");
		var mlnArrLen = mlnArr.length;
		for(var i = 0; i < mlnArrLen; i++){
			var ln = mlnArr[i];
			var colField = i == mlnArrLen - 1 ? "cpCode" : "nodeName_"+i, colTitle = ln;
			var colWidth = i == mlnArrLen - 1 ? "180px" : "120px";
            var col = {field:colField, title:colTitle, width:colWidth,align:'center', halign:'center', sortable:false,
   				formatter:function(value,row,index){
					if(this.field == 'cpCode'){
						return ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
					}else{
	            		var superiorNames = row['superiorNames'];
	            		var arr = superiorNames.split(",");
	            		var rtval = arr[this.field.split("_")[1]];
	            		return rtval ? "<label title='"+rtval+"'>"+rtval+"</label>" : "";
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
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'cpCode'){
					var ctrlPointEditUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=${view}&cpId="+row['cpId'];
   					aud$openNewTab(mlnArr[mlnArr.length-1] + tabTitle, ctrlPointEditUrl, true);
                }else if(field == 'manuIndex'){
					var manuEditUrl = "${contextPath}/intctet/mainProcess/showCPManu.action?manuIndex="+row['manuIndex'];
					aud$openNewTab("控制点关联的底稿", manuEditUrl,  true);
                } 
            },
            onLoadSuccess:function(data){
				aud$mergeGridCells(gridTableId, data)
			},
            frozenColumns:[fzDefinedColumns],
    		columns:[[
    			{field:'cpName',         title:"控制点说明",  width:'200px', align:'center', halign:'center', show:false, hidden:true},
				{field:'ctrlImportName', title:"控制重要程度", width:'100px', align:'center', halign:'center', show:false},
				{field:'indtSectorName', title:"适用板块",    width:'30%', align:'center', halign:'center', show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
				{field:'levelName',      title:"适用层级",    width:'120px', align:'center', halign:'center', show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
				{field:'manuIndex',      title:"底稿索引",    width:'200px', align:'center', halign:'center',
	   				formatter:function(value,row,index){
	   					return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
	   				}
				}
          ]]
        }
    });
	
    // 合并datagrid的单元格
	function aud$mergeGridCells(gridId, data){
		try{
			if(gridId && data){
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
	<div region="center" title="总览" border="0">	
		<table id="totalProcessTable"></table>
	</div>
</body>
</html>