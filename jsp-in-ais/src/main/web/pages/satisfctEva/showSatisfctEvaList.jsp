<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>满意度评价-评价打分</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	if("${errorMsg}"){
		top.$.messager.alert("提示信息","${errorMsg}", "warning", function(){			
			aud$closeTab();
		});
		setTimeout(aud$closeTab,0);
	}
	// 10:组长、参数模板, 20:主审评价模板
	var tpTypeCode = '${tpTypeCode}' ? '${tpTypeCode}' : '20';
	// 基础信息
	var busBaseUrl = "${contextPath}/satisfctEva/";
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "busTable";
	var showDelBtn = true;//false;
	// 主审得分结果
	var zsScoreResult = "${zsScoreResult}" == true || "${zsScoreResult}" == "true" ? true : false;
	// 主审得分明细
	var zsScoreMx = "${zsScoreMx}" == true || "${zsScoreMx}" == "true" ? true : false;
	// 参审打分(在线作业)
	var csScore = "${csScore}" == true || "${csScore}" == "true" ? true : false;
	// 参审打分结果(在线作业)
	var csScoreResult = "${csScoreResult}" == true || "${csScoreResult}" == "true" ? true : false;
	isView = csScoreResult ? true : isView;
	if(isView || zsScoreMx || csScoreResult){
		showDelBtn = false;
	}
	
	// 表格按钮
	var saveBtn = {   
	    text:'保存',
	    iconCls:'icon-save',
	    handler:function(){
	    	saveRows();
	    }
	};
	var postBtn = {
	    text:'提交',
	    iconCls:'icon-ok',
	    handler:postRows	
	};
	var closeBtn = {
	    text:'关闭',
	    iconCls:'icon-cancel',
	    handler:aud$closeTab
	};
    // 保存
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
			if(rt){		
		    	var sendData = null;
		    	//var insertRows = $('#'+gridTableId).datagrid('getChanges','inserted');
		    	var updateRows = $('#'+gridTableId).datagrid('getChanges','updated');
		    	if(updateRows && updateRows.length){
		    		$.each(updateRows, function(i, row){
		    			var sumScore = 0;
		    			var teanmMngScore = row['teanmMngScore'];
		    			//alert("teanmMngScore="+teanmMngScore)
		    			if(teanmMngScore){
		    				sumScore = parseFloat(teanmMngScore);
		    			}
		    			var scoreValArr = [];
		    			//dymFieldArr
		    			//alert(dymFieldArr.length)
		    			$.each(dymFieldArr, function(i, fd){
		    				var val = row[fd];
		    				if(val){
		    					sumScore += parseFloat(val);
		    				}
		    				scoreValArr.push(val ? val : 0);
		    			})
		    			row['sumScore'] = sumScore.toFixed(1);
		    			row['evaItemKey'] = dymFieldArr.join(",");
		    			row['evaItemScore'] = scoreValArr.join(",");
		    			//alert("csScore="+csScore)
		    			if(csScore){
		    				// 在线作业: 满意度打分保存后，状态改成已保存
		    				row['evaStatus'] = "已保存";
		    				row['evaStatusCode'] = "20";
		    			}
		    		});
		    	}
		    	//var insertRowsJson = insertRows.length ? aud$rows2Json("insertRow", insertRows) : {};   
		    	if ( updateRows && updateRows.length ){
			    	var updateRowsJson = updateRows.length ? aud$rows2Json("updateRow", updateRows) : {};
			    	//sendData = $.extend({}, insertRowsJson, updateRowsJson);
			    	sendData = $.extend({}, updateRowsJson);
			    	
			    	//alert("sendData:"+sendData)
					$.ajax({
						url : busBaseUrl + "/saveEvaScore.action",
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
			       			}
						},
						error:function(data){
							aud$loadClose();
							top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
						}
					});
		    	}else{
		    		showMessage1("数据没有修改，不需保存");
		    	}

			}
		}else{
			noMsg ? "" : showMessage1("数据没有修改，不需保存");
		}
    }
    // 提交
    function postRows(){
    	top.$.messager.confirm("确认","评分提交后将不能再修改评分项, 请确认数据是否已经保存？", function(r){
    		if(r){
    			innerFn();
    		}
    	});
    	function innerFn(){
	        $.ajax({
	            url: "${contextPath}/commonPlug/updateBeans.action",
	            dataType: 'json',
	            type: "post",
	            data: {
	                'beanName':'SatisfctEva',
	                'query_eq_projectId':'${projectId}',
	            	//主审评价模板
	                'query_eq_tpTypeCode':tpTypeCode,
	                'update_evaStatus':'已提交',
	                'update_evaStatusCode':'1'
	            },
	            success: function(data) {
	            	showMessage1(data.type == 'info' ? "提交成功" : "提交失败");
	                if(data && data.type == 'info'){
	                	try{
		                	var tabWin = aud$parentDialogWin();
		                	if(tabWin && tabWin.aud$zhushenEvaGrid){                		
		                		tabWin.aud$zhushenEvaGrid.refresh();
		                	}           		
	                	}catch(e){
	                		
	                	}finally{
	                		aud$closeTab();
	                	}
	                }
	            },
	            error: function(data) {
	                top.$.messager.show({
	                    title: '提示信息',
	                    msg: '请求失败！请检查网络配置或者与管理员联系！'
	                });
	            }
	        });
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
			return true;
		}else{
			return false;
		}
	}
    //编辑and选中行
    function editAndSelect(index, field){
    	try{
    		//alert("index="+index+"\nfield="+field)
			$('#'+gridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);
			//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
			editIndex = index; 
			setTimeout(function(){				
				var ed = $('#'+gridTableId).datagrid('getEditor', {index:index,field:field});
				if(ed){
					if(canNotEditField.indexOf(field+",") > 0){
						$(ed.target).select()[0].focus();
					}else{
						$(ed.target).next('span').find("input:text").select()[0].focus();
					}
				}       				
			},0);
    	}catch(e){
    		alert('editAndSelect:\n'+e.message);
    	}
    }    
    
	var barView = ['reload'];
	//var barEdit = showDelBtn ? [saveBtn,'-',postBtn,'-','delete','-','reload','-',closeBtn] : [saveBtn,'-',postBtn,'-','reload','-',closeBtn];
	var barEdit = [saveBtn,'-',postBtn,'-','reload','-',closeBtn];
	if(csScore){		
		barEdit = [saveBtn,'-','reload'];
	}else if(csScoreResult){
		barEdit = ['reload'];
	}
	var cusToolbar = isView ? barView : barEdit;
	if(showDelBtn){
		cusToolbar.push("-");
		cusToolbar.push('delete');
	}
	if(zsScoreResult || zsScoreMx){
		cusToolbar.push('-');
		cusToolbar.push(closeBtn)
	}
	if('${view}' != 'true') {
		cusToolbar.push('-');
		cusToolbar.push(helpBtn)
	}

	// 查询主审评价表格动态表头
    function genZhushenDynamicHead(){
    	var headList = null;
        $.ajax({
            url: busBaseUrl + "genDynamicHead.action",
            dataType: 'json',
            type: "post",
            async: false,
            data: {
                'tpTypeCode':tpTypeCode
            },
            success: function(data) {
            	data.msg ? showMessage1(data.msg) : null;
                if(data && data.type == 'info'){
                	headList = data.headList;
				}
            },
            error: function(data) {
                top.$.messager.show({
                    title: '提示信息',
                    msg: '请求失败！请检查网络配置或者与管理员联系！'
                });
            }
        });
        return headList;
    }
	
    // // 计算综合评分
	// function computeSumScore(){
   	// 	var sumScore = 0;
    // 	var rowField = $('.datagrid-row-editing').find("td[field^='item']");
    // 	if(rowField.length){
    // 		rowField.find(".textbox-value").each(function(i, ele){
	// 			var s = $(ele).val();
	// 			if(s){
	// 				sumScore += parseInt(s);
	// 			}
    // 		});
    // 		//alert("sumScore="+sumScore)
    // 	}
	// 	return sumScore;
	// }
    //给动态表头列赋值
    function assignDymFieldVal(value, row, colId){
		var rtVal = 0;
		var evaItemKey = row.evaItemKey;
		var evaItemScore = row.evaItemScore;
		if(evaItemKey && evaItemScore){
			var idArr = evaItemKey.split(",");
			var scoreArr = evaItemScore.split(",");
			for(var i = 0; i < idArr.length; i++){
				if(colId == idArr[i]){
					rtVal = scoreArr[i];
					break;
				}
			}
		}
    }
	
	// 要评分的表格字段名称
	var scoreFieldArr = ['teanmMngScore'];
	var dymFieldArr = [];
    var gridColums = [];
	var gridRowspan = 1;
	var gridColum2 = [];
    var colspanColums = [];
	var headList = genZhushenDynamicHead();
	if(headList && headList.length){		
		//动态表头（跨行跨列）
		$.each(headList, function(i, headCol){
			var required = headCol.required;
			var gridField = headCol.colId;
			if(headCol.colspan > 1){
				gridField = "";
			}else{				
				scoreFieldArr.push(gridField);
				dymFieldArr.push(gridField);
			}
			var colJson = {
				field:gridField, 
				title:(required == true ? "<font color='red'>*</font>": "" ) + headCol.colName,
				rowspan:headCol.rowspan, 
				colspan:headCol.colspan,
				width:'90px',
				align:'right', 
				halign:'center',
				editor:{
					type:'numberbox', 
					options:{
						required:required, 
						min:0,
						max:headCol.weight,
						precision:1,
						missingMessage:'0-'+headCol.weight+'正数',
						onChange:function(newValue,oldValue){
							
						},
						inputEvents:{
				            blur: function(e) {
				            	var tg = e.data.target;
				                $(tg).numberbox("setValue", $(tg).numberbox("getText"));
				            }
						}
					}
				},
				styler:function(value,row,index){
					return isView ? "" : 'background-color:#FFFACD;';
				},
				formatter:function(value,row,index){
					value = value ? value : 0;
					return isView ? value : "<label title='双击进行编辑' style='cursor:pointer;'>"+value+"</label>";
				}
			};
			if(headCol.colspanList && headCol.colspanList.length){
				gridRowspan = 2;
				var colspanList = headCol.colspanList;
				$.each(colspanList, function(j, spanObj){
					var colspanRequired = spanObj.required;
					if(spanObj.colspan > 1){
						gridField = "";
					}else{
						gridField = spanObj.colId;//'item'+(parseInt(i)+parseInt(j)+1);
						scoreFieldArr.push(gridField);
						dymFieldArr.push(gridField);						
						
					}
					colspanColums.push({
						field:gridField, 
						title:(colspanRequired == true ? "<font color='red'>*</font>": "" ) + spanObj.colName,
						rowspan:spanObj.rowspan, 
						colspan:spanObj.colspan,
						width:'90px',
						align:'right', 
						halign:'center',
						editor:{
							type:'numberbox', 
							options:{
								required:spanObj.required, 
								min:0,
								max:spanObj.weight,
								precision:1,
								missingMessage:'0-'+spanObj.weight+'正数',
								onChange:function(newValue,oldValue){
									
								},
								inputEvents:{
						            blur: function(e) {
						            	var tg = e.data.target;
						                $(tg).numberbox("setValue", $(tg).numberbox("getText"));
						            }
								}
							}
						},
						styler:function(value,row,index){
							return isView ? "" : 'background-color:#FFFACD;';
						},
						formatter:function(value,row,index){
							value = value ? value : 0;
							return isView ? value : "<label title='双击进行编辑' style='cursor:pointer;'>"+value+"</label>";
						}
					});
				});
			}
			gridColum2.push(colJson);
		});
	}
	
	var canNotEditField = new String('insptPerson,projectRole,belongedUnit,sumScore,examinePerson,examineDate,');
	
    var gridColum1 = [];
    gridColum1.push(/* {
		field:'seId', checkbox:true, width:'100px',align:'center', halign:'center', sortable:true, show:false, 
		rowspan:gridRowspan, hidden:!showDelBtn
	}, */{
		field:'insptPerson', title:"被考核人", width:'100px',align:'center', halign:'center', sortable:true, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		rowspan:gridRowspan
	},{
		field:'insptPersonGroup', title:"所在分组", width:'100px',align:'center', halign:'center', sortable:true, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		rowspan:gridRowspan, hidden:!(csScore || csScoreResult)
	},{
		field:'projectRole', title:"项目角色", width:'100px',align:'center', halign:'center', sortable:true, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		rowspan:gridRowspan
	},{
		field:'belongedUnit', title:"所属单位", width:'120px',align:'left', halign:'center', sortable:true, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		rowspan:gridRowspan
	});
	
	var gridColum3 = [];
	gridColum3.push({
		field:'teanmMngScore', title:"团队管理</br>(加分项)", width:'90px',align:'right', halign:'center', sortable:true, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		editor:{
			type:'numberbox', 
			options:{
				required:false, 
				min:0,
				max:100,
				precision:1,
				missingMessage:'0-100正数',
				onChange:function(newValue,oldValue){
					
				},
				inputEvents:{
		            blur: function(e) {
		            	var tg = e.data.target;
		                $(tg).numberbox("setValue", $(tg).numberbox("getText"));
		            }
				}
			}
		},
		rowspan:gridRowspan,
		styler:function(value,row,index){
			return isView ? "" : 'background-color:#FFFACD;';
		},
		formatter:function(value,row,index){
			value = value ? value : 0;
			return isView ? value : "<label title='双击进行编辑' style='cursor:pointer;'>"+value+"</label>";
		}
	},{
		field:'sumScore', title:"综合评分", width:'100px',align:'right', halign:'center', sortable:true, 
		formatter:function(value,row,index){
			return value ? "<label title='"+value+"'>"+value+"</label>" : "";
		},
		rowspan:gridRowspan
	});
	
	if(zsScoreResult){
		gridColum3.push({
			field:'evaCount', title:"考核记录", width:'80px',align:'center', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='单击查看考核打分明细' style='cursor:pointer;color:blue;'>"+value+"</label>" : "";
			},
			rowspan:gridRowspan
		})
	}else if(zsScoreMx){
		gridColum3.push({
			field:'examinePerson', title:"考核人", width:'100px',align:'center', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			rowspan:gridRowspan
		},{
			field:'examineDate', title:"考核时间", width:'100px',align:'center', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			rowspan:gridRowspan
		})
	}else{
		gridColum3.push({
			field:'examinePerson', title:"考核人", width:'100px',align:'center', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			rowspan:gridRowspan
		},{
			field:'examineDate', title:"考核时间", width:'100px',align:'center', halign:'center', sortable:true, 
			formatter:function(value,row,index){
				return value ? "<label title='"+value+"'>"+value+"</label>" : "";
			},
			rowspan:gridRowspan
		})
	}
	
	gridColums = gridColums.concat(gridColum1);
	gridColums = gridColums.concat(gridColum2);
	gridColums = gridColums.concat(gridColum3);
	var finalColumns = gridRowspan > 1 ? [gridColums, colspanColums] : [gridColums];
	
	// 自定义查询方法
	var custom_serviceInstance = 'satisfctEvaService';
  	var custom_serviceMethod = 'evaScoreCustomGrid';
	if(zsScoreResult){
	  	custom_serviceMethod = 'viewZsEvaScoreCustomGrid';
	}else if(zsScoreMx){
		custom_serviceMethod = 'viewZsEvaScoreMxCustomGrid';
	}else if(csScore){
		custom_serviceMethod = 'evaProjectCsScoreList';
	}else if(csScoreResult){
		custom_serviceMethod = 'evaProjectCsScoreRstList';
	}
	
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 自定义查询服务和方法
        serviceInstance:custom_serviceInstance,
      	serviceMethod  :custom_serviceMethod,
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SatisfctEva',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'seId',
        order :'asc',
        sort  :'createTime',
		winWidth:800,
	    winHeight:300,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    gqueryParams:{
			'n_busType':'100',
	    	'n_projectId':'${projectId}',
	    	'n_tpTypeCode':tpTypeCode,
	    	'n_userName':'${user.fname}',
	    	'n_loginName':'${user.floginname}'
	    },
	    associate:true,
        gridJson:{
			rownumbers:true,
		    //pageSize:20,
		    pagination:false,
        	singleSelect:true,
        	checkOnSelect:true,
        	selectOnCheck:true,
    		border:0,
    		//自定义工具栏按钮
    		toolbar:cusToolbar,
			onBeforeLoad:function(data){
				if('${view}' != 'true') {
					initHelpBtn();
				}
			},
    		onLoadSuccess:function(data){
    			if(csScoreResult && data && data.rows.length == 0){
    				top.$.messager.alert("提示信息","未查询到评价打分记录","info");
    			}
    		},
    		onClickCell:function(index, field, value){
        		if(zsScoreResult && field == 'evaCount'){
        			var winTitle = "主审考核打分明细";
        			var evaAction = "viewZsEvaScoreMxList";
 			        new aud$createTopDialog({
 			            title:winTitle,
 			            url  :busBaseUrl + evaAction + ".action?projectId=${projectId}"
 			     	}).open();
        		}
    		},
    		onDblClickCell:function(index, field, value){
        		if(isView || canNotEditField.indexOf(field+",") > 0){
        			return;
        		}
       			endEditing() ? editAndSelect(index, field) : $('#'+gridTableId).datagrid('selectRow', editIndex);
    		},
    		columns:finalColumns
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