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
	<s:text id="title" name="'绩效考核--新建考核节点'"></s:text>
</s:if>
<s:if test="status=='update'">
	<s:text id="title" name="'绩效考核--修改考核节点'"></s:text>
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
			<s:form name="myform" action="save" namespace="/pe/flowpoint">
				<s:hidden name="fp.id"></s:hidden>
				<s:hidden name="status"></s:hidden>
				<s:hidden name="fp.cts"></s:hidden>
				<s:hidden name="fp.creator"></s:hidden>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>考核主体:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="fp.peSystem_name" cssStyle="width:100%"   readonly="true"/>	
								<s:hidden name="fp.peSystem_id"></s:hidden>															
						</td>
						<td class="ListTableTr11">
							节点描述:
						</td>
						<td class="ListTableTr22" >
								<s:textfield name="fp.discript" cssStyle="width:100%" />
						</td>						
							
					</tr>						
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>节点编码:
						</td>
						<td class="ListTableTr22">
						<s:if test="${status=='update'}">
								<s:textfield name="fp.code" cssStyle="width:100%"  readonly="true"/>	
						</s:if>	
						<s:elseif test="${status=='add'}">
								<s:textfield name="fp.code" cssStyle="width:100%" onkeyup="testCode()" />	
						</s:elseif>																				
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>节点名称:
						</td>
						<td class="ListTableTr22" >
								<s:textfield name="fp.name"  cssStyle="width:100%" onkeyup="testName()"/>
						</td>							
					</tr>	
									
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>节点权重:
						</td>
						<td class="ListTableTr22" >						
							<s:textfield name="fp.weight" cssStyle="width:100%"/>																								
						</td>
						
						<td class="ListTableTr11">
							<font color=red>*</font>是否为加减分环节:
						</td>
						<td class="ListTableTr22" >											
							<s:select name="fp.isAdd" list="#@java.util.LinkedHashMap@{'':'','0':'否','1':'是'}" cssStyle="width:100%"></s:select>
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
			<s:button value="返回" onclick="goback('${fp.peSystem_id}')"></s:button>	
			</s:form>

		</center>

	</body>


	<script language="javascript"> 
		function goback(src){//返回	
	window.location="${contextPath}/pe/flowpoint/listAll.action?id="+src;	
	}
     function check(){
       return (frmCheck(document.forms[0],'project_table'));  
    }
	
function saveForm(type){
	if(!check()){//前端验证
	   return false;
	}
    if(!numberValidate_out('fp.code',10,'节点编码')){      
      return false;
    }
    
    if(!numberValidate_out('fp.name',10,'节点名称')){      
      return false;
    }
     if(!numberValidate('fp.weight')){
      return false;
      }	
         
    if(!numberValidate_out('fp.weight',3,'节点权重')){      
      return false;
    }        

         
	var url='';
      if(type==0){
         if(window.confirm("执行添加考核考核节点操作吗?")){
	   url="${contextPath}/pe/flowpoint/save.action";
	   myform.action = url;
	
	   myform.submit();//提交表单
	   }
      
      }
      else{
         if(window.confirm("执行修改考核考核节点操作吗?")){
	   url="${contextPath}/pe/flowpoint/update.action";
	   myform.action = url;
	   myform.submit();//提交表单
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax验证不能重名
var name_value=document.getElementsByName('fp.name')[0].value;
var peSystem_id=document.getElementsByName('fp.peSystem_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/flowpoint', action:'testSameName', executeResult:'false' },{'status':name_value,'peSystem_id':peSystem_id},xxx1);}
function xxx1(data){

if(data['status']=='yes'){
	window.alert("考核节点名称已经存在，请换一个试试!");
	document.getElementsByName('fp.name')[0].value="";
	document.getElementsByName('fp.name')[0].focus();
	return false;
}
  
} 




function testCode(){//ajax验证不能重名
var code_value=document.getElementsByName('fp.code')[0].value;
var peSystem_id=document.getElementsByName('fp.peSystem_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/flowpoint', action:'testSameCode', executeResult:'false' },{'status':code_value,'peSystem_id':peSystem_id},xxx2);}
function xxx2(data){

if(data['status']=='yes'){
	window.alert("考核节点名称已经存在，请换一个试试!");
	document.getElementsByName('fp.code')[0].value="";
	document.getElementsByName('fp.code')[0].focus();
	return false;
}
  
} 

</script>



</html>
