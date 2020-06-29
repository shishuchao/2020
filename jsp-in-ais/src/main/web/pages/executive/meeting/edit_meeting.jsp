<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
<s:text id="title" name="'编辑会议通知'"></s:text>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<script type='text/javascript'
	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript'
	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script language="javascript">
//返回上级list页面
function backList(){
	var url = "${contextPath}/executive/meeting/list.action";
	myform.action = url;
	myform.submit();
}

//保存表单
function saveForm(){
	var bool = true;//提交表单判断参数
	
	
	var callDate = document.getElementsByName("crudObject.callDate")[0].value;
	var endDate = document.getElementsByName("crudObject.endDate")[0].value;
	if((callDate!=null && callDate!='')&&(endDate!=null && endDate!='')){
		if(!compareDate(callDate,endDate)){
			alert("结束日期应晚于召开日期，请检查！");
			return false;
		}
	}
	
	var startTime = document.getElementsByName("crudObject.startTime")[0].value;
	var endTime = document.getElementsByName("crudObject.endTime")[0].value;
	if((startTime!=null && startTime!='')&&(endTime!=null && endTime!='')){
		if(!compareDate(startTime,endTime)){
			alert("结束时间应晚于开始时间，请检查！");
			return false;
		}
	}
	
	
	//非空校验
	if(frmCheck(document.forms[0], 'tab1')){
		//完成保存表单操作
		if(bool==true){
			var flag=window.confirm('确认保存吗?');//isSubmit
			if(flag==true){
				var url = "${contextPath}/executive/meeting/save.action";
				myform.action = url;
				myform.submit();
			}else{
			 	return false;
			}
		}
	}else{
		return false;
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
		if(flag==true){
			myform.submit();
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
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
         function deleteFile(fileId,guid,isDelete,isEdit,appType){		
 			var boolFlag=window.confirm("确认删除吗?");
 			if(boolFlag==true)
 			{
 				//alert(guid);	
 				send('${contextPath}/commons/file/delFile.action?fileId='+fileId+'&&deletePermission='+isDelete+'&&isEdit='+isEdit+'&&guid='+guid+'&&appType=0',guid);
 			}
 		}
</script>
		<s:head />
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
		<s:form id="myform" action="submit" namespace="/executive/meeting">
			<table id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1
				class=ListTable align="center">
				<tr class="ListTableTr11" width="20%">
					<td width="20%">
						起草人:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.draftsmanName" readonly="true"
							display="${varMap['draftsmanNameRead']}" />
						<s:hidden name="crudObject.draftsmanId"></s:hidden>
					</td>
					<td width="20%">
						发布日期:
					</td>
					<td class="ListTableTr2">
						<!-- 						<s:textfield name="crudObject.pubDate" readonly="true"
							maxlength="20" title="单击选择日期"
							disabled="!varMap['pubDateWrite']"
							display="varMap['pubDateRead']" onclick="calendar()" />
 -->
						<s:textfield name="crudObject.pubDate" readonly="true"
							readonly="!(varMap['pubDateWrite']==null?true:varMap['pubDateWrite'])"
							display="${varMap['pubDateRead']}" maxlength="20" title="单击选择日期"
							onclick="calendar()" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td width="20%">
						召开日期:
					</td>
					<td class="ListTableTr2">
						<!-- 						<s:textfield name="crudObject.callDate" readonly="true"
							maxlength="20" title="单击选择日期"
							disabled="!varMap['callDateWrite']"
							display="varMap['callDateRead']" onclick="calendar()" />
 -->
						<s:textfield name="crudObject.callDate" readonly="true"
							readonly="!(varMap['pubDateWrite']==null?true:varMap['pubDateWrite'])"
							display="${varMap['pubDateRead']}" maxlength="20" title="单击选择日期"
							onclick="calendar()" />
					</td>
					<td width="20%">
						开始时间:
					</td>
					<td class="ListTableTr2">
						<!-- 						<s:textfield name="crudObject.startTime" readonly="true"
							maxlength="20" title="单击选择日期"
							disabled="!varMap['startTimeWrite']"
							display="varMap['startTimeRead']" onclick="calendar()" />
 -->
						<s:textfield name="crudObject.startTime" readonly="true"
							readonly="!(varMap['startTimeWrite']==null?true:varMap['startTimeWrite'])"
							display="${varMap['startTimeRead']}" maxlength="20"
							title="单击选择日期" onclick="calendar()" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td width="20%">
						结束日期:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.endDate" readonly="true"
							maxlength="20" title="单击选择日期" display="varMap['endDateRead']"
							onclick="calendar()" />
						<!-- 	disabled="!varMap['endDateWrite']" -->

					</td>
					<td width="20%">
						结束时间:
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.endTime" readonly="true"
							maxlength="20" title="单击选择日期" display="varMap['endTimeRead']"
							onclick="calendar()" />
						<!--disabled="!varMap['endTimeWrite']"  -->
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td width="20%">
						召集单位:
					</td>
					<td class="ListTableTr2">
						<s:buttonText name="crudObject.sumUnit"
							hiddenName="crudObject.sumUnitId" cssStyle="width:60%"
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=crudObject.sumUnit&paraid=crudObject.sumUnitId&orgtype=1',600,350)"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							doubleDisabled="false" />
					</td>
					<td width="20%">
						主持人:
						<font color="red">*</font>
					</td>
					<td class="ListTableTr2">
						<s:textfield name="crudObject.compereName" />
						<s:hidden name="crudObject.compereId" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						地点:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.locate" cssStyle="width:80%" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						参加人员:
						<font color="red">*</font>
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:buttonText name="crudObject.joiner" id="company"
							hiddenName="crudObject.joinerId" cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=crudObject.joiner&paraid=crudObject.joinerId',600,550,'所属单位')"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							doubleDisabled="false" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						会议名称:
						<font color="red">*</font>
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.meetingName" cssStyle="width:80%" />
					</td>
				</tr>

				<tr class="ListTableTr11" width="20%">
					<td>
						会议议题:
					</td>
					<td colspan="3" class="ListTableTr2">
						<s:textfield name="crudObject.meetingTitle" cssStyle="width:80%" />
					</td>
				</tr>

				<!-- 				<tr class="ListTableTr11" width="20%">
					<td>
						任务状态:
					</td>

					<td>
						<s:textfield name="crudObject.taskStats" />
					</td>
					<td>
						处理人意见:
					</td>
					<td>
						<s:textfield name="crudObject.handerSuggest" />
					</td> 
				</tr>
 -->
			</table>

			<s:hidden name="crudObject.taskStats"></s:hidden>
			<s:hidden name="crudObject.taskStatsId"></s:hidden>
			<!--<s:hidden name="crudObject.id" />-->
			<div align="right">
				<%@include file="/pages/bpm/list_toBeStart.jsp"%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<s:button value="保存" onclick="saveForm();" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<s:button value="返回列表" onclick="backList();" />
				&nbsp;&nbsp;&nbsp;&nbsp;

				<div align="center">
					<%@include file="/pages/bpm/list_transition.jsp"%>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>

			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
		</s:form>
	</center>
	</body>
</html>
