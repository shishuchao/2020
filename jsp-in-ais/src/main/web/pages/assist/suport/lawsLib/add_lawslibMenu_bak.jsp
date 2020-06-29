<%@ page language="java"  pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 

		<title>法律法规</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<!-- 长度验证 -->
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
						
		<SCRIPT type="text/javascript">
			function mcheck(){
				if(document.getElementsByName('assistSuportLawslibMenu.category_name')[0].value==""){
					alert('名称不能为空！');
					document.getElementsByName('assistSuportLawslibMenu.category_name')[0].focus();
					return false;
				}
				var priority = document.getElementsByName("assistSuportLawslibMenu.priority")[0].value;
				if(priority!="" && !isDigit(priority)){
					alert("优先级 只能是数字!");
					return false;
				}
				return true;
			}
			//数字校验
			function isDigit(s) { var patrn=/^[0-9]{1,4}$/; if (!patrn.exec(s)) return false; return true; }	
		</SCRIPT>
	</head>
	<body>
	
		<s:form action="saveMenu" namespace="/pages/assist/suport/lawsLib" onsubmit="return mcheck()"
			method="post" theme="simple">
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<tr>
					<td class="listtabletr11">
						父节点名称
					</td>
					<td class="listtabletr2">
						<s:select list="m_list" listKey="id" listValue="category_name"
							emptyOption="false" name="assistSuportLawslibMenu.parent_id"></s:select>
						<br>
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						类别名<font color="red">*</font>
					</td>
					<td class="listtabletr2">
						<s:textfield name="assistSuportLawslibMenu.category_name" maxlength="40"></s:textfield>
						
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						创 建 人
					</td>
					<td class="listtabletr2">
						<s:hidden name="assistSuportLawslibMenu.create_man"></s:hidden>
						${assistSuportLawslibMenu.create_man}
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						单位
					</td>
					<td class="listtabletr2">
						<s:hidden name="assistSuportLawslibMenu.man_dept"></s:hidden>
						<s:hidden name="assistSuportLawslibMenu.deptId"></s:hidden>
						${assistSuportLawslibMenu.man_dept}
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						创建日期
					</td>
					<td class="listtabletr2">
						<s:hidden name="assistSuportLawslibMenu.create_date" value="${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}"></s:hidden>
						${assistSuportLawslibMenu.create_date}
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						优先级
					</td>
					<td class="listtabletr2">
						<s:textfield name="assistSuportLawslibMenu.priority" maxlength="40"></s:textfield>
					</td>
				</tr>
			</table>
			<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
			<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
			<table style="width:97%;border:0" >
					<tr>
						<td>
							<span style="float:right;">
								<s:submit value="保存" align="center"></s:submit>
								<s:reset value="重置" align="center"></s:reset>
							</span>
						</td>
					</tr>
			</table>
		</s:form>
	</body>
</html>