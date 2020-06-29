<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<title>我的事项</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
	
	<!-- 引入EasyUI的js -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<style type="text/css">
		.datagrid-header td, .datagrid-body td, .datagrid-footer td {
			padding: 0px !important;
		}
	</style>
	<script type="text/javascript">
	
	$(function(){
		var tabTiles = ['审计底稿','审计疑点','审计问题','审计事项'];
		$.each(tabTiles, function(a, title){
			var gridId = 'operate-task-detail-list-'+(a+1);
			$('#mytasktab').tabs('add',{
				title:title,
				closable:false,
				cache:false,
				tools:[{    
		            iconCls:'icon-mini-refresh',    
		            handler:function(){    
		            	 $('#'+gridId).datagrid('reload');
		            }    
		        }],
				content:"<table id='"+gridId+"'></table>"
			});			
		});
        $('#mytasktab').tabs('select',0);
	});
	
	
		<%
			response.setHeader("Pragma", "no-cache");  
			response.setHeader("Cache-Control", "no-cache");  
			response.setDateHeader("Expires", 0);
			String owner = "-owner";
			String ownerStr = "true";
		%>
		<%String right=request.getParameter("isView");%>
		
		//关闭导出底稿窗口
		function close_win(){
   			$('#manuTemplateDiv').window('close');  
   		}
		
		//查看审计问题
        function viewLedgerOwner(ledId){
			var row = ledId ? {'id':ledId} : $('#operate-task-detail-list-3').datagrid('getSelected');
			if(row){
				var id = row.id;
				var temp = '${contextPath}/proledger/problem/view.action?ledId='+id+'&id='+id;
				window.parent.addTab('tabs','查看问题','tempframeViewProblem',temp,true);
			}else{
				$.messager.show({
					title:'提示信息',
					msg:'没有选中行！',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
        }

		//恢复疑点状态为未处理
        function inDoubtOwner(){
			var rows = $('#operate-task-detail-list-2').datagrid('getChecked');
			if(rows.length == 1){
				var doubt_author_code = rows[0].doubt_author_code;
				var doubt_status = rows[0].doubt_status;
				var doubt_manu = rows[0].doubt_manu;
				var id = rows[0].doubt_id;
				var checkCode='0';
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
				{namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' },
				{'checkStatus':'050','doubt_id':id},xxx);
			    function xxx(data){
					checkCode =data['checkCode'];
			    }

			    if(checkCode=='1'){

			    }else{
					$.messager.show({
						title:'提示信息',
						msg:'不能恢复,疑点未处理或已删除,请刷新数据后重新操作!',
						timeout:5000,
						showType:'slide'
					});
					return false;
			    }
				$.messager.confirm('恢复疑点','确认恢复疑点吗?',function(r){
					if (r){
						$.ajax({
							type: "POST",
							dataType:'json',
							url : '${pageContext.request.contextPath}/operate/doubtExt/doubtInEasyUI.action',
							data:{
								'audDoubt.doubt_id':id,
								'audDoubt.doubt_status':'010'
							},
							success: function(data){
								if(data.type == 'recover'){
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'操作成功',
										timeout:5000,
										showType:'slide'
									});
									window.close();
									window.location.reload();
								}else{
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'操作失败',
										timeout:5000,
										showType:'slide'
									});
								}
							},
							error:function(data){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:'请求失败',
									timeout:5000,
									showType:'slide'
								});
							}
						});
					}
				});
    		}else{
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
        }

		//处理审计疑点
		function outDoubtOwner(){
			var rows = $('#operate-task-detail-list-2').datagrid('getChecked');
			if(rows.length == 1){
				var doubt_author_code = rows[0].doubt_author_code;
				var doubt_status = rows[0].doubt_status;
				var doubt_manu = rows[0].doubt_manu;
				var id = rows[0].doubt_id;
				if('010'==doubt_status){
					var checkCode='0';
					DWREngine.setAsync(false);
					DWRActionUtil.execute(
					{ namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' },
					{'checkStatus':'010','doubt_id':id},xxx);
					function xxx(data){
						checkCode =data['checkCode'];
					}

					if(checkCode=='1'){
					}else{
						$.messager.show({
							title:'提示信息',
							msg:'不能处理,疑点已处理或已删除,请刷新数据后重新操作!',
							timeout:5000,
							showType:'slide'
						});
						return false;
					}

				}else{
					$.messager.show({
						title:'提示信息',
						msg:'已经是已处理状态!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}

				$.messager.confirm("录入无问题原因","是否录入处理无问题原因?\n点‘确定’按钮录入处理无问题原因，点‘取消’按钮直接处理疑点。",function(r){
					if(r){
						var title = "录入处理无问题原因";
						var myurl = '${contextPath}/operate/doubt/editDoubtReason.action?owner=true&chuli=1&doubt_id='+id;
						$("#outDoubtOwnerFrame").attr("src",myurl);
						$('#outDoubtOwnerDiv').window('open');
						//showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?chuli=1&doubt_id='+id,600,400,title);
					}else{
						$.messager.confirm('处理疑点','确认处理疑点吗?',function(r){
							if (r){
								$.ajax({
									type: "POST",
									dataType:'json',
									url : "${pageContext.request.contextPath}/operate/doubtExt/doubtInEasyUI.action",
									data:{
										'audDoubt.doubt_id':id,
										'audDoubt.doubt_status':'050'
									},
									success: function(data){
										if(data.type == 'dispose'){
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作成功',
												timeout:5000,
												showType:'slide'
											});
											window.close();
											window.location.reload();
										}else{
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作失败',
												timeout:5000,
												showType:'slide'
											});
										}
									},
									error:function(data){
										window.parent.$.messager.show({
											title:'提示信息',
											msg:'请求失败',
											timeout:5000,
											showType:'slide'
										});
									}
								});
							}
						});
					}
				});

			}else{
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
		}

		//删除疑点
        function delDoubtOwner(){
     		var rows = $('#operate-task-detail-list-2').datagrid('getChecked');
     		var doubt_author_code = rows[0].doubt_author_code;
      		var doubt_status = rows[0].doubt_status;
      		var id = rows[0].doubt_id;
			if('010'==doubt_status){
				var checkCode='0';
	            DWREngine.setAsync(false);
		        DWRActionUtil.execute(
		        {namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' },
		        {'checkStatus':'010','doubt_id':id},xxx);
		        function xxx(data){
					checkCode =data['checkCode'];
		        }

		        if(checkCode=='1'){

		        }else{
					$.messager.show({
						title:'提示信息',
						msg:'不能删除,疑点已处理或已删除,请刷新数据后重新操作!',
						timeout:5000,
						showType:'slide'
					});
					return false;
		        }
			}else{
				$.messager.show({
					title:'提示信息',
					msg:'已处理状态不能删除!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			$.messager.confirm('删除疑点','确认删除疑点吗?',function(r){
				if (r){
					$.ajax({
						type: "POST",
						dataType:'json',
						url : "${pageContext.request.contextPath}/operate/doubtExt/doubtDelEasyUI.action",
						data:{
							'audDoubt.doubt_id':id
						},
						success: function(data){
							if(data.type == 'yes'){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:'操作成功',
									timeout:5000,
									showType:'slide'
								});
								window.close();
								window.location.reload();
							}else{
								window.parent.$.messager.show({
									title:'提示信息',
									msg:'操作失败',
									timeout:5000,
									showType:'slide'
								});
							}
						},
						error:function(data){
							window.parent.$.messager.show({
								title:'提示信息',
								msg:'请求失败',
								timeout:5000,
								showType:'slide'
							});
						}
					});
				}
			});
    	}

		//批量删除疑点
		function batchDelDoubtOwner(){
			var selectedRows = $('#operate-task-detail-list-2').datagrid('getChecked');
		    var str = "";
		    var myDoubt = new Array()

			if(selectedRows.length==0){
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作！',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
		    if(selectedRows.length==1){//一条数据，走单独删除
				delDoubtOwner();
		    }else{
				for(i=0;i <selectedRows.length;i++){

					var doubt_author_code = selectedRows[i].doubt_author_code;
					var doubt_status = selectedRows[i].doubt_status;

					var project_id = selectedRows[i].project_id;

					var id = selectedRows[i].doubt_id;

				    if(selectedRows[i].doubt_status=='010'){
					    var checkCode='0';
					    DWREngine.setAsync(false);
						DWRActionUtil.execute(
					    {namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' },
					    {'checkStatus':'010','doubt_id':id},xxx);
					    function xxx(data){
							checkCode =data['checkCode'];
					    }

					    if(checkCode=='1'){

					    }else{
							$.messager.show({
								title:'提示信息',
								msg:'所选取的疑点 ['+selectedRows[i].doubt_name+'] 不能删除,疑点已处理或已删除,请刷新数据后重新操作!',
								timeout:5000,
								showType:'slide'
							});
							return false;
						}
				    }else{
						$.messager.show({
							title:'提示信息',
							msg:'所选取的疑点 ['+selectedRows[i].doubt_name+'] 已处理状态不能删除!',
							timeout:5000,
							showType:'slide'
						});
						return false;
				    }

				}
				$.messager.confirm('删除疑点','确认删除疑点吗?',function(r){
					if (r){
						for(i=0;i <selectedRows.length;i++){
							str += selectedRows[i].doubt_id + ",";
							myDoubt[i]=selectedRows[i].doubt_id;
							var j=i+1;
							var delTip='false';
							if(j==selectedRows.length){
								$.ajax({
									type: "POST",
									dataType:'json',
									url : "${pageContext.request.contextPath}/operate/doubtExt/doubtDelEasyUI.action",
									data:{
										'audDoubt.doubt_id':myDoubt[i]
									},
									success: function(data){
										if(data.type == 'yes'){
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作成功',
												timeout:5000,
												showType:'slide'
											});
											window.close();
											window.location.reload();
										}else{
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作失败',
												timeout:5000,
												showType:'slide'
											});
										}
									},
									error:function(data){
										window.parent.$.messager.show({
											title:'提示信息',
											msg:'请求失败',
											timeout:5000,
											showType:'slide'
										});
									}
								});

							}else{
								$.ajax({
									type: "POST",
									dataType:'json',
									url : "${pageContext.request.contextPath}/operate/doubtExt/doubtDelEasyUI.action",
									data:{
										'audDoubt.doubt_id':myDoubt[i]
									},
									success: function(data){
										if(data.type == 'yes'){
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作成功',
												timeout:5000,
												showType:'slide'
											});
											window.close();
											window.location.reload();
										}else{
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作失败',
												timeout:5000,
												showType:'slide'
											});
										}
									},
									error:function(data){
										window.parent.$.messager.show({
											title:'提示信息',
											msg:'请求失败',
											timeout:5000,
											showType:'slide'
										});
									}
								});
							}

						}
					}
				});

		    }

		}

		//编辑疑点
		function editDoubtOwner(groupCode,project_id,taskId,taskPid,doubt_author_code,doubt_status,doubt_id){
			if(isGoOn()){
				return false;
			}
			/* var rows = $('#operate-task-detail-list-2').datagrid('getChecked');
			if(rows.length == 1){
				var doubt_author_code = rows[0].doubt_author_code;
				var doubt_status = rows[0].doubt_status;
				var doubt_id = rows[0].doubt_id; */
				if('010'==doubt_status){
					var checkCode='0';
					DWREngine.setAsync(false);
				    DWRActionUtil.execute(
				    { namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' },
				    {'checkStatus':'010','doubt_id':doubt_id},xxx);
				    function xxx(data){
					  checkCode =data['checkCode'];
				    }
				    if(checkCode=='1'){

				    }else{
						$.messager.show({
							title:'提示信息',
							msg:'不能修改,疑点已处理或已删除,请刷新数据后重新操作!',
							timeout:5000,
							showType:'slide'
						});
						return false;
				    }
				}else{
					$.messager.show({
						title:'提示信息',
						msg:'已处理状态不能修改!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
				//初始化审计疑点表格时调用
				if(typeof (groupCode) == 'undefined' && typeof (project_id) == 'undefined' && typeof (taskId) == 'undefined' && typeof (taskPid) == 'undefined'){
					var temp = '${contextPath}/operate/doubt/editDoubt.action?owner=true&groupCode=${groupCode}&type=FX&doubt_id='+doubt_id+'&project_id=${project_id}&taskId=${taskId}&taskPid=${taskPid}';
					window.parent.addTab('tabs','编辑疑点','tempframeEditDoubt',temp,true);
				}
				//重新生成审计疑点表格时调用
				else{
					var temp = '${contextPath}/operate/doubt/editDoubt.action?owner=true&groupCode='+groupCode+'&type=FX&doubt_id='+doubt_id+'&project_id='+project_id+'&taskId='+taskId+'&taskPid='+taskPid;
					window.parent.addTab('tabs','编辑疑点','tempframeEditDoubt',temp,true);
				}
			/* }else{
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			} */
		}

		//增加疑点
		function addDoubtOwner(groupCode,project_id,taskId,taskPid){
			var rows = $('#operate-operate_item_list<%=owner%>').treegrid('getData');
			if(rows[0].taskName=='没有给您分配任务'){
				$.messager.show({
					title:'提示信息',
					msg:'没有给您分配任务，不能新增疑点',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			if(isGoOn()){
				return false;
			}

            var row = $('#operate-operate_item_list<%=owner%>').treegrid('getSelected');
            var taskId = row.taskTemplateId;
            var taskName = row.taskName;
            var project_id = "${project_id}";
            var groupCode = row.groupCode;
            var taskPid = row.taskPid;
            var auditObject = row.auditObject;

			//初始化审计疑点表格时调用
			if(typeof (groupCode) == 'undefined' && typeof (project_id) == 'undefined' && typeof (taskId) == 'undefined' && typeof (taskPid) == 'undefined' && typeof (auditObject) == 'undefined'){
				var temp = '${contextPath}/operate/doubt/editDoubt.action?owner=true&groupCode=${groupCode}&type=FX&project_id=${project_id}&taskId=${taskId}&taskPid=${taskPid}&auditObject=${auditObject}';
				window.parent.addTab('tabs','增加疑点','tempframeAddDoubt',temp,true);
			}
			//重新生成审计疑点表格时调用
			else{
				var temp = '${contextPath}/operate/doubt/editDoubt.action?owner=true&groupCode='+groupCode+'&type=FX&project_id='+project_id+'&taskId='+taskId+'&taskPid='+taskPid+'&auditObject='+auditObject;
				window.parent.addTab('tabs','增加疑点','tempframeAddDoubt',temp,true);
			}
		}

		//查看疑点
		function viewDoubtOwner(){
			var rows = $('#operate-task-detail-list-2').datagrid('getChecked');
			if(rows.length == 1){
				var doubt_id = rows[0].doubt_id;
				var temp = '${contextPath}/operate/doubt/view.action?type=YD&doubt_id='+doubt_id;
				window.parent.addTab('tabs','查看疑点','tempframeviewDoubt',temp,true);
			}else{
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
		}

		//导出底稿
		function expManuscript(manuType, manuTypeName){
			// manuType底稿类型  UNITERM-单项底稿，COMPREHENSIVE-综合底稿，不同的类型对应的导出模板不一样
			var selectedRows = $('#operate-task-detail-list-1').datagrid('getChecked');
			if(selectedRows.length==0){
				$.messager.show({
					title:'提示信息',
					msg:'请选择要导出的底稿!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			} 
	/* 		for(i=0;i <selectedRows.length;i++){
				var smanuType = selectedRows[i].manuType;
				if(!(smanuType && manuType && smanuType.toLowerCase() == manuType.toLowerCase())){
					var ms_code = selectedRows[i].ms_code;
					top.$.messager.show({
						title:'提示信息',
						msg:'底稿【'+ms_code+'】不适合【'+manuTypeName+'】导出模板!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
			} */
			manuType = "UNITERM";
			 var manuIdArray=new Array();
			   for(i=0;i <selectedRows.length;i++){
	                var tempformId = selectedRows[i].formId;
	                manuIdArray.push(tempformId);
			   }	 
	        var selectedValue = manuIdArray.join(",");
			 //判断模板数量
	        jQuery.ajax({
					url:'${contextPath}/operate/manuExt/pandManuTem.action?type='+manuType.toLowerCase()+'&project_id='+selectedRows[0].project_id,
					type:'POST',
					dataType:'text',
					async:false,
					success:function(data){
						if(data == 2) {
							// 初始化生成表格
							$('#templateList').datagrid({
								url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type="+manuType.toLowerCase()+"&project_id="+selectedRows[0].project_id,
								method:'post',
								showFooter:false,
								rownumbers:true,
								striped:true,
								autoRowHeight:false,
								fit: true,
								fitColumns:true,
								idField:'id',
								border:false,
								singleSelect:true,
								remoteSort: false,
								columns:[[
									{field:'name',
										title:'模板名称',
										width:200,
										halign:'center',
										align:'left',
										sortable:true
									},
									{field:'operate',
										title:'操作',
										width:100,
										align:'center',
										formatter:function(value,row,index){
											var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\',\''+selectedValue+'\',\''+selectedRows[0].project_name+'\',\''+selectedRows[0].project_id+'\',\''+selectedRows[0].manuType+'\');\">导出</a>';
											return link;
										}
									}
								]]
							});

							$('#templateWindow').window({
								title:'选择审计底稿模板',
								width:600,
								height:400,
								modal:true,
								collapsible:false,
								maximizable:true,
								minimizable:false
							});
						}else if(data == 0){
							showMessage1('请维护对应的模板！');
						}else{
							expManu(data,selectedValue,selectedRows[0].project_name,selectedRows[0].project_id,selectedRows[0].manuType);
						}
					},
					error:function(){
						showMessage1('出错啦！');
					}
			});
		}
		 /*
		 * 创建审计底稿初稿
		 */
		function expManu(templateId,crudId,project_name,project_id,manuType){
			var h = window.screen.availHeight;
			var w = window.screen.width;
			manuType = "COMPREHENSIVE";
			window.showModalDialog("/ais/operate/manuExt/expManu.action?templateId="+templateId+"&form_id="+crudId+"&project_name="+encodeURI(project_name)+"&type="+manuType+"&project_id="+project_id,window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
			 $("#templateWindow").window({"onOpen":function(){
				 $("#templateWindow").window('close');
			 }});
			 location.reload();
		 }
		//批量提交底稿
		function batchSubmitManuOwner(groupCode,project_id,taskId,taskPid){
			var selectedRows = $('#operate-task-detail-list-1').datagrid('getChecked');
			if(selectedRows.length==0){
				$.messager.show({
					title:'提示信息',
					msg:'请选择要提交的底稿!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}                     
			var str = "";
			if(selectedRows.length==1){
				editManuOwner(groupCode,project_id,taskId,taskPid,selectedRows[0].ms_author,selectedRows[0].ms_status,selectedRows[0].formId);
			}else{
				var  manuType = selectedRows[0].manuType;
				for(i=0;i <selectedRows.length;i++){
					var project_id = selectedRows[i].project_id;
					var manuId = selectedRows[i].formId;
					var groupId = selectedRows[i].groupId;
					var authLevel = '';
					var statusNew = '';

					//获取最新底稿状态
					DWREngine.setAsync(false);
					DWRActionUtil.execute(
					{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
					{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
				    function xxx(data){
				    	authLevel =data['url'];
				    	statusNew =data['checkCode'];
				    }
				    if(statusNew!=selectedRows[i].ms_status){
				    	showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 状态发生变化，请刷新数据后重试!');
				    	return false;
				    }
					
					if(selectedRows[i].ms_status=='010'){
				    }else{
						$.messager.show({
							title:'提示信息',
							msg:'所选取的底稿 ['+selectedRows[i].ms_name+'] 不是底稿草稿状态,不能批量提交审批流程,请单独提交!',
							timeout:5000,
							showType:'slide'
						});
						return false;
					}
				/* 	if(manuType != selectedRows[i].manuType){
		            	   $.messager.show({title:'提示信息',msg:'请选择要提交底稿相同类型!'});
				            return;
		               } */
				    str += selectedRows[i].formId + ","; 
				}                                   
				document.getElementsByName('manuIds2')[0].value = str;
				var ttt = document.getElementsByName('manuIds2')[0].value;
               
				var title = "底稿批量提交"; 
				//初始化审计底稿表格时调用
				if(typeof (groupCode) == 'undefined' && typeof (project_id) == 'undefined' && typeof (taskId) == 'undefined' && typeof (taskPid) == 'undefined'){
					var myurl = '${contextPath}/operate/manu/batch.action?owner=true&taskId=${taskId}&isArray=false&is2=true&manuIds2='+ttt;
					$("#batchSubmitManuOwnerFrame").attr("src",myurl);
					$('#batchSubmitManuOwnerDiv').window('open'); 
					//showPopWin('${contextPath}/operate/manu/batch.action?owner=true&taskId=${taskId}&isArray=false&is2=true&manuIds2='+ttt,700,600,title);
				}
				//重新生成审计底稿表格时调用
				else{
					var myurl = '${contextPath}/operate/manu/batch.action?owner=true&taskId='+taskId+'&isArray=false&is2=true&manuIds2='+ttt;
					$("#batchSubmitManuOwnerFrame").attr("src",myurl);
					$('#batchSubmitManuOwnerDiv').window('open'); 
					//showPopWin('${contextPath}/operate/manu/batch.action?owner=true&taskId='+taskId+'&isArray=false&is2=true&manuIds2='+ttt,700,600,title);
				}
			}
   
    	}
		
       //批量提交
   		function close_bat(){
   			$('#batchSubmitManuOwnerDiv').window('close');  
   		
   		}
   		// 刷新
		function reload_bat(){
   			location.reload();
   		}
		// 恢复底稿//该底稿所属小组的组长、副组长、主审有权限恢复该底稿
        function inManuOwner(){
			var rows = $('#operate-task-detail-list-1').datagrid('getChecked');
			if(rows.length == 1){
				var ms_author = rows[0].ms_author;
				var ms_status = rows[0].ms_status;
				var groupId = rows[0].groupId;
				var project_id = rows[0].project_id;
				var manuId = rows[0].formId;
				var authLevel = '';
				var statusNew = '';

				DWREngine.setAsync(false);
				DWRActionUtil.execute(
				{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
				{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
			    function xxx(data){
			    	authLevel =data['url'];
			    	statusNew =data['checkCode'];
			    }

			    if(statusNew!=ms_status){
			    	showMessage1('底稿状态发生变化，请刷新数据后重试！');
			    	return false;
			    }
			    
			    if('060'==ms_status){
					if(authLevel=="0"){
						showMessage1('底稿所属小组的组长、副组长、主审有权限恢复该底稿!');
						return false;
					}
			    }else{
			    	showMessage1('只能恢复已经注销的底稿!');
					return false;
				}
				
				/* if('060'==ms_status){
					DWREngine.setAsync(false);
					DWRActionUtil.execute(
					{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
					{'groupId':groupId,'project_id':project_id},xxx);
					function xxx(data){
						url =data['url'];
					} 
					if(url=="0"){
						$.messager.show({
							title:'提示信息',
							msg:'底稿所属小组的组长、副组长、主审有权限恢复该底稿!',
							timeout:5000,
							showType:'slide'
						});
						return false;
					}else{
					}
				}else{
					$.messager.show({
						title:'提示信息',
						msg:'只能恢复已经注销的底稿!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				} */
				
				var id = rows[0].formId;
				$.messager.confirm('恢复底稿','确认恢复底稿吗?',function(r){    
					if (r){    
						$.ajax({
							type: "POST",
							dataType:'json',
							url : "${pageContext.request.contextPath}/operate/manuExt/manuUpdateEasyUI.action",
							data:{
								'audManuscript.formId':id,
								'audManuscript.ms_status':'050'
							},
							success: function(data){
								if(data.type == 'yes'){
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'操作成功',
										timeout:5000,
										showType:'slide'
									});										
									window.close();
									window.location.reload();
								}else{
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'操作失败',
										timeout:5000,
										showType:'slide'
									});	
								}		
							},
							error:function(data){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:'请求失败',
									timeout:5000,
									showType:'slide'
								});	
							}
						});
					}    
				});
			}else{
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
        }
		
		//底稿注销
		function outManuOwner(){
			var rows = $('#operate-task-detail-list-1').datagrid('getChecked');
			if(rows.length == 1){
				var ms_author = rows[0].ms_author;
				var ms_status = rows[0].ms_status;
				var project_id = rows[0].project_id;
				var manuId = rows[0].formId;
				var groupId = rows[0].groupId;
				var authLevel = '';
				var statusNew = '';
				
				if('${user.floginname}'==ms_author){
				}else{
					$.messager.show({
						title:'提示信息',
						msg:'没有权限注销!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}

				//获取最新底稿状态
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
				{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
				{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
			    function xxx(data){
			    	authLevel =data['url'];
			    	statusNew =data['checkCode'];
			    }
			    if(statusNew!=ms_status){
			    	showMessage1('底稿状态发生变化，请刷新数据后重试！');
			    	return false;
			    }
			    
				if('050'==ms_status){
				}else{
					$.messager.show({
						title:'提示信息',
						msg:'只能注销复核完毕的底稿!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
			  
				var id = rows[0].formId;
				$.messager.confirm('注销底稿','确认注销底稿吗?',function(r){    
					if (r){    
						$.ajax({
							type: "POST",
							dataType:'json',
							url : "${pageContext.request.contextPath}/operate/manuExt/manuUpdateEasyUI.action",
							data:{
								'audManuscript.formId':id,
								'audManuscript.ms_status':'060'
							},
							success: function(data){
								if(data.type == 'yes'){
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'操作成功',
										timeout:5000,
										showType:'slide'
									});
									window.close();
									window.location.reload();
								}else{
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'操作失败',
										timeout:5000,
										showType:'slide'
									});
								}		
							},
							error:function(data){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:'请求失败',
									timeout:5000,
									showType:'slide'
								});
							}
						});
					}    
				});
			}else{
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}			
        }
		
		//删除底稿
		function delManuOwner(){
			var rows = $('#operate-task-detail-list-1').datagrid('getChecked');
			var ms_author = rows[0].ms_author;
			var ms_status = rows[0].ms_status;
			  
			var groupId = rows[0].groupId;
			var project_id = rows[0].project_id;   
							  
			if('010'==ms_status){
				if('${user.floginname}'==ms_author){
				}else{
					window.top.$.messager.show({
						title:'提示信息',
						msg:'没有权限删除！',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
			}else if('060'==ms_status){//请组长和副组长和主审删除
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
				{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
				{'groupId':groupId,'project_id':project_id},xxx);
				function xxx(data){
					url =data['url'];
				} 
				if(url=="0"){
					window.top.$.messager.show({
						title:'提示信息',
						msg:'底稿所属小组的组长、副组长、主审有权限删除该底稿!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}else{
				}
			}else{
				if('050'==ms_status){
					window.top.$.messager.show({
						title:'提示信息',
						msg:'底稿已经复核完毕,不能删除!',
						timeout:5000,
						showType:'slide'
					});
                    return false;
				}else{
					window.top.$.messager.show({
						title:'提示信息',
						msg:'底稿已经进入审批流程,不能删除!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
							
			}

			var id = rows[0].formId;
			$.messager.confirm('删除底稿','确认删除底稿吗?',function(r){    
				if (r){    
					$.ajax({
						type: "POST",
						dataType:'json',
						url : "${pageContext.request.contextPath}/operate/manuExt/manuDelEasyUI.action",
						data:{
							'audManuscript.formId':id
						},
						success: function(data){
							if(data.type == 'yes'){
								window.top.$.messager.show({
									title:'提示信息',
									msg:'操作成功',
									timeout:5000,
									showType:'slide'
								});								
								window.close();
								window.location.reload();
							}else{
								window.top.$.messager.show({
									title:'提示信息',
									msg:'操作失败',
									timeout:5000,
									showType:'slide'
								});
							}		
						},
						error:function(data){
							window.top.$.messager.show({
								title:'提示信息',
								msg:'请求失败',
								timeout:5000,
								showType:'slide'
							});
						}
					});
				}    
			});
		}
		
		//批量删除底稿
		function batchDelManuOwner(){
			var selectedRows = $('#operate-task-detail-list-1').datagrid('getChecked');				
			var str = "";
			var myManu = new Array()

			if(selectedRows.length==0){
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作！',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			/* if(selectedRows.length==1){//一条数据，走单独删除
				delManuOwner();
			}else{ */
				for(i=0;i <selectedRows.length;i++){
				  
					var ms_author = selectedRows[i].ms_author;
					var ms_status = selectedRows[i].ms_status;
					var project_id = selectedRows[i].project_id;
					var manuId = selectedRows[i].formId;
					var groupId = selectedRows[i].groupId;
					var authLevel = '';
					var statusNew = '';

					DWREngine.setAsync(false);
					DWRActionUtil.execute(
					{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
					{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
				    function xxx(data){
				    	authLevel =data['url'];
				    	statusNew =data['checkCode'];
				    }
				    if(statusNew!=ms_status){
				    	showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 状态发生变化，请刷新数据后重试！');
				    	return false;
				    }
				    
				    if(ms_status=='010'){
						if('${user.floginname}'!=ms_author){
							showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 没有权限删除,不能批量删除!');
							return false;
						}
				    }else if(ms_status=='060'){//请组长和副组长和主审删除
						if(authLevel=="0"){
							showMessage1('底稿所属小组的组长、副组长、主审有权限删除该底稿!');
							return false;
						}
				    }else{
				    	showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 不是底稿草稿或者已经注销状态,不能批量删除!');
						return false;
				    }
					
				    /* if(selectedRows[i].ms_status=='010'){
				    }else if(selectedRows[i].ms_status=='060'){//请组长和副组长和主审删除
				   
						var groupId = selectedRows[i].groupId;
					   
						DWREngine.setAsync(false);
						DWRActionUtil.execute(
						{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
						{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
					    function xxx(data){
							url =data['url'];
					    } 
						if(url=="0"){
							$.messager.show({
								title:'提示信息',
								msg:'底稿所属小组的组长、副组长、主审有权限删除该底稿!',
								timeout:5000,
								showType:'slide'
							});
							return false;
						}else{
						}
					}else{
						$.messager.show({
							title:'提示信息',
							msg:'所选取的底稿 ['+selectedRows[i].ms_name+'] 不是底稿草稿或者已经注销状态,不能批量删除!',
							timeout:5000,
							showType:'slide'
						});
						return false;
				   } */
					
				}
				$.messager.confirm('删除底稿','确认删除底稿吗?',function(r){    
					if (r){
						for(i=0;i <selectedRows.length;i++){
							str += selectedRows[i].formId + ","; 
							myManu[i]=selectedRows[i].formId;
							var  j=i+1;
							var delTip='false';
							if(j==selectedRows.length){ 
								$.ajax({
									type: "POST",
									dataType:'json',
									url : "${pageContext.request.contextPath}/operate/manuExt/manuDelEasyUI.action",
									data:{
										'audManuscript.formId':myManu[i]
									},
									success: function(data){
										if(data.type == 'yes'){
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作成功',
												timeout:5000,
												showType:'slide'
											});
											window.close();
											window.location.reload();
										}else{
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作失败',
												timeout:5000,
												showType:'slide'
											});
										}		
									},
									error:function(data){
										window.parent.$.messager.show({
											title:'提示信息',
											msg:'请求失败',
											timeout:5000,
											showType:'slide'
										});
									}
								});
								
							}else{
								$.ajax({
									type: "POST",
									dataType:'json',
									url : "${pageContext.request.contextPath}/operate/manuExt/manuDelEasyUI.action",
									data:{
										'audManuscript.formId':myManu[i]
									},
									success: function(data){
										if(data.type == 'yes'){
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作成功',
												timeout:5000,
												showType:'slide'
											});
											window.close();
											window.location.reload();
										}else{
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'操作失败',
												timeout:5000,
												showType:'slide'
											});
										}		
									},
									error:function(data){
										window.parent.$.messager.show({
											title:'提示信息',
											msg:'请求失败',
											timeout:5000,
											showType:'slide'
										});
									}
								});
									
							}
						}
					}
					 
				});
								  
			//}

    	}
		
		//编辑底稿
		function editManuOwner(groupCode,project_id,taskId,taskPid,ms_author,ms_status,ms_id){
			if(isGoOn()){
				return false;
			}
			/* var rows = $('#operate-task-detail-list-1').datagrid('getChecked');
			if(rows.length == 1){
				var ms_author = rows[0].ms_author;
				var ms_status = rows[0].ms_status;
				var ms_id = rows[0].formId; */
				var url="0";
				if('${user.floginname}'==ms_author){
				}else{
					$.messager.show({
						title:'提示信息',
						msg:'没有权限修改！',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}

				var manuId = ms_id;
				var groupId = groupCode;
				var authLevel = '';
				var statusNew = '';
				//获取最新底稿状态
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
				{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
				{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
			    function xxx(data){
			    	authLevel =data['url'];
			    	statusNew =data['checkCode'];
			    }
			    if(statusNew!=ms_status){
			    	showMessage1('底稿状态发生变化，请刷新数据后重试！');
			    	return false;
			    }
				
				if('010'==ms_status){
					//初始化审计底稿表格时调用
					if(typeof (groupCode) == 'undefined' && typeof (project_id) == 'undefined' && typeof (taskId) == 'undefined' && typeof (taskPid) == 'undefined'){
						var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode=${groupCode}&crudId='+ms_id+'&project_id=${project_id}&taskId=${taskId}&taskPid=${taskPid}&back=true';
						window.parent.addTab('tabs','编辑底稿','tempframeEditManu',temp,true);
					}
					//重新生成审计底稿表格时调用
					else{
						var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode='+groupCode+'&crudId='+ms_id+'&project_id='+project_id+'&taskId='+taskId+'&taskPid='+taskPid+'&back=true';
						window.parent.addTab('tabs','编辑底稿','tempframeEditManu',temp,true);
					}
				}else if('060'==ms_status){
					$.messager.show({
						title:'提示信息',
						msg:'底稿已经注销,不能修改或者提交!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}else{
					if('050'==ms_status){
						/*$.messager.show({
							title:'提示信息',
							msg:'底稿已经复核完毕,不能修改或者提交!',
							timeout:5000,
							showType:'slide'
						});
						return false;*/
						$.messager.confirm("确认对话框","确认修改已复核完毕的底稿吗？",function(r){
							if(r){
								jQuery.ajax({
									url:'${contextPath}/operate/manuExt/updateFormInfoState.action',
									type:'POST',
									data:{'formId':ms_id},
									async:false,
									success:function(data){
										if(data == "1") {
											$('#operate-task-detail-list-1').datagrid('reload');
											//初始化审计底稿表格时调用
											if(typeof (groupCode) == 'undefined' && typeof (project_id) == 'undefined' && typeof (taskId) == 'undefined' && typeof (taskPid) == 'undefined'){
												var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode=${groupCode}&crudId='+ms_id+'&taskInstanceId='+url+'&project_id=${project_id}&taskId=${taskId}&taskPid=${taskPid}&back=true';
												window.parent.addTab('tabs','编辑底稿','tempframeEditManu',temp,true);
											}
											//重新生成审计底稿表格时调用
											else{
												var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode='+groupCode+'&crudId='+ms_id+'&taskInstanceId='+url+'&project_id='+project_id+'&taskId='+taskId+'&taskPid='+taskPid+'&back=true';
												window.parent.addTab('tabs','编辑底稿','tempframeEditManu',temp,true);
											}
										}else{
											showMessage1("更新底稿状态失败！");
										}
									},
									error:function(){
										showMessage1("系统异常！");
									}
								});
							}
						});
					}else{
						DWREngine.setAsync(false);
						DWRActionUtil.execute(
						{namespace:'/operate/manu', action:'getFormUrl', executeResult:'false' }, 
						{'crudId':ms_id},xxx);
						function xxx(data){
							url =data['url'];
						} 
						if(url=="0"){
							$.messager.show({
								title:'提示信息',
								msg:'底稿已经进入审批流程,不能修改或者提交!',
								timeout:5000,
								showType:'slide'
							});
							return false;
						}else{
							//初始化审计底稿表格时调用
							if(typeof (groupCode) == 'undefined' && typeof (project_id) == 'undefined' && typeof (taskId) == 'undefined' && typeof (taskPid) == 'undefined'){
								var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode=${groupCode}&crudId='+ms_id+'&taskInstanceId='+url+'&project_id=${project_id}&taskId=${taskId}&taskPid=${taskPid}&back=true';
								window.parent.addTab('tabs','编辑底稿','tempframeEditManu',temp,true);
							}
							//重新生成审计底稿表格时调用
							else{
								var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode='+groupCode+'&crudId='+ms_id+'&taskInstanceId='+url+'&project_id='+project_id+'&taskId='+taskId+'&taskPid='+taskPid+'&back=true';
								window.parent.addTab('tabs','编辑底稿','tempframeEditManu',temp,true);
							}
						}
					}
				}
			/* }else{
				$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作！',
					timeout:5000,
					showType:'slide'
				});
				return false;
			} */
		} 
		
		//增加底稿
		function addManuOwner(groupCode,project_id,taskId,taskPid){
			var rows = $('#operate-operate_item_list<%=owner%>').treegrid('getData');
			if(rows[0].taskName=='没有给您分配任务'){
				$.messager.show({
					title:'提示信息',
					msg:'没有给您分配任务，不能新增底稿',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			if(isGoOn()){
				return false;
			}
            
            var row = $('#operate-operate_item_list<%=owner%>').treegrid('getSelected');
            var taskId = row.taskTemplateId;
            var taskName = row.taskName;
            var project_id = "${project_id}";
            var groupCode = row.groupCode;
            var taskPid = row.taskPid;
            var auditObject = row.auditObject;
            
			//初始化审计底稿表格时调用
			if(typeof (groupCode) == 'undefined' && typeof (project_id) == 'undefined' && typeof (taskId) == 'undefined' && typeof (taskPid) == 'undefined' && typeof (auditObject) == 'undefined'){
				var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode=${groupCode}&project_id=${project_id}&taskId=${taskId}&taskPid=${taskPid}&back=true&auditObject=${auditObject}';
				window.parent.addTab('tabs','增加底稿','tempframeEditManu',temp,true);
			}
			//重新生成审计底稿表格时调用
			else{
				var temp = '${contextPath}/operate/manu/edit.action?owner=true&groupCode='+groupCode+'&project_id='+project_id+'&taskId='+taskId+'&taskPid='+taskPid+'&back=true&auditObject='+auditObject;
				window.parent.addTab('tabs','审计底稿','tempframeEditManu',temp,true);
			}
		}
		
		function isGoOn(){
			var flag=false;
			jQuery.ajax({
				url:'${contextPath}/operate/manuExt/isGoOn.action',
				type:'POST',
				data:{"project_id":'${project_id}'},
				dataType:'json',
				async:false,
				success:function(data){
					if(data == 2) {
						$.messager.show({
							title:'提示信息',
							msg:'实施方案正在调整，暂不允许登记底稿！',
							timeout:5000,
							showType:'slide'
						});
						flag= true;
					}else{
						flag= false;
					}
				},
				error:function(){
					$.messager.show({
						title:'提示信息',
						msg:'实施方案调整验证出错啦!',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
			});
			return flag;
		}
		
		//底稿反馈
		function feedback(){
			var resullt=''; 
			var s='${project_id}';
			DWREngine.setAsync(false);
			DWRActionUtil.execute(
			{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
			{'project_id':s},xxx);
			function xxx(data){
				result =data['auth'];
			} 

			if(result=='1'){
			}else{
				$.messager.show({
					title:'提示信息',
					msg:'只有组长、副组长和主审有权设置底稿反馈！',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
			var temp = '${contextPath}/operate/manu/feedback.action?project_id=<%=request.getParameter("project_id")%>&taskPid=-1';
			win = window.parent.addTab('tabs','底稿反馈','tempframeFeedback',temp,true);
			
			var h = window.screen.availHeight;
			var w = window.screen.width; 
			win.moveTo(0,0)   
			win.resizeTo(w,h) 
			if(win && win.open && !win.closed) 
				win.focus();
		}
		
		//查看底稿
		function viewManuOwner(formId, project_id){
			var rows = [];
			var projectview="${param.projectview}";
            if(formId && project_id){
                rows = [{
                    'formId' : formId,
                    'project_id':project_id
                }];
            }else{
                rows = $('#operate-task-detail-list-1').datagrid('getChecked');
            }
            
			if(rows.length == 1){
				var formId = rows[0].formId;
				var project_id = rows[0].project_id;
				<% if(!"true".equals(right)){%>
				  if(projectview != 'view'){
					  var temp = '${contextPath}/operate/manu/view.action?crudId='+formId+'&project_id='+project_id; 
				  }else{
					  var temp = '${contextPath}/operate/manu/view.action?view=${param.view}&crudId='+formId+'&project_id='+project_id; 
				  }
					
					
					window.parent.addTab('tabs','查看底稿','tempframeViewManu',temp,true);
				<%}else{%>
				    var temp = '${contextPath}/operate/manu/viewAll.action?crudId='+formId+'&project_id='+project_id;
					window.parent.addTab('tabs','查看底稿','tempframeViewManu',temp,true);
				<% }%>
			}else{
				top.$.messager.show({
					title:'提示信息',
					msg:'请选择一条数据进行操作！',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
		}
		
		//审计事项table上的超链接，审计事项的类型，分为1（事项类别）和2（末级具体事项）
		function task(s,q){
			//审计事项详情表格中显示的事项均为末级具体事项，不会出现（s=='1'）的情形
			if(s=='1'){
				return false;
				var temp = '${contextPath}/operate/task/showContentTypeView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>';
				window.parent.addTab('tabs','查看事项','tempframeViewTask',temp,true);
			}else{
				var temp = '${contextPath}/operate/task/showContentLeafView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>';
				window.parent.addTab('tabs','查看事项','tempframeViewTask',temp,true);
			}
		}
	</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border="0" fit="true">
		<div region="west" style="width:30%;" border="0" split="true" collapsible="true" title="我的事项">
            <div class="easyui-layout" border="0" fit="true">
                 <div region="north" border="0" style="padding:0px;margin:0px;overflow:hidden;display:none;">
                    <table class="ListTable" style="margin-bottom: 5px; margin-left: 5px;">
                        <tr>
<!--                             <td class="EditHead" style="width:30%">审计小组:</td> -->
                            <td class="editTd" style="width:100%">
                                <select id="combox" value="" panelHeight='auto' style="width:90%">
                                    <option value="">　</option>
                                </select>
                            </td>
                        <tr>
                    </table>
                </div> 
                <div region="center" border="0">
                    <table id='operate-operate_item_list<%=owner%>'></table>
                </div>
            </div> 				 		 
	    </div>
		<div region="center" id= "information" border="0">
			<form style="display:none;" id="myform22" name="my_form22" target="_blank" action="/ais/operate/doubt/exportDigao.action?isArray=false&is2=true" method="post" style="">
				<s:hidden name="manuIds2" />
				<s:hidden name="manuArray" />
			</form>
            
            <div id='mytasktab' name='mytasktab' class="easyui-tabs" fit='true' border='0'>
            	<!-- 
                <div title="审计事项">
                    <table id='operate-task-detail-list-4'></table>
                </div>
                <div title="审计疑点">
                    <table id='operate-task-detail-list-2'></table>
                </div>
                <div title="审计问题">
                    <table id='operate-task-detail-list-3'></table>
                </div>
                <div title="审计底稿">
                    <table id='operate-task-detail-list-1'></table>
                </div>
                -->
            </div>
		</div>
		<div id="message">
			<table width="100%" height="100%">
				<tr>
					<td align="center">
						<font size="4" color='#1b6252'>请点击左侧树节点查看审计事项!</font>
					</td>
				</tr>
			</table>
		</div>
		<div id="batchSubmitManuOwnerDiv" title="批量提交底稿" style='overflow:hidden;padding:0px;'> 	  		
			<iframe scrolling="auto" id="batchSubmitManuOwnerFrame" name="batchSubmitManuOwnerFrame" title="批量提交底稿" src="" width="100%" height="100%" frameborder="0"></iframe>				
	    </div>
		<div id="manuTemplateDiv" title="底稿模板选择" style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="manuTemplateFrame" name="manuTemplateFrame" title="模板选择" src="" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>				
	    </div>
		<div id="outDoubtOwnerDiv" title="消除疑点" style='overflow:hidden;padding:0px;'>
			<iframe scrolling="auto" id="outDoubtOwnerFrame" name="outDoubtOwnerFrame" title="消除疑点" src="" width="100%" height="100%" frameborder="0"></iframe>
	    </div>
	    <div id="templateWindow">
			<table id="templateList"></table>
		</div>
	    <input id="mytaskTableId" value='operate-operate_item_list<%=owner%>' style='display:none;'/>
	    <input id="myTaskTemplateId" style='display:none;'/>
	</body>
	<script type="text/javascript">
		$(function(){
			loadSelectH();
			//初始化审计小组下拉框
			$('#combox').combobox({
				url:'${contextPath}/pages/operate/opr_task/operate_group_data.jsp?project_id=<%=request.getParameter("project_id")%>',    
				valueField:'catCode',    
				textField:'catName',
				mode:'local',
				width:'80%',
				onSelect:function(rec){
					var catCode = rec.catCode;
					$('#operate-operate_item_list<%=owner%>').datagrid({
						url : "${pageContext.request.contextPath}/operate/taskExt/getOwnerTaskListJsonEasyUI.action?querySource=grid&uitaskPid=<%=request.getParameter("taskId")%>&uigroupCode="+catCode+""  
					});
				}
			});
			//加载数据
	     	<%String s=request.getParameter("taskPid");%>
				var taskPid,groupCode,project_id;	      
	        <%if("-1".equals(s)||s==null){%>
				taskPid = "-1"; groupCode = "-1"; project_id = "<%=request.getParameter("project_id")%>";
	        <%}else{%>
				taskPid = "<%=request.getParameter("taskId")%>"; groupCode = "-1"; project_id = "<%=request.getParameter("project_id")%>"; 
	        <%}%>
	        //初始化左侧审计事项表格
			$('#operate-operate_item_list<%=owner%>').treegrid({
                title:"<p style=\"color: red;display: inline;\">(还有${taskSum}个事项未完成)</p>",
				url:'${contextPath}/operate/taskExt/getOwnerTaskListJsonTreeGrid.action',
				queryParams:{'project_id':'${project_id}'},
				idField:'uniqueId',
				treeField:'taskName',
				parentField:'taskPid',
				animate : true,
				border:false,
				method:'post',
				//striped:true,
				fit: true,
				//rownumbers : true,
				singleSelect:true,
				columns:[[
							{field:'taskName',title:'审计事项',width:'60%',align:'left',halign:'center'},
							{field:'manu',title:'底稿',width:'15%',align:'left',halign:'center'},
							{field:'doubt',title:'疑点',width:'15%',align:'left',halign:'center'},
							{field:'ledgerNum',title:'问题',width:'15%',align:'left',halign:'center'}
						]],
                onLoadSuccess:function(row, data){
                    if(data && data.rows.length){
                        var myTaskTemplateId = $('#myTaskTemplateId').val();
                        var rowSelect = null;
                        if(myTaskTemplateId!=null&&myTaskTemplateId!=''){
                        	$('#operate-operate_item_list<%=owner%>').treegrid('select',myTaskTemplateId);
                        	rowSelect = $('#operate-operate_item_list<%=owner%>').treegrid('getSelected');
                        }else{
                        	$('#operate-operate_item_list<%=owner%>').treegrid('select',data.rows[0].taskTemplateId);
                        	rowSelect = data.rows[0];
                        }
                        reloadRightGrid(rowSelect);
                    }
                },
                onClickRow:reloadRightGrid
			});
	        
	        <%-- 
	        $('#operate-operate_item_list<%=owner%>').datagrid({
				url : "${pageContext.request.contextPath}/operate/taskExt/getOwnerTaskListJsonEasyUI.action?querySource=grid&view=${param.view}&projectview=${param.projectview}",
				method:'post',
				showFooter:false,
				rownumbers:false,
				pagination:false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				queryParams:{
					'audTask.taskPid':taskPid,
					'audTask.groupCode':groupCode,
					'audTask.project_id':project_id
				},
                onLoadSuccess:function(data){
                    if(data && data.rows.length){
                        $('#operate-operate_item_list<%=owner%>').datagrid('selectRow',0);
                        reloadRightGrid(0, data.rows[0]);
                    }
                },
				onClickRow:reloadRightGrid,
                title:"<p style=\"color: red;display: inline;\">(还有${taskSum}个事项未完成)</p>",
				columns:[[
					{field:'taskTemplateId',
					 sortable:true, 
					 align:'center',
					 title:'fixHidden',
					 hidden:true
					},
					{field:'taskNameView',
					 sortable:true, 
					 align:'center',
					 title:'fixHidden',
					 hidden:true
					},
					{field:'taskPid',
					 sortable:true, 
					 align:'center',
					 title:'fixHidden',
					 hidden:true
					},
					{field:'taskName',
					 title:'审计事项',
					 width:'50%',
					 sortable:true, 
					 halign:'center',
					 align:'left'
					},
					{field:'manu',
					 title:'底稿',
					 width:'15%',
					 sortable:true, 
					 align:'center'
					},
					{field:'doubt',
					 title:'疑点',
					 width:'15%',
					 sortable:true, 
					 align:'center'
					},
					{field:'ledgerNum',
					 title:'问题',
					 width:'15%',
					 sortable:true, 
					 align:'center'
					}
				]]   
			}); --%>
			//noInfo为true，说明无被分配事项，页面右侧不显示数据
			<%String noInfo=String.valueOf(request.getAttribute("noInfo"));%>
				var urlDigao;
			<% if("true".equals(noInfo)){%>
				$('#information').css('display','none');
				$.messager.show({
					title:'提示信息',
					msg:'请点击左侧树节点查看审计事项!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			<%}else{%>
				$('#message').css('display','none');
				//初始化审计事项详情表格
		        $('#operate-task-detail-list-4').datagrid({
					//url : "${url}",
					method:'post',
					showFooter:false,
					rownumbers:false,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					columns:[[
						{field:'taskName',
						 title:'审计事项名称',
						 width:'30%',
						 sortable:true, 
						 halign:'center',
						 align:'left',
						 formatter:function(value,rowData,rowIndex){
							return '<a href=\"javascript:void(0)\" onclick=\"task(\'2\',\''+rowData.taskTemplateId+'\');\">'+value+'</a>';
						 }
						},
						{field:'taskOther',
						 title:'审计程序和方法',
						 width:'20%',
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'law',
						 title:'相关法律法规和监管规定',
						 width:'20%',
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'taskMethod',
						 title:'审计查证要点',
						 width:'20%',
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'taskAssignName',
						 title:'执行人',
						 width:'80px',
						 sortable:true, 
						 align:'center'
						}
					]]   
				});
				
				//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
				<%String sdigao=String.valueOf(request.getAttribute("taskPid"));%>
					var urlDigao;
				<% if("-1".equals(sdigao)||sdigao==null||sdigao=="null"){%>
					urlDigao = "audManuscript.flushdata=1&audManuscript.project_id=${project_id}&audManuscript.task_id=-1";
				<%}else{%>
					urlDigao = "audManuscript.flushdata=1&audManuscript.project_id=${project_id}&audManuscript.task_id=${taskId}&taskPid=${taskPid}&taskId=${taskId}";
				<%}%>
				//初始化审计底稿表格
		        $('#operate-task-detail-list-1').datagrid({
					//url : "${pageContext.request.contextPath}/operate/manuExt/manuListJsonEasyUI.action?querySource=grid&permission=${permission}&isView=${isView}&project_id=${project_id}"+"&"+urlDigao,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					selectOnCheck: false,
					toolbar:[
							<% if(!"true".equals(right)){%>//根据系统参数配置，是否显示底稿反馈按钮
								<% if("enabled"=="${digaofankui}"){%>
									{
										id:'feedback',
										text:'反馈',
										iconCls:'icon-save',
										handler:function(){
											feedback();
										}
									},
								<%}%>
							<%}%>
							<% if(!"view".equals(request.getAttribute("view"))){%>
								{
									id:'addManuOwner',
									text:'新增',
									iconCls:'icon-add',
									handler:function(){
										addManuOwner();
									}
								},
								/* {
									id:'editManuOwner',
									text:'修改',
									iconCls:'icon-edit',
									handler:function(){
										editManuOwner();
									}
								}, */
								{
									id:'batchDelManuOwner',
									text:'删除',
									iconCls:'icon-delete',
									handler:function(){
										batchDelManuOwner();
									}
								},
								/* {
									id:'outManuOwner',
									text:'注销',
									iconCls:'icon-cancel',
									handler:function(){
										outManuOwner();
									}
								},
								{
									id:'inManuOwner',
									text:'恢复',
									iconCls:'icon-recover',
									handler:function(){
										inManuOwner();
									}
								}, */
								{
									id:'batchSubmitManuOwner',
									text:'提交',
									iconCls:'icon-ok',
									handler:function(){
										batchSubmitManuOwner();
									}
								},
							<%}%>
							 {
								id:'expUnitermManuscript',
								text:'导出底稿',
								iconCls:'icon-export',
								handler:function(){
									expManuscript("UNITERM","底稿");
								}
							} 
						/* 	,{
								id:'expComprehensiveManuscript',
								text:'导出WORD底稿',
								iconCls:'icon-export',
								handler:function(){
									expManuscript("COMPREHENSIVE","综合底稿");
								}
							} */
					],
					frozenColumns:[[
						{field:'formId',width:10,align:'center',checkbox:true},
						{field:'ms_name',
						 title:'底稿名称',
						 width:"25%",
						 sortable:true, 
						 halign:'center',
						 align:'left',
                         formatter:function(value,row,index){
                             if('${view}'=='view'){
                            	 return "<a title='单击查看' href='javascript:void(0)' onclick=viewManuOwner('"+row.formId+"','"+row.project_id+"')>"+value+"</a>";
                             }else{
                            	 if(row.ms_status=='010'){
                            		 return "<a title='单击编辑' href='javascript:void(0)' onclick=editManuOwner('"+row.groupId+"','"+row.project_id+"','"+row.task_id+"','','"+row.ms_author+"','"+row.ms_status+"','"+row.formId+"')>"+value+"</a>";
                            	 }else{
                            		 return "<a title='单击查看' href='javascript:void(0)' onclick=viewManuOwner('"+row.formId+"','"+row.project_id+"')>"+value+"</a>";
                            	 }
                             }
                         }
						},
						/* {field:'manuTypeName',
						 title:'底稿类型',
						 width:70,
						 sortable:true, 
						 align:'center'
						}, */
						{field:'ms_statusName',
						 title:'底稿状态',
						 width:70,
						 sortable:true, 
						 align:'center'
						}
					]],
					columns:[[
						{field:'audit_dept_name',
						 title:'被审计单位',
						 width:"20%",
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'task_name',
						 title:'审计事项',
						 width:80,
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'ms_author_name',
						 title:'撰写人',
						 width:60,
						 sortable:true, 
						 align:'center'
						},
						{field:'fileCount',
						 title:'附件',
						 width:40,
						 sortable:true, 
						 align:'center'
						},
						{field:'audit_found',
						 title:'关联疑点',
						 width:'15%',
						 sortable:true,
						 align:'center',
                         formatter:function(value,row,index){
                            return doubt2link(value);
                         }
						},
						{field:'prom',
						 title:'审计问题数量',
						 width:100,
						 sortable:true, 
						 align:'center'
						},
						{field:'ms_date',
						 title:'创建日期',
						 width:80,
						 sortable:true, 
						 align:'center',
						 formatter:function(value,rowData,rowIndex){
							if(value != null){ 
								return value.substring(0,10);
							}
						 }
						},
						{field:'subms_date',
							 title:'最后修改日期',
							 width:100,
							 sortable:true, 
							 align:'center'
							
							}
					]]
				});
				//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
				<%String syidian=String.valueOf(request.getAttribute("taskPid"));%>
					var urlYidian;
				<% if("-1".equals(syidian)||syidian==null||syidian=="null"){%>
					urlYidian = "audDoubt.flushdata=1&audDoubt.doubt_type=YD&audDoubt.project_id=${project_id}&audDoubt.task_id=-1";
				<%}else{%>
					urlYidian = "audDoubt.flushdata=1&audDoubt.doubt_type=YD&audDoubt.project_id=${project_id}&taskPid=${taskPid}&taskId=${taskId}&audDoubt.task_id=${taskId}";
				<%}%>
				//初始化审计疑点表格
		        $('#operate-task-detail-list-2').datagrid({
					//url : "${pageContext.request.contextPath}/operate/doubtExt/doubtListJsonEasyUI.action?querySource=grid&permission=${permission}&isView=${isView}&project_id=${project_id}"+"&"+urlYidian,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					//idField:'id',
					border:false,
					singleSelect:true,
					remoteSort: false,
					selectOnCheck: false,
					toolbar:[<% if(!"view".equals(request.getAttribute("view"))){%>

								{
									id:'addDoubtOwner',
									text:'新增',
									iconCls:'icon-add',
									handler:function(){
										addDoubtOwner();
									}
								},
								/* {
									id:'editDoubtOwner',
									text:'修改',
									iconCls:'icon-edit',
									handler:function(){
										editDoubtOwner();
									}
								}, */
								{
									id:'batchDelDoubtOwner',
									text:'删除',
									iconCls:'icon-delete',
									handler:function(){
										batchDelDoubtOwner();
									}
								},
								{
									id:'outDoubtOwner',
									text:'消除疑点',
									iconCls:'icon-cancel',
									handler:function(){
										outDoubtOwner();
									}
								},
								{
									id:'inDoubtOwner',
									text:'恢复',
									iconCls:'icon-recover',
									handler:function(){
										inDoubtOwner();
									}
								}
							<%}%>
					],
					frozenColumns:[[
						{field:'doubt_id',width:10,sortable:true,align:'center',checkbox:true},
						{field:'doubt_name',
						 title:'疑点名称',
						 width:"15%",
						 sortable:true,
						 halign:'center',
						 align:'left',
                         formatter:function(value,row,index){
                        	 if('${view}'=='view'){
                        		 return "<a title='单击查看' href='javascript:void(0)' onclick=goViewDoubt('"+row.doubt_id+"')>"+value+"</a>";
                        	 }else{
                        		 if(row.doubt_status=='010'){
                        			 return "<a title='单击编辑' href='javascript:void(0)' onclick=editDoubtOwner('"+row.groupId+"','"+row.project_id+"','"+row.task_id+"','','"+row.doubt_author_code+"','"+row.doubt_status+"','"+row.doubt_id+"')>"+value+"</a>";
                        		 }else{
                        			 return "<a title='单击查看' href='javascript:void(0)' onclick=goViewDoubt('"+row.doubt_id+"')>"+value+"</a>";
                        		 }
                        	 }
                        	 //return doubt2link(new String(row.doubt_id+","+value));
                         }
						},
						{field:'doubt_statusName',
						 title:'疑点状态',
						 width:80,
						 sortable:true,
						 align:'center'
						},
						{field:'doubt_code',
						 title:'疑点编码',
						 width:"15%",
						 sortable:true,
						 align:'center',
                         formatter:function(value,row,index){
                            return doubt2link(new String(row.doubt_id+","+value));
                         }
						}
					]],
					columns:[[
						{field:'audit_dept_name',
						 title:'被审计单位',
						 width:"15%",
						 sortable:true,
						 halign:'center',
						 align:'left'
						},
						{field:'task_name',
						 title:'审计事项',
						 width:"15%",
						 sortable:true,
						 halign:'center',
						 align:'left'
						},
						{field:'doubt_author',
						 title:'撰写人',
						 width:60,
						 sortable:true,
						 align:'center'
						},
						{field:'fileCount',
						 title:'附件',
						 width:40,
						 sortable:true,
						 align:'center'
						},
						{field:'doubt_manu_name',
						 title:'关联底稿',
						 width:"15%",
						 sortable:true,
						 align:'center',
                         formatter:function(value,row,index){
                             if(value){
                                return "<a href='javascript:void(0)' onclick=viewManuOwner(\'"+row.doubt_manu.split(',')[0]+"\',\'"+row.project_id+"\')>"+value+"</a>";
                             }
                             return "";
                         }
						},
						{field:'doubt_date',
						 title:'创建日期',
						 width:"10%",
						 sortable:true,
						 align:'center',
						 formatter:function(value,rowData,rowIndex){
							if(value != null){
								return value.substring(0,10);
							}
						 }
						}
					]]
				});

				
				//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
				<%String swenti=String.valueOf(request.getAttribute("taskPid"));%>
					var urlWenti;
				<% if("-1".equals(swenti)||swenti==null||swenti=="null"){%>
					urlWenti = "";
				<%}else{%>
					urlWenti = "taskPid=${taskPid}&taskId=${taskId}";
				<%}%>
				//初始化审计问题表格
		        $('#operate-task-detail-list-3').datagrid({
					//url : "${pageContext.request.contextPath}/proledger/problem/loadLedgerListJsonEasyUI.action?querySource=grid&permission=${permission}&isView=${isView}&project_id=${project_id}"+"&"+urlWenti,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					selectOnCheck: false,
                    /*
					toolbar:[{
								id:'viewLedgerOwner',
								text:'查看',
								iconCls:'icon-view',
								handler:function(){
									viewLedgerOwner();
								}
							}
					],*/
					frozenColumns:[[
					                
                        {field:'audit_con',
	                     title:'问题标题',
	                     width:"20%",
	                     sortable:true, 
	                     halign:'center',
	                     align:'left',
                         formatter:function(value, rowData){
                            return "<a href='javascript:void(0)' onclick=\"viewLedgerOwner('"+rowData.id+"')\">"+value+"</a>";
                         }
	                     } /* ,         
						{field:'manuscript_name',
						 title:'底稿名称',
						 width:"20%",
						 sortable:true, 
						 halign:'center',
						 align:'left',
                         formatter:function(value, rowData){
                             return "<a href='javascript:void(0)' onclick=\"viewLedgerOwner('"+rowData.id+"')\">"+value+"</a>";
                         }
						} */
					]],
					columns:[[
						{field:'taskAssignName',
						 title:'分组',
						 width:"15%",
						 sortable:true, 
						 halign:'center',
						 align:'center'
						},
						{field:'sort_big_name',
						 title:'问题类别',
						 width:"25%",
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'sort_small_name',
						 title:'问题子类别',
						 width:"25%",
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'problem_name',
						 title:'问题点',
						 width:"25%",
						 sortable:true, 
						 halign:'center',
						 align:'left'
						},
						{field:'problem_money',
						 title:'问题金额',
						 width:60,
						 sortable:true, 
						 align:'center'
						},
						{field:'problemCount',
						 title:'发生数量',
						 width:"15%",
						 sortable:true, 
						 halign:'center',
						 align:'center'
						},
						{field:'problem_grade_name',
						 title:'问题定性',
						 width:"15%",
						 sortable:true, 
						 align:'center'
						},
						{field:'describe',
						 title:'问题摘要',
						 width:"15%",
						 sortable:true, 
						 halign:'center',
						 align:'left'
						}
					]]   
				});
			<%}%>
			//初始化批量提交底稿窗口
		    $('#batchSubmitManuOwnerDiv').window({
				width:'80%', 
				height:'80%',  
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true    
		    });
			//初始化消除疑点窗口
		    $('#outDoubtOwnerDiv').window({
				width:702,
				height:280,
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
		    });
			//初始化导出底稿窗口
			$('#manuTemplateDiv').window({   
				width:document.documentElement.clientWidth,   
				height:document.documentElement.clientHeight,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
			setGridBtnsAuth();
		});
        
        function doubt2link(value){
            if(value){
                var arr = value.split(',');
                if(arr && arr.length == 2){
                    var doubtId   = arr[0];
                    var doubtCode = arr[1];
                    var strArr = [];
                    strArr.push("<a title='查看疑点' href='javascript:void(0)' ");
                    strArr.push("onclick=goViewDoubt(\'");
                    strArr.push(doubtId);
                    strArr.push("\')>");
                    strArr.push(doubtCode);
                    strArr.push("</a>");
                    return strArr.join('');
                }else{
                    return value;
                }
            }
            return value;
        }
        
        function goViewDoubt(doubtId){
	    	var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubtId;
	     	top.addTab("tabs","查看审计疑点","manuViewTab",myurl,false);
        }
        
        function setGridBtnsAuth(){
           if('${isView}' == 'true' || '${view}' == 'view'){
                $('#addDoubtOwner,#editDoubtOwner,#batchDelDoubtOwner,#outDoubtOwner,#inDoubtOwner,#addManuOwner,#editManuOwner,#batchDelManuOwner,#outManuOwner,#inManuOwner,#batchSubmitManuOwner').hide();
           }
       }
       
       //function reloadRightGrid(index, row){
       function reloadRightGrid(row){
            var groupCode = row.groupCode;
            if(groupCode=='-1'){
                return false;
            }
            $('#myTaskTemplateId').val(row.uniqueId);
            var auditObject = row.auditObject;
            var taskPid = row.taskPid;
            var taskId = row.taskTemplateId;
            var taskTemplateId = row.taskTemplateId;
            var type = "2";
            var project_id = row.project_id;
            var taskName = row.taskName;//审计事项名称
            var projectview="${param.projectview}";
            //左侧审计事项表格中显示的事项均为末级具体事项，不会出现（taskPid=='-1'）的情形
            <%-- if(taskPid=='-1'||typeof taskPid=='undefined'){
                return false;
                taskPid='-1';
                project_id = '<%=request.getParameter("project_id")%>';
                window.location.href='${pageContext.request.contextPath}/operate/taskExt/taskDetailListUi.action?groupCode='+groupCode+'&coll=0&taskTemplateId='+taskTemplateId+'&taskId='+taskId+'&taskPid='+taskPid+'&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&owner='+<%=ownerStr%>;
            }else{ --%>
                //重新生成审计事项详情表格
                $('#operate-task-detail-list-4').datagrid({
                    url : '${pageContext.request.contextPath}/operate/task/project/showContentTypeViewNew1.action?auditObject='+auditObject+'&groupCode='+groupCode+'&coll=0&taskTemplateId='+taskTemplateId+'&taskId='+taskId+'&taskPid='+taskPid+'&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&owner='+<%=ownerStr%>+''
                });
              $('#operate-task-detail-list-1').datagrid('clearChecked');//清除所有勾选的行
               var urlDigao1 = "audManuscript.flushdata=1&audManuscript.project_id=<%=request.getParameter("project_id")%>&audManuscript.task_id="+taskId+"&taskPid="+taskPid+"&taskId="+taskId+"&groupCode="+groupCode+"&auditObject="+auditObject;
                //重新生成审计底稿表格
                $('#operate-task-detail-list-1').datagrid({
                    url : "${pageContext.request.contextPath}/operate/manuExt/manuListJsonEasyUI.action?querySource=grid&projectview=${param.projectview}&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>"+"&"+urlDigao1
                }); 
                $('#operate-task-detail-list-2').datagrid('clearChecked');//清除所有勾选的行
                var urlYidian1 = "audDoubt.flushdata=1&view=${param.view}&audDoubt.doubt_type=YD&audDoubt.project_id=<%=request.getParameter("project_id")%>&taskPid="+taskPid+"&taskId="+taskId+"&audDoubt.task_id="+taskId+"&groupCode="+groupCode+"&auditObject="+auditObject;
                //重新生成审计疑点表格
                $('#operate-task-detail-list-2').datagrid({
                    url : "${pageContext.request.contextPath}/operate/doubtExt/doubtListJsonEasyUI.action?querySource=grid&permission=${permission}&isView=${isView}&project_id=${project_id}"+"&"+urlYidian1
                });
                $('#operate-task-detail-list-3').datagrid('clearChecked');//清除所有勾选的行
                var urlWenti = "taskPid="+taskPid+"&taskId="+taskId+"&groupCode="+groupCode+"&auditObject="+auditObject;
                //重新生成审计问题表格
                $('#operate-task-detail-list-3').datagrid({
                    url : "${pageContext.request.contextPath}/proledger/problem/loadLedgerListJsonEasyUI.action?querySource=grid&permission=${permission}&isView=${isView}&project_id=${project_id}"+"&"+urlWenti
                });
                
            //}
       }
       
	</script>
</html>
