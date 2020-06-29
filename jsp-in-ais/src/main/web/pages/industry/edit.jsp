<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML> 
<html>
	<head>
		<title>编辑行业性质</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css" />
		<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/aisCommon.css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="${contextPath}/resources/scripts/base64_Encode_Decode.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/validators.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<s:head theme="simple" />
		<script type="text/javascript">
			function saveForm(){
				if(frmCheck(document.forms[0], 'tab1')){
					var i = document.getElementById('industryId').value;
					if(i ==null || i == ''){
						if(lengthVal('industrycode', 3)){
							if(validateRepeat()){
								document.forms[0].submit();
							}
						}
					}else{
						document.forms[0].submit();
						showMessage1('保存成功！');
						parent.$('#zcfgTreeSelect').tree('reload');
					}
				}
			}
			function validateRepeat(){
				var flag = false;
				var code = document.getElementById("industrycode").value;
				var name = document.getElementById("save_industry_name").value;
				var parentCode = document.getElementById("save_industry_parentCode").value;
				var id = document.getElementById("industryId").value;
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
				{ namespace:'/industry', action:'validateRepeat', executeResult:'false' }, 
				{ 'code':code,'name':name,'parentCode':parentCode, 'id':id },callbackFun);
			    function callbackFun(data){
			     	var hasRepeat = data['message'];
			     	if( hasRepeat!= null && hasRepeat != '0'){
				     	if(hasRepeat=='2'){
			     			showMessage1("已存在相同的科目编码！");
				     	}else if(hasRepeat=='1'){
			     			showMessage1("已存在相同的科目名称！");
					    }else if(hasRepeat=='3'){
						    showMessage1("已存在相同的科目名称和编码！");
						}
			     		flag = false;
			     	}else{
			     		flag = true;
			     	}
				}
				return flag;
			}
			function loadForm(){
				var operateResult = document.getElementById("operateResult").value;
				if(operateResult=='false'){
					showMessage1("保存失败！");
				}else if(operateResult=='true'){
					
					parent.$('#zcfgTreeSelect').tree('reload');
				}
			}
			
		</script>
	</head>
	<body onload="loadForm();" style="overflow:hidden">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<s:form action="save" namespace="/industry" name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<tr >
					<td colspan="4" align="left" class=editTd bgcolor="#FAFAFA">
						<s:if test="${empty(industry.id)}">
							新增行业性质
						</s:if>
						<s:else>
							修改行业性质
						</s:else>
					</td>
				</tr>
			</table>
			<TABLE id="tab1" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<TR>
					<TD class=EditHead >
						<font color="red">*</font>&nbsp;行业性质编号
					</TD>
					<TD class=editTd align="left">
						<s:if test="${empty(industry.id)}">
							<s:textfield id="industrycode" name="industry.code"   title="编号" maxlength="100"/>
						</s:if>
						<s:else>
							<s:textfield id="industrycode" name="industry.code"   readonly="true" title="编号" maxlength="12"/>
						</s:else>
					</TD>
					<TD class=EditHead  >
						<font color="red">*</font>&nbsp;行业性质名称
					</TD>
					<TD class="editTd"  align="left">
						<s:textfield name="industry.name"  title="科目名称" maxlength="20" />
					</TD>
				</TR>
				<TR>
					<TD class=EditHead >
						上级编码
					</TD>
					<TD class="editTd"  align="left">
						<s:property value="industry.parentCode"/>
					</TD>
					<TD class=EditHead  >
						上级名称
					</TD>
					<TD class="editTd" align="left">
						<s:property value="industry.parentName"/>
					</TD>
				</TR>
			</TABLE>
			<br>
			<div align="center">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm()">保存</a>
<%--				<s:button value="保存" onclick="saveForm();"></s:button>--%>
			</div>
			<s:hidden id="industryId" name="industry.id"/>
			<s:hidden name="industry.parentCode"></s:hidden>
			<s:hidden name="industry.parentName"></s:hidden>
			<s:hidden name="industry.level"/>
			<s:hidden name="industry.creator"/>
			<s:hidden name="industry.createDate"/>
		</s:form>
	</body>
</html>
