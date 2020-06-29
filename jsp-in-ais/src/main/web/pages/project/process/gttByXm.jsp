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

		table th:first-child {
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
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">

<div>

    <div style="padding: 10px; background: #FAFAFA; border: 1px solid #ccc;">项目甘特图</div>

    <div class="gantt"></div>



</div>


<script>
    $(function () {

        "use strict";

        $(".gantt").gantt({
            source:${data},
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

    });

    function jumpXm(id,projectName,proName,objName,depName) {

        var url = "${contextPath}/sjwh/gtt.action?plan_form_id="+id+"&projectName="+encodeURI(encodeURI(projectName))+"&proName="+encodeURI(encodeURI(proName))+"&objName="+encodeURI(encodeURI(objName))+"&depName="+encodeURI(encodeURI(depName));

        aud$openNewTab('查看甘特图',url);

    }
</script>
</body>
</html>
