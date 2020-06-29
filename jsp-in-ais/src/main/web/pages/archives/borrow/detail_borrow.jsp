<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<base target="_self">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>项目档案文档</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
   <script type="text/javascript">
   	/*
   	 * 返回
   	 */
   	function back(){
		window.history.back();
	}
   </script>
   </head>
<body>
<div align="left" style='padding:10px 0px 0px 10px;'>
    <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javaxcript:window.history.back()">返回</a>
</div>                       	
	<s:form action="detail" name="form" id="form"
		namespace="/archives/borrow">
		<%@include file="/pages/archives/pigeonhole/view_archivesAll.jsp"%>
		<center>
			<table class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%;">
						内部借阅
					</td>
					<td class="editTd" style="width:35%;">
						<s:property value="crudObject.in_borrow_man_name" />

				</td>
				<td class="EditHead" style="width:15%;">
					内部借阅人单位
				</td>
				<td class="editTd" style="width:35%;">
					<s:property value="crudObject.in_borrow_unit_name" />
				</td>
			</tr>


			<tr>
				<td class="EditHead">
					借阅发起人
				</td>
				<td class="editTd">
					<s:property value="crudObject.start_borrow_man_name" />
				</td>
				<td class="EditHead">
					借阅发起人单位
				</td>
				<td class="editTd">
					<s:property value="crudObject.start_borrow_unit_name" />
				</td>
			</tr>



			<tr>
				<td class="EditHead">
					借阅起始时间
				</td>
				<td class="editTd">
					<s:property value="crudObject.start_borrow_time" />
				</td>
				<td class="EditHead">
					借阅结束时间
				</td>
				<td class="editTd">
					<s:property value="crudObject.end_borrow_time" />
				</td>
			</tr>

			<tr>
				<td class="EditHead">
					借阅理由
				</td>
				<td class="editTd" colspan="3">
					<s:property value="crudObject.borrow_reason" />
				</td>
			</tr>

		</table>
		</center>
	</s:form>
	<center>
	  <table cellpadding=0 cellspacing=1 border=0
		    class="ListTable" width="100%" align="center">
	        <tr>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">审计阶段</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">流程节点</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">是否必做</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">文件类型</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">审计文书</td>
	        </tr>
	        <c:forEach items="${projectStageList}" var="projstage">
            <tr>
                 <c:choose>
                  <c:when test="${empty projstage.wppdArchivesList}">
                        <td id="${projstage.stagecode}" rowspan='1' align="left" class="EditHead"> ${projstage.stagename} </td>
                  </c:when>
                   <c:otherwise>
                        <td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wppdArchivesList)}"></c:out>' align="left" class="EditHead"> ${projstage.stagename}</td>
                   </c:otherwise>
                </c:choose>
               <c:choose>
                   <c:when test="${empty projstage.wppdArchivesList}">
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                   </c:when>
                   <c:otherwise>
	                   <c:forEach items="${projstage.wppdArchivesList}" var="wppd" begin="0" end="0">
	                        <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
	                        <td align="left" class="editTd">${wppd.needdo}</td>
	                        <td align="left" class="editTd">
	                        <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
	                        <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
	                        <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
	                        <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
	                        </td>
	                        <td align="left" class="editTd">${wppd.uploadFileUrl}</td>
	                   </c:forEach>
                   </c:otherwise>
                </c:choose>
                 </tr>
                <c:if test="${not empty projstage.wppdArchivesList}">
                   <c:if test="${fn:length(projstage.wppdArchivesList)>1}">
                         <c:forEach items="${projstage.wppdArchivesList}" begin="1" var="wppd" varStatus="state">
                         <tr>
                            <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
                            <td align="left" class="editTd">${wppd.needdo}</td>
                            <td align="left" class="editTd">
	                        <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
	                        <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
	                        <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
	                        <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
	                        </td>
                            <td align="left" class="editTd">${wppd.uploadFileUrl }</td>
                         </tr>                    
                        </c:forEach>
                    </c:if>
                </c:if>
        </c:forEach>
        </table>
	</center>
	</body>
	
</html>
