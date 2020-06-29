<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>适用法规</title>
		<s:head theme="ajax" />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" 
			href="${contextPath}/resources/csswin/style.css" />
		<link rel="stylesheet" type="text/css" 
			href="${contextPath}/resources/csswin/subModal.css" />
		<script language="javascript" type="text/javascript"
			src="${contextPath}/resources/js/normal.js"></script>
		<script language="javascript" type="text/javascript"
			src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript">
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
	 		//发送请求函数
	 		function send(url){
	 			createXMLHttpRequest();
	 			XMLHttpReq.open("GET",url,true);
	 			XMLHttpReq.onreadystatechange=proce;   //指定响应的函数
	 			XMLHttpReq.send(null);  //发送请求
	 			};
	 		function proce(){
	 			if(XMLHttpReq.readyState==4){ //对象状态
	 				if(XMLHttpReq.status==200){//信息已成功返回，开始处理信息
	 				var resText = XMLHttpReq.responseText;
	 				document.getElementById('accelerys').innerHTML=resText;
	 				window.alert("删除成功！");
	 				}else{
	 					window.alert("所请求的页面有异常！");
	 					}
	 					}
	 		}
	 		/*DWR2删除附件回传附件列表---LIHAIFENG 2007-12-20*/
			function deleteFile(fileId,guid,isDelete,isEdit,appType){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true)
				{
					DWREngine.setAsync(false);
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
	<body>
		<center>
			<s:form action="fgView" namespace="/pages/assist/suport/lawsLib" theme="simple">
				<table id="portalTab" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tr>
						<td class="listtabletr1" nowrap="nowrap">
							法规名称：
						</td>
						<td class="listtabletr2">
							<s:textfield name="fg.name" cssStyle="width: 100%"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							发文文号：
						</td>
						<td class="listtabletr2">
							<s:textfield name="fg.wh" cssStyle="width: 100%"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							适用范围：
						</td>
						<td class="listtabletr2">
							<s:textfield name="fg.syfw" cssStyle="width: 100%"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							发文单位：
						</td>
						<td class="listtabletr2">
							<s:textfield name="fg.fwdw" cssStyle="width: 100%"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							生效日期：
						</td>
						<td class="listtabletr2">
							<s:textfield name="fg.sxrq" cssStyle="width: 100%"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							失效日期：
						</td>
						<td class="listtabletr2">
							<s:textfield name="fg.shixrq" cssStyle="width: 100%"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							法规条目：
						</td>
						<td class="listtabletr2">
							<s:textarea name="fg.tm" cssStyle="width: 100%"></s:textarea>
						</td>
					</tr>
				</table>
				<div align="center">
					<s:button align="center" value="关闭" onclick="window.close()"></s:button>
				</div>
			</s:form>
		</center>
	</body>
</html>