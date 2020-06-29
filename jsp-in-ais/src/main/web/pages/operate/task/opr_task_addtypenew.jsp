<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>


<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />编辑审计事项
		</title>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	 	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script language="javascript">
	$(function(){
		
		window.setTimeout(function(){
			$('#taskStartTime, #taskEndTime').datebox({    });
		},100);
		
		if($("#flag").val()=='s'){
			$("#flag").val("");
			showMessage1('保存成功!');
			window.parent.parent.parent.frames['f_left'].reloadTree("${audTask.taskPid}");
			parent.closeW();
			window.parent.parent.parent.frames['childBasefrm'].location.reload();
		}
		
		//audTask_taskAssign audTask_taskAssignName
		$('#audTask_taskAssign').bind('change', function(){
			var text = $(this).find("option:selected").text();
			if(text){
				$('#audTask_taskAssignName').val(text);
			}
		});
		$('#audTask_taskAssignName').val($('#audTask_taskAssign').find("option:selected").text());
		
		$('#audTask_taskGroupAssign').bind('change', function(){
			var text = $(this).find("option:selected").text();
			if(text){
				$('#audTask_taskGroupAssignName').val(text);
			}
		});
		
		$('#audTask_taskGroupAssignName').val($('#audTask_taskGroupAssign').find("option:selected").text());


		$("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});

	});
	
	function flush(){
	    var flush='<%=request.getParameter("flush")%>'
 		if(flush=='true'){
  			 window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
 		}
	  
	}

	function closeW(){
		//window.top.frames['f_left'].location.reload();
		//window.top.frames['childBasefrm'].location.reload();
		//window.close();
		//ais/operate/task/showTreeListEdit.action?project_id=3EA07965-EAD3-3BB2-03BC-90658982D85C
		///ais/operate/task/showContentEdit.action?node="+node.attributes.taskTemplateId+"&path="+path+"&selectedTab=main&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>"
		window.top.frames['childBasefrm'].location.href='${contextPath}/operate/task/showContentEdit.action?node=${taskTemplateId}&selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&taskId=${taskTemplateId}&taskTemplateId=${taskTemplateId}&project_id=<%=request.getParameter("project_id")%>';
		window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${taskTemplateId}&project_id=<%=request.getParameter("project_id")%>';
		window.close();
	
	}
	//function getSelect(){
	 
	//showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/task/showTreeListSelect.action&a=a&project_id=${project_id}&paraname=audTask.taskBeforeName&paraid=audTask.taskBeforeCode',420,320,'前置事项选择');
	//var t=document.getElementsByName('audTask.taskBeforeName')[0].value;
	//alert(t);
	//}
	function check(){

		var v_3 = "audTask.taskName";  // field
		var title_3 = '事项名称';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>1200){
		top.$.messager.alert('提醒',"事项名称的长度不能大于1200字！",'error');
		document.getElementById(v_3).focus();
		return false;
		} 
    if('enabled' == '${shenjichengxu}'){
		var v_3 = "audTask.taskTarget";  // field
		var title_3 = '审计目的';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
	 	if(t.length>2000){
			//alert("审计目的的长度不能大于2000字！");
			top.$.messager.alert('提醒',"所需资料长度不能大于2000字！",'error');
			document.getElementById(v_3).focus();
			return false;
		} 

		var v_3 = "audTask.taskFile";  // field
		var title_3 = '备注';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
			//alert("备注的长度不能大于2000字！");
			top.$.messager.alert('提醒',"备注的长度不能大于2000字！",'error');
			document.getElementById(v_3).focus();
			return false;
		}
		
	 }
    
    
    var taskStartTime = $('#taskStartTime').datebox('getValue');
    var taskEndTime   = $('#taskEndTime').datebox('getValue');
    if(taskStartTime && taskEndTime){
        taskStartTime = taskStartTime.replace(/(^\s*)|(\s*$)/g,'').replace(/-/g,'');
        taskEndTime   = taskEndTime.replace(/(^\s*)|(\s*$)/g,'').replace(/-/g,'');
        if(parseInt(taskEndTime) < parseInt(taskStartTime)){
            $.messager.show({
                title:"提示信息",
                msg:"事项结束时间 应在 事项开始时间 之后"                           
            });
            return false;
        }
    }
    
    
    
		return true;
	}
	
	function onlyNumbers1(s)
	{
		 re = /^\d+\d*$/
		 var str=s.replace(/\s+$|^\s+/g,"");
		 if(str==""){
		 return false;
		 }
		 if(!re.test(str))
		 {
		  //alert("事项序号只能输入正整数,请重新输入!");
		  top.$.messager.alert('提醒',"事项序号只能输入正整数,请重新输入!",'error');
		  return true ;   
		 }
	}
	
	function closeTask(){
		parent.closeTask();
	}
	//-------保存表单
  	function saveFormType(){
       var auth='';
       DWREngine.setAsync(false);
	   DWREngine.setAsync(false);DWRActionUtil.execute(
	   { namespace:'/operate/task', action:'checkSubTask', executeResult:'false' }, 
	   {'project_id':'<%=request.getParameter("project_id")%>','taskTemplateId':'<%=request.getParameter("taskTemplateId")%>'},xxx);
	    function xxx(data){
		  auth =data['auth'];
		}
				 
		  if(auth=='1'||auth=='3'){
		 
		 }else{
			 //top.$.messager.alert('提醒',"请刷新审计方案树,该审计事项已是末级节点,不能增加下级审计事项!",'warning');
			 showMessage1("请刷新审计方案树,该审计事项已是末级节点,不能增加下级审计事项!");
			 return false;
		 }



			var v_3 = "audTask.taskName";  // field
			var title_3 = '事项名称';// field name
			var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                         //top.$.messager.alert('提醒',title_3+"不能为空!",'error');
                         showMessage1(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }

	  		 var v_3 = "audTask.taskMethod";  // field
	  		 var title_3 = '审计查证要点';// field name
	  		 var notNull = 'true'; // notnull
	  		 var t=document.getElementsByName(v_3)[0].value;
	  			if(t.length>5000){
	  			top.$.messager.alert('提醒',"审计查证要点的长度不能大于5000字！",'error');
	  			document.getElementById(v_3).focus();
	  			return false;
	  		 } 

								


			

                 var a = $('#taskStartTime').val();
 				var b = $('#taskEndTime').val();
 				if(a>b){
 					//alert('[结束日期]应大于等于[开始日期]');
                    //top.$.messager.alert('提醒','[结束日期]应大于等于[开始日期]','error');
                    showMessage1('[结束日期]应大于等于[开始日期]');
 					$('#taskStartTime').val('').focus();
 					return false;
 				}


			var v_2 =  "audTask.taskCode";

			var title_2 = '事项编号';// field name
			var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         //window.alert(title_2+"不能为空!");
                         //top.$.messager.alert('提醒',title_2+"不能为空!",'error');
                         showMessage1(title_2+"不能为空!");
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        //window.alert(title_2+"不能为空!");
                        //top.$.messager.alert('提醒',title_2+"不能为空!",'error');
                        showMessage1(title_2+"不能为空!");
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
                   }


			var s = document.getElementsByName(v_2)[0].value;
			/*if(onlyNumbers1(s)){
			 document.getElementById(v_2).focus();
			return false;
			}*/
			//alert(document.getElementsByName("audTask.taskCode")[0].value)
			if(!check()){
			  return false;
			}

			//document.getElementsByName("root2")[0].disabled=true;
			var h='<%=request.getParameter("new")%>'
			if(h=='old'){
			   var url = "${contextPath}/operate/task/saveTypenew.action?leaf=1&node=${node}&path=${path}&addtype=true&selectedTab=<%=request.getParameter("selectedTab")%>";
			   myform.action = url;
			   myform.submit();
			}else {
			var url = "${contextPath}/operate/task/saveTypenew.action?leaf=1&node=${node}&path=${path}&addtype=true&new=true&selectedTab=<%=request.getParameter("selectedTab")%>";
			myform.action = url;
			myform.submit();
			
			}
			//window.parent.parent.parent.frames['f_left'].location.reload();
			
		}

        //保存并增加
		function saveFormTypeAgain(){
	      	var auth='';
	       	DWREngine.setAsync(false);
		   	DWREngine.setAsync(false);DWRActionUtil.execute(
		   	{ namespace:'/operate/task', action:'checkSubTask', executeResult:'false' }, 
		   	{'project_id':'<%=request.getParameter("project_id")%>','taskTemplateId':'<%=request.getParameter("taskTemplateId")%>'},xxx);
		    function xxx(data){
			  auth =data['auth'];
			}
					 
			 if(auth=='1'||auth=='3'){
			 
			 }else{
				 //alert("请刷新审计方案树,该审计事项已是末级节点,不能增加下级审计事项!");
                 top.$.messager.alert('提醒',"请刷新审计方案树,该审计事项已是末级节点,不能增加下级审计事项!",'info');
				 return false;
			 }



				var v_3 = "audTask.taskName";  // field
				var title_3 = '事项名称';// field name
				var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         //window.alert(title_3+"不能为空!");
                         top.$.messager.alert('提醒',title_3+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        //window.alert(title_3+"不能为空!");
                        top.$.messager.alert('提醒',title_3+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }




					/*
				var v_2 =  "audTask.taskCode"

				var title_2 = '事项编号';// field name
				var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_2+"不能为空!");
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_2+"不能为空!");
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
                   }


			var s = document.getElementsByName(v_2)[0].value;
			if(onlyNumbers1(s)){
			 document.getElementById(v_2).focus();
			return false;
			}*/
			if(!check()){
			  return false;
			}
			document.getElementsByName("root")[0].disabled=true;
			//document.getElementsByName("root2")[0].disabled=true;
			var h='<%=request.getParameter("new")%>'
			alert("new")
			if(h=='old'){
			   var url = "${contextPath}/operate/task/saveTypenewAgain.action?selectedTab=<%=request.getParameter("selectedTab")%>";
			   myform.action = url;
			   myform.submit();
			}else {
			var url = "${contextPath}/operate/task/saveTypenewAgain.action?node=${node}&path=${path}&addtype=true&new=true&selectedTab=<%=request.getParameter("selectedTab")%>";
			myform.action = url;
			myform.submit();
			
			}
	 
 

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
		myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&project_id=${project_id}";
		myform.submit();
	}



		//模板生成----------保存表单
		function saveForm(){
		//alert("111");
		var url = "${contextPath}/operate/doubt/save.action";
		myform.action = url;
			myform.submit();
			
			 
		}

 

 



			
				
				
     //上传附件
	 function Upload(id,filelist,delete_flag,edit_flag)
		{
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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



	<body onload="flush()"   fit='true' border="0" style="padding:0px;margin:0px;overflow:scroll;">
	
        <div region="north"  id="phead" border="0" style="overflow:hidden;text-align:right; height:35px; ">
        	<div class="EditHead" style="padding-top:4px;overflow:hidden;">
               <a href='javascript:void(0);' class="easyui-linkbutton" onclick="saveFormType();"  name="root" iconCls="icon-save">保存</a>
			   <a href='javascript:void(0);'  class="easyui-linkbutton" onclick="closeTask();"  iconCls="icon-cancel">关闭</a>
        	</div>
		</div>
		<div region="center" id="pbody" border="0" style='overflow:auto;' >
			<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/task" method="post">

				<table cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center">

					<input type="hidden" id="flag" value="${flag}"/>

					<tr>
						<td style="width: 20%" class="EditHead">

							<font color="red">*</font>&nbsp;事项名称
						</td>
						<!--标题栏-->
						<td   colspan="3" class="editTd">
							<s:textarea name="audTask.taskName"
								cssStyle="width:100%;height:60;"  cssClass='noborder'/>
							<!--一般文本框-->

						</td>
						 
					</tr>


					<s:hidden name="audTask.taskTemplateId" />
					<s:hidden name="audTask.taskPid" />
					<s:hidden name="audTask.template_type" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTask.templateId" />
					<s:hidden name="audTask.id" />
					<s:hidden name="audTask.project_id" />
					<tr style='display:none;'>
									<td style="width: 20%" class="EditHead" >
										<font color="red">*</font>&nbsp;&nbsp;事项序号
									</td>
									<td class="editTd">
				       				<s:textfield name="audTask.taskOrder"  cssStyle="width:80%" maxlength="10"  cssClass='noborder'/>									
								</td>
						<td style="width: 20%" class="EditHead">

							<font color="red">*</font>&nbsp;事项编码
						</td>
						<td style="width: 30%" class="editTd">
 					       <s:textfield name="audTask.taskCode" readonly="true" cssStyle="width:80%"  cssClass='noborder'
								maxlength="20" />
							<%--<s:hidden name="audTask.taskCode" /> --%>
						</td>								
					</tr>
					<!-- <tr>
						<td style="width: 20%" class="EditHead"> -->
						<!--  
							<s:if test="${team=='1'}">
								<font color="red"></font>执行小组
                        </s:if>
							<s:else>
								<font color="red"></font>执行人
						</s:else>
						-->
			<!-- 					执行人

						</td>
					
						<td colspan="3" class="editTd"> -->
						<!--  
							<s:if test="${team=='1'}">
								<s:select list="listReMember" 
									listValue="group" 
									listKey="groupId"  
									id="audTask_taskGroupAssign"
									name="audTask.taskGroupAssign" 
									value="" cssStyle='width:170px;'>
									</s:select>		
									<s:hidden name="audTask.taskGroupAssignName" id="audTask_taskGroupAssignName" />
																
							</s:if>
							<s:else>
								<s:select list="listReMember" listValue="user_name" listKey="user_code"   headerKey="" headerValue=""
									id="audTask_taskAssign"  
									name="audTask.taskAssign"  
									cssStyle='width:165px;'>
								</s:select>
								<s:hidden name="audTask.taskAssignName" id="audTask_taskAssignName"/>
							</s:else>
							-->
<%-- 							<s:select list="listReMember" listValue="user_name" listKey="user_code"   headerKey="" headerValue=""
								id="audTask_taskAssign"  
								name="audTask.taskAssign"  
								cssStyle='width:165px;'>
							</s:select>
							<s:hidden name="audTask.taskAssignName" id="audTask_taskAssignName"/>						
						</td>
					</tr> --%>
					 <s:if test="'enabled' == '${shenjichengxu}'">
					 </s:if>
					 <s:else>
					 	<tr>
					 	   <s:hidden name="audTask.taskAssign" id="audTask_taskAssign"/>	
					 	   <s:hidden name="audTask.taskAssignName" id="audTask_taskAssignName"/>	
							<td style="width: 20%;" class="EditHead">
								事项开始时间
							</td>
							<td class="editTd">
							<input type="text"  id="taskStartTime" name="audTask.taskStartTime"  style="width: 150px"
							value="${audTask.taskStartTime}" editable="false"/>
							</td>
							<td style="width: 20%;" class="EditHead">
								事项结束时间
							</td>
							<td class="editTd">
							<input type="text"  id="taskEndTime" name="audTask.taskEndTime"  style="width: 150px"
								value="${audTask.taskEndTime}" editable="false"/>
							</td>

						</tr> 
						<tr>
							<td style="width: 20%" class="EditHead" >
								&nbsp;&nbsp;审计程序和方法<br><font color=DarkGray>(限2000字)</font>
							</td>
							<td colspan="3" class="editTd">
								<s:textarea name="audTask.taskOther" cssStyle="width:100%;height:80px;overflow-y:hidden;"  cssClass='noborder'/>
								<input type="hidden" id="audTask.taskOther.maxlength" value="2000">
						</td>
						</tr>
						<tr>
							<td style="width: 20%" class="EditHead">
								&nbsp;&nbsp;相关法律法规和监管规定<br><font color=DarkGray>(限2000字)</font>
							</td>
							<td colspan="3" class="editTd">
	 					       <s:textarea name="audTask.law" cssStyle="width:100%;height:80px;overflow-y:hidden;"  cssClass='noborder'/>
	 					       <input type="hidden" id="audTask.law.maxlength" value="2000">
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								所需资料<br><font color=DarkGray>(限2000字)</font>
							</td>
							<td class="editTd" colspan="3">
								<s:textarea name="audTask.taskTarget" 
									cssStyle="width:100%;height:80px;overflow-y:hidden;"  cssClass='noborder' />
									<input type="hidden" id="audTask.taskTarget.maxlength" value="2000">
							</td>
						</tr>
						<tr>
							<td style="width: 20%" class="EditHead">
								&nbsp;&nbsp;审计查证要点
								<br/><div style="text-align:right"><font color=DarkGray>(限5000字)</font></div>
							</td>
							<td colspan="3" class="editTd">
	 					       <s:textarea name="audTask.taskMethod" cssStyle="width:100%;height:80px;overflow-y:hidden;"  cssClass='noborder'/>
	 					       <input type="hidden" id="audTask.taskMethod.maxlength" value="5000">
							</td>
						</tr>
						<tr>
						<td class="EditHead">
							重点关注内容<br><font color=DarkGray>(限2000字)</font>
						</td>
						<td class="editTd" colspan="3" class="editTd">
							<s:textarea name="audTask.pointContent" cssStyle="width:100%;height:80px;overflow-y:hidden;"  cssClass='noborder'/>
							<input type="hidden" id="audTask.pointContent.maxlength" value="2000">
						</td>
					</tr>
					 </s:else>
                  <s:if test="'enabled' == '${shenjichengxu}'">
					<tr>


						<td class="EditHead">

							<font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项名称
						</td>
						<td class="editTd">
							<s:textfield name="audTask.taskBeforeName"
								cssStyle="width:80%;background-color: #EEF7FF;" readonly="true" />
						</td>

						<td class="EditHead">
							<font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项编码


						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield name="audTask.taskBeforeCode" cssStyle="width:80%"  cssClass='noborder'
								readonly="true" />
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/task/showTreeListSelect.action&a=a&code=${audTask.taskCode}&project_id=${project_id}&paraname=audTask.taskBeforeName&paraid=audTask.taskBeforeCode',420,320,'前置事项选择')"
								border=0 style="cursor: hand">
						</td>

					</tr>

					</tr>

					<tr>

						<td class="EditHead">
							&nbsp;&nbsp;&nbsp;是否必做
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:if test="${audTask.taskMust=='1'}">
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust">否
                        </s:if>
							<s:else>
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust" checked="checked">否
						</s:else>
						</td>

						<td>

						</td>
						<!--标题栏-->
						<td>

						</td>

					</tr>
					<tr>
						<td class="EditHead">
							&nbsp;&nbsp;&nbsp;审计目的
						</td>
						<td colspan="3" class="editTd"> 

						</td>

					</tr>
					<tr>

						<td  colspan="4" class="editTd">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audTask.taskTarget"  cssClass='noborder'
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>

					</tr>

					<tr>
						<td class="EditHead">
							&nbsp;&nbsp;&nbsp;备注
						</td>
						<td class="editTd"colspan="3" >

						</td>

					</tr>
					<tr>

						<td class="editTd" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
 
							<s:textarea name="audTask.taskFile"  cssClass='noborder'
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>


               </s:if>

				</table>

				<s:hidden name="newDoubt_type" />
				<s:hidden name="audTemplate.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
                <s:hidden name="audTask.taskPcode" />
                <s:hidden name="path" />
                <s:hidden name="node" />
                <s:hidden name="audTask.haveLevel" value="01"/>

			</s:form>
		</div>
	</body>
</html>
