<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<s:text id="title" name="'审计底稿反馈意见'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/main/manu.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>

		<SCRIPT language="JavaScript">
		   	//返回上级list页面
            function backList(){
	           location.href = "${contextPath}/operate/feedback/feedbackManu.action";
	        }
		
			/*
			*  打开或关闭
			*/
			function triggerSearchTable(){
				var isDisplay1 = document.getElementById('searchDiv').style.display;
				if(isDisplay1==''){
				    document.getElementById("vm").value="查看底稿";
					document.getElementById('searchDiv').style.display='none';
				}else{
				    document.getElementById("vm").value="关闭底稿";
					document.getElementById('searchDiv').style.display='';
					var iframe = document.getElementById("mainIFrame2");
        
                    iframe.src = "/ais/operate/manu/viewAll.action?crudId=${crudObject.formId}&project_id=${crudObject.project_id}";
           
				}

				 
			}
			
		
		function editFeedback(){
		  var title = "编辑审计底稿反馈意见";
		     //d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&pro_id=${pro_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/feedback/editFeedbackInfo.action?ms_id=${crudObject.formId}',700,300,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		}
		
		  function editFeedbackInfo(s){
		    var title = "编辑审计底稿反馈意见";
		     //d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&pro_id=${pro_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/feedback/editFeedbackInfo.action?feed_id='+s,700,300,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		}
		  function deleteFeedback(s)
		  { 
		  if(confirm("确认删除吗？")){
			 window.location.href="${contextPath}/operate/feedback/deleteFeedbackInfo.action?ms_id=${crudObject.formId}&feed_id="+s;
			} 
		   }
		   
		  function sumbitFeedback(s)
		  { 
		  if(confirm("确认提交吗？请注意，提交后将不能修改和删除！")){
			 window.location.href="${contextPath}/operate/feedback/submitFeedbackInfo.action?ms_id=${crudObject.formId}&feed_id="+s;
			} 
		   }
		 
		   
           
           
		function closeGenW(s){
			window.location.reload();
			 
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

 
 
 

		//保存表单
		function saveForm(){
		
		var bool = true;//提交表单判断参数
		 	
			//完成保存表单操作
			if(bool){
			var flag=window.confirm('确认提交吗?');//isSubmit
			if(flag==true){
			var url = "${contextPath}/operate/manu/save.action";
			myform.action = url;
			myform.submit();
			}else{
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
	     
	
	 
	//上传附件
	function Upload(id,filelist,delete_flag,edit_flag){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
 		
 		 

		</script>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
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

			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<tr class="listtablehead">
					<td colspan="6" align="center" class="edithead">
						&nbsp;征求期间
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="right" width="11%" class="ListTableTr1">
						开始日期:
					</td>
					<td class="ListTableTr2" width="17%" align="left">

						<s:property value="crudObject.sdate_comment" />

					</td>
					<td align="right" width="11%" class="ListTableTr1">
						结束日期:
					</td>
					<td class="ListTableTr2" width="18%" align="left">
						<s:property value="crudObject.edate_comment" />

					</td>

				</tr>
			</table>

			<%@include file="/pages/operate/feedback/list_feedbackinfo.jsp"%>
			<div align="right">
				<input type="button" value="返回" onclick="backList()" />
				&nbsp;&nbsp;
				<input type="button" value="查看底稿" id="vm"
					onclick="triggerSearchTable()" />
				&nbsp;&nbsp;
				 
					<input type="button" value="增加底稿反馈意见" onclick="editFeedback()" />&nbsp;&nbsp;&nbsp;&nbsp;
				 

			</div>

			   <div id="searchDiv" style="display: none;">
				 	<tr>
						<td colspan=4>

							<iframe width=100% height=2000 frameborder=0 scrolling=auto id='mainIFrame2'
								src=""></iframe>
						</td>
					</tr>
             </div>
				 

		</center>
	</body>
</html>
