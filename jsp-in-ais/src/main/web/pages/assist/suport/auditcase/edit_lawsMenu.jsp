<!DOCTYPE HTML>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>案例分类维护</title>
		
	<!-- 全局 -->			
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script type="text/javascript">
	function mydelSubmit(){
			parent.parent.$.messager.confirm('确认对话框', '确认删除吗?', function(r){
			if (r){    
				//lawsMenuForm.action="../lawsLib/delMenu.action";
				//lawsMenuForm.submit();
				window.location.href="/ais/pages/assist/suport/lawsLib/delMenu.action?assistSuportLawslibMenu.id=${assistSuportLawslibMenu.id}&assistSuportLawslibMenu.classification=${assistSuportLawslibMenu.classification}";
				parent.location.reload();
			}else{
				return false;
			}    
		});
	}
	function myeditSubmit(){
		window.location.href="../lawsLib/editMenu.action?assistSuportLawslibMenu.id=${assistSuportLawslibMenu.id}&assistSuportLawslibMenu.classification=${assistSuportLawslibMenu.classification}&nodeid=${nodeid}";
	}
	function myaddSubmit(){
		window.location.href="../lawsLib/addMenu.action?mCodeType=${mCodeType}&nodeid=${nodeid}";
	}
	function mydelCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j<1){
			showMessage1('请先至少选中一个在进行删除操作！','消息','0');
			return  false;
		}
		return true;
	}
	//查看是否指定节点下有内容
	function exsitContent(){
		var category_name = document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value;
		if(category_name==null || category_name==''){
			showMessage1('类别名称不能为空！','消息','0');
			return false; 
		}
		var priority = document.getElementsByName("assistSuportLawslibMenu.priority")[0].value;
		if(priority!="" && !isDigit(priority)){
			showMessage1('优先级只能是数字!','消息','0');
			return false;
		}
		//ajax验证内容是否存在
		var flag = 'false';
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute({ namespace:'/pages/assist/suport/lawsLib', action:'exsitMenuContent', executeResult:'false' },
		{'id':'${assistSuportLawslibMenu.id}'},xxx);
		function xxx(data){
			flag = data['flag'];
			document.getElementsByName("flag")[0].value = data['flag'];
			document.getElementById("form1").submit();
			showMessage1('保存成功!','消息','0');
			parent.location.reload();
		} 
		if(flag=='true'){
			if(confirm("此节点下有内容，是否同步内容的分类名称！")){
				document.getElementsByName("flag")[0].value="true";
				document.getElementById("form1").submit();
				parent.location.reload();
			}
		}	
	}
	function myeditCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		//s=lawsForm.getElementsByTagName("assistSuportLawslib.id");
		//alert(s.length);
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j<1){
			showMessage1('请先选择一个再进行修改！','消息','0');
			return false;
		}
		if(j>1){
			showMessage1('修改操作只能选择一个进行修改！','消息','0');
			return false;
		}
		return true;
	}
	function myaddCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j!=0){
			showMessage1('请不要在复选框中选中任何东西！','消息','0');
			return false;
		}
		return true;
	}
	//重置
	function clearInfo(){
		document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value="";
		document.getElementsByName("assistSuportLawslibMenu.priority")[0].value="";
	}
	//数字校验
	function isDigit(s) { var patrn=/^[0-9]{1,4}$/; if (!patrn.exec(s)) return false; return true; }
	</script>
	</head>
	<body>
		<s:form action="saveMenu" namespace="/pages/assist/suport/lawsLib" id="form1" name="lawsMenuForm" method="post" theme="simple">
			<s:if test="!${empty(m_view)}">
				<table style="width: 100%; border: 0">
					<tr>
						<td>
							<span style="float: left;"> 
								<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="myaddSubmit()">新增</a>&nbsp;&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="myeditSubmit()">修改</a>&nbsp;&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="mydelSubmit()">删除</a>&nbsp;&nbsp;
							 </span>
						</td>
					</tr>
				</table>
			</s:if>
			<s:if test="${empty(m_view)}">
				<table style="width: 100%; border: 0">
					<tr>
						<td>
							<span style="float: left;">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="return exsitContent()">保存</a>&nbsp;&nbsp; 
								<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="clearInfo()">重置</a>&nbsp;&nbsp;
								<!--<s:submit value="保存" align="center" onclick="return exsitContent()"></s:submit>-->
							</span>
						</td>
					</tr>
				</table>
			</s:if>
			<s:hidden name="flag" />
			<s:hidden name="nodeid" value="${nodeid}" />
			<s:hidden name="mCodeType" value="${mCodeType}" />

			<s:hidden name="assistSuportLawslibMenu.parent_id"
				value="%{assistSuportLawslibMenu.parent_id}" />
			<s:hidden name="assistSuportLawslibMenu.id"
				value="%{assistSuportLawslibMenu.id}" />
			<s:hidden name="assistSuportLawslibMenu.classification"
				value="%{assistSuportLawslibMenu.classification}" />
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td style="width: 150px" class="EditHead">
						父节点的名称
					</td>
					<td class="editTd">
						<s:text name="%{parentTypeName}"></s:text>
						<br>
					</td>
				</tr>
				<tr>
					<s:if test="${empty(m_view)}">
						<td class="EditHead">
							<font style="color: red;">*</font>&nbsp;类别名
						</td>
						<td class="editTd">
							<s:textfield name="assistSuportLawslibMenu.category_name" cssStyle="width:160px;"  cssClass="noborder"
								value="%{assistSuportLawslibMenu.category_name}" maxlength="40"></s:textfield>
						</td>
					</s:if>

					<s:else>
						<td class="EditHead">
							类别名
						</td>
						<td class="editTd">
							${assistSuportLawslibMenu.category_name}
						</td>
					</s:else>
				</tr>
				<tr>
					<td class="EditHead">
						创建人
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.create_man"
							value="%{assistSuportLawslibMenu.create_man}"></s:hidden>
						${assistSuportLawslibMenu.create_man}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						单位
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.man_dept"></s:hidden>
						${assistSuportLawslibMenu.man_dept}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						创建日期
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.create_date"
							value="${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}"></s:hidden>
						<s:if test="!${empty(assistSuportLawslibMenu.create_date)}">
							${assistSuportLawslibMenu.create_date}
						</s:if>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						优先级
					</td>
					<td class="editTd">
						<s:if test="${empty(m_view)}">
							<s:textfield name="assistSuportLawslibMenu.priority" cssStyle="width:160px;"  cssClass="noborder"
								value="%{assistSuportLawslibMenu.priority}" maxlength="4"></s:textfield>
						</s:if>
						<s:else>
							${assistSuportLawslibMenu.priority}
						</s:else>
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>