<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
	<!-- 注意：在模态窗口里面提交必须有这个 -->
    
    <title>征求意见稿附件</title>
    
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<!--  引入DWR包 -->
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>	
		
  </head>
  <script type="text/javascript">
  /*
   * 保存征求意见稿
   */		
  function saveIssueFile(){
  		//非空验证
  		var feedback_unit = document.getElementsByName('feedback_unit')[0].value;
  		var guid = document.getElementsByName('guid')[0].value;
  
  		if(feedback_unit==null||feedback_unit ==''){
  			alert("请选择被审计单位!");
  			return;
  		}
  		if(guid==null||guid ==''){
  			alert("请上传征求意见稿!");
  			return;
  		}
 		
		DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/project/feedback/online', action:'saveIssueFile', executeResult:'false' },
		{'project_id':'${project_id}', 'processType':'${processType}','feedback_unit':feedback_unit,'guid':guid},
		xxx1
		);
  }
  function xxx1(data){
	if(data['flag'] == "true"){
		window.alert("保存成功！");
	 	window.returnValue="OK";
	 	window.close();
	}else if(data['flag'] == "upload"){
		window.alert("请上传征求意见稿附件！");
	}else {
		window.alert("保存失败！");
	}
  }
   /*
	*   删除附件
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
	*上传附件
	*/
	function Upload(id,filelist){
	
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=online_issue&table_guid=issue_file&guid=<s:property value="guid"/>&&param='
						+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
  </script>
  <body>
    <s:form action="" method="post" name="issueObject">
	 	<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
						class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="center" class="edithead">
					&nbsp;征求意见稿
				</td>
			</tr>
			<tr class="listtablehead">
				<td align="right" style="width:10%;" class="ListTableTr11">
					<font color="red">*</font>&nbsp;被审计单位
				</td>
				<td  class="ListTableTr1" style="width:40%;">
				 	<s:select list="audit_objectMap" listKey="key" listValue="value" name="feedback_unit"/>
				</td>	
				<td align="right" style="width:10%;" class="ListTableTr11">
					<font color="red">*</font>&nbsp;附件上传人
				</td>
				<td align="left" style="width:40%;" class="ListTableTr1">
					<s:textfield name="uploader_name" readonly="true"/>
				</td>																							
			</tr>
			
			<tr>
				<td align="right" width="11%" class="ListTableTr1">
					<s:button 
						disabled="!(varMap['uploadw_fileWrite']==null?true:varMap['uploadw_fileWrite'])"
						display="${varMap['uploadw_fileRead']}" 
						onclick="Upload('guid',accelerys)" value="上传征求意见稿" />
					<s:hidden name="guid" />
				</td>	
				<td align="right" width="11%" colspan="3" class="ListTableTr1">
					<div id="accelerys" align="center">
						<s:property escape="false" value="accessoryList"/>
					</div>
				</td>
			</tr>
			<tr align="right">
				<td align="center" width="11%" class="ListTableTr1" colspan="4" style="text-align: center">
					<s:button value="保 存" onclick="saveIssueFile()"/>
					<s:button onclick="window.close()" value="返 回"/>
				</td>	
			</tr>
		</table>
	</s:form>
  </body>
</html>
