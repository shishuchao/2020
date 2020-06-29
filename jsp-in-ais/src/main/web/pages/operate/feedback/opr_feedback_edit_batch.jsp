<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<s:text id="title" name="'审计底稿反馈意见'"></s:text>



<html>
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script language="javascript">
	
	//关闭窗口
	function closeGenM(){
	 window.parent.closeGenW('MS');
	 window.close()
	}

 

 

	//模板生成----------保存表单
	function saveForm(){
	 
	    if( !check()){
	        return false;
	     }  
		var flag=window.confirm('确认保存吗?');//isSubmit	
		if(flag==true){
		var url = "${contextPath}/operate/feedback/saveFeedbackBatch.action";
		document.getElementById("saveFormFX").disabled=true;
		myform.action = url;
		myform.submit();
		}
	}
 

	//返回上级list页面
	function backList(){
		location.href = "${contextPath}/operate/feedback/feedbackManu.action";
	 
	}


			
				
				
   //上传附件
	function Upload(id,filelist,delete_flag,edit_flag)
		{
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=feedback_info_operate&table_guid=file_id&guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}

 
 		
 		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
      function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true)
		{
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
		{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
		xxx);
		function xxx(data){
		  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
		} 
		}
	}
	
	//校验
	function check(){

		var v_3 = "audFeedbackInfo.feedback_content";  // field
		var title_3 = '反馈内容';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
			alert("反馈内容的长度不能大于2000字！");
			document.getElementById(v_3).focus();
			return false;
		} 
		return true;
	}
</script>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/js/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>





	</head>



	<body>
		<center>


			<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/doubt" method="post">
				<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />

					</td>
				</tr>
			</table>

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="titletable1">
						<td width="20%">

							<font color="red"></font>&nbsp;&nbsp;&nbsp;反馈人所在部门:
						</td>
						<!--标题栏-->
						<td width="30%">
							<s:property value="audFeedbackInfo.feedback_dept_name" />
							<s:hidden name="audFeedbackInfo.feedback_dept_code" />
							<s:hidden name="audFeedbackInfo.feedback_dept_name" />

						</td>

						<td width="20%">

							<font color="red"></font>&nbsp;&nbsp;&nbsp;底稿反馈人:
						</td>
						<td width="30%">
							<s:property value="audFeedbackInfo.feedback_author_name" />
							<s:hidden name="audFeedbackInfo.feedback_author_code" />
							<s:hidden name="audFeedbackInfo.feedback_author_name" />
						</td>
					</tr>



					<tr class="titletable1">


						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;底稿反馈日期:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="audFeedbackInfo.feedback_date" />
							<s:hidden name="audFeedbackInfo.feedback_date" />
							<!--一般文本框-->

						</td>

						<td>


						</td>
						<!--标题栏-->
						<td>
						</td>

					</tr>



					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;反馈内容<font color="red">(2000)</font>:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<s:textarea name="audFeedbackInfo.feedback_content"
								cssStyle="width:100%;height:100;" />

						</td>
					</tr>



					<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
					<tr>
						<td class="ListTableTr11">
							<s:button
								onclick="Upload('audFeedbackInfo.file_id',file_idList,'true','true')"
								value="上传附件"></s:button>
							<s:hidden name="audFeedbackInfo.file_id" />
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="file_idList" align="center">
								<s:property escape="false" value="file_idList" />
							</div>

						</td>
					</tr>
					<s:hidden name="ms_id" />
					<s:hidden name="audFeedbackInfo.ms_id" />
					<s:hidden name="audFeedbackInfo.id" />
					<s:hidden name="manuIds" />
					<s:hidden name="feed_id" />
					<s:hidden name="feed_id_batch" /> 






				</table>


				<div align="right">
					<s:button value="保存" id="saveFormFX" onclick="saveForm();" />
					&nbsp;&nbsp;
					<input type="button" value="返回" onclick="backList()" />
					&nbsp;&nbsp;&nbsp;
				</div>
			</s:form>

		</center>
	</body>
</html>
