<!DOCTYPE HTML >
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<s:text id="title" name="'方案查看'"></s:text>
<html>
<script language="javascript">
function goedit(){
//返回上级list页面
	location.href='${contextPath}/pages/operate/template/template2_programme.jsp?pro_id=${audProgramme.pro_id}&pb=true&';

}
function goedit2(){
//返回上级list页面
	window.open('${contextPath}/pages/operate/task/task_tree2_ready.jsp?pro_id=${audProgramme.pro_id}&pb=true&','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

}

function goView2(){
	var h = window.screen.availHeight;
	var w = window.screen.width;
 
			check="1";
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
			win = window.open('${contextPath}/operate/task/mainReadyView.action?project_id=${project_id}','ready',',"height=768,width=1024,status=no,toolbar=no,menubar=no,location=no,resizable=no');
			//win = window.open('<%=request.getContextPath()%>/pages/operate/index.jsp?pro_id='+projectCodeRadios[i].value,'cw11',',"height='+h+',width='+w+',status=yes,toolbar=yes,menubar=yes,location=yes,resizable=yes');
			win.moveTo(0,0)   
			win.resizeTo(w,h) 
			if(win && win.open && !win.closed) 
              win.focus();

	}
</script>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<div align="center" > 
<s:form id="myform"  action="view" namespace="/mng/train/train" >

<table class="ListTable">
	<tr><td colspan="5" style="text-align: center;"   class="EditHead"><s:property value="#title"/></td></tr>
</table>


	
<table  class="ListTable" >
	

		 
	
<tr>
<td class="EditHead" style="width:15%">方案名称</td><td class="editTd" style="width:85%" COLSPAN="3"><a href="javascript:void(0);" onclick="goView2()"><s:property value="audProgramme.programmeName"/></a></td>
</tr>
		 
	 
<tr>
<td class="EditHead" style="width:15%">方案类别</td><td class="editTd" style="width:35%"><s:property value="audProgramme.typeName"/></td>
 
<td class="EditHead" style="width:15%">方案版本</td><td class="editTd"  style="width:35%"><s:property value="audProgramme.proVer"/></td>
</tr>
		 
	
<tr>
<td class="EditHead">编制人</td><td class="editTd"><s:property value="audProgramme.proAuthorName"/></td>
 
<td class="EditHead">编制日期</td><td class="editTd"><s:property value="audProgramme.proDate"/></td>
</tr>
</table>

<s:hidden name="audProgramme.pro_id"/>  
<s:hidden name="audProgramme.project_id"/> 
 
</s:form>
</div>
</body>
</html>
