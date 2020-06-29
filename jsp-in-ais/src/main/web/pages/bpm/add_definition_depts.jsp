<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>添加流程适用单位</title>
		<!-- 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>    
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		 -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	 	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	</head>
	<body>
		 <%-- <div style="height:200px;"></div>
 		 <p>
         	<a href="javascript:a()">click here</a>
         <br/>
             document.body.clientHeight = <span id="bodyheight"></span> px
         <br/>
             document.documentElement.clientHeight = <span id="documentheight"></span> px
        </p> --%>
		<div style="height:380px;" align="center" class="easyui-layout">
			<s:form action="saveDefinitionDept" namespace="/bpm/definition" id="myForm">
				<s:hidden name="definitionId" />
				<div style="text-align:right">
					<a onclick="toSave()" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >保存</a>
					<a onclick="history.go(-1)" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" >返回</a>
				</div>
				<table id="definitionDeptTable" cellpadding=0 cellspacing=1 border=0
					 class="ListTable">
						<tr>
							<td class="EditHead">
								选择单位
							</td>
							<td class="editTd">
								<s:buttonText2 cssClass="noborder" id="deptIds"
									name="deptNames" cssStyle="width:90%"
									hiddenName="deptIds"
									doubleOnclick="showSysTree(this,{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',param:{'p_item':1,'orgtype':1},checkbox:true,title:'适用单位'})"
									doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									doubleCssStyle="cursor:hand;border:0"
									readonly="true"/>
							</td>
						</tr>
				</table>
				
			</s:form>
		</div>
	</body>
	<script type="text/javascript">
	 	/* function a(){
			document.getElementById("bodyheight").innerText = document.body.clientHeight;
		    document.getElementById("documentheight").innerText = document.documentElement.clientHeight;
		} */
	 
		function validateForm(){
			var deptIds = document.getElementById('deptIds').value;
			if(deptIds==''){
				showMessage1('请选择单位!');
				return false;
			}
			return true;
		}
		function toSave(){
			if(validateForm()){
				myForm.submit();
			}
		}
	</script>
</html>
