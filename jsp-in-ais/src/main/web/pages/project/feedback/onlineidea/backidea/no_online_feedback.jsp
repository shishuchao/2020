<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<base target="_self"><!-- 注意：在模态窗口里面提交必须有这个 -->
	<head>

	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>填写反馈意见</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			<script type="text/javascript"	src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
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
	function String.prototype.Trim() {return this.replace(/(^\s*)|(\s*$)/g,"");}   //去掉前后空格
	 var issues_files="";
	/*
 	 *判断表单数据是否为空
 	 */
 	function checkForm(type){
 		var  feedback_user_name = document.form.feedback_user_name.value;
 		var  feedback_content = document.form.feedback_content.value;

 		if(feedback_user_name==null || feedback_user_name.Trim().length<=0){
			alert("请输入反馈人！");
			document.form.feedback_user_name.focus();
			return false;
		}
	 	if(feedback_content == null || feedback_content.Trim().length<=0){
			alert("请您输入反馈意见内容！");
			document.form.feedback_content.focus();
			return false;
		}
	 	//是否选择征求意见稿
		if(${processType=='report'}){
			if(!checkFile()){return false};
		} 
	 	document.getElementById("issues_files").value=issues_files;
		form.submit();
 	}
 	//是否选择征求意见稿
 	function checkFile(){

 		var len = document.getElementsByName("fileGUID").length;
 		for(var i=0;i<len; i++){
 			if(document.getElementsByName("fileGUID")[i].checked == true){
 				issues_files += document.getElementsByName("fileGUID")[i].value + ','; 
 			}
 		} 
 		issues_files = issues_files.substr(0, issues_files.length-1); 
 		if(issues_files==''){
 			 alert("请选择附件！"); 
 			 return false;
 		}
 		return true;
 		
 	}
 	/*
 	 *上传文件
 	 */
	function Upload(id,filelist){
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=online_feeback&table_guid&feedback_file&guid='+guid+'&&param='+rnm +'&&deletePermission=true&&upload_id=${userName}&&upload_name=${userName}',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
    if('${add}'==1){
        var pdoc = window.dialogArguments;
		if(pdoc!=undefined){
			pdoc.ref();
			window.close(); 
		}
    }
}
</script>
	</head>


	<body onUnload="myClose()" onload="closeSelf()">
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
					
					<tr >
						<td align="left" class="ListTableTr11">
					被审计单位:
						</td>
						<td class="ListTableTr22" align="right" >
							<s:select list="audit_objectMap" listKey="value" listValue="value" name="feedbackObject.feedback_unit_name"/>
						</td>
						<td align="left" class="ListTableTr11">
							<font color=red>*</font>反馈人:
						</td>
						<td class="ListTableTr22" align="right" >
					   		<s:textfield name="feedbackObject.feedback_user_name"  label="反馈人名称" id="feedback_user_name" maxlength="25"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" align="right">
							<font color=red>*</font>反馈意见內容:
							
						</td>
						<td class="ListTableTr22" colspan="3">
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
						<td class="ListTableTr11">
							<input type="button" name="planForm_0" value="上传附件" style="" 
 								onclick="Upload('feedbackObject.feedback_file',accelerys)">
 						</td>
						<td class="ListTableTr22" align="right" colspan="3">
							<s:hidden name="feedbackObject.feedback_file"  />	
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>
						</td>
					</tr>
				</table>
				<s:if test="${processType=='report'}">
				<table class="its">
					<tr class="listtablehead">
						<td colspan="5" align="left" class="edithead">
							附件选择列表
						</td>
					</tr>
				</table>
				<display:table id="row1" name="issuefilelist1" pagesize="10"
					class="its" requestURI="${contextPath}/project/feedback/online/viewAllidea.action">
					<display:column title="选择" media="html" headerClass="center"
						class="center"  >
						<input type="checkbox" name="fileGUID" value="${row1.file_id}"/>
					</display:column>
					<display:column title="附件名称" headerClass="center" class="center"
						 property="file_name" sortable="true"></display:column>
					<display:column title="上传人" headerClass="center" class="center"
						property="uploader_name"  sortable="true"></display:column>
					<display:column title="上传时间" headerClass="center" class="center"
						property="file_time" sortable="true"></display:column>
				</display:table>
			</s:if>
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
				
				<s:button value="保存" title="提交您所填写的反馈意见" onclick="checkForm('submit');" />
				<br><br>

				<div align="center">
				<s:if test="info!=null && info!=''">
					<font color="red" size="2">错误，上传附件是0字节，请重新上传！</font>
				</s:if>
				</div>
			<s:hidden name="feedbackObject.status" id="status" value="1"/> <!-- 默认为提交1 -->
			<s:hidden name="feedbackObject.issue_id" id="issue_id"/>
			<s:hidden name="feedbackObject.is_online" id="is_online" value="0"/>
			<s:hidden name="feedbackObject.project_id" id="issue_id" value="${project_id}"/>
			<s:hidden name="feedbackObject.processType" id="issue_id" value="${processType}"/>
			<s:hidden name="feedbackObject.file_name" id="file_name"/>
			<s:hidden name="feedback_ids" id="feedback_ids"/>
			<s:hidden name="issues_files" id="issues_files"></s:hidden>
			</s:form>

		</center>
	</body>
</html>
