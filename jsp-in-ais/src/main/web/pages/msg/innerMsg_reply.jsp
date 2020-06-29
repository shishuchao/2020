<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>回复消息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/swfload/uploadFile.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		 <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript">	
			$(function(){
				$("#innerMsg_toUsers_FName").val('${innerMsgReply.toUsersName}');
				$("#innerMsg_toUsers").val('${innerMsgReply.toUsers}');
			});
			function myCheck(){
				obj=document.getElementById("innerMsg_toUsers");
				me=document.getElementById("manualEmail");
				mm=document.getElementById("manualMobile");
				ismsg = document.getElementById("isSendMsg");
				ismail = document.getElementById("isSendMail");
				iss = document.getElementById("isSendSms");
				if(!(ismsg.checked||ismail.checked||iss.checked)){
					alert("请指定至少一种发送类型！");
					return ;
				}
		        if(ismsg.checked){
		        	if(obj.value==""){
			            alert("接收人不能为空,请完善信息!");  
			    		return ;
		        	}
		        }
		        if(ismail.checked){
		        	if(obj.value==""&&me.value==""){
			            alert("接收人与外发邮箱不能同时为空,请完善信息!");  
			    		return;
		        	}
		        	if(!inputemailValidate("manualEmail")){
		        		return;
		        	}
		        }
		        
				obj=document.getElementById("subject");
				 if(obj.value==""){
					 return confirm("标题为空,确认要提交吗?");
				 }
				 obj=document.getElementById("bodyText");
				 if(obj.value==""){
					 return confirm("内容为空,确认要提交吗?");
				 }
				innerMsgForm.submit();			
			 }
			function Upload(guid,divIdName){
			    var contextPath = '${contextPath}';
				var table_name = 'sys_InnerMsg';
				var table_guid = 'attachmentsId';
				var guid=document.getElementById(guid).value;
				var deletePermission = 'true';
				var isEdit = 'false';
				var title = '系统通知附件信息'
				var width = 500;
				var height = 450;
				uploadFile(contextPath,table_name,table_guid,guid,deletePermission,isEdit,divIdName,title,width,height);
			}
			function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true){
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
					function xxx(data){
					  	document.getElementById("attachmentsDiv").parentElement.innerHTML=data['accessoryList'];
					} 
				}
			}
			function chgShow(ele,status,infoEle,infoEle1){
				if(status){
					ele.style.display='';
				}else{
					ele.style.display='none';
					infoEle.value="";
					if(infoEle1)
						infoEle1.value="";
				}
			}
			function openwindow(url,name,iWidth,iHeight){
				var url;                                 //转向网页的地址;
				var name;                           //网页名称，可为空;
				var iWidth;                          //弹出窗口的宽度;
				var iHeight;                        //弹出窗口的高度;
				var iTop = (window.screen.availHeight-iHeight)/2;       //获得窗口的垂直位置;
				var iLeft = (window.screen.availWidth-iWidth)/2;           //获得窗口的水平位置;
				window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
			}
			function initWebPage(){
				var isSendMail = '${isSendMail}';
				var isSendSms = '${isSendSms}';
				var isSendMsg = '${isSendMsg}';
				if(isSendMail=='true'){
					document.getElementById('mailTr').style.display='';
				}
				if(isSendSms=='true'){
					document.getElementById('mobileTr').style.display='';
				}
				if(isSendMsg=='true'){
					document.getElementById('userTr').style.display='';
				}
			}
		</script>
	</head>
<body onload="initWebPage();" style="overflow: auto;overflow-x:hidden;" class="easyui-layout">
<s:form action="innerMsg_save" id="innerMsgForm" name="innerMsgForm"
	namespace="/msg" theme="simple" 
	method="post">
	<s:hidden name="readFlag"/>
	<s:hidden name="attachments" value="${innerMsg.attachmentsId}"/>
	<table id="planTable" name="planTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%;">
		<tr align="center">
			<td height="45" align="center" colspan="2" nowrap="nowrap"
				class="edithead" style="width: 10%">
			<div align="center" ><b>回复消息</b></div>
			</td>
		</tr> 
		<tr>
			<td class="EditHead" style="width:10%"><b>类&nbsp;&nbsp;&nbsp;型 </b></td>
			<td class="editTd"  style="width: 35%">
				<s:checkbox name="isSendMsg" id="isSendMsg" onclick="chgShow(userTr,this.checked,innerMsg_toUsers_FName,innerMsg_toUsers)"></s:checkbox>
				<label for="isSendMsg">站内消息</label> 
				<s:checkbox name="isSendMail" id="isSendMail" onclick="chgShow(mailTr,this.checked,manualEmail)" >&nbsp;&nbsp;&nbsp;&nbsp;</s:checkbox>
				<label for="isSendMail">电子邮件</label>
				点击<a style="cursor: hand;color:red" class="text1" onclick="openwindow('/ais/general/acntMng.action?formType=2','',350,320)">账号管理</a>完善邮箱配置
				</td>
		</tr>
		<tr class="listtablehead" id="userTr" style="display:none;">
			<td class="EditHead" style="width:10%" >
				<b>内部账号</b></td>
			<td class="editTd"  style="width:35%;">
				
				<s:buttonText2 id="innerMsg_toUsers_FName"
				name="innerMsg.toUsersName" cssStyle="width:400"
				hiddenId="innerMsg_toUsers" hiddenName="innerMsg.toUsers"
				doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'请选择接收人',
								  type:'treeAndUser',
                                  param:{
                                    'p_item':1,
                                    'orgtype':1
                                  }
								})"
				doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
				doubleCssStyle="cursor:hand;border:0" readonly="true"
				maxlength="200" title="接收人" />
				
			</td>
		</tr>
		<tr class="listtablehead" id="mailTr" style="display:none;">
			<td class="EditHead" nowrap="nowrap" style="width: 15%"
				height="45"><b>外发邮箱 </b></td>
			<td class="editTd" nowrap="nowrap"
				style="width: 30%;">
				<input type="text" name="manualEmail" id="manualEmail" maxlength="200"style="width:400px;">
		</tr>
		<tr>
			<td class="EditHead" style="width:10%">
				<b>标&nbsp;&nbsp;&nbsp;题</b>
			</td>
			<td class="editTd" style="width:35%">
				<textarea id="subject" name="innerMsg.subject" style='width:100%;height:100px;overflow-y:visible;line-height:150%;'>${innerMsgReply.subject}</textarea>
			</td>
		</tr>
		<tr>
			<td class="EditHead" style="width:10%">
				<b>内&nbsp;&nbsp;&nbsp;容</b>
			</td>
			<td class="editTd" style="width:35%">
			<s:textarea id="bodyText" 
				name="innerMsg.bodyText" cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;"
				value="${innerMsg.bodyText}" />
			</td>
		</tr>
		<%--<tr id="fujian">
			<td class="EditHead">
				<a class="easyui-linkbutton" iconCls="icon-upload" href="javascript:void(0);" onclick="Upload('${innerMsg.attachmentsId}',accelerys)">上传附件</a>
				<s:hidden name="innerMsg.attachmentsId" />
			</td>
			<td class="editTd" colspan="3">
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList" />
				</div>
			</td>
		</tr>--%>
		<tr>
			<td class="EditHead" style="width:10%;">附件</td>
			<td class="editTd" colspan="3">
				<div id="head_${innerMsg.attachmentsId}" style="float: left" class="required"></div>
				<div id="content_${innerMsg.attachmentsId}" style="float: right"></div>
			</td>
		</tr>
		<tr align="center">
			<td align="center" colspan="2" class="edithead">
			<div align="center">
				<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="myCheck()">发送</a>
				<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="javascript:window.location.href='${contextPath}/msg/innerMsg_list.action?readFlag=${readFlag}'">返回</a>
			</div>
		</tr> 
	</table>
</s:form>
<script type="text/javascript">
		$(function(){
			$('#bodyText').attr('maxlength',10000000);
			$('#head'+"_${innerMsg.attachmentsId}").fileUpload({
				fileGuid:'${innerMsg.attachmentsId}' == ''?'-1':'${innerMsg.attachmentsId}',
				echoType:2,
				isDel:true,
				isEdit:true,
				uploadFace:1,
				triggerId:'content'+'_${innerMsg.attachmentsId}'
			});

			$("#innerMsgForm").find("textarea").each(function(){
				autoTextarea(this);
			});
		});

</script>
</body>
</html>
