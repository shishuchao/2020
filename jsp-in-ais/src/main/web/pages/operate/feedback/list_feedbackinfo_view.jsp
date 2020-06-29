<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 
	<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
		<tr>
			<td colspan="5" align="left" class="EditHead" style="width: 20%">
				<font style="float:left;">&nbsp;底稿在线反馈信息</font>
			</td>
		</tr>

		<tr>
			<td style="width: 15%" class="EditHead">
				<center>
					反馈人
				</center>
			</td>
			<td style="width: 50%" class="EditHead">
				<center>
					反馈信息
				</center>
			</td>
			<td style="width: 15%" class="EditHead">
				<center>
					反馈人所在部门
				</center>
			</td>
			<td style="width: 10%" class="EditHead">
				<center>
					反馈日期
				</center>
				
			</td>
			<td style="width: 10%" class="EditHead">
				<center>
					操作
				</center>
			</td>
		</tr>
		<s:iterator value="feedbackInfoList">
			<tr>
				<td class="editTd">
				<center>
					<s:property value="feedback_author_name" />
				</center>
				</td>
				<td class="editTd" style='word-break:break-all;word-wrap:break-word;width:300px'>
					 
					<center>
						<s:property value="feedback_content" />
					</center>
				</td>
				<td class="editTd">
					<center>
						<s:property value="feedback_dept_name" />
				</td>
				<td class="editTd" >
				<center>
					<s:property value="feedback_date" />
					</center>
				</td>
				<td class="editTd">
					<center>
						<a href="javascript:void(0);" onclick="viewFeedback('${id}','<s:property value="feedback_author_code" />')">查看</a>
					</center>
				</td>
			</tr>
		</s:iterator>
	</table>
 
