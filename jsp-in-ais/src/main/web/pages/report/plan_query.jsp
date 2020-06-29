<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title></title>

		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script language="javascript">
		
			function CheckSubmit(){

				document.forms[0].action = "${contextPath}/report/jasper!planResult.action";
				document.forms[0].target = "showreport";
				document.forms[0].submit();
			}
			 var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     $(document).ready(function(){
		    	 CheckSubmit();
		     });
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head" style="width: 780px;">
			<s:form name="form">
				<table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							<font color=red>*</font>统计单位
						</td>
						<td class="editTd">
							<s:buttonText2 cssClass="noborder" id="tjdw"
										   name="tjdw"
										   hiddenName="tjdwCode"
										   hiddenId="tjdwCode"
										   doubleOnclick="showSysTree(this,{
								  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
								  title:'组织机构选择'
								})"
										   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
										   doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
						</td>


						<td class="EditHead">
							<font color=red>*</font>统计年度
						</td>
						<td class="editTd">
							<select class="easyui-combobox" name="year" id="year"  editable="false">
								<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
									<s:if test="${key eq year}">
										<option value="<s:property value="key"/>" selected><s:property value="value"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
						<td class="EditHead">
							输出格式
						</td>
						<td class="editTd">
							<select name="reportType" class="easyui-combobox" editable="false">
								<option value="html">HTML</option>
								<option value="xls">EXCEL</option>
							</select>
						</td>
							<%--<td class="EditHead" nowrap>--%>
							<%--新窗口显示--%>
							<%--</td>--%>
							<%--<td class="editTd">--%>
							<%--<input type="checkbox" name="ismax">--%>
							<%--</td>--%>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
			<div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
			</div>
		</div>
	</div>
	<div region="north" style="height:5%;overflow:hidden;" border="false" split="false">
		<div>
			<table id="toolbar"></table>
		</div>
	</div>
	<div region="center" style="overflow: hidden;" border="false">
		<iframe allowtransparency="true" style="z-Index: 1" name="showreport" src="<%=request.getContextPath()%>/blank.jsp" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
	</div>

	<script type="text/javascript">
		function doSearch(){
			if($('#tjdw').val()==null||$('#tjdw').val()==''){
				top.$.messager.show({
					title:'提示消息',
					msg:"请选择统计单位！",
					timeout:5000,
					showType:'slide'
				});
				return;
			}
			if($('#year').combobox('getValue')==null||$('#year').combobox('getValue')==''){
				top.$.messager.show({
					title:'提示消息',
					msg:"请选择统计年度！",
					timeout:5000,
					showType:'slide'
				});
				return;
			}
			$('#dlgSearch').dialog('close');
			CheckSubmit();
		}
		$(function () {
			$('#toolbar').datagrid({
				toolbar:[
					{id:'search',text:'查询',iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch',800,300);
						}
					}
				]
			});
			showWin('dlgSearch');
		});
	</script>
	</body>
</html>
