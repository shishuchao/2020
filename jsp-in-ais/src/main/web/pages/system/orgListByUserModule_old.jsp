<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List,ais.auth.model.AuthUserModule,ais.organization.model.UOrganization"%>
<html>
  <head>
 <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="Javascript">
function getSelectedValue()
{
  document.all("paraName").value=configtree.GetSelectedValue();
  document.all("paraIds").value=configtree.GetSelected();
  
  document.all("selectedLoginName").value=window.parent.document.getElementsByName("selectName")[0].value;
  document.forms[0].submit();
 // window.parent.parent.hidePopWin(false);
}
function doClose(){
window.parent.close();
	//window.parent.parent.hidePopWin(false);
}
function allSelected(){// 所有的复选框都被选中
	configtree.CheckAllNodes();
}
function allNoSelected(){
	configtree.CancelAllNodes();
};
</script>
  </head>
  
  <body >
  <s:if test="${empty(view) or user.floginname=='admin'}">
	  <table border=0 cellspacing=1 cellpadding=1 width=95% >
	<tr>
	<td width=60%>
		<td>
		<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="保存" onclick="getSelectedValue()"></div>
		</td>
		<td width=10 nowrap></td>
		<td>
		<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="doClose()"></div>
		</td>
		<td width=10 nowrap></td>
		<td>	
		<div id="oneSelect" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="全选" onclick="allSelected();"></div>					
		</td>
		<td>	
		<div id="oneSelect2" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="反选" onclick="allNoSelected();"></div>					
		</td>
	</tr>
	</table>
</s:if>
  <!-- ******* -->
 <s:if test="${empty(view) or user.floginname=='admin'}"> 
<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00" SelectSub="false"  ShowAll="true">
</s:if>
<s:else>
<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00" CheckDisabled="true">
</s:else>
<%
	 List orgList=(List)request.getAttribute("orgList");
 	 List aumList=(List)request.getAttribute("aumList");
 	 UOrganization org;
 	 for(int i=0;i<orgList.size();i++){
 	 	org=(UOrganization)orgList.get(i);
 	 	String checked="false";
 	 	for(int j=0;j<aumList.size();j++){
 	 		if(aumList.get(j)!=null){
 	 			String id=((AuthUserModule)aumList.get(j)).getFvalue();
 	 			if(id.equals(org.getFid().toString())){
 	 				checked="true";
  					break;
 	 			}
 	 		}
 	 	}
 %>
<p  title="<%=org.getFname()%>" sid="<%=org.getFid()%>" pid="<%=org.getFpid()%>"   value="<%=org.getFid()%>" checked="<%=checked%>"></p>
<%}%>
</div>

<s:form action="saveToAuthUserModule" namespace="/system">
<!--数据存储位置-->
<input type="hidden" id="paraName" name="paraName">
<input type="hidden" id="paraIds" name="paraIds">
<input type="hidden" id="companyId" name="companyId" value="${companyId}">
<input type="hidden" id="selectedLoginName" name="selectedLoginName">
<s:hidden name="fmoduleId"></s:hidden>
</s:form>
  </body>
</html>