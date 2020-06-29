<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新建公式</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="<%=basePath%>scripts/jquery-1.4.3.min.js"></script>
</head>
<body>
	<s:form id="attachedFormulaForm" action="saveAttachedFormula"
		namespace="/attached/formula" target="_parent">
		<s:hidden name="attachedFormula.formulaid" />
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" align="center" style="width: 80%;">
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					<font color=red>*</font>公式名称：
				</td>
				<td class="ListTableTr22" >
					<s:textfield name="attachedFormula.formulaname" id="formulaname" title="公式名称" />
				</td>
				<td class="ListTableTr11" nowrap="nowrap">
					<font color=red>*</font>公式编码：
				</td>
				<td class="ListTableTr22">
					<s:textfield name="attachedFormula.formulacode" id="formulacode" title="编码" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" />
				</td>
			</tr>
			
			<tr>
				<td class="ListTableTr11" nowrap="nowrap"><font color=red>*</font>数据源：
				</td>
				<td class="ListTableTr22"  colspan="3"><s:select id="dsType"
						name="attachedFormula.datasourcetype"
						list="#@java.util.LinkedHashMap@{'guanli':'管理系统','zaixian':'在线审计'}"
						disabled="false" theme="ufaud_simple"
						templateDir="/strutsTemplate" /> &nbsp;&nbsp; <a href='javascript:checkDB();'>测试数据源</a></td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">输入参数：</td>
				<td class="ListTableTr22" colspan="3">
				<s:textarea name="attachedFormula.paramin" title="输入参数" cssStyle="width:100%;height:20px;" />
				</td>
						
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">公式内容：</td>
				<td class="ListTableTr22" colspan="3"><s:textarea
						name="attachedFormula.formulacontent" rows="20"
						cssStyle="width:100%;height:200px;" title="公式内容" /></td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap" colspan="4"
					style="text-align: left;">说明：<br> 1.参数名称在公式中用##包围起来<br>
					2.系统内建参数列表如下：<br> (1)startdate:审计期间开始,字符型(yyyyMMdd)<br>
					(2)enddate:审计期间结束,字符型(yyyyMMdd)<br> (3)projectcode:项目编号,字符型<br>
				</td>
			</tr>
		</table>
	</s:form>
</body>
<script type="text/javascript">
//验证数据源
function checkDB(){
  var dstype = $("#dsType").val();
  var dbtext = $("#dsType :selected").text();
   $.ajax({
   type: "POST",
   url: "<%=basePath%>attached/file/attachedfile!checkDB.action",
   data: {"dstype":dstype},
   success: function(msg){
        if(1 != msg){
           alert(dbtext+"数据源连接失败！");
        }else{
           alert(dbtext+"数据源连接成功！");
        }
   }
});
}
</script>
</html>