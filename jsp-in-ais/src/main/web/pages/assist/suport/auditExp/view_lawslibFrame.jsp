<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script language="javascript">
/*
*  打开或关闭查询面板
*/
function triggerSearchTable(){
	try{
		var isDisplay = childBasefrm.document.getElementById('searchTable').style.display;
		if(isDisplay==''){
			childBasefrm.document.getElementById('searchTable').style.display='none';
		}else{
			childBasefrm.document.getElementById('searchTable').style.display='';
		}
	}catch(e){
		
	}
}
</script>
		<style type="text/css"> 
			#content{
				width: 20%;
			}
		</style>
</head>
    <table class='listtable' style='display:none;'>
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				<div style="display: inline;width:80%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/assist/suport/lawsLib/index.action?mCodeType=sjjy&m_view=view')"/>
				</div>
				<div style="display: inline;width:20%;text-align: right;">
					<a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a>
				</div>
			</td>
		</tr>
	</table>

<div id="container" class='easyui-layout' fit='true' >
  <div id="content" region='west' split='true' title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>类别">
	<iframe name="f_left" width="100%" frameborder="0" height="100%" src="showTreeList.action?mCodeType=sjjy&m_view=true"></iframe>
  </div>
  <div id="sidebar" region='center' title='详细信息 -- <a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a>'>
		<iframe name="childBasefrm" width="100%" frameborder="0" height="100%" src="search.action?mCodeType=sjjy&nodeid=${nodeid}&m_view=view" ></iframe>
  </div>
</div>
</html>