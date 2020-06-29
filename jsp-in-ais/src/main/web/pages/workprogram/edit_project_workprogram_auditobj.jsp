<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>工作方案明细列表</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<link rel="stylesheet" type="text/css"	href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<script type="text/javascript"	src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>

<s:head theme="ajax" />

<script language="javascript">
function editwppd(wppdid,wppdupid,index){
	var bObject = event.srcElement;
	var tdObject = bObject.parentNode;
	var trObject = tdObject.parentNode;
	var guid="";
    if(wppdupid){
    	guid=wppdupid;
    }else{
    	guid="<%=new UUID().toString()%>"+index;
    }
    var num=Math.random();
    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
    window.open('${contextPath}/commons/file/welcome4wp.action?projectid=${projectid}&guid='+guid+'${fileFlag}&param='+rnm+'&deletePermission=true&wppid='+wppdid+"&rowIndex="+trObject.rowIndex,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}

function editUploadFileUrl(rowIndex,filename,fileid,projectid,uploadfileid){
	var trObject = document.getElementById("workprogramdetailTable").rows(rowIndex/1);
	var fileurl="";
    for(var i=0;i<filename.length-1;i++){
        fileurl+= "<a id='_a" + fileid[i] + "' href='${contextPath}/commons/file/downloadFile.action?fileId="+fileid[i]+"' target='_blank'>"+filename[i]+"</a>" +
				"<a href='javascript:void(0);' id='_v" + fileid[i] + "' onclick=\"viewDoc('" + projectid + "','" + fileid[i] + "')\">[查看]</a>" +
				"<a href='javascript:void(0);' id='_e" + fileid[i] + "' onclick=\"editDoc('" + projectid + "','" + fileid[i] + "')\">[编辑]</a>" +
				"<a href='javascript:void(0);' id='_d" + fileid[i] + "' onclick=\"deleteUploadFile('" + uploadfileid + "','" + fileid[i] + "')\">[删除]</a>" +
				"<a href='javascript:void(0);' id='_s" + fileid[i] + "' onclick=\"sendEmail('" + uploadfileid + "')\">[邮件发送]</a>" +
				"<br/>";
    }
    if(rowIndex==1){
	   trObject.cells(4).innerHTML=fileurl;
    }else{
    	trObject.cells(3).innerHTML=fileurl;
    }    
}


var templateLinkId;
var genLinkId;
function generateDoc(guid, fileGuid, templateId,projdetailid){
    templateLinkId = "_t" + templateId;
    genLinkId = "_gen" + templateId;
    
    var genLink = document.getElementById(genLinkId);
    
    genLink.innerHTML = "正在创建...";
    genLink.disabled = "disabled";
    
	var h = window.screen.availHeight;
	var w = window.screen.availWidth;
	window.showModalDialog(
			"/ais/workprogram/docgenerate.action?projdetailid="+projdetailid+"&projectId=" + guid + 
					"&fileGuid=" + fileGuid +
				"&templateId=" + templateId + 
				"&parentURL=" + escape("${contextPath}/workprogram/editWorkProgramProjectDetail.action?<%=request.getQueryString()%>"),
				window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:yes');
}

function editDoc(guid, docId) {
	var editLink = document.getElementById("_e" + docId);
	editLink.value = "编辑中...";
	editLink.disabled = "disabled";
	
	var a = document.getElementById("_a" + docId);
	a.disabled = "disabled";
	var d = document.getElementById("_d" + docId);
	d.disabled = "disabled";
	var v = document.getElementById("_v" + docId);
	v.disabled = "disabled";
	
	var h = window.screen.availHeight;
	var w = window.screen.width;
	window.showModalDialog(
			"/ais/workprogram/editdoc.action?projectId=" + guid +
					"&docId=" + docId +
				"&parentURL=" + escape("${contextPath}/workprogram/editWorkProgramProjectDetail.action?<%=request.getQueryString()%>"),
				window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:yes');
}

function viewDoc(guid, docId) {
	var viewLink = document.getElementById("_v" + docId);
	viewLink.value = "查看中...";
	viewLink.disabled = "disabled";
	
	var a = document.getElementById("_a" + docId);
	a.disabled = "disabled";
	var d = document.getElementById("_d" + docId);
	d.disabled = "disabled";
	var e = document.getElementById("_e" + docId);
	e.disabled = "disabled";
	
	var h = window.screen.availHeight;
	var w = window.screen.width;
	window.showModalDialog(
			"/ais/workprogram/viewdoc.action?projectId=" + guid + 
					"&docId=" + docId +
				"&parentURL=" + escape("${contextPath}/workprogram/editWorkProgramProjectDetail.action?<%=request.getQueryString()%>"),
				window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:yes');
}

var tagAId;
var tagInputId;
var editLinkId;
var viewLinkId;
function deleteUploadFile(guid, fileId) {
	if(window.confirm("确定删除此文件吗？")){
		tagAId = "_a" + fileId;
		tagInputId = "_d" + fileId;
		editLinkId = "_e" + fileId;
		viewLinkId = "_v" + fileId;
		mailLinkId = "_s" + fileId;
		
		var delBtn = document.getElementById(tagInputId);
		delBtn.value = "删除中...";
		delBtn.disabled = "disabled";
		
		var a = document.getElementById(tagAId);
		a.disabled = "disabled";
		var e = document.getElementById(editLinkId);
		e.disabled = "disabled";
		var v = document.getElementById(viewLinkId);
		v.disabled = "disabled";
		
		var s = document.getElementById(mailLinkId);
		s.disabled = "disabled";
		
		
		
		DWREngine.setAsync(true);
		DWREngine.setAsync(false);DWRActionUtil.execute(
				{"namespace":"/commons/file", "action": "delFile", "executeResult": "false"},
				{"fileId" : fileId, "guid" : guid},
				delCallBack
			);
	}
}

function delCallBack(data) {
	var a = document.getElementById(tagAId);
	a.parentNode.removeChild(a);
	var d = document.getElementById(tagInputId);
	d.parentNode.removeChild(d);
	var e = document.getElementById(editLinkId);
	e.parentNode.removeChild(e);
	var v = document.getElementById(viewLinkId);
	v.parentNode.removeChild(v);
	var s = document.getElementById(mailLinkId);
	s.parentNode.removeChild(s);
}
/**发送有邮件**/
function sendEmail(guid){
	var vHeight = document.body.scrollHeight + 300;
    window.resizeTo(document.body.scrollWidth, vHeight);
	showPopWin('<%=request.getContextPath()%>/msg/sendMail.action?innerMsg.attachmentsId='+guid,500,350,'发送邮件');
}
</script>
</head>
<body>
<s:form id="workprogramDetailForm" action="saveWorkprogramDetail" namespace="/workprogram">
    <s:hidden name="projectid" value="${projectid}"/>
    <table id="workprogramdetailTable"  class="its" align="center">
        <tr>
            <td style="text-align: center;width: 10%;" class="ListTableTr11">阶段名称</td>
            <td style="text-align: center;width: 12%;" class="ListTableTr11" nowrap>流程节点</td>
            <td style="text-align: center;width: 10%;" class="ListTableTr11" nowrap>是否必做</td>
            <td style="text-align: center;width: 30%;" class="ListTableTr11" nowrap>对应模板</td>
            <td style="text-align: center;width: 30%;" class="ListTableTr11" nowrap>阶段性文书</td>
            <td style="text-align: center;width: 8%;" class="ListTableTr11" nowrap>操作</td>
        </tr>
        <c:forEach items="${projectStageList}" var="projstage">
            <tr class="odd">
                 <c:choose>
                  <c:when test="${empty projstage.wppdList}">
                        <td id="${projstage.stagecode}" rowspan='1' style="text-align: center;" class="ListTableTr11"> ${projstage.stagename} </td>
                  </c:when>
                   <c:otherwise>
                        <td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wppdList)}"></c:out>' style="text-align: center;" class="ListTableTr11"> ${projstage.stagename}</td>
                   </c:otherwise>
                  </c:choose>
               <c:choose>
                   <c:when test="${empty projstage.wppdList}">
                        <td style="text-align: left;" class="ListTableTr22">&nbsp;</td>
                        <td style="text-align: left;" class="ListTableTr22">&nbsp;</td>
                        <td style="text-align: left;" class="listtabletr22">&nbsp;</td>
                        <td style="text-align: left;" class="listtabletr22">&nbsp;</td>
                        <td style="text-align: left;" class="listtabletr22">&nbsp;</td>
                   </c:when>
                   <c:otherwise>
                   <c:forEach items="${projstage.wppdList}" var="wppd" begin="0" end="0">
                        <td style="text-align: left;">${wppd.workprogramdetailname}</td>
                        <td class="odd" style="text-align: center;">${wppd.needdo}</td>
                        <td class="odd" style="text-align: left;">${wppd.templateFileUrl}</td>
                        <td class="odd" style="text-align: left;">${wppd.uploadFileUrl}</td>
                        <td class="odd" style="text-align: center;">
	                        <c:if test="${view != 'view' }">
	                        	<input type="button" value="添加" onclick="editwppd('${wppd.projdetailid}','${wppd.uploadfileid}','')"/>
	                        </c:if>
                        </td>
                   </c:forEach>
                   </c:otherwise>
                </c:choose>
                 </tr>
                <c:if test="${not empty projstage.wppdList}">
                   <c:if test="${fn:length(projstage.wppdList)>1}">
                         <c:forEach items="${projstage.wppdList}" begin="1" var="wppd" varStatus="state">
                         <tr class="odd">
                            <td style="text-align: left;">${wppd.workprogramdetailname}</td>
                            <td style="text-align: center;">${wppd.needdo}</td>
                            <td style="text-align: left;">${wppd.templateFileUrl}</td>
                            <td style="text-align: left;">${wppd.uploadFileUrl }</td>
                            
                            <td style="text-align: center;">
                            	<c:if test="${view != 'view' }">
	                            	<input type="button" value="添加" onclick="editwppd('${wppd.projdetailid}','${wppd.uploadfileid}','${state.index}')"/>
    							</c:if>
                            </td>
                         </tr>                    
                        </c:forEach>
                    </c:if>
                </c:if>
        </c:forEach>
    </table>
</s:form>
</body>
</html>