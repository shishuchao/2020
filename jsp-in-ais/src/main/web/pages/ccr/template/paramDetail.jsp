<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head>
		<title>基础参数设置</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<style type="text/css">
			textarea {
				width: 90%;
				height: 50px;
			}
		</style>
		<SCRIPT type="text/javascript">
		
				function categoryChange(){
				var su = document.getElementsByName('detail.sumType');
				var suvalue;
				for(i=0;i<su.length;i++){
					if(su[i].checked)
						suvalue = su[i].value;
				}
				if(suvalue == 0){
					document.getElementById('qrow').style.display="none";
					document.getElementById('cst').style.display="none";
					document.getElementById('srow').style.display="none";
					document.getElementById('ranges').style.display="";
					document.getElementById('sicol').style.display="none";
					
				}
				if(suvalue == 1){
					document.getElementById('qrow').style.display="";
					document.getElementById('cst').style.display="";
					document.getElementById('srow').style.display="";
					document.getElementById('ranges').style.display="none";
					document.getElementById('sicol').style.display="none";
					
				}
				if(suvalue == 2){
					document.getElementById('qrow').style.display="none";
					document.getElementById('cst').style.display="none";
					document.getElementById('srow').style.display="none";
					document.getElementById('ranges').style.display="none";
					document.getElementById('sicol').style.display="";
					
				}
			}
		
		
			function saveParam(){
				var su = document.getElementsByName('detail.sumType');
				var suvalue;
				for(i=0;i<su.length;i++){
					if(su[i].checked)
						suvalue = su[i].value;
				}
				if(suvalue == 0){
					var _startCol = document.getElementById('startCol').value;
					var _endCol = document.getElementById('endCol').value;
					if(_startCol == '' || _endCol == ''){
						alert('区域定义错误，请检查区域左上角及有下角是否填写！');
						return false;
					}
				}
				if(suvalue == 2){
					var _sumCol = document.getElementById('sumCol').value;
					if(_sumCol == ''){
						alert('要汇总的单元格不能为空，请填写后保存！');
						return false;
					}
				}
				
				if(suvalue == 1){
					var _qr = document.getElementById('quoteRow').value;
					var _sr = document.getElementById('sumRowNum').value;
					if(_qr == 0){
						alert('汇总引用行不能为0或空！请填写合理的行号');
						return false;
					}
					if(_sr == 0){
						alert('结果行不能为0或者空！请填写合理的行号');
						return false;
					}
				}
				
				document.forms[0].submit();
			}
			
		</SCRIPT>
</head>
<body onload="categoryChange(); ">
	<s:form action="paramDetailSave.action" namespace="/ccrTemplate" name="editForm">
	<s:hidden name="detail.paramId"/>
	<s:hidden name="detail.sheetName"/>
	<s:hidden name="detail.sheetIndex"/>
	<s:hidden name="detail.templateId"/>
	<s:hidden name="detail.detailPk"></s:hidden>
		<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 align="right">
						汇总类型
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="70%" align="left">
							<s:radio list="#@java.util.LinkedHashMap@{'0':'区域汇总','1':'插入引用及汇总','2':'单格汇总'}" value="${detail.sumType }" name="detail.sumType" onclick="categoryChange(); "></s:radio>
					</TD>
				</TR>
				<tr id="qrow">
					<TD class=ListTableTr1 align="right">
						汇总引用行
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="70%" align="left">
							<s:textfield name="detail.quoteRow" id="quoteRow" cssStyle="width:100%"></s:textfield>
					</TD>
				</tr>
				<tr id="cst">
					<TD class=ListTableTr1 align="right">
						连续（）行
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="70%" align="left">
							<s:textfield name="detail.consecutive" id="consecutive" cssStyle="width:100%"></s:textfield>
					</TD>
				</tr>
				<tr id="srow">
					<TD class=ListTableTr1 align="right">
						结果（或插入引用开始）行
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="70%" align="left">
							<s:textfield name="detail.sumRow" id="sumRowNum" cssStyle="width:100%"></s:textfield>
					</TD>
				</tr>
				<tr id="ranges">
					<TD class=ListTableTr1 align="right">区域:<font color="red">*</font></td>
					<TD class=ListTableTr2 width="70%" align="left">
						左上角<s:textfield id="startCol" name="detail.startCol" maxLength="20" cssStyle="width:80"/>
						右下角<s:textfield id="endCol" name="detail.endCol" maxLength="20" cssStyle="width:80"/>
					</TD>
				</tr>
				<tr id="sicol">
					<TD class=ListTableTr1 align="right">单格:<font color="red">*</font></td>
					<TD class=ListTableTr2 width="70%" align="left">
						<s:textfield id="sumCol" name="detail.sumCol" maxLength="20" cssStyle="width:150"/>
					</TD> 
				</tr>
			</TABLE>
			<div align="right">
				<s:button value="保存" onclick="saveParam(); "></s:button>&nbsp;&nbsp;
&nbsp;&nbsp;			</div> 
			
		</s:form>
</body>
</html>