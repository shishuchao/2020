<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>新建公式</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:form id="formulaForm" action="saveFormula"
			namespace="/unitary/nc/autoreport" target="_parent">
			<s:hidden name="formula.id" />
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width: 15%;" nowrap="nowrap">
						<font color=red>*</font>&nbsp;公式名称
					</td>
					<td class="editTd" style="width: 35%;">
						<s:textfield  name="formula.name" cssStyle="width:160px;" id="formulaName"
							cssClass="noborder"  maxlength="255" title="公式名称" />
					</td>
					<td class="EditHead" style="width: 15%;" nowrap="nowrap">
						<font color=red>*</font>&nbsp;返回类型
					</td>
					<td class="editTd" style="width: 35%;">
						<select id="returnType" class="easyui-combobox" name="formula.returnType" style="width:150px;" panelHeight="auto">
					       <s:iterator value="#@java.util.LinkedHashMap@{'zifuchuan':'字符串','shuzhi':'数值','biaoge':'表格','duanluo':'段落'}" id="entry">
					         <s:if test="${formula.returnType==key}">
					          <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
					         </s:if>
					         <s:else>
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:else>
					       </s:iterator>
						</select> 
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>&nbsp;数据源
					</td>
					<td class="editTd">
						<select id="dsType" class="easyui-combobox" name="formula.dsType" style="width:150px;" panelHeight="auto">
					       <s:iterator value="#@java.util.LinkedHashMap@{'guanli':'管理系统','zaixian':'在线审计','neikong':'内控评价'}" id="entry">
					         <s:if test="${formula.dsType==key}">
					          <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
					         </s:if>
					         <s:else>
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:else>
					       </s:iterator>
					    </select> 
					</td>
					<td class="EditHead" nowrap="nowrap">
						输入参数
					</td>
					<td class="editTd" colspan="3">
						<s:textfield name="formula.paramIn" cssStyle="width:160px;"
						cssClass="noborder" maxlength="500" title="输入参数" />
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap="nowrap">
						公式内容
					</td>
					<td class="editTd" colspan="3">
						<s:textarea name="formula.content" rows="20"
						cssClass="noborder" cssStyle="width:100%;height:200px;" title="公式内容" />
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap="nowrap" colspan="4"
						style="text-align: left;">
						说明：
						<br>
						1.参数名称在公式中用##包围起来
						<br>
						2.系统内建参数列表如下：
						<br>
						(1)startdate:审计期间开始,字符型(yyyyMMdd)
						<br>
						(2)enddate:审计期间结束,字符型(yyyyMMdd)
						<br>
						(3)projectcode:项目编号,字符型
						<br>
						(4)manuId:底稿编号,字符型
						<br>
						(5)evaProjectFormId:内控编号,字符型
						<br>
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>
