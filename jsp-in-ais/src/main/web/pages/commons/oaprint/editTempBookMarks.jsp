<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form id="ff" method="post">
<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	<tr>
		<td class="EditHead" style="text-align: center;">标签编码</th>
		<td class="EditHead" style="text-align: center;">标签文字</th>
	</tr>
		<tr>
			<td class="editTd" style="text-align: center; vertical-align:middle;">
				<s:hidden name="bookMarks.tbmid"></s:hidden>
				<s:hidden name="bookMarks.templateid"></s:hidden>
				<s:textfield  cssClass="noborder"name="bookMarks.bookmarkid" id="bookmarkid"></s:textfield>
			</td>
			<td class="editTd" style="text-align: center; vertical-align:middle;">
				<s:textfield  cssClass="noborder"name="bookMarks.bookmarktext" id="bookmarktext"></s:textfield>
			</td>
		</tr>
			<tr>
			<td class="editTd"  colspan="2" style="text-align: right; vertical-align:middle;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveTempBookMarks('${bookMarks.templateid}');">保存</a>&nbsp;&nbsp;
			</td>
		</tr>
</table>

</form>