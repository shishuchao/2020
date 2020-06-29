<%@page import="ais.framework.util.StringUtil"%>
<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
  <head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue()
{		
	var nameStr=configtree.GetSelectedValue();
	var len=nameStr.length;
	if(nameStr.charAt(len-1)==','){	
		nameStr=nameStr.substring(0,len-1);
	}
  	document.all("paranamevalue").value=nameStr;
  	
  	var idStr=configtree.GetSelected();
  	var leng=idStr.length;
	if(idStr.charAt(leng-1)==','){	
		idStr=idStr.substring(0,leng-1);
	}
  	document.all("paraidvalue").value=idStr;
}
function chkall(){
	configtree.CheckAllNodes();
}
function allNochk(){
	configtree.UnCheckAllNodes();
} 
</script>
  </head>

<body style="margin-top: 3px;">
<div id="m_div" style="text-align:right;">
	<table border=0 cellspacing=1 cellpadding=1>
		<tr>
		<td>
			<div id="oneSelect" class="imgbtn" style="width:50px;" Imgsrc="/ais/resources/images/sall.gif" Background="#D2E9FF" Text="全选" onclick="chkall();"></div>					
			</td>
			<td>	
			<div id="oneSelect2" class="imgbtn" style="width:50px;" Imgsrc="/ais/resources/images/sall.gif" Background="#D2E9FF" Text="全不选" onclick="allNochk();"></div>
			</td>
			<td><div style="width:10px;"></div></td>
		</tr>
	</table>
</div>
<s:if test="${empty (audited_dept_Tree)}">
	<div align="center">
	<h4 style="color: red">没有对应的被审计单位</h4>
	</div>
</s:if>
<s:else>
<%
	String auditObjectSelectCascade = SysParamUtil.getSysParam("ais.plan.selectauditobject.cascade");
	if(StringUtil.notEmpty(auditObjectSelectCascade) && auditObjectSelectCascade.equals("enabled")){
%>
	<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00" SelectSub="true">
<%
	}else{
%>
	<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00" SelectSub="false">
<%
	}
%>
	<p title="所有被审计单位" sid="x1" pid="0"></p>
	<s:iterator value="#request.audited_dept_Tree">
		<s:if test="${parentId=='0'}">
	   	<p title="<s:property value="name"/>" sid="<s:property value="id"/>" pid="x1" ></p>
	   </s:if>
	   <s:else>
	   	<p title="<s:property value="name"/>" sid="<s:property value="id"/>" pid="<s:property value="parentId"/>" ></p>
	   </s:else>
	</s:iterator>
</div>
</s:else>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
  </body>
</html>