<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<html>
	<script language="javascript">
	 //生成
      function generate(s)
		  {
		     d_id=document.getElementsByName("doubt_id")[0].value;
		     n_type=s;
		     d_type=document.getElementsByName("type")[0].value;
		     window.paramw = "模态窗口";
             window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	                    
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
		document.getElementsByName("audProgramme.doubt_status")[0].value="050"
		//audProgramme.doubt_status
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
	myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&project_id=${project_id}";
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
//alert("111");
var url = "${contextPath}/operate/template/saveRoot.action";
myform.action = url;
	myform.submit();
	alert("1112234");
	//parent.location.href='${contextPath}/operate/template/main.action?audProgrammeId='+<%=request.getParameter("audProgrammeId")%>;
	window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?audProgrammeId=<%=request.getParameter("audProgrammeId")%>';
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
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>修改实施方案:总体方案查看</title>
		<s:head />
	</head>



	<body class="easyui-layout">
		<div region="center" style="overflow: auto; width: 100%;height: 100%;">
			<s:form id="myform" onsubmit="return true;" action="view" method="post">
				<table cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center">

					
					
				
				
					<tr>
						<td class="EditHead" style="width:17.5%">
							<font color="red"></font>&nbsp;&nbsp;&nbsp;模板名称
						</td>
						<!--标题栏-->
						<td class="editTd" style="width:32.5%">
							<s:property value="audProgramme.templateName" />
						</td>

						<td  class="EditHead" style="width:17.5%">
							&nbsp;&nbsp;&nbsp;审计方案名称
						</td>
						<td class="editTd" style="width:32.5%">
							<s:property value="audProgramme.programmeName" />
						</td>
					</tr>
					<s:hidden name="audProgramme.audProgrammeId" />
					<s:hidden name="audProgrammeId" />
					<tr>
						<td class="EditHead">
							<font color="red"></font>&nbsp;&nbsp;&nbsp;类别名称
						</td>
						<td class="editTd">
							<s:property value="audProgramme.typeName" />
							<s:hidden name="audProgramme.proAuthorCode" />
							<s:hidden name="audProgramme.proAuthorName" />
						</td>
						<!--标题栏-->
						<td class="EditHead">

							<font color="red"></font>&nbsp;&nbsp;&nbsp;子类别名称
						</td>
						<td class="editTd">
							<s:property value="audProgramme.typeName2" />
							<font color="red"></font>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<tr >
						<td class="EditHead">
							<font color="red"></font>&nbsp;&nbsp;&nbsp;编制日期
						</td>
						<td class="editTd">
							<s:property value="audProgramme.proDate" />
							<s:hidden name="audProgramme.task_id" />
							<s:hidden name="audProgramme.task_code" />
						</td>

						<td class="EditHead">
							&nbsp;&nbsp;&nbsp;编制人
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:property value="audProgramme.proAuthorName" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width: 130px">
							<font color="red"></font>项目开始日期
						</td>
						<td class="editTd">
						<s:property value="audProgramme.sceneAudStarttime" />
						</td>
						<td class="EditHead" style="width: 130px">
							项目结束日期
						</td>
						<td class="editTd">
						<s:property value="audProgramme.sceneAudEndtime" />
						</td>

					</tr>
					<tr>
						<td class="EditHead">审计期间开始</td>
						<td class="editTd" ><s:property value="audProgramme.audit_start_time" /></td>
						<td class="EditHead" >审计期间结束</td>
						<td class="editTd"> <s:property value="audProgramme.audit_end_time" /></td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							基本情况
						</td>
						<td  class="editTd" colspan="3">
							<s:textarea cssClass="noborder" cssStyle="width:100%;height:80px;overflow-y:hidden;" name="audProgramme.auditDeptInfo" readonly="true"></s:textarea>
						</td>

					</tr>
					<tr class='audit'>
						<td class="EditHead">
							审计目标和范围
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audProgramme.auditTarget" /> --%>
							<s:textarea cssClass="noborder" name="audProgramme.auditTarget" cssStyle="width:100%;height:80px;overflow-y:hidden;" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							审计内容和重点
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.pointContent" cssStyle="width:100%;height:80px;overflow-y:hidden;" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							组织分工
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audProgramme.auditAssessment" /> --%>
							<s:textarea cssClass="noborder" name="audProgramme.people_work" cssStyle="width:100%;height:80px;overflow-y:hidden;" readonly="true"/>
						</td>
					</tr>


<%-- 					<tr  class='audit'>
						<td class="EditHead">
							审计方法
						</td>
						<td class="editTd" colspan="3">
							<s:property value="audProgramme.method" />
							<s:textarea cssClass="noborder" name="audProgramme.method" cssStyle="width:100%;height:80px;overflow-y:hidden;" />
						</td>
					</tr> --%>
					<tr class='audit'>
						<td class="EditHead">
							对专家和外部审计<br>工作结果的利用
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audProgramme.people_work" /> --%>
							<s:textarea cssClass="noborder" name="audProgramme.procedures" cssStyle="width:100%;height:80px;overflow-y:hidden;" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							其他事项
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audProgramme.procedures" /> --%>
							<s:textarea cssClass="noborder" name="audProgramme.other" cssStyle="width:100%;height:80px;overflow-y:hidden;" readonly="true"/>
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">附件</td>
						<td class="editTd" colspan="3">
							<div id="assistFile" class="easyui-fileUpload" 
								 data-options="fileGuid:'${audProgramme.file_id}',isAdd:false,isEdit:false,isDel:false"></div>
						</td>
					</tr>
					
					
						<tr class='interCtrl'>
							<td class="EditHead">评价依据</br><font color="darkgray">(限2000字)</font></td>
							<td class="editTd" colspan="3">
								<textarea id="evaBasis_ue" style='height:60px;width:99%;'>${audProgramme.evaBasis}</textarea>
								<s:hidden name="audProgramme.evaBasis" id="evaBasis_value"></s:hidden>
							</td>
						</tr>
						<tr class='interCtrl'>
							<td class="EditHead">评价范围</br><font color="darkgray">(限2000字)</font></td>
							<td class="editTd" colspan="3">
								<textarea id="evaScope_ue" style='height:60px;width:99%;'>${audProgramme.evaScope}</textarea>
								<s:hidden name="audProgramme.evaScope" id="evaScope_value"></s:hidden>
							</td>
						</tr>
						<tr class='interCtrl'>
							<td class="EditHead">评价方式</br><font color="darkgray">(限2000字)</font></td>
							<td class="editTd" colspan="3">
								<textarea id="evaMethod_ue" style='height:60px;width:99%;'>${audProgramme.evaMethod}</textarea>
								<s:hidden name="audProgramme.evaMethod" id="evaMethod_value"></s:hidden>
							</td>
						</tr>
						<tr class='interCtrl'>
							<td class="EditHead">评价内容</br><font color="darkgray">(限2000字)</font></td>
							<td class="editTd" colspan="3">
								<textarea id="evaContent_ue" style='height:60px;width:99%;'>${audProgramme.evaContent}</textarea>
								<s:hidden name="audProgramme.evaContent" id="evaContent_value"></s:hidden>
							</td>
						</tr>
						<tr class='interCtrl'>
							<td class="EditHead">工作组织</br><font color="darkgray">(限2000字)</font></td>
							<td class="editTd" colspan="3">
								<textarea id="workOrg_ue" style='height:60px;width:99%;'>${audProgramme.workOrg}</textarea>
								<s:hidden name="audProgramme.workOrg" id="workOrg_value"></s:hidden>
							</td>
						</tr>
						<tr class='interCtrl'>
							<td class="EditHead">总体安排</br><font color="darkgray">(限2000字)</font></td>
							<td class="editTd" colspan="3">
								<textarea id="overallArgm_ue" style='height:60px;width:99%;'>${audProgramme.overallArgm}</textarea>
								<s:hidden name="audProgramme.overallArgm" id="overallArgm_value"></s:hidden>
							</td>
						</tr>
						<tr class='interCtrl'>
							<td class="EditHead">工作要求</br><font color="darkgray">(限2000字)</font></td>
							<td class="editTd" colspan="3">
								<textarea id="jobRequirements_ue" style='height:60px;width:99%;'>${audProgramme.jobRequirements}</textarea>
								<s:hidden name="audProgramme.jobRequirements" id="jobRequirements_value"></s:hidden>
							</td>
						</tr>
				</table>

				<s:hidden name="newDoubt_type" />
				<s:hidden name="audProgramme.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				
			</s:form>
		</div>
	</body>
	
<script type="text/javascript">
$(function(){

	if("${interCtrl}" == 'true'){	
		try{
			$('.audit').hide();
			$('.interCtrl').show();
		}catch(e){
			
		}
		
		$("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});
		
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
	
</html>
