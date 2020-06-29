<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%@page import="ais.framework.util.MyProperty"%>
<s:text id="title" name="'查看审计结论'"></s:text>





<html>
	<script language="javascript">

	function closeWindow(){
	  	//window.top.frames['f_left'].location.reload();
	  	//
	  	
	  	var pid='<%=request.getParameter("taskPid")%>';
	  	var type='<%=request.getParameter("type")%>';
	  	var tab='proc';
	  	if(pid=='null'||pid==null){
	  	   pid='<%=request.getParameter("taskTemplateId")%>'
	  	}else{
	  	    
	  	}
	  	
	   
	  	
	  	//alert(pid);
	  	//&taskPid=90FA5FB1-3E5F-E67E-70AF-FEC64D7400C1&taskTemplateId=5B294137-3D96-494C-4812-618FD59DF3C8&project_id=62AC552B-1366-BBB4-8198-A4DF4F584884
	  	//window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=main&taskTemplateId=null&audTemplateId=<%=request.getParameter("audTemplateId")%>";
	  	if(tab=='proc'){
	  	  window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/task/showContentLeafEditList.action?selectedTab=proc&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>&type=<%=request.getParameter("type")%>&taskTemplateId="+pid;
	  	}else if(tab=='item'){
	  	window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/task/showContentLeafEditList.action?selectedTab=proc&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>&type=<%=request.getParameter("type")%>&taskTemplateId="+pid;
	  	window.top.frames['childBasefrm'].basefrm2.location.href="${contextPath}/operate/task/showContentTypeEdit.action?selectedTab=item&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>&type=1&taskTemplateId="+pid;     
	  	}else if(tab=='main'){
	  	  //  window.top.frames['childBasefrm'].location.href="${contextPath}/operate/task/showContentEdit.action?selectedTab=main&project_id=<%=request.getParameter("project_id")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>";
	  	}
	  	
	  	//window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=proc&type=<%=request.getParameter("type")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	//window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=proc&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid+"&type"+type;
		//window.top.frames['f_left'].location.reload();
		//window.top.frames['childBasefrm'].location.reload();
		window.close();
	}
	
	function closeW(){
			 
		//window.top.frames['f_left'].location.reload();
		//alert('/ais/operate/template/showContent.action?node=${taskTemplateId}&selectedTab=item&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>');
		window.top.frames['childBasefrm'].location.href='/ais/operate/task/showContentEdit.action?node=${audTask.taskTemplateId}&selectedTab=item&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskId=${taskTemplateId}&taskTemplateId=${taskTemplateId}&project_id=<%=request.getParameter("project_id")%>';
		
		//window.top.frames['childBasefrm'].location.href='${contextPath}/operate/template/showContentLeaf.action?node=D9A859C9-BC38-A6B1-E5DA-62E4A91C0C59&path=/0/xnode-19/xnode-28&selectedTab=proc&type=2&taskPid=CFCB9DE7-9C64-2E31-D47C-0B04E130AE5F&taskTemplateId=D9A859C9-BC38-A6B1-E5DA-62E4A91C0C59&audTemplateId=1A0E378B-6654-2DB7-0A62-EB1FF54976A8';
		window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${audTask.taskTemplateId}&project_id=<%=request.getParameter("project_id")%>';
		window.close();
	
	}

	function check(){

	 
		var v_3 = "audTask.evaluation";  // field
		var title_3 = '审计评价结果';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("审计评价结果的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
	 

        var v_3 = "audTask.evaluationName";  // field
		var title_3 = ' 审计评价类型';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert(" 审计评价类型的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		}   
		 var v_3 = "audTask.comment";  // field
		var title_3 = '审计复核意见';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("审计复核意见的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
		 
		 
		return true;
	}
		function generateLeaf()
		  {
		     var title="增加程序";
		     window.paramw = "模态窗口";
             //window.open('${contextPath}/operate/task/addLeaf.action?type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>');
		     showPopWin('${contextPath}/operate/task/addLeaf.action?type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',720,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     
		     //type=2&taskTemplateId=43917C5D-4745-7041-BD03-56243A457B3C&project_id=62AC552B-1366-BBB4-8198-A4DF4F584884
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
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
	//模板生成----------保存表单
function saveFormLeaf(){
//alert("111");


var v_3 = "audTask.taskName";  // field
var title_3 = '事项名称';// field name
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





var v_2 =  "audTask.taskOrder"



var title_2 = '事项序号';// field name
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
}
if(!check()){
 return false;
}
var url = "${contextPath}/operate/task/saveEvaluation.action?taskPid=<%=request.getParameter("taskPid")%>";
myform.action = url;
	myform.submit();
	//alert('${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>');
	//parent.location.href='${contextPath}/operate/template/main.action?audTemplateId='+<%=request.getParameter("audTemplateId")%>;
	window.parent.parent.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
	//alert(window.top.frames['f_left']);
	 
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
      function deleteRecord2()
		  {
		  	if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/task/deleteLeaf.action";
	            myform.submit();
	            window.top.location.href='${contextPath}/operate/task/mainReadyEdit.action?project_id=<%=request.getParameter("project_id")%>';
	      }
	                    
	} 
		 //删除
      function deleteRecord()
		  {
		  	if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/task/deleteLeaf.action";
	            myform.submit();
	            window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${audTask.taskPid}&project_id=<%=request.getParameter("project_id")%>';
	            //window.top.location.href='${contextPath}/operate/template/main.action?audTemplateId=<%=request.getParameter("audTemplateId")%>';
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
var url = "${contextPath}/operate/doubt/save.action";
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



  function subExport(){
    location.href='${contextPath}/operate/doubt/exportSubTask.action?project_id=${audTask.project_id}&taskId=${audTask.taskTemplateId}';//
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
	
	    function task(){
          window.open('${contextPath}/operate/task/showContentLeafView.action?type=1&taskTemplateId=${audTask.taskTemplateId}&project_id=${audTask.project_id}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
                
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
	<style type="text/css">
   textarea { /** auto break line */
	word-wrap: break-word;
	word-break: break-all;
     }

    .divSim {
	display: block;
	width: 40%;
	white-space: nowrap;
	float: left;
	white-space: nowrap;
	overflow: hidden;
	word-break: break-all;
	-o-text-overflow: ellipsis; /**/ /* for Opera */
	text-overflow: ellipsis; /**/ /* for IE */
    }

   .divSim:after {
	content: "...";
	padding-left: 3px;
	font-size: 12px;
   }
   </style>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:if test="'enabled' == '${shenjichengxu}'">
			<title><s:property value="#title" />
		</s:if>

		</title>
		<s:head />
	</head>



	<body>
		<center>
			<s:if test="'enabled' == '${shenjichengxu}'">
				<table>
					<tr class="listtablehead">

						<td colspan="5" align="left" class="edithead">
							<s:property value="#title" />
						</td>
					</tr>
				</table>
			</s:if>
			<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/task" method="post">
				<div align="left" style="color: #007FFF;">
					<a href="javascript:void(0);" onclick="javascript:task()" title="${audTask.url}"><div
							class="divSim" style="cursor: hand">
							&nbsp;&nbsp;&nbsp;&nbsp;审计事项: ${audTask.url}
						</div>
					</a>
				</div>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<s:hidden name="audTask.taskName" />
					<s:hidden name="audTask.taskOrder" />
					<s:hidden name="audTask.taskTemplateId" />
					<s:hidden name="audTask.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTask.templateId" />
					<s:hidden name="audTask.id" />
					<s:hidden name="audTask.project_id" />
					<s:hidden name="audTask.taskCode" />
					<s:hidden name="audTask.taskAssignName" />

					<tr>
						<td class="titletable1" colspan="1" width=25%>
							&nbsp;&nbsp;&nbsp;审计评价结果:
						</td>
						<td class="titletable1" colspan="3" width=75%>
							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audTask.evaluation"
								cssStyle="width:100%;height:140;" />
						</td>

					</tr>


					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计评价类型:
						</td>
						<td class="titletable1" colspan="3">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audTask.evaluationName"
								cssStyle="width:100%;height:70;" />
						</td>

					</tr>


					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计复核意见:
						</td>
						<td class="titletable1" colspan="3">
							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audTask.comment"
								cssStyle="width:100%;height:70;" />
						</td>

					</tr>


					<tr>
						<td class="titletable1" width=25%>
							&nbsp;&nbsp;&nbsp;编辑人:
						</td>
						<td class="titletable1" width=25%>
							&nbsp;
							<s:property value="audTask.evaUserName" />
						</td>
						<td class="titletable1" width=25%>
							&nbsp;&nbsp;&nbsp;编辑时间:
						</td>
						<td class="titletable1" colspan="1">
							&nbsp;
							<s:property value="audTask.evaDate" />
						</td>
					</tr>










				</table>
				<s:hidden name="audTask.evaDate" />
				<s:hidden name="audTask.evaUserCode" />
				<s:hidden name="audTask.evaUserName" />
				<s:hidden name="audTask.taskTarget" />
				<s:hidden name="audTask.taskFile" />
				<s:hidden name="audTask.taskMethod" />
				<s:hidden name="audTask.taskOther" />
				<s:hidden name="audTask.evaluationCode" />
				<s:hidden name="audTask.template_type" value="2" />
				<s:hidden name="audTemplate.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="audTask.taskProgress" />
				<s:hidden name="audTask.taskPcode" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				<s:hidden name="path" />
				<s:hidden name="node" />


			</s:form>

		</center>
	</body>
</html>
