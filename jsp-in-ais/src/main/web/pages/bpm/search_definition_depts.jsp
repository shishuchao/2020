<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>查询流程适用单位</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	 	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	</head>
	<body>
		<div style="height:380px;" align="center" class="easyui-layout">
			<s:form action="findDefinitionDepts" namespace="/bpm/definition" id="myForm">
				<s:hidden name="definitionId" />
				<div style="text-align:right">
					<a onclick="toSelect()" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >查询</a>
					<a onclick="history.go(-1)" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" >返回</a>
				</div>
				<table id="definitionDeptTable" cellpadding=0 cellspacing=1 border=0
					 class="ListTable">
						<tr>
							<td class="EditHead">
								选择被审计单位
							</td>
							<td class="editTd">
								<s:buttonText2
										id="audit_object_name" cssClass="noborder"
										hiddenId="audit_object"
										name="audit_object_name"
										hiddenName="audit_object"
										doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								  param:{
								    'departmentId':$('#audit_object').val()
								  },
								  cache:false,
								  checkbox:true,
								  //height:500,
								  title:'请选择被审计单位'

								})"
										doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
										doubleCssStyle="cursor:hand;border:0" readonly="true"
										display="${varMap['audit_objectRead']}"
										doubleDisabled="!( varMap['audit_object_buttonWrite']==null ? true : varMap['audit_object_buttonWrite'] )" />
							</td>
						</tr>
				</table>
				
			</s:form>
		</div>


	</body>
	<script type="text/javascript">
		function validateForm(){
			var deptIds = document.getElementById('audit_object_name').value;
			if(deptIds==''){
				showMessage1('请选择被审计单位!');
				return false;
			}
			return true;
		}
		function toSelect(){
			if(validateForm()){
				myForm.submit();
			}
		}
	</script>
</html>
