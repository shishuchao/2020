<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审前关注点管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
</head>
<script type="text/javascript">

// 初始化
$(function(){
	
	$("#lrsjyd_form").find("textarea").each(function(){
		autoTextarea(this);
	});
	

	
/* 	 var winH = document.documentElement.clientHeight || document.body.clientHeight;
	 var winW = document.documentElement.clientWidth || document.body.clientWidth;
    $('#lrsjyd_div').window({   
		width:winW,   
		height:winH,   
		modal:true,
		collapsible:false,
		maximizable:false,
		minimizable:false,
		closed:true
	});  */ 
	// 关闭录入窗口
	$('#closeWinSjyd').bind('click',function(){
		$('#lrsjyd_div').window('close');
	})
    $('#atTreeWrap').window({   
		width:700,   
		height:510,   
		modal:true,
		collapsible:false,
		maximizable:false,
		minimizable:false,
		closed:true
	}); 
	$('#clearAtTree').bind('click',function(){
		$('#atTreeWrap').window('close');
	});
	// 分配审前关注点给审计事项
	$('#sureAtTree').bind('click',function(){
		var treeNode = $('#atTree').tree('getSelected');
		var taskId = "";

		if(treeNode){
			taskId = treeNode.id;
		}else{
			$.messager.show({
				title:'提示信息',
				msg:'请选择审计事项！',
				timeout:5000,
				showType:'slide'
			});
			return;
		}
		if(treeNode.leaf != undefined){
			$.messager.show({
				title:'提示信息',
				msg:'请选择末级节点！',
				timeout:5000,
				showType:'slide'
			});
			return false;
		}
		        
        var groupId   = $('#group_selectId option:selected').attr('value');
        var groupName = $('#group_selectId option:selected').attr('mc');
        //alert(groupId +' ' + groupName);
        /*
		if(!groupId){
			alert('请选择审计分组！');
			return;
		}*/
		var rows = $('#sjydQueryDataTab').datagrid('getSelections');
		if (rows && rows.length > 0){
			var delIdArr = [];
			$.each(rows, function(i, row){
				delIdArr.push("'"+row.id+"'");
			});
			//alert(delIdArr.join(',')+' ---  '+taskId)
			$.ajax({
				url:"<%=request.getContextPath()%>/adl/assignAuditDoubtfulToAuditTask.action",
				dataType:'json',
				cache:false,
				type: "post",
				data: {
					'ids':delIdArr.join(','),
					'taskId':taskId,
                    'groupId':groupId,
                    'groupName':groupName,
                    'projectId':$('#projectId').val()
				},
				success: function(data){			
						if(data.type == 'success'){
							window.parent.$.messager.show({
								title:'提示信息',
								msg:data.msg,
								timeout:5000,
								showType:'slide'
							});
                            querySjyd();
							$('#atTreeWrap').window('close');
						}
				},
				error:function(data){
					window.parent.$.messager.show({
						title:'提示信息',
						msg:'请求失败！',
						timeout:5000,
						showType:'slide'
					});
				}
			});
		}	
	});
	// 加载关注点表格
	loadSjydTableGrid();
	///querySjyd();
	
})


function loadSjydTableGrid(){
	var view = ${view};
	// 初始化生成表格
	$('#sjydQueryDataTab').datagrid({
		url : "<%=request.getContextPath()%>/adl/querySjyd.action",
		queryParams:{
			'queryAd.bsjdwDm':$('#queryAd_bsjdwDm').val(),
			'queryAd.ydqjQ':formatDate2String($('#queryAd_ydqjQ').val()),
			'queryAd.ydqjZ':formatDate2String($('#queryAd_ydqjZ').val()),
            'projectId':$('#projectId').val()
		},
		onSortColumn:function(sortName,sortOrder){
			var queryparams = $('#sjydQueryDataTab').datagrid('options').queryParams;  
			//queryparams['sortName'] = sortName;
			queryparams['sortOrder'] = sortOrder;
		},
		method:'post',
		showFooter:false,
		rownumbers:true,
		pagination:true,
		striped:true,
		autoRowHeight:false,
		fit: true,
		fitColumns:true,
		idField:'id',	
		border:false,
		singleSelect:true,
		remoteSort: false,
		onLoadSuccess:function(data){
			if($('#group_selectId option').length == 0){
				createGroupSelect(data.group);
			}
			initHelpBtn();
			doCellTipShow('sjydQueryDataTab');
		},
		onClickCell:function(rowIndex, field, value){
			if(field == 'ydmc'){			
				var rows = $('#sjydQueryDataTab').datagrid('getRows');
				viewYjInfo(rows[rowIndex]);
				$('#sjydQueryDataTab').datagrid('unselectRow',rowIndex);
			}
		},
		toolbar:[{
			text:'刷新',
			iconCls:'icon-reload',
			handler:function(){
				querySjyd();
			}
		}
		<s:if test="${view == 'false'}">
		,'-',{
			text:'分配给审计事项',
			id:'fpsjsx',
			iconCls:'icon-edit',
			handler:function(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${projectId }'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							var rows = $('#sjydQueryDataTab').datagrid('getSelections');
							if(rows.length == 0){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:'请选择记录！',
									timeout:5000,
									showType:'slide'
								});
							}else{
								var row =  $('#sjydQueryDataTab').datagrid("getSelected");
								var YDLY = row.ydly;
								if(YDLY == "用户新增"){
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'该关注点是用户新增，不允许重新分配审计事项！',
										timeout:5000,
										showType:'slide'
									});
								}else{
									try {
										if($('#atTree').tree('getRoot')){
											if(row.isAssign == '未分配'){
												if(row.doubt_status == '050' || row.doubt_status == '055') {
													window.parent.$.messager.show({
														title:'提示信息',
														msg:'已处理的关注点，不能再次重新分配审计事项！',
														timeout:5000,
														showType:'slide'
													});
												} else {
													$('#atTreeWrap').window('open');
												}
											}else{
												window.parent.$.messager.show({
													title:'提示信息',
													msg:'已分配的关注点，在取消分配后才能再次重新分配审计事项！',
													timeout:5000,
													showType:'slide'
												});
											}
										}else{
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'当前项目还没有创建实施方案， 无法进行关注点分配！',
												timeout:5000,
												showType:'slide'
											});
										}
									}catch(e){
										window.parent.$.messager.show({
											title:'提示信息',
											msg:'当前项目还没有创建实施方案， 无法进行关注点分配！',
											timeout:5000,
											showType:'slide'
										});
									}
								}
													 
							}
						}else{
							window.parent.$.messager.show({
								title:'提示信息',
								msg:'您不是项目组成员，不能进行操作！',
								timeout:5000,
								showType:'slide'
							});
						}
					},
					error:function(){
					}
				});
				
			}
		}
		,'-',{
			text:'取消分配',
			id:'quxfp',
			iconCls:'icon-cancel',
			handler:function(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${projectId }'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							var rows = $('#sjydQueryDataTab').datagrid('getSelections');
							if(rows.length == 0){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:'请选择记录！',
									timeout:5000,
									showType:'slide'
								});
							}else{
								var row =  $('#sjydQueryDataTab').datagrid("getSelected");
								var YDLY = row.ydly;
								if(YDLY == "用户新增"){
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'该关注点是用户新增，不允许取消分配！',
										timeout:5000,
										showType:'slide'
									});
								}else{
									if(row.doubt_status == '050' || row.doubt_status == '055') {
										window.parent.$.messager.show({
											title:'提示信息',
											msg:'已处理的关注点，不允许取消分配！',
											timeout:5000,
											showType:'slide'
										});
									} else {
										var ydbmArr = [];
										$.each(rows, function(i, row){
											row.isAssign != '未分配' ? ydbmArr.push("'"+row.ydbm+"'") : null;
										});
										if(ydbmArr && ydbmArr.length == 0){
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'请选择已分配的关注点，未分配的关注点不需要进行此操作！',
												timeout:5000,
												showType:'slide'
											});
										}else{
											cancelAssignedSjyd(ydbmArr.join(','),$('#projectId').val());
										}
									}
								}
							}
						}else{
							window.parent.$.messager.show({
								title:'提示信息',
								msg:'您不是项目组成员，不能进行操作！',
								timeout:5000,
								showType:'slide'
							});
						}
					},
					error:function(){
					}
				});
				
			}
		}
		/*,'-',{
			text:'新增',
			id:'xzsjyd',
			iconCls:'icon-add',
			handler:function(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${projectId }'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							window.location.href="/ais/operate/doubt/editDoubt.action?owner=true&type=FX&from=risk&owner=true&project_id=${projectId }&taskId=-1&taskPid=-1";
						}else{
							alert("您不是项目组成员，不能进行操作！");
						}
					},
					error:function(){
					}
				});
			}
		},'-',{
			text:'编辑',
			id:'bjsjyd',
			iconCls:'icon-edit',
			handler:function(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${projectId }'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							var rows = $('#sjydQueryDataTab').datagrid('getSelections');
							if(rows.length == 0){
								$.messager.alert('提示信息','请选择记录！', 'error');
							}else{
								if(rows.length>1  ){
									$.messager.alert('提示信息','只能选择一条记录！', 'error');
								}else{
									var row =  $('#sjydQueryDataTab').datagrid("getSelected");
									var doubtID = row.id;
									var YDLY = row.ydly;
									if(YDLY == "用户新增"){
										window.location.href="/ais/operate/doubt/editDoubt.action?owner=true&type=FX&from=risk&doubt_id="+doubtID+"&project_id=${projectId }&taskId=-1&taskPid=-1&ydqjQ=${ydqjQ}&ydqjZ=${ydqjZ}";
									}
									else{
										$.messager.alert('提示信息','该疑点来自疑点库，不允许编辑！', 'error');
									}
								}					
							}
						}else{
							alert("您不是项目组成员，不能进行操作！");
						}
					},
					error:function(){
					}
				});
				
				
			}
		},'-',{
			text:'删除',
			id:'scsjyd',
			iconCls:'icon-remove',
			handler:function(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${projectId }'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							var rows = $('#sjydQueryDataTab').datagrid('getSelections');
							if(rows.length == 0){
								$.messager.alert('提示信息','请选择记录！', 'error');
							}else{
								if(rows.length>1){
									$.messager.alert('提示信息','只能选择一条记录！', 'error');
								}else{
									var row =  $('#sjydQueryDataTab').datagrid("getSelected");
									var doubtID = row.id;
									var YDLY = row.ydly;
									if(YDLY == "用户新增"){
										window.location.href="/ais/operate/doubt/delete.action?owner=true&type=FX&from=risk&doubt_id="+doubtID+"&project_id=${projectId }&taskId=-1&taskPid=-1";
									}
									else{
										$.messager.alert('提示信息','该疑点来自疑点库，不允许删除！', 'error');
									}
								}					            
							}
						}else{
							alert("您不是项目组成员，不能进行操作！");
						}
					},
					error:function(){
					}
				});
				
			}
		}*/
		</s:if>
			,'-',helpBtn
		],
		frozenColumns:[[
   			/*{field:'id'  ,title:'选择',width:'50px', checkbox:true, align:'center'},*/
   			{field:'ydbm',title:'关注点编码',width:'120px',halign:'center', sortable:true},
   			{field:'ydmc',
   			title:'关注点名称',
   			//width:'150px',
   			align:'left',
   			sortable:true,
   			formatter:function(value,rowData,rowIndex){
   				return "<a href='javascript:void(0);'>"+value+"</a>";
   			}}
		]],
		columns:[[   

			{field:'ydqjQ',
			 title:'关注点开始时间',
			 //width:'100px', 
			 sortable:true, 
			 align:'center', 
			 formatter:function(value,rowData,rowIndex){
				return value && value.length > 10 ? value.substring(0,10) :value;
			}},
			{field:'ydqjZ',
				 title:'关注点结束时间',
				 //width:'100px', 
				 align:'center', 
				 sortable:true, 
				 formatter:function(value,rowData,rowIndex){
					return value && value.length > 10 ? value.substring(0,10) :value;
				}},
            {field:'bsjdwMc',title:'被审计单位',width:'200px', sortable:true},
			{field:'ydnr',   title:'关注点内容',  width:'150px', sortable:true,align:'left',hidden:true},
			{field:'doubt_statusName',title:'处理状态',width:'100px',align:'center', sortable:true},
			{field:'isAssign',
                title:'是否分配',
                //width:'100px',
                sortable:true,
                align:'center'},
			{field:'assignForSjsx',
                title:'分配给审计事项',
                //width:'150px',
                sortable:true,
                align:'left'},
            {field:'ydly',    title:'关注点来源',
              //width:'100px',
              align:'left', sortable:true,hidden:true},
            {field:'wtlbMc',  title:'问题类别',
              //width:'100px',
              align:'left', sortable:true}, 
            {field:'zcfgMc',  title:'政策法规依据',
              width:'300px',
              align:'left', sortable:true},
			{field:'ydfxrMc', title:'关注点发现人',
			  //width:'100px',
			  align:'center',sortable:true},
			/* {field:'fj',      title:'附件',
			  //width:'100px',
			  align:'center',hidden:'true'},
			{field:'fileList',title:'附件列表',
			  //width:'100px',
			  align:'center',hidden:'true'}, */
			{field:'tjrq',
				 title:'提交日期',
				 //width:'110px', 
				 align:'center', 
				 sortable:true, 
				 formatter:function(value,rowData,rowIndex){
					return value && value.length > 10 ? value.replace('T',' ') :value;
				}}
		]]   
	});
	//单元格tooltip提示
	//alert('${view}'); 预览状态
	if(${view eq 'view'}){
		$('#fpsjsx').hide();
		$('#quxfp').hide();
		$('#xzsjyd').hide();
		$('#bjsjyd').hide();
		$('#scsjyd').hide();
		$('.datagrid-btn-separator').hide();
	}
	
	// 加载审计事项树
	loadSjsxTree();
}

//加载审计事项树
function loadSjsxTree(){	
	$.ajax({
		url : "<%=request.getContextPath()%>/adl/getAuditTaskTree.action",
		dataType:'json',
		cache:false,
		data:{'projectId':$('#projectId').val()},
		success:function(data){
			//alert(object2string(data.atTreeJson) +',  type='+data.type)
			if(data.type=='success'){
				var treeData = data.atTreeJson;
				$('#atTree').tree({
					lines:true,
					data:treeData,
					onDblClick:function(node){
						$('#sureAtTree').trigger('click');
					}
				}); 
			}else{
				window.parent.$.messager.show({
					title:'提示信息',
					msg:data.msg,
					timeout:5000,
					showType:'slide'
				});
			}
		}
	})
}

// 查询审前关注点
function querySjyd(){
	$.ajax({
		dataType:'json',
		url : "<%=request.getContextPath()%>/adl/querySjyd.action",
		data: {
			'queryAd.bsjdwDm':$('#queryAd_bsjdwDm').val(),
			'queryAd.ydqjQ':formatDate2String($('#queryAd_ydqjQ').val()),
			'queryAd.ydqjZ':formatDate2String($('#queryAd_ydqjZ').val()),
            'projectId':$('#projectId').val()
		},
		cache:false,
		type: "post",
		success: function(data){
			//alert($('#lrsjyd_form').serialize());
			if(data.type == 'success'){
				// 加载返回的数据，生成table					
				$('#sjydQueryDataTab').datagrid('loadData',data);
                // 加载审计分组
                createGroupSelect(data.group);
			}else{
				window.parent.$.messager.show({
					title:'提示信息',
					msg:data.msg,
					timeout:5000,
					showType:'slide'
				});
			}	
		},
		error:function(data){
			window.parent.$.messager.show({
				title:'提示信息',
				msg:'请求失败！',
				timeout:5000,
				showType:'slide'
			});
		}
	});
}

// 格式化日期
function formatDate2String(str){
	if(str){
		var d = new Date(str);
		return d.getYear()+'-'+parseInt(d.getMonth()+1)+'-'+d.getDate();
	}
	return "";
}

// 查询已经信息 
function viewYjInfo(rowData){
	if(rowData){
		 var winH = document.documentElement.clientHeight || document.body.clientHeight;
		 var winW = document.documentElement.clientWidth || document.body.clientWidth;
	    $('#lrsjyd_div').window({   
			width:winW,   
			height:winH,   
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false
		});
		//$('#lrsjyd_div').window('open');
		//alert(rowData['fileList'])
		for(var p in rowData){
           $('*[name=view_'+p+']').html(rowData[p]);		
		}
        // 设置附件列表
        var fjGuid = rowData.fj;
        //alert('fjGuid='+fjGuid) 
        if(fjGuid){
            $('#view_files').fileUpload('property', 'fileGuid', fjGuid); 
            $('#view_files').fileUpload('reloadFile');
        }
		window.setTimeout(function(){
			$('#zcfgMc').focus();
		},0);
	}
}

// 根据关注点代码和当前项目id查询所分配给的审计事项
function getSjsxBySjydBm(id,curprojectId){
	var taskName = '';
    if(id){
        $.ajax({
            dataType:'json',
            url : "<%=request.getContextPath()%>/adl/getSjsxBySjydBm.action",
            data: { 'ydbm':id,
                    'curprojectId':curprojectId},
            cache:false,
            async:false,
            type: "post",
            success: function(data){
                if(data.type == 'success'){
                    taskName = data.sjsx.taskName;			                   
                }	
            }
        });
    }
    return taskName;
}

// 取消已分配的审前关注点
function cancelAssignedSjyd(ydbm,curprojectId){
    if(ydbm){
        $.ajax({
            dataType:'json',
            url : "<%=request.getContextPath()%>/adl/cancelAssignedSjyd.action",
            data: { 'ydbm':ydbm,
                    'curprojectId':curprojectId},
            cache:false,
            type: "post",
            success: function(data){
                window.parent.$.messager.show({
    				title:'提示信息',
    				msg:data.msg,
    				timeout:5000,
    				showType:'slide'
    			});
                if(data.type != 'error'){
                    querySjyd();
                }
            }
        });
    }
}


//json 转化成 string 递归对象的各个属性，形成string串
function object2string(o){
	 try {
	     var r = [];
	     // 如果为字符串string，则返回
	     if (typeof o == "string" || o == null) {
	         var tmpArr = new Array();
	         tmpArr.push("'");
	         tmpArr.push(o);
	         tmpArr.push("'");
	         return tmpArr.join("");
	     }else if (typeof o == "number" || typeof o == "boolean" || typeof o == "function" || o == null) {
	         var tmpArr = new Array();
	         tmpArr.push(o);
	         return tmpArr.join("");
	     }
	     //如果对object对象，则遍历object的元素
	     if (o) {
	         var objType = jQuery.type(o);
	         if (objType === "object") {
	             r[0] = "{"
	             for (var i in o) {
	                 r[r.length] = i;
	                 r[r.length] = ":";
	                 r[r.length] = object2string(o[i]);
	                 r[r.length] = ",";
	             }
	             r[r.length - 1] = "}";
	         } else if (objType === "array") {
	             r[0] = "["
	             for (var i = 0; i < o.length; i++) {
	                 r[r.length] = object2string(o[i]);
	                 r[r.length] = ",";
	             }
	             r[r.length - 1] = "]"
	         }
	         return r.join("");
	     }
	     return o.toString();
	 } catch (e) {
	     //oException.show("object2string()", e);
	 }
}

	// 构造审计分组下拉
	function createGroupSelect(json){
		var obj = $('#group_selectId');	       
		if(json && obj){
			obj.html('');
			//obj.append("<option><font color='gray'>-请选择-</font></option>");
			for(var p in json){
				var node = json[p];              
                obj.append("<option value='"+node.groupId+"' mc='"+node.groupName+"'>"+node.groupName+"</option>");
			}
		}
	}
	
</script>

</head>
<body>
	<input type='hidden'   id='queryAd_bsjdwDm'  name='queryAd.bsjdwDm' value='${queryAd.bsjdwDm }'/>
	<input type='hidden'   id='queryAd_ydqjQ'    name='queryAd.ydqjQ'   value='${queryAd.ydqjQ }'/>
	<input type='hidden'   id='queryAd_ydqjZ'    name='queryAd.ydqjZ'   value='${queryAd.ydqjZ }'/>
	<input type='hidden'   id='projectId'        name='projectId'       value='${projectId }'/>
	<div style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true" border="0">
		<div region="center" id='sjydQueryDataDiv' border="0">
			<table id="sjydQueryDataTab"></table>
		</div> 
	</div>
	
	 <!-- 审计事项树(单选,双击选择） -->
	 <div id='atTreeWrap' title='关注点分配，请选择审计事项（单击选择 或者 双击分配关注点）' style='text-align:center;overflow:hidden;'>
	 	<ul id='atTree' style='height:413px; width:686px;text-align:left;border-bottom:1px solid #cccccc; padding:10px;overflow:auto;'></ul>
	 	<div style='padding:5px;text-align:left;height:35px; width:670px;border:1px solid #cccccc;overflow:hidden;display:none'>
            <label>审计分组</label>
            <label style='padding:4px 0px 0px 10px;line-height:25px;'><select id='group_selectId'></select></label>
        </div>
        <div style='padding:5px; text-align:right;'>
	 		<button id='sureAtTree'  class="easyui-linkbutton" iconCls="icon-save">分配</button>&nbsp;&nbsp;
	 		<button id='clearAtTree' class="easyui-linkbutton" iconCls="icon-cancel">退出</button> 			
	 	</div>
	 </div>
	
     <div id="lrsjyd_div" title="关注点信息" style='overflow:auto;padding:0px;'>
     		<form id='lrsjyd_form' name='sjsx_form' method="POST" style='overflow:auto;' >
		        <table class="ListTable" align="center"  style='width:100%;'>
		        	<tr>
		        		<td class='EditHead' style='text-align:right;width:150px;'>关注点名称</td>
		        		<td class='editTd'   style='width:250px;'>
		        			<label id='ydmc' name='view_ydmc'></label>
		        		</td>	        		
		        		<td class='EditHead' style='text-align:right;width:160px;'>关注点编码</td>
		        		<td class='editTd'   style='width:250px;'>
		        			<label id='ydbm' name='view_ydbm' ></label>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class='EditHead'>关注点期间</td>
		        		<td class='editTd'>
		        			<label id='ydqjQ'  name='view_ydqjQ'></label>至<label id='ydqjZ'  name='view_ydqjZ'></label>
		        		</td>
		        		<td class='EditHead'>是否分配</td>
		        		<td class='editTd'>
		        			<label id='isAssign'  name='view_isAssign'></label>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class='EditHead' nowrap style='width:150px;'>分配给审计事项</td>
		        		<td class='editTd' colSpan='3'>
		        			<label id='assignForSjsx'  name='view_assignForSjsx' ></label>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class='EditHead' >被审计单位</td>
		        		<td class='editTd'  colspan=3>
		        			<label id='bsjdwMc' name='view_bsjdwMc' ></label>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class='EditHead' >问题类别</td>
		        		<td class='editTd'  colspan=3 style='padding:3px;'>
		        			<label   id='wtlbMc' name='view_wtlbMc' ></label>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class='EditHead' >政策法规依据</td>
		        		<td class='editTd' colspan=3 style='padding:3px;'>
		        			<textarea id='zcfgMc' name='view_zcfgMc' class="noborder" onfocus='this.blur();' readonly='readonly' style='border-width:0px;width:100%;height:65px'></textarea>
		        		</td>
		        	</tr>
		        	
		        	<tr style='height:50px;'>
		        		<td class='EditHead' >关注点内容（限1000字以内）</td>
		        		<td class='editTd'  colspan=3 style='padding:5px;'>
		        			<label  id='ydnr'  name='view_ydnr'></label>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class='EditHead' >关注点发现人</td>
		        		<td class='editTd'  >
		        			<label   id='ydfxrMc' name='view_ydfxrMc'></label>
		        		</td>
		        		<td class='EditHead' >提交日期</td>
		        		<td class='editTd'>
		        			<label id='tjrq' name='view_tjrq'></label>
		        		</td>
		        	</tr>
		        	<tr height='80px;'>
						<td class="EditHead" nowrap>附件</td>
						<td class="editTd" colspan='3' style='padding:5px;'>
		                    <div id="view_files" class="easyui-fileUpload" style="overflow-x:hidden;"
		                    data-options="fileGridTitle:'',callbackGridHeight:220,fileGuid:0,isAdd:false, isDel:false, isEdit:false" ></div> 
						</td>
		        	</tr>
		        </table>
     		</form>
    		 <div style='text-align:right;padding:10px;' id='exportBtnDiv'>
       			<button  id='closeWinSjyd' class="easyui-linkbutton" iconCls="icon-cancel">退出</button>							        
	     	</div>
     </div>
</body>
</html>