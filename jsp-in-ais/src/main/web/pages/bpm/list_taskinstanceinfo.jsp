<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- 当流程未启动时，不显示此页面的内容 LIHAIFENG 2007-10-30 --%>
<s:if
	test="processInfoList.size>0">
	<table   cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
		<tr>
			<s:if test="taskInstanceId==-1">
				<td colspan="1"  class="EditHead" style="width: 20%">
					<font style="float:left;">&nbsp;流程信息</font>
				</td>
				<td colspan="4" align="left" class="EditHead">
					&nbsp;
					<font style="float: left;">
					<s:if test="formInfo.formState!=3">
						当前处理人：${formInfo.toActorId_name}
					</s:if>
					</font>
				</td>
			</s:if>
			<s:else>
				<td colspan="5" align="left" class="EditHead" style="width: 20%">
					<font style="float:left;">&nbsp;流程信息</font>
				</td>
			</s:else>
		</tr>

		<tr >
			<td style="width: 20%" class="EditHead">
				<center>
					环节名称
				</center>
			</td>
			<td style="width: 10%" class="EditHead">
				<center>
					处理人
				</center>
			</td>
			<td class="EditHead" style="width: 20%">
				<center>
					处理人所在部门
				</center>
			</td>
			<td class="EditHead" style="border-bottom:0;line-height:150%;width:30%;">
				<center>
					处理意见
				</center>
			</td>
			<td class="EditHead"  style="width: 20%">
				<center>
					处理时间
				</center>
			</td>
		</tr>
		<s:iterator value="processInfoList">
			<tr>
				<td class="editTd" style="width: 20%">
				<center>
					<s:if test="node_back==1">
							<s:property value="taskName" /><font color="red">(回退)</font>
						</s:if>
						<s:else>
							<s:property value="taskName" />
						</s:else>
						</center>
				</td>
				<td class="editTd" style="width: 10%">
					<%--				[--%>
					<%--				<s:property value="userId" />--%>
					<%--				]--%>
					<center>
						<s:property value="userName" />
					</center>
				</td>
				<td class="editTd" style="width: 20%">
					<center>
						<s:property value="deptName" />
				</td>
				<td class="editTd" style='word-break:break-all;word-wrap:break-word;width:30%;'>
					<center>
					<s:property value="comments" />
					</center>
				</td>
				<td class="editTd" style="width: 20%">
					<center>
						<s:date name="createDate" format="yyyy-MM-dd HH:mm:ss" />
					</center>
				</td>
			</tr>
		</s:iterator>
	</table>
</s:if>
