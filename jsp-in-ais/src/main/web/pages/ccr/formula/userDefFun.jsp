<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
Function exeUserDefFun()
<s:iterator value="formulaList">
	str = """${templateTypeName}""${rettype} ${formulaName}(${paras})"
	str = str & vbCrLf & "BEGIN_HELP"
	str = str & vbCrLf & "${formulaNameCn} "
	str = str & vbCrLf & "【函数】:  ${rettype} ${formulaName}(${paras})"
	str = str & vbCrLf & "【报表】:  ${templateTypeName};"
	str = str & vbCrLf & "【说明】:  ${mark};"
	str = str & vbCrLf & "【参数】:  ${paras};"
	' 用法注释掉  其中双引号异常 待解决
	'str = str & vbCrLf & "【用法】:  ${usage};"
	str = str & vbCrLf & "【示例】:  ${exam};"
	str = str & vbCrLf & "END_HELP"
	document.getElementById("CellWeb1").DefineFunctions(str) 
</s:iterator>
End Function

