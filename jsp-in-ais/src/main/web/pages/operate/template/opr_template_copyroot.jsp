<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String s = (String) request.getAttribute("success");
	String ret = (String) request.getParameter("ret");
	//System.out.print(s);
%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	</head>
	<script type="text/javascript">
        //返回
		function closeWindow(){
			if('<%=ret%>'=='false'){
				window.location.href='${contextPath}/operate/template/list.action?interCtrl=${interCtrl}';
			}else if('<%=ret%>'=='true'){
				window.location.href='${contextPath}/operate/template/listRet.action?interCtrl=${interCtrl}';
			}
		}
        //校验
   	  	function check(){
			var v_3 = "audTemplate.templateName";  // field
			var title_3 = '方案名称';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>200){
				showMessage1("方案名称的长度不能大于200字！");
				document.getElementById(v_3).focus();
				return false;
			}
			var v_3 = "audTemplate.proVer";  // field
			var title_3 = '方案版本';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>200){
				showMessage1("方案版本的长度不能大于200字！");
				document.getElementById(v_3).focus();
				return false;
			} 
			return true;
    	}
		//-------保存表单
		function saveFormRoot(){
			var v_3 = "audTemplate.templateName";  // field
			var title_3 = '方案名称';// field name
			var notNull = 'true'; // notnull
           	if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
           	{
				showMessage1(title_3+"不能为空!");
				bool = false;
				return false;
           	}
            if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
            }
			if(!check()){
				return false;
			}
			var proVer = document.getElementById("proVer").value;
			var typecode = document.getElementById("typeCode").value;
			var url = "${contextPath}/operate/template/saveRootCopy.action?ret=<%=ret%>&interCtrl=${interCtrl}";
			if(proVer==null || proVer==''){
				showMessage1("方案版本不能为空！");
				return;
			}
			if(typecode==null || typecode==''){
				showMessage1("请选择项目类别！");
				return;
			}
			myform.action = url;
			document.getElementsByName("root")[0].disabled=true;
			myform.submit();
		}
		//保存成功信息
		function test(s){
			if(s==true){
				showMessage1("保存成功！");
			}else{
			} 
		}
		
	$(function(){
		if(!"${interCtrl}"){
			$('#audTemplate_belongTo').val('audit');
		}
	});	
	</script>
	<body onload="test(<%=s%>)" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<s:form id="myform" onsubmit="return true;" action="view"
				method="post">
				<input type='hidden' id='audTemplate_belongTo' name="audTemplate.belongTo" value="${audTemplate.belongTo}"/>
				<div style="text-align:left;padding:5px;">
					<a class="easyui-linkbutton" name="root" data-options="iconCls:'icon-save'" onclick="saveFormRoot()">保存</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="closeWindow()">返回</a>&nbsp;&nbsp;
				</div>
				<table class="ListTable">
					<tr >
						<td class="EditHead" style="width: 15%">
							<font color="red">*</font> 方案名称
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<s:textfield cssClass="noborder" name="audTemplate.templateName"
								cssStyle="width:160px;" />
							<!--一般文本框-->
						</td>
						<td class="EditHead" style="width: 15%">
							<font color="red">*</font> 方案版本
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<!--  s:property value="audTemplate.doubt_status" /-->
							<s:textfield cssClass="noborder" id="proVer" name="audTemplate.proVer"
								cssStyle="width:160px;" />
						</td>
					</tr>
					<s:hidden name="audTemplate.audTemplateId" />
					<s:hidden name="audTemplateId" />
					<tr >
						<td class="EditHead">
							<font color="red"></font> 编制人
						</td>
						<td class="editTd">
							<s:property value="audTemplate.proAuthorName"/>
							<s:hidden name="audTemplate.proAuthorCode" />
							<s:hidden name="audTemplate.proAuthorName" />
						</td>
						<td class="EditHead">
							<font color="red"></font> 编制日期
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:property value="audTemplate.proDate"/>
							<s:hidden name="audTemplate.proDate" />
							<!--一般文本框-->
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							&nbsp;&nbsp;&nbsp;
							<font color="red">*</font> 项目类别
						</td>
						<td class="editTd">
							<s:doubleselect id="typeCode" cssStyle="width:160px;"
								doubleList="projectTypeMap[top]" doubleListKey="code"
								doubleListValue="name" listKey="code" listValue="name"
								name="audTemplate.typeCode" list="projectTypeMap.keySet()"
								doubleName="audTemplate.typeCode2" theme="ufaud_simple"
								templateDir="/strutsTemplate" emptyOption="true"></s:doubleselect>
						</td>
						<td class="EditHead">
							所属单位
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield cssClass="noborder" name="audTemplate.atCompany"  id="atCompany" cssStyle="width:150px" readonly="true" maxlength="100"/>
							<input type="hidden" id="atCompanyCode" name="audTemplate.atCompanyCode" value="${audTemplate.atCompanyCode}">
							<img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									 onclick="showSysTree(this,
											 { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
											 title:'请选择所属单位',
											 param:{
											 'p_item':1,
											 'orgtype':2
											 },
											 defaultDeptId:'${magOrganization.fpid}'
							})"/>
						</td>
					</tr>
					<s:hidden name="newDoubt_type" />
					<s:hidden name="audTemplate.doubt_id" />
					<s:hidden name="doubt_id" />
					<s:hidden name="type" />
					<s:hidden name="pro_id" />
				</table>
				<div id="layer" style="display: none">
					<img src="${contextPath}/images/uploading.gif">
					<br>
					正在读取，请稍候... ...
				</div>
				<div align="center" id="errorInfo1">
					<br>
					<%
						if (s != null && !"".equals(s) && !"true".equals(s)) {
					%>
					<%=s%>
					<%
						}
					%>
					<%
						if ("true".equals(s)) {
					%>

					<%
						}
					%>
				</div>
			</s:form>
		</div>
	</body>
</html>
