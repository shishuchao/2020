<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	//总体方案页面，也就是审计方案模板的根节点页面
	String pb = (String) request.getParameter("refresh");
	String taskTemplateId = (String) request
			.getParameter("taskTemplateId");
	String audTemplateId = (String) request
			.getParameter("audTemplateId");
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>方案维护：总体方案修改</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script language="javascript">
	  $(function (){
		  showWin('addType_div','增加事项类别');
		  setTextareaAuto();
	  });
	  
	  function setTextareaAuto(){
	  	  $("#myform").find("textarea").each(function(){
			  autoTextarea(this);
		  });
	  }
	  function reload(){
	  	  window.location.reload();
	  }
	  //生成
      function generateType()
		  {
		    var taskTemplateId="<%=request.getParameter("taskTemplateId")%>";
		    if(taskTemplateId == null || taskTemplateId == "" || taskTemplateId =="null"){
		       taskTemplateId =	document.getElementById("taskTemplateId").value;
		    }
		     var url ="${contextPath}/operate/template/addType.action?taskTemplateId="+taskTemplateId+"&audTemplateId=<%=request.getParameter("audTemplateId")%>&selectedTab=<%=request.getParameter("selectedTab") %>";
		   	 showWinIf('addType_div',url,'增加事项类别',$(window).width()-100,$(window).height()-100);
		    // title="增加类别";
		     //window.paramw = "模态窗口";
             //window.showModalDialog('${contextPath}/operate/template/addType.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //window.open('${contextPath}/operate/template/addType.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>');
		    // showPopWin('${contextPath}/operate/template/addType.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',720,600,title);
		     //var num=Math.random();
		     //var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
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
		var title_3 = '方案名称';// field name
		var notNull = 'true'; // notnull
        if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != ""){
	         showMessage1(title_3+"不能为空!");
	         bool = false;
	         return false;
        }
		
        if("${interCtrl}" == 'true'){        	
	        aud$ueAssignValToBusEle();        
	        if(!audEvd$validateform('myform')){
	        	return;
	        }
        }
		
        $.ajax({
			type:"post",
			data:$('#myform').serialize(),
			url:"${contextPath}/operate/template/saveRoot.action",
			async:false,
			success:function(){
		    	showMessage1('保存成功！');
		    	parent.parent.reloadChildTreeNode();
			}
		});
        
		//var url = "${contextPath}/operate/template/saveRoot.action";
		//myform.action = url;
		//myform.submit();
		//window.parent.frames['treeIframe'].location.href='${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>';
		//parent.location.href='${contextPath}/operate/template/main.action?audTemplateId='+<%=request.getParameter("audTemplateId")%>;
		//alert(window.parent.frames['f_left']);
	}
	
	//刷新页面
	function again(){
		if(<%=pb%>==null||<%=pb%>=='null'||<%=pb%>==''){
			window.location="${contextPath}/operate/template/showContentRoot.action?selectedTab=main&taskTemplateId=<%=taskTemplateId%>&audTemplateId=<%=audTemplateId%>&refresh=1"
		} 
	}

	function xg(){  
    	//setTimeout("again()",100); 
    }
	
	function saveForm1(){
		var bool = true;//提交表单判断参数
		//非空校验
		var v_3 = "doubt.course_title";  // field
		var title_3 = '课程名称';// field name
		var notNull = 'true'; // notnull
        if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
	         showMessage1(title_3+"不能为空!");
	         bool = false;
	         return false;
        }
	
	
		var v_3 = "doubt.doubted_staff";  // field
		var title_3 = '适用人员';// field name
		var notNull = 'true'; // notnull
        if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
	        showMessage1(title_3+"不能为空!");
	        bool = false;
	        return false;
        }
	
		var v_3 = "doubt.staff_str";  // field
		var title_3 = '适用人员描述';// field name
		var notNull = 'true'; // notnull
        if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
	         showMessage1(title_3+"不能为空!");
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
 				showMessage1("删除成功");
 				}else{
 					showMessage1("所请求的页面有异常");
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
<style type="text/css">
input[class~=editElement]{
	width:90% !important;
}
#myform td:nth-of-type(1){
	border-left-width:0px;
}
#myform td:last-of-type{
	border-right-width:0px;
}
</style>
</head>
<body onload="xg()" style='padding:0px;margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true'>
    <div region='north' border='0' style='padding:0px;overflow:hidden;background-color:#FAFAFA;border-bottom:1px solid #cccccc;'>
        <div style="float:right;margin:3px 5px 4px 5px;">        
			<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateType()">增加类别</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormRoot()">保存</a>         
        </div>            
    </div>
    <div region='center' border='0' >
		<s:form id="myform" onsubmit="return true;" action="view" method="post">
			<s:hidden name="audTemplateId"/>
			<s:hidden name="taskTemplateId"/>
			<s:hidden name="refreshCode"/>
			<s:hidden name="type"/>
			<s:hidden name="pro_id"/>
			<s:hidden name="path"/>
			<s:hidden name="node"/>
	
			<s:hidden name="audTaskTemplate.taskTemplateId" id="taskTemplateId"/>
			<s:hidden name="audTaskTemplate.taskPid"/>
	
			<s:hidden name="audTemplate.audTemplateId"/>
	
			<s:hidden name="audTemplate.typeCode2"/>
			<s:hidden name="audTemplate.typeName2"/>
			
			<s:hidden name="audTemplate.proAuthorCode"/>
			<s:hidden name="audTemplate.proAuthorName"/>
			<s:hidden name="audTemplate.proDate"/>
			<s:hidden name="audTemplate.proAccord"/>
			<s:hidden name="audTemplate.auditFocus"/>
			<s:hidden name="audTemplate.auditAssessment"/>
			<s:hidden name="audTemplate.teamMembers"/>
			<s:hidden name="audTemplate.startDate"/>
			<s:hidden name="audTemplate.endDate"/>
			<s:hidden name="audTemplate.method"/>
			<s:hidden name="audTemplate.proStatus"/>
			<s:hidden name="audTemplate.dept_code"/>
			<s:hidden name="audTemplate.dept_name"/>
			<s:hidden name="audTemplate.dept_code_author"/>
			<s:hidden name="audTemplate.dept_name_author"/>
			<s:hidden name="audTemplate.publish"/>
			<s:hidden name="audTemplate.taskNametype"/>
			<s:hidden name="audTemplate.taskStartTime"/>
			<s:hidden name="audTemplate.taskEndTime"/>
	
			<s:hidden name="audTemplate.timesCited"/>
			<s:hidden name="audTemplate.belongTo"/>
	
			<table class="ListTable" align="center" style='width:100%;table-layout:fixed;margin-top:-2px;'>
				<tr style="height:0px;">
					<td style="width:15%;"></td><td style="width:35%;"></td>
					<td style="width:15%;"></td><td style="width:35%;"></td>
				</tr>
				<s:if test="${interCtrl == 'true'}">
					<tr>
						<td  class="EditHead">方案名称</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="audTemplate.templateName" />
						</td>
						<td class="EditHead">方案版本</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="audTemplate.proVer" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">编制日期</td>
						<td class="editTd">
							<s:property value="audTemplate.proDate"/>
						</td>
						<td class="EditHead">编制人</td>
						<td class="editTd">
							<s:property value="audTemplate.proAuthorName"/>（<s:property value='audTemplate.atCompany'/>）
						</td>
					</tr>	
					<tr>
						<td class="EditHead">类别名称</td>
						<td class="editTd">
					        <input type='text' id='audTemplate_typeName' name='audTemplate.typeName' value="${audTemplate.typeName}"
					         class="noborder editElement clear " readonly/>
					        <input type='hidden' id='audTemplate_typeCode' name='audTemplate.typeCode' value="${audTemplate.typeCode}"
					         class="noborder editElement clear " readonly/>
					        <a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
					            onclick="showSysTree(this,{
					                  title:'项目类别选择',
					                  onlyLeafClick:true,
					                  noMsg:true,
					                  queryBox:false,
					                  param:{
					                    'plugId':'710007',
					                    'whereHql':'type=\'710007\'',
					                    'customRoot':'项目类别',
					                    'rootParentId':'0',
					                    'beanName':'CodeName',
					                    'treeId'  :'code',
					                    'treeText':'name',
					                    'treeParentId':'pid',
					                    'treeOrder':'code'
					                  }
					        })"></a>						
						</td>
						<td class="EditHead">所属单位</td>
						<td class="editTd">
						    <input type='text' id='audTemplate_atCompany' name='audTemplate.atCompany' 
	                          value="${audTemplate.atCompany}" class="noborder editElement clear" readonly/>
						    <input type='hidden' id='audTemplate_atCompanyCode' name='audTemplate.atCompanyCode'
	                          value="${audTemplate.atCompanyCode}" class="noborder editElement clear" readonly/>
						    <a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
						        onclick="showSysTree(this,{
						              title:'所属单位选择',
						              param:{
						                'rootParentId':'0',
						                'beanName':'UOrganizationTree',
						                'treeId'  :'fid',
						                'treeText':'fname',
						                'treeParentId':'fpid',
						                'treeOrder':'fcode'
						             }                                  
						    })"></a>
						</td>
					</tr>	
				</s:if>
				<s:else>
					<tr>
						<td class="EditHead">模板名称</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="audTemplate.templateName"/>
						</td>
						<td class="EditHead">审计方案名称</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="audTemplate.programmeName"/>
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
							<s:hidden name="audTemplate.typeCode"/>
							<s:hidden name="audTemplate.typeName"/>
							<s:hidden name="audTemplate.atCompany"/>
							<s:hidden name="audTemplate.atCompanyCode"/>
							<s:hidden name="audTemplate.proVer"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">编制日期</td>
						<td class="editTd">
							<s:property value="audTemplate.proDate"/>
						</td>
						<td class="EditHead">编制人</td>
						<td class="editTd">
							<s:property value="audTemplate.proAuthorName"/>（<s:property value='audTemplate.atCompany'/>）
						</td>
					</tr>			
				
				</s:else>
	
				<tr class='audit'>
					<td class="EditHead">基本情况</td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" name="audTemplate.auditDeptInfo" cssStyle="width:100%;overflow-y:hidden"/>
					</td>
				</tr>
				<tr class='audit'>
					<td class="EditHead">审计目标和范围</td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" name="audTemplate.auditTarget" cssStyle="width:100%;overflow-y:hidden"/>
					</td>
				</tr>
				<tr class='audit'>
					<td class="EditHead">审计内容和重点</td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" name="audTemplate.pointContent" cssStyle="width:100%;overflow-y:hidden"/>
					</td>
				</tr>
				<tr class='audit'>
					<td class="EditHead">组织分工</td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" name="audTemplate.people_work" cssStyle="width:100%;overflow-y:hidden"/>
					</td>
				</tr>
				<tr class='audit'>
					<td class="EditHead">对专家和外部审计<br>工作结果的利用</td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" name="audTemplate.procedures" cssStyle="width:100%;overflow-y:hidden"/>
					</td>
				</tr>
				<tr class='audit'>
					<td class="EditHead">其他事项</td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" name="audTemplate.other" cssStyle="width:100%;overflow-y:hidden"/>
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

		</s:form>
		<div id="addType_div"></div>
	</div>
	
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
			$.each(ueTextareaArr, function(i, eleId){
				ueObj[i] = UE.getEditor(eleId + '_ue', ueOptions);
				$('#'+eleId+'_value').addClass('editElement len'+maxChar);
			});
		}catch(e){
			alert(e.message);
		}
		
		function aud$ueAssignValToBusEle(){
			if("${interCtrl}" == 'true'){				
				try{
					$.each(ueTextareaArr, function(i, eleId){
						$('#'+eleId+'_value').val(ueObj[i].getContent(eleId + '_ue'));
					});
				}catch(e){
					
				}
			}
		}
		window.aud$ueAssignValToBusEle = aud$ueAssignValToBusEle;
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
