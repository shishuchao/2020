<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>影响程度评估</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
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

$(function(){
	var rrs_id = '${rrs_id}';
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
 	var influenceSDId = '${influenceSDId}';
 	var affectScore = '${affectScore}';
 	
 	var columnUnfix = eval('${influenceDegreeList}');
 	var columnFix = [];
 	 for(i in columnUnfix) {
     	if(i == 0) {
     		tmp = {field:'influence0',width:bodyW*0.125 + 'px',title:columnUnfix[i].name, align:'center', sortable:true, type:'custom', target:$('#query_tradePlate')[0],
					formatter:function(value,rowData,rowIndex){
						var score = 0;
						return '<div title=\''+value+'\' onclick=\"selectScores(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.influence0+'\',\''+rowData.id+'\');\">'+value+'</div>';
					},
				    styler:function(value,rowData,rowIndex){
				        if (fuckclick == true && rowIndex == rowIndexClick){
							//当单元格被点击的时候，颜色变成红色
				        	return 'background-color:#ffee00;color:red;';
				        }
				    }
               };
     	}else if(i == 1){
     		tmp = {field:'influence1',width:bodyW*0.125 + 'px',title:columnUnfix[i].name, align:'center', sortable:true, show:'true', oper:'eq',
				formatter:function(value,rowData,rowIndex){
					var score = 1;
					return '<div title=\''+value+'\' onclick=\"selectScores1(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.influence1+'\',\''+rowData.id+'\');\">'+value+'</div>';
				},
			    styler:function(value,rowData,rowIndex){
			        if (fuckclick1 == true && rowIndex == rowIndexClick){
						//当单元格被点击的时候，颜色变成红色
			        	return 'background-color:#ffee00;color:red;';
			        }
			    }
           };
     	}else if(i == 2){
     		tmp = {field:'influence2',width:bodyW*0.125 + 'px',title:columnUnfix[i].name, align:'center', sortable:true, show:'true', oper:'eq',
					formatter:function(value,rowData,rowIndex){
						var score = 2;
						return '<div title=\''+value+'\' onclick=\"selectScores2(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.influence2+'\',\''+rowData.id+'\');\">'+value+'</div>';
					},
				    styler:function(value,rowData,rowIndex){
				        if (fuckclick2 == true && rowIndex == rowIndexClick){
							//当单元格被点击的时候，颜色变成红色
				        	return 'background-color:#ffee00;color:red;';
				        }
				    } 
            };
     	}else if(i == 3){
     		tmp = {field:'influence3',width:bodyW*0.125 + 'px',title:columnUnfix[i].name, align:'center', sortable:true, show:'true', oper:'eq',
				formatter:function(value,rowData,rowIndex){
					var score = 3;
					return '<div title=\''+value+'\' onclick=\"selectScores3(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.influence3+'\',\''+rowData.id+'\');\">'+value+'</div>';
				},
			    styler:function(value,rowData,rowIndex){
			        if (fuckclick3 == true && rowIndex == rowIndexClick){
						//当单元格被点击的时候，颜色变成红色
			        	return 'background-color:#ffee00;color:red;';
			        }
			    } 
           };
     	}else if(i == 4){
     		tmp = {field:'influence4',width:bodyW*0.125 + 'px',title:columnUnfix[i].name, align:'center', sortable:true, show:'true', oper:'eq',
				formatter:function(value,rowData,rowIndex){
					var score = 4;
					return '<div title=\''+value+'\' onclick=\"selectScores4(\''+score+'\',\''+value+'\',\''+rowIndex+'\',\''+rowData.influence4+'\',\''+rowData.id+'\');\">'+value+'</div>';
				},
			    styler:function(value,rowData,rowIndex){
			        if (fuckclick4 == true && rowIndex == rowIndexClick){
						//当单元格被点击的时候，颜色变成红色
			        	return 'background-color:#ffee00;color:red;';
			        }
			    } 
           };
     	}
     	columnFix.push(tmp);
     }
 	
    //frloadOpen();
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'InfluenceSD',
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
                    	url:'${contextPath}/riskManagement/management/riskImplement/saveInfluenceScore.action',
                    	async:false,
                    	type:'POST',
                    	data:{'rowScore':rowScore,'riskWaitId':riskWaitId,'influenceSDId':rowId},
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
				{field:'iType',title:'影响方面', width:bodyW*0.11 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_sdYear')[0],
                    formatter:function(value,rowData,rowIndex){
                        return  ["<label title='"+value+"'>",value,"</label>"].join('') ;
                    }},
				{field:'riskDes',title:'风险描述', width:bodyW*0.12 + 'px',align:'center', sortable:true, show:'true', oper:'like',
                    formatter:function(value,rowData,rowIndex){
                        return  ["<label title='"+value+"'>",value,"</label>"].join('') ;
                    }}
            ]],
            columns:[columnFix],
    		onLoadSuccess:function(data){
    			var rows = $("#sDTable").datagrid("getRows");
    			$.each(rows,function(index,row){
    				if(row.id == influenceSDId){
        				if(affectScore == 0){
        					//selectScores();
        					fuckclick = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}else if(affectScore == 1){
        					//selectScores1(affectScore,"",row.influence3,row.id);
        					fuckclick1 = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}else if(affectScore == 2){
        					//selectScores2();
        					fuckclick2 = true;
        					rowIndexClick = index;
        					if(flag==true){
        						$('#sDTable').datagrid('reload');
        					}
        					flag = false;
        				}else if(affectScore == 3){
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
