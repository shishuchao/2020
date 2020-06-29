<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>方案维护：总体方案查看</title>
		
		<style type='text/css'>
			textarea { border-width:0px}
		</style>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		
		});
	</script>
	<script language="javascript">
	 //生成
      function generateType()
		  {
		   
		     title="增加类别";
		     window.paramw = "模态窗口";
             //window.showModalDialog('${contextPath}/operate/template/addType.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //window.open('${contextPath}/operate/template/addType.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>');
		     showPopWin('${contextPath}/operate/template/addType.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',720,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();&type="+type+"&taskPid="+taskPid+"&taskTemplateId="+id+"&audTemplateId=08BCD152-16D0-2750-3EEB-BC30571F3622";
	                    
	} 
	function generateLeaf()
		  {
		     title="审计事项";
		     window.paramw = "模态窗口";
             //window.open('${contextPath}/operate/template/addLeaf.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>');
		     showPopWin('${contextPath}/operate/template/addLeaf.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',720,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
	} 
	 //删除
      function deleteRecord()
		  {
		  	if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/doubt/delete.action";
	            myform.submit();
	      }
	                    
	} 
	function exe(){
		if (confirm("是否设置为已处理状态?")) {
		document.getElementsByName("audTemplate.doubt_status")[0].value="050"
		//audTemplate.doubt_status
	         saveForm();
         }else{
	 
         } 
	}
	function law(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	
	function regu(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
             
function backList(){
	myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&pro_id=${pro_id}";
	myform.submit();
}



//模板生成----------保存表单
function saveForm(){
var url = "${contextPath}/operate/doubt/save.action";
myform.action = url;
	myform.submit();
	
	 
}

//模板生成----------保存表单
function saveFormRoot(){
var v_3 = "audTemplate.templateName";  // field
var title_3 = '模板名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }
var url = "${contextPath}/operate/template/saveRoot.action";
myform.action = url;
	myform.submit();
	//parent.location.href='${contextPath}/operate/template/main.action?audTemplateId='+<%=request.getParameter("audTemplateId")%>;
	window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>';
	//alert(window.top.frames['f_left']);
	 
}


function saveForm1(){
var bool = true;//提交表单判断参数
//非空校验
 

	
 
	
 
	
var v_3 = "doubt.course_title";  // field
var title_3 = '课程名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }


var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

var v_3 = "doubt.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

	
	//保存表单
	if(bool){
	var flag=window.confirm('确认操作吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/mng/doubt/save.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}




			
				
				
   //上传附件
	function Upload(id,filelist,delete_flag,edit_flag)
		{
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
</script>
	</head>
	<body class="easyui-layout" style="overflow-y:auto;" fit='true' border='0'>
		<center>
			<s:form id="myform" onsubmit="return true;" action="view" method="post">
				<table cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center" >
				
					<s:if test="${interCtrl == 'true'}">
						<tr>
							<td class="EditHead" style="width:15%;">方案名称</td>
							<td class="editTd" style="width:35%;">${audTemplate.templateName}</td>
							<td class="EditHead" style="width:15%;">方案版本</td>
							<td class="editTd" style="width:35%;">${audTemplate.proVer}</td>
						</tr>
						<tr>
							<td class="EditHead">编制日期</td>
							<td class="editTd">${audTemplate.proDate}</td>
							<td class="EditHead">编制人</td>
							<td class="editTd">${audTemplate.proAuthorName}</td>
						</tr>	
						<tr>
							<td class="EditHead">类别名称</td>
							<td class="editTd">${audTemplate.typeName}</td>
							<td class="EditHead">所属单位</td>
							<td class="editTd">${audTemplate.atCompany}</td>
						</tr>
					</s:if>
					<s:else>
						<tr>
							<td class="EditHead">审计方案名称</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="audTemplate.templateName" cssStyle='border:0;width:100%' readonly="true"/>
							</td>
							<td class="EditHead">方案版本</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="audTemplate.proVer" cssStyle='border:0;' readonly="true"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">类别名称</td>
							<td class="editTd">
								<s:property value="audTemplate.typeName"/>
							</td>
							<td class="EditHead">子类名称</td>
							<td class="editTd">
								<s:property value="audTemplate.typeName2"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">编制日期</td>
							<td class="editTd">
								<s:property value="audTemplate.proDate"/>
								<s:hidden name="audTemplate.proDate"/>
							</td>
							<td class="EditHead">编制人</td>
							<td class="editTd">
								<s:property value="audTemplate.proAuthorName"/>（<s:property value='audTemplate.atCompany'/>）
								<s:hidden name="audTemplate.proAuthorCode"/>
								<s:hidden name="audTemplate.proAuthorName"/>
								<s:hidden name="audTemplate.atCompany"/>
								<s:hidden name="audTemplate.atCompanyCode"/>
							</td>
						</tr>
					
					</s:else>
				
				



					<tr class='audit'>
						<td class="EditHead">基本情况</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTemplate.auditDeptInfo" cssStyle="width:100%;height:80px;overflow-y:hidden" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">审计目标和范围</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTemplate.auditTarget" cssStyle="width:100%;height:80px;overflow-y:hidden" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">审计内容和重点</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTemplate.pointContent" cssStyle="width:100%;height:80px;overflow-y:hidden" readonly="true"/>
						</td>
					</tr>

					<tr class='audit'>
						<td class="EditHead">组织分工</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTemplate.people_work" cssStyle="width:100%;height:80px;overflow-y:hidden" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">对专家和外部审计<br>工作结果的利用</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTemplate.procedures" cssStyle="width:100%;height:80px;overflow-y:hidden" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">其他事项</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTemplate.other" cssStyle="width:100%;height:80px;overflow-y:hidden" readonly="true"/>
						</td>
					</tr>
					
					
					<tr class='interCtrl'>
						<td class="EditHead">评价依据</br><font color="darkgray">(限2000字)</font></td>
						<td class="editTd" colspan="3">
							<textarea id="evaBasis_ue" style='height:60px;width:99%;'>${audTemplate.evaBasis}</textarea>
							<s:hidden name="audTemplate.evaBasis" id="evaBasis_value"></s:hidden>
						</td>
					</tr>
					<tr class='interCtrl'>
						<td class="EditHead">评价范围</br><font color="darkgray">(限2000字)</font></td>
						<td class="editTd" colspan="3">
							<textarea id="evaScope_ue" style='height:60px;width:99%;'>${audTemplate.evaScope}</textarea>
							<s:hidden name="audTemplate.evaScope" id="evaScope_value"></s:hidden>
						</td>
					</tr>
					<tr class='interCtrl'>
						<td class="EditHead">评价方式</br><font color="darkgray">(限2000字)</font></td>
						<td class="editTd" colspan="3">
							<textarea id="evaMethod_ue" style='height:60px;width:99%;'>${audTemplate.evaMethod}</textarea>
							<s:hidden name="audTemplate.evaMethod" id="evaMethod_value"></s:hidden>
						</td>
					</tr>
					<tr class='interCtrl'>
						<td class="EditHead">评价内容</br><font color="darkgray">(限2000字)</font></td>
						<td class="editTd" colspan="3">
							<textarea id="evaContent_ue" style='height:60px;width:99%;'>${audTemplate.evaContent}</textarea>
							<s:hidden name="audTemplate.evaContent" id="evaContent_value"></s:hidden>
						</td>
					</tr>
					<tr class='interCtrl'>
						<td class="EditHead">工作组织</br><font color="darkgray">(限2000字)</font></td>
						<td class="editTd" colspan="3">
							<textarea id="workOrg_ue" style='height:60px;width:99%;'>${audTemplate.workOrg}</textarea>
							<s:hidden name="audTemplate.workOrg" id="workOrg_value"></s:hidden>
						</td>
					</tr>
					<tr class='interCtrl'>
						<td class="EditHead">总体安排</br><font color="darkgray">(限2000字)</font></td>
						<td class="editTd" colspan="3">
							<textarea id="overallArgm_ue" style='height:60px;width:99%;'>${audTemplate.overallArgm}</textarea>
							<s:hidden name="audTemplate.overallArgm" id="overallArgm_value"></s:hidden>
						</td>
					</tr>
					<tr class='interCtrl'>
						<td class="EditHead">工作要求</br><font color="darkgray">(限2000字)</font></td>
						<td class="editTd" colspan="3">
							<textarea id="jobRequirements_ue" style='height:60px;width:99%;'>${audTemplate.jobRequirements}</textarea>
							<s:hidden name="audTemplate.jobRequirements" id="jobRequirements_value"></s:hidden>
						</td>
					</tr>
				</table>
				<s:hidden name="audTemplate.audTemplateId" />
				<s:hidden name="audTemplateId" />
				<s:hidden name="taskTemplateId" />
				<s:hidden name="newDoubt_type" />
				<s:hidden name="audTemplate.proStatus" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
			</s:form>
		</center>
		
		
<script type="text/javascript">
$(function(){
	if("${interCtrl}" == 'true'){	
		try{
			$('.audit').hide();
			$('.interCtrl').show();
		}catch(e){
			
		}
		// 富文本框初始化
		try{
			var maxChar = 2000;
			var ueTextareaArr = ['evaBasis','evaScope','evaMethod','evaContent','workOrg','overallArgm','jobRequirements'];
			var evaBasis_ue, evaScope_ue, evaMethod_ue, evaContent_ue, workOrg_ue, overallArgm_ue, jobRequirements_ue;
			var ueObj = [evaBasis_ue, evaScope_ue, evaMethod_ue, evaContent_ue, workOrg_ue, overallArgm_ue, jobRequirements_ue];
			var ueOptions = {
				elementPathEnabled:false,
				maximumWords:maxChar
			}
			$.each(ueTextareaArr, function(i, eleId) {
			    ueObj[i] = UE.getEditor(eleId + '_ue', ueOptions);
			    ueObj[i].ready(function() {
			        //不可编辑
			        ueObj[i].setDisabled();
			    });
			});
			
		}catch(e){
			//alert(e.message);
		}

	}else{
		try{
			$('.interCtrl').remove();
			$('.audit').show();
		}catch(e){
			
		}
	}

});
</script>
		
	</body>
</html>
