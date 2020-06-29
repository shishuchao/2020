<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body style="overflow-y:auto">		
	<a style="padding-left:20px;" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="editTempBookMarks('','${tid}');" href="javascript:void(0);">新增</a>
	<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
		<tr>
			<td  style="text-align: center; vertical-align:middle;" class="EditHead" >标签编码</td>
			<td   style="text-align: center; vertical-align:middle;" class="EditHead">标签文字</td>
			<td  style="text-align: center; vertical-align:middle;" class="EditHead" >操作</td>
		</tr>
		<s:iterator value="#request.bookMarkList" id="bm">
			<tr>
				<td class="editTd" style="text-align: center; vertical-align:middle;">
				${bm.bookmarkid }
				</td>
				<td class="editTd" style="text-align: center; vertical-align:middle;" >
				${bm.bookmarktext }
				</td>
				<td class="editTd" style="text-align: center; vertical-align:middle;">
				<a
					href='javascript:void(0);'
					onclick="editTempBookMarks('${bm.tbmid}','${tid }');">编辑</a> &nbsp;&nbsp; 
				<a href='javascript:void(0);'
					onclick="deleteTempBookMarks('${bm.tbmid}','${tid }');"
					>删除</a>
				</td>
			</tr>
		</s:iterator>
	</table>
</body>