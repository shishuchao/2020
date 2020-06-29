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
	<s:text id="title" name="'绩效考核--新建指标'"></s:text>
</s:if>
<s:if test="status=='update'">
	<s:text id="title" name="'绩效考核--修改指标'"></s:text>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/pe/validate/validateCommon.js"></script>
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
			<s:form name="myform" action="save" namespace="/pe/yszb">
				<s:hidden name="yszb.id"></s:hidden>
				<s:hidden name="status"></s:hidden>
				<s:hidden name="yszb.cts"></s:hidden>
				<s:hidden name="yszb.creator"></s:hidden>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>考核主体:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="yszb.peSystem_name" cssStyle="width:100%"  readonly="true"/>	
								<s:hidden name="yszb.peSystem_id"></s:hidden>															
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>考核要素:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="yszb.ys_name" cssStyle="width:100%"  readonly="true"/>	
								<s:hidden name="yszb.ys_id" ></s:hidden>	
						</td>						
					</tr>						
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>指标序号:
						</td>
						<td class="ListTableTr22">								
							<s:textfield name="yszb.yszb_number" cssStyle="width:100%" onkeyup="testNumber()"/>
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>指标名称:
						</td>
						<td class="ListTableTr22" >
								<s:textfield name="yszb.name" cssStyle="width:100%" onkeyup="testName()"/>
						</td>						
					</tr>					

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>指标权重:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="yszb.basicScore" cssStyle="width:100%" />	
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>评分标准:
						</td>
						<td class="ListTableTr22">

						<s:select name="yszb.pfbz_id" headerKey="" headerValue="请选择评分标准"
							list="pfbzList" listKey="id" listValue="name" />								
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
				<!--<input type="button" name="back" value="返回"
					onclick="javascript:window.location='<s:url action="listAll.action?id=${yszb.ys_id}"></s:url>'">  -->
					
				<s:button value="返回" onclick="goback('${yszb.ys_id}')"></s:button>	
					
			</s:form>

		</center>

	</body>


	<script language="javascript"> 
	function goback(src){//返回	
	window.location="${contextPath}/pe/yszb/listAll.action?id="+src;	
	}
	
	
     function check(){
       return (frmCheck(document.forms[0],'project_table'));  
    }
	
function saveForm(type){
	if(!check()){//前端验证
	   return false;
	}
   if(!numberValidate('yszb.yszb_number')){
      return false;
      }	
    if(!numberValidate_out('yszb.yszb_number',2,'指标序号')){
      return false;
      }
      
   if(!numberValidate('yszb.basicScore')){
      return false;
      }	
    if(!numberValidate_out('yszb.basicScore',3,'指标权重')){
      return false;
      }
            
     if(!numberValidate_out('yszb.name',50,'指标名称')){
      return false;
      } 
      
	var url='';
      if(type==0){
         if(window.confirm("执行添加考核指标操作吗?")){
	   url="${contextPath}/pe/yszb/save.action";
	   myform.action = url;
	
	   myform.submit();//提交表单
	   }
      
      }
      else{
         if(window.confirm("执行修改考核指标操作吗?")){
	   url="${contextPath}/pe/yszb/update.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax验证不能重名
var name_value=document.getElementsByName('yszb.name')[0].value;
var ys_id=document.getElementsByName('yszb.ys_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/yszb', action:'testSameName', executeResult:'false' },{'status':name_value,'ys_id':ys_id},xxx1);}
function xxx1(data){

if(data['status']=='yes'){
	window.alert("指标名称已经存在，请换一个试试!");
	document.getElementsByName('yszb.name')[0].value="";
	document.getElementsByName('yszb.name')[0].focus();
	return false;
}
  
} 



function testNumber(){//ajax验证不能重名

var ys_number_value=document.getElementsByName('yszb.yszb_number')[0].value;
var ys_id=document.getElementsByName('yszb.ys_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/yszb', action:'testSameNumber', executeResult:'false' },{'status':ys_number_value,'ys_id':ys_id},xxx2);}
function xxx2(data){

if(data['status']=='yes'){
	window.alert("指标序号已经存在，请换一个试试!");
	document.getElementsByName('yszb.yszb_number')[0].value="";
	document.getElementsByName('yszb.yszb_number')[0].focus();
	return false;
}
  
} 

</script>



</html>

