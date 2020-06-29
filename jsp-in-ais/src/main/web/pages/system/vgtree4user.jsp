<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function RightGo(id,name)
{
<s:url id="url"    action="uSystemAction"  method="getVgUserList" namespace="/system"/>
var url='<s:text name="%{url}"/>';
if(url.indexOf('?')!=-1)
url=url+'&amp;';
else
url=url+'?';
  parent.main.location.href=url+'p_vgid='+id;
}
function tip(){
	alert("抽调人员时,禁止调用本单位人员!");
}
function changeOrg(){
<s:url id="orgurl"    action="uSystemAction"  method="orgList4user" namespace="/system"/>
//window.location.href='<s:text name="%{orgurl}"/>';
window.location.href='<%=request.getContextPath()%>/pages/system/morg/morg4user.jsp';
}
</script>
  </head>
  <%
  	String string=request.getParameter("extend");
  	request.setAttribute("extend",string);
   %>
  <body>
  <!-- 
  <input type="radio" name="rgname"  onclick="changeOrg()"/>组织机构&nbsp;&nbsp;<input type="radio" name="rgname" checked="checked"/>人员群组
   -->
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
<s:iterator value="#request.vgtree"  id="row">
<p  title="<s:property value="name"/>" sid="<s:property value="id"/>" pid="0" click="RightGo('<s:property value="id"/>','<s:property value="name"/>')"></p>
</s:iterator>
</div>
<br><input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
 <div id="sellist" class="datalist" ondelrow="reCount()"></div>
  </body>
</html>