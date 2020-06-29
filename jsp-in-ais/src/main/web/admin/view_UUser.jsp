<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<title></title>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript">
			function mydelSubmit(){
				if(true){  //mydelCheck()
					if(!window.confirm("请确认该用户没有参与到业务流程中,确定删除?"))
		 			return false;
					uuserForm.action="delUUser.action";
					uuserForm.submit();
				}else
				{
					return false;	
				}
			} 
			function myeditSubmit(){
				if(true){ //myeditCheck()
					uuserForm.action="editUUser.action";
					uuserForm.submit();
				}else{
					return false;
				}
			}
			function myaddSubmit(){
				if(true){ // myaddCheck()
					document.getElementsByName('uUser.fuserid')[0].value='0';
					uuserForm.action="editUUser.action";
					uuserForm.submit();
				}else
				{
					return false;
				}
			}
			function myGoListSubmit(){
				if(true){ //myaddCheck()
					uuserForm.action="listUUser.action";
					uuserForm.submit();
				}else
				{
					return false;
				}
			}
			
			function back(){
				uuserForm.action="listUUser.action?fdepid=${uUser.fdepid}";
				uuserForm.submit();
			}
		</script>
	</head>
	
	<body>
	<div class="easyui-panel" title="查看用户-${uUser.fname}" fit=true style="overflow: visibility ;">
		${mess}
		<s:form action="" name="uuserForm" namespace="/admin" theme="simple" method="post">	
			<s:hidden name="fdepid" value="${fdepid}"></s:hidden>
			<!-- 用于保存开始点击节点的id -->
			<s:hidden name="uUser.fuserid" value="%{uUser.fuserid}"></s:hidden>
			<s:hidden name="uUser.fdepid" value="%{uUser.fdepid}"></s:hidden>
			<s:hidden name="uUser.fdepname" value="%{uUser.fdepname}"></s:hidden>
			<table style="width:97%;border:0" >
				<tr>
					<td>
						<span style="float:right;">
							<s:if test="${empty(backType)}">
								<s:if test="${uUser.flivestate=='注销'}">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-remove'"  onclick="mydelSubmit();" />删除</a>
								</s:if>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'"  onclick="myeditSubmit();" />修改</a>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-add'"  onclick="myaddSubmit();" />增加</a>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="myGoListSubmit();" />返回</a>
							</s:if>
							<s:if test="!${empty(backType)}">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="back()">返回</a>
							</s:if>
						</span>
					</td>
				</tr>
			</table>
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable">
				<tr >
					<td class="EditHead" nowrap="nowrap" style="width: 10%">
						员工编码
					</td>
					<td class="editTd" nowrap="nowrap" style="width: 40%">
						<s:text name="%{uUser.fcode}"></s:text>
					</td>
					<td class="EditHead" nowrap="nowrap" style="width: 10%">
						用户名称
					</td>
					<td class="editTd" nowrap="nowrap" style="width: 40%">
						<s:text name="%{uUser.fname}"></s:text>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						登录名称
					</td>
					<td class="editTd">
						<s:text name="%{uUser.floginname}"></s:text>
					</td>
					<td class="EditHead">
						密码
						
					</td>
					<td class="editTd">
						******
					</td>
					
				</tr>
				<tr >
					<td class="EditHead">
						身份证
					</td>
					<td class="editTd">
						<s:text name="%{uUser.fcard}"></s:text>
					</td>
					<td class="EditHead">
						出生日期
					</td>
					<td class="editTd">
					    <fmt:formatDate value="${uUser.fborn}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						电话
					</td>
					<td class="editTd">
						<s:text name="%{uUser.fphone}"></s:text>
					</td>
					<td class="EditHead">
						手机
					</td>
					<td class="editTd">
						<s:text name="%{uUser.fmobile}"></s:text>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						Email
					</td>
					<td class="editTd">
						<s:text name="%{uUser.femail}"></s:text>
					</td>
					<td class="EditHead">
						性别
					</td>
					<td class="editTd">
						<s:text name="%{uUser.fsex}"></s:text>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						启用状态
					</td>
					<td class="editTd">
						<s:if test="uUser.flivestate=='zx'">
							注销
						</s:if>
						<s:elseif test="uUser.flivestate=='qy'">
							启用
						</s:elseif>
						<s:elseif test="uUser.flivestate=='dj'">
							冻结
						</s:elseif>
					</td>
					<td class="EditHead">
						在职状态
					</td>
					<td class="editTd">
						<s:select disabled="true" list="basicUtil.incumbencyStateList" id='cbb' name="uUser.fstate" cssStyle="width:160px;" cssClass="easyui-combobox" listKey="code" listValue="name"></s:select>
					</td>
					
				</tr>
				<tr >
					<td class="EditHead">
						所属部门或公司
					</td>
					<td class="editTd">
						<s:text name="%{uUser.fdepname}"></s:text>
					</td>
					<td class="EditHead">
						角色类型
					</td>
					<td class="editTd">
						<s:if test="uUser.flevel=='admin'">
							系统管理
						</s:if>
						<s:if test="uUser.flevel=='general'">
							业务操作
						</s:if>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						顺序号
					</td>
					<td class="editTd">
						${uUser.forder}
					</td>
					<td class="EditHead">
						是否审计人才
					</td>
					<td class="editTd">
						${uUser.isAudit}
					</td>
				</tr>
			</table>
		</s:form>
	</div>
	</body>
</html>
