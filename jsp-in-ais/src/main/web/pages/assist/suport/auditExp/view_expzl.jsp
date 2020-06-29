<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>所需资料</title>
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
			<s:form action="zlView" namespace="/pages/assist/suport/lawsLib" theme="simple">
				<table id="portalTab" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tr>
						<td class="listtabletr1">
							资料标题：
						</td>
						<td class="listtabletr2">
							<s:textfield name="zl.title" cssStyle="width: 100%"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							资料内容：
						</td>
						<td class="listtabletr2">
							<s:textarea name="zl.content" cssStyle="width: 100%"></s:textarea>
						</td>
					</tr>
					<!-- 
					<tr>
						<td class="listtabletr1">
							附件：
						</td>
						<td class="listtabletr2">
							<table cellpadding=1 cellspacing=1 border=0 bgcolor=#409cce class=ListTableFile>
								<tr class=listtablehead>
									<td colspan=6 align=left class=edithead>&nbsp;附件信息</td>
								</tr>
								<tr align=center class=titletable1>
									<td align=center class=1_lan nowrap="true">
										<center>文件名称</center>
									</td>
									<td class=1_lan nowrap="true">
										<center>附件上传时间</center>
									</td>
									<td class=1_lan nowrap="true">
										<center>附件上传人</center>
									</td>
									<td class=1_lan nowrap="true">
										<center>最后修改时间</center>
									</td>
									<td class=1_lan nowrap="true">
										<center>最后修改人</center>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					 -->
				</table>
				<div align="center">
					<s:button align="center" value="关闭" onclick="window.close()"></s:button>
				</div>
			</s:form>
		</center>
	</body>
</html>