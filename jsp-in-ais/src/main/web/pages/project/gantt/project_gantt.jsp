<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
	<title>项目甘特图</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<style>
		.colorDiv{
			float: right;
			width: 18px;
			height: 18px;
			border-radius: 3px;
			margin-top: 5px;
			margin-right: 3px;
		}
		.colorDesc{
			float: right;
			margin-top: 3px;
			margin-right: 10px;
			/*font-size: 12px;*/
		}
	</style>
	<script>
		$(function () {
			var bodyh = $("body").height();
			$("#mainDiv").css("height", bodyh);
			var centerh = $("body").height() - $("#northDiv").height();
			$("#centerDiv").css("height", centerh);
		})
	</script>
</head>
<body style="margin: 0; padding: 0; overflow: hidden;" class="easyui-layout">
	<div id="mainDiv">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head" style="width: 780px;">
				<s:form name="paramForm">
					<table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead">
								<font color=red>*</font>统计年度
							</td>
							<td class="editTd">
								<select class="easyui-combobox" name="ganttParamInfo.year" id="year" editable="false">
									<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
										<s:if test="${key eq ganttParamInfo.year}">
											<option value="<s:property value="key"/>" selected><s:property value="value"/></option>
										</s:if>
										<s:else>
											<option value="<s:property value="key"/>"><s:property value="value"/></option>
										</s:else>
									</s:iterator>
								</select>
							</td>
							<td class="EditHead">
								<font color=red>*</font>审计单位
							</td>
							<td class="editTd">
								<s:buttonText2 cssClass="noborder" id="tjdw"
											   name="ganttParamInfo.audit_dept_name"
											   hiddenName="ganttParamInfo.audit_dept"
											   hiddenId="audit_dept"
											   doubleOnclick="showSysTree(this,{
								  	url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  	param:{
								  		'p_item':3
								  	},
								  	title:'审计单位选择'
								})"
											   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
											   doubleCssStyle="cursor:pointer;border:0" readonly="true"/>

							</td>
						</tr>
						<tr>
							<td class="EditHead">
								排程状态
							</td>
							<td class="editTd">
								<select class="easyui-combobox" id="status" editable="false" name="ganttParamInfo.status" style="width:150px;" panelHeight="auto">
									<option value="">&nbsp;</option>
									<s:iterator value='#@java.util.LinkedHashMap@{"待启动":"待启动","进行中":"进行中","已完成":"已完成"}'>
										<option value="<s:property value="key"/>"> <s:property value="value"/></option>
									</s:iterator>
								</select>
							</td>
							<td class="EditHead">
								项目名称
							</td>
							<td class="editTd">
								<s:textfield name="ganttParamInfo.searchProName" id="searchProName" cssClass="noborder" maxlength="255"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								提示
							</td>
							<td class="editTd" colspan="3">
								<s:textfield name="ganttParamInfo.searchDesc" id="searchDesc" cssClass="noborder" maxlength="255"/>
							</td>
						</tr>
					</table>
					<input type="hidden" id="ganttParamInfo_ganttScale" name="ganttParamInfo.ganttScale"/>
					<input type="hidden" id="ganttParamInfo_changeView" name="ganttParamInfo.changeView"/>
				</s:form>
			</div>
			<div class="serch_foot">
				<div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="searchrecal()">重置</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#dlgSearch').window('close')">取消</a>
				</div>
			</div>
		</div>

		<div region="north" split="false" id="northDiv">
			<div style="border: 1px solid #dddddd; margin: 1px 5px; background-color: #f6f6f6;">
				<div style="margin: 5px 5px;">
					<div style="text-align: left;">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="query();">查询</a>
<%--						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-view'" onclick="changeView('months');">月视图</a>--%>
						<a href="javascript:void(0);" class="easyui-linkbutton" id="weekBtn" data-options="iconCls:'icon-view'" onclick="changeView('weeks');">周视图</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" id="dayBtn" data-options="iconCls:'icon-view'" onclick="changeView('days');">日视图</a>

						<div class="colorDesc" id="today">今天</div>
						<div class="colorDiv" style="background-color: #f2c311;"></div>
						<div class="colorDesc">逾期/延期时间</div>
						<div class="colorDiv" style="background-color: #e84c3d;"></div>
						<div class="colorDesc">正常执行</div>
						<div class="colorDiv" style="background-color: #59d78e;"></div>
						<div class="colorDesc">计划时间</div>
						<div class="colorDiv" style="background-color: #3598db;"></div>
					</div>
				</div>
			</div>
		</div>
		<div id="centerDiv" region="center" style="overflow: hidden; margin: auto 5px;" border="0">
			<iframe allowtransparency="true" style="z-Index: 1" name="viewGantt" src="" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
		</div>
	</div>

	<script>
		function doSearch(){
			if($('#year').combobox('getValue')==null||$('#year').combobox('getValue')==''){
				top.$.messager.show({
					title:'提示消息',
					msg:"请选择统计年度！",
					timeout:5000,
					showType:'slide'
				});
				return;
			}
			if($('#tjdw').val()==null||$('#tjdw').val()==''){
				top.$.messager.show({
					title:'提示消息',
					msg:"请选择审计单位！",
					timeout:5000,
					showType:'slide'
				});
				return;
			}
			$('#dlgSearch').dialog('close');
			$('#ganttParamInfo_changeView').val('');
			drawGantt();
		}

		function searchrecal() {
			$('#year').combobox('setValue', '');
			$('#tjdw').val('');
			$('#audit_dept').val('');
			$('#status').combobox('setValue', '');
			$('#searchProName').val('');
			$('#searchDesc').val('');
		}

		function query(){
			searchWindShow('dlgSearch', 800, 300);
		}

		function changeView(scale) {
			var curScale = $('#ganttParamInfo_ganttScale').val();
			if (!curScale){
				$('#ganttParamInfo_changeView').val('');
			}else{
				$('#ganttParamInfo_changeView').val('yes');
			}
			if (scale !== curScale){
				if (scale == 'months'){
					$('#today').html('本月');
				}else if (scale == 'weeks'){
					$('#today').html('本周');
					$('#dayBtn').find('.l-btn-left').css('background-color', '');
					$('#weekBtn').find('.l-btn-left').css('background-color', '#9be5fe');
				}else{
					$('#today').html('今天');
					$('#dayBtn').find('.l-btn-left').css('background-color', '#9be5fe');
					$('#weekBtn').find('.l-btn-left').css('background-color', '');
				}

				$('#ganttParamInfo_ganttScale').val(scale);
				drawGantt();
			}
		}

		function drawGantt(){
			document.forms[0].action = "${contextPath}/project/process/getGanttData.action";
			document.forms[0].target = "viewGantt";
			document.forms[0].submit();
		}

		$(function() {
			showWin('dlgSearch');

			//drawGantt();
			changeView("days");
		});
	</script>
</body>
</html>
