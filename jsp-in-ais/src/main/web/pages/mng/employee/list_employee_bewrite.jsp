<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>撰文信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>		
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<STYLE type="text/css">
		select{
			font-size: 13px !important;
		}
		</STYLE>
	</head>
	<script type="text/javascript">
		function employeeEdit(){
			var cbxs = document.getElementsByName("employeeBewrite_ids");
			var cbx_count = 0;
			var cbx_no = -1;
			for(var i=0;i<cbxs.length;	i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
				}
			}
			if(cbx_count>1){
				alert("不能同时修改多个撰文信息！");
				return false;
			}
			if(cbx_no==-1){
				alert("没有选择要修改的撰文信息!");
				return false;
			}
			document.forms[1].action="employeeBewriteEdit.action";
			document.forms[1].submit();
		}
		function cleanForm(){
			document.getElementsByName("employeeBewrite.articleTitle")[0].value = "";
			document.getElementsByName("employeeBewrite.articleTypeCode")[0].selectedIndex = -1;
			document.getElementsByName("employeeBewrite.coachMan")[0].value = "";
			document.getElementsByName("employeeBewrite.appearMediaCode")[0].selectedIndex = -1;
			
			document.forms[0].action="${contextPath}/mng/employee/employeeBewriteSearch.action";
			document.forms[0].submit();
		}
	</script>
	<body>
		<s:form namespace="/mng/employee" id="form1" name="form2">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						文章标题
					</td>
					<TD class="listtabletr1">
						<s:textfield name="employeeBewrite.articleTitle" />
					</TD>
					<TD align="center" class="listtabletr1">
						文章类别
					</TD>
					<TD class="listtabletr1">
						<s:select name="employeeBewrite.articleTypeCode" headerKey="" headerValue="" list="basicUtil.articleTypeList4Search" listKey="code" listValue="name"/>
					</TD>
				</tr>
				<tr class="listtablehead">
					<TD class="listtabletr1">
						指导人
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="employeeBewrite.coachMan" />
					</TD>
					<TD class="listtabletr1">
						发表媒体
					</TD>
					<TD class="listtabletr1">
						<s:select name="employeeBewrite.appearMediaCode" headerKey="" headerValue="" list="basicUtil.appearMediaList4Search" listKey="code" listValue="name"/>
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="4" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="employeeBewriteSearch" value="查询"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:button value="重置" onclick="cleanForm()" />
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
		<s:form namespace="/mng/employee" id="form2" name="form2"
			onsubmit="return delOrEdit('employeeBewrite_ids','撰文信息');">
			<display:table requestURI="${contextPath}/mng/employee/employeeBewriteSearch.action"  name="list" id="row" class="its" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				defaultsort="2" defaultorder="descending">
				<display:column>
					<s:if test="listStatus == 'edit'">
						<input type="checkbox" name="employeeBewrite_ids" value="${row.id}">
					</s:if>
				</display:column>
				<display:column title="文章标题" headerClass="center" sortable="true">
					<a href="${contextPath}/mng/employee/employeeBewriteView.action?employeeBewrite.id=${row.id}&listStatus=${listStatus}">${row.articleTitle}</a>
				</display:column>
				<display:column property="articleType" title="文章类别" sortName="articleType" headerClass="center" sortable="true" />
				<display:column property="coachMan" title="指导人" sortName="coachMan" sortable="true" headerClass="center" />
				<display:column property="joinWriteMan" title="合著人" sortName="joinWriteMan" headerClass="center" sortable="true" />
				<display:column property="appearMedia" title="发表媒体" sortName="appearMedia" headerClass="center" sortable="true" />
				<display:column property="appearDate" title="发表日期" sortName="appearDate" sortable="true" headerClass="center" />
				<display:column property="palm" title="所获奖项" sortName="palm" sortable="true" headerClass="center" />
			</display:table>
			<s:if test="listStatus == 'edit'">
				<div align="right">
					<input type="button" value="增加" onclick="window.location.href='${contextPath}/mng/employee/employeeBewriteAdd.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'">
					&nbsp;&nbsp;
					<s:submit action="employeeBewriteDelete" value="删除"/>
					&nbsp;&nbsp;
					<s:button onclick="employeeEdit()" value="修改" />
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeBewrite_ids', true)" value="全选">
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeBewrite_ids', false)" value="全不选">
					&nbsp;&nbsp;
					<input type="button" value="返回" onclick="parent.window.location='${contextPath}/mng/employee/employeeInfoList.action?listStatus=edit'">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</s:if>
			<s:hidden name="listStatus"/>
			<s:hidden name="employeeInfo.id"/>
		</s:form>
	</body>
</html>
