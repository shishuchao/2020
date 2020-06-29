<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<title>内控-准备-评价方案-确定评价内容</title>
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
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
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
	    	//$('#'+gridTableId).datagrid('load', gridQueryParamJson);
	    	g1.refresh(gridQueryParamJson);
	    }
	});
    
    //根据选中的控制点，动态构建左侧树形的被评价单位下主流程
    function genMpNodes(mpNames, mpCodes){
    	try{
	    	if(mpNames && mpCodes && mpNames.length > 0 && mpNames.length == mpCodes.length){
		    	var sNode = $('#bjtreeSelect').tree('getSelected');
		    	if(!sNode) return;
		    	var attributes = sNode.attributes;
		    	var ajson = (new Function("return " + attributes))();
		    	if(ajson.type == '1'){
		    		var children = null;
		    		try{
			    		children = $('#bjtreeSelect').tree('getChildren', sNode.target);
		    		}catch(e){
		    			//alert(e.message);
		    		}
					//alert('children='+children)
					var appendData = [];
					if(children && children.length){						
						$.each(mpCodes, function(j, mpCode){
							var isSame = false;
							var clen = children.length;
							for(var i = 0; i < clen; i++){
								var cnode = children[i];
								if(cnode['id'] == mpCode){
									isSame = true;
						    		//$('#bjtreeSelect').tree('remove', cnode.target);
								}
							}
							if(!isSame){
								appendData.push({
									'id':mpCode,
									'text':mpNames[j],
									'attributes':"{'type':'2'}"
								});
							}
						});
						
					}else{
						$.each(mpNames, function(i, mpName){
							appendData.push({
								'id':mpCodes[i],
								'text':mpName,
								'attributes':"{'type':'2'}"
							});
						});
					}
		    		$('#bjtreeSelect').tree('append', {
		    			'parent':sNode.target,
		    			'data'  :appendData
		    		}); 
		    		
		    		$("#selectedMpCodes, #selectedMpNames").val('');
		    	}
	    	}  		
    	}catch(e){
    		alert('genMpNodes:'+e.message);
    	}
    }
    
    //获得选中的被评价单位
    function getSelectTreeOrgId(onRtJson){
    	try{   		
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
    	}catch(e){
    		alert("getSelectTreeOrgId:\n"+e.message);
    	}
    	return null;
    }

	var selectCpBtn = {
        text:'新增',
        iconCls:'icon-add',
        handler:function(){
        	var nodeInfo = getSelectTreeOrgId();
        	var attr = nodeInfo.attributes;
        	//alert(attr.levelCode+","+attr.tradePlateCode)
        	if(nodeInfo){       		
	        	var orgId = nodeInfo.id;
	        	var param = "&projectId=${projectId}&orgId="+orgId+"&levelCode="+attr.levelCode+"&tradePlateCode="+attr.tradePlateCode;
	        	var selectUrl = "${contextPath}/intctet/prepare/assessScheme/showProcessList.action?view=${view}"+param;
	    		new aud$createTopDialog({
	    			title:nodeInfo.text+'-${lastlevelName}选择',
	    			url:selectUrl
	    		}).open();
        	}
        }	
	};
	
	var cusToolbar = isView ? [] : [selectCpBtn,'-'];
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ProjectControlPoint',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'cpId',
        order :'asc',
        sort  :'evaluatedUnitId, mpCode, cpCode',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar: isView ? ['export',  'reload'] : ['delete', 'export',  'reload'],
	    associate:true,
		//定制查询条件
		whereSql: "projectId='${projectId}' ",
		//删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject)
		afterRemoveRowsFn:function(rows, gridObject){
			reloadLeftTree();
		},
        gridJson:{
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		toolbar:cusToolbar,
            onLoadSuccess:function(data){
            	aud$mergeGridCells(gridTableId, data);
            	if(data && data.rows && data.rows.length){
            		parent.$('#qtab').tabs('enableTab',3);
            	}
            	//alert($('#selectedMpNames').val())
            	//alert($('#selectedMpCodes').val())
            	var mpNames = $('#selectedMpNames').val();
            	var mpCodes = $('#selectedMpCodes').val();
            	if(mpNames && mpCodes){            		
	            	//genMpNodes(mpNames.split(","), mpCodes.split(","));
	            	reloadLeftTree();
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
   					viewTitle = "${firstlevelName}查看";
                }else if(field == 'cpCode'){
                	viewUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=true&proCp=true&projectId=${projectId}&cpId="+row.cpId;
   					viewTitle = "项目${lastlevelName}查看";
                }
                if(viewUrl){
                	aud$openNewTab(viewTitle, viewUrl, true);
                }
            },
            frozenColumns:[[
				{field:'cpId',   title:"选择",checkbox:true, width:'10px', align:'center', halign:'center', show:'false'},
				{field:'evaluatedUnit', title:"被评价单位", width:'150px', align:'center', halign:'center', sortable:true,  show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
   				{field:'mpName', title:"${firstlevelName}", width:'100px', align:'center', halign:'center', sortable:true, show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
   				},
				{field:'mpCode', title:"${firstlevelName}编码", width:'100px', align:'center', halign:'center', sortable:true, show:false, 				
					formatter:function(value,row,index){
   						return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
   				}},
				{field:'cpCode', title:"${lastlevelName}编码", width:'160px', align:'center', halign:'center', sortable:true, show:false,	   				
					formatter:function(value,row,index){
   						return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
   				}}
            	
            ]],
   		    columns:[[
   				{field:'cpName', title:"${lastlevelName}", width:'80%', align:'left', halign:'center', show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
   				}
           ]]
        }
    });
    
    function reloadLeftTree(){
		var sNode = $('#bjtreeSelect').tree("getSelected") 
		var root = $('#bjtreeSelect').tree("getRoot");
		var tnode = sNode || root
		if(tnode){
			$('#bjtreeSelect').tree("reload");

			setTimeout(function(){
				var myNode = $('#bjtreeSelect').tree("find", tnode.id);
				//alert(myNode)
				if(myNode){
					$('#bjtreeSelect').tree("select", myNode.target);
				}
			},500);
		}
    }
    
    window.contentCpList = g1;
    
    // 合并datagrid的单元格
	function aud$mergeGridCells(gridId, data){
		try{
			if(gridId && data){
            	var rows = data.rows;          
				if(rows && rows.length){
					var fieldsName = ['evaluatedUnit'];
					var fieldsCode = ['evaluatedUnitId'];
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
<body class="easyui-layout" id="codenameLayout" border="0" fit="true">
	<div region="west" title="被评价单位" style="width:270px;overflow:hidden;padding:10px;" split="true" border="0" >
		<ul id='bjtreeSelect' class='easyui-tree'></ul>
    </div>
    <div region="center" style="overflow:hidden;" border="0" >
    	<table id="contentCpList"></table>
    </div>
    <input type="hidden" id="selectedMpCodes" />
    <input type="hidden" id="selectedMpNames" />
</body>
</html>
