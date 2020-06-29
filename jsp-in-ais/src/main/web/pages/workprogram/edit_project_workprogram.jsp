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
</script>
</head>
<body style="overflow: hidden;" class='easyui-layout'>
	<div region="north" class="easyui-layout" style="padding:0px; overflow:auto;height: 266px" border="false" >
		<div class="easyui-panel" style="width:100%;padding:0px;overflow:hidden;"  title="补充性审计文书" split="false" collapsible="false" border="false">
			<s:form id="projectReworkForm" action="save" namespace="/project/rework">
			    <s:hidden name="projectid" value="${projectid}"/>
			    <table id="workprogramdetailTable"  cellpadding=0 cellspacing=0 border=0  class="ListTable"  style="width:100%;">
			        <tr>
			            <td style="text-align: center;width: 10%;" class="EditHead">阶段名称</td>
			            <td style="text-align: center;width: 12%;" class="EditHead" nowrap>流程节点</td>
			            <td style="text-align: center;width: 10%;" class="EditHead" nowrap>是否必做</td>
			            <td style="text-align: center;width: 30%;" class="EditHead" nowrap>对应模板</td>
			            <td style="text-align: center;width: 30%;" class="EditHead" nowrap>阶段性文书</td>
			            <td style="text-align: center;width: 8%;" class="EditHead" nowrap>操作</td>
			        </tr>
			        <c:forEach items="${projectStageList}" var="projstage">
			            <tr>
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
									<td style="text-align: left;" class="EditHead">&nbsp;</td>
			                        <td style="text-align: left;" class="EditHead">&nbsp;</td>
			                        <td style="text-align: left;" class="EditHead">&nbsp;</td>
			                        <td style="text-align: left;" class="EditHead">&nbsp;</td>
			                        <td style="text-align: left;" class="EditHead">&nbsp;</td>
			                   	</c:when>
			                   	<c:otherwise>
			                   	<c:forEach items="${projstage.wppdList}" var="wppd" begin="0" end="0">
			                        <td style="text-align: left;" class="editTd">${wppd.workprogramdetailname}</td>
			                        <td class="editTd" style="text-align: center;">${wppd.needdo}</td>
			                        <td class="editTd" style="text-align: left;">${wppd.templateFileUrl}</td>
			                        <%-- <td class="editTd" style="text-align: left;">${wppd.uploadFileUrl}</td>
			                        <td class="editTd" style="text-align: center;">
						                <c:if test="${view != 'view' }">
						                	<a id="btn" href="javascript:;" onclick="editwppd('${wppd.projdetailid}','${wppd.uploadfileid}','','${wppd.templateid}')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
					                   	</c:if>
			                        </td> --%>
			                        
			                        <td class="editTd" style="text-align: left;">
										<div id="shenjizuFiles_${wppd.projdetailid}"></div>
									</td>
									<td class="editTd" style="text-align: center;">
										<c:if test="${supervisorcode != 'view' }"> 
											<div id="shenjizuBtn_${wppd.projdetailid}"></div>
										 </c:if> 
									</td>
			                        
			                   	</c:forEach>
			                   	</c:otherwise>
			                </c:choose>
						</tr>
						<c:if test="${not empty projstage.wppdList}">
						   	<c:if test="${fn:length(projstage.wppdList)>1}">
								<c:forEach items="${projstage.wppdList}" begin="1" var="wppd" varStatus="state">
									<tr>
										<td style="text-align: left;" class="editTd">${wppd.workprogramdetailname}</td>
										<td style="text-align: center;" class="editTd">${wppd.needdo}</td>
										<td style="text-align: left;" class="editTd">${wppd.templateFileUrl}</td>
										<%-- <td style="text-align: left;" class="editTd">${wppd.uploadFileUrl }</td>

										<td class="editTd" style="text-align: center;">
											<c:if test="${view != 'view' }">
												<a id="btn" href="javascript:;" onclick="editwppd('${wppd.projdetailid}','${wppd.uploadfileid}','${state.index}')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
											</c:if>
										</td> --%>

										<td class="editTd" style="text-align: left;">
											<div id="shenjizuFiles_${wppd.projdetailid}"></div>
										</td>
										<td class="editTd" style="text-align: center;">
											<c:if test="${supervisorcode != 'view' }">
												<div id="shenjizuBtn_${wppd.projdetailid}"></div>
											 </c:if>
										</td>
								 	</tr>
								</c:forEach>
							</c:if>
						</c:if>
			        </c:forEach>
			    </table>
			    <s:hidden name="wpd_stagecode"/>
			</s:form>
		</div>
		<br/>

		<%--<div style="width:100%;padding:0px;overflow-y:hidden;" class="easyui-panel" title="整改跟踪信息" border="false">
		</div>--%>

		<div id="planName" title="问题信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>
	</div>
	<div region='center' border='0'>
		<table id='trackList'></table>
	</div>

	<div id="importProjects" style="padding: 0px;overflow:hidden;" title="导入整改跟踪信息">
		<s:form id="importForm" action="importTrackLedgerProblem" namespace="/proledger/problem" method="post" enctype="multipart/form-data" onsubmit="wait();">
			<s:hidden name="project_id"  value="${project_id}"/>
			<s:hidden name="view" value="${view}"/>
			<s:hidden name="wpd_stagecode"  value="${wpd_stagecode}"/>
			<s:hidden name="permission"  value="${permission}"/>
			<s:hidden name="supervisorcode"  value="${supervisorcode}"/>
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

	<script type="text/javascript">
		$(function(){
			if('${supervisorcode}' == 'view'){
				<c:forEach items="${projectStageList}" var="projstage">
				<c:forEach items="${projstage.wppdList}" var="wppd" >
					$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
						fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
						echoType:2,
						isDel:false,
						isEdit:false,
						uploadFace:1,
						triggerId:'shenjizuBtn'+'_${wppd.projdetailid}'
					});
				</c:forEach>
			</c:forEach>
			}else{
				<c:forEach items="${projectStageList}" var="projstage">
				<c:forEach items="${projstage.wppdList}" var="wppd" >
					$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
						fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
						echoType:2,
						isDel:true,
						isEdit:true,
						uploadFace:1,
						triggerId:'shenjizuBtn'+'_${wppd.projdetailid}'
					});
				</c:forEach>
			</c:forEach>
			}


		});
	
		$(function(){
			var bodyW = $('body').width();
			$('#trackList').datagrid({
				url : "<%=request.getContextPath()%>/proledger/problem/auditTrackingList.action?querySource=grid&project_id=${project_id}&permission=<%=request.getAttribute("permission")%>&supervisorcode=${supervisorcode}",
				method:'post',
				//showFooter:false,
				rownumbers:true,
				//pagination:true,
				//striped:true,
				//autoRowHeight:false,
				fit: true,
				pageSize: 20,
				pagination:true,
				title:'整改跟踪信息',
				//fitColumns:false,
				idField:'id',
				border:false,
				singleSelect:true,
				remoteSort: false,
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
				onLoadSuccess:function(){
					doCellTipShow('trackList');
				},
				columns:[[
					{field:'id', title: '主键',hidden:true, align:'center',title:'fixHidden'},
					{field:'serial_num',title:'问题编号',align:'center',width:bodyW*0.1+'px', sortable:true},
					{field:'problem_all_name',title:'问题类别',width:bodyW*0.1+'px',sortable:true, halign:'center',align:'left',
						formatter:function(value,row,index){
							var problemVa = value.split("-");
							value = problemVa[0];
							return value ? "<label title='"+value+"'>"+value+"</label>" : "";
						}
					},
					{field:'problem_name',title:'问题点',width:bodyW*0.15+'px', halign:'center',align:'left',sortable:true},
					{field:'problem_money',title:'涉及金额(万元)', halign:'center',width:bodyW*0.07+'px',align:'right',sortable:true,formatter:aud$gridFormatMoney},
					{field:'problemCount',title:'发生数量(个)',sortable:true, width:bodyW*0.07+'px',halign:'center',align:'right'},
					{field:'problem_grade_name',title:'审计发现类型', width:bodyW*0.07+'px', halign:'center',align:'left',sortable:true},
					{field:'examine_creater_name',title:'监督检查人', width:bodyW*0.07+'px', halign:'center',align:'left',sortable:true},
					{field:'mend_state',title:'整改状态', width:bodyW*0.1+'px', halign:'center',align:'left',sortable:true},
					{field:'f_mend_opinion_name',title:'整改状态评价', width:bodyW*0.1+'px', halign:'center',align:'left',sortable:true},
					{field:'operate',title:'整改跟踪',width:bodyW*0.09+'px',align:'center',
						formatter:function(value,rowData,rowIndex){
							return '<a href=\"javascript:void(0)\" onclick=\"trackInfo(\''+rowData.id+'\');\">跟踪信息</a>';
					}
					}
				]]
			});
			

			
			$('#importProjects').window({
				//title:'整改跟踪信息导入',
				width:1000,
				height:300,
				top:50,
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true,
				maximized:false
			});

			<s:if test="${operate1 == 'imp'}">
			  $('#importProjects').window('open');
			</s:if>
		});

		function trackInfo(id){
			//var row = $('#trackList').datagrid("getSelections");
			var project_id = '${project_id}';
			var permission = '${permission}';
			var interaction = '${interaction}';
			var idEdit = '${isEdit}';
			var loginname = '${user.floginname}';
			var supervisor_code = '${projectStartObject.supervisor_code}';
			var trackUrl = "";
		 //	if(loginname == supervisor_code){
				trackUrl = "${contextPath}/proledger/problem/editAudTrackingLedger.action?id="+id+"&project_id=${project_id}&permission=${permission}&interaction=${interaction}&wpd_stagecode=${wpd_stagecode}&supervisorcode=${supervisorcode}&view=${view}";
			/* }else{
				trackUrl ="${contextPath}/proledger/problem/editAudTrackingLedger.action?id="+id+"&project_id=${project_id}&isEdit=&permission=${permission}&interaction=${interaction}&wpd_stagecode=${wpd_stagecode}&view=view";
			}  */

			aud$openNewTab("跟踪信息评价", trackUrl, true);
			//window.location.href= trackUrl;
			/*$('#showPlanName').attr("src",trackUrl);
			$('#planName').window('open');*/
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
		 *表单提交校验
		 */
		function isCloseTaizhangJ(){//台账是否关闭
			var flag = false;
			var project_id = document.getElementsByName('crudObject.project_id')[0].value;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/archives/pigeonhole', action:'isCloseTaizhang', executeResult:'false' },
					{'project_id':project_id},
					xxx);
			function xxx(data){
				isClose = data['isClose'];
				if(isClose=='true'){
					flag = true;
				}
			}
			return flag;
		}
		/*
			提交表单
		*/
		function toSubmit(option){
			var isCloseTaizhang = isCloseTaizhangJ();
			var taizhang = '<s:property value="@ais.project.ProjectSysParamUtil@isXMTZEnabled()" />';
			if(taizhang && !isCloseTaizhang){//校验台账是否完成191127
				alert("台账未完成！");
				return false;
			}
			
			if(!confirm("提交后将不能补充归档资料，请确认整改相关附件资料均已上传?")){
				return false;
			}
			var tableId = 'projectStartTable';
			var formId = 'projectReworkForm';

			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			var flowForm = document.getElementById(formId);
			if(frmCheck(flowForm,tableId)==false){
				return false;
			}else{
				<s:if test="isUseBpm=='true'">
					if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
						var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
						if(actor_name==null||actor_name==''){
							window.alert('下一步处理人不能为空！');
							return false;
						}
					}
				</s:if>
				if(confirm('确认提交吗?')){
					document.getElementById('submitButton').disabled=true;
					<s:if test="isUseBpm=='true'">
						flowForm.action="<s:url action="submit" includeParams="none"/>";
					</s:if>
					<s:else>
						flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
					</s:else>
					flowForm.submit();
				}else{
					return false;
				}
			}
		}
		/*
			保存表单
		*/
		function toSave(formId,tableId){
			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			var flowForm = document.getElementById(formId);
			document.getElementById('saveButton').disabled=true;
			if(frmCheck(flowForm,tableId)==false){
				document.getElementById('saveButton').disabled=false;
				return false;
			}else{	
				flowForm.action="${contextPath}/project/rework/save.action";
				flowForm.submit();
			}
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

	 	function load() {
			$('#download').linkbutton('disable');
			var project_id = "${project_id}"
			window.location.href = "${contextPath}/templatedownload?file=track_ledger_template.xls&&permission=${permission}&&type=trackLedger&&formType=1&&project_id="+project_id;
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
		//	$('#importProjects').window('close');		
			document.getElementById("importButton").disabled = true;
			document.getElementById("layer").style.display = "";
			document.getElementById("errorInfo1").style.display = "none";
			document.getElementById("errorInfo2").style.display = "none";		
	 	}

	 	function refresh(){
			$('#trackList').datagrid('reload');
		}
	</script>
</body>
</html>