<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<!DOCTYPE HTML>
<html>
<head>
<title>整改信息设定</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
</head>
<script type="text/javascript">
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
<%--<body style="overflow: auto;" fit="true">--%>
<body class='easyui-layout' style="overflow: hidden">
	<!--  -->
	<div region='north' class="easyui-layout" style="padding:0px; overflow:auto; height: 240px" border="false">
		<!--补充性审计文书 start  -->
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
			                        <td class="editTd" style="text-align: left;">
										<div id="shenjizuFiles_${wppd.projdetailid}"></div>
									</td>
									<td class="editTd" style="text-align: center;">
										<c:if test="${supervisorcode != 'view'}"> 
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
				                            	<a id="btn" href="javascript:void(0);" onclick="editwppd('${wppd.projdetailid}','${wppd.uploadfileid}','${state.index}')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
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
		<!-- 补充性审计文书 end -->	
		<br/>
	</div>
	<div region='center' border='0'>
		<table id="gridList" ></table>
		<form id="psoInfo" name="psoInfo" style='display:none;'>
			<input type="hidden" name="projectStartObject.audit_object_name" value="${projectStartObject.audit_object_name}"/>
			<input type="hidden" name="projectStartObject.zeren_dept" value="${projectStartObject.zeren_dept}"/>
			<input type="hidden" name="projectStartObject.zeren_person" value="${projectStartObject.zeren_person}"/>
			<input type="hidden" name="projectStartObject.telephone" value="${projectStartObject.telephone}"/>
			<input type="hidden" name="projectStartObject.supervisor_code" 
				id="supervisor_code" value="${projectStartObject.supervisor_code}"/>
			<input type="hidden" name="projectStartObject.supervisor_name" 
				id="supervisor_name" value="${projectStartObject.supervisor_name}"/>
			<s:hidden name="project_id" />
			<s:hidden name="isEdit" />
		</form>
	</div>

	<div id="examineId">
		<s:form method="post" id="examineForm">
			<table class="ListTable" align="center">
				<tr  class="listtablehead">
					<td class="EditHead" style="width: 15%">整改期限开始</td>
					<td class="editTd" style="width:35%">
						<input type="text" class="easyui-datebox" name="mend_term"  id="mend_term" editable="false"/>
					</td>
					<td class="EditHead" style="width: 15%">整改期限结束</td>
					<td class="editTd" tyle="width:35%">
						<input type="text" name="mend_term_enddate" class="easyui-datebox" id ="mend_term_enddate" editable="false"/>
					</td>
				</tr>
				<tr  class="listtablehead">
					<td class="EditHead">监督检查人</td>
					<td class="editTd">
						<select class="easyui-combobox" name="examine_creater_code" id="examine_creater_code" data-options="editable:false,panalHeight:'auto'" >
							<s:iterator value="examineCreaterMap">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead"></td>
					<td class="editTd"></td>
				</tr>
			</table>
		</s:form>

	</div>
	  <!--
	<div style="overflow:auto" region="center" fit="true" data-options="href:'${contextPath}/proledger/problem/overallMendLedger.action?project_id=${project_id}&isEdit=${isEdit}&isfrom=taizhang&view=${view}&interaction=${interaction}'">
	</div>
	-->
	<!--   
	<div id='ss' title='审计决定问题' >
	   <iframe id="reworkWorkProgram"  src="${contextPath}/proledger/problem/mendLedgerListNew.action?project_id=${project_id}&isEdit=${isEdit}&permission=${permission}&view=${view}&interaction=${interaction}"
	        frameborder="0" width="100%" height="98%;" scrolling="auto"></iframe>					
	</div> 
	-->

</body>
<script type="text/javascript">
//初始化加载表格
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
				triggerId:'shenjizuBtn_${wppd.projdetailid}'
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
				triggerId:'shenjizuBtn_${wppd.projdetailid}'
			});
		</c:forEach>
	</c:forEach>
	}
	
	
	
	
	
	//alert("${projectStartObject.submitStage}")
	var isView = "${isEdit}" == true || "${isEdit}" == "true" ? false : true;
	if("${projectStartObject.submitStage}" == '2'){
		isView = true;
	}
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "gridList";
	
	var editIndex = undefined;
    // 结束上次编辑的行
	function endEditing(){
		if(editIndex == undefined){
			return true;
		}
		if($('#'+gridTableId).datagrid('validateRow', editIndex)){//判断行是否校验成功，成功后结束编辑
			$('#'+gridTableId).datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		}else{
			return false;
		}
	}
    
    //编辑and选中行
    function editAndSelect(index, field){
    	try{
    		if(!(field == "examine_creater_name" || field == "mend_term" || field == "mend_term_enddate")){
    			field = "examine_creater_name";
    		}
			$('#'+gridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);	       				
			var ed = $('#'+gridTableId).datagrid('getEditor', {index:index,field:field});
			if(ed){
				$(ed.target).select()[0].focus();
			}	       				
			//记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
			editIndex = index; 
    	}catch(e){
    		alert('editAndSelect:\n'+e.message);
    	}
    }   
	var examineBtn = {
		id:'examine',
		text:'整改设定',
		iconCls:'icon-edit',
		handler:function(){
			examineFun();
		}
	};
	var saveBtn = {   
	    text:'保存',
	    iconCls:'icon-save',
	    handler:function(){
	    	saveRows(false, false);
	    }
	};
	var postBtn = {   
	    text:'提交',
	    iconCls:'icon-ok',
	    handler:function(){
	    	saveRows(true, true);
	    }
	};
	var  proyear = "${projectStartObject.pro_year}";
    // 保存问题,保存修改、新增的行
    function saveRows(noMsg, isPost){
		endEditing();
    	var insertRows = $('#'+gridTableId).datagrid('getChanges','inserted');
    	var updateRows = $('#'+gridTableId).datagrid('getChanges','updated');
    	//alert("updateRows="+updateRows.length)
		var rows = $('#'+gridTableId).datagrid('getRows');
		if(rows && rows.length){
			$('#'+gridTableId).datagrid('acceptChanges');
			var rt = true;
			for(var j = 0; j < rows.length; j++){
				var row = rows[j];
				if(j == 0 && !$('#supervisor_code').val()){
					$('#supervisor_code').val(row['examine_creater_code']);
					$('#supervisor_name').val(row['examine_creater_name']);
				}
				var rowsIndex = $('#'+gridTableId).datagrid('getRowIndex', row);
				editAndSelect(rowsIndex);
				var startDate = row['mend_term'];
				var endDate = row['mend_term_enddate'];
				//var mend_method = row['mend_method'];
				//var examine_method = row['examine_method'];
				//var zeren_person = row['zeren_person'];
				//if (!startDate || !endDate || !mend_method || !examine_method || !zeren_person){
				if (!startDate || !endDate){
					noMsg ? "" : showMessage1("第【"+parseInt(rowsIndex + 1)+"】行，有必输项没有输入");
					rt = false;
					break;
				}
				//alert(startDate+"\n"+endDate)
				if(startDate && endDate){
					var startDate2 = parseInt(startDate.replace(/(\s*)/g, "").replace(/-|:/g,""));
					var endDate2 = parseInt(endDate.replace(/(\s*)/g, "").replace(/-|:/g,""));
					if(endDate2 < startDate2){
						var ed = $('#'+gridTableId).datagrid('getEditor', {
							index:rowsIndex,
							field:"mend_term_enddate"
						});
						if(ed){
							$(ed.target).select().focus();
						}
						noMsg ? "" : showMessage1("第【"+parseInt(rowsIndex + 1)+"】行，整改期限结束【"+endDate+"】 应大于 整改期限开始【"+startDate+"】");
						rt = false;
						break;
					}
				}
				
				if(proyear!=null || proyear !="" || proyear !=undefined){
	            	var start= new Array(); 
	            	start=startDate.split("-");
	            	var end= new Array(); 
	            	end=endDate.split("-");
	            	if(start[0] !=null && start[0]!=''){
	            		if(start[0] < proyear){ 
	            			showMessage1("整改期限开始必须大于项目所属年度["+proyear+"]！"); 
	            			rt = false;
							break;
	            		}
	            		
	            		if(end[0] < proyear){
	            			showMessage1("整改期限结束必须大于项目所属年度["+proyear+"]！");
	            			rt = false;
							break;
	            		}
	            	}
				}
				
				if($('#'+gridTableId).datagrid('validateRow', rowsIndex)){								
					$('#'+gridTableId).datagrid('endEdit', rowsIndex);
				}else{
					rt = false;
					var ed = $('#'+gridTableId).datagrid('getEditor', {
						index:rowsIndex,
						field:"examine_creater_code"
					});
					if(ed){
						$(ed.target).select().focus();
					}
					noMsg ? "" : showMessage1("第【"+parseInt(rowsIndex + 1)+"】行数据校验未通过");
					break;
				}
			}
			//alert("rt="+rt+"\nupdateRows="+updateRows.length)
			if(!rt){
				return false;
			}
			if(rt && updateRows.length){
				var rcUrl = "${contextPath}/proledger/problem/saveRectificConfigInfo.action";
		    	var sendData = null;
		    	//var insertRowsJson = insertRows.length ? aud$rows2Json("insertRow", insertRows) : {};
		    	//var updateRowsJson = updateRows.length ? aud$rows2Json("updateRow", updateRows) : {};
		    	//sendData = $.extend({}, insertRowsJson, updateRowsJson);
				sendData = aud$rows2Json("updateRow", rows);
				$.ajax({
					url : rcUrl,
					dataType:'json',
					type: "post",
					data: sendData,
					async:false,
					beforeSend:function(){
						var check = sendData != null ? true : false;
						check ? aud$loadOpen() : null;
						return check;
					},
					success: function(data){
						aud$loadClose();
						data && data.msg && !noMsg ? showMessage1(data.msg) : null;
		       			if(data && data.type == 'info'){
		       				$('#'+gridTableId).datagrid('acceptChanges');
		       				if(isPost){
		       					submitSetReworkProblem();
		       				}else{		       					
		       					busGridObj.refresh();
		       				}
		       			}
					},
					error:function(data){
						aud$loadClose();
						top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
					}
				});
			}else{
				noMsg ? "" : (rt ? showMessage1("数据没有修改，不需保存") : "");
				if(isPost){
					submitSetReworkProblem();
				}
			}
		}else{
			noMsg ? "" : showMessage1("数据没有修改，不需保存");
			
			if(isPost){
				submitSetReworkProblem();
			}
		}
    }
    
    
	//整改信息设定提交
	function submitSetReworkProblem(){
		var formData=$("#psoInfo").serialize();
		$.ajax({
			url : "${contextPath}/proledger/problem/submitSetReworkProblem.action",
			data: formData,
			type: "POST",
			async:false,
			success: function(tip){
				//alert('after post, tip='+tip)
				if(tip=='1'){
					top.$.messager.show({
						title:"消息",
						msg:"请完成全部问题设定！",
					});
					return false;
				}else if(tip=='-1'){
					top.$.messager.show({
						title:"消息",
						msg:"请在【被审计单位维护】中完善项目被审计单位反馈账号信息！",
					});
					return false;
				}else{
					top.$.messager.show({
						title:"消息",
						msg:"提交成功！",
					});
					setTimeout(function(){						
						window.location.href='${contextPath}/proledger/problem/mendLedgerList.action?view=view&project_id=${project_id}&wpd_stagecode=report&isEdit=false&permission=full';
					}, 100);
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
	
	var barView = ['export','-','reload'];
	var barEdit = [examineBtn,'-',saveBtn,'-',postBtn,'-','export','-','reload'];
	var cusToolbar = isView ? barView : barEdit;
	
	var userIds = "${userIds}";
	var userNames = "${userNames}";
    var userArr = [];
    if(userIds && userNames){
    	var userIdArr = $.trim(userIds).split(",");
    	var userNamesArr = $.trim(userNames).split(",");
    	$.each(userIdArr, function(i, userId){
    		//alert(userId +" "+ userNames[i])
    		userArr.push({
    	    	'code':userId,
    	    	'name':userNamesArr[i]
    		});
    	});
    }
	
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MiddleLedgerProblem',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        order :'asc',
        sort  :'serial_num',
		winWidth:800,
	    winHeight:300,
	    gqueryParams:{
	    	'query_eq_project_id':'${project_id}',
	    	'query_eq_tableType':'1'
	    	
	    },
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],    
	    //associate:true,
	    //删除前执行（提示前）
	    beforeRemoveRowsFn:function(rows, gridObject){ 
	    	//$('#'+gridTableId).datagrid('acceptChanges');
	    	return true;
	    },
		// 删除后不刷新表格，防止行编辑选择的删除行包含新增行时，如果刷新grid会把新增行给刷掉
		delRefresh:false,
        gridJson:{
			rownumbers:true,
		    pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		//自定义工具栏按钮
    		toolbar:cusToolbar,
        	onClickCell:function(index, field, value){
        		if(isView){
        			return;
        		}
       			endEditing() ? editAndSelect(index, field) : $('#'+gridTableId).datagrid('selectRow', editIndex);
    		},
    		frozenColumns:[[
				<s:if test="${isEdit=='true' || projectStartObject.submitStage!='2'}">
				{field:'id',width:'50', checkbox:true, align:'center'},
				</s:if>
    			{field:'serial_num',title:'问题编号',width:'130px',align:'center', sortable:true,
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				}
    			},
    			{field:'audit_con',title:'问题标题',width:'200px',align:'left', sortable:true,
    				formatter:function(value,row,index){
    					// return value ? "<label title='"+value+"'>"+value+"</label>" : "";
						return '<a href=\"javascript:void(0)\" onclick=\"toOpenProblemWindow(\''+row.manuscript_id+'\',\''+row.id+'\',\''+row.project_id+'\');\">'+row.audit_con+'</a>';
    				}
    			}
    		]],
    		columns:[[
				{
					field: 'problem_all_name', title: '问题类别', width: '180px', sortable: true, halign: 'center', align: 'left',
					formatter: function (value, row, index) {
						if (value != null && value != '' && value.indexOf("-") != -1){
							var problemVa = value.split("-");
							value = problemVa[0];
						}
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					}
				},
				{
					field: 'problem_name', title: '问题点', width: '180px', sortable: true, halign: 'center', align: 'left',
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					}
				},
				{
					field: 'zeren_company', title: '整改责任单位', halign: 'center', align: 'right', width: '150px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					}
				},
				{
					field: 'problem_money', title: '涉及金额（万元）', halign: 'center', width: '150px', align: 'right', sortable: true, exportType:"AMOUNT",
						formatter:aud$gridFormatMoney
				},
				{
					field: 'problemCount', title: '发生数量（个）', halign: 'center', align: 'right', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : 0;
					}
				},
				{
					field: 'examine_creater_code', title: '监督检查人', halign: 'center', align: 'right', width: '130px', sortable: true,
					formatter: function (value, row, index) {
						var vtext = "";
						$.each(userArr, function (i, jdata) {
							if (jdata['code'] == value) {
								vtext = jdata['name'];
								return false;
							}
						});
						if (vtext) {
							// 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
							var rtVal = vtext ? vtext : value;
							row['examine_creater_name'] = rtVal;
							return rtVal;
						} else {
							row['examine_creater_code'] = row['creater_code'];
							row['examine_creater_name'] = row['creater_name'];
							return row['examine_creater_name'];
						}
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {
						type: 'combobox', options: {
							required: true,
							editable: false,
							panelHeight: 'auto',
							valueField: 'code',
							textField: 'name',
							data: userArr
						}
					}
				},
				{
					field: 'mend_term', title: '整改期限开始', halign: 'center', align: 'center', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						if (value) {
							var t = value.indexOf("T");
							if (t != -1) {
								value = value.substr(0, t);
							}
						}
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'datebox', options: {required: true}}
				},
				{
					field: 'mend_term_enddate', title: '整改期限结束', halign: 'center', align: 'center', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						if (value) {
							var t = value.indexOf("T");
							if (t != -1) {
								value = value.substr(0, t);
							}
						}
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'datebox', options: {required: true}}
				}
/*				,
				{
					field: 'mend_method', title: '整改方式', halign: 'center', align: 'right', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'validatebox', options: {required: true}}
				},
				{
					field: 'examine_method', title: '检查方式', halign: 'center', align: 'right', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'validatebox', options: {required: true}}
				},
				{
					field: 'zeren_person', title: '责任人', halign: 'center', align: 'right', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'validatebox', options: {required: true}}
				},
				{
					field: 'zeren_company', title: '整改责任单位', halign: 'center', align: 'right', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'textbox'}
				},
				{
					field: 'zeren_dept', title: '责任部门', halign: 'center', align: 'right', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'textbox'}
				},
				{
					field: 'telephone', title: '联系电话', halign: 'center', align: 'right', width: '100px', sortable: true,
					formatter: function (value, row, index) {
						return value ? "<label title='" + value + "'>" + value + "</label>" : "";
					},
					styler: function (value, row, index) {
						return isView ? "" : 'background-color:#FFFACD;';
					},
					editor: {type: 'textbox'}
				}*/
			]]
        }
    });

	$("#examineId").dialog({
		title:'整改要求设定',
		width:900,
		height:300,
		closed:true,
		resizable:true,
		cache:  false,
		shadow: false,
		minimizable:true,
		maximizable:true,
		modal:true,
		//iconCls:'icon-edit',
		onOpen:function(){
			clearExamine();
		},
		buttons:[{
			text:'保存',
			iconCls:'icon-save',
			handler:function(){
				saveExamine();
			}
		},{
			text:'清空',
			iconCls:'icon-empty',
			handler:function(){
				clearExamine();
			}
		},{
			text:'关闭',
			iconCls:'icon-cancel',
			handler:function(){
				clearExamine();
				$("#examineId").dialog("close");
			}
		}

		]

	})
});

function examineFun(){
	var rows = $('#gridList').datagrid('getChecked');
	if ( rows.length < 1){
		showMessage1("请选择一条记录!");
		return false;
	}else{
		$("#examineId").window("open");
		//clearExamine();
		var rows = $('#gridList').datagrid('getChecked');
		var mend_term = rows[0].mend_term;
		var s = mend_term&& mend_term.length > 10 ? mend_term.substring(0,10) :mend_term;

		var mend_term_enddate = rows[0].mend_term_enddate;
		var e = mend_term_enddate&& mend_term_enddate.length > 10 ? mend_term_enddate.substring(0,10) :mend_term_enddate;

		var examine_creater_code = rows[0].examine_creater_code;
		if ( rows.length == 1 ){
			if ( rows[0].mend_term != null ){
				$("#mend_term").datebox('setValue',s);
			}else{
				$("#mend_term").datebox('setValue','');
			}
			if ( rows[0].mend_term_enddate != null ){
				$("#mend_term_enddate").datebox('setValue',e);
			}else{
				$("#mend_term_enddate").datebox('setValue','');
			}
			if ( rows[0].examine_creater_code != null ){
				$("#examine_creater_code").combobox("setValue",rows[0].examine_creater_code);
				$("#examine_creater_code").combobox("setText",rows[0].examine_creater_name)
			}

		}else {
			var startFlag = true;
			var endFlag = true;
			var examineflag = true;
			for ( var i=1;i< rows.length;i++){
				if (rows[i].mend_term != mend_term ){
					startFlag = false;
				}
				if (rows[i].mend_term_enddate != mend_term_enddate ){
					endFlag = false;
				}
				if (rows[i].examine_creater_code != examine_creater_code ){
					examineflag = false;
				}
			}

			if (startFlag && s){
				$("#mend_term").datebox('setValue',s);
			}else{
				$("#mend_term").datebox('setValue','');
			}
			if (endFlag && e){
				$("#mend_term_enddate").datebox('setValue',e);
			}else{
				$("#mend_term_enddate").datebox('setValue','');
			}
			if (examineflag && rows[0].examine_creater_code){
				$("#examine_creater_code").combobox("setValue",rows[0].examine_creater_code);
				$("#examine_creater_code").combobox("setText",rows[0].examine_creater_name)
			}


		}


	}
}


function saveExamine(){
	var rows = $('#gridList').datagrid('getChecked');
	if ( rows.length < 1){
		showMessage1("请选择一条记录!");
		return false;
	}
	var ids = "";
	for(var i=0;i<rows.length;i++){
		ids+=rows[i].id+",";
	}
	var mend_term = $('#mend_term').datebox('getValue');
	if ( mend_term == null || mend_term == ""){
		//showMessage1("整改期限开始不能为空!");
		//return false;
	}
	var mend_term_enddate = $('#mend_term_enddate').datebox('getValue');
	if ( mend_term_enddate == null || mend_term_enddate == ""){
		//showMessage1("整改期限结束不能为空!");
		//return false;
	}
	if (!validateDate("mend_term","mend_term_enddate")){
		return false;
	}
	if (!validateDateYear(mend_term,mend_term_enddate,'${psObject.pro_year}')){
		return false;
	}

	var examine_creater_code = $('#examine_creater_code').combobox('getValue');
	if ( examine_creater_code == null || examine_creater_code == ""){
		//showMessage1("监督检查人 不能为空!");
		//return false;
	}
	if ((mend_term == null || mend_term == "") && (mend_term_enddate == null || mend_term_enddate == "") && (examine_creater_code == null || examine_creater_code == "")){
		showMessage1("设定项的值不能全部为空！");
		return false;
	}
	var examine_creater_name = $('#examine_creater_code').combobox('getText');
	$.ajax({
		url:'${contextPath}/proledger/problem/saveRectificConfigInfoDecide.action',
		type:'post',
		async:false,
		data:{'ids':ids,'mend_term':mend_term,'mend_term_enddate':mend_term_enddate,'examine_creater_code':examine_creater_code,'examine_creater_name':examine_creater_name,'exceptEmpty':'1'},
		success:function(data){
			if( data == "1"){
				showMessage1("保存成功!");
				//clearExamine();
				$("#examineId").dialog("close");
				$("#gridList").datagrid("reload");
			}
		}

	})
}

/* 清空 */
function clearExamine(){
	//resetForm("examineForm");
	$("#mend_term").datebox('setValue','');
	$("#mend_term_enddate").datebox('setValue','');
	$("#examine_creater_code").combobox("setValue",'');
	$("#examine_creater_code").combobox("setText",'')
}
/*
    校验两个日期大小顺序
*/
function validateDate(beginDateId,endDateId){
	var s1 = $('#'+beginDateId);
	var e1 = $('#'+endDateId);
	if(s1 && e1){
		var s = s1.datebox('getValue');
		var e = e1.datebox('getValue');
		if(s!='' && e!=''){
			var s_date=new Date(s.replace("-","/"));
			var e_date=new Date(e.replace("-","/"));
			if(s_date.getTime()>e_date.getTime()){
				$.messager.alert("错误","整改期限开始必须小于等于结束!");
				return false;
			}
		}
	}
	return true;
}
/*
    校验两个日期和项目年度比较
   */
function validateDateYear(startDate,endDate,year){
	var start= new Array();
	start=startDate.split("-");
	var end= new Array();
	end=endDate.split("-");
	if(start[0] !=null && start[0]!=''){
		if(start[0] < year){
			showMessage1("整改期限开始必须大于项目所属年度["+year+"]！");
			return false;
		}

	}
	if ( end[0] !=null && end[0]!='' ){
		if(end[0] < year){
			showMessage1("整改期限结束必须大于项目所属年度["+year+"]！");
			return false;
		}
	}
	return true;
}
// 查看问题
function toOpenProblemWindow(manuscript_id, problemId, projectId){
	//var viewSjwtUrl  = "${contextPath}/proledger/problem/view.action?manuscript_id=" + manuscript_id + "&isView=true&id=" + problemId + "&interaction=${interaction}&project_id=" + projectId;
	var viewSjwtUrl  = "${contextPath}/proledger/problem/viewMiddle.action?id=" + problemId + "&interaction=${interaction}&project_id=" + projectId;
	aud$openNewTab('查看问题',viewSjwtUrl,true);
}
</script>
</html>