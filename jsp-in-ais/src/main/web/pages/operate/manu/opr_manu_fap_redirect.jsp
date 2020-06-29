<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
 <s:text id="title" name="'发送审计底稿'"></s:text>
   <%
   	
    String s = (String)request.getAttribute("success");
    %>


<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><s:property value="#title" />
		</title>
	</head>
	<script language="javascript">
        function sucFun(){
            if(<%=s%> == true){
                parent.$.messager.alert(function(){
                    window.opener=null;
                    window.open('','_self');
                    window.close();
                });
            }
        }
	$(document).ready(function(){
		//初始化引用底稿窗口
	    $('#manuReferenceDiv').window({
			width:800, 
			height:600,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true    
	    });   
		});
	//保存表单
	function saveListForm(){
	    var manuIdArrayName = document.getElementsByName('manuIdArrayName')[0].value;
	     if(manuIdArrayName.length==0){
		   alert("请选择底稿！");
		   document.getElementsByName('manuIdArrayName')[0].focus();
		    return false;
		 }  
	   var bool = true;//提交表单判断参数
	 	
		//完成保存表单操作
		if(bool){
		var flag=window.confirm('确认提交吗?');//isSubmit
		if(flag==true){
		var url = "${contextPath}/operate/manu/saveSelectManu.action?file_id2=<%=request.getParameter("file_id2")%>&file_id=<%=request.getParameter("file_id")%>&manuscriptInstanceId=<%=request.getParameter("manuscriptInstanceId")%>&instanceName=<%=request.getParameter("instanceName")%>";
		myform.action = url;
		
		document.getElementById("submitButton").disabled=true;
		document.getElementById("layer").style.display="";
		myform.submit();
		
		}else{
			 	return false;
			 }
		}
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
	
	//新增底稿
	function backList(){
	//	window.open('${contextPath}/operate/manu/fapEdit.action?fap=true&project_id=<%=request.getParameter("project_id")%>&type=DG&file_id2=<%=request.getParameter("file_id2")%>&file_id=<%=request.getParameter("file_id")%>','','height=650px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no');
		//myform.submit();
		
		window.open('${contextPath}/operate/manu/fapEdit.action?fap=true&project_id=<%=request.getParameter("project_id")%>&type=DG&file_id2=<%=request.getParameter("file_id2")%>&file_id=<%=request.getParameter("file_id")%>');
	}

	function closeGenW(s){
		window.location.reload();
		//alert(s);
		window.parent.document.frames[s].location.reload(); 
		
		 //window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type=<s:property value="type" />&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>";
	}

	//---------保存表单
	function saveForm(){
	//alert("111");
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
	var url = "${contextPath}/operate/doubt/save.action";
	myform.action = url;
		myform.submit();
		 
	}


 
	function closeWinUI(){
		$('#manuReferenceDiv').window('close');
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
	
     //提示信息
	 function test(s){
		 if(s==true){
		    alert("保存成功！");
		 }else{
	 }
  
 }
     
		//选择引用疑点
  	function  getOwerManu(){
			//	var myurl = "/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/manu/selectManu.action&a=a&taskPid=${taskPid}&taskId=${taskId}&project_id=${project_id}&paraname=manuIdArrayName&paraid=manuIdArray";
			
			var myurl = "<%=request.getContextPath()%>/operate/manu/querySelectManu.action?a=a&taskPid=${taskPid}&taskId=${taskId}&project_id=${project_id}&paraname=manuIdArrayName&paraid=manuIdArray";
			$("#myFrame").attr("src",myurl);
				$('#manuReferenceDiv').window('open');
			}	
</script>




	<body onload="test(<%=s%>);sucFun();" oncontextmenu=self.event.returnValue=false>
		<center>

		<%-- 	<table  class="ListTable" >
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table> --%>
	     <table class="ListTable">
				<tr>
					<td colspan="5" style="text-align:center;" class="EditHead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/manu" method="post" >

<%-- 				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">


					<tr class="titletable1">
						<td style="width: 20%" class="ListTableTr11">

							<font color="red">*</font>底稿名称:
						</td>
						<!--标题栏-->
						<td class="ListTableTr22">
							<s:textfield name="manuIdArrayName" cssStyle="width:80%" readonly="true"/>
							<!--一般文本框-->
                             <s:hidden name="manuIdArray"/>  
						<img
						src="<%=request.getContextPath()%>/resources/images/s_search.gif"
						onclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/manu/selectManu.action&a=a&taskPid=${taskPid}&taskId=${taskId}&project_id=${project_id}&paraname=manuIdArrayName&paraid=manuIdArray',600,450,'底稿选择')"
						border=0 style="cursor:hand">
		                </td>
					</tr>
					

				</table> --%>
				
				
				
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td style="width: 20%" class="EditHead">
							<font color="red">*</font>底稿名称:
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield name="manuIdArrayName" id="manuIdArrayName" cssStyle='width:90%' cssClass="noborder" />
						
                             <s:hidden name="manuIdArray"  id="manuIdArray" />   
				<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="getOwerManu()" border=0 style="cursor: hand">
                </td>
					</tr>
					

				</table>
				

                <s:hidden name="newDoubt_type"/>
				<s:hidden name="audDoubt.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
			<%-- 	<s:button id="submitButton" value="保存" onclick="saveListForm();" />&nbsp;&nbsp;
                <s:button value="生成新底稿" onclick="backList();" /> --%>
 	    <a href="javascript:void(0);" id="submitButton" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveListForm();">保存</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0);"  class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="backList();">生成新底稿</a>
       		<div id="layer" style="display:none">
				<img src="${contextPath}/images/uploading.gif">
				<br>
				正在保存，请稍候... ...
			</div>
			<div  id="errorInfo1">
				  <% if(s!=null&&!"".equals(s)&&!"true".equals(s)){%>
				  <%=s %>
				  <% }%>
				  <% if("true".equals(s)){%>
				  <% }%>
			</div>

			</s:form>

		</center>
			<div id="manuReferenceDiv" title="引用底稿数据" style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="myFrame" name="myFrame" title="引用底稿" src="" width="100%" height="100%" frameborder="0"><!-- main --></iframe>				
	      </div>
	</body>
</html>
