<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			
		<title>法律法规</title>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<!--  引入DWR包 -->
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>	
		<!-- 长度验证 -->
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
		<script type="text/javascript">
	${jspRefresh}
	function mydelSubmit(){
		if(confirm("确认删除吗？")){
			window.location.href="delMenu.action?assistSuportLawslibMenu.id=${assistSuportLawslibMenu.id}&assistSuportLawslibMenu.classification=${assistSuportLawslibMenu.classification}";
		}else{
			return false;
		}
	}
	function myeditSubmit(){
		window.location.href="editMenu.action?assistSuportLawslibMenu.id=${assistSuportLawslibMenu.id}&assistSuportLawslibMenu.classification=${assistSuportLawslibMenu.classification}&nodeid=${nodeid}";
	}
	function myaddSubmit(){
		window.location.href="addMenu.action?mCodeType=flfg&nodeid=${nodeid}";
	}
	function mydelCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j<1){
			alert('请先至少选中一个在进行删除操作！');
			return  false;
		}
		return true;
	}
	//查看是否指定节点下有内容
	function exsitContent(){
		//校验项目类别名
		var category_name = document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value;
		if(category_name==null || category_name==''){
			alert("类别名称不能为空！");
			return false;
		}
		var priority = document.getElementsByName("assistSuportLawslibMenu.priority")[0].value;
		if(priority!="" && !isDigit(priority)){
			alert("优先级 只能是数字!");
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
		} 
		if(flag=='true'){
			if(confirm("此节点下有内容，是否同步内容的分类名称！"))
				document.getElementsByName("flag")[0].value="true";
		}
			
	}
	
	function myeditCheck(){
		s=document.getElementsByName("assistSuportLawslibMenu.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j<1){
			alert('请先选择一个再进行修改！');
			return false;
		}
		if(j>1){
			alert('修改操作只能选择一个进行修改！');
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
			alert('请不要在复选框中选中任何东西！');
			return false;
		}
		return true;
	}
	//重置
	function clearInfo(){
		document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value="";
		document.getElementsByName("assistSuportLawslibMenu.priority")[0].value="";
	}
	${malert}
	//数字校验
			function isDigit(s) { var patrn=/^[0-9]{1,4}$/; if (!patrn.exec(s)) return false; return true; }
</script>
	</head>
	<body> 
		
		${message} 
		<s:form action="saveMenu" namespace="/pages/assist/suport/lawsLib" name="lawsMenuForm"
			method="post" theme="simple">
			<s:hidden name="flag"/>
			<s:hidden name="nodeid" value="${nodeid}" />
			<s:hidden name="mCodeType" value="${mCodeType}" />
			
			<s:hidden name="assistSuportLawslibMenu.parent_id"
				value="%{assistSuportLawslibMenu.parent_id}" />
			<s:hidden name="assistSuportLawslibMenu.id"
				value="%{assistSuportLawslibMenu.id}" />
			<s:hidden name="assistSuportLawslibMenu.classification"
				value="%{assistSuportLawslibMenu.classification}" />
			<table class="ListTable">
				<tr>
					<td class="listtabletr11">
						所属类别
					</td>
					<td class="listtabletr2">
						<s:text name="%{parentTypeName}"></s:text>
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						类别名
					</td>
					<td class="listtabletr2">
						<s:if test="${empty(m_view)}">
						<s:textfield name="assistSuportLawslibMenu.category_name"
							value="%{assistSuportLawslibMenu.category_name}" maxlength="40"></s:textfield>
						</s:if>
						<s:else>
							${assistSuportLawslibMenu.category_name}
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						创 建 人
					</td>
					<td class="listtabletr2">
						<s:hidden name="assistSuportLawslibMenu.create_man"
							value="%{assistSuportLawslibMenu.create_man}" ></s:hidden>
							${assistSuportLawslibMenu.create_man}
						
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						单位
					</td>
					<td class="listtabletr2">
						<s:hidden name="assistSuportLawslibMenu.man_dept"></s:hidden>
						<s:hidden name="assistSuportLawslibMenu.deptId"></s:hidden>
							${assistSuportLawslibMenu.man_dept}
						
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						创建日期
					</td>
					<td class="listtabletr2">
							<s:hidden name="assistSuportLawslibMenu.create_date" value="${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}" ></s:hidden>
							<s:if test="!${empty(assistSuportLawslibMenu.create_date)}">
								${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}
						</s:if>
					</td>
				</tr>
				<tr>
					<td class="listtabletr11">
						优先级
					</td>
					<td class="listtabletr2">
						<s:if test="${empty(m_view)}">
						<s:textfield name="assistSuportLawslibMenu.priority"
							value="%{assistSuportLawslibMenu.priority}" maxlength="40"></s:textfield>
						</s:if>
						<s:else>
							${assistSuportLawslibMenu.priority}
						</s:else>
					</td>
				</tr>
			</table>
			<s:if test="!${empty(m_view)}">
			<table style="width:97%;border:0" >
				<tr>
					<td>
						<span style="float:right;">
							<s:button value="删除" onclick="mydelSubmit();"></s:button>
							<s:button value="修改" onclick="myeditSubmit();"></s:button>
							<s:button value="增加" onclick="myaddSubmit();"></s:button>
						</span>
					</td>
				</tr>
			</table>
			</s:if>
			<s:if test="${empty(m_view)}">
				<table style="width:97%;border:0" >
					<tr>
						<td>
							<span style="float:right;">
								<s:submit value="保存" align="center" onclick="return exsitContent()"></s:submit>
								<s:button value="重置" align="center" onclick="return clearInfo()"></s:button>
							</span>
						</td>
					</tr>
				</table>
			</s:if>
		</s:form>
		
	</body>
</html>