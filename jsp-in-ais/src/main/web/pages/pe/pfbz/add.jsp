<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='/ais/dwr/engine.js'></script>
<script type='text/javascript' src='/ais/dwr/util.js'></script>
<s:if test="status=='add'">
	<s:text id="title" name="'绩效考核--评分标准'"></s:text>
</s:if>
<s:if test="status=='update'">
	<s:text id="title" name="'修改绩效考核--评分标准'"></s:text>
</s:if>

<html>
	<head>
		<title><s:property value="#title" />
		</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
					<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/validateCommon.js"></script>
		<s:head />
	</head>

	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						&nbsp;
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form name="myform" action="save" namespace="/pe/pfbz" >
				<s:hidden name="pfbz.id"></s:hidden>
				<s:hidden name="pfbz.status"></s:hidden>
				<s:hidden name="pfbz.cts"></s:hidden>
				<s:hidden name="pfbz.creator"></s:hidden>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>评分标准名称:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="pfbz.name" maxlength="200" onkeyup="testName()"/>
						</td>
					</tr>
				</table>
				<s:if test="status=='add'">
					<s:button value="保存" onclick="saveForm(0);" />&nbsp;&nbsp;
				</s:if>
				<s:else>
					<s:button value="保存" onclick="saveForm(1);" />&nbsp;&nbsp;
                </s:else>


				&nbsp;&nbsp;	
				<input type="button" name="back" value="返回"
					onclick="javascript:window.location='<s:url action="listAll"></s:url>'">
			</s:form>

		</center>

	</body>


	<script language="javascript"> 
     function check(){
       return (frmCheck(document.forms[0],'project_table'));  
    }
	
function saveForm(type){
	if(!check()){//前端验证
	   return false;
	}
    if(!numberValidate_out('pfbz.name',50,'评分标准名称')){      
      return false;
    }
	var url='';
      if(type==0){
         if(window.confirm("执行添加评分标准操作吗?")){
	   url="${contextPath}/pe/pfbz/save.action";
	   myform.action = url;
	
	   myform.submit();//提交表单
	   }
      
      }
      else{
         if(window.confirm("执行修改评分标准操作吗?")){
	   url="${contextPath}/pe/pfbz/update.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax验证不能重名
var name_value=document.getElementsByName('pfbz.name')[0].value;
DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/pfbz', action:'testSameName', executeResult:'false' },{'status':name_value},xxx1);}
function xxx1(data){

if(data['status']=='yes'){
	window.alert("评分标准名称已经存在，请换一个试试!");
	document.getElementsByName('pfbz.name')[0].value="";
	document.getElementsByName('pfbz.name')[0].focus();
	return false;
}
  
} 


</script>



</html>

