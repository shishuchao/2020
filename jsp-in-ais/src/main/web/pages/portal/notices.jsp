<%@ page language="java" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
  <head>    
    <title>系统通知</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resources/css/simple.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		div{
			display:block;
			width:100%;
			white-space:nowrap;
			float:left;
			white-space:nowrap;
			overflow:hidden;
			word-break:break-all;
		    -o-text-overflow: ellipsis;    /**//* for Opera */
		    text-overflow:ellipsis;        /**//* for IE */
		}
		div:after{
			content:"...";
			padding-left:3px;
			font-size:12px;
		}
	</style>
  </head>
  <body style="background-color: #FFFFFF;">
    
		<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
			<s:iterator value="systemNotices" id="row">
				<tr>
					<td height="25" class="line" nowrap="nowrap"> 
					<div>
						<a
							onclick="window.open('/ais/bpm/systemprompt/viewDetailSystemPrompt.action?id=${row.id }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
							href="javascript:void(0);" title="${row.description}">
							${row.description}
						</a></div>
					</td>
				</tr>
			</s:iterator>
		</table>
  </body>
</html>
