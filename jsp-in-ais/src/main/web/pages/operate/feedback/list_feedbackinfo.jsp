<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 
	<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr class="listtablehead">
			 
				<td colspan="5" align="left" class="edithead">
					&nbsp;底稿反馈信息
				</td>
				 
			  
			 
		</tr>

		<tr align="center" class="titletable1">
			 
			<td width=15%>
				<center>
					反馈人
				</center>
			</td>
			
			<td width=50%>
				<center>
					反馈信息
				</center>
			</td>
			<td>
				<center width=15%>
					反馈人所在部门
				</center>
			</td>
			<td width=10%>
				<center>
					反馈日期
				</center>
				
			</td>
			<td width=10%>
				<center>
					操作
				</center>
				
			</td>
		</tr>
		<s:iterator value="feedbackInfoList">
			<tr>
				<td class="listtabletr2">
				<center>
					<s:property value="feedback_author_name" />
				</center>
				</td>
				<td class="listtabletr2" style='word-break:break-all;word-wrap:break-word;width:300px'>
					 
					<center>
						<s:property value="feedback_content" />
					</center>
				</td>
				<td class="listtabletr2">
					<center>
						<s:property value="feedback_dept_name" />
				</td>
				<td class="ListTableTr2" >
				<center>
					<s:property value="feedback_date" />
					</center>
				</td>
				<td class="listtabletr2">
					<center>
					<s:if test="'${feedback_ok}'=='1'">
					 </s:if>
					 <s:else>
					 <a href="javascript:void(0);" onclick="editFeedbackInfo('${id}')">编辑</a>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="deleteFeedback('${id}')">删除</a>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="sumbitFeedback('${id}')">提交</a>
					 </s:else>
					</center>
				</td>
			</tr>
		</s:iterator>
	</table>
 
