<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<title>选择单位</title>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script language="javascript">
function toSetVal(){
	var sData = dialogArguments;
	var objs = document.getElementsByName("ids");
	var objVals = "";
	var objNames = "";
	for(var i=0;i<objs.length;i++){
		if(objs[i].checked){
			objVals+=objs[i].value+",";
			objNames+=document.getElementById(objs[i].value).value+",";
		}
	}
	sData.idlist=objVals.substring(0,objVals.length-1);
	sData.namelist=objNames.substring(0,objNames.length-1);
	self.close();
}

</script>
<body>

<table width="100%" border="0" cellspacing="5" cellpadding="0" align=center >
	<tr>
		<td>
			<TABLE width="100%"  border=0 cellPadding=1 cellSpacing=1 cols=7 bgcolor="#409cce" class=ListTable size="20" align="center" id="projTable">
				<tr align=center class="titletable1">
                  <td class="1_lan"  width=8% height="20">选项</td>
                  <td class="1_lan" width=18%>单位名称 </td>
				</tr>
				<s:iterator value="deptList" status="dept">
			 		<tr  id="tr${fid }">
			 			<td class=ListTableTr2><input type="checkbox" name="ids" value="${fid }"/> </td>
			 			<input type="hidden" id="${fid }" name="names" value="${fname }"/>
			 			<td colspan="2" class=ListTableTr2 cols=2>${fname }</td>				 			
			 		</tr>
		 		</s:iterator>
			</TABLE>

	<tr>
		<td align=right>
        	<input name="Submit" type="button" class="button23" value="确 定" onclick="toSetVal()">
		</td>
	</tr>
</table>
</body>
</html>
