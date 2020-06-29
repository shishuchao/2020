<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<base target="_self"><!-- 注意：在模态窗口里面提交必须有这个 -->
	<head>

	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>填写反馈意见</title>
		
		
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<!-- 长度验证 -->
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
	<script type="text/javascript">
 	/*
 	 *判断表单数据是否为空
 	 */
 	function checkForm(type){
	 	if(document.form.feedback_content.value.length <= 0 || document.form.feedback_content.value == null ){
			alert("请您输入反馈意见内容！");
			document.form.feedback_content.focus();
			return false;
		}	
		if(type=='submit'){
		 	if(confirm('请注意，提交后将不能修改和删除！')){
			 	 document.form.status.value='1';
		         form.submit();
		 	}else{
		 		return false;//取消提交
		 	}
	 	}
	 	if(type=='save'){
	 		document.form.status.value='2';
		 	form.submit();
	 	}
 	}
 	/*
 	 *上传文件
 	 */
	function Upload(id,filelist){
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('/ais/commons/file/welcome.action?table_name=online_feeback&table_guid=feedback_file&guid='+guid+'&&param='+rnm +'&&deletePermission=true&&upload_id=${userName}&&upload_name=${userName}',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		//parent.setAutoHeight();
	}
	/*
	1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
	2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
		getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
	*/
	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true){
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
				xxx);
			function xxx(data){
			  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
			} 
		}
	}	
	
/*
 * 刷新父页面
 */
function myClose(){
	var pdoc = window.dialogArguments;
	if(pdoc!=undefined){
		pdoc.ref(); 
	}
}
/*
 *关闭自己
 */
function closeSelf(){
    if('${issue_id}'==''){
        var pdoc = window.dialogArguments;
		if(pdoc!=undefined){
			pdoc.ref();
			window.close(); 
		}
    }
}
</script>
	</head>


	<body onUnload="myClose()"; onload="closeSelf()">
		<center>
		<s:form action="saveFeedbackIdea" method="POST" namespace="/project/feedback/online"  name="form"
			enctype="multipart/form-data">


				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="left" class="edithead">
							&nbsp;请填写反馈意见
						</td>
					</tr>
					
					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
					被审计单位:
						</td>
						<td class="listtabletr2" align="right" >
						<s:textfield name="feedbackObject.feedback_unit_name" readonly="true" size="50"/>
						</td>
					<td align="left" class="listtabletr1">
					反馈人:
						</td>
						<td class="listtabletr2" align="right" >
					    <s:textfield name="feedbackObject.feedback_user_name"  readonly="true"/>
						</td>
					</tr>
					<tr class="listtablehead">
						<td class="listtabletr2" align="right" colspan="4">
							<font color=red>*</font>反馈意见內容:
							<s:if test="feedbackObject.feedback_id !=null && feedbackObject.feedback_id != ''">
								<s:textarea name="feedbackObject.feedback_content"
									cssStyle="width:100%;height:100;overflow-y:visible"
									id="feedback_content"  disabled="false" />
								<input type="hidden" id="feedbackObject.feedback_content.maxlength" value="500">
							</s:if>
							<s:else>
								<s:textarea name="feedbackObject.feedback_content"
								cssStyle="width:100%;height:100;overflow-y:visible"
								id="feedback_content" />
								<input type="hidden" id="feedbackObject.feedback_content.maxlength" value="500">
							</s:else>	
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							<input type="button" name="planForm_0" value="上传附件" style="" 
 								onclick="Upload('feedbackObject.feedback_file',accelerys)">
 						</td>
						<td class="listtabletr2" align="right" colspan="3">
							<s:hidden name="feedbackObject.feedback_file"  />	
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>
						</td>
					</tr>
				</table>

				<!--新添加的四个字段  -->	
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="7" align="center" class="edithead">
							&nbsp;选择反馈意见方式
						</td>
					</tr>
					
					<tr class="listtablehead">
						<td align="right" width="11%" class="ListTableTr1">
							是否有纸质:
						</td>
						<td class="ListTableTr2" width="17%"  align="left">
							<s:radio name="feedbackObject.is_paper" list="#@java.util.LinkedHashMap@{'true':'是','false':'否'}" />
						</td>
						<td align="right" width="11%" class="ListTableTr1">
							电子意见与纸质意见是否相符:
						</td>
						<td class="ListTableTr2" width="18%" align="left">
						    <s:radio name="feedbackObject.paper_elec_match" list="#@java.util.LinkedHashMap@{'true':'是','false':'否'}"/> 
						</td>
					     <td align="right" width="11%" class="ListTableTr1">
							纸质反馈意见是否盖章签字
						</td>
						<td class="ListTableTr2"  width="20%" align="left">
							<s:radio name="feedbackObject.paper_seal" list="#@java.util.LinkedHashMap@{'true':'是','false':'否'}" />
						</td>
					</tr>
				</table>
				
				<s:button value="保 存" title="保存提交您所填写的反馈意见" onclick="checkForm('save');" />
									&nbsp;&nbsp;
				<s:button value="提 交" title="确认提交您所填写的反馈意见" onclick="checkForm('submit');" />
				<br><br>

				<div align="center">
				<s:if test="info!=null && info!=''">
				<font color="red" size="2">错误，上传附件是0字节，请重新上传！</font>
				</s:if>
				<s:else>
					<font color="red" size="2">*特别提示: 请确认反馈意见无误,提交后将不能修改和删除!</font>
				</s:else>
				</div>
			<s:hidden name="feedbackObject.status" id="status"/>
			<s:hidden name="feedbackObject.is_online" id="is_online" value="1"/>
			<s:hidden name="feedbackObject.issue_id" id="issue_id"/>
			<s:hidden name="feedback_ids" id="feedback_ids"/>
			<s:hidden name="feedbackObject.processType" id="processType"/>
			<s:hidden name="feedbackObject.project_id" id="feedback_ids"/>
			<s:hidden name="feedbackObject.feedback_user" id="feedback_user"/>
			<s:hidden name="feedbackObject.file_name" id="file_name"/>
			</s:form>

		</center>
	</body>
</html>
