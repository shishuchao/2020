<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/scripts/treepanel/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/treepanel/TreePanel.js"></script>
<script language="Javascript">
function RightGo(node)
{
<s:url id="url"    action="getRoleListByCompany" namespace="/systemnew"/>
var url='<s:text name="%{url}"/>';
if(url.indexOf('?')!=-1)
url=url+'&amp;';
else
url=url+'?';
  parent.main.location.href=url+'p_deptid='+node.id+'&amp;p_deptname='+encodeURIComponent(node.text);
}

</script>
  </head>
  <body>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
  	<script type="text/javascript">
		var tree = new TreePanel({
				'root' : ${jsonResult}
			});
			tree.addListener('click',RightGo);
			tree.iconPath='${contextPath}/scripts/treepanel/img/';
			tree.showSelectBox = false;
			tree.render();
	</script>
</div>
<br><input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
 <div id="sellist" class="datalist" ondelrow="reCount()"></div>
  </body>
</html>