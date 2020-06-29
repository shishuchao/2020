<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='/ais/dwr/engine.js'></script>
<script type='text/javascript' src='/ais/dwr/util.js'></script>

	<s:text id="title" name="'��Ч����--��ϵ��ϸ'"></s:text>


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
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/checkboxSelected.js"></script>

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
			<s:form name="myform" action="save" namespace="/pe/pesystem">	
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">
					<tr>
						<td class="ListTableTr11">
							��ϵ����:
						</td>
						<td class="ListTableTr22" colspan="3">							
							<s:property  value="peSystem.name"/>
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							��ϵ״̬:
						</td>
						<td class="ListTableTr22">
							
											<s:if test="${peSystem.status=='0'}">
				<s:div cssStyle="text-align:center; color:green">�ݸ�</s:div>
				</s:if>
				<s:elseif test="${peSystem.status=='2'}">
				<s:div cssStyle="text-align:center; color:red">�ѷ���</s:div>
				</s:elseif>
				<s:elseif test="${peSystem.status=='1'}">
				<s:div cssStyle="text-align:center; color:brown">��ע��</s:div>
				</s:elseif>	
						</td>
						<td class="ListTableTr11">
							��ϵ�汾:
						</td>
						<td class="ListTableTr22">					
							<s:property value="peSystem.edition"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							���˶���:
						</td>
						<td class="ListTableTr22">					
					      <s:property value="peSystem.peObjectName"/>								
						</td>
						<td class="ListTableTr11">
							��������:
						</td>
						<td class="ListTableTr22">							
							<s:property value="peSystem.peMainName"/>
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							���˶���λ��Χ:
						</td>
						<td class="ListTableTr22">						
							<s:property value="peSystem.object_unit_name"/>									
						</td>
						<td class="ListTableTr11">
							���˶�����Ա��Χ:
						</td>
						<td class="ListTableTr22">						
							<s:property value="peSystem.object_sjrc_name"/>	
						</td>
					</tr>


					<tr>
						<td class="ListTableTr11">
							���˷�ʽ:
						</td>
						<td class="ListTableTr22" colspan="3">							
							<s:property value="peSystem.peTypeName"/>	
						</td>

					</tr>
					<tr>
						<td class="ListTableTr11">
							����ָ��:
						</td>
						<td class="ListTableTr22">
							<s:if test="${peSystem.ys_id=='no'}">								
									<s:div cssStyle="text-align:center; color:red">δ����</s:div>								
							</s:if>
							<s:elseif test="${peSystem.ys_id=='yes'}">								
									<s:div cssStyle="text-align:center; color:green">�Ѷ���</s:div>								
							</s:elseif>
						</td>
						<td class="ListTableTr11">
							��������:
						</td>
						<td class="ListTableTr22">
							<s:if test="${peSystem.flow_id=='no'}">							
									<s:div cssStyle="text-align:center; color:red">δ����</s:div>								
							</s:if>
							<s:elseif test="${peSystem.flow_id=='yes'}">								
									<s:div cssStyle="text-align:center; color:green">�Ѷ���</s:div>								
							</s:elseif>
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							������:
						</td>
						<td class="ListTableTr22">						
							<s:property value="peSystem.creator"/>									
						</td>
						<td class="ListTableTr11">
							����ʱ��:
						</td>
						<td class="ListTableTr22">						
							<s:property value="peSystem.cts"/>	
						</td>
					</tr>
					
					<tr>
						<td class="ListTableTr11">
							����޸���:
						</td>
						<td class="ListTableTr22">						
							<s:property value="peSystem.lastmodifier"/>									
						</td>
						<td class="ListTableTr11">
							����޸�ʱ��:
						</td>
						<td class="ListTableTr22">						
							<s:property value="peSystem.mts"/>	
						</td>
					</tr>					

					<tr>
						<td class="ListTableTr11">
							��ע:
						</td>
						<td class="ListTableTr22" colspan="3">							
							<s:property value="peSystem.beizhu"/>	
						</td>

					</tr>


				</table>
				

				
				<input type="button" name="back" value="����"
					onclick="javascript:window.location='<s:url action="listAll"></s:url>'">
			</s:form>

		</center>

	</body>


	<script language="javascript"> 
     function check(){
       return (frmCheck(document.forms[0],'project_table'));  
    }
	
function saveForm(type){
	if(!check()){//ǰ����֤
	   return false;
	}

	var url='';
      if(type==0){
         if(window.confirm("ִ����ӿ�����ϵ������?")){
	   url="${contextPath}/pe/pesystem/save.action";
	   myform.action = url;
	
	   myform.submit();//�ύ��
	   }
      
      }
      else{
         if(window.confirm("ִ���޸Ŀ�����ϵ������?")){
	   url="${contextPath}/pe/pesystem/update.action";
	   myform.action = url;
	   myform.submit();//�ύ��
	   }
      
      }
	
}



</script>

	<script language="javascript">
function testName(){//ajax��֤��������
var name_value=document.getElementsByName('peSystem.name')[0].value;
DWREngine.setAsync(false);DWRActionUtil.execute(
{ namespace:'/pe/pesystem', action:'testSameName', executeResult:'false' },{'status':name_value},xxx1);}
function xxx1(data){

if(data['status']=='yes'){
	window.alert("��ϵ�����Ѿ����ڣ��뻻һ������!");
	document.getElementsByName('peSystem.name')[0].value="";
	document.getElementsByName('peSystem.name')[0].focus();
	return false;
}
  
} 
//������ƶ������ͱ�ţ����������ű仯
function autoInput1(src){

var peMainCode=document.getElementsByName('peSystem.peMainCode')[0];
if(src.value==''){
peMainCode.value='';
}
if(src.value=='1000201'){
peMainCode.value='1000301';
}
if(src.value=='1000202'){
peMainCode.value='1000302';
}
if(src.value=='1000203'){
peMainCode.value='1000303';
}
if(src.value=='1000204'){
peMainCode.value='1000304';
}
if(src.value=='1000205'){
peMainCode.value='1000305';
}
}


function autoInput2(src){
var peObjectCode=document.getElementsByName('peSystem.peObjectCode')[0];
if(src.value==''){
peObjectCode.value='';
}
if(src.value=='1000301'){
peObjectCode.value='1000201';
}
if(src.value=='1000302'){
peObjectCode.value='1000202';
}
if(src.value=='1000303'){
peObjectCode.value='1000203';
}
if(src.value=='1000304'){
peObjectCode.value='1000204';
}
if(src.value=='1000305'){
peObjectCode.value='1000205';
}
}
</script>
	</script>



</html>

