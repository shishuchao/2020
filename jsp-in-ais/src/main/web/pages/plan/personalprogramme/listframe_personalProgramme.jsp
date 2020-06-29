<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>个人计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<s:head theme="ajax" />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		
		<script type="text/javascript">
		

			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay1 = window.frames['basefrm1'].document.getElementById('searchTable').style.display;
				if(isDisplay1==''){
					window.frames['basefrm1'].document.getElementById('searchTable').style.display='none';
				}else{
					window.frames['basefrm1'].document.getElementById('searchTable').style.display='';
				}

				var isDisplay2 = window.frames['basefrm2'].document.getElementById('searchTable').style.display;
				if(isDisplay2==''){
					window.frames['basefrm2'].document.getElementById('searchTable').style.display='none';
				}else{
					window.frames['basefrm2'].document.getElementById('searchTable').style.display='';
				}
			}
			
			
			function doAutoHeight1() {
				if(document.body.clientHeight>165)
			    document.all.basefrm1.style.height = document.body.clientHeight-110;
		    }

			function doAutoHeight2() {
				if(document.body.clientHeight>165)
			    document.all.basefrm2.style.height = document.body.clientHeight-110;
		    }
		</script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<tr class="listtablehead">
				<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
					<div style="display: inline;width:80%;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/plan/personalprogramme/listmain.action')"/>
					</div>
				</td>
			</tr>
		</table>


		<s:tabbedPanel id='test' theme='ajax'>
			<s:div id='personalProgramme' label='计划信息' theme='ajax'
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="basefrm1"
					src="${contextPath}/plan/personalprogramme/list.action" frameborder="0"
					width="100%" height="550" onload="doAutoHeight1( )"></iframe>
			</s:div>


			<s:div id='workSummarize' label='工作总结' theme='ajax'
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="basefrm2"
					src="${contextPath}/plan/worksummarize/list.action"
					frameborder="0" width="100%" height="550" onload="doAutoHeight2()"></iframe>
			</s:div>
		</s:tabbedPanel>
	</body>
</html>