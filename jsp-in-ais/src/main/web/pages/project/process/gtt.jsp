<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
	<title>Demo</title>
	<link href="http://cdnjs.cloudflare.com/ajax/libs/prettify/r298/prettify.min.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/gtt/css/style.css" type="text/css" rel="stylesheet">
	<link href="${contextPath}/gtt/css/impromptu/impromptu.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>

	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<script src="${contextPath}/gtt/js/jquery.min.js"></script>
	<script src="${contextPath}/gtt/js/jquery.fn.gantt.js"></script>

    <s:head theme="ajax" />

	<style type="text/css">
		body {
			font-family: Helvetica, Arial, sans-serif;
			font-size: 13px;
			padding: 0 0 50px 0;
		}

		h1 {
			margin: 40px 0 20px 0;
		}

		h2 {
			font-size: 1.5em;
			padding-bottom: 3px;
			border-bottom: 1px solid #DDD;
			margin-top: 50px;
			margin-bottom: 25px;
		}

		table td:first-child {
			width: 150px;
		}

		/* Bootstrap 3.x re-reset */
		.fn-gantt *,
		.fn-gantt *:after,
		.fn-gantt *:before {
			-webkit-box-sizing: content-box;
			-moz-box-sizing: content-box;
			box-sizing: content-box;
		}
	</style>
</head>
<body style="margin: 0;padding: 0;" class="easyui-layout">

<div style="height:100%;width:100%;overflow-x:scroll;overflow-y:scroll">
	<div style="padding: 10px; background: #FAFAFA; border: 1px solid #ccc;">项目计划信息</div>
	<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tab1">
		<tr>
			<td class="EditHead" style="width: 15%">
				项目名称
			</td>
			<td class="editTd" style="width: 35%">
					<input type="text" style="border:none; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'  value="${projectName}"   editable="false"/>

			</td>
			<td class="EditHead" style="width: 15%" nowrap="nowrap">
				项目类别
			</td>
			<td class="editTd" style="width: 35%">
					<input type="text" style="border:none; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'  value="${proName}"   editable="false"/>

			</td>
		</tr>
		<tr>
			<td class="EditHead">
				审计单位
			</td>
			<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'  value="${objName}"   editable="false"/>

			</td>
			<td class="EditHead">
				被审计单位
			</td>
			<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'  value="${depName}"   editable="false"/>

			</td>
		</tr>
	</table>

    <div style="padding: 10px; background: #FAFAFA; border: 1px solid #ccc;">甘特图</div>

    <div class="gantt"></div>

	<div style="padding: 10px;  border: 1px solid #ccc;">项目准备阶段时间信息</div>

	<form style="background: #FAFAFA;" id="searchForm" action="sjwhByTime.action" name="searchForm" namespace="/sjwh">
		<input type="hidden" name="projectId" value="${plan_form_id}" reload="false"/>
		<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tab2">
			<tr>
				<td class="editTd">阶段</td>
				<td class="editTd">计划开始时间</td>
				<td class="editTd">计划结束时间</td>
				<td class="editTd">实际开始时间</td>
				<td class="editTd">实际结束时间</td>
			</tr>
			<tr class="datagrid-row">
				<td class="editTd">准备阶段</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'  value="${readyPlanStartTime}"   name="readyPlanStartTime"  title="单击选择日期"  editable="false"/>

				</td>
				<td class="editTd">
					<input type="text" style="border:none ; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'   value="${readyPlanEndTime}"   name="readyPlanEndTime"  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'   value="${readyActualStartTime}"   name="readyActualStartTime"  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'  value="${readyActualEndTime}"   name="readyActualEndTime"  title="单击选择日期"  editable="false"/>
				</td>
			</tr>
			<tr>
				<td class="editTd">实施阶段</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'  value="${applyPlanStartTime}"   name="applyPlanStartTime"  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'  value="${applyPlanEndTime}"   name="applyPlanEndTime"  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'  value="${applyActualStartTime}"   name="applyActualStartTime"  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'  value="${applyActualEndTime}"   name="applyActualEndTime"  title="单击选择日期"  editable="false"/>
				</td>
			</tr>
			<tr>
				<td class="editTd">报告编制</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'   value="${reportPlanStartTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'   value="${reportPlanEndTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'   value="${reportActualStartTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly"  onfocus='this.blur();'  value="${reportActualEndTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
			</tr>
			<tr>
				<td class="editTd">征求意见</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'  value="${advicePlanStartTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly"    onfocus='this.blur();' value="${advicePlanEndTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'  value="${adviceActualStartTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'   value="${adviceActualEndTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
			</tr>
			<tr>
				<td class="editTd">报批</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'   value="${approvalPlanStartTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly"  onfocus='this.blur();'  value="${approvalPlanEndTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;" readonly="readonly" onfocus='this.blur();'   value="${approvalActualStartTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
				<td class="editTd">
					<input type="text" style="border:none; background: #FAFAFA;"  readonly="readonly" onfocus='this.blur();'  value="${approvalActualEndTime}"   name=""  title="单击选择日期"  editable="false"/>
				</td>
			</tr>
		</table>

	</form>


</div>


<script>
    $(function () {

        "use strict";

        $(".gantt").gantt({
            source: [
                {
                    name: "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp1",
                    desc: "准备阶段计划工作",
                    values: [{
                        from: "${rePlanstartTime}",
                        to: "${rePlanendTime}",
                        label: "准备阶段计划工作",
                        customClass: "ganttGreen"
                    }]
                },
                {
                    desc: "准备阶段实际工作",
                    values: [{
                        from: "${reActstartTime}",
                        to: "${reActendTime}",
                        label: "准备阶段实际工作",
                        customClass: "ganttRed"
                    }]
                },
                {
                    name: "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp2",
                    desc: "实施阶段计划工作",
                    values: [{
                        from: "${apstartTime}",
                        to: "${apendTime}",
                        label: "实施阶段计划工作",
                        customClass: "ganttGreen"
                    }]
                },
                {
                    name: " ",
                    desc: "实施阶段实际工作",
                    values: [{
                        from: "${aastartTime}",
                        to: "${aaendTime}",
                        label: "实施阶段实际工作",
                        customClass: "ganttRed"
                    }]
                },
                {
                    name: "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp3",
                    desc: "报告阶段计划工作",
                    values: [{
                        from: "${rpStartTime}",
                        to: "${rpendTime}",
                        label: "报告阶段计划工作",
                        customClass: "ganttGreen"
                    }]
                },
                {
                    desc: "报告阶段实际工作",
                    values: [{
                        from: "${raStartTime}",
                        to: "${raendTime}",
                        label: "报告阶段实际工作",
                        customClass: "ganttRed"
                    }]
                },
                {
                    name: "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp4",
                    desc: "征求意见计划工作",
                    values: [{
                        from: "${adpstartTime}",
                        to: "${adpendTime}",
                        label: "征求意见计划工作",
                        customClass: "ganttGreen"
                    }]
                },
                {
                    desc: "征求意见实际工作",
                    values: [{
                        from: "${adaStartTime}",
                        to: "${adaendTime}",
                        label: "征求意见实际工作",
                        customClass: "ganttRed"
                    }]
                },
                {
                    name: "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp5",
                    desc: "报批计划工作",
                    values: [{
                        from: "${appStartTime}",
                        to: "${appendTime}",
                        label: "报批计划工作",
                        customClass: "ganttGreen"
                    }]
                },
                {
                    desc: "报批实际工作",
                    values: [{
                        from: "${apaStartTime}",
                        to: "${apaendTime}",
                        label: "报批实际工作",
                        customClass: "ganttRed"
                    }]
                }
            ],
            navigate: "scroll",
            scale: "days",
            maxScale: "months",
            minScale: "days",
            itemsPerPage: 10,
            useCookie: true,
            onRender: function () {
                if (window.console && typeof console.log === "function") {
                    console.log("chart rendered");
                }
            }
        });
        //
        // $(".gantt").popover({ <table style="background-color: #f6f6f6;"><tr><td>编号</td><td>工作名称</td><td>开始时间</td><td>结束时间</td></tr></table>
        //     selector: ".bar",
        //     title: "I'm a popover",
        //     content: "And I'm tde content of said popover.",
        //     trigger: "hover"
        // });


    });
</script>
</body>
</html>
