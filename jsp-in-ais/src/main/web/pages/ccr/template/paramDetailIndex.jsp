<!--PAGEID:5767B5C1-2069-3F5E-811F-C8BB39AF93FD-->
<%@ page contentType="text/html;charset=GBK"%>

<%
	String result=(String)request.getAttribute("result");
	if(result!=null){
	 	if(result.equals("1")){
			result="±£´æ³É¹¦£¡";
		}
		else
			result="±£´æÊ§°Ü£¬ÇëÖØÊÔ£¡";
		
		//ÒÆ³ýresult
		request.removeAttribute("result");
	}
	else
		result="";
%>

<html>
<head>
<script language="javascript">
function init()
{
	if("<%=result%>"!=""){
		alert("<%=result%>");
		window.close();
		var url = window.parent.dialogArguments.document.location;
		window.parent.dialogArguments.document.location.href=url;
	}
}
</script>
</head>
<body>
<script language="javascript">
init();
</script>
<iframe src="${contextPath }/ccrTemplate/paramDetailEdit.action?paramId=${paramId }&sheetName=${sheetName }" width="100%" height="100%" scrolling="yes" frameborder="0"></iframe>
</body>
</html>
