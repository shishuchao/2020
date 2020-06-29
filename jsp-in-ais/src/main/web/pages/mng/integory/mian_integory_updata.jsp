<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<s:text id="title" name="'中介机构库'"></s:text>
		<title><s:property value="#title" /></title>
		<s:head theme="ajax" />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/cncext/grid-examples.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/cncext/examples.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/styles/portal/ext-all.css" />
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<link
			href="${pageContext.request.contextPath}/styles/main/ais4ext.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/pages/assist/baseInfo/dept.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/js/dwr/DWRActionUtil.js'></script>
		<SCRIPT type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/calendar.js"></SCRIPT>
			
		<script type="text/javascript">
				function openDialog(){
					var num=Math.random();
					var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
					window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=${integoryinfoW.fjid}&&param='+rnm+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
				}
				function deleteFile(fileId,guid,isDelete,isEdit,appType){
					var boolFlag=window.confirm("确认删除吗?");
					if(boolFlag==true)
					{
						DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
					{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
					xxx);
					function xxx(data){
					  	document.getElementById("accelerys").innerHTML=data['accessoryList'];
					} 
					}
				}
		</script>
	</head>
	
	<body topmargin="0" leftmargin="0" >
		<center> 
			<s:tabbedPanel id="">
				<s:div id="info" label="基本信息" theme="ajax">
				<iframe src="${contextPath}/resmngt/integory/updateIntegory.action?interoryId=${interoryId }"
					frameborder="0" width="100%" height="260"></iframe>
				</s:div>
			</s:tabbedPanel>
		</center>
	</body>