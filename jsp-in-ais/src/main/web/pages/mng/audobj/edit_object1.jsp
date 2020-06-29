<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>被审计单位</title>
	<s:head theme="ajax"/>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>					
	<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
	<script type='text/javascript'src='${contextPath}/pages/mng/audobj/obj.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#associateDeptCode").attr("maxlength",30000);
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
		function Upload(id,filelist){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
  		function saveObj(){
			if(frmCheck(document.forms[0],'tab1')){
				document.forms[0].submit();	
			}
		}
	    function sucFun(){
	        var sucFlag = document.getElementById('sucFlag').value;
	        if(sucFlag == '1'){
	         document.getElementById("sucFlag").value="";
	         $.messager.show({title:'提示信息',msg:'保存成功!'});
	         } 
	        }
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" onload="sucFun();">
	<div region="center">
		<s:form action="save" namespace="/mng/audobj/object" id="myform">
				<div style="text-align:left;padding:5px;">
					<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveObj()">保存</a>
				</div>
				<table id='tab1' cellpadding=0 cellspacing=1 border=0 class="ListTable">
					<tr>
						<td class="EditHead" style="width:15%;">
							上级机构编码
						</td>
						<td class="editTd"  style="width:35%;">
						<%
							String sc1 = request.getParameter("_superiorCode");
							if(sc1 != null && !sc1.trim().equals("")){
						%>
							<s:textfield  name="auditingObject.superiorCode" value="<%=sc1 %>" readonly="true" cssClass="noborder"></s:textfield>
						<%
							}else{
						%>
							<s:textfield name="auditingObject.superiorCode" readonly="true" cssClass="noborder"></s:textfield>
						<%
							}
						%>
						</td>
						<td class="EditHead"  style="width:15%;">
							本级机构编码
						</td>
						<td class="editTd"  style="width:35%;">
							<s:textfield name="auditingObject.currentCode" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="EditHead">
							对象名称
						</td>
						<td class="editTd">
							<s:textfield  name="auditingObject.name" readonly="true" cssClass="noborder"></s:textfield>
						</td>
						<td class="EditHead">
							成立时间
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.establishDate" readonly="true" cssClass="noborder"
								 maxlength="20"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							单位性质
						</td>
						<td class="editTd">
							<s:hidden name="auditingObject.comTypeCode"></s:hidden>
							<s:textfield  name="auditingObject.comTypeName" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
						<td class="EditHead">
							组织机构代码
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.artificialCode" readonly="true" cssClass="noborder"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							法人代表
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.artificialPersion" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
						<td class="EditHead">
							机构级次
						</td>
						<td class="editTd">
							<s:hidden name="auditingObject.orgLevelCode"></s:hidden>
							<s:textfield name="auditingObject.orgLevelName" readonly="true" cssClass="noborder"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							经营区域
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.runArea" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
						<td class="EditHead">
							单位负责人
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.director" readonly="true" cssClass="noborder"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							单位人数
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.employeesNum" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
						<td class="EditHead">
							财务负责人
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.financialDirector" readonly="true" cssClass="noborder"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							上级单位
						</td>
						<td class="editTd">
							<s:hidden  name="auditingObject.parentId"></s:hidden>
							<s:textfield name="auditingObject.parentName" readonly="true" cssClass="noborder"></s:textfield>
						</td>
						<td class="EditHead" nowrap>
							所属审计单位
						</td>
						<td class="editTd">
							<s:hidden  name="auditingObject.departmentId"></s:hidden>
							<s:textfield name="auditingObject.departmentName" readonly="true" cssClass="noborder"></s:textfield>
						</td>
					</tr>						
					<tr>
						<td class="EditHead">
							注册资本
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.initCapital" readonly="true" cssClass="noborder"></s:textfield>
						</td>
						<td class="EditHead">
							主营业务
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.primeOperating" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="EditHead">
							办公地址
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.officeAddress" readonly="true" cssClass="noborder"></s:textfield>
						</td>
						<td class="EditHead">
							邮政编码
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.postCode" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="EditHead">
							办公电话
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.officePhone" readonly="true" cssClass="noborder"></s:textfield>
						</td>
						<td class="EditHead">
							传真
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.faxCode" readonly="true" cssClass="noborder"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="EditHead">
							持有股份
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.holdingShares" maxlength="100" cssClass="noborder"></s:textfield>
						</td>
						<td class="EditHead">
							所属板块
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.hisPlate" maxlength="100" cssClass="noborder"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							关联核算组织编号
							<br><font color="red" size="1">请注意填写正确!</font>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder"  name="auditingObject.associateDeptCode" id="associateDeptCode" cssStyle="width:100%;overflow-y:hidden;" title="关联核算组织编号" />
							<!--<s:textfield name="auditingObject.associateDeptCode" title="关联核算组织编号" maxlength="30000" cssClass="noborder"></s:textfield>-->
							<s:hidden name="originalAssociateDeptCode" value="${auditingObject.associateDeptCode}"/>
						</td>
					</tr>	
					<tr>
						<td class="EditHead" nowrap>
							关联核算组织名称
							<br><font color="red" size="1">请注意填写正确!</font>
						</td>
						<td class="editTd">
							<s:textfield name="auditingObject.associateDept" title="关联核算组织名称" maxlength="30000" cssClass="noborder"></s:textfield>
						</td>						
					
						<td class="EditHead" nowrap>
								对应组织机构
							</td>
							<td class="editTd" >
								<s:hidden  name="auditingObject.correspondingDeptId"></s:hidden>
								<s:textfield name="auditingObject.correspondingDeptName" readonly="true" cssClass="noborder"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<s:hidden name="auditingObject.otherResourceFile"/>
						</td>
						<td class="editTd" colspan="3">
							<div id="otherResourceFileList" align="center">
								<s:property escape="false" value="otherResourceFileList" />
							</div>							
						</td>
					</tr>
					<s:hidden name="auditingObject.createDepartmentName" value="%{auditingObject.createDepartmentName}"/>																																			
					<s:hidden name="auditingObject.createDepartmentCode" value="%{auditingObject.createDepartmentCode}"/>																																			
					<s:hidden name="auditingObject.createPersonName" value="%{auditingObject.createPersonName}"/>																																			
					<s:hidden name="auditingObject.createPersonCode" value="%{auditingObject.createPersonCode}"/>																																																																						
					<s:hidden name="auditingObject.createDate" value="%{auditingObject.createDate}"/>
					<s:hidden name="auditingObject.industryName" value="%{auditingObject.industryName}"/>		
					<s:hidden name="auditingObject.industryCode" value="%{auditingObject.industryCode}"/>
							<!-- 中文简称 -->																																																												
					<s:hidden name="auditingObject.cAbbreviation" value="%{auditingObject.cAbbreviation}"/>	
					<!-- 英文简称-->																																																												
					<s:hidden name="auditingObject.eAbbreviation" value="%{auditingObject.eAbbreviation}"/>	
					<!-- 财务联系人-->																																																														
					<s:hidden name="auditingObject.financialLinkman" value="%{auditingObject.financialLinkman}"/>																																																													
			         <!-- 审计负责人-->	
				    <s:hidden name="auditingObject.auditDirector" value="%{auditingObject.auditDirector}"/>	
			         <!--审计联系人-->	
				    <s:hidden name="auditingObject.auditLinkman" value="%{auditingObject.auditLinkman}"/>
				    <s:hidden name="auditingObject.basicSituation" value="%{auditingObject.basicSituation}"/>																																																												
				</table>
				<s:hidden name="auditingObject.id"/>
				<s:hidden name="status"/>
			    <s:hidden name="sucFlag" id="sucFlag"/>
		</s:form>
	</div>
</body>
</html>