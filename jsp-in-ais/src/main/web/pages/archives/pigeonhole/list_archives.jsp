<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<% 
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>

		<STYLE type="text/css">
/*			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}*/
		</STYLE>
	</head>
	<script>
		/* $(function(){		
			if("${errorMsg}"){
				top.$.messager.alert("提示信息","${errorMsg}", "warning", function(){			
					aud$closeTab();
				});
				setTimeout(aud$closeTab,0);
			}
		}); */
		/*
		 * 提取文件
		 */
		 function archivesFile(archives_form_id,project_id){
			 $.ajax({
					type: "POST",
				    dataType:"text",
				    url: "${contextPath}/archives/workprogram/pigeonhole/lookRole.action?project_id = "+project_id,
				    success:function(data){
				    	if(data == 'zuyuan'){
				    		showMessage2("只有主审,组长,副组长有操作权限!");
				    	}else{
				    		var url = "${contextPath}/archives/workprogram/pigeonhole/collectArchives.action?archives_form_id=" + archives_form_id
		 	               		 + "&project_id=" + project_id;
						 	window.location = url;
						 	addUploadProssess();
				    	} 
				    }
				});
		 	
		 	
		 }
		 /*
		 * 提取文书
		 */
		<%-- function archivesWriter(archives_form_id,project_id,type){ 
			 var title='';
			 if('uniterm'==type){
				 title='选择单项底稿模板';
			 }else if('comprehensive'==type){
				 title='选择综合底稿模板';
			 }else if('evidence'==type){
				 title='选择取证记录模板';
			 }else{
				 title='选择查询书模板';
			 }
	        //判断模板数量 data ==2是多条
	        jQuery.ajax({
					url:'${contextPath}/operate/manuExt/pandManuTem.action?type='+type+'&project_id='+project_id,
					type:'POST',
					dataType:'text',
					async:false,
					success:function(data){
						if(data == 2) {
							// 初始化生成表格
							$('#templateList').datagrid({
								url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type="+type+"&project_id="+project_id,
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
											var link = '<a href=\"javascript:void(0);\" onclick=\"archivesWriterAll(\''+row.templateId+'\',\''+archives_form_id+'\',\''+project_id+'\',\''+type+'\');\">提取</a>';
											return link;
										}
									}
								]]
							});

							$('#templateWindow').window({
								title:title,
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
							archivesWriterAll(data,archives_form_id,project_id,type);
						}
					},
					error:function(){
						showMessage1('出错啦！');
					}
		});
			
	} --%>

		
		 /*
		 * 提取文书  最新需求 by wk 2016 11 29
		 */
		function archivesWriter(archives_form_id,project_id,type){
			top.$.messager.confirm('提示信息','确定提取文件吗？如果已经提取过文件，已有档案将被覆盖!',function(isFound){
				if(isFound){
					var editWriterUrl = '${contextPath}/operate/manuExt/reportTemplateList.action?project_id='+project_id+'&type='+type+'&form_id='+archives_form_id;
					 $.ajax({
							type: "POST",
						    dataType:"text",
						    url: "${contextPath}/archives/workprogram/pigeonhole/checkMlpData.action?project_id = "+project_id,
						    success:function(data){
						    	if(data == '1'){
						    		showMessage2("整改问题尚未全部设定，不能归档!");
						    	}else{
						    		$.ajax({
										type: "POST",
									    dataType:"text",
									    url: "${contextPath}/archives/workprogram/pigeonhole/lookRole.action?project_id = "+project_id,
									    success:function(data){
									    	if(data == 'zuyuan'){
									    		showMessage2("只有主审,组长,副组长有操作权限!");
									    	}else{
									    		var url = "${contextPath}/archives/workprogram/pigeonhole/collectArchives.action?archives_form_id=" + archives_form_id
							 	               		 + "&project_id=" + project_id;
											 	window.location = url;
											 	addUploadProssess();
									    	} 
									    }
									});
						    	} 
						    }
						}); 
				}
			});
		}
		 
		 function archivesWriterAll(templateId,archives_form_id,project_id,type){
			 $("#dx").attr("src","");
			 var uniterm_url = "${contextPath}/archives/workprogram/pigeonhole/archivesAllWriter.action?archives_form_id=" + archives_form_id
        		 + "&project_id=" + project_id+ "&templateId=" + templateId+ "&type=" + type;
			 $("#dx").attr("src",uniterm_url);
			 $("#templateWindow").window({"onOpen":function(){
				 $("#templateWindow").window('close');
			 }}); 
			// location.reload();
		 }
		 function archivesWriterClose(){
			 $('#archivesWriterPage').window('close');
		 }
		 
		/*
		 * 文件管理(项目方案文件管理)
		 */
		function editDetail(archives_form_id,project_id,archive_name){
			$.ajax({
				type: "POST",
			    dataType:"text",
			    url: "${contextPath}/archives/workprogram/pigeonhole/lookRole.action?project_id = "+project_id,
			    success:function(data){
			    	if(data == 'zuyuan'){
			    		showMessage2("只有主审,组长,副组长有操作权限!");
			    	}else{
			    		var url = "${contextPath}/archives/workprogram/pigeonhole/editArchivesFile.action?project_id="+project_id 
						+ "&archive_name=" + encodeURI(encodeURI(archive_name));
						//window.open(url,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no') ;
						window.location = url;
			    	} 
			    }
			});
		}
	
		/*
		 * 处理
		 */
		function archivesPigeonholeEdit(crudId,project_id){
			var flag = "";
			jQuery.ajax({
				url:"${contextPath}/archives/workprogram/pigeonhole/checkArchivesFile.action",
				type:"post",
				data:{"project_id":project_id,"archives_name":'${pigeonholeObject.project_name}'},
				async:false,
				success:function(data){
					flag = data;
				}
				
			});
			if(flag == "1"){
				alert("请将审计文书的必做节点完成后再提交！");
				return false;
			}
			$.ajax({
				type: "POST",
			    dataType:"text",
			    url: "${contextPath}/archives/workprogram/pigeonhole/lookRole.action?project_id = "+project_id,
			    success:function(data){
			    	if(data == 'zuyuan'){
			    		showMessage2("只有主审,组长,副组长有操作权限!");
			    	}else{
			    		var back1 = "${contextPath}/archives/pigeonhole/listTobeStarted.action";
						back1 = encodeURIComponent(back1);
						var backURL = encodeURIComponent(back1);
						var url = "${contextPath}/archives/pigeonhole/edit.action?crudId="+crudId+"&&project_id="+project_id+"&&backURL=true";
						window.location = url;
			    	} 
			    }
			});
			
		}
		//
		function displayAlert(){
			var msg = '${project_name}';
			if(msg!=null && msg!='' && msg=='true'){
				alert("项目提取文件成功！");
			}
		}
		//显示进度条
		function addUploadProssess(){
		document.getElementById("archiveslist1").style.visibility="hidden";
		document.getElementById("imgDiv").style.visibility="visible";
		return true;
	}
	 function archivesAudmanuscript(){
	 	var archives_project_id = document.getElementById("archives_project_id").value;
	 	var url = "${contextPath}/archives/workprogram/pigeonhole/saveAudManuscript.action?project_id="+archives_project_id;
		window.open(url,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no') ;
	 }
	 
	 	/*
		*  打开或关闭查询面板
		*/
		function triggerSearchTable(){
			var isDisplay = document.getElementById('searchTable').style.display;
			if(isDisplay==''){
				document.getElementById('searchTable').style.display='none';
			}else{
				document.getElementById('searchTable').style.display='';
			}
		}
		/*
		*  重置
		*/
		function myReset(){
            $("#searchForm .editTd").find('select,input').attr('value',null);
		}
		/*
		* 刷新
		*/
		function reloadHomeAfterSubmitFlow(){
			try{
		    	// 是否来自审计作业页面
		   		var isJobPage = false;
		     	var bodyId = top.document.body.id;
		     	//alert(bodyId)
		    	if(bodyId == 'projectLayout'){
		        	isJobPage = true;
		      	}else if(bodyId == 'mainLayout'){
		          	isJobPage = false;
		      	}
		     	var pageWin = isJobPage ? window.top.opener.parent : window.top; 
		     	//alert(pageWin.reloadHomePage)
				if(pageWin && pageWin.reloadHomePage){
		       		pageWin.reloadHomePage();
				}
			}catch(e){
				//alert('reloadHomeAfterSubmitFlow:\n'+e.message);
			}
		}
		
		function supMaterial(archives_form_id,project_id,type){
			$.messager.confirm('操作提示','您确定要补充材料重启流程吗？',function(flag){
				if(flag) {
					$.ajax({
						type: "POST",
					    dataType:"text",
					    url: "${contextPath}/archives/pigeonhole/updateArchiveStatus.action",
					    data:{'status':'4','status_name':'补充材料','project_id':project_id,'archives_form_id':archives_form_id},
					    success:function(data){
					    	if(data == '1') {
					    		$('#archiveslist').datagrid('reload');
					    	} else {
					    		showMessage2("补充材料处理失败!");
					    	}
					    }
					});
				}
			});
		}
	</script>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="proArchiversSearch" class="searchWindow">
			<div class="search_head">
			<s:form namespace="/archives/pigeonhole" action="listTobeStarted" name="searchForm" id="searchForm">
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead" style="width:15%">项目名称</td>
							<td class="editTd" style="width:35%">
								<s:textfield  cssClass="noborder" name="pigeonholeObject.project_name" maxlength="100"/>
							</td>
							<td class="EditHead" style="width:15%">档案名称</td>
							<td class="editTd" style="width:35%">
								<s:textfield  cssClass="noborder" name="pigeonholeObject.archives_name" maxlength="100"/>
							</td>
							<input type="hidden" name="pigeonholeObject.project_id" id="archives_project_id">
						</tr>
						<tr >
							<td class="EditHead">计划类别</td>
							<td class="editTd">
								<select editable="false" class="easyui-combobox" name="projectStartObject.plan_type_name" style="width:80%;" editable="false" panelHeight="auto">
							       <option value="">&nbsp;</option>
							       <s:iterator value="{'年度计划','临时计划'}" id="entry">
							         <option value="${entry }">${entry }</option>
							       </s:iterator>
							    </select>
							</td>
							<td class="EditHead">项目类别</td>
							<td class="editTd">
									<select editable="false" id="pro_type" class="easyui-combobox" name="projectStartObject.pro_type_name" style="width:80%;" editable="false" panelHeight="auto">
								       <option value="">&nbsp;</option>
								       <s:iterator value="BasicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
								         <option value="<s:property value="code"/>"><s:property value="name"/></option>
								       </s:iterator>
								    </select>
							</td>
						</tr>
					</table>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
		        	<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="myReset()">重置</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#proArchiversSearch').window('close')">取消</a>
				</div>
			</div>
	</div>
	<div region="center" id="archiveslist1" border='0'>
		<table id="archiveslist"></table>
	</div>
	
	<div id="imgDiv" style="visibility : hidden; text-align: center;">
	<table width="100%" height="100%" border="0" style="height: 50px;border: 0px;width: 80%;">
			<tr>
				<td align="center">
					<center>
					<b><font color="#007fff">文件正在提取，请稍候... ...</font></b>
					<marquee direction="right" scrollamount="8" scrolldelay="200">
					    <span class="progressBarHandle-0"></span>
					    <span class="progressBarHandle-1"></span>
					    <span class="progressBarHandle-2"></span>
					    <span class="progressBarHandle-3"></span>
					    <span class="progressBarHandle-4"></span>
					    <span class="progressBarHandle-5"></span>
					    <span class="progressBarHandle-6"></span>
					    <span class="progressBarHandle-7"></span>
					    <span class="progressBarHandle-8"></span>
					    <span class="progressBarHandle-9"></span>
					</marquee>
					</center>
				</td>
			</tr>
		</table>
	</div>	
	<script type="text/javascript">
		function doSearch(){
			$("#archiveslist").datagrid({
	    		queryParams:form2Json('searchForm')
	    	});
			$('#proArchiversSearch').window('close')
		}
		function archiveThrow(archive_name,project_id) {
		    debugger;
            var url = "${contextPath}/archives/workprogram/pigeonhole/archivesFile.action?type=pigeonhole&project_id=" + project_id
                + "&archive_name=" + encodeURI(encodeURI(archive_name));
            aud$openNewTab('档案文件', url, true);
        }
	</script>
	<script type="text/javascript">
		$(function(){
		   if("${param.issubmit}" == '1'){
				reloadHomeAfterSubmitFlow();
			}

/*			  if ('${firstManu}' == "1"){
				  if (top.$('#menuList')){
					  top.$('#menuList').html("") ;
				      top.ProjectIndex.initSteps(top.$('#menuList'),'-11');
				  }
			  }*/
			//查询
			showWin('proArchiversSearch');
			loadSelectH();
			var bodyW = $('body').width();
            var project_id = "${project_id}";
            // 初始化生成表格
			$('#archiveslist').datagrid({
				url : "<%=request.getContextPath()%>/archives/pigeonhole/listTobeStarted.action?view=${view}&querySource=grid&projectId=${project_id}",
				method:'post',
				showFooter:false,
				rownumbers:true, 
			 	pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				selectOnCheck:false,
				toolbar:[/*{
							id:'searchObj',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('proArchiversSearch');
							}
						},'-',*/helpBtn
					],
				onLoadSuccess:function(){
					initHelpBtn();
					doCellTipShow('archiveslist');
				},
				frozenColumns:[[
				       			{field:'formId',width:bodyW*0.1+'px', hidden:true, align:'center'},
					<s:if test="${view != 'projectview'}">
				       			{field:'project_name',title:'项目名称',width:bodyW*0.12+'px',halign:'center',align:'left'},
				       			{field:'archives_name',title:'档案名称',width:bodyW*0.14+'px',halign:'center',sortable:true,align:'left',
									formatter:function (value ,rowData,rowIndex) {
                                        return '<a href=\"javascript:void(0)\" onclick=\"archiveThrow(\''+rowData.archives_name+'\',\''+project_id+'\');\">'+rowData.archives_name+'</a>';
                                    }
								}
					</s:if>
					<s:else>
								{field:'project_name',title:'项目名称',width:bodyW*0.195+'px',halign:'center',align:'left'},
								{field:'archives_name',title:'档案名称',width:bodyW*0.215+'px',halign:'center',sortable:true,align:'left',
									formatter:function (value ,rowData,rowIndex) {
										return '<a href=\"javascript:void(0)\" onclick=\"archiveThrow(\''+rowData.archives_name+'\',\''+project_id+'\');\">'+rowData.archives_name+'</a>';
									}
								}
					</s:else>

				    		]],
				columns:[[  
					/*{field:'plan_type_name',
							title:'计划类别',
							width:bodyW*0.06+'px',
							halign:'center',
							align:'left', 
							sortable:true,
						},*/
					{field:'pro_type_name',
						title:'项目类别',
						width:bodyW*0.08+'px',
						sortable:true,
						halign:'center', 
						align:'left'
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:bodyW*0.12+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},{field:'pro_starttime',
						 title:'开始时间',
						 width:bodyW*0.06+'px',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						  if(value!=null){return value.substring(0,10);}
						 }
					},{field:'pro_endtime',
						 title:'结束时间',
						 width:bodyW*0.06+'px',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
				  			if(value!=null){return value.substring(0,10);}
						 }
					},{field:'audit_dept_name',
						 title:'所属单位',
						 width:bodyW*0.11+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					<s:if test="${view != 'projectview'}">
					{field:'link',
						 width:bodyW*0.15+'px',
						 title:'操作',
						 halign:'center',
						 align:'center',
						 sortable:false
					}
					</s:if>
				]]
			});
			
		});
	</script>	
	<iframe id="dx" src="" style="display:none;"></iframe>
	<div id="templateWindow">
			<table id="templateList"></table>
		</div>
	<!-- 提取文书页面 -->
	<div id='archivesWriterPage' title='提取文书' style='overflow:hidden; margin:0px;'>
		 <div region="center" style='padding:2px; text-align:center;border:0px solid #cccccc;'>
		 	<iframe width='1100px' height='500px' frameborder=0 scrolling=false id="iFrameWriterPage"></iframe>
		 </div>
	</div>	
	</body>
	
</html>
