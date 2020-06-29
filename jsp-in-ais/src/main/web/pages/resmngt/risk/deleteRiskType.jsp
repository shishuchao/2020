<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@page import="ais.framework.util.StringUtil"%>
<HTML>
<HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>风险分类管理</TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<script type="text/javascript" src="${contextPath}/scripts/treepanel/TreePanel.js"></script>
<script type='text/javascript'	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' 	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript'	src='${contextPath}/dwr/engine.js'></script>
<Script language=Javascript>
function doClear(){
	window.parent.hidePopWin(false);
}
var node = null;
function RightGO(tree_node){
	if(tree_node.getChecked()){
		node = tree_node;
	}else{
		node = null;
	}
}
var isDelChild = false;
function removeTreeNode(){
	if(node){
		if(node.hasChildNodes()&&!isDelChild){
			alert("存在下级分类，不允许删除！");
			return;
		}
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/resmngt/risk', action:'delete', executeResult:'false' }, 
				{'id':node.id},
				xxx);
		function xxx(rs){
			if(rs['status']=='200'){
				pp_node = window.parent.tree.getNodeById(node.id);
				pp_node.parentNode.removeChild(node);
				pp_node = null;
				p_node = node.parentNode;
				p_node.removeChild(node);
				node = null;
			}else if(rs['status']=='delete error'){
				alert('删除出错！');
			}else if(eval(rs['hasChild'])){
				alert('后台存在下级分类，不允许删除！')
			}
		}
	}
}
</Script>
</HEAD>

<BODY bgcolor="#DEE7FF" topmargin=0 leftmargin=0>

<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
<tr><td align=center>
<s:if test="${empty(riskTypeJson)}">
  	<script type="text/javascript">
		var tree = new TreePanel({
				'root' : ${riskTypeJson}
			});
		tree.addListener('click',RightGO);
		tree.iconPath='${contextPath}/scripts/treepanel/img/';
		tree.showSelectBox = false;
		tree.render();
	</script>
</s:if>
</td></tr>
<tr><td nowrap></td></tr>
<tr><td align=right>
<table border=0 cellspacing=1 cellpadding=1 width=95% height="10">
<tr>
<td width=60%>
<td>
<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="删除" onclick="removeTreeNode()"></div>
</td>
<td width=10 nowrap></td>
<td>
<div id="clear" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/clear.gif" Background="#D2E9FF" Text="完成" onclick="doClear();"></div>
						
</td>
</tr>
</table>
</td></tr>
<tr><td>
</td></tr>
</table>
</BODY>
</HTML>