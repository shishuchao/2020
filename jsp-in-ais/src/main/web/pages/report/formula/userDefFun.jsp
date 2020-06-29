<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
Function exeUserDefFun()
	<s:iterator value="result">
		'公式-${cnName}
	    str = """${attributeName}"" ${rettype} ${funName}(${inParam})"
	    str = str & vbCrLf & "BEGIN_HELP"
	    str = str & vbCrLf & "${rettype} ${cnName}(${inParamCn})"
	    str = str & vbCrLf & "${remark}"
	    str = str & vbCrLf & "END_HELP"
		document.getElementById("CellWeb1").DefineFunctions(str) 
	</s:iterator>
End Function