
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<script type='text/javascript'
	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript'
	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
<!-- 长度验证 -->
<script type="text/javascript"
	src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>		
<s:if test="${param.isnew == true}">
	<s:text id="title" name="'计划管理--增加个人计划'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'计划管理--修改个人计划'"></s:text>
</s:else>

<html>
	<script language="javascript">
	function change(){
		var isNeed = document.getElementsByName("personalProgramme.isRemind")[0].value;
		if('Y' == isNeed){
			document.getElementById("notNeedRemind").style.display="none";
			document.getElementById("needRemind").style.display="block";
		}else{
			document.getElementById("needRemind").style.display="none";
			document.getElementById("notNeedRemind").style.display="block";
			document.getElementsByName("personalProgramme.remindTime")[0].value="";
		}
	}
	
	function backList(){
		document.location = "${contextPath}/plan/personalprogramme/list.action";
	}
	
	//模板生成----------保存表单
	function saveForm(){
 		//if(frmCheck(document.forms[0],'tab1')){
	 		var flag=window.confirm('确认操作吗?');//isSubmit
	 		vardate1=document.getElementsByName("personalProgramme.startTime")[0].value;
	 		vardate2=document.getElementsByName("personalProgramme.endTime")[0].value;  
	 		
	 		if(compareDate(vardate1 , vardate2)){
	 			alert("结束时间不能早于开始时间！");
	 			return false;
	 		}
			if(flag==true){
				var url = "${contextPath}/plan/personalprogramme/save.action";
				myform.action = url;
				myform.submit();
		 	}else{
		 		return false;
	 		}
		//}
		
	}
	function compareDate(DateOne,DateTwo){
		if(DateTwo.length<1||DateOne.length<1) return false;
		var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ("-"));
		var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ("-")+1);
		var OneYear = DateOne.substring(0,DateOne.indexOf ("-"));
		
		var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ("-"));
		var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ("-")+1);
		var TwoYear = DateTwo.substring(0,DateTwo.indexOf ("-"));
		
		if (Date.parse(OneMonth+"/"+OneDay+"/"+OneYear) >
		Date.parse(TwoMonth+"/"+TwoDay+"/"+TwoYear))
		{
		return true;
		}
		else
		{
		return false;
		}
	}
				
				
   //上传附件
	function Upload(id,filelist,delete_flag,edit_flag)
		{
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_persp&talbe_guid=fjid&guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
 				window.alert("删除成功");
 				}else{
 					window.alert("所请求的页面有异常");
 					}
 					}
 		}
 		
 		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.commons.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
          
 		
 		/*
		* 删除附件
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

</script>
	
	<head>
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>
	<body onload="change()">
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						&nbsp;
						<s:property value="#title" />
					</td>
				</tr>
			</table>

			<s:form id="myform" action="save"
				namespace="/plan/personalProgramme/personalProgramme">

				<table id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
					<tr class="ListTableTr1" width="20%">
						<td>
							标题:
						</td>
						<td class="ListTableTr2">
							<s:textfield name="personalProgramme.title" cssStyle="width:300px" maxlength="50"/>
						</td>
					</tr>
					<tr class="ListTableTr1" width="20%">
						<td>
							开始时间:
						</td>
						<td class="ListTableTr2">
							<s:textfield id="startTime" name="personalProgramme.startTime"
								readonly="true" cssStyle="width:90%" 
								title="单击选择日期"
								onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"
								cssStyle="width:300px" maxlength="100"/>
						</td>
					</tr>
					<tr class="ListTableTr1" width="20%">
						<td>
							结束时间:
						</td>
						<td class="ListTableTr2">
							<s:textfield id="endTime" name="personalProgramme.endTime"
								readonly="true" cssStyle="width:90%"
								title="单击选择日期"
								onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"
								cssStyle="width:300px" maxlength="100"/>
						</td>
					</tr>

					<tr class="ListTableTr1" width="20%">
						<td>
							(手工录入)参与人:
						</td>
						<td class="ListTableTr2">
							<s:textfield name="personalProgramme.parter" cssStyle="width:300px" maxlength="50"/>
						</td>
					</tr>

					<tr class="ListTableTr1">
						<td>
							是否提醒:
						</td>
						<td class="ListTableTr2">
							<s:select name="personalProgramme.isRemind" emptyOption="true"
								list="#@java.util.LinkedHashMap@{'Y':'是','N':'否'}"
								disabled="false" theme="ufaud_simple"
								templateDir="/strutsTemplate" cssStyle="width:150px" onchange="change()"/>
						</td>
					</tr>
					
					<tr class="ListTableTr1" width="20%">
						<td>
							提醒时间:
						</td>
						<td id="needRemind" class="ListTableTr2" style="display: block">
							<s:textfield id="endTime" name="personalProgramme.remindTime"
								readonly="true" cssStyle="width:90%" maxlength="15"
								title="单击选择日期"
								onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"
								cssStyle="width:300px" maxlength="100"/>
						</td>
						<td id="notNeedRemind" class="ListTableTr2" style="display: none">
							
						</td>
					</tr>


					<tr class="ListTableTr1" width="20%">
						<td>
							计划内容:
							<font color="red">(最多500字)</font>
						</td>
						<td class="ListTableTr2">
							<s:textarea name="personalProgramme.programmeContent"
								cssStyle="width:70%" />
							<input type="hidden" id="personalProgramme.programmeContent.maxlength" value="500">
						</td>
					</tr>

				</table>
				<div id="buttonDiv" align="right" style="width: 97%">
					<div id="accelerys" align="center">
						<s:property escape="false" value="accessoryList" />
					</div>
					<s:button onclick="Upload('personalProgramme.fjid',accelerys,true)"
						value="上传附件"></s:button>
					<s:hidden name="personalProgramme.fjid"></s:hidden>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<s:if test="${param.isnew!=true}">
						<s:hidden name="personalProgramme.id" />
						<s:hidden name="personalProgramme.saveTime" />
					</s:if>
					<s:button value="保 存" onclick="saveForm();" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<s:button value="返回列表" onclick="backList();"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</s:form>

		</center>
	</body>
</html>
