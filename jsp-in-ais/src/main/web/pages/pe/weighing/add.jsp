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
	<s:text id="title" name="'添加时效性考核--权重'"></s:text>
</s:if>
<s:if test="status=='update'">
	<s:text id="title" name="'修改时效性考核--权重'"></s:text>
</s:if>

<html>
	<head>
		<title><s:property value="#title" /></title>
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
			<s:form id="myform" action="save" namespace="/pe/weighing">
				<s:hidden name="weighing.id"></s:hidden>
				<s:hidden name="status"></s:hidden>

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>权重编号:
						</td>
						<td class="ListTableTr22">
							<s:if test="status=='add'">
								<s:textfield name="weighing.code" cssStyle="width:100%"
									maxlength="200" onblur="testCode()" />
							</s:if>
							<s:else>
								<s:textfield name="weighing.code" cssStyle="width:100%"
									maxlength="200" />
							</s:else>
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>权重名称:
						</td>
						<td class="ListTableTr22">
							<s:if test="status=='add'">
								<s:textfield name="weighing.name" cssStyle="width:100%"
									maxlength="200" onblur="testName()" />
							</s:if>
							<s:if test="status=='update'">
								<s:textfield name="weighing.name" cssStyle="width:100%"
									maxlength="200" />
							</s:if>
						</td>


						<td class="ListTableTr11">
							<font color=red>*</font>权重值
						</td>

						<td class="ListTableTr22">
							<s:textfield name="weighing.value" cssStyle="width:100%"
								maxlength="200" />
						</td>

					</tr>




				</table>

				<s:if test="status=='add'">
					<s:button value="保存" onclick="saveForm(0);" />&nbsp;&nbsp;
				</s:if>
				<s:else>
					<s:button value="保存" onclick="saveForm(1);" />&nbsp;&nbsp;
                </s:else>

				<s:reset value="清空"></s:reset>
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
	
	var url='';
      if(type==0){
         if(window.confirm("确定执行添加时效性考核--权重操作吗?")){
	   url="${contextPath}/pe/weighing/save.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }
      
      }
      else{
         if(window.confirm("确定执行修改时效性考核--权重操作吗?")){
	   url="${contextPath}/pe/weighing/update.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax验证不能重名

document.getElementsByName('status')[0].value=document.getElementsByName('weighing.name')[0].value;//用status带参数到后台

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/weighing', action:'testSameName', executeResult:'false' },'status',xxx1);}
function xxx1(data){
if(data['status']=='yes'){
	window.alert("时效性考核--权重名称已经存在，请换一个试试!");
	document.getElementsByName('weighing.name')[0].value="";
	document.getElementsByName('weighing.name')[0].focus();
}
  
} 

function testCode(){//ajax验证不能重名

document.getElementsByName('status')[0].value=document.getElementsByName('weighing.code')[0].value;//用status带参数到后台
DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/weighing', action:'testSameCode', executeResult:'false' },'status',xxx2);}
function xxx2(data){
if(data['status']=='yes'){
	window.alert("时效性考核--权重code已经存在，请换一个试试!");
	document.getElementsByName('weighing.code')[0].value="";
	document.getElementsByName('weighing.code')[0].focus();
}
  
}

</script>



</html>

