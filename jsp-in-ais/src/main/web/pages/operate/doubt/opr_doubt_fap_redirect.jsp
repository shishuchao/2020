<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<!DOCTYPE HTML>
 <s:text id="title" name="'发送审计疑点'"></s:text>
   <%
   	
    String s = (String)request.getAttribute("success");
    %>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<script language="javascript">
		function sucFun(){
    		if('${flag_success}'=='1'){
    			parent.$.messager.alert('提示信息', '保存成功', 'info', function(){
    				window.opener=null;
        			window.open('','_self');
        			window.close();	
				});	
    		}        		
   		}
		//审计事项开始
		$(document).ready(function(){
		//初始化引用底稿窗口
	    $('#manuReferenceDiv').window({
			width:650, 
			height:450,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true    
	    });   
		});
		//保存表单
		function saveListForm(){
		    var doubtIdArrayName = document.getElementsByName('doubtIdArrayName')[0].value;
		     if(doubtIdArrayName.length==0){
		    	 window.parent.$.messager.show({
						title:'提示信息',
						msg:"请选择疑点！",
						timeout:5000,
						showType:'slide'
					});
			   document.getElementsByName('doubtIdArrayName')[0].focus();
			    return false;
			 }  
		 	
			//完成保存表单操作
			parent.$.messager.confirm('确认对话框', '确认提交吗?', function(r) {
				if (r) {
					var url = "${contextPath}/operate/doubt/saveSelectDoubt.action?file_id2=<%=request.getParameter("file_id2")%>&file_id=<%=request.getParameter("file_id")%>&doubtscriptInstanceId=<%=request.getParameter("doubtscriptInstanceId")%>&instanceName=<%=request.getParameter("instanceName")%>";
					myform.action = url;
					document.getElementById("submitButton").disabled=true;
					document.getElementById("layer").style.display="";
					myform.submit();
					}else{
						 	return false;
					}
				
			});
			
		}
		function closeWinUI(){
			$('#manuReferenceDiv').window('close');
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
		     var title = "生成审计疑点";
		     //d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/doubt/gendoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+s+'&&project_id=${project_id}',700,600,title);
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
	   win=window.open('${contextPath}/pages/operate/doubt/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
	
	//生成新疑点
	function backList(){
		window.open('${contextPath}/operate/doubt/fapEdit.action?project_id=<%=request.getParameter("project_id")%>&type=YD&file_id2=<%=request.getParameter("file_id2")%>&file_id=<%=request.getParameter("file_id")%>');
		//myform.submit();
	}

	function closeGenW(s){
			window.location.reload();
			//alert(s);
			window.parent.document.frames[s].location.reload(); 
			
			 //window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type=<s:property value="type" />&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>";
		}

		//------保存表单
		function saveForm(){
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
				 window.parent.$.messager.show({
						title:'提示信息',
						msg:'保存成功',
						timeout:5000,
						showType:'slide'
					});
			 }else{
		 }
  
 	}
		//选择引用疑点
     	function  getOwerDoub(){
				var myurl = "${contextPath}/operate/doubt/queryDoubtSelect.action?&a=a&taskPid=${taskPid}&taskId=${taskId}&project_id=${project_id}&paraname=doubtIdArrayName&paraid=doubtIdArray";
				$("#myFrame").attr("src",myurl);
				$('#manuReferenceDiv').window('open');
			}	
	</script>
	</head>



	<body onload="test(<%=s%>);sucFun();" oncontextmenu="self.event.returnValue=false">
		<center>
			<table class="ListTable">
				<tr>
					<td colspan="5" style="text-align:center;" class="EditHead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/doubt" method="post" >
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td style="width: 20%" class="EditHead">
							<font color="red">*</font>选择己有疑点:
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield name="doubtIdArrayName" id="doubtIdArrayName" cssStyle='width:90%' cssClass="noborder" />
							<!--一般文本框-->
                             <s:hidden name="doubtIdArray" id="doubtIdArray" value="${doubtIdArray}"/>  
				<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="getOwerDoub()" border=0 style="cursor: hand">
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
				<a href="javascript:void(0);" id="submitButton" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveListForm();">保存</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0);"  class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="backList();">生成新疑点</a>
 
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
		<div id="manuReferenceDiv" title="引用疑点数据" style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="myFrame" name="myFrame" title="引用疑点" src="" width="100%" height="100%" frameborder="0"><!-- main --></iframe>				
	      </div>
	</body>
</html>
