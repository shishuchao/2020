<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> user </TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<link href="<%=request.getContextPath()%>/styles/blue/ufaud.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/styles/displaytag/maven-base.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/styles/displaytag/maven-theme.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/styles/displaytag/site.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/styles/displaytag/screen.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/styles/displaytag/print.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<script language="Javascript">

function RightGo(url)
{

 parent.mainFrame.location.href=url;
 }
 function getCheck(){
 alert(configtree.GetSelected());
 }
 
  function getCheckValue(){
 
  var i=document.all("rowcount").value;
  var vs="";
  if(i=="0" || i==""){
  return vs;
  } else{
   for(var j=1;j<=i;j++){
     check=document.getElementById("node"+j);
     if(check.checked){
     if(vs=="")
     vs=check.value;
     else
     vs=vs+";"+check.value;
     }
    
   }
  }
  return vs;
 }
 function doPermission(){
 var s=getCheckValue();
 if(s==""){
 alert("请选择要设置权限的用户.");
 return(false);
 }
 if(s.indexOf(";")!=-1){
		alert("只能选择一项.");
		return(false);
		}
var array=s.split(",");
var loginname=array[1];
showPopWin("../system/authAuthorityAction!authoritySet.action?p_floginname="+loginname,700,550,'权限设置');
 }
</script>
</HEAD>
<BODY topmargin=0 leftmargin=0>
<display:table name="userlist" id="row" class="its" pagesize="10"> 
			<display:column title="选择"  style="width:30" headerClass="center" class="center">
			<input type="checkbox" id="node${row_rowNum}" isnode="true" loginname="${row.floginname}" value="${row.fuserid},${row.floginname},${row.fname},${requestScope.p_deptname}"/>
    		</display:column> 
			<display:column  title ="登录名称" property ="floginname" headerClass="center" class="center"></display:column>
			<display:column  title ="真实姓名" property ="fname" headerClass="center" class="center"></display:column>  
			<display:column  title ="编码" property ="fcode" headerClass="center" class="center"></display:column> 
			
			
				</display:table>
<input type="hidden" name="rowcount" value="${row_rowNum}">
</BODY>
</HTML>