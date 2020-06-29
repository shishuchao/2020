<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	<script language="javascript">
	function myCheck(){
		if(!frmCheck(document.forms[0],"m_table")) return false;
		if(!isPlusInteger($_name("codeHead.level").value)){alert("级别 为数字!");return false;}
		if(comBig($_name('codeHead.level').value,1)){alert('级别长度只能为一位!');return false;}
		if(comBig($_name('codeHead.name').value,60)){alert('名称长度过长!');return false;}
		if(comBig($_name('codeHead.code').value,10)){alert('类别码长度过长!');return false;}
		if(comBig($_name('codeHead.note').value,100)){alert('注释长度过长!');return false;}
		if(!isPlusInteger($_name("codeHead.code").value)){alert("类别码 为数字!");return false;}
		return true;
	}
	function gback(){
		window.location.href='list2.action?codeHead.pid=${codeHead.pid}';
	}
	function $_name(name){return document.getElementsByName(name)[0]}
	function isPlusInteger(str) {
		return (new RegExp(/^([+]?)(\d+)$/).test(str));
	}
	String.prototype.gblen = function() {var len = 0;for (var i=0; i<this.length; i++){if(this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {len+= 2;} else {len ++;}}return len;}
	function comBig(m,n){if(m.gblen()>n)return true;return false;}
</script>
	<link href="<%=request.getContextPath()%>/css/blue/ufaud.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/styles/main/ais.css"
		rel="stylesheet" type="text/css">

	<link href="<%=request.getContextPath()%>/displaytag/maven-base.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/maven-theme.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/site.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/screen.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/print.css"
		rel="stylesheet" type="text/css">
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
	</head>
	<body>
		<s:form id="myform" action="saveType" onsubmit="return myCheck();" theme="simple">
			<s:token/>
			<table id="m_table" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" style="width:96%;" class="ListTable">
				<tr class="titletable1">
					<td>
						类别码<font color="red">*</font>
					</td>
					<td>
					<s:if test="${not empty (codeHead.id) or folder}">
						<s:textfield name="codeHead.code" disabled="true"/>
						<s:hidden name="codeHead.code"/>
					</s:if><s:else>
						<s:textfield name="codeHead.code"/>
					</s:else>
					</td>
				</tr>
				<tr class="titletable1">
					<td>
						名称<font color="red">*</font>
					</td>
					<td>
						<s:textfield name="codeHead.name" />
					</td>
				</tr>
				<tr class="titletable1">
					<td>
						级别<font color="red">*</font>
					</td>
					<td>
					<s:if test="${ folder}">
						<s:hidden name="codeHead.level"/>
						<s:textfield name="codeHead.level" disabled="true"/>
					</s:if><s:else>
						<s:textfield name="codeHead.level"/>
					</s:else>
					</td>
				</tr>
				<tr class="titletable1">
					<td>
						注释
					</td>
					<td>
						<s:textfield name="codeHead.note" />
					</td>
					</tr>
					
				<s:if test="${user.floginname=='admin'}">
				
				<tr class="titletable1">
					<td>
						属性
					</td>
					<td>
						<s:select list="#@java.util.LinkedHashMap@{'C':'客户','S':'系统'}" name="codeHead.type" emptyOption="true"></s:select>
					</td>
					</tr>
				</s:if>
				<s:else>
						<s:if test="${empty (codeHead.type)}">
							<s:hidden name="codeHead.type" value="C"/>
						</s:if><s:else>
							<s:hidden name="codeHead.type"/>
						</s:else>
				</s:else>
			</table>

			<s:hidden name="codeHead.id" />
			<s:hidden name="codeHead.pid" />
			
			<table style="width: 97%; border: 0">
				<tr>
					<td>
						<span style="float: right;"> <input type="submit"
								value="保存" align="right"> <input type="button"
								name="add" value="返回" onclick="gback()"> </span>
					</td>
				</tr>
			</table>
		</s:form>
		
	</body>
</html>
