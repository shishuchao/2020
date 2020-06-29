<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/ledger.js"></script>
		<title>台账分析</title>
		<script language="javascript">  
function saveForm(){
 var leftcodes= document.getElementsByName("leftcodes");
 var flog=false;
 var num=0;
 for(i=0;i<leftcodes.length;i++){
   if(leftcodes[i].checked){
     flog=true;
     num=num+1;
     document.getElementsByName("mode_condition")[0].value=leftcodes[i].value;
   }
 }
 if(!flog){
    alert("请选择！");
    return false;
   }
 if(num>1){
	 alert("只能选择一个！");
	 return false;
 }
 myForm.submit();
}
//-->  
</script>
		<script type="text/javascript"> 　
  function oo(){
  var codes= window.opener.document.getElementsByName("codes")[0].value;
  var names= window.opener.document.getElementsByName("names")[0].value;
  document.getElementsByName("codes")[0].value=codes;
  document.getElementsByName("names")[0].value=names;
  }
</script>
		<style>
.searchtable {
	background-color: white;
	border: 1px solid #A9B9CD;
	border-bottom: 1px solid silver;
}
</style>
	</head>
	<body onload="oo()">
		<s:form name="myForm" namespace="/ledger/ledgerAnalyse"
			action="queryLedgerAnalyse">
			<table>
			<s:iterator value="list">
								<tr>
									<td>
										<INPUT TYPE="checkbox" NAME="leftcodes"
											value="<s:property value="leftcodes"/>&<s:property value="rightcodes"/>">
									</td>
									<td>
										<s:property value="name" />
									</td>
								</tr>
			</s:iterator>
				<tr>
					<td colspan="2" align="right">
						<p align="right">
							<s:button value="查询" onclick="saveForm()"></s:button>
						</p>
					</td>
				</tr>
			</table>
			<s:hidden name="poName"></s:hidden>
			<s:hidden name="className"></s:hidden>
			<s:hidden name="isAuth"></s:hidden>
			<s:hidden name="project_code"></s:hidden>
			<input type="hidden" name="codes">
			<input type="hidden" name="names">
			<s:hidden name="mode_condition" />
		</s:form>
	</body>
</html>
