<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-显示控制点关联的所有底稿</title>
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
	var fzDefinedColumns = [];	
	fzDefinedColumns.push({field:'manuIndex',
		title:"底稿索引", 
		width:'200px',
		align:'center',
		halign:'center', 
		sortable:true, 
		oper:'like',
		formatter:function(value,row,index){
       		var manuStatusCode = row['manuStatusCode'];
			var scolor = "blue";
			if(manuStatusCode == '0'){
				scolor = "#6A5ACD";
			}else if(manuStatusCode == '1'){
				scolor = "#5F9EA0";
			}	
			var rvEnd = row['rvEnd'];
			if(rvEnd == '0'){
				scolor = "#8FBC8F";
			}else if(rvEnd == '1'){
				scolor = "green";
			}
			return ["<label title='单击查看"+"["+row['manuStatus']+"]' style='cursor:pointer;color:"+scolor+";'>",value,"</label>"].join('') ;
		}
	});
	
	var gridColums = [];
	var matrixLevelNames = '${matrixLevelNames}';
	if(matrixLevelNames){
		var mlnArr = matrixLevelNames.split(",");
		var mlnArrLen = mlnArr.length;
		for(var i = 0; i < mlnArrLen; i++){
			var ln = mlnArr[i];
			var colField = i == mlnArrLen - 1 ? "cpCode" : "nodeName_"+i, colTitle = ln;
			var colWidth = i == mlnArrLen - 1 ? "200px" : "120px";
            var col = {field:colField, title:colTitle, width:colWidth,align:'center', halign:'center', sortable:false, 
				oper:'like', show: i == 0 ? true : 'false', queryKey:i == 0 ? 'mpName' : colField,
   				formatter:function(value,row,index){
					if(this.field == 'cpCode'){
						return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
					}else{
	            		var superiorNames = row['superiorNames'];
	            		var arr = superiorNames.split(",");
	            		return arr[this.field.split("_")[1]];
					}
   				}
            }
            gridColums.push(col);
		}
	}
	
    $.merge(gridColums, [
			{field:'cpName',title:"控制点名称", queryText:'控制点', width:'120px',align:'center',halign:'center', oper:'like'},
			{field:'projectName', title:"所属项目",width:'180px',align:'left', halign:'center', sortable:false, show:false,
   				formatter:function(value,row,index){
   					return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
   				}
			},
			{field:'manuStatus', title:"底稿状态",width:'110px',align:'center', halign:'center', sortable:true, oper:'like'},
			{field:'rvEnd',   title:"是否复核完成",width:'100px',align:'center', halign:'center', sortable:false,show:false,
				type:'custom', target:$('#queryCond1')[0],
   				formatter:function(value,row,index){
   					return value == '0' ? '进行中' : value == '1' ? "<strong><font color='red'>已完成</font></strong>" : '未开始';
   				}
			},
			{field:'ctrlImportName',title:"控制重要程度",width:'120px',align:'center',halign:'center', show:false},
			{field:'ctrlModeName',  title:"控制方式",   width:'150px',align:'center',halign:'center', show:false},
			{field:'ctrlSeqName',   title:"控制频率",   width:'120px',align:'center',halign:'center', show:false},
			{field:'testConclusion',title:"测试结论",   width:'120px',align:'center',halign:'center',
				type:'custom', target:$('#queryCond4')[0]},
			{field:'tester',     title:"测试人",  width:'90px', align:'center', halign:'center', sortable:true,
				type:'custom', target:$('#queryCond1')[0]},
			{field:'reviewer', title:"复核人",  width:'90px', align:'center', halign:'center', sortable:true,
				type:'custom', target:$('#queryCond6')[0]},
			{field:'executionFrequency', title:"执行频率",  width:'90px', align:'center', halign:'center', sortable:true,
				type:'custom', target:$('#queryCond2')[0]},
			{field:'yearDeal',  title:"全年发生交易",width:'120px', align:'center', halign:'center', sortable:true, oper:'like'},
			{field:'sampleSize',title:"样本量", width:'80px',  align:'center', halign:'center', sortable:true, oper:'like'},
			{field:'actualControl',title:"实际控制方式",  width:'120px', align:'center', halign:'center', sortable:true,
				type:'custom', target:$('#queryCond3')[0]},
			{field:'groupName',title:"所属分组",  width:'150px', align:'center', halign:'center', show:false},
			{field:'evaluatedUnit',title:"被评价单位",  width:'150px', align:'center', halign:'center', sortable:true,
				type:'custom', target:$('#queryCond5')[0]}
				
	]);
	
	var gridTableId = "cpManuTable";
    var manuGrid = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'EvaManuscript',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'manuId',
        order :'asc',
        sort  :'manuIndex',
		winWidth:780,
	    winHeight:330,
	    myToolbar:['search', 'export', 'reload'],
	    associate:true,
		//定制查询条件
		whereSql: "manuIndex='${manuIndex}'",
        gridJson:{
		    pageSize:10,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
            onLoadSuccess:function(data){
				aud$mergeGridCells(gridTableId, data);
				$('#processTree').tree("expandAll");
			},
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'cpCode'){
   					var cpUrl= "${contextPath}/intctet/mainProcess/editControlPoint.action?proCp=true&view=true&projectId="+row['projectId']+"&cpId="+row['cpId'];
   					//alert('cpUrl='+cpUrl);
   					aud$openNewTab("项目${lastlevelName}查看", cpUrl, true);
   					
                }else if(field == 'manuIndex'){
                	var manuStatusCode = row['manuStatusCode'];
					var manuEditUrl = "${contextPath}/intctet/evaluationActualize/editManu.action?view=true&projectId="+row['projectId']+"&evaluatedUnitId="+row['evaluatedUnitId']+"&manuId="+row['manuId'];
   					aud$openNewTab(row['projectName']+"-底稿查看", manuEditUrl, true);
                }else if(field == "projectName"){
                	var projectId = row['projectId'];
					var manuEditUrl = "${contextPath}/intctet/evaProject/evaPlan/editEvaPlan.action?view=true&formId="+row['projectId'];
   					aud$openNewTab(row['projectName']+"-查看", manuEditUrl, true);
                } 
            },
            frozenColumns:[fzDefinedColumns],
    		columns:[gridColums]
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
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id="cpManuTable"></table>
	
	<!-- 自定义查询条件 -->	
	<div id="queryCond1">
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_testerId' class="noborder editElement clear" readonly/>
		<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
                  title:'测试人选择',
				  param:{
				  	'rootParentId':'0',
                    'beanName':'UOrganizationTree',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode'
                 },
                 type:'treeAndUser',
                 singleSelect:true
		})"></a>
	</div>
	
	<div id="queryCond2"> 
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden' name='query_eq_executionFrequencyCode' value="${manu.executionFrequencyCode}"  class="noborder editElement clear" readonly/>
		<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
				  title:'执行频率选择',
                  onlyLeafClick:true,
	          	  noMsg:true,
	              queryBox:false,
				  param:{
					'plugId':'710012',
				    'whereHql':'type=\'710012\'',
				    'customRoot':'执行频率',
				  	'rootParentId':'0',
                    'beanName':'CodeName',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeOrder':'name'
                  }
		})"></a>
	</div>
	
	<div id="queryCond3">
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_actualControlCode'  class="noborder editElement clear" readonly/>
		<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
				  title:'实际控制方式选择',
                  onlyLeafClick:true,
	          	  noMsg:true,
	              queryBox:false,
				  param:{
					'plugId':'710013',
				    'whereHql':'type=\'710013\'',
				    'customRoot':'实际控制方式',
				  	'rootParentId':'0',
                    'beanName':'CodeName',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeOrder':'name'
                  }
		})"></a>
	</div>
	
	<div id="queryCond4">
		<input type='text' class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_testConclusionCode' class="noborder editElement clear" readonly/>
		<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
				  title:'测试结论选择',
                  onlyLeafClick:true,
	          	  noMsg:true,
	              queryBox:false,
				  param:{
					'plugId':'710014',
				    'whereHql':'type=\'710014\'',
				    'customRoot':'测试结论',
				  	'rootParentId':'0',
                    'beanName':'CodeName',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeOrder':'name'
                  }
		})"></a>
	</div>
	
	<div id="queryCond5">
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_evaluatedUnitId' class="noborder editElement clear" readonly/>
		<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
                  title:'被评价单位选择',
				  param:{
				  	'rootParentId':'0',
                    'beanName':'UOrganizationTree',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode'
                 },
                 singleSelect:true
		})"></a>
	</div>
	
	
	<div id="queryCond6">
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_reviewerId' class="noborder editElement clear" readonly/>
		<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
                  title:'复核人选择',
				  param:{
				  	'rootParentId':'0',
                    'beanName':'UOrganizationTree',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode'
                 },
                 type:'treeAndUser',
                 singleSelect:true
		})"></a>
	</div>
</body>
</html>