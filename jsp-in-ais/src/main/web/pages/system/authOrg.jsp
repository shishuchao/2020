<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>数据授权 </title>
	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>

<%--<% String m_ulname=request.getParameter("userLoginName");
	String ulname=null;
	String outtext="被授权人:";
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

var ay=getParameter(window.location.href);
var viewtype="";//add 20080416
var globalRoleType="";//20080428
var companyId="";//20080428
for (var i=0;i<ay.length;i++)
{
   if (ay[i].name.toLowerCase()=="url")
   {
	 url=ay[i].value;
		//add
<%--		//url=url+"?selectName="+encodeURIComponent('<%=sn%>')--%>
		url=url+"?selectName="+encodeURIComponent('<%=request.getParameter("p_froleid")%>')
   }
   if(ay[i].name.toLowerCase()=='view'){
   	viewtype=ay[i].value;
   }
   if(ay[i].name.toLowerCase()=='fscopecode'){
   	globalRoleType=ay[i].value;
   }
   if(ay[i].name.toLowerCase()=='companyid'){
   	companyId=ay[i].value;
   }
}
//document.all.selectspace.src=url+"?method="+dmethod+extend;
if(viewtype.length>1){
	url=url+"&view="+viewtype;
}
if(globalRoleType.length>1){
	url=url+"&fscopecode="+globalRoleType;
}
if(companyId.length>=1){
	url=url+"&companyId="+companyId;
}
document.all.toLinkFrame.src=url;
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
window.close();
//window.parent.hidePopWin(false);

}

</Script>
</head>

<body class="easyui-layout" fit="true" border='0'>
	<div region="west" style="width:150px;" split="true" border='0'>
		<ul id="moduleTree" style="padding: 10px;"></ul>
	</div>
	<div region="center" style="overflow: hidden;"  border='0'>
		<iframe id="selectspace" name="selectspace" src="" frameborder=0  width="100%"  height="100%"></iframe>
		<s:form action="saveToAuthUserModule" namespace="/system">
			<!--数据存储位置-->
			<input type="hidden" id="paraName" name="paraName">
			<input type="hidden" id="paraIDs" name="paraIDs">
			<input type="hidden" id="selectName" name="selectName" value="<%=request.getParameter("p_froleid")%>">
		</s:form>
	</div>

<script type="text/javascript">
	$(function(){
		$('#moduleTree').tree({
			url:'${contextPath}/system/allDataAuthModules.action?selectName='+encodeURIComponent('${param.p_froleid}'),
			method:'get',
			animate:true,
			cache:false,
			lines:true,
			onClick:function(node){
				$('#selectspace').attr('src',node.attributes.fcfgclass+'?view=${param.view}&fmoduleId='+node.id+'&selectedLoginName=${param.p_froleid}');
			}
		});
	});
</script>
</body>
</html>
