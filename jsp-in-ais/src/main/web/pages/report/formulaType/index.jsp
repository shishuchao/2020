<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>公式类别</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<style type="text/css"> 
			#container{
				width:100%;height: 90%;
			}
			#content{
				width: 20%;text-align: left;float: left;height: 100%;
			}
			#sidebar{
				width: 80%;text-align: left;float: right;height: 100%;
			}
		</style>
	</head>
<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable">
			<tr class="listtablehead">
				<td  align="left" class="edithead">
					<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/formulatype/index.action')" />
				</td>
			</tr>
		</table>
<div id="container">
  <div id="content">
	<iframe name="leftTree" width="100%" frameborder="0" height="100%" 
	src="<s:url action="tree" namespace="/report/formulatype"></s:url>"></iframe>
  </div>
  <div id="sidebar">
	<iframe name="childBasefrm" width="100%" frameborder="0" height="100%" src="about:blank"></iframe>
  </div>
</div>
</body>
</html>