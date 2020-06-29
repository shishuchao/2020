<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<title>内控-准备-评价方案-确定评价内容-选择控制点</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>	
<script type="text/javascript">
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "cpList";
	var cusWhereSql = " exists (select 1 from AudBusRelation ar  where a.cpId = ar.bid "+
	 "and ar.attrName = 'intctet_level' and ar.itemCode='${levelCode}')"+
	 "and exists (select 1 from AudBusRelation ar2  where a.cpId = ar2.bid "+
	 "and ar2.attrName='intctet_indtSector' and ar2.itemCode = '${tradePlateCode}')";
    $('#treeSelect').tree({   
		url:'${contextPath}/intctet/prepare/assessScheme/treeList.action?source=tree&projectId=${projectId}&orgId=${orgId}',
	    lines:true,
	    onClick:function(node){
			var gridQueryParamJson = {};
			if(node.id != 'root'){
				gridQueryParamJson = {'query_eq_mpCode':node.id};
			}
			
    		$.extend(gridQueryParamJson, {
    			whereSql:cusWhereSql,
    			boName  :'ControlPoint'
    		});
	    	//$('#'+gridTableId).datagrid('load', gridQueryParamJson);
	    	g1.refresh(gridQueryParamJson);
	    }
    });

	var addBtn = {
        text:'确定',
        iconCls:'icon-ok',
        handler:function(){
	       	 var rows = $('#'+gridTableId).datagrid('getChecked');//返回是个数组
	       	 if(rows && rows.length){
				 var mpCodes = [], mpNames = [];
		  		 var cpIdArr = [];
		  		 var msgArr = [];
			     for(i = 0; i < rows.length; i++){
			    	var row = rows[i];
			    	var cpId = row['cpId'];
			    	var cpCode = row['cpCode'];
			    	var isHaveRec = countBeans(cpCode);
			    	//alert(row.cpName+"\n"+isHaveRec)
	            	if(isHaveRec){
	            		msgArr.push("【"+row.cpName+"("+cpCode+")"+"】已经添加");
            			var rowIndex = $('#'+gridTableId).datagrid('getRowIndex',row);
            			$('#'+gridTableId).datagrid('unselectRow',rowIndex);
            			$('#'+gridTableId).datagrid('uncheckRow',rowIndex);
	            	}else{            		
			    	 	cpIdArr.push(cpId); 
			    	 	mpCodes.push(row['mpCode']);
			    	 	mpNames.push(row['mpName']);
	            	}
			     }
			     if(msgArr && msgArr.length){
            		top.$.messager.alert("提示信息", msgArr.join("</br>"), "info", function(){});
			     }else if(cpIdArr && cpIdArr.length){
			    	var mpDataJson = removeSameVal(mpCodes, mpNames);
				    saveCpRow(cpIdArr.join(","), mpDataJson.keys, mpDataJson.vals);		    	 
			     }
	       	 }else{
	       		 showMessage1("请选择控制点");
	       	 }
        }
	};
	
	//去掉数组中的重复值
	function removeSameVal(mpCodes, mpNames){
		var keys = [], vals = [];
		if(mpCodes && mpCodes.length){
			var mpLen = mpCodes.length;
			for(var i = 0; i < mpLen; i++){
				var mpCode = mpCodes[i];
				var isSame = false;
				if(keys.length == 0){
					keys.push(mpCode);
					vals.push(mpNames[i]);
				}else{
					var keyLen = keys.length;
					for(var j = 0; j < keyLen; j++){
						var key = keys[j];
						//alert(mpCode +"\n"+ key)
						if(mpCode == key){
							isSame = true;
							break;
						}
					}
					if(!isSame){
						keys.push(mpCode);
						vals.push(mpNames[i]);
					}
				}
			}
		}
		return {
			"keys":keys,
			"vals":vals
		};
	}
	
	var closeBtn = {
        text:'关闭',
        iconCls:'icon-cancel',
        handler:function(){
        	aud$closeTab();
        }	
	}
	
   	function saveCpRow(cpIds, mpCodes, mpNames){
		$.ajax({
			url : "${contextPath}/intctet/prepare/assessScheme/saveProControlPoint.action",
			dataType:'json',
			data:{
				'view':'${view}',	
				'projectId':'${projectId}',
				'cpIds' :cpIds,
				'auditId':"${orgId}"
			},
			type: "post",	
			beforeSend:function(){
				 aud$loadOpen();
				 return true;
			},
			success: function(data){
				aud$loadClose();
				data.msg ? showMessage1(data.msg) : null;
       			if(data.type = 'info'){
	  				var tabWin = aud$parentDialogWin();
	  				var sureContentWin = tabWin.$('#sureContent').get(0).contentWindow;
	  				if(sureContentWin){	  					
	        			var gridQueryParamJson = $.extend({
							'query_eq_evaluatedUnitId':"${orgId}"
	        			},{
	            			'whereSql':"projectId = '${projectId}'",
	            			'boName'  :'ProjectControlPoint'
	            		});
	        			if(mpCodes && mpNames && mpCodes.length == mpNames.length){	        				
		        			sureContentWin.$("#selectedMpCodes").val(mpCodes.join(","));
		        			sureContentWin.$("#selectedMpNames").val(mpNames.join(","));
	        			}
	        			sureContentWin.$('#contentCpList').datagrid('load', gridQueryParamJson);
	  				}
       				showMessage1("添加成功");
       				aud$closeTab();
       			}
			},
			error:function(data){
				aud$loadClose();
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
	}
	
	//检查当前被评价单位下是否选中的控制点
	function countBeans(cpCode){
		var count = 0;
		$.ajax({
			url : "${contextPath}/commonPlug/countBeans.action",
			dataType:'json',
			async:false,
			data: {
				"beanName":"ProjectControlPoint",
				"query_eq_projectId":"${projectId}",
				"query_eq_evaluatedUnitId":"${orgId}",
				"query_eq_cpCode":cpCode,
			},
			type: "post",
			success: function(data){
				count = data.count;
			},
			error:function(data){
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
		return count;
	}
	
	
	var fzDefinedColumns = [];
	fzDefinedColumns.push({field:'cpId',  
		title:'选择',       
		width:'10px', 
		checkbox:true,  
		align:'center', 
		halign:'center', 
		hidden:isView,
		show:'false'});
	
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
	            		return arr[this.field.split("_")[1]];
					}
   				}
            }
            fzDefinedColumns.push(col);
		}
	}
	
	
	var cusToolbar = isView ? [closeBtn] : [addBtn, "-", closeBtn, "-"];
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
	    myToolbar:['reload'],
	    associate:true,	    
		//定制查询条件
		whereSql: cusWhereSql,
        gridJson:{
        	pageSize:20,
	       	singleSelect:true,
	       	checkOnSelect:false,
	       	selectOnCheck:false,
	   		border:0,
	   		toolbar:cusToolbar,
	   		idField:'cpId',
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
                	viewUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=true&cpId="+row.cpId;
   					viewTitle = "${lastlevelName}查看";
                }
                if(viewUrl){          	
	                aud$openNewTab(viewTitle, viewUrl, true);
                }
            },
            onCheck:function(rowIndex,rowData){
            	if(countBeans(rowData.cpCode)){
            		showMessage1("当前被评价单位已经存在此${lastlevelName}");
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
            	}
            },
            onLoadSuccess:function(data){
				aud$mergeGridCells(gridTableId, data);
			},
            frozenColumns:[fzDefinedColumns],
   		    columns:[[
				{field:'ctrlImportName', title:"控制重要程度", width:'100px', align:'center', halign:'center', show:false},
				{field:'levelName',      title:"适用层级",    width:'20%', align:'center', halign:'center', show:false},
				{field:'indtSectorName', title:"适用板块",    width:'40%', align:'left', halign:'center', show:false}
            ]]
        }
    });
    
    $('#'+gridTableId).datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '400px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
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
<body class="easyui-layout" id="codenameLayout" border="0" fit="true">
	<div region="west" title="业务流程" style="width:200px;padding:10px;" split="true" border="0">
		<ul id='treeSelect' class='easyui-tree'></ul>
    </div>
    <div region="center" style="overflow:hidden;" border="0">
    	 <table id="cpList"></table>
    </div>
</body>
</html>
