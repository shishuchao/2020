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
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>
	</head>
	<script>
		/*
		 * 提取文件
		 */
		 function archivesFile(archives_form_id,project_id){
			 var url = "${contextPath}/intctet/proArchive/collectArchives.action?archives_form_id=" + archives_form_id
        		 + "&project_id=" + project_id;
	 		window.location = url;
	 		addUploadProssess();
		 }

		/*
		 * 文件管理(项目方案文件管理)
		 */
		function editDetail(archives_form_id,epId,archive_name){
			var url = "${contextPath}/intctet/proArchive/archivesFile.action?epId="+epId 
			+ "&archive_name=" + encodeURI(encodeURI(archive_name));
			aud$openNewTab('文件管理',url);
		}
	
		/*
		 * 处理
		 */
		function archivesPigeonholeEdit(crudId,project_id){
			var back1 = "${contextPath}/intctet/proArchive/listTobeStarted.action";
			back1 = encodeURIComponent(back1);
			var backURL = encodeURIComponent(back1);
			var url = "${contextPath}/intctet/proArchive/edit.action?crudId="+crudId+"&&project_id="+project_id+"&&returnBatch=true&&backURL="+backURL;
			window.location.href=url;
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
			document.getElementsByName("project_name")[0].value = "";
			document.getElementsByName("archives_name")[0].value = "";
			document.getElementsByName("epCategory")[0].value = "";
			document.getElementsByName("proCategory")[0].value = "";
			//提交
			//document.forms[0].submit();
		}
		
		function doSearch(){
			$("#archiveslist").datagrid({
	    		queryParams:form2Json('searchForm')
	    	});
			$('#proArchiversSearch').window('close');
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
	</script>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="proArchiversSearch" class="searchWindow">
			<div class="search_head">
			<s:form namespace="/intctet/proArchive" action="listTobeStarted" name="searchForm" id="searchForm">
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead" style="width:15%">项目名称</td>
							<td class="editTd" style="width:35%">
								<s:textfield  cssClass="noborder" name="project_name" maxlength="100"/>
							</td>
							<td class="EditHead" style="width:15%">档案名称</td>
							<td class="editTd" style="width:35%">
								<s:textfield  cssClass="noborder" name="archives_name" maxlength="100"/>
							</td>
						</tr>
						<tr >
							<td class="EditHead">计划类别</td>
							<td class="editTd">
								<select editable="false" class="easyui-combobox" name="epCategory" style="width:80%;" editable="false" panelHeight="auto">
							       <option value="">&nbsp;</option>
							       <!-- <s:iterator value="{'年度计划','临时计划'}" id="entry">
							         <option value="${entry }">${entry }</option>
							       </s:iterator> -->
							       <s:iterator value="basicUtil.planLevelList" id="entry">
								       <option value="<s:property value="name"/>"><s:property value="name"/></option>
								     </s:iterator>
							    </select>
							</td>
							<td class="EditHead">项目类别</td>
							<td class="editTd">
								<select editable="false" id="pro_type" class="easyui-combobox" name="proCategory" style="width:80%;" editable="false" panelHeight="auto">
								    <option value="">&nbsp;</option>
								    <s:iterator value="basicUtil.proCategoryList" id="entry">
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
		function (){
			$("#archiveslist").datagrid({
	    		queryParams:form2Json('searchForm')
	    	});
			$('#proArchiversSearch').window('close')
		}
	</script>
	<script type="text/javascript">
		$(function(){
		   if("${param.issubmit}" == '1'){
				reloadHomeAfterSubmitFlow();
			}
			
			//查询
			showWin('proArchiversSearch');
			loadSelectH();
			// 初始化生成表格
			$('#archiveslist').datagrid({
				url : "<%=request.getContextPath()%>/intctet/proArchive/listTobeStarted.action?querySource=grid",
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
				toolbar:[{
							id:'searchObj',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('proArchiversSearch');
							}
						}
					],
				frozenColumns:[[
				       			{field:'formId',width:50, hidden:true, align:'center'},
				       			{field:'project_name',title:'项目名称',width:'140px',halign:'center',align:'left'},
				       			{field:'archives_name',title:'档案名称',width:'140px',halign:'center',sortable:true,align:'left'}
				    		]],
				columns:[[  
					{field:'epCategory',
							title:'计划类别',
							width:'90px',
							halign:'center',
							align:'center', 
							sortable:true,
					},{field:'proCategory',
						title:'项目类别',
						width:'90px',
						sortable:true,
						halign:'center', 
						align:'center'
					},{field:'evaStart',
						 title:'开始时间',
						 width:'100px',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						 
						  if(value!=null){return value.substring(0,10);}
						  
						 }
					},{field:'evaEnd',
						 title:'结束时间',
						 width:'100px',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								  if(value!=null){return value.substring(0,10);}
						 }
					},{field:'evaOrgan',
						 title:'内控评价组织机构',
						 width:'150px',
						 halign:'center',
						 align:'center', 
						 sortable:true
					},
					{field:'link',
						 title:'操作',
						 width:'100px',
						 halign:'center',
						 align:'center',
						 sortable:false
					}
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
