<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<TITLE> user </TITLE>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>

	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
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
 var checknode=document.getElementsByName("checkvalue");
 var i=checknode.length;
  var vs="";
  if(i=="0" || i==""){
  return vs;
  } else{
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
if(array[1]=='<%=((ais.user.model.UUser)session.getAttribute("user")).getFloginname()%>'){
	alert("禁止对本人赋予权限");
		return false;
	}
var loginname=array[1];
showPopWin("../system/authAuthorityAction!authoritySet.action?p_floginname="+loginname,700,500,'权限设置');
 }
 function test(){
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
if(array[1]=='<%=((ais.user.model.UUser)session.getAttribute("user")).getFloginname()%>'){
	alert("禁止对本人赋予权限");
		return false;
	}
 	showPopWin('/ais/pages/system/authOrg.jsp?userLoginName='+array[1]+'&url=/ais/system/allDataAuthModules.action',800,550,'数据授权');
 }
 function showOwnAllRoles(){
 	var s=getCheckValue();
 	if(s==""){alert("请选择要设置权限的用户.");return(false);}
 	if(s.indexOf(";")!=-1){alert("只能选择一项.");return(false);}
	var array=s.split(",");
	var loginname=array[1];
	showPopWin("../system/authAuthorityAction!authAllRoleSet.action?p_floginname="+loginname,700,500,'用户角色');
 }
 function selDept(){
 
 	var url='<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url='+window.parent.document.getElementsByName('left')[0].src+'&paraname=p_deptname&paraid=p_deptid&p_item=2';
 	//alert(url);
 	
 	showPopWin(url,300,250,'组织机构选择');
 }
 function setfmid(obj,otherName){
		var str;
		str=obj.options[obj.selectedIndex].text;
		document.getElementsByName(otherName)[0].value=str;
	}
	function chkall(){
	var inputs=document.getElementsByName("checkvalue");
	if(inputs){
		for(var i=0,j=inputs.length;i<j;i++){
			inputs[i].checked=true;
		}
	}
}
function allNochk(){
	var inputs=document.getElementsByName("checkvalue");
	if(inputs){
		for(var i=0,j=inputs.length;i<j;i++){
			inputs[i].checked=false;
		}
	}
}
</script>
<style type="text/css">
#m_div table {
	border:0 ;
	margin: 0 0 0 0 !important;
	width: 40px;
}
#m_div td {
	padding: 0 0 0 0 !important;
	text-align: right;
}
table{
	margin: 2px 0 20px 0 !important;
}
</style>
</HEAD>
<BODY topmargin=0 leftmargin=0> 
<div id="ais_divselect"></div>
<div id="m_div" style="text-align:right;">
	<table border=0 cellspacing=1 cellpadding=1>
	<tr>
	<td>
		<div id="oneSelect" class="imgbtn" style="width:50px;" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="全选" onclick="chkall();"></div>					
		</td>
		<td>	
		<div id="oneSelect2" class="imgbtn" style="width:50px;" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="全不选" onclick="allNochk();"></div>
		</td>
		<td><div style="width:10px;"></div></td>
	</tr>
	</table>
</div>

<display:table name="roleList" id="row" class="its" pagesize="10" requestURI="${pageContext.request.contextPath}/systemnew/getRoleListByCompany.action?method=list&paraid=bpmTask.assign_policy_string&p_issel=${p_issel}&p_item=${p_item}&p_deptid=${p_deptid}&p_deptname='${p_deptname}'" excludedParams="*">
			<display:column title="选择"  style="width:30" headerClass="center" class="center">
			<input type="checkbox" id="node${row_rowNum}" name="checkvalue" isnode="true" value="${row.fcompanyid},${row.froleid},${row.fname},${requestScope.p_deptname}"/>
    		</display:column> 
			<display:column  title ="角色名称" property ="fname" sortable="true" headerClass="center" class="center"></display:column>
			
			</display:table>
<input type="hidden" name="rowcount" value="${row_rowNum}">
<table cellpadding="0" cellspacing="0"></table>
</BODY>
</HTML>