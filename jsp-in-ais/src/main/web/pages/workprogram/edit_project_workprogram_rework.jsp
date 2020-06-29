<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>工作方案明细列表edit</title>
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>

<s:head theme="ajax" />

<script language="javascript">
//function editwppd(wppdid,wppdupid,index){
	function editwppd(wppdid,wppdupid,index,template_id){
	var bObject = event.srcElement;
	var tdObject = bObject.parentNode;
	var trObject = tdObject.parentNode;
	var guid="";
	//template_id
    if(wppdupid){
    	guid=wppdupid;
     }else{
    	 guid="<%=new UUID().toString()%>"+index;
     }
	 
	    var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	  // window.open('${contextPath}/commons/file/welcome4wp.action?table_name=mng_aud_workprogram_detail&&talbe_guid='+guid+'&guid='+guid+'&param='+rnm+'&deletePermission=true&wppid='+wppdid+"&rowIndex="+trObject.rowIndex,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
    	window.open('${contextPath}/commons/file/welcome4wparchives.action?table_name=mng_aud_workprogram_detail&table_guid=template_id&guid='+guid+'&param='+rnm+'&deletePermission=true&wppid='+wppdid+"&rowIndex="+trObject.rowIndex,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

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
	if(viewLink){
		viewLink.value = "查看中...";
		viewLink.disabled = "disabled";	
	}
	var a = document.getElementById("_a" + docId);
	if(a){
		a.disabled = "disabled";
	}
	
	var d = document.getElementById("_d" + docId);
	if(d){
		d.disabled = "disabled";
	}
	
	var e = document.getElementById("_e" + docId);
	if(e){
		e.disabled = "disabled";	
	}
	
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
		if(a){
			a.disabled = "disabled";
		}
		
		var e = document.getElementById(editLinkId);
		if(e){
			e.disabled = "disabled";
		}		
		
		var v = document.getElementById(viewLinkId);
		if(v){
			v.disabled = "disabled";
		}		
		
		var s = document.getElementById(mailLinkId);
		if(s){
			s.disabled = "disabled";
		}		
		
		
		
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

 function load() {
	$('#download').linkbutton('disable');
	var project_id = "${projectid}";
	window.location.href = "${contextPath}/templatedownload?file=track_ledger_template.xls&permission=${permission}&type=trackLedger&project_id="+project_id;
 }
	
 function submit_dr(){
	var template = document.all('template').value;
	if(template == ''){
		$.messager.alert('系统提示',"请先选择要导入的文件",'warning');			
		return;
	}
	jQuery("#importForm").submit();		
 }

 function wait() {
	document.getElementById("importButton").disabled = true;
	document.getElementById("layer").style.display = "";
	document.getElementById("errorInfo1").style.display = "none";
	document.getElementById("errorInfo2").style.display = "none";		
	}

</script>
</head>
<body style="overflow: hidden;" class="easyui-layout"  fit="true" id="lay">
	<s:if test="${isSource eq 'inner'}">
	<div region="north" style="padding:0px; overflow:hidden;height:280px;" border="false" >
	</s:if>
	<s:else>
	<div region="north" style="padding:0px; overflow:hidden;height:80px;" border="false" >
	</s:else>
		<div style="text-align: right; margin-top: 5px; margin-right: 10px;">
			<!-- <div id="errorMsg"></div> -->
			<a id="submitBtn" class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="submitFeedback()">
				<s:if test="${en eq 'en'}">
					Submit
				</s:if>
				<s:else>
					提交
				</s:else>
			</a>
			<%--&nbsp;&nbsp;
			<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">
				<s:if test="${en eq 'en'}">
					Back
				</s:if>
				<s:else>
					返回
				</s:else>
			</a>--%>
		</div>
		<%--<br>--%>
		<s:if test="${en eq 'en'}">
			<div class="easyui-panel" style="width:100%;padding:0px;overflow:hidden;"  title="Additional Audit Documents" split="false" collapsible="false" border="false" id="docPanel">
		</s:if>
		<s:else>
			<s:if test="${isSource eq 'inner'}">
			<div class="easyui-panel" style="width:100%;padding:0px;overflow:hidden;"  title="补充性审计文书" split="false" collapsible="false" border="false" id="docPanel">
			</s:if>
			<s:else>
			<div class="easyui-panel" style="width:100%;padding:0px;overflow:hidden;"  title="" split="false" collapsible="false" border="false" id="docPanel">
			</s:else>
		</s:else>
			<s:form id="workprogramDetailForm" action="saveWorkprogramDetail" namespace="/workprogram">
			    <s:hidden name="projectid" value="${projectid}"/>
			<s:if test="${isSource eq 'inner'}">
				<table id="workprogramdetailTable"  cellpadding=0 cellspacing=0 border=0  class="ListTable"  style="width:100%;">
					<tr>
						<td style="text-align: center;width: 10%;" class="EditHead">
							<s:if test="${en eq 'en'}">
								Phase Name
							</s:if>
							<s:else>
								阶段名称
							</s:else>
						</td>
						<td style="text-align: center;width: 12%;" class="EditHead" nowrap>
							<s:if test="${en eq 'en'}">
								Flow Node
							</s:if>
							<s:else>
								流程节点
							</s:else>
						</td>
						<td style="text-align: center;width: 10%;" class="EditHead" nowrap>
							<s:if test="${en eq 'en'}">
								Do or Not Do
							</s:if>
							<s:else>
								是否必做
							</s:else>
						</td>
						<td style="text-align: center;width: 30%;" class="EditHead" nowrap>
							<s:if test="${en eq 'en'}">
								Template
							</s:if>
							<s:else>
								对应模板
							</s:else>
						</td>
						<td style="text-align: center;width: 30%;" class="EditHead" nowrap>
							<s:if test="${en eq 'en'}">
								Document
							</s:if>
							<s:else>
								阶段性文书
							</s:else>
						</td>
						<td style="text-align: center;width: 8%;" class="EditHead" nowrap>
							<s:if test="${en eq 'en'}">
								Operation
							</s:if>
							<s:else>
								操作
							</s:else>
						</td>
					</tr>
					<c:forEach items="${projectStageList}" var="projstage">
						<tr class="odd">
							<c:choose>
								<c:when test="${empty projstage.wppdList}">
									<td id="${projstage.stagecode}" rowspan='1' style="text-align: center;" class="EditHead"> ${projstage.stagename} </td>
								</c:when>
								<c:otherwise>
									<td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wppdList)}"></c:out>' style="text-align: center;" class="EditHead"> ${projstage.stagename}</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${empty projstage.wppdList}">
									<td style="text-align: left;" class="editTd">&nbsp;</td>
									<td style="text-align: left;" class="editTd">&nbsp;</td>
									<td style="text-align: left;" class="editTd">&nbsp;</td>
									<td style="text-align: left;" class="editTd">&nbsp;</td>
									<td style="text-align: left;" class="editTd">&nbsp;</td>
								</c:when>
								<c:otherwise>
									<c:forEach items="${projstage.wppdList}" var="wppd" begin="0" end="0">
										<td class="editTd" style="text-align: left;">${wppd.workprogramdetailname}</td>
										<td class="editTd" style="text-align: center;">${wppd.needdo}</td>
										<td class="editTd" style="text-align: left;">${wppd.templateFileUrl}</td>
										<td class="editTd" style="text-align: left;">
											<div id="shenjizuFiles_${wppd.projdetailid}"></div>
										</td>
										<td class="editTd" style="text-align: center;">
											<s:if test="${wppd.workprogramdetailname == '1、整改通知书' || wppd.workprogramdetailname == '1.整改通知书'}">
											</s:if>
											<s:else>
												<c:if test="${view != 'view' }">
													<span id="shenjizuBtn_${wppd.projdetailid}"></span>
												</c:if>
											</s:else>
										</td>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tr>
						<c:if test="${not empty projstage.wppdList}">
							<c:if test="${fn:length(projstage.wppdList)>1}">
								<c:forEach items="${projstage.wppdList}" begin="1" var="wppd" varStatus="state">
									<tr class="odd">
										<td  class="editTd" style="text-align: left;">${wppd.workprogramdetailname}</td>
										<td  class="editTd" style="text-align: center;">${wppd.needdo}</td>
										<td  class="editTd" style="text-align: left;">${wppd.templateFileUrl}</td>
										<td class="editTd" style="text-align: left;">
											<div id="shenjizuFiles_${wppd.projdetailid}"></div>
										</td>
										<td class="editTd" style="text-align: center;">
											<s:if test="${wppd.workprogramdetailname == '1、整改通知书' || wppd.workprogramdetailname == '1.整改通知书'}">
											</s:if>
											<s:else>
												<c:if test="${view != 'view' }">
													<span id="shenjizuBtn_${wppd.projdetailid}"></span>
												</c:if>
											</s:else>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</c:if>
					</c:forEach>
				</table>
			</s:if>
			</s:form>
			</div>
			<br/>
			<%--<s:if test="${en eq 'en'}">
			<div style="width:100%;padding:0px;overflow:hidden;" id="tablePanel" class="easyui-panel" title="Rectification Follow Information" border="false" >
			</s:if>
			<s:else>
			<div style="width:100%;padding:0px;overflow:hidden;"  id="tablePanel" class="easyui-panel" title="整改跟踪信息" border="false" >
				</s:else>
			</div>--%>
		</div>
		<div region='center' border='0'>
			<table id='trackList' ></table>
<%--			<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
		            <iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		  	</div>--%>
	</div>
	<!-- start -->
	<div id="importProjects" style="padding: 0px;overflow:hidden;" title="导入整改跟踪信息" >
		<%--<s:form id="importForm" action="importTrackLedgerProblem" namespace="/proledger/problem" method="post" enctype="multipart/form-data" onsubmit="wait();">--%>
		<s:form id="importForm" action="importTrackLedgerProblem" namespace="/workprogram" method="post" enctype="multipart/form-data" onsubmit="wait();">
			<%--<s:hidden name="project_id"  value="${projectid}"/>--%>
			<s:hidden name="projectid"  value="${projectid}"/>
			<s:hidden name="view" value="${view }"/>
			<s:hidden name="projectType" value="${projectType}"/>
			<s:hidden name="formType" value="2"/>
			<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
				<tr>
					<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
					<td class="editTd" align="left"><s:file name="template" size="66%" cssStyle="font-size:15px" accept="application/vnd.ms-excel"/></td>
					<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-import'" id="importButton" onclick="submit_dr();">导入</a></td>
					<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-download'" id="download" onclick="load()">下载模板</a></td>
				</tr>
			</table>
			<s:hidden name="listStatus" />
		</s:form>
		<div region="center" border='0'>
			<div id="layer" style="display: none" align="center">
				<img src="${contextPath}/images/uploading.gif"> <br> 正在读取，请稍候......
			</div>
			<div align="left" id="errorInfo1">
				<s:if test="%{#tipList.size != 0}">
					<s:iterator value="%{#tipList}">
						&nbsp;&nbsp;&nbsp;●<s:property value="%{position}" />：<s:property value="%{errorInfo}" />
						<br>
					</s:iterator>
				</s:if>
			</div>
			<div align="left" id="errorInfo2">
				<s:if test="%{#tipMessage != null}">
					&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}" />
				</s:if>
			</div>
		</div>
	</div>
	<!-- end -->
	<script type="text/javascript">
		$(function(){
		    var en = '${en}' == 'en';
			if('${supervisorcode}' == 'view'){
				<c:forEach items="${projectStageList}" var="projstage">
				<c:forEach items="${projstage.wppdList}" var="wppd" >
					if(en){
						$('#shenjizuBtn_${wppd.projdetailid}').linkbutton({
							iconCls:'icon-upload',
							text:'Add File'
						});
					}

					<c:if  test="${wppd.workprogramdetailname == '1、整改通知书' || wppd.workprogramdetailname == '1.整改通知书'}">
						$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
							fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
							echoType:2,
							isDel:false,
							isEdit:false,
							uploadFace:en ? 2:1,
							triggerId:'shenjizuBtn_${wppd.projdetailid}'
						});
					</c:if>
					<c:if  test="${wppd.workprogramdetailname != '1、整改通知书' && wppd.workprogramdetailname != '1.整改通知书'}">
						$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
							fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
							echoType:2,
							isDel:false,
							isEdit:false,
							uploadFace:en ? 2:1,
							<s:if test="${fileUploaders} != ''">
							whereSql: "uploader in (${fileUploaders})",
							</s:if>
							triggerId:'shenjizuBtn_${wppd.projdetailid}'
						});
					</c:if>
				</c:forEach>
				</c:forEach>
			}else{
				<c:forEach items="${projectStageList}" var="projstage">
				<c:forEach items="${projstage.wppdList}" var="wppd" >
					if(en){
						$('#shenjizuBtn_${wppd.projdetailid}').linkbutton({
							iconCls:'icon-upload',
							text:'Add File'
						});
					}
               
	             	<c:if  test="${wppd.workprogramdetailname == '1、整改通知书' || wppd.workprogramdetailname == '1.整改通知书'}">
						$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
							fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
							echoType:2,
							isDel:false,
							isEdit:false,
							uploadFace:en ? 2:1,
							triggerId:'shenjizuBtn_${wppd.projdetailid}'
						});
	              	</c:if>
	              	<c:if  test="${wppd.workprogramdetailname != '1、整改通知书' && wppd.workprogramdetailname != '1.整改通知书'}">
						$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
							fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
							echoType:2,
							isDel:true,
							isEdit:true,
							uploadFace:en ? 2:1,
							<s:if test="${fileUploaders} != ''">
							whereSql: "uploader in (${fileUploaders})",
							</s:if>
							triggerId:'shenjizuBtn_${wppd.projdetailid}'
						});
	              	</c:if>
				</c:forEach>
				</c:forEach>
			}
		});
		$(function(){
		    //设置跟踪信息表格面板高度
		    /*var center = $('#lay').layout('panel','center');
		    var docPanelHeight = $('#docPanel').panel('options').height;
		    var centerHeight = center.panel('options').height;
		    $('#tablePanel').panel('resize',{
		       height:centerHeight-docPanelHeight-80
			});*/
            var en = '${en}' == 'en';
			$('#trackList').datagrid({
				url : "/ais/proledger/problem/auditTrackingListForAuditObject.action?project_id=${projectid}&querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				//fit: true,
				title:en ? 'Rectification Follow Information' : '整改跟踪信息',
				pageSize: 10,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				fit:true,
				toolbar:[
							{
								id:'impLedgerOwner',
								text:'批量导入',
								iconCls:'icon-import',
								handler:function(){
									$('#download').linkbutton('enable');
									$('#importProjects').window('open');
								}
							}
							
						],
				/*columns:[[
					{field:'id',width:'50', hidden:true, align:'center'},
					{field:'audit_con',title:en ? 'Title':'问题标题',align:'center',width:'15%', sortable:true},
                	{field:'problem_grade_name',title:en ? 'Type':'审计发现类型', width:'10%', halign:'center',align:'left',sortable:true},
					{field:'problem_desc',title:en ? 'Describe':'问题描述',width:'15%',sortable:true, halign:'center',align:'left'},
					{field:'audit_law',title:en ? 'Qualitative Basis':'定性依据',width:'13%', halign:'center',align:'left',sortable:true},
					{field:'aud_mend_advice',title:en ? 'Recommendation':'审计建议', width:'8%', halign:'center',align:'left',sortable:true},
					{field:'mend_state',title:en ? 'Status':'整改状态', width:'8%', halign:'center',align:'left',sortable:true},
					{field:'operate',title:en ? 'Follow':'整改跟踪',width:'8%',align:'center',
						formatter:function(value,rowData,rowIndex){
							return '<a href=\"javascript:void(0)\" onclick=\"trackInfo(\''+rowData.id+'\');\">'+(en ? 'Follow':'跟踪信息')+'</a>';
				}	
					}
				]]*/
                columns:[[
                    {field:'id',width:'50', hidden:true, align:'center'},
                    {field:'serial_num',title:'问题编号',align:'center',width:'15%', sortable:true},
                    {field:'problem_all_name',title:'问题类别',width:'15%',sortable:true, halign:'center',align:'left',
                        formatter:function(value,rowData,rowIndex){
                        	if (value == null){
                        	    return ""
							}
                            var problemVa = [];
                            if (value.indexOf("-")>=0) {
                                problemVa = value.split("-");
                                value = problemVa[0];
                            }

                            return value;
                        }

					},
                    {field:'problem_name',title:'问题点',width:'13%', halign:'center',align:'left',sortable:true},
                    {field:'problem_money',title:'发生金额(万元)', halign:'center',width:'7%',align:'right',sortable:true
						,formatter:aud$gridFormatMoney
					},
                    {field:'problemCount',title:'发生数量(个)',sortable:true, width:'7%',halign:'center',align:'right'},
                    {field:'zeren',title:'问题性质', width:'10%', halign:'center',align:'left',sortable:true},
                    {field:'examine_creater_name',title:'监督检查人', width:'8%', halign:'center',align:'left',sortable:true},
                    {field:'mend_state',title:'整改状态', width:'8%', halign:'center',align:'left',sortable:true},
                    {field:'operate',title:'整改跟踪',width:'8%',align:'center',
                        formatter:function(value,rowData,rowIndex){
                            return '<a href=\"javascript:void(0)\" onclick=\"trackInfo(\''+rowData.id+'\');\">跟踪信息</a>';
                        }
                    }
                ]]

            });
			
			$('#importProjects').window({
				title:'整改跟踪信息导入',
				modal:true,
				width:900,
				height:450,
				minimizable: false,
				maximizable: false,
				collapsible: false,
				closed:true
			});
          
			<s:if test="${operate1 == 'imp'}">
		 	  $('#importProjects').window('open');
			</s:if> 
			
		});
			
		function trackInfo(id){
			var trackUrl = "${contextPath}/proledger/problem/feedbackListForAuditObject.action?en=${en}&middleLedgerProblem_id="+id+"&project_id=${projectid}&view=edit";
			window.location.href= trackUrl; 
		}
			
			
		function closeWin(){
			 $('#planName').window('close');
		}
		function saveCloseWin(){
			 $('#planName').window('close');
			 showMessage2("保存成功！");
		}
		/* 刷新 */
		function reloadtrackList(){
			$('#trackList').datagrid('reload');
		}

		/*
			校验两个日期大小顺序
		*/
		function validateDate(beginDateId,endDateId){
			var s1 = document.getElementById(beginDateId);
			var e1 = document.getElementById(endDateId);
			if(s1 && e1){
				var s = s1.value;
				var e = e1.value;
				if(s!='' && e!=''){
					var s_date=new Date(s.replace("-","/"));
					var e_date=new Date(e.replace("-","/"));
					if(s_date.getTime()>e_date.getTime()){
						window.alert("日期区间开始必须小于结束!");
						return false;
					}
				}
			}
			return true;
		}
		$('#planName').window({
            width:1000, 
            height:500,  
            modal:true,
            collapsible:false,
            maximizable:true,
            minimizable:false,
            closed:true,
            maximized:true
        });
		
		function back(){
			
			window.location.href = "/ais/project/rework/listAllForAuditObject.action?en=${en}";
		}
		
		//提交
		function submitFeedback(){
			//整改阶段文书必做检查 by zxl 2020.2.21
			var zgRows = $("#workprogramdetailTable tr");
			if (zgRows!=null && zgRows.length>0){
				for(var i=1; i<zgRows.length; i++){
					var sfbzCol = 2;
					if (i>1){
						sfbzCol = 1;
					}
					var fjCol = sfbzCol+2;
					var sfbz = $("#workprogramdetailTable").find("tr:eq("+i+") td:eq("+sfbzCol+")");
					if (sfbz!=null && $(sfbz).text()=="是"){
						var fj = $("#workprogramdetailTable").find("tr:eq("+i+") td:eq("+fjCol+")");
						if ($(fj).find("div a").length==0){
							showMessage1("有必做文书没有上传，请上传后再提交！");
							return;
						}
					}
				}
			}

			//当前表格显示的可能不是全部问题，放到后端验证
			/*var rows = $('#trackList').datagrid('getRows');
			if(rows && rows.length>0){
				for(var j = 0; j < rows.length; j++){
					var row = rows[j];
					if (row['mend_state']==null || row['mend_state']==''){
						showMessage1('请完成所有问题的整改反馈！');
						return;
					}
				}
			}*/
			var project_id = "${projectid}";
			$.ajax({
				url : "${contextPath}/proledger/problem/submitFeedback.action",
				data: {project_id:project_id, checkData: "1"},
				type: "POST",
				success: function(data){
					if(data){
						if(data.type == 'error'){
							showMessage1(data.errorMsg[0]);
							return;
						}else if(data.type!='exception'){
							try{
								$("#submitBtn").removeAttr('onclick');
								$.messager.confirm("提示","提交后已录入的信息或上传的附件将不可修改，确认提交吗？",function(r){
									if(r){
										$.ajax({
											url : "${contextPath}/proledger/problem/submitFeedback.action",
											data: {project_id:project_id},
											type: "POST",
											success: function(data){
												if(data){
													if(data.type == 'error'){
														showMessage1(data.errorMsg[0]);
													}else if(data.type!='exception'){
														top.$.messager.show({
															title: "消息",
															msg: "提交成功！",
														});
														window.location.reload();
													}
												}
											},
											error:function(data){
												top.$.messager.show({
													title:"消息",
													msg:"提交失败！",
												});
											}
										});
									}
								});
							}finally {
								$("#submitBtn").attr('onclick', 'submitFeedback();');
							}
						}
					}
				},
				error:function(data){
					top.$.messager.show({
						title:"消息",
						msg:"请求错误！",
					});
				}
			});
		}

	</script>
</body>
</html>