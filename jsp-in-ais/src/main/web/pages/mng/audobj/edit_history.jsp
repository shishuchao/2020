<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>


<s:if test="crudObject.id==0">
	<s:text id="title" name="'添加对象'"></s:text>
</s:if>
<s:else>
    <s:text id="title" name="'修改对象'"></s:text>
</s:else>
<html>
<head><title><s:property value="#title"/></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>					
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head> 

<body>
<script>
function Upload(id,filelist)
	{
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_outside_history&table_guid=other_resource_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
 				window.alert("删除成功！");
 				}else{
 					window.alert("所请求的页面有异常！");
 					}
 					}
 		}
 		
 		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
 		function deleteFile(fileId,guid,bool,appType){		
 			var boolFlag=window.confirm("确认删除吗?");
 			if(boolFlag==true)
 			{
 				//alert(guid);	
 				send('${contextPath}/commons/file/delFile.action?fileId='+fileId+'&&deletePermission='+bool+'&&guid='+guid+'&&appType='+appType,guid);
 			}
 		}
		function vNum(){
			if(!isMoneyNum(document.getElementById('outsideHistory.wjwgje').value)){
				alert("查出违纪违规行为金额 应为金额格式！");
				return false;
			}
			if(!isMoneyNum(document.getElementById('outsideHistory.ysjje').value)){
				alert("应上缴金额 应为金额格式！");
				return false;
			}
			if(!isMoneyNum(document.getElementById('outsideHistory.tzje').value)){
				alert("调账金额 应为金额格式！");
				return false;
			}
			if(!isMoneyNum(document.getElementById('outsideHistory.jzsslfje').value)){
				alert("纠正损失浪费金额 应为金额格式！");
				return false;
			}
			if(!isMoneyNum(document.getElementById('outsideHistory.cjzsjzje').value)){
				alert("促进增收节支金额 应为金额格式！");
				return false;
			}
			if(!isMoneyNum(document.getElementById('outsideHistory.fkje').value)){
				alert("罚款金额 应为金额格式！");
				return false;
			}
			var re = /^[0-9]+$/;
			var issue = document.getElementById('outsideHistory.tcjyyj').value
			if(issue!=null && issue!='' && !re.test(issue)){
				alert("提出建议意见被采纳 应为数字！");
				return false;
			}
			return true;
		}
 		function chkHistory(){
 			if(!frmCheck(document.forms[0],'tab1') || !vNum()) return false;
 			var startDate=document.getElementsByName("outsideHistory.startDate")[0].value;
 			var endDate=document.getElementsByName("outsideHistory.endDate")[0].value;
			if(startDate!=null && startDate!='' && endDate!=null && endDate!='' && !compareDate(startDate,endDate)){
				alert("审计开始日期 要大于 审计终止日期!");
				return false;
			}
 			return true;
 		}	
</script>
<center>
<s:form action="save" onsubmit="return chkHistory();">
				<table id='tab1' cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							项目名称
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:100%" name="outsideHistory.projectName" maxlength="50"></s:textfield>
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							审计单位
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:100%" name="outsideHistory.department" maxlength="50"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							审计开始日期
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:100%" maxlength="10" name="outsideHistory.startDate" readonly="true" onclick="calendar()"></s:textfield>
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							审计终止日期
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:100%" maxlength="10" name="outsideHistory.endDate" readonly="true" onclick="calendar()"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							查出违纪违规行为金额
						</td>
						<td class="ListTableTr22">
							<input name="outsideHistory.wjwgje" value="${outsideHistory.wjwgje}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">（万元）
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							应上缴金额
						</td>
						<td class="ListTableTr22">
							<input name="outsideHistory.ysjje" value="${outsideHistory.ysjje}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">（万元）
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							调账金额
						</td>
						<td class="ListTableTr22">
							<input name="outsideHistory.tzje" value="${outsideHistory.tzje}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">（万元）
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							纠正损失浪费金额
						</td>
						<td class="ListTableTr22">
							<input name="outsideHistory.jzsslfje" value="${outsideHistory.jzsslfje}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">（万元）
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							促进增收节支金额
						</td>
						<td class="ListTableTr22">
							<input name="outsideHistory.cjzsjzje" value="${outsideHistory.cjzsjzje}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">（万元）
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							罚款金额
						</td>
						<td class="ListTableTr22">
							<input name="outsideHistory.fkje" value="${outsideHistory.fkje}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">（万元）
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							提出建议意见被采纳
						</td>
						<td class="ListTableTr22">
							<DIV><s:textfield cssStyle="width:80%" name="outsideHistory.tcjyyj" maxlength="4"></s:textfield>（条）</DIV>
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							项目负责人
						</td>
						<td class="ListTableTr22">
							<s:textfield cssStyle="width:100%" name="outsideHistory.projectDirector" maxlength="16"></s:textfield>
						</td>						
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap="nowrap">
							备注
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textfield cssStyle="width:100%" name="outsideHistory.remark" maxlength="128"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							<s:button onclick="Upload('outsideHistory.otherResourceFile',otherResourceFileList)" value="上传附件"></s:button>
							<s:hidden name="outsideHistory.otherResourceFile"/>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="otherResourceFileList" align="center">
								<s:property escape="false" value="otherResourceFileList" />
							</div>							
						</td>
					</tr>
				</table>
<s:hidden name="outsideHistory.id"/>  
<s:hidden name="outsideHistory.objectId"/>
<s:hidden name="outsideHistory.createDepartmentCode"/>
<s:hidden name="outsideHistory.createPersonCode"/>
<s:hidden name="outsideHistory.createDate"/>
<s:submit value="保存"/>&nbsp&nbsp&nbsp&nbsp
<input type="button" name="back" value="返回" onclick="javascript:window.location='<s:url action="list"><s:param name="outsideHistory.objectId" value="%{outsideHistory.objectId}"/></s:url>'">
 </s:form>

</center>
</body>
</html>