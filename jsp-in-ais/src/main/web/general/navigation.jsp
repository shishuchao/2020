<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> navigation </TITLE>
<script language="javascript" type="text/javascript" src="../css/normal.js"></script>
<link href="../css/site.css" rel="stylesheet" type="text/css">

<script language="Javascript">

function RightGo(url)
{
 parent.allFrame.location.href=url;
 }
 function getCheck(){
 alert('00');
 alert(configtree.GetSelected());
 }
</script>
</HEAD>
<BODY  topmargin=0 leftmargin=0>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00" topVisible="false">
<p title="" sid="1" pid="0"></p>
<%--<p title="组织机构维护" sid="2" pid="1" click="RightGo('orgindex.jsp')"></p>
<p title="人员维护" sid="3" pid="1" click="RightGo('uuser_index.jsp')"></p>
<p title="测试树" sid="4" pid="1" ></p>
<p title="部门1" sid="5" pid="4" ></p>
<p title="部门2" sid="6" pid="4" ></p>
<p title="基础数据" sid="100" pid="1" click="RightGo('<s:url action="list" namespace="/basic/codename"><s:param name="type" value="1002"/></s:url>')')"></p>


--%><p title="密码修改" sid="3" pid="1" click="RightGo('changePassWord.jsp')"></p>
<p title="注销" sid="4" pid="1" click="RightGo('<%=request.getContextPath()%>/j_acegi_logout')"></p>


</div>

</BODY>
</HTML>
