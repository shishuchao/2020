<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<style type="text/css"> 
			#container{
				width:100%;height: 100%;
			}
			#content{
				width: 260px; text-align: left;float: left;height: 100%;display: '';
			}
			#sidebar{
				text-align: left;float: right;height: 100%; vertical-align: top;
			}
			#formula{
				text-align: left;float: right;height: 100%; vertical-align: top;
			}
			#treefrm{
				border-style: double;
			}
			#formulafrm{
				border-style: dotted;border-width: 1px;
			}
		</style>
		
	</head>
<body topmargin="5" leftmargin="5" rightmargin="5">
<div id="container">
  <div id="content">
	<iframe name="treefrm" id="treefrm" width="100%" frameborder="0" height="100%" src="<s:url action="listFormula" namespace="/ccrFormula"></s:url>"></iframe>
  </div>
  <div id="formula">
  	<iframe name="formulafrm" id="contentfrm" width="100%" frameborder="0" height="100%" src="<s:url action="editFormula" namespace="/ccrFormula"></s:url>"></iframe>
  </div>
</div>
</body>
</html>