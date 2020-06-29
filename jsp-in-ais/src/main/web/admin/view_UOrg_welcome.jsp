<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
    

<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

<title>组织机构设置</title>
<script language="javascript" type="text/javascript" src="../css/normal.js"></script>
<link href="../css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">

function RightGo(id,type)
{
	 //alert(url);
	 //if(type=='C')
 		parent.maintest.location.href='editUOrg.action?view=view&uOrganization.fid='+id;
 	
 }
 function getCheck(){
 	//alert(configtree.GetSelected());
	//alert(configtree.GetSelected().length-1);
	 s=configtree.GetSelected();
	//alert(s.substring(0,s.length-1));
	menuForm.fpid.value=s.substring(0,s.length-1);
 }
 
 function addTypett(s){
 id=document.all("paranamevalue").value;
 //alert(id);
 	menuForm.m_type.value=s;
 	 alert(menuForm.m_type.value);
 	
 	menuForm.target=parent.maintest;
 	menuForm.submit();
 	
 }
 function getSelectedValue(id,name)
{
  document.all("paranamevalue").value=name;
  document.all("paraidvalue").value=id;
}
</script>

</head>
<body>
<s:form id="menuForm" action="editUOrg" namespace="/admin" >
<%--<input type="button"  value="增加公司"　onclick="addTypett('C')" >
<input type="button" name="addDept" value="增加部门"　onclick="addType(D);"/>

<a onclick="addTypett('C')" >增加公司</a><br><!-- 点击公司　提交　fpid -->
<a onclick="addTypett('D')" >增加部门</a>
--%>
<s:hidden name="m_type"></s:hidden>
<s:hidden name="uOrganization.fid" value="0"></s:hidden>
<s:hidden name="fpid"></s:hidden>
<div class="TreeView" id="configtree" onclick="getCheck();" Checkbox="0" SelectedColor="#FFFF00">


<s:iterator value="uOrgList">
   <p  title="<s:property value="fname"/>" sid="<s:property value="fid"/>" pid="<s:property value="fpid"/>" click="RightGo('<s:property value="fid"/>','<s:property value="ftype"/>')"></p>
</s:iterator>




</div>

<%--<div id="save" class="imgbtn" Imgsrc="../images/save.gif" Background="#D2E9FF" Text="save" onclick="getCheck();"></div>--%>
<input type="hidden" name="paraidvalue" value="0"/>
<input type="hidden" name="paranamevalue"/>
</s:form>
<%--<a href="search_UOrg.jsp" >测试搜索</a>--%>
</body>
</html>
