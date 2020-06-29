<%@ page contentType="text/html; charset=GBK" %>

<html>
<HEAD>
<TITLE>请稍候……</TITLE>
</HEAD>

<STYLE>
 body{background-color:#C0C0C0;	font-size:10pt;cursor:wait;}
</STYLE>

<body>

<table aign="center" valign="center" width="100%" height="100%" border="0">
  <tr>
    <td  width="100%" align="center" valign="center" >
      <div aign="center" valign="center" style="background:#E4E4E4;padding:20px;width:200px; height:55px; border:1px solid #666666;font-size:10pt;">
        数据处理中, 请稍候……
      </div>
    </td>
  </tr>
</table>

</body>
</html>

<%
String url=request.getParameter("url");
url=url.replace('$','&');
%>
<SCRIPT LANGUAGE=javascript>
  window.location.href="<%= url%>";
</SCRIPT>