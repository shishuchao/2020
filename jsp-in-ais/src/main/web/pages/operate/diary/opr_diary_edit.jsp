<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<s:text id="title" name="'编辑审计日记'"></s:text>


<html>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cloud/styles/extjs/resources/css/ext-all.css" /> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/css/ux-all.css" /> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cloud/styles/css/common.css"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cloud/styles/css/color-blue.css" /> 
<script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/jquery.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/ext-jquery-adapter.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/ext-all.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/StatusBar.js"> </script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/ColumnNodeUI.js"> </script> 
  <script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTabPanel.js"> </script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTab.js"> </script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/extjs/locale/ext-lang-zh_CN.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/js/main.js"></script> 
 <script type="text/javascript" src="${pageContext.request.contextPath}/cloud/styles/js/ui.js"></script> 
	<script language="javascript">

	function check(){

		var v_3 = "audDiary.diary_name";  // field
		var title_3 = '日记名称';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>200){
		alert("日记名称的长度不能大于200字！");
		document.getElementById(v_3).focus();
		return false;
		}

		var v_3 = "audDiary.diary_file";  // field
		var title_3 = '查阅资料';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("查阅资料的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		}

		var v_3 = "audDiary.diary_prof";  // field
		var title_3 = '专业判断/查证结果';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("专业判断/查证结果的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		}

		var v_3 = "audDiary.diary_method";  // field
		var title_3 = '程序/方法 ';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("程序/方法的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		}

		var v_3 = "audDiary.diary_matter";  // field
		var title_3 = '审计事项  ';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("审计事项的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		}

		var v_3 = "audDiary.diary_other";  // field
		var title_3 = '其他';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("其他的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		}

		return true;
	}
		 //生成
      function generateMS(s)
		  {
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限操作！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能执行操作！");
		                    return false;
		                  }else{
		              }
		     d_id=document.getElementsByName("doubt_id")[0].value;
		     n_type='MS';
		     var title = "生成审计底稿";
		     //d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/doubt/genManu.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+s+'&&project_id=${project_id}',700,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
	} 
	
	 //生成
      function generate(s)
		  {
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限操作！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能执行操作！");
		                    return false;
		                  }else{
		              }
		     d_id=document.getElementsByName("doubt_id")[0].value;
		     n_type=s;
		     var title = "";
		     if(s=="YD"){
		       title = "生成审计疑点";
		     }else if(s=="FX"){
		       title = "生成审计发现";
		     }else if(s=="DS"){
		       title = "生成重大事项";
		     } 
		     d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}',700,600,title);
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
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能删除！");
		                    return false;
		                  }else{
		              }
		           
		  	if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/doubt/delete.action";
	            myform.submit();
	      }
	                    
	} 
	function exe(){
	
	        var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限处理！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能重复处理！");
		                    return false;
		                  }else{
		              }
		if (confirm("是否设置为已处理状态?")) {
		document.getElementsByName("audDoubt.doubt_status")[0].value="050"
		//audDoubt.doubt_status
	      var url = "${contextPath}/operate/doubt/save.action";
myform.action = url;
	myform.submit();
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
	//location.href = "${contextPath}/operate/manu/listTobeStarted.action?taskId=${taskId}&taskPid=${taskPid}&project_id=${project_id}";
	//var url = "${contextPath}/operate/manu/search.action?taskId=${taskId}&taskPid=${taskPid}&project_id=${project_id}";
    //myform.action = url;
	//myform.submit();
    var u = '${pageContext.request.contextPath}/operate/diaryExt/diaryList.action?project_id=${audDiary.project_id}'
	//window.location.href=u;

      					
      window.parent.Usp.doTabLoad({
               tabId:'operate-index-tab',
               pid:'common-data-dataframe-tab12',
               url:u
               });   					
}

function closeGenW(s){
	window.location.reload();
	//alert(s);
	window.parent.document.frames[s].location.reload(); 
	
	 //window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type=<s:property value="type" />&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>";
}

//模板生成----------保存表单
function saveForm(){
   
   var v_3 = "audDiary.diary_name";  // field
var title_3 = '日记名称';// field name
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



                 v_3 = "audDiary.groupName";  // field
                 title_3 = '所属小组';// field name
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


                                  if(!check()){
                                      return false;
                                  }
		           
var url = "${contextPath}/operate/diary/save.action";
document.getElementsByName("root")[0].disabled=true;
myform.action = url;
	myform.submit();
	 
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
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_diary_operate&table_guid=file_id&guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<s:head />
		 
	</head>



	<body>
		<center>
             <table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>

			<s:form id="myform" onsubmit="return true;" action="/ais/operate/diary" method="post" >

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">








					<tr class="titletable1">
						<td style="width: 20%">
							<font color="red">*</font> 日记名称:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield name="audDiary.diary_name" cssStyle="width:80%" />
							<!--一般文本框-->

						</td>

						<td style="width: 20%">&nbsp;&nbsp;&nbsp;
						</td>
						<!--标题栏-->



						<td style="width: 30%">
 
						</td>
					</tr>






					<tr class="titletable1">
						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;日记编码:
						</td>
						<!--标题栏-->
						<td>
						    <s:property value="audDiary.diary_code" />
						    <s:hidden name="audDiary.diary_code" />
							<!--  s:textfield name="audDoubt.doubt_code" cssStyle="width:80%"/>-->
							<!--一般文本框-->

						</td>

						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;提交人:
						</td>
						<td>
							<s:property value="audDiary.diary_author" />
							<s:hidden name="audDiary.diary_author_code" />
							<s:hidden name="audDiary.diary_author" />
						</td>
					</tr>



					<tr class="titletable1">


					  <td>

							<font color="red">*</font> 所属小组:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield  name="audDiary.groupName" cssStyle="width:80%" readonly="true"/>
                                  <img
				src="<%=request.getContextPath()%>/resources/images/s_search.gif"
				onclick="showPopWin('/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectGroup.action&a=a&project_id=${project_id}&paraname=audDiary.groupName&paraid=audDiary.groupId',500,330,'所属小组选择')"
				border=0 style="cursor:hand">
				<s:hidden name="audDiary.groupId" />
						</td>

						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;提交日期:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="audDiary.diary_date" />
							<s:hidden name="audDiary.diary_date" />
							<!--一般文本框-->

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

						 

							<s:textarea name="audDiary.diary_file"
								cssStyle="width:100%;height:50;" />

						</td>
					</tr>
					
					
									 				<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;
 
		 专业判断/查证结果:
 
 

						</td>
						<td class="titletable1" colspan="3">
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

						 

							<s:textarea name="audDiary.diary_prof"
								cssStyle="width:100%;height:50;" />

						</td>
					</tr>
					 
				 				<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;
 
		 程序/方法:
 
 

						</td>
						<td class="titletable1" colspan="3">
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

						 

							<s:textarea name="audDiary.diary_method"
								cssStyle="width:100%;height:50;" />

						</td>
					</tr>
					
									 				<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;
 
		 审计事项:
 
 

						</td>
						<td class="titletable1" colspan="3">
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

						 

							<s:textarea name="audDiary.diary_matter"
								cssStyle="width:100%;height:50;" />

						</td>
						
									 				<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;
 
		 其他:
 
 

						</td>
						<td class="titletable1" colspan="3">
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

						 

							<s:textarea name="audDiary.diary_other"
								cssStyle="width:100%;height:50;" />

						</td>
						
					</tr>
					<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
					<tr>
						<td class="ListTableTr11">
							<s:button
								onclick="Upload('audDiary.file_id',file_idList,'true','true')"
								value="上传附件"></s:button>
							<s:hidden name="audDiary.file_id" />
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="file_idList" align="center">
								<s:property escape="false" value="file_idList" />
							</div>

						</td>
					</tr>






				</table>

                <s:hidden name="newDoubt_type"/>
				<s:hidden name="audDiary.diary_id" />
				<s:hidden name="audDiary.project_id" />
				<s:hidden name="diary_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
			<s:hidden name="taskPid" />
			<s:hidden name="taskId" />
			<s:hidden name="taskId" />
			<s:hidden name="audDiary.dr_code_sort" />
			<s:hidden name="audDiary.task_code_sort" />
			  <div align="right">
				<s:button value="保存" onclick="saveForm();" name="root"/>&nbsp;&nbsp;
                <s:button value="返回" onclick="backList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               </div>
			 
			</s:form>

		</center>
	</body>
</html>
