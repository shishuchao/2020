<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>可能性评估</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<style>
    .td-select{background:#FBEC88}/*td高亮样式*/
</style>

<script type="text/javascript">
var flag = true;
var fuckclick = false;
var fuckclick1 = false;
var fuckclick2 = false;
var fuckclick3 = false;
var fuckclick4 = false;
var rowIndexClick = -1;
var rowId = null;
var rowProbability = null;
var rowScore = 0;
var riskWaitId = "${riskWaitId}";

function selectScores(score,value,rowIndex,inadequacy,id){
	
	fuckclick = true;
	fuckclick1 = false;
	fuckclick2 = false;
	fuckclick3 = false;
	fuckclick4 = false;
	rowIndexClick = rowIndex;
	rowProbability = inadequacy;
	rowId = id;
	rowScore = score;
	$('#sDTable').datagrid('reload');
}

function selectScores1(score,value,rowIndex,inadequacy,id){
	
	fuckclick = false;
	fuckclick1 = true;
	fuckclick2 = false;
	fuckclick3 = false;
	fuckclick4 = false;
	rowIndexClick = rowIndex;
	rowProbability = inadequacy;
	rowId = id;
	rowScore = score;
	$('#sDTable').datagrid('reload');
}

function selectScores2(score,value,rowIndex,inadequacy,id){
	
	fuckclick = false;
	fuckclick1 = false;
	fuckclick2 = true;
	fuckclick3 = false;
	fuckclick4 = false;
	rowIndexClick = rowIndex;
	rowProbability = inadequacy;
	rowId = id;
	rowScore = score;
	$('#sDTable').datagrid('reload');
}

function selectScores3(score,value,rowIndex,inadequacy,id){
	
	fuckclick = false;
	fuckclick1 = false;
	fuckclick2 = false;
	fuckclick3 = true;
	fuckclick4 = false;
	rowIndexClick = rowIndex;
	rowProbability = inadequacy;
	rowId = id;
	rowScore = score;
	$('#sDTable').datagrid('reload');
}

function selectScores4(score,value,rowIndex,inadequacy,id){
	
	fuckclick = false;
	fuckclick1 = false;
	fuckclick2 = false;
	fuckclick3 = false;
	fuckclick4 = true;
	rowIndexClick = rowIndex;
	rowProbability = inadequacy;
	rowId = id;
	rowScore = score;
	$('#sDTable').datagrid('reload');
}

//var single = true;//配置是否只能同时选择一行

$(function(){
	var rrs_id = '${rrs_id}';
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
    var probabilitySDId = '${probabilitySDId}';
    var possibleScore = '${possibleScore}';
    
    var probabilityScaleList = eval('${probabilityScaleList}');
    var columnFix = [];
    for(i in probabilityScaleList) {
    	var column;
    	if(i == 0) {
    		column = {field:'probability0',title:probabilityScaleList[i].name, width:bodyW*0.14 + 'px',align:'center', sortable:true, show:'true', oper:'like',
				formatter:function(value,rowData,rowIndex){
					var score = 0;
					return '<div title=\''+value+'\' onclick=\"selectScores(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.probability0+'\',\''+rowData.id+'\');\">'+value+'</div>';
				},
			    styler:function(value,rowData,rowIndex){
			        if (fuckclick == true && rowIndex == rowIndexClick){
						//当单元格被点击的时候，颜色变成红色
			        	return 'background-color:#ffee00;color:red;';
			        }
			    }
           }
    	}else if(i == 1) {
    		column = {field:'probability1',width:bodyW*0.14 + 'px',title:probabilityScaleList[i].name, align:'center', sortable:true, type:'custom', target:$('#query_tradePlate')[0],
				formatter:function(value,rowData,rowIndex){
					var score = 1;
					return '<div title=\''+value+'\' onclick=\"selectScores1(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.probability1+'\',\''+rowData.id+'\');\">'+value+'</div>';
				},
			    styler:function(value,rowData,rowIndex){
			        if (fuckclick1 == true && rowIndex == rowIndexClick){
						//当单元格被点击的时候，颜色变成红色
			        	return 'background-color:#ffee00;color:red;';
			        }
			    }
           }
    	}else if(i == 2) {
    		column = {field:'probability2',width:bodyW*0.14 + 'px',title:probabilityScaleList[i].name, align:'center', sortable:true, show:'true', oper:'eq',
					formatter:function(value,rowData,rowIndex){
						var score = 2;
						return '<div title=\''+value+'\' onclick=\"selectScores2(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.probability2+'\',\''+rowData.id+'\');\">'+value+'</div>';
					},
				    styler:function(value,rowData,rowIndex){
				        if (fuckclick2 == true && rowIndex == rowIndexClick){
							//当单元格被点击的时候，颜色变成红色
				        	return 'background-color:#ffee00;color:red;';
				        }
				    } 
            }
    	}else if(i == 3) {
    		column = {field:'probability3',width:bodyW*0.14 + 'px',title:probabilityScaleList[i].name, align:'center', sortable:true, show:'true', oper:'eq',
				formatter:function(value,rowData,rowIndex){
					var score = 3;
					return '<div title=\''+value+'\' onclick=\"selectScores3(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.probability3+'\',\''+rowData.id+'\');\">'+value+'</div>';
				},
			    styler:function(value,rowData,rowIndex){
			        if (fuckclick3 == true && rowIndex == rowIndexClick){
						//当单元格被点击的时候，颜色变成红色
			        	return 'background-color:#ffee00;color:red;';
			        }
			    }   
           }
    	}else if(i == 4) {
    		column = {field:'probability4',width:bodyW*0.14 + 'px',title:probabilityScaleList[i].name, align:'center', sortable:true, show:'true', oper:'eq',
				formatter:function(value,rowData,rowIndex){
					var score = 4;
					return '<div title=\''+value+'\' onclick=\"selectScores4(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.probability4+'\',\''+rowData.id+'\');\">'+value+'</div>';
				},
			    styler:function(value,rowData,rowIndex){
			        if (fuckclick4 == true && rowIndex == rowIndexClick){
						//当单元格被点击的时候，颜色变成红色
			        	return 'background-color:#ffee00;color:red;';
			        }
			    }   
           }
    	}
    	columnFix.push(column);
    }
    
    //frloadOpen();
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ProbabilitySD',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        whereSql: 'rrs_id=\''+ rrs_id +'\'',
        order:'asc',
        sort:'sn',
        gridJson:{    
            checkOnSelect:true,
            selectOnCheck:true,
            singleSelect:true,
            //onLoadSuccess:frloadClose,
            toolbar:[
                <s:if test="isView != 'Y'">
                {  
                text: '保存', iconCls: 'icon-save', handler: function () {  
                     
                    $.ajax({
                    	url:'${contextPath}/riskManagement/management/riskImplement/saveProbabilityScore.action',
                    	async:false,
                    	type:'POST',
                    	data:{'rowScore':rowScore,'riskWaitId':riskWaitId,'probabilitySDId':rowId},
                    	success:function(data) {
                    		if(data == '1') {
                    			showMessage1('保存成功！');
                    		}
                    	}
                    });
                }  
            }
              </s:if>  
            ] ,
            frozenColumns:[[
				{field:'id', title:'选择', checkbox:true, align:'center', show:'false', hidden:true},
				{field:'sn',title:'编号', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'eq',
                    formatter:function(value,rowData,rowIndex){
                        return  ["<label title='"+value+"'>",value,"</label>"].join('') ;
                    }},
				{field:'pType',title:'可能性种类', width:bodyW*0.14 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_sdYear')[0],
                    formatter:function(value,rowData,rowIndex){
                        return  ["<label title='"+value+"'>",value,"</label>"].join('') ;
                    }}
            ]],
            columns:[columnFix],
    		onLoadSuccess:function(data){
    			var rows = $("#sDTable").datagrid("getRows");
    			$.each(rows,function(index,row){
    				if(row.id == probabilitySDId){
        				if(possibleScore == 0){
        					//selectScores();
        					fuckclick = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}else if(possibleScore == 1){
        					//selectScores1();
        					fuckclick1 = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}else if(possibleScore == 2){
        					//selectScores2();
        					fuckclick2 = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}else if(possibleScore == 3){
        					//selectScores3();
        					fuckclick3 = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}else{
        					//selectScores4();
        					fuckclick4 = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}
    				}
    			});
    		}
        }
    });	
    g1.batchSetBtn([
        <s:if test="isView != 'Y'">
			{'index':1, 'display':true},
		</s:if>
		<s:else>
			{'index':1, 'display':false},
		</s:else>
		{'index':2, 'display':false},
		{'index':3, 'display':false},
		{'index':4, 'display':false},
		{'index':5, 'display':false},
		{'index':6, 'display':false},
        {'index':7, 'display':false},
        {'index':8, 'display':false}
    ]);
    
    /*$('#sDTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});*/
});

</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
