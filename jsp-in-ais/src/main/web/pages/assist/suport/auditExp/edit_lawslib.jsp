<%@ taglib prefix="s" uri="/struts-tags"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<s:if test="${assistSuportLawslib.id}=='0'">
	<s:text id="title" name="'添加审计经验'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改审计经验'"></s:text>
</s:else>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css" 
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />

		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<s:head theme="simple" />
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<!-- 长度验证 -->
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
			
		<title>审计案例</title> <!-- <s:property value="#title" /> -->
	
	<script type="text/javascript">
	function openDialog()
	{
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=assist_suport_lawslib&table_guid=muuid&guid=${assistSuportLawslib.muuid}&&param='+rnm+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}

	function deleteFile(fileId,guid,isDelete,isEdit,appType){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true)
		{
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
		{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
		xxx);
		function xxx(data){
		  	document.getElementById("accelerys").innerHTML=data['accessoryList'];
		} 
		}
	}
	function publish2(){
 		var boolFlag=window.confirm("确认发布吗?");
 		if(boolFlag==true){
	 		var url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/publish.action?ids=${assistSuportLawslib.id}&nodeid=${nodeid}&mCodeType=${mCodeType}&listpub=Y";
	 		window.location = url;
 		}
 	}
 	
	function check(){
		if(frmCheck(document.forms[0],"mytable")==false) return false;
	}
	function getUrlParam(){
		return "&mCodeType=${mCodeType}";
	}
</script>
</head>
	<body onload="" leftmargin="0" topmargin="0" bottommargin="0">
		<center>
			<s:form action="save" namespace="/pages/assist/suport/lawsLib"
				onsubmit="return check();" theme="simple">
				<s:token/>
				<s:hidden name="nodeid" value="${nodeid}" />
				<s:hidden name="assistSuportLawslib.categoryFk"
					value="${assistSuportLawslib.categoryFk}" />
				<s:hidden name="assistSuportLawslib.id"
					value="${assistSuportLawslib.id}" />
				<s:hidden name="assistSuportLawslib.muuid"
					value="${assistSuportLawslib.muuid}" />
				
						<s:hidden name="assistSuportLawslib.classification"
						value="${assistSuportLawslib.classification}" />
					<s:hidden name="mCodeType"
						value="${mCodeType}" />
				<%-- 发布状态 --%>
				<s:if test="${empty(assistSuportLawslib.pub_state)}">
					<s:hidden name="assistSuportLawslib.pub_state" value="N"/>
				</s:if>
				<s:else>
					<s:hidden name="assistSuportLawslib.pub_state"/>
				</s:else>
				<%-- 发布人 --%>
				<s:hidden name="assistSuportLawslib.pub_man"/>
				<%-- 创建人 --%>
				<s:if test="${empty(assistSuportLawslib.upman)}">
					<s:hidden name="assistSuportLawslib.upman" value="${user.floginname}"/>
				</s:if>						
				<s:else>
					<s:hidden name="assistSuportLawslib.upman"/>
				</s:else>
				<s:hidden name="assistSuportLawslib.effective"/>
			<s:div id='one' label='基本信息' theme='ajax' cssStyle="height: 100%">
				<table class="ListTable" id="mytable">
					<tr>
						<td class="listtabletr11" nowrap="nowrap">
							名称
							<font color="red">*</font>
						</td>
						<td class="listtabletr22">
							<s:textfield title="名称(题目/条目)" name="assistSuportLawslib.title" maxlength="127"/>
						</td>
						<td class="listtabletr11" nowrap="nowrap">
							颁布日期<font color="red">*</font> 
						</td>

						<td class="listtabletr22" nowrap="nowrap">
							<s:textfield 
								name="assistSuportLawslib.promulgationDate"
								value="${assistSuportLawslib.promulgationDate}"
								onclick="calendar()"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="listtabletr11">
							发布单位<font color="red">*</font>
						</td>
						<td class="listtabletr22">
							<s:textfield 
								name="assistSuportLawslib.promulgationDept" maxlength="50"/>
						</td>
						<td class="listtabletr11">
							经验类别<font color="red">*</font>
						</td>
						<td class="listtabletr22" nowrap="nowrap">
							<div>
								<s:textfield  name="assistSuportLawslib.category" readonly="true"/>

								&nbsp;
								<img
									src="<%=request.getContextPath()%>/resources/images/s_search.gif"
									onclick="showPopWin('<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/pages/assist/suport/lawsLib/allLawsLibMenus.action&urlpara=getUrlParam&paraname=assistSuportLawslib.category&paraid=assistSuportLawslib.categoryFk',500,310)"
									border=0 style="cursor: hand">
							</div>
						</td>
					</tr>
					<tr>
						<td class="listtabletr11">创建人<font color="red">*</font></td>
						<td class="listtabletr22">
							<s:property value="assistSuportLawslib.summan"/>
							<s:hidden name="assistSuportLawslib.summan"/>
						</td>
						<td class="listtabletr11">创建单位<font color="red">*</font></td>
						<td class="listtabletr22">
							<s:property value="assistSuportLawslib.sundept"/>
							<s:hidden name="assistSuportLawslib.sundept"/>
							<s:hidden name="assistSuportLawslib.sundeptId"/>
						</td>
					</tr>
					<tr>
						<td class="listtabletr11">创建日期<font color="red">*</font></td>
						<td class="listtabletr22">
							
							${fn:substring(assistSuportLawslib.createDate,0,10)}
							
							<s:hidden name="assistSuportLawslib.createDate"/>
						</td>
						<%@include file="/pages/assist/suport/pub_state2.jsp"%>
					</tr>
					<tr>
						<td class="listtabletr11">
							正文<font color="red">*</font>
						</td>
						<td class="listtabletr22" colspan="3">
							<FCK:editor id="assistSuportLawslib.content" basePath="/ais/resources/fckedit/" height="250" toolbarSet="cnn2">
									${assistSuportLawslib.content}
							</FCK:editor>
						</td>

					</tr>
				</table>
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList" />
				</div>
				<br>
				<table style="width:97%;border:0" >
					<tr>
						<td>
							<span style="float:right;">
								<s:hidden name="m_message" value="${m_message}" />
								<s:if test="${not empty(assistSuportLawslib.id) && assistSuportLawslib.id!='0'}">
									<s:if test="${empty(assistSuportLawslib.pub_state)}||${assistSuportLawslib.pub_state=='N'}">
										<s:button value="发布" id="pub_button" onclick="publish2();"/>&nbsp;
									</s:if>
								</s:if>
								<s:button  onclick="openDialog()" value="上传附件"></s:button>&nbsp;<s:submit value="保存" /><input type="button" name="back" value="返回" onclick="javascript:window.location.href='../lawsLib/search.action?nodeid=${nodeid}&mCodeType=${mCodeType}'">
							</span>
						</td>
					</tr>
				</table>
				</s:div>
			</s:form>
			
		</center>
	</body>

</html>