<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:if test="${audTaskTemplate.taskTemplateId==null}">
	<s:text id="title" name="'增加审计事项'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'编辑审计事项'"></s:text>
</s:else>

<html>
	<script language="javascript">
	//关闭窗口
	function closeW(){
			 
		window.top.frames['childBasefrm'].location.href='${contextPath}/operate/template/showContent.action?node={taskTemplateId}&selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&taskTemplateId=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
		window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
		window.close();
	
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

    //输入项的验证
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
	    if('enabled' == '${shenjichengxu}'){
			var v_3 = "audTaskTemplate.taskTarget";  // field
			var title_3 = '审计目的';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>2000){
				alert("审计目的的长度不能大于2000字！");
				document.getElementById(v_3).focus();
				return false;
			} 
		
			var v_3 = "audTaskTemplate.taskFile";  // field
			var title_3 = '备注';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>2000){
				alert("备注的长度不能大于2000字！");
				document.getElementById(v_3).focus();
				return false;
			} 
		 
	    }
		 
		return true;
	}

	//保存表单
	function saveFormLeaf(){
		alert("${contextPath}/operate/template/saveType.action?addtype=true&selectedTab=<%=request.getParameter("selectedTab")%>");
		var url = "${contextPath}/operate/template/saveType.action?addtype=true&selectedTab=<%=request.getParameter("selectedTab")%>";
		document.getElementsByName("root")[0].disabled=true;
		document.getElementsByName("root2")[0].disabled=true;
		myform.action = url;
	    myform.submit();
		window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
	}


	//保存表单
	function saveFormLeafAgain(){
	
		var v_3 = "audTaskTemplate.taskName";  // field
		var title_3 = '事项名称';// field name
		var notNull = 'true'; // notnull
		if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
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
		if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != ""){
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
		var url = "${contextPath}/operate/template/saveTypeAgain.action?addtype=true&selectedTab=<%=request.getParameter("selectedTab")%>";
		document.getElementsByName("root")[0].disabled=true;
		document.getElementsByName("root2")[0].disabled=true;
		myform.action = url;
			myform.submit();
			//alert('${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>');
			//parent.location.href='${contextPath}/operate/template/main.action?audTemplateId='+<%=request.getParameter("audTemplateId")%>;
			//window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>';
			//alert(window.top.frames['f_left']);
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

				<table class="ListTable">



					<tr class="titletable1">
						<td class="ListTableTr11" style="width: 20%" ><font color="red">*</font>&nbsp;事项名称</td>
						<td class="ListTableTr22" colspan=3>
							<s:textarea name="audTaskTemplate.taskName"
								cssStyle="width:100%;height:60;" />
							<!--一般文本框-->

						</td>

					</tr>


					<s:hidden name="audTaskTemplate.taskTemplateId" />
					<s:hidden name="audTaskTemplate.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTaskTemplate.templateId" />
					<s:hidden name="audTaskTemplate.template_type" value="1" />
					<tr class="titletable1">
						<td class="ListTableTr11">

							<font color="red"></font>&nbsp;执行人
						</td>
						<td class="ListTableTr22" style='width:40%;'>
							<s:hidden name="audTaskTemplate.taskAssign" />

						</td>

						<td class="ListTableTr11">

							<font color="red">*</font> &nbsp;事项序号
						</td>
						<!--标题栏-->
						<td class="ListTableTr22">
							<s:textfield name="audTaskTemplate.taskOrder"  maxlength="3" cssStyle='width:150px;'/>
							<!--一般文本框-->

						</td>
					</tr>
					<tr class="titletable1">
						<td class="ListTableTr11">事项编码
						</td>
						<!--标题栏-->
						<td class="ListTableTr22" colspan="3">
							<s:property value="audTaskTemplate.taskCode" />
							<s:hidden name="audTaskTemplate.taskCode" />
						</td>
					</tr>

					<s:if test="'enabled' == '${shenjichengxu}'">
						<tr class="titletable1">
							<td class="ListTableTr11">

								<font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项名称
							</td>
							<td class="ListTableTr22">
								<s:textfield name="audTaskTemplate.taskBeforeName"
									cssStyle="width:80%;background-color:#EEF7FF" readonly="true" />

							</td>
							<td class="ListTableTr11">
								<font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项编码
							</td>
							<!--标题栏-->
							<td class="ListTableTr22">
								<s:textfield name="audTaskTemplate.taskBeforeCode"  />
								<!--一般文本框-->
								<img
									src="<%=request.getContextPath()%>/resources/images/s_search.gif"
									onclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/template/showTreeListSelect.action&a=a&code=${audTaskTemplate.taskCode}&&audTemplateId=${audTemplateId}&paraname=audTaskTemplate.taskBeforeName&paraid=audTaskTemplate.taskBeforeCode',400,450,'前置事项选择')"
									border=0 style="cursor: hand">
							</td>
						</tr>

						<tr class="titletable1">


							<td class="ListTableTr11">是否必做
							</td>
							<!--标题栏-->
							<td class="ListTableTr22">
								<s:if test="${audTaskTemplate.taskMust=='1'}">
									<input type="radio" value="1" name="audTaskTemplate.taskMust"
										checked="checked">是&nbsp;<input type="radio"
										value="0" name="audTaskTemplate.taskMust">否
                        </s:if>
								<s:else>
									<input type="radio" value="1" name="audTaskTemplate.taskMust"
										checked="checked">是&nbsp;<input type="radio"
										value="0" name="audTaskTemplate.taskMust" checked="checked">否
						</s:else>
							</td>

							<td class="ListTableTr22">

							</td>
							<!--标题栏-->
							<td class="ListTableTr22">

							</td>

						</tr>
						<tr>
							<td class="ListTableTr11">审计目的
							</td>
							<td class="ListTableTr22" colspan="3">

							</td>

						</tr>
						<tr>

							<td cclass="ListTableTr22" colspan="4">


								<s:textarea name="audTaskTemplate.taskTarget"
									cssStyle="width:100%;height:70;" />

							</td>
						</tr>

						</tr>

						<tr>
							<td class="ListTableTr11">
								&nbsp;&nbsp;&nbsp;备注
							</td>
							<td class="ListTableTr22" colspan="3">

							</td>

						</tr>
						<tr>

							<td class="ListTableTr22" colspan="4">


								<s:textarea name="audTaskTemplate.taskFile"
									cssStyle="width:100%;height:70;" />

							</td>
						</tr>

					</s:if>

					<tr>
						<td class="ListTableTr11" style="width:20%;">
							审计查证要点
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

				<s:hidden name="audTaskTemplate.taskPcode" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
				<s:hidden name="path" />
				<s:hidden name="node" />
				<s:button value="保存" onclick="saveFormLeaf();" name="root" />&nbsp;&nbsp;
                <s:button value="关闭" onclick="closeW();" />&nbsp;&nbsp;
				 

			</s:form>

		</center>
	</body>
</html>
