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
		<title>修改实施方案:总体方案修改</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>	
	<style type="text/css">
		/* 浮动最上层 */
		#div1 {
			z-index: 9;
		}

		#div2 {
			z-index: 1;
		}
		.textbox .textbox-text {
    		padding-top: 1px !important;
    		padding-bottom: 1px !important;
		}
	</style>
	<script language="javascript">
		$(document).ready(function(){
			 /* $('#addType_div').window({   
					width :document.documentElement.clientWidth || document.body.clientWidth,   
					height:document.documentElement.clientHeight || document.body.clientHeight,  
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				}); */
			showWin('addType_div','增加审计类别');
		});
	
		$(function(){   
			
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
			
			
			  $('#generateType').bind('click',function(){
				  //$('#addType_frm').attr('src','${contextPath}/operate/task/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=${audTask.taskTemplateId}&taskPid=${audTask.taskTemplateId}&project_id=<%=request.getParameter("project_id")%>');
		          //$('#addType_div').window('open');
				  var url = '${contextPath}/operate/task/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=${audTask.taskTemplateId}&taskPid=${audTask.taskTemplateId}&project_id=<%=request.getParameter("project_id")%>';
		          showWinIf('addType_div',url,'增加类别',600,350);
				});
				// 保存方案库 
			$('#sendId').bind('click',function(){
				 if(document.getElementById("title").value.replace(/\s+$|^\s+/g,"")==""){
				      $.messager.alert('警告',"请输入回传方案名称!","error");
				      return false;
				    }
				$.ajax({
					dataType:'json',
					url : "<%=request.getContextPath()%>/operate/task/generateTemplate.action",
					data:{"project_id":'${project_id}',"taskInstanceId":'${taskInstanceId}',"ppFormId":'${crudId}'},
					type: "POST",
					success: function(data){
						if(data.type == 'success'){
							$('#sendBack_div').window('close');
							$.messager.show({
								title:'回传成功',
								msg:'对话框将在5秒后关闭。',
								timeout:5000,
								showType:'slide'
							});
						}
					},
					error:function(data){
						$('#sendBack_div').window('close');
						$.messager.alert('提示信息','回传失败！','error');
					}
				});
			})
			
			if($("#sucFlag").val()=='1'){
				$("#sucFlag").val('');
				$.messager.show({
					title:'提示信息',
					msg:'保存成功',
					timeout:5000,
					showType:'slide'
				});
				//window.parent.parent.frames['childBasefrm'].location.reload();
				window.parent.parent.frames['f_left'].location.reload();
			}
				
				
			}); 
		
		function sucFun(){
    		if($("#sucFlag").val()=='1'){
    			$("#sucFlag").val('');
    			$.messager.show({
    				title:'提示信息',
    				msg:'保存成功！',
    				timeout:5000,
    				showType:'slide'
    			});
    		}        		
   		}
	
	function closeW(){
		$('#addType_div').window('close');
	}
	function check(){
		var v_3 = "audProgramme.programmeName";  // field
		var title_3 = '审计方案名称';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>300){
			$.messager.show({
				title:'提示信息',
				msg:'审计方案名称的长度不能大于300字！',
				timeout:5000,
				showType:'slide'
			});
			document.getElementById(v_3).focus();
			return false;
		} 

		var v_3 = "audProgramme.sceneAudStarttime";  // field
		var title_3 = '审计现场开始时间';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(null==t || t==''){
		$.messager.show({
			title:'提示信息',
			msg:'审计现场开始时间不能为空！',
			timeout:5000,
			showType:'slide'
		});
		document.getElementById(v_3).focus();
		return false;
		} 
		
		var v_3 = "audProgramme.sceneAudEndtime";  // field
		var title_3 = '审计现场结束时间';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(null==t || t==''){
			$.messager.show({
				title:'提示信息',
				msg:'审计现场结束时间不能为空！',
				timeout:5000,
				showType:'slide'
			});
		document.getElementById(v_3).focus();
		return false;
		}else{
			var start_time = document.getElementsByName("audProgramme.sceneAudStarttime")[0].value;
			var end_time = document.getElementsByName("audProgramme.sceneAudEndtime")[0].value;
			if(start_time && end_time){
				if(start_time!=""&&end_time!=""){
					start_time = start_time.replace("-","").replace("-","");
					end_time = end_time.replace("-","").replace("-","");
					var sn = new Number(start_time);
					var en = new Number(end_time);
					if(sn>en){
						$.messager.show({
							title:'提示信息',
							msg:'审计现场开始时间不能大于结束时间！',
							timeout:5000,
							showType:'slide'
						});
						return ;
					}
				}			
			}
		} 		
		var v_3 = "audProgramme.auditDeptInfo";  // field
		var title_3 = '基本情况';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		$.messager.show({
			title:'提示信息',
			msg:'基本情况的长度不能大于2000字！',
			timeout:5000,
			showType:'slide'
		});
		document.getElementById(v_3).focus();
		return false;
		}

		/* var v_3 = "audProgramme.auditDeptInfo";  // field
		var title_3 = '被审计单位基本情况';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("被审计单位基本情况的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		}  */
		
		var v_3 = "audProgramme.other";  // field
		var title_3 = '其他事项';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
			showMessage1("其他事项的长度不能大于2000字！");
		   //document.getElementById(v_3).focus();
		    return false;
		} 

		var v_3 = "audProgramme.auditTarget";  // field
		var title_3 = '审计目标和范围';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
			showMessage1("审计目标和范围的长度不能大于2000字！");
		   //document.getElementById(v_3).focus();
		    return false;
		}

		var v_3 = "audProgramme.pointContent";  // field
		var title_3 = '审计内容和重点';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>5000){
		  showMessage1("审计内容和重点的长度不能大于5000字！");
		  //document.getElementById(v_3).focus();
		   return false;
		} 

		var v_3 = "audProgramme.people_work";  // field
		var title_3 = '组织分工 ';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		   showMessage1("组织分工的长度不能大于2000字！");	
		   //document.getElementById(v_3).focus();
		   return false;
		} 

 		var v_3 = "audProgramme.procedures";  // field
		var title_3 = '对专家和外部审计工作结果的利用';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>5000){
			  showMessage1("对专家和外部审计工作结果的利用的长度不能大于5000字！");	
		      //document.getElementById(v_3).focus();
		      return false;
		} 
		
		return true;
	}
	
	//模板生成----------保存表单
function saveFormRoot(){
	var v_3 = "audProgramme.programmeName";  // field
	var title_3 = '审计方案名称';// field name
	var notNull = 'true'; // notnull
	
    if("${interCtrl}" == 'true'){        	
        aud$ueAssignValToBusEle();        
        if(!audEvd$validateform('myform')){
        	return;
        }
    }

	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "")
		           {
				         $.messager.show({
				        	 title:"提示信息",
				        	 msg:title_3+"不能为空!",
				        	 timeout:5000,
				         });
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
		           if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
		        	   $.messager.show({
				        	 title:"提示信息",
				        	 msg:title_3+"不能为空!",
				        	 timeout:5000,
				         });
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }
                   if(!check()){
                       return false; 
                   }
	var url = "${contextPath}/operate/task/saveRoot.action";
	myform.action = url;
	myform.submit();
}

	 //生成
      function generateType()
		  {
		     var title="增加类别";
		     if('enabled' == '${shenjichengxu}')
				title="增加审计事项";
		     window.paramw = "模态窗口";
		     var p='${audTask.taskTemplateId}';
		     showPopWin('${contextPath}/operate/task/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId='+p+'&taskPid='+p+'&project_id=<%=request.getParameter("project_id")%>',550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	                    
	} 
	function generateLeaf()
		  {
		     var title="增加审计事项";
		     window.paramw = "模态窗口";
		     showPopWin('${contextPath}/operate/task/addLeaf.action?tab=main&type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',720,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	                    
	} 
	
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

 


function saveForm1(){
var bool = true;//提交表单判断参数
 

	
 
	
 
	
var v_3 = "doubt.course_title";  // field
var title_3 = '课程名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "")
		           {
	        	   $.messager.show({
			        	 title:"提示信息",
			        	 msg:title_3+"不能为空!",
			        	 timeout:5000,
			         });
				         bool = false;
				         return false;
		           }


var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "")
		           {
	        	   $.messager.show({
			        	 title:"提示信息",
			        	 msg:title_3+"不能为空!",
			        	 timeout:5000,
			         });
				         bool = false;
				         return false;
		           }

var v_3 = "doubt.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "")
		           {
	        	   $.messager.show({
			        	 title:"提示信息",
			        	 msg:title_3+"不能为空!",
			        	 timeout:5000,
			         });
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
 				$.messager.show({
		        	 title:"提示信息",
		        	 msg:"删除成功！",
		        	 timeout:5000,
		         });
 				}else{
 					$.messager.show({
			        	 title:"提示信息",
			        	 msg:"所请求的页面异常",
			        	 timeout:5000,
			         });
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
    //在窗口或框架被调整大小时,重载页面以使大文本框依据内容重新自适应高度
 	function resize(){
 		//window.location.href = "${contextPath}/operate/task/showContentRootEdit.action?selectedTab=main&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&project_id=<%=request.getParameter("project_id")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>";
 	}
</script>
	</head>
	<body  class="easyui-layout" onload="sucFun();" border='0' onresize="resize();">
		<div region="center" border='0' title="模板信息" style="overflow: scroll; width: 100%;height: 100%;">
			<s:form id="myform" onsubmit="return true;" action="/operate/task" method="post">
			<%-- 	<div style="position:absolute;top:0px;right:5px;">
					<s:if test="${teamAuth=='1'}">
						<a id="generateType" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加类别</a> &nbsp;
						<a id="saveFormRoot"onclick="saveFormRoot();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						
					</s:if>
				</div> --%>
			<div style="width: 100%;position:absolute;top:0px;z-index:9999999;" id="div1" align="center" >
				<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
					<tr class="EditHead">
						<td >
							<span style='float: left; text-align: left;'>
							<s:property value="#title" /></span>
						</td>
						<td  >
							<span style='float: right; text-align: right;'>
								<a id="generateType" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加类别</a> &nbsp;
								<a id="saveFormRoot"onclick="saveFormRoot();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
							</span>
						</td>
					</tr>

				</table>
			</div>
			<div class="position:relative" id="div2">
				<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
					<tr>
						<td class="EditHead">
							模板名称
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:property value="audProgramme.templateName" />
							<s:hidden name="audProgramme.templateName" />
							<!--一般文本框-->
						</td>

						<td class="EditHead">
							 审计方案名称
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:if test="${teamAuth=='1'}">
								<s:textfield cssClass="noborder" name="audProgramme.programmeName" cssStyle="width:160px;" maxlength="4000"/>
							</s:if>
							<s:else>
								<s:property value="audProgramme.programmeName" />
							</s:else>
						</td>
					</tr>
					<s:hidden name="audProgramme.id" />
					<s:hidden name="audProgramme.project_id" />
					<s:hidden name="audProgramme.audTemplateId" />


					<tr>
						<td class="EditHead">
							类别名称
						</td>
						<td class="editTd">
							<s:property value="audProgramme.typeName" />
							<s:hidden name="audProgramme.typeName" />
							<s:hidden name="audProgramme.typeCode" />
							<s:hidden name="audProgramme.proVer" />
							<s:hidden name="audProgramme.startDate" />
							<s:hidden name="audProgramme.endDate" />
							<s:hidden name="audProgramme.proStatus" />
							<s:hidden name="audProgramme.proAuthorCode" />
							<s:hidden name="audProgramme.proAuthorName" />
						</td>
						<!--标题栏-->
						<td class="EditHead">
							子类别名称
							<s:hidden name="audProgramme.proDate" />
						</td>
						<td class="editTd">
							<s:property value="audProgramme.typeName2" />
							<s:hidden name="audProgramme.typeName2" />
							<s:hidden name="audProgramme.typeCode2" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							编制日期
						</td>
						<td class="editTd">
							<s:property value="audProgramme.proDate" />
						</td>
						<td class="EditHead">
							编制人
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:property value="audProgramme.proAuthorName" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width: 130px;white-space:nowrap;">
							<font color="red">*</font>项目开始日期
						</td>
						<td class="editTd">
							<input type="text"  id="sceneAudStartTime" name="audProgramme.sceneAudStarttime" class="easyui-datebox" style="width: 150px; padding-top: 1px; padding-bottom: 1px;"
							value="${audProgramme.sceneAudStarttime}" editable="false"/>
						</td>
						<td class="EditHead" style="width: 130px;white-space:nowrap;">
							<font color="red">*</font>项目结束日期
						</td>
						<!--标题栏-->
						<td class="editTd">
							<input type="text"  id="sceneAudEndTime" name="audProgramme.sceneAudEndtime" class="easyui-datebox" style="width: 150px; padding-top: 1px; padding-bottom: 1px;"
							value="${audProgramme.sceneAudEndtime}" editable="false"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计期间开始</td>
						<td class="editTd"><s:property value="audProgramme.audit_start_time" /></td>
						<td class="EditHead" >审计期间结束</td>
						<td class="editTd"><s:property value="audProgramme.audit_end_time" /></td>
						<s:hidden name="audProgramme.audit_start_time" />
						<s:hidden name="audProgramme.audit_end_time" />
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							基本情况<br/><div style="float: right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.auditDeptInfo" cssStyle="width:100%;height:80px;overflow-y:hidden;"></s:textarea>
							<input type="hidden" id="audProgramme.auditDeptInfo.maxlength" value="2000">
						</td>

					</tr>
					<tr class='audit'>
						<td class="EditHead">
							审计目标和范围
							<br/><div style="float: right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.auditTarget" cssStyle="width:100%;height:80px;overflow-y:hidden" />
							<input type="hidden" id="audProgramme.auditTarget.maxlength" value="2000">
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							审计内容和重点
							<br/><div style="float: right;"><font color=DarkGray>(限5000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.pointContent" cssStyle="width:100%;height:80px;overflow-y:hidden" />
							<input type="hidden" id="audProgramme.pointContent.maxlength" value="5000">
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							组织分工
							<br/><div style="float: right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.people_work" cssStyle="width:100%;height:80px;overflow-y:hidden" />
							<input type="hidden" id="audProgramme.people_work.maxlength" value="2000">
						</td>
					</tr>


<%-- 					<tr>
						<td class="EditHead">
							审计方法
							<br/><div style="float: right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.method" cssStyle="width:100%;height:80px;overflow-y:hidden" />
							<input type="hidden" id="audProgramme.method.maxlength" value="2000">
						</td>
					</tr> --%>
					<tr class='audit'>
						<td class="EditHead">
							对专家和外部审计<br>工作结果的利用
							<br/><div style="float: right;"><font color=DarkGray>(限5000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.procedures" cssStyle="width:100%;height:80px;overflow-y:hidden" />
							<input type="hidden" id="audProgramme.procedures.maxlength" value="5000">
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">
							其他事项
							<br/><div style="float: right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audProgramme.other" cssStyle="width:100%;height:80px;overflow-y:hidden" />
							<input type="hidden" id="audProgramme.other.maxlength" value="2000">
						</td>
					</tr>
					<tr class='audit'>
						<td class="EditHead">附件</td>
						<td class="editTd" colspan="3">
							<div id="assistFile" class="easyui-fileUpload" 
								 data-options="fileGuid:'${audProgramme.file_id}'"></div>
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
				
				
				</div>
				
				
				
				<s:hidden name="audProgramme.file_id" />
				<s:hidden name="audTask.taskTemplateId" />
				<s:hidden name="newDoubt_type" />
				<s:hidden name="path" />
				<s:hidden name="node" />
				<s:hidden name="audProgramme.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<input type="hidden" name="sucFlag" id="sucFlag" value="${tip}"/>
				<input type="hidden" name="interCtrl" value="${interCtrl}"/>
			</s:form>
		</div>
		<div id="addType_div" title="增加类别" style="overflow:hidden">
			<!-- <iframe id="addType_frm" src="" frameborder="0" scrolling="no" style="width:100%;height:100%;">
			</iframe> -->
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
	
</html>
