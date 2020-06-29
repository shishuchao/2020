<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/ais.css">
		<script type="text/javascript" src="${contextPath}/scripts/ledger.js"></script>
		<title>台账分析</title>
		
		<script type="text/javascript"> 　
			function selectValue(){
				var leftcodes= document.getElementsByName("leftcodes");
				var rightcodes= document.getElementsByName("rightcodes");
				var left='';
				var right='';
				var flog=false;
				for(i=0;i<leftcodes.length;i++){
					if(leftcodes[i].checked){
						flog=true;
						left+=leftcodes[i].value+',';
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
						right+=rightcodes[i].value+',';
					}
				}
				if(!flog1){
					alert("请选择统计字段！");
					return false;
				}
				document.getElementsByName("ledgerAnalyse.leftcodes")[0].value=left.substring(0,left.length-1);
				document.getElementsByName("ledgerAnalyse.rightcodes")[0].value=right.substring(0,right.length-1);
			}
	
			function saveForm(){
				 var name=document.getElementsByName("ledgerAnalyse.name")[0].value;
				 var leftcodes=document.getElementsByName("ledgerAnalyse.leftcodes")[0].value;
				 var rightcodes=document.getElementsByName("ledgerAnalyse.rightcodes")[0].value;
				 if(name==null||name==''){
	                alert("模型名称不能为空!");
	                return false;
				 }
				 if(leftcodes==null||leftcodes==''){
		                alert("分类字段不能为空!");
		                return false;
					 }
				 if(rightcodes==null||rightcodes==''){
		                alert("统计字段不能为空!");
		                return false;
					 }
				 myForm.submit();
			}
			function backList(){
				window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseParent/analyseList.action?fid=${fid}&poName=${poName}";
				
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
	
	<body onload="">
		<s:form name="myForm" namespace="/ledger/ledgerAnalyseParent" action="saveAnalyseTemplate">
			<table align="left" class="searchtable">
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
			</table>
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr>
					<td class="ListTableTr11">
						<font color="red">*</font>模型名称:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="ledgerAnalyse.name" cssStyle="width:90%"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color="red">*</font>分类字段:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="ledgerAnalyse.leftcodes" cssStyle="width:90%"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color="red">*</font>统计字段:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="ledgerAnalyse.rightcodes" cssStyle="width:90%"/>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" class="ListTableTr22">
						<p align="center">
						    <s:button value="选择" onclick="selectValue()"></s:button>&nbsp;&nbsp;
							<s:button value="保存" onclick="saveForm()"></s:button>&nbsp;&nbsp;
							<s:button value="返回" onclick="backList()"></s:button>&nbsp;&nbsp;
						</p>
					</td>
				</tr>
			</table>
			
			<input type="hidden" name="fid" value="${fid}">
			<input type="hidden" name="id" value="${id}">
			<input type="hidden" name="poName" value="${poName}">
			<input type="hidden" name="ledgerAnalyse.fid" value="${fid}">
			<s:hidden name="ledgerAnalyse.id" />
		</s:form>
	</body>
</html>
