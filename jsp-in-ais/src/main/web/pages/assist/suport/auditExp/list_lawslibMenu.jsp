<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript">
${jspRefresh}
	function mydelSubmit(){
		if(mydelCheck()){
			lawsMenuForm.submit();
		}else
		{
			return false;	
		}
	}
	function myeditSubmit(){
		if(myeditCheck()){
		lawsMenuForm.action="../lawsLib/editMenu.action";
		lawsMenuForm.submit();
		}else{
			return false;
		}
	}
	function myaddSubmit(){
		if(myaddCheck()){
		lawsMenuForm.action="../lawsLib/addMenu.action";
		lawsMenuForm.submit();
		}else
		{
			return false;
		}
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
			alert('请先选择一个再进行编辑！');
			return false;
		}
		if(j>1){
			alert('编辑操作只能选择一个进行编辑！');
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
	
</script>

<title>审计经验</title>
<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
</head>
<body>
<h1>这个方法没有该，应该时没有使用的页面</h1>
<s:form action="delMenu" method="post" namespace="/pages/assist/suport/lawsLib" name="lawsMenuForm">
<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
	<s:button value="删除" onclick="mydelSubmit();"></s:button>
	<s:button value="编辑" onclick="myeditSubmit();"></s:button>
	<s:button value="增加" onclick="myaddSubmit();"></s:button>
	<br>
	<display:table name="nodeList" id="mnode"  class="its" pagesize="10"  excludedParams="*"  requestURI="/pages/assist/suport/lawsLib/listMenu.action" 
			defaultorder="descending">
			<display:column title="操作">
			<%-- 
				<a href="<s:url action="editMenu"><s:param name="abc" value="456"/></s:url>&assistSuportLawslibMenu.id=${mnode.id}&nodeid=${nodeid}">编辑</a>
				<a href="<s:url action="delMenu"><s:param name="abc" value="456"/></s:url>&assistSuportLawslibMenu.id=${mnode.id}&nodeid=${nodeid}">删除</a>
			--%>
				<input type="checkbox" name="assistSuportLawslibMenu.id" value="${mnode.id}" >
			</display:column>
			<display:column title="主键" >${mnode.id}</display:column>
			<display:column title="种类名称">
				<s:if test="${mnode.level}!=0">
					<c:forEach 	begin="1" end="${mnode.level}">
						<img src="/ais/images/T.png"/>
					</c:forEach>
				</s:if>
			 	${mnode.categoryName}
				<%-- 
			 	 ${mnode.level}
			 	--%> 
			</display:column>
			<display:column title="创建人" >${mnode.createMan}</display:column>
			<display:column title="创建日期">
				<dt:format pattern="yyyy-MM-dd"><dt:parse pattern="yyyy-MM-dd HH:mm:ss.S">
				${mnode.createDate}
				</dt:parse></dt:format>
			<%-- 
			${mnode.createDate}
			--%>
			</display:column>
			
			
			</display:table>
</s:form>
</body>
</html>