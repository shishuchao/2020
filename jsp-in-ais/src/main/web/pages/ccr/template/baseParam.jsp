<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>基础参数</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<script type='text/javascript'
			src='${contextPath}/dwr/engine.js'></script>
		<style type="text/css">
			textarea {
				width: 90%;
				height: 50px;
			}
		</style>
		<SCRIPT type="text/javascript">
			function insertTheRows(){
				var con = parent.parent.childBasefrm;
				con.insertTheRows();
			}
			function getSheetName(){
					var _sheetIndex = parent.parent.childBasefrm.CellWeb1.GetCurSheet();
					var _sheetName = parent.parent.childBasefrm.CellWeb1.GetSheetLabel(_sheetIndex);
					document.getElementById('sheetName').value = _sheetName;
				}
			
			function sumCategoryChange(){
				var su = document.getElementsByName('parameter.isSum');
				var suvalue;
				for(i=0;i<su.length;i++){
					if(su[i].checked)
						suvalue = su[i].value;
				}
				if(suvalue == 1){
						document.getElementById("detailList").style.display="block";	
				}else{
					document.getElementById("detailList").style.display="none";
				}
			}
			
			function paramSave(){
				document.forms[0].submit();
			}
			
		</SCRIPT>
</head>
<body onload="getSheetName(); sumCategoryChange(); ">
	<s:form action="paramSave.action" namespace="/ccrTemplate" name="editForm" id="form1">
		<s:hidden name="parameter.id"/>
		<s:hidden name="parameter.sheetIndex"/>
		<s:hidden name="parameter.sheetName" id="sheetName"/>
		<s:hidden name="parameter.templateId"></s:hidden>
		<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 align="right">
						是否汇总
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="80%" align="left">
							<s:radio id="issum" list="#@java.util.LinkedHashMap@{'0':'否','1':'是'}" value="${parameter.isSum }" name="parameter.isSum" onclick="sumCategoryChange(); "></s:radio>
					</TD>
				</TR>
				
		</TABLE>
		<div align="right">
			
				<s:button value="保存" onclick="paramSave(); "/>
				&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
	</s:form>
	<br>
	<center>
		<iframe id="detailList" width="100%" frameborder="0" height="400px"  src="${contextPath }/ccrTemplate/detailList.action?paramId=${parameter.id}"></iframe>
	</center>
</body>

</html>