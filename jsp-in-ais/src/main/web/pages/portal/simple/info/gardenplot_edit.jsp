<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>

<html>	
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title></title>
		<s:head />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		
		
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<!-- 长度验证 -->
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<!-- 上传附件 -->
		<script type="text/javascript" src="${contextPath}/scripts/swfload/uploadFile.js"></script>	
		
		<script language="javascript">
		String.prototype.gblen = function() {  
		    var len = 0;  
		    for (var i=0; i<this.length; i++) {  
		         if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {  
		             len += 2;  
		         } else {  
		             len ++;  
		         }  
		     }  
		     return len;  
		 }
		/*
		 * 添加
		 */
		function add(id){
			window.location.href = "${contextPath}/portal/simple/information/gardenPlotAdd.action?parent_id=" + id;
		}
		/*
		 * 保存
		 */
		function saveForm(){
			var bool = true;
			//非空校验
		 	bool=frmCheck(document.forms["myform"],'portalTab');
			//提交表单
			if(bool){
			var oEditor = FCKeditorAPI.GetInstance('studyGardenPlot.content'); 
			var msg = oEditor.GetXHTML( true );
			if(msg.gblen()>1200){
				alert("内容不能超过1000字符，现有"+msg.gblen()+"个字符！请考虑将内容存为word或者文本文件当做附件上传。");
				return false;
			}
			var flag=window.confirm('确认保存吗?');//isSubmit
			if(flag==true){			
			var url = "${contextPath}/portal/simple/information/gardenPlotSave.action";
			myform.action = url;
			myform.submit();v
			}else{
				 	return false;
				 }
			}
		}
		
		/*DWR2删除附件回传附件列表---LIHAIFENG 2007-12-20*/
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
		/*
		 * 打开上传
		 */
		function openDialog_file(){
		    //定义只能上传的附件格式"image/pjpeg";
		    var contextPath = '${contextPath}';
			var table_name = 'portal_studygardenplot';
			var table_guid = 'accessory';
			var guid = '${studyGardenPlot.accessory}';
			var deletePermission = 'true';
			var isEdit = 'true';
			var idName = 'accelerys';
			var title = '系统通知附件信息'
			var width = 500;
			var height = 450;
			uploadFile(contextPath,table_name,table_guid,guid,deletePermission,isEdit,idName,title,width,height);
		}
		//限定受众
		function changeIsAppoint(){
			var isAppoint = document.getElementsByName('studyGardenPlot.isAppoint')[0].checked;
			var pae1 = document.getElementById('appointTD1');
			var pae2 = document.getElementById('appointTD2');
			
			changeDisabledStatus(pae1,isAppoint);
			changeDisabledStatus(pae2,isAppoint);
			if(isAppoint){
				pae1.parentElement.style.display = '';
				pae2.parentElement.style.display = '';
			}else{
				pae1.parentElement.style.display = 'none';
				pae2.parentElement.style.display = 'none';
			}
		}
		//更改限定受众的状态
		function changeDisabledStatus(pae,isAppoint){
			for(var i=0;i<pae.childNodes.length;i++){
				if(pae.childNodes[i].nodeName=='IMG'||pae.childNodes[i].nodeName=='INPUT'){
					if(isAppoint){
						pae.childNodes[i].disabled = false;
					}else{
						pae.childNodes[i].disabled = true;
					}
				}
			}
		}
	</script>
	</head>
	<body onload="changeIsAppoint()" class="easyui-layout">
		<center>
			<s:form id="myform" name="myform" action="/portal/simple/information/gardenPlotSave.action" enctype="multipart/form-data" method="post">
				<table id="portalTab" cellpadding=0 cellspacing=0 border=0 
					class="ListTable">
					<tr >
						<td   class="EditHead"   style="width:20%" nowrap="nowrap">
							<font color="red">*</font>&nbsp;标题
						</td>
						<td  class="editTd" style="width:30%" nowrap="nowrap">
							<s:textfield cssClass="noborder" name="studyGardenPlot.title" maxlength="50"/>
						</td>
						<td   class="EditHead" style="width:20%" nowrap="nowrap">
							<font color="red">*</font>&nbsp;关键字
						</td>
						<td class="editTd" style="width:30%" nowrap="nowrap">
							<s:textfield cssClass="noborder" name="studyGardenPlot.keyword" maxlength="50"/>
						</td>
					</tr>
					<tr >
						<td class="EditHead" >限定受众
						</td>
						<td class="editTd" colspan="3">
							<s:checkbox name="studyGardenPlot.isAppoint" onclick="changeIsAppoint()"></s:checkbox>
							<font color="blue">选中限定受众，使发布的信息只能被选择的对象浏览！</font>
						</td>
					</tr>	
					<tr >
						<td  class="EditHead" style="width:20%" nowrap="nowrap">
							限定受众-个人
						</td>
						<td  class="editTd" style="width:30%" id="appointTD1" valign="center" colspan="3">
							<s:buttonText
								name="studyGardenPlot.acceptorString.userNames" cssClass="noborder"
								doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=studyGardenPlot.acceptorString.userNames&paraid=studyGardenPlot.acceptorString.users&p_issel=1',600,350)" 
								doubleSrc="/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" 
								readonly="true" 
								doubleDisabled="false" size="60"/>
							<s:hidden name="studyGardenPlot.acceptorString.users"></s:hidden>
						</td>
					</tr>				
					<tr >
						<td class="EditHead" style="width:20%" nowrap="nowrap">
							限定受众-部门
						</td>
						<td class="editTd" style="width:30%" id="appointTD2" valign="center" colspan="3">
							
							<s:buttonText  cssClass="noborder"
								name="studyGardenPlot.acceptorString.orgNames" 
								doubleOnclick="showPopWin('/pages/system/search/searchdatamuti.jsp?url=/system/uSystemAction!orgList4muti.action&paraname=studyGardenPlot.acceptorString.orgNames&paraid=studyGardenPlot.acceptorString.orgs',600,350)" 
								doubleSrc="/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" 
								readonly="true" 
								doubleDisabled="false" size="60"/>
							<s:hidden name="studyGardenPlot.acceptorString.orgs"></s:hidden>
						</td>
					</tr>
					<tr >
						<td class="EditHead" colspan="4" style="text-align: center;">
							内容
						</td>
					</tr>
					<tr >
						<td class="editTd" colspan="4" style="width:100%">
						<FCK:editor id="studyGardenPlot.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="cnn2" tabSpaces="1"
							imageBrowserURL=" /ais/resources/fckedit/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/ais/editor/filemanager/browser/default/connectors/jsp/connector" 
							linkBrowserURL=" /ais/resources/fckedit/editor/filemanager/browser/default/browser.html?Connector=/ais/editor/filemanager/browser/default/connectors/jsp/connector" 
							linkUploadURL=" /ais/editor/filemanager/upload/simpleuploader?Type=Image"
							imageUploadURL=" /ais/editor/filemanager/upload/simpleuploader?Type=Image">
								${studyGardenPlot.content}
						</FCK:editor>
						</td>
					</tr>
				</table>
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList"/>
				</div>
				<s:hidden name="studyGardenPlot.id"></s:hidden>
				<s:hidden name="studyGardenPlot.parent_id"></s:hidden>
				<s:hidden name="studyGardenPlot.accessory"></s:hidden>
				<s:hidden name="studyGardenPlot.company_id"></s:hidden>
				<s:hidden name="studyGardenPlot.company_name"></s:hidden>
				<s:hidden name="studyGardenPlot.department_id"></s:hidden>
				<s:hidden name="studyGardenPlot.department_name"></s:hidden>
				<s:hidden name="studyGardenPlot.creator_code"></s:hidden>
				<s:hidden name="studyGardenPlot.creator_name"></s:hidden>
				<s:hidden name="studyGardenPlot.create_date"></s:hidden>
				<s:hidden name="studyGardenPlot.ispub"></s:hidden>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="openDialog_file()" >上传附件</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();" >保存</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='${contextPath}/portal/simple/information/gardenPlotList.action?studyGardenPlot.parent_id=${studyGardenPlot.parent_id}&studyGardenPlot.company_id=${studyGardenPlot.company_id}'" >返回</a>
			</s:form>
				
		</center>
	</body>
</html>
