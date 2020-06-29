<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>基础参数</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script> 
		<style type="text/css">
			textarea {
				width: 90%;
				height: 50px;
			}
		</style>
		<SCRIPT type="text/javascript">
			function addWin(_paramId){
				var sheetName = encodeURI(encodeURI(parent.document.getElementById('sheetName').value));
				var src = '${contextPath }/ccrTemplate/paramDetailEditIndex.action?paramId='+_paramId +'&sheetName='+sheetName;
				window.showModalDialog(src,window,"location:No;status:No;help:No;dialogWidth:400px;dialogHeight:300px;scroll:No;");    
			}
			
			function delVal(){
				var _param = document.getElementById('paramId').value;
				var cbxs = document.getElementsByName("ids");
					var cbx_count = 0;
					var cbx_no = -1;
					var ids='';
					for ( var i = 0; i < cbxs.length; i++) {
						if (cbxs[i].checked) {
							cbx_count++;
							cbx_no = i;
								ids += '@' + cbxs[i].value;
						}
					}
				if (cbx_no == -1) {
					alert("没有选择要删除的信息!");
					return false;
				}
				window.location = '${contextPath}/ccrTemplate/delDetail.action?id=' + ids + '&paramId=' + _param;
			}
		</SCRIPT>
</head>
<body>
	<center>
	<s:hidden name="paramId" id="paramId"></s:hidden>
	<display:table requestURI="detailList.action" name="detailList" 
					id="row" pagesize="${baseHelper.pageSize}" partialList="true"
					size="${baseHelper.totalRows}" class="its">
			<display:column title="选择" style="text-align:center;width:30px" headerClass="center">
						<input type="checkbox" name="ids" value="${row.detailPk}">
			</display:column>
			<display:column property="quoteRow" title="引用行" sortable="false" sortName="false" headerClass="center" style="text-align:center" />
			<display:column property="consecutive" title="连续" sortable="false" sortName="false" headerClass="center" style="text-align:center" />
			<display:column property="sumRow" title="结果（或插入开始）行" sortable="false" sortName="false" headerClass="center" style="text-align:center" />
			<display:column title="区域" sortable="false" sortName="false" headerClass="center" style="text-align:center" >
				<s:if test="${row.sumType == 0}">
				${row.sheetName}!${row.startCol}:${row.endCol}
				</s:if>
			</display:column>
			<display:column property="sumCol" title="单格汇总" sortable="false" sortName="false" headerClass="center" style="text-align:center" />
		</display:table>
		<br/>
			<div align="right">
			<s:button value="增加" onclick="addWin('${paramId}')"/>
			&nbsp;&nbsp;
			<s:button value="删除" onclick="delVal(); "></s:button>
			&nbsp;&nbsp;
				<s:button value="全选" onclick="checkall('ids')"/>
						&nbsp;&nbsp;
				<s:button value="反选" onclick="checkback('ids')"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		</center>
</body>
</html>