<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function RightGo(id,name)
{
<s:url id="url"    action="uSystemAction"  method="getUserList" namespace="/system"/>
var url='<s:text name="%{url}"/>';
if(url.indexOf('?')!=-1)
url=url+'&amp;';
else
url=url+'?';
  parent.main.location.href=url+'p_deptid='+id+'&amp;p_deptname='+encodeURIComponent(name);
}
function tip(){
	alert("抽调人员时,禁止调用本单位人员!");
}
function changeVg(){
//parent.main.location.href='';
<s:url id="vgurl"    action="uSystemAction"  method="getVgList4user" namespace="/system"/>
window.location.href='<s:text name="%{vgurl}"/>';
}
</script>
  </head>
  <%
  	String string=request.getParameter("extend");
  	request.setAttribute("extend",string);
   %>
  <body>
  <!-- 
  <input type="radio" name="rgname" checked="checked"/>组织机构&nbsp;&nbsp;<input type="radio" name="rgname" onclick="changeVg()"/>人员群组
   -->
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
<s:iterator value="#request.orgtree"  id="row">
	<s:if test="${not empty(extend) and row.fcompanyid==company.fcompanyid}">
            <p  title="<s:property value="fname"/>" sid="<s:property value="fid"/>"  pid="<s:property value="fpid"/>" click="tip()"></p>
	</s:if>
	<s:else>
           <p  title="<s:property value="fname"/>" sid="<s:property value="fid"/>" pid="<s:property value="fpid"/>" click="RightGo('<s:property value="fid"/>','<s:property value="fname"/>')"></p>
	</s:else>
</s:iterator>
</div>
<br><input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
 <div id="sellist" class="datalist" ondelrow="reCount()"></div>
  </body>
</html>