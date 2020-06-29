/*
 *功能：附件上传
 * contextPath：文件部署路径
 * table_name：上传附件关联业务表的表名称
 * table_guid：业务表中关联附件表的字段名称
 * guid：业务表关联附件表的id值
 * deletePermission：上传附件是否有删除权限 （true/false）
 * isEdit： 上传附件是否有编辑权限 （true/false）并且只有office使用金格控件的才可以真的能编辑
 * idName： 业务页面中显示附件列表div的id名称
 * title：  上传附件页面显示的标题
 */
function uploadFile(contextPath,table_name,table_guid,guid,deletePermission,isEdit,idName,title,width,height){
	//var urlstr = contextPath + '/commons/file/welcome.action&table_name=' + table_name + '&' 
	//				+ 'table_guid=' + table_guid + '&guid=' + guid 
	//				+ '&deletePermission=' + deletePermission + '&isEdit=' + isEdit + '&'  
	//				+ 'accelerys=' + idName;
	//showPopWin(contextPath + '/pages/commons/file/fileupload/fileUpload.jsp?url='+urlstr,width,height,title);
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
	var urlstr = contextPath + '/commons/file/welcome.action?table_name=' + table_name + '&' 
					+ 'table_guid=' + table_guid + '&guid=' + guid + '&param='+rnm 
					+ '&deletePermission=' + deletePermission + '&isEdit=' + isEdit 
					+ '&title=' + encodeURIComponent(encodeURIComponent(title)) + '&accelerys=' + idName;
	//window.open(urlstr,idName,'dialogWidth:700px;dialogHeight:450px;status:yes');
	window.showModalDialog(urlstr,idName,'dialogWidth:700px;dialogHeight:450px;status:yes');
}

/**
 * 功能：上传被审计资料模板
 */
 
 function uploadFileModel(contextPath,aaid,deletePermission,isEdit,idName,width,height,title){
	var urlstr = contextPath + '/auditAccessoryList/welcome.action&table_name=AUDIT_ACCESSORYLIST&aaid=' 
					+ aaid 
					+ '&deletePermission=' + deletePermission + '&isEdit=' + isEdit + '&'  
					+ 'idName=' + idName;
	showPopWin(contextPath + '/pages/commons/file/fileupload/fileUpload.jsp?url='+urlstr,width,height,"模板");
 }
 /**
  * 功能：上传被审计单位资料
  */
  
  function uploadFileResource(contextPath,aaid,deletePermission,isEdit,idName,width,height,title,templateGuid,operateAuth){
	var urlstr = contextPath + '/auditAccessoryList/welcomeUpload.action&table_name=AUDIT_ACCESSORYLIST&aaid=' 
					+ aaid 
					+ '&deletePermission=' + deletePermission + '&isEdit=' + isEdit + '&'  
					+ 'idName=' + idName+'&templateGuid=' + templateGuid+"&operateAuth="+operateAuth;
	showPopWin(contextPath + '/pages/commons/file/fileupload/fileUpload.jsp?url='+urlstr,width,height,"附件");
}