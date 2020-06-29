<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<td class="EditHead">
	是否发布
	</td>
	<td class="editTd">
		<s:if test="${assistSuportLawslib.pub_state=='Y'}">
			是
		</s:if>
		<s:else>
			否
		</s:else>
	</td>
