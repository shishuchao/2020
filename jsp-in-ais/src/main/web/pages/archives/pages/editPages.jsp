<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<base target="_self">
	<!-- 注意：在模态窗口里面提交必须有这个 -->

	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>文书档案编辑</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

		<script type="text/javascript">
		
		//检验是否是数字
function isNumber(oNum)
   {
  if(!oNum) return false;
  var strP=/^\d+(\.\d+)?$/;
  if(!strP.test(oNum)) return false;
  try{
  if(parseFloat(oNum)!=oNum) return false;
  }
  catch(ex)
  {
   return false;
  }
  return true;
   }
   
   
function saveInfo(t1){

	var pages_code = document.getElementsByName("archivesPagesObject.pages_code")[0].value;//文书编号
	var pages_name = document.getElementsByName("archivesPagesObject.pages_name")[0].value;//文书名称
	
	
	if(pages_code==null || pages_code==""){
	alert("请填写文书编号!");
	return false;
	}
	if(pages_name==0 || pages_name==null){
	alert("请填写文书名称!");
	return false;
	}
	
	var pages_year = document.getElementsByName("archivesPagesObject.pages_year")[0].value;//文书保存期限
	if(pages_year != null || pages_year !=""){
	var bool =  isNumber(pages_year);
	 if(!bool){
	 alert("文书档案保存年度必须是数字！");
	 document.getElementsByName('archivesPagesObject.pages_year')[0].focus();
	 return false;
	 }
	}else{
	alert("请填写文书保存年限!");
	return false;
	}
	
	var send_depId = document.getElementsByName("archivesPagesObject.send_depId")[0].value;
	if(send_depId==null || send_depId==""){
	alert("请选择发文单位!");
	return false;
	}
	
	var pages_kinds = document.getElementById("pages_kind");
	var pages_kind
	for(var i=0;i<pages_kinds.options.length;i++){
		if(pages_kinds.options[i].selected)
			pages_kind=pages_kinds.options[i].value;
	}
	if(pages_kind==null || pages_kind==''){
		alert("请选择文书类型！");
		return false;
	}
	document.getElementsByName("archivesPagesObject.pages_return")[0].value = t1;
	
	myform.submit();
}


function returnBackWindows(){
var pages_type = '<s:property value="pages_type" />';
var url = "${contextPath}/archives/pages/listPages.action?pages_type="+pages_type;
window.location = url;
}




//附件操作
//上传附件
function Upload()
{
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
	window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_archives_pages&table_guid=receive_guid&guid=<s:property value="archivesPagesObject.receive_guid"/>&&param='+rnm+'&&deletePermission=true&&isEdit=true&&title='+encodeURI(encodeURI("发文附件信息")),accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
}
//删除附件
	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true)
		{
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

		</script>

	</head>

	<body>

		<center>

			<table width="100%">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						添加收文文书
					</td>
				</tr>
			</table>
			<s:form action="savePages"
				namespace="/archives/pages"  name="myform">

			<%@include
				file="/pages/archives/pages/public_top.jsp"%>
		<center>
<br>
&nbsp;&nbsp;&nbsp;
<div id="accelerys" align="left"
							style="margin-left: 10px">
							<s:property escape="false" value="accessoryList" />
						</div>
						<div align="right">
							<s:button  onclick="Upload()" value="上传收文文件"></s:button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<br>
				<br>
				</center>

			<%@include
				file="/pages/archives/pages/public_bottom.jsp"%>

<!-- 隐藏字段 -->
				<s:hidden name="pages_type" />
				<s:hidden name="archivesPagesObject.pages_return"/>
	            <s:hidden name="archivesPagesObject.receive_guid"></s:hidden>
			</s:form>
		</center>
	</body>
</html>




