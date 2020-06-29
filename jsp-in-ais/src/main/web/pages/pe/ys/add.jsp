<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='/ais/dwr/engine.js'></script>
<script type='text/javascript' src='/ais/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/pe/validate/validateCommon.js"></script>
<s:if test="status=='add'">
	<s:text id="title" name="'��Ч����--�½�Ҫ��'"></s:text>
</s:if>
<s:if test="status=='update'">
	<s:text id="title" name="'��Ч����--�޸�Ҫ��'"></s:text>
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
			<s:form name="myform" action="save" namespace="/pe/ys">
				<s:hidden name="ys.id"></s:hidden>
				<s:hidden name="status"></s:hidden>
				<s:hidden name="ys.cts"></s:hidden>
				<s:hidden name="ys.creator"></s:hidden>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>��������:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="ys.peSystem_name" cssStyle="width:100%"  readonly="true"/>	
								<s:hidden name="ys.peSystem_id"></s:hidden>															
						</td>
						<td class="ListTableTr11">
							
						</td>
						<td class="ListTableTr22">
								<!--<s:textfield name="ys.basicScore" cssStyle="width:100%" />-->	
						</td>						
					</tr>						
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>Ҫ�����:
						</td>
						<td class="ListTableTr22">								
							<s:textfield name="ys.ys_number" cssStyle="width:100%" onkeyup="testNumber()"/>
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>Ҫ������:
						</td>
						<td class="ListTableTr22" >
								<s:textfield name="ys.name" cssStyle="width:100%" onkeyup="testName()"/>
						</td>						
					</tr>					

					

																	
				</table>
				<s:if test="status=='add'">
					<s:button value="����" onclick="saveForm(0);" />&nbsp;&nbsp;
				</s:if>
				<s:else>
					<s:button value="����" onclick="saveForm(1);" />&nbsp;&nbsp;
                </s:else>

				&nbsp;&nbsp;	
			<s:button value="����" onclick="goback('${ys.peSystem_id}')"></s:button>	
			</s:form>

		</center>

	</body>


	<script language="javascript"> 
	function goback(src){//����	
	window.location="${contextPath}/pe/ys/listAll.action?id="+src;	
	}	
     function check(){
       return (frmCheck(document.forms[0],'project_table'));  
    }
	
function saveForm(type){
	if(!check()){//ǰ����֤
	   return false;
	}
	
   if(!numberValidate('ys.ys_number')){
      return false;
      }	
    if(!numberValidate_out('ys.ys_number',2,'Ҫ�����')){
      return false;
      }
     if(!numberValidate_out('ys.name',50,'Ҫ������')){
      return false;
      }     
	var url='';
      if(type==0){
         if(window.confirm("ִ����ӿ���Ҫ�ز�����?")){
	   url="${contextPath}/pe/ys/save.action";
	   myform.action = url;
	
	   myform.submit();//�ύ��
	   }
      
      }
      else{
         if(window.confirm("ִ���޸Ŀ���Ҫ�ز�����?")){
	   url="${contextPath}/pe/ys/update.action";
	   myform.action = url;
	   myform.submit();//�ύ��
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax��֤��������
var name_value=document.getElementsByName('ys.name')[0].value;
var peSystem_id=document.getElementsByName('ys.peSystem_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/ys', action:'testSameName', executeResult:'false' },{'status':name_value,'peSystem_id':peSystem_id},xxx1);}
function xxx1(data){

if(data['status']=='yes'){
	window.alert("Ҫ�������Ѿ����ڣ��뻻һ������!");
	document.getElementsByName('ys.name')[0].value="";
	document.getElementsByName('ys.name')[0].focus();
	return false;
}
  
} 



function testNumber(){//ajax��֤��������

var ys_number_value=document.getElementsByName('ys.ys_number')[0].value;
var peSystem_id=document.getElementsByName('ys.peSystem_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/ys', action:'testSameNumber', executeResult:'false' },{'status':ys_number_value,'peSystem_id':peSystem_id},xxx2);}
function xxx2(data){

if(data['status']=='yes'){
	window.alert("Ҫ������Ѿ����ڣ��뻻һ������!");
	document.getElementsByName('ys.ys_number')[0].value="";
	document.getElementsByName('ys.ys_number')[0].focus();
	return false;
}
  
} 

</script>



</html>

