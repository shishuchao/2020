<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<TITLE>经济责任人</TITLE>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>

<script language="Javascript">
function RightGo(url){
	parent.mainFrame.location.href=url;
}
function getCheck(){
	alert(configtree.GetSelected());
}
function getCheckValue(){
	var checknode=document.getElementsByName("checkvalue");
	var i=checknode.length;
	var vs="";
	if(i=="0" || i==""){
  		return vs;
	}else{
		for(var j=0;j<i;j++){
			if(checknode[j].checked){
			if(vs=="")
			vs=checknode[j].value;
			else
			vs=vs+";"+checknode[j].value;
			}
		}
	}
	return vs;
}
function selDept(){
 	var url='<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url='+window.parent.document.getElementsByName('left')[0].src+'&paraname=p_deptname&paraid=p_deptid&p_item=2';
 	showPopWin(url,300,250,'组织机构选择');
}
function setfmid(obj,otherName){
	var str;
	str=obj.options[obj.selectedIndex].text;
	document.getElementsByName(otherName)[0].value=str;
}
</script>
</HEAD>
<body topmargin=0 leftmargin=0>
	<div id="ais_divselect"></div>
	<display:table name="selList" id="row" class="its" pagesize="10" requestURI="" excludedParams="*">
		<display:column title="选择"  style="width:30" headerClass="center" class="center">
			<input type="checkbox" id="node${row.id}" name="checkvalue" isnode="true" value="${row.id},${row.name}"/>
   		</display:column> 
		<display:column title ="姓名" property="name" sortable="true" headerClass="center" class="center"></display:column>
		<display:column  title ="所属单位" property="company" sortable="true" headerClass="center" class="center"></display:column>  
	</display:table>
	<input type="hidden" name="rowcount" value="${row_rowNum}">
	<table cellpadding="0" cellspacing="0"></table>
</body>
</html>
