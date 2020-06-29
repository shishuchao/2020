<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<tr>
	<td class="listtabletr1">
	是否发布
	</td>
	<td class="listtabletr2" id="my_pub">
		<s:if test="${assistSuportLawslib.pub_state=='Y'}">
			是
		</s:if>
		<s:else>
			否
		</s:else>
	</td>
	<td class="listtabletr1">
	</td>
	<td class="listtabletr2">
	</td>
</tr>