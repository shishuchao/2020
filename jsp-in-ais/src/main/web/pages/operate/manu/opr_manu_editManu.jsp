<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<s:text id="title" name="'编辑审计底稿'"></s:text>
<html><head>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script lang="javascript">

    	//查看审计底稿反馈意见  
         function viewFeedback(s,q){
		    var title = "查看审计底稿反馈意见";
		     //showPopWin('${contextPath}/operate/feedback/viewFeedbackInfo.action?ms_id=${crudObject.formId}',700,350,title);
		     window.open('${contextPath}/operate/feedback/viewFeedbackInfo.action?feed_id='+s,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			}
		function test1(){
	        var name=document.getElementsByName("audManuscript.customName")[0].value;
	        var code=document.getElementsByName("audManuscript.customId")[0].value;
	        //alert(name);
	        //alert(code);
	        var nameArray=name.split(',');
	        var codeArray=code.split(',');
	        var strName='';
	        var strCode='';
	        var tt='';
	        for(var a=0;a<nameArray.length;a++){
	          strName=nameArray[a];
	          strCode=codeArray[a];
	          if(tt!=''){
	            tt=tt+'    '+'<a href=# onclick=go(\"';
	            tt+=strCode+'\")>'+strName+'</a>';
	          }else{
	            tt='<a href=# onclick=go(\"'+strCode+'\")>'+strName+'</a>';
	          }
	         
	        }
	       
	        p.innerHTML=tt+"<br />";
	        //setTimeout('Test();',1000);
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
			  alert("只能输入正整数,请重新输入");
			  return true ;   
			 }
		}

		//返回上级list页面
		function backList(){
			location.href = "${contextPath}/operate/manu/listTobeStarted.action?taskId=${taskId}&taskPid=${taskPid}&pro_id=${pro_id}";
		 
		}
		
		//返回上级list页面
		function backListPlan(){
			location.href = "${contextPath}/operate/manu/listTobeStarted.action?taskId=${taskId}&taskPid=${taskPid}&pro_id=${pro_id}";
		}
		
		//保存表单0
		function saveForm0(){
			document.getElementsByName('audManuscript.status')[0].value='0';
			saveForm()
		}
		
		//保存表单1
		function saveForm1(){
			document.getElementsByName('audManuscript.status')[0].value='1';
			saveForm()
		}

     
 

		//保存表单
		function saveForm(){
		
			var bool = true;//提交表单判断参数
			 	
			 	var v_3 = "audManuscript.ms_name";  // field
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
	    
 	
			//完成保存表单操作
			if(bool){
			var flag=window.confirm('确认提交吗?');//isSubmit
			if(flag==true){
			var url = "${contextPath}/operate/manu/saveManu.action";
			myform.action = url;
			myform.submit();
			}else{
				 	return false;
				 }
			}
		}


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
				var flag=window.confirm("您确认提交吗?");
				if(flag==true)
				{
					document.getElementById('submitButton').disabled=true;
					 
						myform.action="<s:url action="submit" includeParams="none"/>";
					  
					myform.submit();
				}
				else
				{
					return false;
				}
			}
		}




		//提交表单
		function submitForm(){
			var flag=window.confirm('确认提交吗?');
			if(flag==true){myform.submit();
			}else{
			return false;
			}
	    }
	    function regu(){
		   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		}
		
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
         function deleteFile(fileId,guid,isDelete,isEdit,appType){		
 			var boolFlag=window.confirm("确认删除吗?");
 			if(boolFlag==true)
 			{
 				//alert(guid);	
 				send('${contextPath}/commons/file/delFile.action?fileId='+fileId+'&&deletePermission='+isDelete+'&&isEdit='+isEdit+'&&guid='+guid+'&&appType=0',guid);
 			}
 		}
 		
 		function test(){
 		  document.getElementsByName('audManuscript.ms_status')[0].value='040';
 		  var d=document.getElementsByName('audManuscript.ms_status')[0].value;
 		  //alert(d);
 		}

</script>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<script type='text/javascript'
			src='${pageContext.request.contextPath}/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
<title><s:property value="#title"/></title>
<s:head/>
</head>

	

	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();test1()">
	</s:if>
	<s:else>
		<body onload="test1()">
	</s:else>
	
<center>
<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead"><s:property value="#title"/></td></tr>
</table>
<s:form id="myform"  action="submit" namespace="/operate/manu" onsubmit="test()">	

<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
	
 


	
					<tr class="titletable1">
						<td style="width: 20%">

							<font color="red"></font>&nbsp;&nbsp;&nbsp;底稿状态:
						</td>
						<!--标题栏-->
<td style="width: 30%">
<s:if test="audManuscript.ms_status == '010'">
	底稿草稿
</s:if>
<s:if test="audManuscript.ms_status == '020'">
	正在征求
</s:if>
<s:if test="audManuscript.ms_status == '030'">
	等待复核
</s:if>
<s:if test="audManuscript.ms_status == '040'">
	正在复核
</s:if>
<s:if test="audManuscript.ms_status == '050'">
	复核完毕
</s:if>

 					<!--  s:property value="audDoubt.doubt_status" /-->
							<s:hidden name="audManuscript.ms_status" />
						</td>

						<td style="width: 20%">&nbsp;&nbsp;&nbsp;底稿编码:
						</td>
						<!--标题栏-->
						<td style="width: 30%">
 					<s:property value="audManuscript.ms_code"/>
							<s:hidden name="audManuscript.ms_code" />
						</td>
					</tr>

<tr  class="titletable1">
<td>

&nbsp;&nbsp;&nbsp;底稿名称:</td><!--标题栏-->
<td>
<s:textfield  name="audManuscript.ms_name"/><!--一般文本框-->
 
</td>
<s:hidden name="audManuscript.customId" />
<s:hidden name="audManuscript.customName" />
<td>

&nbsp;&nbsp;&nbsp;审计事项编码:</td><!--标题栏-->
<td>
<s:property value="audManuscript.task_code"/><!--一般文本框-->
<s:hidden name="audManuscript.task_code" />
 
</td>
</tr>
<tr> <td class="titletable1">
							&nbsp;&nbsp;&nbsp;被审计单位
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audManuscript.audit_dept_name"
								cssStyle="width:100%;height:30;" />

						</td>
	</tr>
	<tr  class="titletable1">
<td>

&nbsp;&nbsp;&nbsp;审计事项名称:</td><!--标题栏-->
<td>
<s:property value="audManuscript.task_name"/><!--一般文本框-->
 <s:hidden name="audManuscript.task_name" />
</td>
<td>

&nbsp;&nbsp;&nbsp;项目名称:</td><!--标题栏-->
<td>
<s:property value="audManuscript.project_name"/><!--一般文本框-->
<s:hidden name="audManuscript.project_name" />
 
</td>
</tr>
	
	<tr  class="titletable1">
<td>

&nbsp;&nbsp;&nbsp;审计期间开始:</td><!--标题栏-->
<td>
<s:property value="audManuscript.manu_start"/><!--一般文本框-->
 <s:hidden name="audManuscript.manu_start" />
</td>
<td>

&nbsp;&nbsp;&nbsp;审计期间结束:</td><!--标题栏-->
<td>
<s:property value="audManuscript.manu_end"/><!--一般文本框-->
<s:hidden name="audManuscript.manu_end" />
 
</td>
</tr>
	<tr  class="titletable1">
<td>

&nbsp;&nbsp;&nbsp;提交人:</td><!--标题栏-->
<td>
<s:property value="audManuscript.ms_author_name"/><!--一般文本框-->
 <s:hidden name="audManuscript.task_id" />
 <s:hidden name="audManuscript.pro_id" />
  <s:hidden name="audManuscript.ms_author_name" />
  <s:hidden name="audManuscript.ms_author" />
</td>
<td>

&nbsp;&nbsp;&nbsp;提交日期:</td><!--标题栏-->
<td>
<s:property value="audManuscript.ms_date"/><!--一般文本框-->
<s:hidden name="audManuscript.ms_date" />
 
</td>
</tr>
<tr>
	<td class="titletable1">
							&nbsp;&nbsp;&nbsp;关联索引
						</td>
						<td class="titletable1" colspan="3">
                         
						</td>

					</tr>
			<tr>
	<td class="titletable1">
							&nbsp;&nbsp;&nbsp;自定义底稿
						</td>
						<td class="titletable1" colspan="3">
                               <span id="p"></span>
						</td>

					</tr>		
					
					
	<tr> <td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计记录
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audManuscript.ms_description"
								cssStyle="width:100%;height:110;" />

						</td>
	</tr>
	
		<tr> <td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计结论
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audManuscript.audit_con"
								cssStyle="width:100%;height:70;" />

						</td>
	</tr>
	
	
			<tr> <td class="titletable1">
							&nbsp;&nbsp;&nbsp;查阅资料
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audManuscript.audit_file"
								cssStyle="width:100%;height:70;" />

						</td>
	</tr>
	
			<tr> <td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计程序
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audManuscript.audit_method_name"
								cssStyle="width:100%;height:70;" />

						</td>
	</tr>
	<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;法规制度
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

							<s:textarea name="audManuscript.audit_law"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
					 
					 
 
					<s:hidden name="audManuscript.audit_regulation"/>
 

					<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
					<tr>
						<td class="ListTableTr11">
							<s:button
								onclick="Upload('audManuscript.file_id',file_idList,'true','true')"
								value="上传附件"></s:button>
							<s:hidden name="audManuscript.file_id" />
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="file_idList" align="center">
								<s:property escape="false" value="file_idList" />
							</div>

						</td>
					</tr>
	 
			<s:hidden name="pro_id" />
			<s:hidden name="taskPid" />
			<s:hidden name="taskId" />
			<s:hidden name="audManuscript.id" />
            <s:hidden name="audManuscript.feedback" />
			<s:hidden name="audManuscript.prom" />
            
</table>
 
 
<s:hidden name="audManuscript.formId"/>  
<div align="center">

 

 
<s:button  value="保存" onclick="saveForm();"/>&nbsp;&nbsp;
 
</div>

</s:form>
</center>
</body>
</html>
