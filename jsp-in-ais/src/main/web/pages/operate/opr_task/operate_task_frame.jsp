<!DOCTYPE HTML>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<title>实施方案</title>
	<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/extjs/resources/css/ext-all.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/css/ux-all.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/css/common.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/css/color-blue.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/jquery.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/ext-jquery-adapter.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/ext-all.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/StatusBar.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/ColumnNodeUI.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTabPanel.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTab.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/locale/ext-lang-zh_CN.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/js/main.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/js/ui.js"></script>
		<link rel="stylesheet" type="text/css"
			href="/ais/scripts/portal/tree/column-tree.css" />
		<link
			href="${pageContext.request.contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<!-- 引入dwr的js文件 -->
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>

		<style type="text/css">
		textarea { /** auto break line */
			word-wrap: break-word;
			word-break: break-all;
		}
		
		.EditHead {
			background-image: url(../../images/ais/bg1a.jpg);
			background-repeat: repeat;
			height: 26px;
			text-align: left;
			vertical-align: middle;
			font-size: 12px;
			font-family: "simsun";
			font-weight: bold;
			color: #007FFF;
			background-repeat: repeat;
		}
		
		.ListTable {
			background-color: #7CA4E9;
			font-size: 12px;
			border: 0px;
			width: 97%;
			margin: 0px;
		}
		
		.ListTable2 {
			font-size: 12px;
			border: 0px;
			width: 97%;
			margin: 0px;
		}
		
		.ListTableTr1 {
			BACKGROUND-COLOR: #F5F5F5;
			height: 22;
			vertical-align: middle;;
		}
		
		.ListTableTr2 {
			BACKGROUND-COLOR: #ffffff;
			height: 20;
			padding-left: 5px;
		}
		
		.ListTableTr22 {
			BACKGROUND-COLOR: #ffffff;
			width: 35%;
			height: 20;
			padding-left: 5px;
		}
		
		.ListTableTr3 {
			BACKGROUND-COLOR: #ffffff;
			height: 20;
			padding-left: 5px;
		}
		
		.titletable1 {
			background-color: #EEF7FF;
			height: 21;
		}
		</style>
	<script type="text/javascript">	
	//---ext----定义开始-----
	Ext.onReady(function(){
		var t=new Usp.Tab({
	  		tabConfig:{id:'common-data-dataframe-tab'}
	  	});
	  	//在左侧打开了两个页签，并且默认设置总体方案是当前页签
	  	t.openTab({
		  	id:'common-data-dataframe-tab2',//id
		  	title:'审计事项<p style="color: red;display: inline;">(已分配的审计事项还有${taskSum}个事项未完成)</p>',
		  	height:Ext.getBody().getHeight()-panleHeight,
		  	autoHeight:false,
		  	closable:false,
		  	autoScroll:false, 
		  	actionUrl:'${pageContext.request.contextPath}/operate/task/project/showContentTypeView.action?coll=0&taskTemplateId=-1&taskId=-1&taskPid=-1&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&view=view&project_id=<%=request.getParameter("project_id")%>&interaction=${interaction}'
	  	});
	  	
		var workPanel=new Usp.WorkPanel({
						hasLeft:false,
						mainConfig:{id:'common-data-dataframe-main'}
						});
		workPanel.main.add(t.getTabPanel());
	    workPanel.wp.render('common-data-dataframe');
	    
	   	t.getTabPanel().setActiveTab('common-data-dataframe-tab2');//默认当前页签
	  });
	 //---ext----定义结束----
	 
	</script>
	</head>
	<body style='overflow:hidden;' >
	<div id='common-data-dataframe' style='overflow:hidden;' /> 
	</body>
</html>