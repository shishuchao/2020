<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<s:if test="crudObject.formId!=null">
	<s:text id="title" name="'修改审计底稿'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'增加审计底稿'"></s:text>
</s:else>

<html>
	<head>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>  
		<script lang="javascript">
     
        <%String pb = (String) request.getParameter("back");%>
        <%String owner = (String) request.getParameter("owner");//参数判断，是在我的任务页签还是实施方案页签打开%>
        <%
        String strOwner="";
        if("true".equals(owner)){
        	strOwner="-owner";
        }else{
        	strOwner="";
        }
        %>
       
        //返回上级list页面
        function backList()
          {
               if('<%=strOwner%>'=='-owner'){//参数判断，是在我的任务页签
                  var u='${pageContext.request.contextPath}/operate/manuExt/manuUiOwner.action?project_id=${crudObject.project_id}&taskId=${taskId}&taskPid=${crudObject.task_id}'
				  window.location.href=u;
               }else{//参数判断，是实施方案页签打开
                  var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?project_id=${crudObject.project_id}&taskId=${taskId}&taskPid=${crudObject.task_id}'
				  window.location.href=u;
               }
               
               window.parent.hidePopWin(false);
        }
       
        
        //小组选择
        function getGroup(){
          var code=document.getElementsByName("crudObject.groupId")[0].value; 
          var num=Math.random();
		  var rnm=Math.round(num*9000000000+1000000000);
          var url='/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/task/selectDept.action&a=a&x='+rnm+'&group_id='+code+'&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept';
           //alert(url);
          if(code=null||code==""){
             alert("请先选择所属小组!");
             return false;
          }
          showPopWin(url,500,330,'被审计单位选择');
        }   
        //小组选择
        function  getOwerGroup(){
            var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
        	var code=document.getElementsByName("crudObject.project_id")[0].value; 
        	 
        	showPopWin('/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectGroup.action&a=a&x='+rnm+'&project_id='+code+'&paraname=crudObject.groupName&paraid=crudObject.groupId',500,330,'所属小组选择');
        }  
       
	    
        
        //关闭
        function closeGenM(){
         window.parent.closeGenW('MS');
         window.close()
       }
       

	    
		  function noblank(txtObject){
                   if(txtObject.value.replace(/\s+$|^\s+/g,"")=="null"){
                        window.alert("不能输入'null'!");
				         return false;
                   }
                   
                   if(txtObject.value.replace(/\s+$|^\s+/g,"")=="NULL"){
                        window.alert("不能输入'NULL'!");
				         return false;
                   }
                   return true;

           }	
	           
             </script>
		     <script language="javascript">
             
             //验证输入的内容
             function check(){
	           var v_3 = "crudObject.ms_name";  // field
	           var title_3 = '底稿名称';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>100){
	             alert("底稿名称的长度不能大于100字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }  	


	           var v_3 = "crudObject.audit_dept_name";  // field
	           var title_3 = '被审计单位';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>2000){
	             alert("被审计单位的长度不能大于2000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            var v_3 = "crudObject.audit_dept";  // field
	            var title_3 = '被审计单位';// field name
	            var notNull = 'true'; // notnull
	            var t=document.getElementsByName(v_3)[0].value;
	            if(t.length>2000){
	              alert("被审计单位的长度不能大于2000字！");
	              document.getElementById("crudObject.audit_dept_name").focus();
	              return false;
	            }
	            var v_3 = "crudObject.linkManuName";  // field
	            var title_3 = '引用底稿';// field name
	            var notNull = 'true'; // notnull
	            var t=document.getElementsByName(v_3)[0].value;
	       	    if(t.length>2000){
	              alert("引用底稿的长度不能大于2000字！");
	              document.getElementById(v_3).focus();
	              return false;
	            } 
	            var v_3 = "crudObject.linkManuId";  // field
	            var title_3 = '引用底稿';// field name
	            var notNull = 'true'; // notnull
	            var t=document.getElementsByName(v_3)[0].value;
	            if(t.length>2000){
	              alert("引用底稿的长度不能大于2000字！");
	              document.getElementById("crudObject.linkManuName").focus();
	              return false;
	             }
	             var v_3 = "crudObject.ms_description";  // field
	             var title_3 = '审计记录';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>3000){
	             alert("审计记录的长度不能大于3000字！");
	             document.getElementById(v_3).focus();
	             return false;
	             } 
                    
	             var v_3 = "crudObject.audit_con";  // field
	             var title_3 = '审计结论';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>5000){
	             alert("审计结论的长度不能大于5000字！");
	             document.getElementById(v_3).focus();
	             return false;
	             }    
                   
	             var v_3 = "crudObject.audit_file";  // field
	             var title_3 = '查阅资料';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>3000){
	             alert("查阅资料的长度不能大于3000字！");
	             document.getElementById(v_3).focus();
	             return false;
	             }                   
                   
	             var v_3 = "crudObject.audit_method_name";  // field
	             var title_3 = '审计程序';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>3000){
	             alert("审计程序的长度不能大于3000字！");
	             document.getElementById(v_3).focus();
	             return false;
	             }                   
                   
	             var v_3 = "crudObject.audit_law";  // field
	             var title_3 = '法律法规';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>3000){
	             alert("法律法规的长度不能大于3000字！");
	             document.getElementById(v_3).focus();
	             return false;
	             }

	             var v_3 = "crudObject.audit_regulation";  // field
	             var title_3 = '规章制度';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>3000){
	             alert("规章制度的长度不能大于3000字！");
	             document.getElementById(v_3).focus();
	             return false;
	             }

	             var v_3 = "crudObject.audit_dept_feedback";  // field
	             var title_3 = '底稿反馈意见';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
	             alert("底稿反馈意见的长度不能大于2000字！");
	             document.getElementById(v_3).focus();
	             return false;
	             }
	             return true;
	             }

	             //保存表单
	             function saveForm(){

	             var bool = true;//提交表单判断参数

   	             var v_3 = "crudObject.ms_name";  // field
	             var title_3 = '底稿名称';// field name
	             var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }

                 v_3 = "crudObject.groupName";  // field
                 title_3 = '所属小组';// field name
                 var notNull = 'true'; // notnull
                 	         /*   if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    } */
                                    
                  v_3 = "crudObject.audit_dept_name";  // field
                 title_3 = '被审计单位';// field name
                 var notNull = 'true'; // notnull
                 	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    }                    
                                    
              if( !check()){
                 return false;
              }    

 	
			   //完成保存表单操作
			   if(bool){
			    var flag=window.confirm('确认保存吗?');//isSubmit
			     if(flag==true){
			//    var t=document.getElementById('subModelHTML');
			//	document.getElementById('crudObject.subModelHTML').value=t.innerHTML;
			    var url = '${contextPath}/operate/manu/save.action?back=<%=pb%>';
			     myform.action = url;
			     document.getElementsByName("root")[0].disabled=true;
			     myform.submit();
			     }else{
				 	 return false;
				  }
			    }
			}
			
			function doStart(){
				document.getElementById('myform').action = "start.action";
				document.getElementById('myform').submit();
			}					

          //提交
	      function toSubmit(act)
	      {
	         
		   {  
			 <s:if test="isUseBpm=='true'">
			 if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
			 {
				 var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
				 if(actor_name=='')
				 {
					window.alert('下一步处理人不能为空！');
					return false;
				 }
			  }
			  </s:if>
			
			
			    var bool = true;//提交表单判断参数

	            var v_3 = "crudObject.ms_name";  // field
	            var title_3 = '底稿名称';// field name
	            var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }

                 v_3 = "crudObject.groupName";  // field
                 title_3 = '所属小组';// field name
                 var notNull = 'true'; // notnull
                 	 /*           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    }
                                     */
                  v_3 = "crudObject.audit_dept_name";  // field
                 title_3 = '被审计单位';// field name
                 var notNull = 'true'; // notnull
                 	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    }                    
                                    
              if( !check()){
                 return false;
              }    

 	
	       //完成保存表单操作
	       if(bool){
	    	   parent.$.messager.confirm('确认对话框', '您确认提交吗?', function(r) {
			  		if (r) {
			  			document.getElementById('submitButton').disabled=true;
						myform.action="<s:url action="submit" includeParams="none"/>";
						myform.submit();
			  		}else{
			  			return false;
			  		}
			  		
			  	});
		}
	}

}
			//提交表单
			function submitForm(){
			    var v_3 = "crudObject.ms_name";  // field
				var title_3 = '底稿名称';// field name
				var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }

                 v_3 = "crudObject.groupName";  // field
                 title_3 = '所属小组';// field name
                 var notNull = 'true'; // notnull
                 	/*            if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    } */
      			if( !check()){
                 	return false;
              	}    
    
    			if(document.getElementsByName("formInfo.toActorId_name")[0]!=null&&document.getElementsByName("formInfo.toActorId_name")[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert("请选择下一步处理人！");
				         bool = false;
				         document.getElementById("formInfo.toActorId_name").focus();
				         return false;
		           }
				var flag=window.confirm('确认提交吗?');
				if(flag==true){
				 
				 document.getElementById("submitButton").disabled=true;
				 myform.submit();
				}else{
				return false;
				}
    	}
    	//法规制度
    	function regu(){
	   		window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		}
	    //法规制度
		function law(){
		   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
		}
		//上传附件
		function Upload(id,filelist,delete_flag,edit_flag){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_manuscript_operate&table_guid=file_id&guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
          function reloadHomeAfterSubmitFlow(){
        		try{
        	    	// 是否来自审计作业页面
        	   		var isJobPage = false;
        	     	var bodyId = top.document.body.id;
        	     	//alert(bodyId)
        	    	if(bodyId == 'projectLayout'){
        	        	isJobPage = true;
        	      	}else if(bodyId == 'mainLayout'){
        	          	isJobPage = false;
        	      	}
        	     	var pageWin = isJobPage ? window.top.opener.parent : window.top; 
        	     	//alert(pageWin.reloadHomePage)
        			if(pageWin && pageWin.reloadHomePage){
        	       		pageWin.reloadHomePage();
        			}
        		}catch(e){
        			//alert('reloadHomeAfterSubmitFlow:\n'+e.message);
        		}
        	}
 		
 		function testStatus(){
 		  document.getElementsByName('crudObject.ms_status')[0].value='040';
 		  var d=document.getElementsByName('crudObject.ms_status')[0].value;
 		  //alert(d);
 		}
 		$(function(){ 
 			if($("#sucFlag").val()=='1'){
    			$("#sucFlag").val('');
    			parent.close_bat();
    			top.$.messager.show({
					title:'提示信息',
					msg:"提交成功!",
					timeout:5000,
					showType:'slide'
				});
    			parent.reload_bat();
    			reloadHomeAfterSubmitFlow();
    		}  
 		/* 	  var manuType=document.getElementsByName('crudObject.manuType');
 			  if( manuType != null && manuType[0].value != null && "undefined" != manuType[0].value ){
 				 manuTypefun(manuType[0].value);
 			  } */
 			
 		});
	
</script>
		 
		 
		 
		 
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>



	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();"  class="easyui-layout">
	</s:if>
	<s:else>
		<body onload=""  class="easyui-layout">
	</s:else>
	<div  region="center"  style="overflow:auto;">
	<s:form id="myform" action="submit" namespace="/operate/manu" onsubmit="testStatus()">
	<div style="display: none;">
		<table>
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					<s:property value="#title" />
				</td>
			</tr>
		</table>
		
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">





				<tr class="titletable1">
					<td style="width: 20%">

						<font color="red"></font>&nbsp;&nbsp;&nbsp;底稿状态:
					</td>
					<!--标题栏-->
					<td style="width: 30%">
						<s:if test="crudObject.ms_status == '010'">
	                         底稿草稿
                        </s:if>
						<s:if test="crudObject.ms_status == '020'">
	                         正在征求
                        </s:if>
						<s:if test="crudObject.ms_status == '030'">
	                         等待复核
                        </s:if>
						<s:if test="crudObject.ms_status == '040'">
	                         正在复核
                        </s:if>
						<s:if test="crudObject.ms_status == '050'">
	                         复核完毕
                        </s:if>

						<!--  s:property value="audDoubt.doubt_status" /-->
						<s:hidden name="crudObject.ms_status" />
						<input type="hidden" id="attendMemberIds" name="crudObject.attendMemberIds" value="${crudObject.attendMemberIds}"/>	
						<input type="hidden" id="attendMemberNames" name="crudObject.attendMemberNames" value="${crudObject.attendMemberNames}"/>						
					</td>

					<td style="width: 20%">
						&nbsp;&nbsp;&nbsp;底稿编码:
					</td>
					<!--标题栏-->
					<td style="width: 30%">
						<s:property value="crudObject.ms_code" />
						<s:hidden name="crudObject.ms_code" />
					</td>
				</tr>

				<tr class="titletable1">
					<td>
						<font color="red">*</font> 底稿名称:
					</td>
					<!--标题栏-->
					<td>
						<s:textfield name="crudObject.ms_name" />
						<!--一般文本框-->

					</td>
					<s:hidden name="crudObject.customId" />
					<s:hidden name="crudObject.customName" />
					<s:hidden name="crudObject.subms_date" />
					<td>

						&nbsp;&nbsp;&nbsp;审计事项编码:
					</td>
					<!--标题栏-->
					<td>
						<s:property value="crudObject.task_code" />
						<!--一般文本框-->
						<s:hidden name="crudObject.task_code" />

					</td>
				</tr>

				<tr class="titletable1">
					<td>

						<font color="red">*</font> 所属小组:
					</td>
					<!--标题栏-->
					<td>
						<s:textfield name="crudObject.groupName" cssStyle="width:80%"
							readonly="true" />
						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getOwerGroup()" border=0 style="cursor: hand">
						<s:hidden name="crudObject.groupId" />
					</td>

					<td>
					</td>
					<!--标题栏-->
					<td>
					</td>

				</tr>

				<tr>
					<td class="titletable1">
						<font color="red">*</font> 被审计单位:
					</td>
					<td class="titletable1" colspan="3">

						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getGroup();" border=0 style="cursor: hand">
					</td>

				</tr>
				<tr>

					<td class="ListTableTr22" colspan="4">

						<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

						<s:textarea name="crudObject.audit_dept_name" readonly="true"
							cssStyle="width:100%;height:25;" />

					</td>
					<s:hidden name="crudObject.audit_dept" />
				</tr>
				<tr class="titletable1">
					<td>

						&nbsp;&nbsp;&nbsp;审计事项名称:
					</td>
					<!--标题栏-->
					<td>
						<s:property value="crudObject.task_name" />
						<!--一般文本框-->
						<s:hidden name="crudObject.task_name" />
					</td>
					<td>

						&nbsp;&nbsp;&nbsp;项目名称:
					</td>
					<!--标题栏-->
					<td>
						<s:property value="crudObject.project_name" />
						<!--一般文本框-->
						<s:hidden name="crudObject.project_name" />

					</td>
				</tr>

				<tr class="titletable1">
					<td>

						&nbsp;&nbsp;&nbsp;审计期间开始:
					</td>
					<!--标题栏-->
					<td>
						<s:property value="crudObject.manu_start" />
						<!--一般文本框-->
						<s:hidden name="crudObject.manu_start" />
						<s:hidden name="crudObject.audit_found" />
						<s:hidden name="crudObject.audit_matter" />
					</td>
					<td>

						&nbsp;&nbsp;&nbsp;审计期间结束:
					</td>
					<!--标题栏-->
					<td>
						<s:property value="crudObject.manu_end" />
						<!--一般文本框-->
						<s:hidden name="crudObject.manu_end" />

					</td>
				</tr>
				<tr class="titletable1">
					<td>

						&nbsp;&nbsp;&nbsp;提交人:
					</td>
					<!--标题栏-->
					<td>
						<s:property value="crudObject.ms_author_name" />
						<!--一般文本框-->
						<s:hidden name="crudObject.task_id" />
						<s:hidden name="crudObject.project_id" />
						<s:hidden name="crudObject.ms_author_name" />
						<s:hidden name="crudObject.ms_author" />
					</td>
					<td>

						&nbsp;&nbsp;&nbsp;创建日期:
					</td>
					<!--标题栏-->
					<td>
						<s:property value="crudObject.ms_date" />
						<!--一般文本框-->
						<s:hidden name="crudObject.ms_date" />

					</td>
				</tr>
				<tr>
					<td class="titletable1">
						&nbsp;&nbsp;&nbsp;关联索引:
					</td>
					<td class="titletable1" colspan="3">
						<span id="p1"></span>
					</td>

				</tr>

				<tr>
					<td class="titletable1">

						<font color="red"></font>&nbsp;&nbsp;&nbsp;引用底稿:
					</td>
					<td class="titletable1">
						<s:textfield name="crudObject.linkManuName" cssStyle="width:80%"
							readonly="true" />
						<!--一般文本框-->
						<s:hidden name="crudObject.linkManuId" />
						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getOwerManu()" border=0 style="cursor: hand">
					</td>
					<td class="titletable1" colspan="2">


					</td>

				</tr>
				<tr>
					<td class="titletable1">

						&nbsp;
					</td>
					<td class="titletable1" colspan="3">
						<span id="p2"></span>
					</td>


				</tr>

				<tr>
					<td class="titletable1">
						&nbsp;&nbsp;&nbsp;审计记录:
					</td>
					<td class="titletable1" colspan="3">
					<!-- 下面补充参数用 -->
					 <s:textarea name="crudObject.audit_record"/>
					 <s:textarea name="crudObject.audit_advice"/>
					</td>

				</tr>
				<tr>

					<td class="ListTableTr22" colspan="4">
						<s:hidden name="crudObject.interact" />
						<s:if test="crudObject.interact==1">
							<div id="subModelHTML" runat="server"
								style="border-style: none; left: 0px; overflow: scroll; width: 100%; position: relative; top: 0px; height: 260px;">

								<s:property escape="false" value="crudObject.subModelHTML" />
							</div>
						<s:hidden name="crudObject.subModelHTML" />
							<s:hidden name="crudObject.ms_description" />

						</s:if>
						<s:if test="crudObject.interact==2">
							<div id="subModelHTML" runat="server"
								style="border-style: none; left: 0px; overflow: scroll; width: 100%; position: relative; top: 0px; height: 260px;">

								<s:property escape="false" value="crudObject.subModelHTML" />
							</div>
					<s:hidden name="crudObject.subModelHTML" />
							<s:hidden name="crudObject.ms_description" /> 

						</s:if>
						<s:else>
					<%-- 		<s:hidden name="crudObject.subModelHTML" />
							<s:hidden name="subModelHTML" /> --%>
							<s:textarea name="crudObject.ms_description"
								cssStyle="width:100%;height:70;" />
						</s:else>
					</td>
				</tr>

				<tr>
					<td class="titletable1">
						&nbsp;&nbsp;&nbsp;审计结论:
					</td>
					<td class="titletable1" colspan="3">

					</td>

				</tr>
				<tr>

					<td class="ListTableTr22" colspan="4">

						<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

						<s:textarea name="crudObject.audit_con"
							cssStyle="width:100%;height:70;" />

					</td>
				</tr>


				<tr>
					<td class="titletable1">
						&nbsp;&nbsp;&nbsp;查阅资料:
					</td>
					<td class="titletable1" colspan="3">

					</td>

				</tr>
				<tr>

					<td class="ListTableTr22" colspan="4">

						<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

						<s:textarea name="crudObject.audit_file"
							cssStyle="width:100%;height:70;" />

					</td>
				</tr>

				<tr>
					<td class="titletable1">
						&nbsp;&nbsp;&nbsp;审计程序:
					</td>
					<td class="titletable1" colspan="3">

					</td>

				</tr>
				<tr>

					<td class="ListTableTr22" colspan="4">

						<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

						<s:textarea name="crudObject.audit_method_name"
							cssStyle="width:100%;height:70;" />

					</td>
				</tr>
				<tr>
					<td class="titletable1">
						&nbsp;&nbsp;&nbsp;法规制度:
					</td>
					<td class="titletable1" colspan="3">
						<input type="button" value="查看法规制度" onclick="law()" />
					</td>

				</tr>
				<tr>

					<td class="ListTableTr22" colspan="4">

						<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

						<s:textarea name="crudObject.audit_law"
							cssStyle="width:100%;height:70;" />

					</td>
				</tr>

				  

						<s:hidden name="crudObject.audit_regulation"/>

					 

				<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
				<tr>
					<td class="ListTableTr11">
						<s:button
							onclick="Upload('crudObject.file_id',file_idList,'true','true')"
							value="上传附件"></s:button>
						<s:hidden name="crudObject.file_id" />
					</td>
					<td class="ListTableTr22" colspan="3">
						<div id="file_idList" align="center">
							<s:property escape="false" value="file_idList" />
						</div>

					</td>
				</tr>

				<s:if test="digaofankui=='enabled'">
					<tr class="listtablehead">

						<td colspan="5" align="left" class="edithead">
							&nbsp;底稿反馈信息
						</td>



					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;反馈意见:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>

					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="crudObject.audit_dept_feedback"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
				</s:if>
				<s:else>
					<s:hidden name="crudObject.audit_dept_feedback" />
				</s:else>
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<s:hidden name="back" value="<%=pb%>" />
				<s:hidden name="crudObject.id" />
				<s:hidden name="crudObject.task_code_sort" />
				<s:hidden name="crudObject.ms_code_sort" />
				<s:hidden name="taskInstanceId" />
				<s:hidden name="crudObject.prom" />
                <s:hidden name="crudObject.feedback" /> 
                <s:hidden name="crudObject.describe" />
                <s:hidden name="crudObject.batch"/>
                <s:hidden name="crudObject.manuType"/> 
                <s:hidden name="owner" />
			</table>
           </div>
           <table cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center">
		<tr>
			 
			<td width=34% class="EditHead">
				<center>
					底稿名称
				</center>
			</td>
			<td width=33% class="EditHead">
				<center >
					底稿作者
				</center>
			</td>
			<td width=33% class="EditHead">
				<center>
					创建日期
				</center>
			</td>
			 
		</tr>
		<s:iterator value="manuInfoList">
			<tr>
				<td class="editTd">
				<center>
					<s:property value="ms_name" />
				</center>
				</td>
				<td class="editTd">
					<center>
						<s:property value="ms_author_name" />
					</center>
				</td>
				<td class="editTd" >
				<center>
					<s:property value="ms_date" />
					</center>
				</td>
				 
			</tr>
		</s:iterator>
		<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
	  </table>
			<%@include file="/pages/bpm/list_transition.jsp"%>
			<s:hidden name="crudObject.formId" />
			<div align="center">
				<s:if test="crudObject.formId!=null">
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />&nbsp;&nbsp;
					
			    </s:if>
			</div>
			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
			
		</s:form>
		</div>
	</body>
</html>
