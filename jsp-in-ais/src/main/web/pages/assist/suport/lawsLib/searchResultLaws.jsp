<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 

		<title>法律法规</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
		src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
			<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script> 
			<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		
	</head>
	<script type="text/javascript">
	function mydelSubmit(){
		if(mydelCheck()){
			if(confirm("确认删除吗？")){
			lawsForm.action="deleteLaws.action";
				lawsForm.submit();
			}else{
				return false;
			}
		}else
		{
			return false;	
		}
	}
	
	function reset2(){
		setNull("assistSuportLawslib.title");
		setNull("assistSuportLawslib.codification");
		setNull("assistSuportLawslib.promulgationDate");
		setNull("assistSuportLawslib.effctiveDate");
		setNull("assistSuportLawslib.invalidationDate");
		setNull("assistSuportLawslib.promulgationDept");
		setNull("assistSuportLawslib.category");
		setNull("assistSuportLawslib.effective");
		setNull("assistSuportLawslib.content");
		setNull("assistSuportLawslib.categoryFk");
		
		
		document.forms[0].action="search.action";
		document.forms[0].submit();
	}
	
	function myeditSubmit(){
		if(myeditCheck()){
		lawsForm.action="editLaws.action";
		lawsForm.submit();
		}else{
			return false;
		}
	}
	function myaddSubmit(){
		url="../lawsLib/addLaws.action?mCodeType=${mCodeType}&marked=1";
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
			alert('请先选择一条记录在进行修改！');
			return false;
		}
		if(j>1){
			alert('修改操作只能选择一条记录进行修改！');
			return false;
		}
		return true;
	}
	//批量发布  撤销批量发布
	function mypub(status){
		if(status=="Y")
			url="../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=Y&marked=1";
		else
			url="../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=N&marked=1";
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
	//查询
	function mSearchSub(){
		var _content = document.getElementsByName("assistSuportLawslib.content")[0].value;
		if(_content != null && _content != ""){
			document.forms[0].action="indexSearch_flfg_edit.action";
			document.forms[0].submit();
		}else{
			document.forms[0].action="search.action";
			document.forms[0].submit();
		}
	}
	
		function fileexistence(fileid){
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/pages/assist/suport/lawsLib', action:'fileexis', executeResult:'false' }, 
		{ 'fileId':fileid },
		xxx);
	    function xxx(data){
	     	if(data['exis'] != null && data['exis'] == '1'){
	     		var url = "${contextPath}" + "/commons/file/downloadFile.action?fileId=" + fileid;
				window.open(url, "","height=500px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	     	}
	     	if(data['exis'] != null && data['exis'] == '0'){
	     		alert('您所要查看的文件已不存在！');
	     	}	
	     	
		}
	}
	
	function createindex(){
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/pages/assist/suport/lawsLib', action:'createIndex', executeResult:'false' }, 
		{  },
		xxx);
	    function xxx(data){
	     		if(data['createStatus'] != null && data['createStatus'] == '1'){
	     		alert("索引创建成功");
	     	}
		}
	}
	</script>
	<body>
		<center>
	<s:form action="indexSearch_flfg_edit.action" name="lawsForm">
<%@include file="/pages/assist/suport/lawsLib/include_search2.jsp"%>
${message}
<s:hidden name="mCodeType" value="flfg"></s:hidden>

	<display:table name="r4dList" id="row"  class="its" 
		pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}"
		  requestURI="/pages/assist/suport/lawsLib/indexSearch_flfg_edit.action" 
			sort="external"
				defaultsort="4" defaultorder="descending">
			<display:column>
				<input type="checkbox" name="assistSuportLawslib.id" ispub='${row.pub_state}'
						value="${row.id}">
						&nbsp;&nbsp;
				<a href="editLaws.action?assistSuportLawslib.id=${row.id}"><font style="font-size: 14px;font-weight: 600">${row.articleTitle }</font></a>
				<br/>
					<a><font style="font-size: 12px">${row.displayContent }</font></a> 
				
				
				<s:if test="${row.file4Display != null}">
				<br/>
				<a>快速查看 : </a>
					<c:forEach var="tmp" items="${row.file4Display }">
						<a href="javascript:void(0);" onclick="fileexistence('${tmp.key }'); ">${tmp.value }</a>&nbsp;&nbsp;
					</c:forEach>
				</s:if>
				<br/>
				<a>创建日期 : ${row.createDate }</a> &nbsp;&nbsp;&nbsp;&nbsp;
				<a>发布状态:  <font color="#ff0000">${row.pub_state }</font></a>
				
			</display:column>
	</display:table>
			<!-- 样式 -->
			<table style="width: 100%; border: 0">
				<tr>
					<td>
						<span style="float: right;"> 
								<s:button value="全选" onclick="checkall('assistSuportLawslib.id');"></s:button> 
								<s:button value="反选" onclick="checkback('assistSuportLawslib.id');"></s:button> 
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<s:button value="删除" onclick="mydelSubmit();"></s:button> 
								<s:hidden name="ids" id="ids"></s:hidden>
								
								
								<s:button value="修改" onclick="myeditSubmit();"></s:button> 
								<s:button value="增加" onclick="myaddSubmit();"></s:button>
								<s:button value="批量发布" onclick="mypub('Y');"></s:button>
								<s:button value="批量撤销发布" onclick="mypub('N');"></s:button>
								<s:button value="生成索引" onclick="createindex(); "></s:button>
						</span>
					</td>
				</tr>
			</table>
		</s:form>
		</center>
	</body>
	
</html>