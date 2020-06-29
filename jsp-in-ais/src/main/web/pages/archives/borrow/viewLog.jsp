<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML>
<html>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<title>借阅详细-查看</title>
	</head>
	<body>
		<s:form action="viewLog" namespace="/archives/borrow" name="form">
			<center>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td colspan="4" >
						<font style="float: left;">档案借阅详细信息</font>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width: 15%;">借阅发起人</td>
					<td class="editTd" style="width: 35%;">
						<s:property value="crudObject.start_borrow_man_name" />
					</td>
					<td class="EditHead" style="width: 15%;">借阅发起人单位</td>
					<td class="editTd" style="width: 35%;">
						<s:property value="crudObject.start_borrow_unit_name" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">借阅起始时间</td>
					<td class="editTd">
						<s:property value="crudObject.start_borrow_time" />
					</td>
					<td class="EditHead">借阅结束时间</td>
					<td class="editTd">
						<s:property value="crudObject.end_borrow_time" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">内部借阅人</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.in_borrow_man_name" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">借阅理由</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.borrow_reason" />
					</td>
				</tr>
			</table>
			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%> 
			<center>
		    <table id="workprogramdetailTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	            <tr >
					<td colspan="5">
						<font style="float: left;">授权借阅文件列表</font>	
					</td>
				</tr>
	        <tr>
	            <td style='text-align:center;' nowrap="nowrap" class="EditHead">审计阶段</td>
	            <td style='text-align:center;' nowrap="nowrap" class="EditHead">流程节点</td>
	            <td style='text-align:center;' nowrap="nowrap" class="EditHead">是否必做</td>
	            <td style='text-align:center;' nowrap="nowrap" class="EditHead">文件类型</td>
	            <td style='text-align:center;' nowrap="nowrap" class="EditHead">审计文书</td>
	        </tr>
	        <c:forEach items="${projectStageList}" var="projstage">
            <tr>
               <c:choose>
                  <c:when test="${empty projstage.wppdArchivesList}">
                        <td id="${projstage.stagecode}" rowspan='1' align="center" class="editTd"> ${projstage.stagename} </td>
                  </c:when>
                   <c:otherwise>
                        <td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wppdArchivesList)}"></c:out>' align="center" class="editTd"> ${projstage.stagename}</td>
                   </c:otherwise>
               </c:choose>
               <c:choose>
                   <c:when test="${empty projstage.wppdArchivesList}">
                        <td align="left" class="editTd">&nbsp;</td>
                        <td style="text-align: center;" class="editTd">&nbsp;</td>
                        <td style="text-align: center;" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                   </c:when>
                   <c:otherwise>
	                   <c:forEach items="${projstage.wppdArchivesList}" var="wppd" begin="0" end="0">
	                        <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
	                        <td style="text-align: center;" class="editTd">${wppd.needdo}</td>
	                        <td style="text-align: center;" class="editTd" nowrap="nowrap">
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
                            <td style="text-align: center;" class="editTd">${wppd.needdo}</td>
                            <td style="text-align: center;" class="editTd" nowrap="nowrap">
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
	
			<!-- <div align="right" style="width: 97%">
	
	                   <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"  onclick="window.close();" />关闭</a>
			</div> -->
			
			</center>
		</s:form>
	</body>
</html>
