<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>



<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />编辑审计类别
		</title>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script language="javascript">
	$(function(){
		if($("#flag").val()=='s'){
			$("#flag").val("");
			$.messager.show({
				title:'提示信息',
				msg:'保存成功!',
				timeout:5000,
				showType:'slide'
			});
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
		
		$('#audTask_taskGroupAssign').bind('change', function(){
			var text = $(this).find("option:selected").text();
			if(text){
				$('#audTask_taskGroupAssignName').val(text);
			}
		});
		
	});
	
	function flush(){
	    var flush='<%=request.getParameter("flush")%>'
 		if(flush=='true'){
 			window.parent.parent.frames['f_left'].locationTaskTreeNode('${audTask.taskTemplateId}','${audTask.taskName}', true);
 		}
	  
	}

	function closeW(){
		parent.closeW();
	}
	function check(){

		var v_3 = "audTask.taskName";  // field
		var title_3 = '事项名称';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>1200){
			top.$.messager.alert("提醒","事项名称的长度不能大于1200字！",'error');
		document.getElementById(v_3).focus();
		return false;
		} 
    if('enabled' == '${shenjichengxu}'){
		var v_3 = "audTask.taskTarget";  // field
		var title_3 = '审计目的';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
			top.$.messager.alert("提醒","审计目的的长度不能大于2000字！",'error');
		document.getElementById(v_3).focus();
		return false;
		} 

		var v_3 = "audTask.taskFile";  // field
		var title_3 = '备注';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
			top.$.messager.alert("提醒","备注的长度不能大于2000字！",'error');
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
			 top.$.messager.alert("提醒","事项序号只能输入正整数,请重新输入!",'error');
		  return true ;   
		 }
	}
	//-------保存表单
  	function saveFormType(){
       var auth='';
       DWREngine.setAsync(false);
	   DWREngine.setAsync(false);
	   DWRActionUtil.execute(
	   { namespace:'/operate/task', 
		 action:'checkSubTask',
		 executeResult:'false' }, 
	   {'project_id':'<%=request.getParameter("project_id")%>','taskTemplateId':'<%=request.getParameter("taskTemplateId")%>'},xxx);
	    function xxx(data){
		  auth =data['auth'];
		}
				 
		  if(auth=='1'||auth=='3'){
		 
		 }else{
			 top.$.messager.alert("提醒","请刷新审计方案树,该审计事项已是末级节点,不能增加下级审计事项!",'error');
			 return false;
		 }
			var v_3 = "audTask.taskName";  // field
			var title_3 = '事项名称';// field name
			var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
	        	   top.$.messager.alert("提醒",title_3+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                	 top.$.messager.alert("提醒",title_3+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }
                   
				var v_5 =  "audTask.taskOrder"

				var title_5 = '事项序号';// field name
				var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_5)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
	        	   top.$.messager.alert("提醒",title_5+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_5).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_5)[0].value.replace(/\s+$|^\s+/g,"")==""){
                	 top.$.messager.alert("提醒",title_5+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_5).focus();
				         return false;
                   }


			var s5 = document.getElementsByName(v_5)[0].value;
			if(onlyNumbers1(s5)){
			 document.getElementById(v_2).focus();
			return false;
			}	 				


			var v_2 =  "audTask.taskCode";

			var title_2 = '事项编号';// field name
			var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
	        	   top.$.messager.alert("提醒",title_2+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
                	 top.$.messager.alert("提醒",title_2+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
                   }
                   

                 var a = $('#taskStartTime').val();
 				var b = $('#taskEndTime').val();
 				if(a>b){
 					top.$.messager.alert("提醒",'[结束日期]应大于等于[开始日期]','error');
 					$('#taskStartTime').val('').focus();
 					return false;
 				}
 				


			//var s = document.getElementsByName(v_2)[0].value;
			/*if(onlyNumbers1(s)){
			 document.getElementById(v_2).focus();
			return false;
			}*/
			//alert(document.getElementsByName("audTask.taskCode")[0].value)
			
			if(!check()){
			  return false;
			}

			document.getElementsByName("root")[0].disabled=true;
			var h='<%=request.getParameter("new")%>'
			if(h=='old'){
			   var url = "${contextPath}/operate/task/saveType.action?node=${node}&path=${path}&addtype=true&selectedTab=<%=request.getParameter("selectedTab")%>";
			   myform.action = url;
			   myform.submit();
			}else {
			var url = "${contextPath}/operate/task/saveType.action?node=${node}&path=${path}&addtype=true&new=true&selectedTab=<%=request.getParameter("selectedTab")%>";
			myform.action = url;
			myform.submit();
			
			}
			window.parent.parent.parent.frames['f_left'].location.reload();
			
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
				 top.$.messager.alert("提醒","请刷新审计方案树,该审计事项已是末级节点,不能增加下级审计事项!","warning");
				 return false;
			 }



				var v_3 = "audTask.taskName";  // field
				var title_3 = '事项名称';// field name
				var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
	        	   		top.$.messager.alert("提醒",title_3+"不能为空!","error");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                	 	top.$.messager.alert("提醒",title_3+"不能为空!",'error');
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }

			if(!check()){
			  return false;
			}
			document.getElementsByName("root")[0].disabled=true;
			//document.getElementsByName("root2")[0].disabled=true;
			var h='<%=request.getParameter("new")%>'
			if(h=='old'){
			   var url = "${contextPath}/operate/task/saveTypeAgain.action?selectedTab=<%=request.getParameter("selectedTab")%>";
			   myform.action = url;
			   myform.submit();
			}else {
			var url = "${contextPath}/operate/task/saveTypeAgain.action?node=${node}&path=${path}&addtype=true&new=true&selectedTab=<%=request.getParameter("selectedTab")%>";
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
	<body onload="flush()"  style="overflow:hidden;margin:0px;padding:0px;">
		
		
			<div class="editHead" style="margin-left:-10px;width:100%;text-align:right; height:35px; line-height:32px;">
                <a href='javascript:void(0);' class="easyui-linkbutton" onclick="saveFormType();"  name="root" iconCls="icon-save">保存</a>&nbsp;
                <a href='javascript:void(0);'  class="easyui-linkbutton" onclick="closeW();"  iconCls="icon-cancel">关闭</a>
			</div>
			<div style="overflow:auto">
				<center>
				<s:form id="myform" onsubmit="return true;" action="/ais/operate/task" method="post">
					<table cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center">
					<input type="hidden" id="flag" value="${flag}"/>
						<tr>
							<td  class="EditHead">
								<font color="red">*</font>&nbsp;事项类别名称
							</td>
							<!--标题栏-->
							<td   colspan="3" class="editTd">
								<s:textfield name="audTask.taskName" id="taskName" cssClass='noborder'/>		
								<!--一般文本框-->
							</td>
						</tr>
							<tr >
								<td class="EditHead">
									事项开始时间
								</td>
								<td class="editTd">
									<%-- <input type="text"  id="taskStartTime" name="audTask.taskStartTime" class="easyui-datebox" style="width: 150px"
										value="${audTask.taskStartTime}" editable="false"/> --%>
									<input type="text"  id="taskStartTime" name="audTask.taskStartTime" class="easyui-datebox" style="width: 150px"
									value="${audTask.taskStartTime}" editable="false"/>
								</td>
								<td  class="EditHead">
									事项结束时间
								</td>
								<td class="editTd">
									<input type="text"  id="taskEndTime" name="audTask.taskEndTime" class="easyui-datebox" style="width: 150px"
										value="${audTask.taskEndTime}" editable="false"/>
								</td>
							</tr> 
							<tr style='display:none;' >
							<td  class="EditHead" >
								<font color="red">*</font>&nbsp;事项序号
							</td>
							<td class="editTd">
						       	<s:textfield name="audTask.taskOrder"  maxlength="10" cssClass='noborder'/>									
							</td>							
							<td  class="EditHead">
								<font color="red">*</font>&nbsp;事项编码
							</td >
							<td class="editTd">
		 					    <s:textfield name="audTask.taskCode" cssClass='noborder'
									maxlength="20" />
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
						<tr style="display:none;">
							<td class="EditHead">
								<s:if test="${team=='1'}">
									<font color="red"></font>执行小组
	                        </s:if>
								<s:else>
									<font color="red"></font>执行人
							</s:else>
							
							执行人
							</td>
							<!--标题栏-->
							<td colspan="3" class="editTd">
								<s:if test="${team=='1'}">
								   <!--  
									<s:select list="listReMember" listValue="group" listKey="groupId"  name="audTask.taskGroupAssignName" value="" cssStyle='width:170px;'>
 									</s:select>
 									<s:hidden name="audTask.taskGroupAssign" />
 									<s:hidden name="audTask.taskGroupAssignName" />		
 									-->		
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
									<!--  
									<s:select list="listReMember" listValue="user_name" listKey="user_code"  
									name="audTask.taskAssignName" value="" cssStyle='width:170px;'>
	 								</s:select>
									<s:hidden name="audTask.taskAssignName" />
									<s:hidden name="audTask.taskAssign" />
									-->
									<s:select list="listReMember" listValue="user_name" listKey="user_code"  
										id="audTask_taskAssign"  
										name="audTask.taskAssign"  
										headerKey="" headerValue=""
										cssStyle='width:170px;'>
									</s:select>
									<s:hidden name="audTask.taskAssignName" id="audTask_taskAssignName"/> 
								</s:else>
							</td>
							
							
						</tr>
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
				</center>
			</div>

		
	</body>
</html>
