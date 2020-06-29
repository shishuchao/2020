
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>发送消息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript">
		$(function(){
			var parentTabId = '${parentTabId}';
			var curTabId = aud$getActiveTabId();
			$("#closeBtn").bind('click', function(){
				if ("${toFirst}" == '1'){
					window.parent.$('#tempMailDiv').window('close');
				}else{
					window.history.back(-1);
				}
				
			    /*$("button.close").click();
                // window.parent.$("#innermsgShow").css('display','none');
                // window.parent.$(".modal-backdrop.fade.in")[1].remove();
                 window.parent.$("#newMessage").click();*/

			});
		});
			function myCheck(){
				obj=document.getElementById("innerMsg_toUsers");
				me=document.getElementById("manualEmail");
				mm=document.getElementById("manualMobile");
				ismsg = document.getElementById("isSendMsg");
				ismail = document.getElementById("isSendMail");
//				iss = document.getElementById("isSendSms");
				if(!(ismsg.checked||ismail.checked)){//||iss.checked
					$.messager.show({
						title:'提示消息',
						msg:'请指定至少一种发送类型！',
						timeout:5000,
						showSpeed:1000
					});
					return ;
				}
		        if(ismsg.checked){
		        	if(obj.value==""){
						$.messager.show({
							title:'提示消息',
							msg:'接收人不能为空,请完善信息!',
							timeout:5000,
							showSpeed:1000
						});
			    		return ;
		        	}
		        }
		        if(ismail.checked){
		        	if(obj.value==""&&me.value==""){
						$.messager.show({
							title:'提示消息',
							msg:'接收人与外发邮箱不能同时为空,请完善信息!',
							timeout:5000,
							showSpeed:1000
						});
			    		return;
		        	}
		        	if(!inputemailValidate("manualEmail")){
		        		return;
		        	}
		        }
		        obj=document.getElementById("subject");
		        if (obj.value==""){
					$.messager.show({
						title:'提示消息',
						msg:'消息标题不能为空,请完善信息!',
						timeout:5000,
						showSpeed:1000
					});
		    		return ;
		        }
		        obj=document.getElementById("bodyText");
		        if (obj.value==""){
					$.messager.show({
						title:'提示消息',
						msg:'消息内容不能为空,请完善信息!',
						timeout:5000,
						showSpeed:1000
					});
		    		return ;
		        }
		        innerMsgForm.submit();
		        if("${readFlag}" == 8 || "${toFirst}" =='1'){
		        	backclose();
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
			function contants(){
				$("#contants").window("open");
			}
			function myClose(){
				$("#contants").window("close");
			}
			function toRight(){
				var data = new Array();
				//原有数据
				var toData = $('#toData').datagrid("getRows");
				//新加数据
				var fromData = $('#fromData').datagrid("getSelections");
				//数据对比,去重取并集
				//data = Array.union(toData,fromData);
				var flag = false;
				for(var i=0; i<fromData.length; i++){
					for(var j=0; j<toData.length; j++){
						if(fromData[i].sysAccount == toData[j].sysAccount){
							flag = true;
						}
					}
					if(!flag){
						toData.push(fromData[i]);
					}
					flag = false;
				}
				
				
				$("#toData").datagrid({
					data: toData
				});
				$('#fromData').datagrid("reload");

			}
			function toLeft(){
				var data = new Array();
				var toDataAll = $('#toData').datagrid("getRows");
				var toData = $('#toData').datagrid("getSelections");
				var flag = false;
				for(var i=0; i<toDataAll.length; i++){
					for(var j=0; j<toData.length; j++){
						if(toDataAll[i].sysAccount == toData[j].sysAccount){
							flag = true;
						}
					}
					if(!flag){
						data.push(toDataAll[i]);
					}
					flag = false;
				}
				$("#toData").datagrid({
					data: data
				});
			}
			function mySave(){
				var sysAccounts = "";
				var emails = "";
				var userNames = "";
				var toDataAll = $('#toData').datagrid("getRows");
				for(var i=0; i<toDataAll.length; i++){
					if(i == 0){
						sysAccounts = toDataAll[i].sysAccount;
						emails = toDataAll[i].email;
						userNames = toDataAll[i].userName;
					}else{
						sysAccounts = sysAccounts + "," + toDataAll[i].sysAccount;
						emails = emails + ";" + toDataAll[i].email;
						userNames = userNames + "," + toDataAll[i].userName;
					}
				}
				ismsg = document.getElementById("isSendMsg");
				ismail = document.getElementById("isSendMail");
		        if(ismsg.checked){
		        	$("#innerMsg_toUsers_FName").val(userNames);
		        	$("#innerMsg_toUsers").val(sysAccounts);
		        }
		        if(ismail.checked){
		        	$("#manualEmail").val(emails);
		        }
		        $("#contants").window("close");
			} 
			$().ready(function(){
				$('#fromData').datagrid({    
				    url:'/ais/admin/frequentContactsAll.action',
				    striped:true,
				    columns:[[    
				        {field:'sysAccount',title:'系统账户',width:50,hidden:true},    
				        {field:'userName',title:'联系人姓名',width:103},    
				        {field:'email',title:'邮箱',width:155}    
				    ]]    
				});  
				
				$('#toData').datagrid({
					striped:true,
				    columns:[[    
				        {field:'sysAccount',title:'系统账户',width:80,hidden:true},    
				        {field:'userName',title:'联系人姓名',width:110},    
				        {field:'email',title:'邮箱',width:165}    
				    ]]   
				});
				$("#contants").window({
					title:"常用联系人",
					width:680,
					height:400,
					modal:true
				});
				$("#contants").window("close");
				 $("#userName").bind("keypress",function(event){
					 var name =  $("#userName").val();
					 if(event.keyCode == "13"){
						 $('#fromData').datagrid("load",{
							 userName:name
						 });

					 }
				 });
				$('#bodyText').attr('maxlength',10000000);
				$('#subject').attr('maxlength',200);
                $("#innerMsgForm").find("textarea").each(function(){
                    autoTextarea(this);
                });
			});
			

		function backclose(){
			var readFlag = '${readFlag}';
			if(readFlag != null && (readFlag == '8' ||  "${toFirst}" =='1')){
				window.parent.$('#tempMailDiv').window('close');
			}else{
				window.location.href='${contextPath}/msg/innerMsg_list.action?readFlag=${readFlag}'	;
			}
		}
		
		function selectAll(){
			$.ajax({
				url:'${contextPath}/msg/selectAllUser.action',
				type:'post',
				dataType:"json",
				async:false,
				success:function(data){
					$("#innerMsg_toUsers").val(data.userCode);
					$("#innerMsg_toUsers_FName").val(data.userName);
				}
			})
		}
		</script>
	</head>
<body onload="initWebPage();" >
<s:form action="innerMsg_save" id="innerMsgForm" name="innerMsgForm"
	namespace="/msg" theme="simple" method="post">
	<table align="center" cellpadding=1 cellspacing=1 border=0
		class="ListTable" style="width:100%;height:450px;">
		<s:hidden name="readFlag" value="${readFlag}"></s:hidden>
		<s:hidden name="attachments" value="${innerMsg.attachmentsId}"/>
		<tr class="listtablehead">
			<td class="EditHead" nowrap="nowrap" style="width: 20%"
				height="45"><b>类&nbsp;&nbsp;&nbsp;型 </b></td>
			<td class="editTd"  nowrap="nowrap"
				style="width: 90%" >
				<s:checkbox name="isSendMsg" id="isSendMsg" onclick="chgShow(userTr,this.checked,innerMsg_toUsers_FName,innerMsg_toUsers)"></s:checkbox>
				<label for="isSendMsg">站内消息</label> 
				<s:checkbox name="isSendMail" id="isSendMail" onclick="chgShow(mailTr,this.checked,manualEmail)" >&nbsp;&nbsp;&nbsp;&nbsp;</s:checkbox>
				<label for="isSendMail">电子邮件</label>
				点击<a style="cursor: hand;color:red" class="text1" onclick="openwindow('/ais/general/acntMng.action?formType=2','',350,320)">账号管理</a>完善邮箱配置
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" style="cursor: hand;" onclick="contants();">常用联系人</a>
			</td>
		</tr>
		<tr class="listtablehead" id="userTr" style="display: none;">
			<td class="EditHead" nowrap="nowrap" style="width:10%" height="45">
				<font color=red>*</font><b>内部账号</b></td>
			<td class="editTd" nowrap="nowrap"  style="width:90%;padding: 10px;" height="45">
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
				maxlength="200" title="接收人" /> &nbsp;&nbsp;
				<a class="easyui-linkbutton" iconCls="icon-edit" href="javaScript:void(0)" onclick="selectAll()">全部</a>
			</td>
		</tr>
		<tr class="listtablehead" id="mailTr" style="display:none;">
			<td class="EditHead" nowrap="nowrap" style="width: 10%"
				height="45"><b>外发邮箱 </b></td>
			<td class="editTd" nowrap="nowrap"
				style="width: 90%;padding: 10px;" height="45">
				<input type="text" name="manualEmail" id="manualEmail" maxlength="200"style="width:400">
		</tr>
		<tr class="listtablehead">
			<td valign="middle" nowrap="nowrap" class="EditHead"
				style="width: 10%; height: 50;">
				<font color=red>*</font><b>标&nbsp;&nbsp;&nbsp;题</b>
				<br/><div style="text-align:right"><font color=DarkGray>(限200字)</font></div>
			</td>
			<td class="editTd" style="width: 90%;padding: 10px;" > 
			<s:textarea id="subject"
				name="innerMsg.subject" cssStyle="width:100%;overflow-y:visible;ime-mode: active;"
				value="${innerMsg.subject}" cols="50" rows="5"/>
				
			</td>
		</tr>
		<tr class="listtablehead">
			<td valign="middle" nowrap="nowrap" class="EditHead"
				style="width: 10%; height: 50;">
				<font color=red>*</font><b>内&nbsp;&nbsp;&nbsp;容</b>
			</td>
			<td class="editTd" style="width: 90%;padding: 10px;" > 
			<s:textarea id="bodyText"
				name="innerMsg.bodyText" cssStyle="width:100%;overflow-y:visible"
				value="${innerMsg.bodyText}"  cols="50" rows="10"/>
			</td>
		</tr>
		<tr>
			<!-- fileUpload 组件文件上传 -->
			<td class="EditHead" nowrap>
				<div style='float:right;'>附件</div>
				<div id='addFileBtnID' style='float:right;margin:15px -60px 0 0;'></div>
				<s:hidden id="w_file" name="innerMsg.attachmentsId" />
			</td>
			<td class="editTd" colspan="3" >
				<div data-options="fileGuid:'${innerMsg.attachmentsId}'"  class="easyui-fileUpload"></div>
			</td>
		</tr>
		<tr align="center">
			<td height="45" align="center" colspan="2" class="edithead" style="width: 10%">
				<div align="center">
				    <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="myCheck()">发送</a>
				     <a id="closeBtn" class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)">关闭</a>
				</div>
			</td>
		</tr>
	</table>
</s:form>
<div id="contants" style="overflow-y:hidden;">
	
	<div style="width:270px;height:370px;overflow-y:auto;float:left;border:3px solid #DDDDDD;">
		姓名：<s:textfield name="userName" id="userName" cssStyle="margin:3px 0 0 5px;"></s:textfield>
		<div style="height:10px;"></div>
		<table id="fromData"></table>
	</div>
	<div style="width:290px;height:370px;float:right;border:3px solid #DDDDDD;overflow-y:auto;">
		<div style="height:33px;text-align:center;">
			<div style="font-weight:700;font-size:16px;color:#5599FF;margin-top:5px;">已选联系人</div>
		</div>
		<table id="toData"></table>
	</div>
	  <!-- <div style="width:40px;height:360px;">    --> 
	  <div style="width:60px;height:360px;float:left;overflow-y:hidden;">                    
	  <div style="margin-top:20px;margin-left:10px;margin-right: 10px;"><a style="cursor:pointer;" onclick="toLeft();"><img src="/ais/pages/introcontrol/util/themes/icons/undo.png" /></a></div>	                               
		<div style="margin-top:80px;margin-left:10px;margin-right: 10px;"><a style="cursor:pointer;" onclick="toRight();"><img src="/ais/pages/introcontrol/util/themes/icons/redo.png"/></a></div>
		
        <div style="margin-top:100px;margin-left:10px;margin-right: 10px;"><a href="javascript:;" class="easyui-linkbutton" onclick="mySave();">确&nbsp;&nbsp;定</a></div>
		<div style="margin-top:10px;margin-left:10px;margin-right: 10px;"><a href="javascript:;" class="easyui-linkbutton" onclick="myClose();" >关&nbsp;&nbsp;闭</a><div>
	</div> 
	

</div>

</body>
</html>
