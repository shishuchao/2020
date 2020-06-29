<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <script  language="javascript">
  function rightGo(url){

  document.all.orgtree.src=url; 
  }
  </script>
  </head>
  
  <body>
  <table width="100%" height="100%">
  <tr><td align="left" valign="top">
   <ul>
        <li>
        <s:url id="url"  action="../uCompanyAction" method="tree" />
<s:a  href="javascript:void(0);" onclick="rightGo('%{url}')">组织机构</s:a>
        </li>
         <li>
        <s:url id="url"  action="../uCompanyAction" method="tree" />
<s:a href="%{url}">人员设置</s:a>
        </li>
        </ul>
 </td><td align="left" >
 <iframe id="orgtree"  height="100%" width="80%" align="left" ></iframe>
 </td></tr>
  </table>

</body>
</html>
