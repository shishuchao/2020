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
 /*
  function getCheckValue(){
var i=document.all("rowcount").value;
  var vs="";
  if(i=="0" || i==""){
  return vs;
  } else{
   for(var j=1;j<=i;j++){
   alert(j);
     check=document.getElementById("node"+j);
     if(check!=null&&check!=''){
	     if(check.checked){
	     if(vs=="")
	     vs=check.value;
	     else
	     vs=vs+";"+check.value;
	     }
    }
   }
  }
  return vs;
 }
 */
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
</script>
</HEAD>
<BODY topmargin=0 leftmargin=0> 

<div id="ais_divselect"></div>
<display:table name="list" id="row" class="its" requestURI="/mng/employee/employeeInfoList4Agency.action?interoryId=${interoryId}" excludedParams="*"
		pagesize="${baseHelper.pageSize}" partialList="true" 
		size="${baseHelper.totalRows}" sort="external"
		defaultsort="2" defaultorder="descending">
			<display:column title="选择"  style="width:30" headerClass="center" class="center">
			<input type="checkbox" id="node${row_rowNum}" name="checkvalue" isnode="true" loginname="${row.id}" value="${row.id},${row.id},${row.name},${row.agency}"/>
    		</display:column> 
			<display:column  title ="真实姓名" property ="name" sortable="true" headerClass="center" class="center"></display:column>  
			<display:column  title ="所属单位" property ="agency" sortable="true"  headerClass="center" class="center"></display:column> 
			</display:table>
<input type="hidden" name="rowcount" value="${row_rowNum}">

</BODY>
</HTML>