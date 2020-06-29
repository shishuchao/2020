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
 var rightcodes= document.getElementsByName("rightcodes");
 var unitcodes= document.getElementsByName("unitcodes");
 var flog=false;
 for(i=0;i<leftcodes.length;i++){
   if(leftcodes[i].checked){
     flog=true;
   }
 }
 if(!flog){
    alert("请选择分类字段！");
    return false;
   }
 var flog1=false;
  for(i=0;i<rightcodes.length;i++){
   if(rightcodes[i].checked){
     flog1=true;
   }
 }
  if(!flog1){
    alert("请选择统计字段！");
    return false;
   }
 
  if(unitcodes.length>0){
    var flog2=false;
    var count=0;
   for(i=0;i<unitcodes.length;i++){
    if(unitcodes[i].checked){
      flog2=true;
      count++;
    }
   }
 
   if(count>1){
     alert("统计单位只能选择一个！");
     return false;
   }
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
			<table align="center" class="searchtable">
				<tr>
					<td>
						<table id="grid" class="searchtable">
							<tr>
								<td>

								</td>
								<td>
									<STRONG>分类字段</STRONG>
								</td>
							</tr>
							<s:iterator value="list_left">
								<tr onclick="select(this);">
									<td>
										<INPUT TYPE="checkbox" NAME="leftcodes"
											value="<s:property value="code"/>">
									</td>
									<td>
										<s:property value="name" />
									</td>
								</tr>
							</s:iterator>
						</table>
					</td>
					<td>
						<table id="right" class="searchtable">
							<tr>
								<td>

								</td>
								<td>
									<STRONG>统计字段</STRONG>
								</td>
							</tr>
							<s:iterator value="list_right">
								<tr onclick="select(this);">
									<td>
										<INPUT TYPE="checkbox" NAME="rightcodes"
											value="<s:property value="code"/>">
									</td>
									<td>
										<s:property value="name" />
									</td>
								</tr>
							</s:iterator>
						</table>
					</td>
					<td>
							<s:iterator value="list_right">
								<s:if test="code=='l.p_unit'">
								<table id="unit" class="searchtable">
									<tr>
										<td>

										</td>
										<td>
											<STRONG>统计单位</STRONG>
										</td>
									</tr>
									<s:iterator value="basicUtil.ledger_unitList">
										<tr onclick="select(this);">
											<td>
												<INPUT TYPE="checkbox" NAME="unitcodes"
													value="<s:property value="name"/>">
											</td>
											<td>
												<s:property value="name" />
											</td>
										</tr>
									</s:iterator>
								</s:if>
								</table>
							</s:iterator>
					</td>
				</tr>
				<tr>
					<td>
						<INPUT TYPE="image" SRC="${contextPath}/images/ledger/up.jpg"
							width="20" onclick="javascript:moveup();return false;">
						<INPUT TYPE="image" SRC="${contextPath}/images/ledger/down.jpg"
							width="20" onclick="javascript:movedown();return false;">
					</td>
					<td>
					</td>
				</tr>
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
		</s:form>
	</body>
</html>
