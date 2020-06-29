<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<title>信息管理</title>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>

	<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
</head>
	<SCRIPT type="text/javascript">
		function displayAlert(){
			var msg = '${message}';
			if(msg=='noauthrity'){
				alert("没有权限！");
			}else if(msg=='pubsuccess'){
				alert("发布成功！")
			}else if(msg=='puboffsuccess'){
				alert("撤销发布成功！")
			}
		}
		function realDel(id,type){
			if(window.confirm("确认删除吗？")){
				url="${contextPath}/portal/simple/information/deleteByType.action?information.id="+id+"&information.type="+type;
				window.location=url;
			}
		}
		//批量修改优先级
		function chgnums(formid){
			var puts_temp=document.getElementsByTagName('input');
			var puts,j=0,temp;
			for(i=0;i<puts_temp.length;i++){
				if(puts_temp[i].name.indexOf("id_")!=-1){
					temp=puts_temp[i].value;
					if(/^[0-9]+$/.test( temp ))
						continue;
					else{
						alert("请输入数字！");
						return false;
					}
				}
			}
			document.getElementById(formid).submit();
		}
		function resetPage(){
			var _title = document.getElementsByName("information.title");
			var _key = document.getElementsByName("information.infkey");
			var _createdate = document.getElementsByName("information.createdate");
			if(_title){
				_title[0].value="";
			}
			if(_key){
				_key[0].value="";
			}
			if(_createdate){
				_createdate[0].value="";
			}
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
		function hidePageLink(){
			/*
			var spans = document.getElementsByTagName("span")
			if(spans){
				if(spans.length){
					for (var i = 0; i < spans.length; i++) {
						if (spans[i].className == "pagelinks") {
							spans[i].style.display="none";
							break;
						}
						
					}
				}
			}*/
			displayAlert();
		}
	</SCRIPT>
<%
	int type = ((ais.portal.simple.model.Information) request
			.getAttribute("information")).getType();
	if (type == ais.portal.simple.model.Information.HOTLINK) {
		request.setAttribute("fkey", "网址");
	} else if (type == ais.portal.simple.model.Information.FEEDBACK) {
		request.setAttribute("fkey", "Email");
	} else {
		request.setAttribute("fkey", "关键字");
	}
%>
<body onload="hidePageLink()">
<center>
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
							<div style="display: inline;width:80%;">
								<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/portal/simple/information/listByType.action?information.type=${information.type}')"/>
							</div>
							<div style="display: inline;width:20%;text-align: right;">
								<s:if test="information.type!=@ais.portal.simple.model.Information@DEPTDES&&information.type!=@ais.portal.simple.model.Information@FEEDBACK">
								<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
								</s:if>
							</div>
						</td>
					</tr>
	</table>

<s:if test="information.type!=@ais.portal.simple.model.Information@DEPTDES&&information.type!=@ais.portal.simple.model.Information@FEEDBACK">
<s:form id="myform" action="/portal/simple/information/chgnumsViewByType.action">
	<table id="searchTable" style="display: none;" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
	<tr  class="titletable1">
	<td class="ListTableTr11">标题</td><td class="ListTableTr22"><s:textfield name="information.title"/></td>
		
	<td>${fkey}</td><td><s:textfield name="information.infkey"/></td>
	</tr>
	<tr  class="titletable1">
	<td class="ListTableTr11">创建时间</td><td class="ListTableTr22"><s:textfield name="information.createdate" onclick="calendar()" readonly="true"/></td>
	<td colspan="2"></td>
	</tr>
	<tr class="titletable1">
		<td colspan="4" align="right">
		<div style="display: inline;width:70%;"></div>
			<div style="display: inline;width:30%;text-align: right;">
				<s:hidden name="information.type" value="${information.type}"/>  
				<s:submit value="查询"/>
				<s:button onclick="resetPage()" value='重置'></s:button>
				<!--<s:if test="${Authority}">
					<s:button value="批量修改优先级" onclick="chgnums('myform2');"></s:button>
				</s:if>-->
			</div>
		</td>
	</tr>
	</table>
</s:form>
</s:if>

<s:form id="myform2"   action="/portal/simple/information/chgnumsViewByType.action" method="post">
	<display:table name="list" id="row" requestURI="${contextPath}/portal/simple/information/listViewByType.action" 
					pagesize="${baseHelper.pageSize}" partialList="true" excludedParams="message"
					size="${baseHelper.totalRows}" sort="external" 
					defaultsort="0" defaultorder="descending" class="its" cellpadding="1">
		<display:column title="标题" sortable="true"  class="center" style="word-break:break-all; word-wrap: break-word;"
			headerClass="center" maxLength="20" >
			<a href="javascript:;" onclick="parent.goMenu('部门公告','${contextPath}/portal/simple/information/viewByType.action?information.type=1&information.id=${row.id}','8')">
						${row.title} 
			</a>
		</display:column>
		<s:if test="information.type==@ais.portal.simple.model.Information@HOTLINK">
			<display:column property="infkey" title="网址" sortable="true"  class="center" headerClass="center" ></display:column>
		</s:if>
		<s:elseif test="information.type==@ais.portal.simple.model.Information@FEEDBACK">
			<display:column property="infkey" title="Email" sortable="true"  class="center" headerClass="center"></display:column>
		</s:elseif>
		<s:else>
			<display:column property="infkey" title="关键字" sortable="true" class="center" headerClass="center" ></display:column>
		</s:else>
		<display:column title="创建人" sortable="true" style="white-space:nowrap;"  class="center" headerClass="center" >
			${row.createManName}&nbsp;
		</display:column>
		<display:column property="createdate" title="创建时间" sortable="true"style="white-space:nowrap;"  class="center" headerClass="center"></display:column>

	
		<display:setProperty name="paging.banner.placement" value="bottom" />		
	</display:table>
	<s:hidden name="information.type" value="${information.type}"/>  
</s:form>
</center>
</body>
</html>
