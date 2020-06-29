<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<s:text id="title" name="'编辑行政发文'"></s:text>
<html>
	<head>
		<title><s:property value="#title" /></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:head />
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css" />
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<script type="text/javascript"
		src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
	<script type='text/javascript'
		src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript'
		src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript"
		src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script language="javascript">


//返回上级list页面
function backList(){
	var url = "${contextPath}/executive/sendfile/list.action";
	myform.action = url;
	myform.submit();
}

//保存表单
function saveForm(){
var bool = true;//提交表单判断参数
//非空校验
 
	if(frmCheck(document.forms[0], 'tab1')){
		//完成保存表单操作
		if(bool){
		var flag=window.confirm('确认保存吗?');//isSubmit
		if(flag==true){
		var url = "${contextPath}/executive/sendfile/save.action";
		myform.action = url;
		myform.submit();
		}else{
			 	return false;
			 }
		}
	}
}

//提交表单
function toSubmit(option){
	if(frmCheck(document.forms[0], 'tab1')){
		if(document.getElementsByName('isAutoAssign')[0].value=='false'){
				var actor_name=document.getElementsByName('formInfo.toActorId_name')[0].value;
			if(actor_name==''){
				window.alert('下一步处理人不能为空！');
				return false;
				}
		}
	
		var flag=window.confirm('确认提交吗?');
		if(flag==true){myform.submit();
		}else{
			return false;
		}
	}
}
//上传附件
	function Upload(id,filelist,delete_flag,edit_flag){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=sendfile&table_guid=fjid&guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
		
</script>



	<script>
var XMLHttpReq=false;
 		//创建一个XMLHttpRequest对象
 		function createXMLHttpRequest(){
 				if(window.XMLHttpRequest){ //Mozilla 浏览器
 					XMLHttpReq=new XMLHttpRequest();
 					}
 					else if(window.ActiveXObject){ //微软IE 浏览器
 						try{
 							XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
 							}catch(e){
 								try{
 									XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
									//IE 5.0版本
 									}catch(e){}
 									}
 								}
 		}
 		var layerName="";//指定删除之后回显的DIV标签对的id属性
 		//发送请求函数
 		function send(url,guid){
 			createXMLHttpRequest();
 			XMLHttpReq.open("GET",url,true);
 			
 			this.layerName=document.getElementById(guid).parentElement.id;
 			
 			XMLHttpReq.onreadystatechange=proce;//指定响应的函数
 			XMLHttpReq.send(null);  //发送请求
 			};
 		function proce(layerName){
 			if(XMLHttpReq.readyState==4){ //对象状态
 				if(XMLHttpReq.status==200){//信息已成功返回，开始处理信息
 				var resText = XMLHttpReq.responseText;
 				document.getElementById(this.layerName).innerHTML=resText;
 				window.alert("删除成功");
 				}else{
 					window.alert("所请求的页面有异常");
 					}
 				}
 		}
 		
 		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.commons.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
 		function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
			var boolFlag=window.confirm("确认删除吗?");
			if(boolFlag==true){
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
					{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
					xxx);
				function xxx(data){
				  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
				} 
			}
		}

</script>
	</head>

	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();">
	</s:if>
	<s:else>
		<body>
	</s:else>

	<center>
		<table>
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					&nbsp;
					<s:property value="#title" />
				</td>
			</tr>
		</table>
		<s:form id="myform" action="submit" namespace="/executive/sendfile">
			<table id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1
				class=ListTable align="center">
				<tr class="ListTableTr11" width="20%">
					<td>
						签发人:
					</td>
					<td class="ListTableTr2">
						<s:buttonText name="crudObject.signerName"
							hiddenName="crudObject.signerId" cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/frameselect4s.jsp?url=/pages/system/userindex.jsp&paraname=crudObject.signerName&paraid=crudObject.signerId',600,550)"
							doubleSrc="/resources/images/s_search.gif" title="人员单选"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							doubleDisabled="false" />
					</td>
					<td>
						拟稿人:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.writerName" readonly="true"
							cssStyle="width:60%" />
						<s:hidden name="crudObject.writerId"></s:hidden>
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						签发人意见:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.signerSuggest" maxlength="25"
							cssStyle="width:60%" />
					</td>
					<td>
						拟稿人部门:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.writerDept" readonly="true"
							cssStyle="width:60%" />
						<s:hidden name="crudObject.WriterDeptId"></s:hidden>
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						发文字号:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.sendFileNO" maxlength="25"
							cssStyle="width:60%" />
					</td>
					<td colspan="2">
						印
						<s:textfield name="crudObject.printSum" maxlength="10"
							cssStyle="width:20%" />
						份 附件
						<s:textfield name="crudObject.fjSum" maxlength="10"
							cssStyle="width:20%" />
						份 印发:
						<s:textfield name="crudObject.printSend" maxlength="10"
							cssStyle="width:20%" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						编号日期:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.refeDate" readonly="true"
							maxlength="20" title="单击选择日期" onclick="calendar()"
							cssStyle="width:60%" />
					</td>
					<td>
						签发日期:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.signerDate" readonly="true"
							maxlength="20" title="单击选择日期" onclick="calendar()"
							cssStyle="width:60%" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						紧急程度:
					</td>
					<td class="ListTableTr2">
						<s:select name="crudObject.emergencyLevel"
							list="basicUtil.emergencyLevelList" listKey="code"
							listValue="name" emptyOption="true" />
					</td>
					<td>
						保密等级:
					</td>
					<td class="ListTableTr2">
						<s:select name="crudObject.securityLevel"
							list="basicUtil.securityLevelList" listKey="code"
							listValue="name" emptyOption="true" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						<font color="red">*</font> 主送:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:buttonText name="crudObject.mainSend" id="company"
							hiddenName="crudObject.mainSendId" cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=crudObject.mainSend&paraid=crudObject.mainSendId',600,550,'所属单位')"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							doubleDisabled="false" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						抄送:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:buttonText name="crudObject.copySend" id="company"
							hiddenName="crudObject.copySendId" cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=crudObject.copySend&paraid=crudObject.copySendId',600,550,'所属单位')"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							doubleDisabled="false" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						<font color="red">*</font> 标题:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.title" maxlength="50"
							cssStyle="width:80%" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						主题词:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.mainWord" maxlength="50"
							cssStyle="width:80%" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						文种:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.recordType" maxlength="50"
							cssStyle="width:80%" />
					</td>
				</tr>
				<!-- 				<tr class="ListTableTr11" width="20%">
					<td>
						正文内容:
					</td>
					<td colspan="3">
						<s:textarea name="crudObject.content"></s:textarea>
					</td>
				</tr>
 -->
				<tr class="ListTableTr11" width="20%">
					<td>
						附注:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.annotations" maxlength="50"
							cssStyle="width:80%" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						阅读范围:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.readScope" maxlength="50"
							cssStyle="width:80%" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						印发单位:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.publishUnit" maxlength="50"
							cssStyle="width:80%" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						创建时间:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.createTime" readonly="true"
							maxlength="20" title="单击选择日期" onclick="calendar()"
							cssStyle="width:80%" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						送达时间:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.endTime" readonly="true"
							maxlength="20" title="单击选择日期" onclick="calendar()"
							cssStyle="width:80%" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						备注:
						<font color="red">(最多500字)</font>
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textarea name="crudObject.backup" />
						<input type="hidden" id="crudObject.backup.maxlength" value="500">
					</td>
				</tr>

				<!-- 				<tr class="ListTableTr11" width="20%">
					<td>
						当前任务:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.currentTask" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						处理人意见:
					</td>

					<td>
						<s:textfield name="crudObject.handerSuggest" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						阅件用户:
					</td>
					<td>
						<s:textfield name="crudObject.readUser" />
					</td>
				</tr>
				<tr class="ListTableTr11" width="20%">
					<td>
						已阅人员:
					</td>
					<td>
						<s:textfield name="crudObject.readedPerson" />
					</td>
				</tr>
 -->
			</table>
			<div id="accelerys" align="center">
				<s:property escape="false" value="accessoryList" />
			</div>

			<s:hidden name="crudObject.fjid"></s:hidden>
			<s:hidden name="crudObject.currentTask"></s:hidden>
			<s:hidden name="crudObject.currentTaskId"></s:hidden>
			<s:hidden name="crudObject.id" />
			<div align="right">
				<s:button onclick="Upload('crudObject.fjid',accelerys,true);"
					value="上传附件"></s:button>
				<%@include file="/pages/bpm/list_toBeStart.jsp"%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<s:button value="保存" onclick="saveForm();" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<s:button value="返回列表" onclick="backList();" />
				&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<div align="center">
				<%@include file="/pages/bpm/list_transition.jsp"%>
			</div>
			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
		</s:form>
	</center>
	</body>
</html>
