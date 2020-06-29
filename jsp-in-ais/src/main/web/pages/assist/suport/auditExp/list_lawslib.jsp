<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<s:head />
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>	
<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>		
<script type='text/javascript'
		src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript'
		src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript'
		src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript">
	function mydelSubmit(){
		if(mydelCheck()){
			if(confirm("确认删除吗？")){
				s=document.getElementsByName("assistSuportLawslib.id");
				j=0;
				var ids="";
				for(i=0;i<s.length;i++){
					if(s[i].checked){
						ids = ids + s[i].value+",";
						j=j+1;
					}
				}
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/pages/assist/suport/lawsLib', action:'deleteisnotJy', executeResult:'false' }, 
						{'ids':ids},
						xxx);
				function xxx(rs){
					if(rs['exis']=='false'){
						alert('所选信息当中，有处于已发布状态，请先执行撤消操作！');
						return false ;
					}else{
						lawsForm.submit();
					}
				}
			}else{
				return false;
			}
		}else
		{
			return false;	
		}
	}
	function myeditSubmit(){
		if(myeditCheck()){
		lawsForm.action="../lawsLib/edit.action";
		lawsForm.submit();
		}else{
			return false;
		}
	}
	function myaddSubmit(){
		url="../lawsLib/add.action?mCodeType=${mCodeType}&nodeid=${nodeid}";
		window.location=url;
	}
	function mydelCheck(){
				s=document.getElementsByName("assistSuportLawslib.id");
				j=0;
				var ids="";
				for(i=0;i<s.length;i++){
					if(s[i].checked){
						ids = ids + s[i].value+",";
						j=j+1;
					}
				}
				if(j<1){
					alert('请先选中记录再进行删除操作！');
					return  false;
				}
				document.getElementById("ids").value=ids;
				return true;
	}
	function myeditCheck(){
		s=document.getElementsByName("assistSuportLawslib.id");
		j=0;
		for(i=0;i<s.length;i++){
			if(s[i].checked)
				j=j+1;
		}
		if(j<1){
			alert('请先选择一条记录再进行修改！');
			return false;
		}
		if(j>1){
			alert('修改操作只能选择一条记录进行修改！');
			return false;
		}
		return true;
	}
	function mSearchSub(){
		document.forms[0].action="search.action";
		document.forms[0].submit();
	}
	//批量发布  撤销批量发布
	function mypub(status){
		if(status=="Y")
			url="../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=Y";
		else
			url="../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=N";
		var chkboxs=document.getElementsByName("assistSuportLawslib.id");
		var counter=0;
		var ids ="";
		if(chkboxs.length<1){alert("请选择一条记录进行发布！");return false;}
		for(i=0;i<chkboxs.length;i++){
			if(chkboxs[i].checked){
				if(chkboxs[i].ispub!=status){
					ids = ids + chkboxs[i].value + ",";
					counter++;
				}
			}
		}
		if(counter<1){
			if(status=="Y")
				alert("请至少选择一条未发布记录进行发布！");
			else
				alert("请至少选择一条已发布记录进行撤销发布！");
			return false;
		}
		window.location= url + "&ids=" + ids;
	}
</script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<title>审计案例</title>
</head>
<body>
<center>
<s:form action="delete" namespace="/pages/assist/suport/lawsLib" method="post" name="lawsForm">
	${message}
	<%@include file="/pages/assist/suport/auditExp/include_search2.jsp"%>	
	<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
	<s:hidden name="nodeid" value="${nodeid}"></s:hidden><br>
	
	<div align="center">
	<display:table name="objectList" id="row"  class="its" requestURI="/pages/assist/suport/lawsLib/listByTypeKey.action"
		 pagesize="${baseHelper.pageSize}" partialList="true" 
		size="${baseHelper.totalRows}" sort="external"
		defaultsort="2" defaultorder="descending" >
			<display:column title="" headerClass="center" class="center"><!-- 操作类型 -->
				<input type="checkbox" name="assistSuportLawslib.id" value="${row.id}" ispub='${row.pub_state}' >
			</display:column>
			<display:column title="名称" property="title" sortable="true" headerClass="center" class="left" 
				style="WHITE-SPACE: nowrap;width:120;word-break : break-all" sortName="title"/>
			<display:column title="发布单位" property="promulgationDept" sortable="true" headerClass="center" class="left" 
				style="WHITE-SPACE: nowrap;width:120;word-break : break-all" sortName="promulgationDept"/>
			<display:column title="创建日期" sortable="true" headerClass="center" class="left" maxLength="10" property="createDate" sortName="createDate">
			</display:column>
			<display:column title="颁布日期" sortable="true" headerClass="center" class="left" maxLength="10" property="promulgationDate" sortName="promulgationDate">
			</display:column>
			<display:column title="经验类别" sortable="true" headerClass="center" class="left" sortName="category">${row.category}</display:column>
			<display:column title="发布状态" sortable="true" headerClass="center" class="center" sortName="pub_state">
					<s:if test="${row.pub_state=='Y'}">
						是
					</s:if>
					<s:else>
						否
					</s:else>
				</display:column>
	</display:table>
	</div>
	<table style="width:97%;border:0" >
		<tr>
			<td>
				<span style="float:right;">
					<s:button value="全选" onclick="checkall('assistSuportLawslib.id');"></s:button> 
					<s:button value="反选" onclick="checkback('assistSuportLawslib.id');"></s:button> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<s:button value="删除" onclick="mydelSubmit();"></s:button>
					<s:hidden name="ids" id="ids"></s:hidden>
					<s:button value="修改" onclick="myeditSubmit();"></s:button>
					<s:button value="增加" onclick="myaddSubmit();"></s:button>
					<s:button value="批量发布" onclick="mypub('Y');"></s:button>
					<s:button value="批量撤销发布" onclick="mypub('N');"></s:button>
				</span>
			</td>
		</tr>
	</table>
</s:form>
</center>
</body>
</html>