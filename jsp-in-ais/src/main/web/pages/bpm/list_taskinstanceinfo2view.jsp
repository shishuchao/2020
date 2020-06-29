<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:if test="processInfoList.size>0">
	<%-- 当流程未启动时，不显示此页面的内容 LIHAIFENG 2007-10-30 --%>
	<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				&nbsp;流程信息
			</td>
		</tr>

		<tr align="center" class="titletable1">
			<td>
				<center>
					环节名称
				</center>
			</td>
			<td>
				<center>
					处理人
				</center>
			</td>
			<td>
				<center>
					处理人所在部门
				</center>
			</td>
			<td>
				<center>
					处理意见
				</center>
			</td>
			<td>
				<center>
					处理时间
				</center>
			</td>
		</tr>
		<s:iterator value="processInfoList">
			<tr>
				<td class="listtabletr2">
					<center>
						<s:property value="taskName" />
					</center>
				</td>
				<td class="listtabletr2">
					<%--				[--%>
					<%--				<s:property value="userId" />--%>
					<%--				]--%>
					<center>
						<s:property value="userName" />
					</center>
				</td>
				<td class="listtabletr2">
					<center>
						<s:property value="deptName" />
				</td>
				<td class="listtabletr2" style='word-break:break-all;word-wrap:break-word;width:300px'>
					<center>
						<s:property value="comments" />
					</center>
				</td>
				<td class="listtabletr2">
					<center>
						<s:date name="createDate" format="yyyy-MM-dd HH:mm:ss" />
					</center>
				</td>
			</tr>
		</s:iterator>
	</table>
</s:if>
