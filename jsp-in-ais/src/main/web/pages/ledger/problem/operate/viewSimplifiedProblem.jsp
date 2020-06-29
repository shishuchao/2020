<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<title>查看问题</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
<style type="text/css">
/* 浮动最上层 */
#div1 {
	z-index: 9;
}

#div2 {
	z_index: 1;
}
</style>
</head>
<body class="easyui-layout">
<div fit="true"   region="center" border='0'  style="overflow: auto; width: 100%;height: 100%;">
	<div region="center" border='0'>
		<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
			<tr>
				<td class="EditHead" style="width:15%;">问题类别</td>
				<td class="editTd" style="width:35%;">
					<s:property value="ledgerProblem.problem_all_name" />
					<s:hidden id="sort_big_code" name="ledgerProblem.sort_big_code" />
					<s:hidden id="sort_big_name" name="ledgerProblem.sort_big_name" />
					<s:hidden id="sort_small_code" name="ledgerProblem.sort_small_code" />
					<s:hidden id="sort_small_name" name="ledgerProblem.sort_small_name" />
					<s:hidden id="sort_three_code" name="ledgerProblem.sort_three_code" />
					<s:hidden id="sort_three_name" name="ledgerProblem.sort_three_name" />
					<s:hidden id="ledgerProblem_id" name="ledgerProblem.id" />
                </td>
				<td class="EditHead">审计问题编号</td>
				<td class="editTd" >
					<s:property value="ledgerProblem.serial_num" />
				</td>
			</tr>
			<tr>
				<td class="EditHead" width="15%">问题点</td>
				<td class="editTd" width="35%">
					<s:property value="ledgerProblem.problem_name" />
				</td>
				<td class="EditHead" width="15%">备注(问题点为其他)</td>
				<td class="editTd" width="35%">
					<s:property value="ledgerProblem.problemComment" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">被审计单位</td>
				<td class="editTd">
					<s:property value="ledgerProblem.audit_object_name"/>
				</td>
				<td class="EditHead">问题标题</td>
				<td class="editTd">
					<s:property value="ledgerProblem.audit_con"/>			 
				</td>
			</tr>
			<tr>
				<td class="EditHead">涉及金额</td>
				<td class="editTd">
					<fmt:formatNumber value="${ledgerProblem.problem_money}" pattern="###.############"/>&nbsp;万元
				</td>
				<td class="EditHead">发生数量</td>
				<td class="editTd">
					<s:property value="ledgerProblem.problemCount"/>&nbsp;个
				</td>
			</tr>
			<tr>
				<td class="EditHead">审计发现类型</td>
				<td class="editTd">
					<s:property value="ledgerProblem.problem_grade_name" />
				</td>
				<td class="EditHead">重要程度</td>
				<td class="editTd">
					<s:property value="ledgerProblem.ofsDetail"/>
				</td>
			</tr>
			<tr>
				<s:if test="ledgerProblem.pro_type == '020312'">
					<td class="EditHead">责任<div>(经济责任审计)</div></td>
					<td class="editTd"><s:property value="ledgerProblem.zeren" /></td>
				</s:if>
				<s:else>
					<td class="EditHead">责任<div>(非经济责任审计)</div></td>
					<td class="editTd"><s:property value="ledgerProblem.zeren" /></td>
				</s:else>
				<td class="EditHead">问题发现日期</td>
				<td class="editTd">
					<s:property value="ledgerProblem.problem_date"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">问题录入人</td>
				<td class="editTd">
					<s:property value="ledgerProblem.creater_name"/>
				</td>
				<td class="EditHead">问题发现人</td>
				<td class="editTd">
					<s:property value="ledgerProblem.lp_owner"/>
				</td>
			</tr>
				<td class="EditHead">关联底稿</td>
				<td class="editTd">
					<s:property value="ledgerProblem.linkManuName"/>
				</td>
				<td class="EditHead"></td>
				<td class="editTd"></td>
			</tr>
			<tr>
				<td class="EditHead">是否入报告
				</td>
				<td class="editTd" >
					<s:property value="ledgerProblem.isToReport" />
				</td>
				<td class="EditHead">是否整改
				</td>
				<td class="editTd" >
					<s:property value="ledgerProblem.isInReport" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">不入报告原因
				</td>
				<td class="editTd" >
					<s:property value="ledgerProblem.reportRemarks" />
				</td>
				<td class="EditHead">不整改原因
				</td>
				<td class="editTd" >
					<s:property value="ledgerProblem.remarks" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">是否采纳审计意见</td>
				<td class="editTd">
					<s:property value="ledgerProblem.sfcnsjyj"/>
				</td>
				<td class="EditHead"></td>
				<td class="editTd"></td>
			</tr>
			<tr>
				<td class="EditHead">违规违纪类型</td>
				<td class="editTd">
					<s:property value="ledgerProblem.wgwjlxName"/>
				</td>
				<td class="EditHead">违规违纪金额</td>
				<td class="editTd">
					<fmt:formatNumber value="${ledgerProblem.wgwjje}" pattern="###.############"/>&nbsp;万元
				</td>
			</tr>
			
			<%-- <tr>
				<td class="EditHead">问题所属开始日期</td>
				<td class="editTd">
					<s:property value="ledgerProblem.creater_startdate" />
				</td>
				<td class="EditHead">问题所属结束日期</td>
				<td class="editTd">
					<s:property value="ledgerProblem.creater_enddate" />
				</td>
			</tr> --%>

			<tr>
				<td class="EditHead">问题描述</td>
				<td class="editTd" colspan="3">
					<s:property value="ledgerProblem.describe"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">定性依据</td>
				<td class="editTd" colspan="3">
					<s:property value="ledgerProblem.audit_law"/>
				</td>
			</tr>

			<tr>
				<td class="EditHead">审计建议</td>
				<td class="editTd" colspan="3">
					<s:property value="ledgerProblem.audit_advice"/>
				</td>
			</tr>

		</table>
	 </div>
	</div>
</body>
</html>
