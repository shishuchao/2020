<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计整改情况统计分析-结果</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<%--<script>
		$(function () {
			var mainHeight = window.parent.document.getElementById("centerDiv").style.height;
			if (mainHeight) {
				$("#mainDiv").css("height", mainHeight);
			}
		})
	</script>--%>
<body>
<div id="mainDiv" style="overflow: hidden;">
	<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
		<thead>
		<tr style="background-color: grey">
			<c:if
				test="${ledgerProblem.project_name!=null&&ledgerProblem.project_name!=''}">
				<th  class="EditHead">
					<p align="center">
						项目名称
					</p>
				</th>
			</c:if>
			<c:if
				test="${ledgerProblem.pro_year!=null&&ledgerProblem.pro_year!=''}">
				<th  class="EditHead" style="color: gray">
					<p align="center">
						项目年度
					</p>
				</th>
			</c:if>

			<c:if
				test="${ledgerProblem.pro_type!=null&&ledgerProblem.pro_type!=''}">
				<th  class="EditHead">
					<p align="center">
						项目类型
					</p>
				</th>
			</c:if>

			<c:if
				test="${ledgerProblem.audit_object_name!=null&&ledgerProblem.audit_object_name!=''}">
				<th  class="EditHead">
					<p align="center">
						被审计单位
					</p>
				</th>
			</c:if>

			<c:if
				test="${ledgerProblem.audit_dept_name!=null&&ledgerProblem.audit_dept_name!=''}">
				<th  class="EditHead">
					<p align="center">
						审计单位
					</p>
				</th>
			</c:if>

			<c:if
				test="${ledgerProblem.problem_name!=null&&ledgerProblem.problem_name!=''}">
				<th  class="EditHead">
					<p align="center">
						问题点
					</p>
				</th>
			</c:if>

			<c:if
				test="${ledgerProblem.sort_big_name!=null&&ledgerProblem.sort_big_name!=''}">
				<th  class="EditHead">
					<p align="center">
						问题类别
					</p>
				</th>
			</c:if>

			<th  class="EditHead">
				<p align="center">
					问题数量
				</p>
			</th>
			<th  class="EditHead">
				<p align="center">
					涉及金额（万元）
				</p>
			</th>
			<th  class="EditHead">
				<p align="center">
					已整改
				</p>
			</th>
			<th  class="EditHead">
				<p align="center">
					部分整改
				</p>
			</th>
			<th  class="EditHead">
				<p align="center">
					未整改
				</p>
			</th>
			<th  class="EditHead">
				<p align="center">
					整改落实率
				</p>
			</th>
		</tr>
		</thead>
		<%--<c:forEach items="${list}" varStatus="status" var="info">--%>
		<tbody>
		<s:iterator value="list" id="info">
			<tr>
				<c:if
					test="${ledgerProblem.project_name!=null&&ledgerProblem.project_name!=''}">
					<td class="editTd">
						<p align="left">
							${info.project_name}
						</p>
					</td>
				</c:if>

				<c:if
					test="${ledgerProblem.pro_year!=null&&ledgerProblem.pro_year!=''}">
					<td class="editTd">
						<p align="center">
							${info.pro_year}
						</p>
					</td>
				</c:if>

				<c:if
					test="${ledgerProblem.pro_type!=null&&ledgerProblem.pro_type!=''}">
					<td class="editTd">
						<p align="center">
							${info.pro_type }
						</p>
					</td>
				</c:if>

				<c:if
					test="${ledgerProblem.audit_object_name!=null&&ledgerProblem.audit_object_name!=''}">
					<td class="editTd">
						<p align="center">
							${info.audit_object_name}
						</p>
					</td>
				</c:if>

				<c:if
					test="${ledgerProblem.audit_dept_name!=null&&ledgerProblem.audit_dept_name!=''}">
					<td class="editTd">
						<p align="center">
							${info.audit_dept}
						</p>
					</td>
				</c:if>

				<c:if
					test="${ledgerProblem.problem_name!=null&&ledgerProblem.problem_name!=''}">
					<td class="editTd">
						<p align="center">
							${info.problem_name}
						</p>
					</td>
				</c:if>

				<c:if
					test="${ledgerProblem.sort_big_name!=null&&ledgerProblem.sort_big_name!=''}">
					<td class="editTd">
						<p align="center">
							${info.sort_big_name}
						</p>
					</td>
				</c:if>

				<td class="editTd">
					<p align="center">
						${info.p_number}
					</p>
				</td>
				<td class="editTd" style="text-align: right;">
					<%--<p align="center">
						${info.moneyString}
					</p>--%>
					<s:property value="%{formatMoneyWithSeparator(#info.moneyString)}" />
				</td>
				<td class="editTd">
					<p align="center">
						${info.sum_mend_ok}
					</p>
				</td>
				<td class="editTd">
					<p align="center">
						${info.sum_mend_now}
					</p>
				</td>
				<td class="editTd">
					<p align="center">
						${info.sum_mend_no}
					</p>
				</td>
				<td class="editTd">
					<p align="right">
						${info.mend_rate}
					</p>
				</td>
			  </tr>
		<%--</s:iterator>--%>
		</s:iterator>
		</tbody>
	</table>
</div>
</body>
</html>
