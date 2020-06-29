<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'编辑审计事项'"></s:text>
<html>
	<script language="javascript">
	function closeWindow(){
	  	var pid='<%=request.getParameter("tid")%>';
	  	var type='<%=request.getParameter("type")%>';
	  	var tab='<%=request.getParameter("tab")%>';
	  	if(pid=='null'||pid==null){
	  	   pid='<%=request.getParameter("taskTemplateId")%>'
	  	}else{
	  	    
	  	}
	  	if(tab=='proc'){
	  	window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/template/showContentLeafList.action?selectedTab=proc&type=2&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	}else if(tab=='item'){
	  	window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/template/showContentLeafList.action?selectedTab=proc&type=2&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	window.top.frames['childBasefrm'].basefrm2.location.href="${contextPath}/operate/template/showContentType.action?selectedTab=item&type=1&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	}else if(tab=='main'){
	  	}
		window.close();
	}
		function generateLeaf()
		  {
		     title="审计事项";
		     window.paramw = "模态窗口";
		     showPopWin('${contextPath}/operate/template/addLeaf.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',720,600,title);
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
	 
	
	function closeW(){
			 
		window.top.frames['childBasefrm'].location.href='/ais/operate/template/showContent.action?node=${taskTemplateId}&selectedTab=item&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
		
		window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
		window.close();
	
	}
	 
	function law(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	
	function regu(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
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
			  alert("事项序号只能输入正整数,请重新输入!");
			  return true ;   
		 }
	}

	function check(){
	
		var v_3 = "audTaskTemplate.taskName";  // field
		var title_3 = '事项名称';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>1000){
		alert("事项名称的长度不能大于1000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
	
		var v_3 = "audTaskTemplate.law";  // field
		var title_3 = '所需材料';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("所需材料的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
		
		//var v_3 = "audTaskTemplate.taskFile";  // field
		//var title_3 = '审计关注点';// field name
		//var notNull = 'true'; // notnull
		//var t=document.getElementsByName(v_3)[0].value;
		//if(t.length>2000){
		//alert("审计关注点的长度不能大于2000字！");
		//document.getElementById(v_3).focus();
		//return false;
		//} 
		
		//var v_3 = "audTaskTemplate.taskOther";  // field
		//var title_3 = '审计风险';// field name
		//var notNull = 'true'; // notnull
		//var t=document.getElementsByName(v_3)[0].value;
		//if(t.length>2000){
		//alert("审计风险的长度不能大于2000字！");
		//document.getElementById(v_3).focus();
		//return false;
		//} 
	
		var v_3 = "audTaskTemplate.taskMethod";  // field
		var title_3 = '审计步骤和方法';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("审计步骤和方法的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
		 
		return true;
	  }
		//保存表单
	function saveFormLeaf(){
		
		
		var v_3 = "audTaskTemplate.taskName";  // field
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
		
		
		
		
		
		var v_2 =  "audTaskTemplate.taskOrder"
		
		
		
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
		
		var url = "${contextPath}/operate/template/saveLeaf.action?tid=<%=request.getParameter("tid")%>";
		myform.action = url;
			myform.submit();
			window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
			 
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


			<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/template" method="post">

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">





					<s:hidden name="audTaskTemplate.taskTemplateId" />
					<s:hidden name="audTaskTemplate.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTaskTemplate.templateId" />
					<s:hidden name="audTaskTemplate.taskName" />


					<tr>
						<td class="ListTableTr11" style="width:20%;">
							审计程序和方法
						</td>
						<td class="ListTableTr22" colspan="3" style="width:80%;">
							<s:textarea name="audTaskTemplate.taskOther"
								cssStyle="width:100%;overflow-y:visible;" />
						</td>

					</tr>
					<tr>
						<td class="ListTableTr11">
							相关法律法规和监管规定
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="audTaskTemplate.law"
								cssStyle="width:100%;overflow-y:visible;" />
						</td>

					</tr>
					<!-- <tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计关注点:
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">


							<s:textarea name="audTaskTemplate.taskFile"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>		
 
				    <tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计风险:
						</td>
						<td class="titletable1" colspan="3">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<s:textarea name="audTaskTemplate.taskOther"
								cssStyle="width:100%;overflow-y:visible;" />

						</td>
					</tr> -->


					<tr>
						<td class="ListTableTr11">
							审计查证要点
						</td>
						<td class="ListTableTr11" colspan="3">
							<s:textarea name="audTaskTemplate.taskMethod"
								cssStyle="width:100%;height:100;" />
						</td>
					</tr>

				</table>

				<s:hidden name="audTaskTemplate.template_type" value="2" />
				<s:hidden name="audTaskTemplate.taskPcode" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
				<s:hidden name="audTaskTemplate.taskOrder" />
				<s:hidden name="audTaskTemplate.taskCode" />
				<s:button value="保存" onclick="saveFormLeaf();" />&nbsp;&nbsp;
				<s:button value="关闭" onclick="closeW();" />&nbsp;&nbsp; 
				 

				 
				 

			</s:form>

		</center>
	</body>
</html>
