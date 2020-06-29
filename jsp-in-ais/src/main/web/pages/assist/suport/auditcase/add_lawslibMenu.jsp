<!DOCTYPE HTML>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>审计案例</title>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<!-- 长度验证 -->
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<!-- 全局 -->		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>		
			<SCRIPT type="text/javascript">
			function mcheck(){
				var name=document.getElementsByName('assistSuportLawslibMenu.category_name')[0].value;
				if(name==""){
					showMessage1('名称不能为空！','消息','0');
					return false;
				}
				var priority = document.getElementsByName("assistSuportLawslibMenu.priority")[0].value;
				if(priority!="" && !isDigit(priority)){
					showMessage1('优先级只能是数字!','消息','0');
					return false;
				}
				return true;
			}
			//数字校验
			function isDigit(s) { var patrn=/^[0-9]{1,4}$/; if (!patrn.exec(s)) return false; return true; }	
		</SCRIPT>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:form action="saveMenu" id="save" namespace="/pages/assist/suport/lawsLib" onsubmit="return mcheck()"
			method="post" theme="simple">
			<table style="width:100%;border:0" >
				<tr>
					<td>
						<span style="float:left;">
							 <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="exsitContent()">保存</a>&nbsp;&nbsp;
							 <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="clearInfo()">重置</a>&nbsp;&nbsp;
						</span>
					</td>
				</tr>
			</table>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					 <td class="EditHead" width="150px">
						父节点名称
					</td>
					<td class="editTd">
						<s:select cssClass="easyui-combobox" list="m_list" cssStyle="width:160px;" listKey="id" listValue="category_name" 
								emptyOption="false" name="assistSuportLawslibMenu.parent_id"></s:select>
						<br>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;类别名
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" cssStyle="width:250px;" name="assistSuportLawslibMenu.category_name" maxlength="40"></s:textfield>
						<br>
					</td>
				</tr>
				<tr>
					 <td class="EditHead">
						创建人
					</td>
					<td class="editTd">
<%--						<s:textfield name="assistSuportLawslibMenu.create_man" readonly="true"></s:textfield>--%>
							<s:hidden name="assistSuportLawslibMenu.create_man"></s:hidden>
						${assistSuportLawslibMenu.create_man}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						单位
					</td>
					<td class="editTd">
<%--						<s:textfield name="assistSuportLawslibMenu.man_dept" readonly="true"></s:textfield>--%>
						<s:hidden name="assistSuportLawslibMenu.man_dept"></s:hidden>
						${assistSuportLawslibMenu.man_dept}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						创建日期
					</td>
					<td class="editTd">
					<s:hidden name="assistSuportLawslibMenu.create_date" value="${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}"></s:hidden>
						${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						优先级
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" cssStyle="width:250px;" name="assistSuportLawslibMenu.priority" maxlength="40"></s:textfield>
					</td>
				</tr>
			</table>
			<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
			<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
		</s:form>
		<script type="text/javascript">
			function clearInfo(){
				document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value="";
				document.getElementsByName("assistSuportLawslibMenu.priority")[0].value="";
			}
			function exsitContent(){
				if(mcheck()){
					//document.getElementById("save").submit();
					//parent.location.reload();
					//防止数据未提交已经刷新父页面
					$.ajax({
				        type:'post',
			            url:'/ais/pages/assist/suport/lawsLib/saveMenu.action',
			            data: $('#save').serialize(),
			        	success:function(data){
			        		if('success' == data){
			        			showMessage1('保存成功！');
			        			parent.location.reload();
			        		}
			        	},
				    });
				}else{
					return false;
				}
				
			} 
		</script>
	</body>
</html>