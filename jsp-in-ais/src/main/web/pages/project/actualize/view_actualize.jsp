<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>实施阶段</title>
       <link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
		
			function ledger(){
			   window.open("<%=request.getContextPath()%>/proledger/custom/createLedgerTabs.action?project_id=${projectStartObject.formId}&isView=true&permission=${viewPermission}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
			}
			
			function ssfa(){
				win = window.open('<%=request.getContextPath()%>/pages/operate/index.jsp?project_id=${projectStartObject.formId}&isView=true&permission=${viewPermission}' ,'act','height=768,width=1024,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,resizable=yes');
				var h = window.screen.height;
				var w = window.screen.width;
				win.moveTo(0,0)   
				win.resizeTo(w,h) 
				if(win && win.open && !win.closed) 
		        win.focus();
			}

			
				
		</script>
	</head>
	<body class="easyui-layout">
		<div region="center">
        	<div id='actualizePanel' class="easyui-tabs" fit="true" style="overflow:visible;">
                 <div id='auditWorkProgramActualize' title='补充性审计文书' 
                            >
                        <iframe id="prepareWorkProgram"
                            src="${contextPath}/workprogram/viewWorkProgramProjectDetail.action?projectid=<s:property value="crudObject.project_id" />&wpd_stagecode=actualize"
                            frameborder="0" width="100%" height="340" scrolling="auto"></iframe>
                </div>
            </div>
         </div>
			<div id="buttonDiv" region="south" style="height:50px;text-align:center;">
				<input class="button" type="button" value="审计实施" onclick="ssfa();"/>
			</div>
	</body>
</html>