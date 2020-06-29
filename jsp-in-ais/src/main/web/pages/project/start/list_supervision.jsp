<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<jsp:directive.page import="ais.framework.util.UUID"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
	<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/util.js'></script>
	</head>
	<body>
	<s:form action="listSupervision" namespace="/project" method="post">
	<table id="supervisionTable" cellpadding=0 cellspacing=1 border=0
                bgcolor="#409cce" class="ListTable" align="center">
				<tr>
					<td align="left" class="ListTableTrSupervisionT" nowrap>
						选择
					</td>
					<td align="left" class="ListTableTrSupervisionT" nowrap>
						底稿名称
					</td>
					<td align="left" class="ListTableTrSupervisionT" nowrap>
						操作
					</td>
				</tr>
		<s:iterator value="supervisionList" id="row">
				<tr>
					<td align="left" class="ListTableTrSupervisionF">
						<input type="checkbox" value="${row.vision_id}" name="supervision_ids">
					</td>
					<td align="left" class="ListTableTrSupervisionF">
						<s:if test="${row.oprName!=null}">
							<a id="_a${row.common_file_id}" href="${contextPath}/commons/file/downloadFile.action?fileId=${row.common_file_id}" target='_blank'><s:property value="oprName"/></a>
							&nbsp;&nbsp;
							<s:if test="${type!='view'}">
							
								<a href='javascript:void(0);' id="_e${row.common_file_id}"  onclick="editDoc('${row.project_id}','${row.common_file_id}')">[编辑]</a>
							</s:if>
						</s:if>
					</td>
					<td align="left" class="ListTableTrSupervisionF">
						<s:if test="${type!='view'}">
						<input type="button" value="添加" onclick="uploadSupervision('${row.vision_id}','${row.uploadId }','${row.common_file_id}','')"/>
						</s:if>
					</td>
				</tr>
		</s:iterator>
			<s:if test="${type!='view'}">
				<tr>
					<td align="right" class="listtabletr22" colspan="6">
						<input type="button" value="新增督导底稿" onclick="javascript:window.location='${contextPath}/project/editSupervision.action?project_id=${project_id}'"/>
						<input type="button" value="删除底稿" onclick="delSupervison(this)"/>
					</td>
				</tr>	
			</s:if>	
				
		<s:hidden name="projectid" value="${project_id}"/>
	</table>
	</s:form>
	</body>
	<script type="text/javascript">
		//wppdid 对应vision_id  ,wppdupid  对应  uploadid  ,file_id 对应common_file_id
		function uploadSupervision(wppdid,wppdupid,file_id,index){
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
		    window.open('${contextPath}/commons/file/welcome4wpSupervision.action?guid='+guid+'&param='+rnm+'&deletePermission=true&wppid='+wppdid+'&rowIndex='+trObject.rowIndex+'&project_id=${project_id}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

		}
		function editUploadFileUrl(rowIndex,filename,fileid,projectid,uploadfileid){
			var trObject = document.getElementById("supervisionTable").rows(rowIndex/1);
			var fileurl="";
		    for(var i=0;i<filename.length-1;i++){
			    if(filename[i]!=''){
				     fileurl+= "<a id='_a" + fileid[i] + "' href='${contextPath}/commons/file/downloadFile.action?fileId="+fileid[i]+"' target='_blank'>"+filename[i]+"</a>" +
								"<a href='javascript:void(0);' id='_e" + fileid[i] + "' onclick=\"editDoc('" + projectid + "','" + fileid[i] + "')\">[编辑]</a>" +
								"<a href='javascript:void(0);' id='_d" + fileid[i] + "' onclick=\"deleteUploadFile('" + uploadfileid + "','" + fileid[i] + "')\">[删除]</a>" +
								"<br/>";
			    }
		    }
		    if(rowIndex==1){
			   trObject.cells(4).innerHTML=fileurl;
		    }else{
		    	trObject.cells(4).innerHTML=fileurl;
		    }    
		}
		function editDoc(guid, docId) {
		var editLink = document.getElementById("_e" + docId);
		editLink.value = "编辑中...";
		editLink.disabled = "disabled";
		
		var a = document.getElementById("_a" + docId);
		a.disabled = "disabled";
		var d = document.getElementById("_d" + docId);
		d.disabled = "disabled";
		var h = window.screen.availHeight;
		var w = window.screen.width;
		window.showModalDialog(
				"${contextPath}/workprogram/editdoc.action?projectId=" + guid +
						"&docId=" + docId +
					"&parentURL=" + escape("${contextPath}/project/start/listSupervision.action?<%=request.getQueryString()%>"),
					window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:yes');
		}

		var tagAId;
		var tagInputId;
		var editLinkId;
		function deleteUploadFile(guid, fileId) {
			tagAId = "_a" + fileId;
			tagInputId = "_d" + fileId;
			editLinkId = "_e" + fileId;
			
			var delBtn = document.getElementById(tagInputId);
			delBtn.value = "删除中...";
			delBtn.disabled = "disabled";
			
			var a = document.getElementById(tagAId);
			a.disabled = "disabled";
			var e = document.getElementById(editLinkId);
			e.disabled = "disabled";
			
			
			DWREngine.setAsync(true);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{"namespace":"/project", "action": "delSupervisionCommonFile", "executeResult": "false"},
					{"fileId" : fileId, "wppd_uploadfileid" : guid,"project_id":'${project_id}'},
					xxx
				);
			function xxx(data) {
					retmessage=data['ret_message'];
			 		if(retmessage="ok"){
		                DWREngine.setAsync(true);
						DWREngine.setAsync(false);DWRActionUtil.execute(
							{"namespace":"/commons/file", "action": "delFile", "executeResult": "false"},
							{"fileId" : fileId, "wppd_uploadfileid" : guid},
							delCallBack
						);
		            }else{
		                alert("删除失败！");
		            }
			}	
			
		}
		function delCallBack(data) {
			var a = document.getElementById(tagAId);
			a.parentNode.removeChild(a);
			var d = document.getElementById(tagInputId);
			d.parentNode.removeChild(d);
			var e = document.getElementById(editLinkId);
			e.parentNode.removeChild(e);
		}
		function updateSuper(pro_type,vision_id){
		var cruuent_pro_type = document.getElementsByName("crudObject.pro_type")[0].value;
			if(cruuent_pro_type!='${projectStartObject.pro_type}'){
				if(confirm("更改的项目类型与当前项目不一致。当前列表将不再显示。您确定要更改吗?")){
				document.forms[0].action ="${contextPath}/project/updateSuper.action?project_id=${project_id}&superPro_type="+pro_type+"&wppd_id="+vision_id ;
				document.forms[0].submit() ;
				}
			}else{
				document.forms[0].action ="${contextPath}/project/updateSuper.action?project_id=${project_id}&superPro_type="+pro_type+"&wppd_id="+vision_id ;
				document.forms[0].submit() ;
			}
		}
		function delSupervison(){
			var cbxs = document.getElementsByName("supervision_ids");
				var cbx_no = -1;
				for(var i=0;i<cbxs.length;i++){
					if(cbxs[i].checked){
						cbx_no = i;
					}
				}
				if(cbx_no==-1){
					alert("没有选择要删除的底稿!");
					return false;
				}
				if( window.confirm('确认删除吗？')){
					document.forms[0].action="${contextPath}/project/deleteSupervision.action?project_id=${project_id}";
					document.forms[0].submit();
				}
		}
	</script>
</html>
