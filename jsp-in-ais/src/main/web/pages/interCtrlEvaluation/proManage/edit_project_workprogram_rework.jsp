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
<body style="overflow:hidden;" class="easyui-layout" fit="true" >
<div id='btnBar' style='position:absolute;top:0px;right:1px;z-index:9010;'>
	<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="submitFeedback()">提交</a>
	<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a>
</div>
<div region="center"  style="padding:0px; overflow:hidden;" border="0" title="补充性审计文书" split="true" >
		<s:form id="workprogramDetailForm" action="saveWorkprogramDetail" namespace="/workprogram">
		    <s:hidden name="project_id" value="${project_id}"/>
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
		                            	<div id="fileList_${wppd.projdetailid}"></div>  
		                        </td>
		                        <td class="editTd" style="text-align: center;">
			                        <c:if test="${view != 'view' }">
			                        	<div id="uploadBtn_${wppd.projdetailid}"></div>
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
		                            <td class="editTd" style="text-align: left;">${wppd.workprogramdetailname}</td>
		                            <td class="editTd" style="text-align: center;">${wppd.needdo}</td>
		                            <td class="editTd" style="text-align: left;">${wppd.templateFileUrl}</td>
		                            <td class="editTd" style="text-align: left;">
			                        	<div id="fileList_${wppd.projdetailid}"></div>  
			                        </td>
		                            <td class="editTd" style="text-align: center;">
		                            	<c:if test="${view != 'view' }">
			                            	<div id="uploadBtn_${wppd.projdetailid}"></div>
		    							</c:if>
		                            </td>
		                         </tr>                    
		                        </c:forEach>
		                    </c:if>
		                </c:if>
		        </c:forEach>
		    </table>
		</s:form>

</div>
<div  region="south" style="height:200px;overflow:hidden;"   title="整改跟踪信息" border="0" >
	<table id='trackList' ></table>
</div>
<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
   	<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
</div>
	<script type="text/javascript">
		$(function(){	
			if('${uploadIdStrs}'!=null && '${uploadIdStrs}'!='' && '${uploadIdStrs}'!='null'){
				var temp = '${uploadIdStrs}'.split(",");
				var projectid='${project_id}';
				if(temp!=null && temp.length>0){
					for(var i=0;i<temp.length;i++){
						if(temp[i]!='' && temp[i]!=null){
							var tempStr = temp[i].split("|");
							var projdetailid = tempStr[0];
							var uploadfileid = tempStr[1]=='' ? tempStr[0]:tempStr[1];
							var fileListDiv = "fileList_"+projdetailid;
							var uploadBtnDiv = "uploadBtn_"+projdetailid;
							//初始化上传文件空间列表和上传按钮
							$('#'+fileListDiv).fileUpload({
								fileGuid:uploadfileid,
								echoType:2,
								<s:if test="${view}=='view'">
									isDel:false,
									isEdit:false,							
								</s:if>
								uploadFace:1,
								triggerId:uploadBtnDiv,
								onFileSubmitSuccess:function(data,options){
									/* for(var p in data) alert(p+"="+data[p])
									return false; */
									jQuery.ajax({
										url:'${contextPath}/workprogram/saveUploadFileIdToWorkProgramProjectDetail.action',
										type:'POST',
										data:{"projectid":projectid,"wppd_id":data.fileId},
										dataType:'json',
										async:'false'
									});
								},
								onDeleteFile:function(fileIdList){
									//for(var p in fileIdList) alert(p+"="+fileIdList[p])
									jQuery.ajax({
										url:'${contextPath}/workprogram/delUploadFileIdToWorkProgramProjectDetail.action',
										type:'POST',
										data:{"projectid":projectid,"wppd_id":fileIdList[0]},
										dataType:'json',
										async:false
									});
									//return true;
								}
							});	 										
						}
					}
				}
			}
			
			
			$('#trackList').datagrid({
				url : "/ais/intctet/proManage/auditTrackingListForAuditObject.action?project_id=${project_id}&querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 10,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[
					{field:'id',width:'50', hidden:true, align:'center'},
					{field:'defectCode',title:'内控缺陷编号',align:'center',width:'120px', sortable:true},
					{field:'defectName',title:'内控缺陷名称',width:'120px',sortable:true, halign:'center',align:'center'},
					{field:'manuscriptIndex',title:'底稿索引',width:'180px', halign:'center',align:'center',sortable:true},
					{field:'controlName',title:'所属控制点', halign:'center',width:'100px',align:'center',sortable:true},
					{field:'circuitName',title:'所属主流程', halign:'center',width:'100px',align:'center',sortable:true},
					{field:'defectTypeName',title:'缺陷类型', halign:'center',width:'7%',align:'center',sortable:true},
					{field:'relateLoss',title:'涉及到损失/错报的金额',sortable:true, width:'200px',halign:'center',align:'right'},
					{field:'defineResult',title:'认定结果', width:'10%', halign:'center',align:'center',sortable:true},
					{field:'mendAdvice',title:'整改建议', width:'8%', halign:'center',align:'center',sortable:true},
					{field:'mendDeadline',title:'整改期限', width:'8%', halign:'center',align:'center',sortable:true},
					{field:'mendMeasure',title:'整改措施', width:'15%', halign:'center',align:'center',sortable:true},
					{field:'mendProgress',title:'整改进度', width:'8%', halign:'center',align:'center',sortable:true},
					{field:'lastFeedbackTime',title:'最近反馈时间', width:'100px', halign:'center',align:'left',sortable:true},
					{field:'operate',title:'操作',width:'200px',align:'center',
						formatter:function(value,rowData,rowIndex){
							if(rowData.planStartTime == '' || rowData.planStartTime == null)
								return '<a href=\"javascript:void(0)\" onclick=\"mendWrite(\''+rowData.id+'\');\">录入整改措施</a>';
							else
								return '<a href=\"javascript:void(0)\" onclick=\"mendWrite(\''+rowData.id+'\');\">录入整改措施</a>|<a href=\"javascript:void(0)\" onclick=\"trackInfo(\''+rowData.id+'\');\">录入整改结果</a>';
						}	
					}
				]]   
			}); 
		});
			
		function trackInfo(id){
			var trackUrl = "";
			trackUrl = "${contextPath}/intctet/proManage/feedbackListForAuditObject.action?inter_ctrl_problem_id="+id+"&project_id=${project_id}";
			window.location.href= trackUrl; 
		}
		
		function mendWrite(id){
			var trackUrl = "";
			trackUrl = "${contextPath}/intctet/proManage/editMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=true&permission=full";
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
			
			window.location.href = "${contextPath}/intctet/proManage/listAllForAuditObject.action"; 
		}
		
		//提交
		function submitFeedback(){
		    
			$.ajax({
				url : "${contextPath}/intctet/proManage/submitFeedback.action?project_id=${project_id}",
				type: "POST",
				success: function(data){
					if(data == '1') {
						$.messager.show({
							title:"消息",
							msg:"提交成功！",
						});
					}else if(data == '0') {
						$.messager.show({
							title:"消息",
							msg:"提交失败！",
						});
					}
				},
				error:function(data){
					$.messager.show({
						title:"消息",
						msg:"提交失败！",
					});
				}
			});
		}

	</script>
</body>
</html>