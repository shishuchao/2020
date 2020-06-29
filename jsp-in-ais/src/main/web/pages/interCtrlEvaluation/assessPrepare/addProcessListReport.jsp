<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<title>内控-缺陷-${lastlevelName}选择</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>	
<script type="text/javascript">
$(function(){
	//var isView = '${view}';	
	var isView = 'true';	
	var projectId = '${projectId}';
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "contentCpList";
    $('#bjtreeSelect').tree({   
		url:'${contextPath}/intctet/prepare/assessScheme/genOrgProcessTree.action?projectId=${projectId}',
	    lines:true,
	    onLoadSuccess:function(){
	    	setTimeout(function(){
	    		$('#bjtreeSelect').tree('expandAll');
	    	},0);
	    },
	    onClick:function(node){
	    	var nodeInfo = getSelectTreeOrgId(true);
	    	var type = nodeInfo.type;
	    	if(type == '1'){
	    		gridQueryParamJson = {'query_eq_evaluatedUnitId':node.id};
	    	}else if(type == '2'){
    			var parentNode = $('#bjtreeSelect').tree('getParent', node.target);
    			gridQueryParamJson = {
					'query_eq_mpCode':node.id,
					'query_eq_evaluatedUnitId':parentNode.id
				};
	    	}else{
	    		g1.refresh();
	    		return;
	    	}
    		$.extend(gridQueryParamJson, {
    			whereSql:"projectId='${projectId}'",
    			boName  :'ProjectControlPoint'
    		});
	    	$('#'+gridTableId).datagrid('load', gridQueryParamJson);
	    }
	});
    
	//是否选中一条记录
	function isSingle(rows){
		if(rows!=null && rows.length>0){
			if(rows.length==1){
				return true;
 			}else{

				top.$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
				return false;	     			
 			}				
		}else{

			top.$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
			return false;
		}	
	}	
	
    //获得选中的被评价单位
    function getSelectTreeOrgId(onRtJson){
    	var node = $('#bjtreeSelect').tree('getSelected');
    	if(node){
    		var attributes = node.attributes;
    		if(attributes){
    			//alert(attributes)
    			var ajson = (new Function("return " + attributes))()
    			
    			if(onRtJson){
    				return ajson;
    			}
    			
    			//for(var p in ajson) alert(p+"="+ajson[p])
    			if(ajson.type != 1){
    				showMessage1("只能选择左侧的被评价单位，不要选择主流程和根节点");
    			}else{
    				return {
    					id:node.id,
    					text:node.text,
    					attributes:ajson
    				}
    			}
    		}
    	}else{
    		showMessage1("请选择左侧的被评价单位");
    	}
    	return null;
    }

	var addBtn = {
	         text:'确定',
	         iconCls:'icon-ok',
	         handler:function(){
	        	 var rows = $('#contentCpList').datagrid('getChecked');//返回是个数组
	        	 if(isSingle(rows)){
	        	 	var row = rows[0];    
	        	 
        	 	     var activeTabId = aud$getActiveTabId();
        	 		 var  win  = aud$parentDialogWin();//aud$getTabIframByTabId(activeTabId)
                     win.$('#controlName').val(row.cpName);
        	 		  win.$('#controlCode').val(row.cpCode)
                     
                     win.$('#circuitName').val(row.mpName); //主流程
        	 		 win.$('#circuitCode').val(row.mpCode);
        			 win.$('#sonCircuitName').val(row.superiorNames); // 子流程
        	 		 win.$('#sonCircuitCode').val(row.superiorCodes);
        	 		
        	 		 win.$('#evaDept').val(row.evaluatedUnit); // 被评价单位
        	 		 win.$('#reportProblem_evaDeptCode').val(row.evaluatedUnitId);
        	 		 
        	 		 win.$('#accountabilityUnit').val(row.evaluatedUnit);  //整改责任单位
        	 		 win.$('#accountabilityUnitCode').val(row.evaluatedUnitId);

        			 win.$('#manuscriptIndex').val(row.manuIndex); // 底稿索引
        			 var tId = "#superior_";
	        	     if ( row.superiorNames != null && row.superiorNames != ""){
        	        	var superiorNames = row.superiorNames;
        	        	var suNames =  superiorNames.split(","); // 
        	         	var suLen = suNames.length;
        	        	$.each(suNames,function(i,suName){
        	        		 win.$(tId+i).text(suName);
        	        	});  
	        	     }  
        	 		aud$closeTopDialog();
	        	 }
	         }
	};
	

	var cusToolbar = isView ? [ addBtn,"-"] : [addBtn, "-"];
	
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ProjectControlPoint',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'cpId',
        order :'asc',
        sort  :'evaluatedUnitId, cpCode',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar: isView ? [] : ['export', 'search', 'reload','delete', 'export', 'search', 'reload'],
	    associate:true,
		//定制查询条件
		whereSql: "projectId='${projectId}' ",
        gridJson:{
    		singleSelect:true,
        	checkOnSelect:false,
    		border:0,
    		toolbar:cusToolbar,
            onLoadSuccess:function(data){
            	if(data && data.rows && data.rows.length){
            		parent.$('#qtab').tabs('enableTab',3);
            	}
            },
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                var viewUrl = "", viewTitle = "查看";
                if(field == 'mpCode'){
                	viewUrl = "${contextPath}/intctet/mainProcess/showSubProcessList.action?view=true&nodeCode="+row.mpCode;
   					viewTitle = "主流程查看";
                }else if(field == 'cpCode'){
                	viewUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=true&proCp=true&projectId=${projectId}&cpId="+row.cpId;
   					viewTitle = "项目控制点查看";
                }
                if(viewUrl){
                	aud$openNewTab(viewTitle, viewUrl, true);
                }
            },
            frozenColumns:[[
				{field:'cpId',   title:"选择",checkbox:true, width:'1px', align:'center', halign:'center', show:false},
				{field:'evaluatedUnit', title:"被评价单位", width:'220px', align:'left', halign:'center', show:false,
   					formatter:function(value,row,index){
   						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
   					}
				},
				{field:'mpCode', title:"主流程编码", width:'100px', align:'center', halign:'center', show:false, 				
					formatter:function(value,row,index){
   						return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
   				}}
            ]],
   		    columns:[[
   				{field:'mpName', title:"主流程", width:'100px', align:'center', halign:'center', show:false,
   					formatter:function(value,row,index){
   						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
   					}
   				},
				{field:'cpCode', title:"${lastlevelName}编码", width:'180px', align:'center', halign:'center', show:false,	   				
					formatter:function(value,row,index){
   						return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
   				}},
   				{field:'cpName', title:"${lastlevelName}", width:'40%', align:'center', halign:'center', show:false,
   					formatter:function(value,row,index){
   						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
   					}
   				}
           ]]
        }
    });
    window.contentCpList = g1;
});
</script>
</head>
<body class="easyui-layout" id="codenameLayout" border="0" fit="true">
	<div region="west" style="width:260px;overflow:hidden;padding:10px;" split="true" border="0" >
		<ul id='bjtreeSelect' class='easyui-tree'></ul>
    </div>
    <div region="center" style="overflow:hidden;" border="0" >
    	<table id="contentCpList"></table>
    </div>
</body>
</html>
