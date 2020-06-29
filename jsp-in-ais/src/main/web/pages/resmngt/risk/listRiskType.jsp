<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>风险分类管理</TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${contextPath}/scripts/treepanel/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/scripts/treepanel/TreePanel.js"></script>
<script type='text/javascript'
	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript'
	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<Script language=Javascript>
function doClear(){
	window.parent.location.reload();
	window.parent.hidePopWin(false);
}
selectnode = null;
function RightGO(tree_node){
	if(tree_node.checked!=1&&tree_node.id!='root'){
		tree_node.setCheck(1);
		for(var k in tree.nodeHash){
			var node = tree.nodeHash[k];
			if(node.id!=tree_node.id){
				node.setCheck(0);
			}
		}
		selectnode = tree_node;
		appendtd.innerHTML='<div id="selectAdd" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/clear.gif" Background="#D2E9FF" Text="添加子项" onclick="appendTreeNode()"></div>';
	}else{
		tree_node.setCheck(0);
		selectnode = null;
		appendtd.innerHTML='<div id="selectAdd" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/clear.gif" Background="#D2E9FF" Text="添加" onclick="appendTreeNode()"></div>';
	}
	
}
function appendTreeNode(){
	if(typeName.value==''){
		alert("请填写要添加的分类！");
		return false;
	}
	var parentId = "";
	if(selectnode){
		parentId=selectnode.id;
	}
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/resmngt/riskType', action:'saveType', executeResult:'false' }, 
		{'parentId':parentId,'riskType.typeName':typeName.value},
		xxx);
	function xxx(rs){
		if(rs['status']=='200'){
			alert('保存成功！');
			 window.location.reload();
		}else{
			alert('保存失败！');
		}
	} 
}

var isDelChild = false;
function removeTreeNode(){
	if(selectnode!=null){
		if(selectnode.hasChildNodes()&&!isDelChild){
			alert("存在下级分类，不允许删除！");
			return;
		}
		if(selectnode.id=='root'){
			alert("根节点，不允许删除！");
			return;
		}
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/resmngt/riskType', action:'deleteType', executeResult:'false' }, 
				{'id':selectnode.id},
				xxx);
		function xxx(rs){
			if(rs['status']=='200'){
				alert('删除成功！');
				 window.location.reload();
			}else if(rs['status']=='delete error'){
				alert('删除出错！');
			}else if(eval(rs['hasChild'])){
				alert('后台存在下级分类，不允许删除！')
			}else if(rs['status']=='300'){
				alert('该分类下已经上传报告，不允许删除！');
			}
		}
	}
}
<s:if
test="${!empty(riskTypeJson)}">
TreeNode.prototype.onCheck=function(){
	if(this.checked!==false){
		RightGO(this);
	}
			
};
var tree = new TreePanel({
	'root' : ${riskTypeJson}
});
function drawTree(){
	tree.container = document.getElementById('treeTd');
	tree.addListener('click',RightGO);
	tree.iconPath='${contextPath}/scripts/treepanel/img/';
	tree.showSelectBox = true;
	tree.checkChild=false;
	tree.render();
	tree.getRootNode()['html-element']['checkbox'].style.display='none';
}
</s:if>
<s:else>function drawTree(){}</s:else>

</Script>
</HEAD>

<BODY bgcolor="#DEE7FF" topmargin=8 leftmargin=8 rightmargin="8" onload="drawTree()">
<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
	<tr>
		<td align=left bgcolor="#FFFFFF" id="treeTd" height="300" valign="top"></td>
	</tr>
	<tr>
		<td nowrap></td>
	</tr>
	<tr>
		<td align=right>
		<table border=0 cellspacing=1 cellpadding=1 width=95% height="10">
			<tr>
				<td width=60%>
				<td>
					<s:textfield name="typeName" id="typeName" size="20"  title="分类名称" maxlength="25"/>
				</td>
				<td width=10 nowrap></td>
				<td id="appendtd">
				<div id="selectAdd" class="imgbtn"
					Imgsrc="<%=request.getContextPath()%>/resources/images/clear.gif"
					Background="#D2E9FF" Text="添加" onclick="appendTreeNode()"></div>
				</td>
				<td width=10 nowrap></td>
				<td>
				<div id="selectDel" class="imgbtn"
					Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif"
					Background="#D2E9FF" Text="删除" onclick="removeTreeNode()"></div>
				</td>
				<td width=10 nowrap></td>
				<td>
				<div id="clear" class="imgbtn"
					Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif"
					Background="#D2E9FF" Text="完成" onclick="doClear();"></div>

				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
</BODY>
</HTML>