<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
var v_formula = new Object();
<s:iterator value="result" id="row">
	v_formula.${funName} = new Object();
	v_formula.${funName}.attri = ${attributeCode};
	v_formula.${funName}.pnames = new Array();
	v_formula.${funName}.pDataType = new Array();
	<s:iterator value="orderInParameters">
		v_formula.${funName}.pnames.push('${paramName}');
		v_formula.${funName}.pDataType.push('${dataType}');
	</s:iterator>
</s:iterator>
function getFormulaAttri(funName){
	return v_formula[funName].attri;
}
function getFormulaParaName(funName,pOrder){
	return v_formula[funName].pnames[pOrder];
}
function getFormulaParaType(funName,pOrder){
	return v_formula[funName].pDataType[pOrder];
}
function getFormulaValue(funName,pOrder,vle){
	if(getFormulaParaType(funName,pOrder)=='5'){
		try{
			return DateStr(vle,1);
		}catch(e){
			return vle;
		}
	}else{
		return vle;
	}
}