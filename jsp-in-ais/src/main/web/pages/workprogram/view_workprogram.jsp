<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>工作方案明细列表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<s:head theme="ajax" />
	</head>
	<body style="overflow-x: hidden;">
		<s:form id="workprogramDetailForm" action="saveWorkprogramDetail" namespace="/workprogram">
		    <s:hidden name="wpid" value="${wpid}"/>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor=""
			   class="ListTable" width="100%" align="center">
				<tr >
					<td colspan="5" align="left" class="topTd">
						<div style="display: inline;width:80%;">
							工作方案模板名称：<s:property value="wp_name"/>
						</div>
					</td>
				</tr>
			</table>
		    <table id="workprogramdetailTable" cellpadding=0 cellspacing=0 border=0
		                 class="ListTable" align="center">
		        <tr>
		            <td style="text-align:center" class="EditHead">阶段名称</td>
		            <td style="text-align:center" class="EditHead">流程节点</td>
		            <td style="text-align:center" class="EditHead">是否必做</td>
		            <td style="text-align:center" class="EditHead">对应模板</td>
		        </tr>
		        <c:forEach items="${projectStageList}" var="projstage">
		            <tr>
		                <c:choose>
			                <c:when test="${empty projstage.wpdList}">
			                	<td id="${projstage.stagecode}" rowspan='1' style="text-align:center" class="editTd"> ${projstage.stagename} </td>
			                </c:when>
			                <c:otherwise>
			                	<td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wpdList)}"></c:out>' style="text-align:center" class="editTd"> ${projstage.stagename}</td>
			                </c:otherwise>
		                </c:choose>
						<c:choose>
		                	<c:when test="${empty projstage.wpdList}">
		                        <td align="left" class="editTd">&nbsp;</td>
		                        <td align="left" class="editTd">&nbsp;</td>
		                        <td align="left" class="editTd">&nbsp;</td>
		                	</c:when>
		               		<c:otherwise>
		                	<c:forEach items="${projstage.wpdList}" var="wpd" begin="0" end="0">
		                    	<td align="left" class="editTd">${wpd.workprogramdetailname}</td>
		                        <td style='text-align:center;' class="editTd">${wpd.needdo}</td>
		                        <td align="left" class="editTd">${wpd.fileurl}</td>
		                	</c:forEach>
		               		</c:otherwise>
		               	</c:choose>
					</tr>
					<c:if test="${not empty projstage.wpdList}">
		            	<c:if test="${fn:length(projstage.wpdList)>1}">
		                	<c:forEach items="${projstage.wpdList}" begin="1" var="wpd">
		                    	<tr>
		                        	<td align="left" class="editTd">${wpd.workprogramdetailname}</td>
		                            <td style='text-align:center;' class="editTd">${wpd.needdo}</td>
		                            <td align="left" class="editTd">${wpd.fileurl}</td>
		                        </tr>                    
		                   	</c:forEach>
		             	</c:if>
		          	</c:if>
				</c:forEach>
				<!-- <tr>
		        	<td align="right" colspan="6" class="bottomTd">
		        	    <a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="self.close()">关闭</a>
		          	</td>
		       	</tr> -->
			</table>
		</s:form>
	</body>
</html>