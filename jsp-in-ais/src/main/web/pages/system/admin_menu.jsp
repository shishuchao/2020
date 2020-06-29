<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<jsp:directive.page import="ais.user.model.UUser"/>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>权限授权</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<%--<% String m_ulname=request.getParameter("userLoginName");
	
	String ulname=null;
	String outtext="被授权人帐号:";
	String sn="";//selectname
	if(m_ulname!=null&&m_ulname.contains("888_")){
		m_ulname=new String(m_ulname.getBytes("iso8859-1"),"utf-8");//add 2008.2.20
		sn=m_ulname.substring(0,m_ulname.lastIndexOf("_"));
		outtext="被授权角色:";
		ulname=m_ulname.substring(m_ulname.lastIndexOf("_")+1,m_ulname.length());
	}else{
		ulname=m_ulname;
		sn=m_ulname;
	}
 %>
--%><Script language=Javascript>
function RefreshWin()
{
var url="";
var viewtype="";
var ay=getParameter(window.location.href);
for (var i=0;i<ay.length;i++)
{
   if (ay[i].name.toLowerCase()=="view")
   {
	 viewtype=ay[i].value;
   }
}

url='/ais/system/getMenuListForUserModule.action';
url=url+"?selectedLoginName="+encodeURIComponent('<%=request.getParameter("p_froleid")%>');
url=url+"&fmoduleId=3002"
if(viewtype.length>1){
	url=url+"&view="+viewtype;
}
//document.all.selectspace.src=url+"?method="+dmethod+extend;
document.all.selectspace.src=url;
}

function GetParamater()
{
	
    if (selectspace.document.all("paranamevalue")!=null&&selectspace.document.all("paraidvalue")!=null)
	{
			selectspace.getSelectedValue();
	          var namevalue=selectspace.document.all("paranamevalue").value;
		  var idvalue=selectspace.document.all("paraidvalue").value;
                  var fun=document.all.funname.value;
                  //---
                  	document.getElementById('paraName').value=namevalue;
                  	document.getElementById('paraIDs').value=idvalue;
                  	if(document.getElementById('paraName').value==""){
                  		alert("没有选中数据对象是不可以保存的");
                  		return false;
                  	}
                  	document.forms[0].submit();
                  //---
	}
	else
	{
	  alert("无法获取到有效参数!");
	}
	
	
}
function doClose(){
//window.close();
window.parent.hidePopWin(false);

}

</Script>
</HEAD>

<BODY  topmargin=2 leftmargin=2 onload="RefreshWin();">

<table border=0 cellspacing=0 width=100% align=center height="100%">
<tr><td colspan="2"><img src="<%=request.getContextPath()%>/resources/images/tip.gif" border=0>&nbsp;<b><%=request.getAttribute("outtext")%> &nbsp; <%=request.getAttribute("fname") %></b></td></tr>
<tr>

<td align=center  height="100%">
<iframe id="selectspace" name="selectspace" src="" frameborder=0  width="100%"   height="100%"></iframe>
</td></tr>

</table>
<s:form action="saveToAuthUserModule" namespace="/system">
<!--数据存储位置-->
<input type="hidden" id="paraName" name="paraName">
<input type="hidden" id="paraIDs" name="paraIDs">
<input type="hidden" id="selectName" name="selectName" value="<%=request.getParameter("p_froleid")%>">
</s:form>
</BODY>
</HTML>
