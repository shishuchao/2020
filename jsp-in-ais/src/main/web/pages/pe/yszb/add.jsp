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
	<s:text id="title" name="'��Ч����--�½�ָ��'"></s:text>
</s:if>
<s:if test="status=='update'">
	<s:text id="title" name="'��Ч����--�޸�ָ��'"></s:text>
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
							<font color=red>*</font>��������:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="yszb.peSystem_name" cssStyle="width:100%"  readonly="true"/>	
								<s:hidden name="yszb.peSystem_id"></s:hidden>															
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>����Ҫ��:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="yszb.ys_name" cssStyle="width:100%"  readonly="true"/>	
								<s:hidden name="yszb.ys_id" ></s:hidden>	
						</td>						
					</tr>						
					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>ָ�����:
						</td>
						<td class="ListTableTr22">								
							<s:textfield name="yszb.yszb_number" cssStyle="width:100%" onkeyup="testNumber()"/>
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>ָ������:
						</td>
						<td class="ListTableTr22" >
								<s:textfield name="yszb.name" cssStyle="width:100%" onkeyup="testName()"/>
						</td>						
					</tr>					

					<tr>
						<td class="ListTableTr11">
							<font color=red>*</font>ָ��Ȩ��:
						</td>
						<td class="ListTableTr22">
								<s:textfield name="yszb.basicScore" cssStyle="width:100%" />	
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>���ֱ�׼:
						</td>
						<td class="ListTableTr22">

						<s:select name="yszb.pfbz_id" headerKey="" headerValue="��ѡ�����ֱ�׼"
							list="pfbzList" listKey="id" listValue="name" />								
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
				<!--<input type="button" name="back" value="����"
					onclick="javascript:window.location='<s:url action="listAll.action?id=${yszb.ys_id}"></s:url>'">  -->
					
				<s:button value="����" onclick="goback('${yszb.ys_id}')"></s:button>	
					
			</s:form>

		</center>

	</body>


	<script language="javascript"> 
	function goback(src){//����	
	window.location="${contextPath}/pe/yszb/listAll.action?id="+src;	
	}
	
	
     function check(){
       return (frmCheck(document.forms[0],'project_table'));  
    }
	
function saveForm(type){
	if(!check()){//ǰ����֤
	   return false;
	}
   if(!numberValidate('yszb.yszb_number')){
      return false;
      }	
    if(!numberValidate_out('yszb.yszb_number',2,'ָ�����')){
      return false;
      }
      
   if(!numberValidate('yszb.basicScore')){
      return false;
      }	
    if(!numberValidate_out('yszb.basicScore',3,'ָ��Ȩ��')){
      return false;
      }
            
     if(!numberValidate_out('yszb.name',50,'ָ������')){
      return false;
      } 
      
	var url='';
      if(type==0){
         if(window.confirm("ִ����ӿ���ָ�������?")){
	   url="${contextPath}/pe/yszb/save.action";
	   myform.action = url;
	
	   myform.submit();//�ύ��
	   }
      
      }
      else{
         if(window.confirm("ִ���޸Ŀ���ָ�������?")){
	   url="${contextPath}/pe/yszb/update.action";
	   myform.action = url;
	   myform.submit();//�ύ��
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax��֤��������
var name_value=document.getElementsByName('yszb.name')[0].value;
var ys_id=document.getElementsByName('yszb.ys_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/yszb', action:'testSameName', executeResult:'false' },{'status':name_value,'ys_id':ys_id},xxx1);}
function xxx1(data){

if(data['status']=='yes'){
	window.alert("ָ�������Ѿ����ڣ��뻻һ������!");
	document.getElementsByName('yszb.name')[0].value="";
	document.getElementsByName('yszb.name')[0].focus();
	return false;
}
  
} 



function testNumber(){//ajax��֤��������

var ys_number_value=document.getElementsByName('yszb.yszb_number')[0].value;
var ys_id=document.getElementsByName('yszb.ys_id')[0].value;

DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/yszb', action:'testSameNumber', executeResult:'false' },{'status':ys_number_value,'ys_id':ys_id},xxx2);}
function xxx2(data){

if(data['status']=='yes'){
	window.alert("ָ������Ѿ����ڣ��뻻һ������!");
	document.getElementsByName('yszb.yszb_number')[0].value="";
	document.getElementsByName('yszb.yszb_number')[0].focus();
	return false;
}
  
} 

</script>



</html>

