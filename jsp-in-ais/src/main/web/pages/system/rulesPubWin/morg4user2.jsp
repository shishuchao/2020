<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<title>组织机构设置</title>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
		<script language="Javascript">
function RightGo(id,name)
{
<s:url id="url"    action="uSystemAction"  method="getUserList" namespace="/system"/>
var url='<s:text name="%{url}"/>';
if(url.indexOf('?')!=-1)
url=url+'&amp;';
else
url=url+'?';
  parent.main.location.href=url+'p_deptid='+id+'&amp;p_deptname='+encodeURIComponent(name);
}
function changeVg(){
//parent.main.location.href='';
<s:url id="vgurl"    action="uSystemAction"  method="getVgList4user" namespace="/system"/>
window.location.href='<s:text name="%{vgurl}"/>';
}
</script>
<script type="text/javascript">
m_id='${orgId}';
m_name='${orgName}';
Ext.onReady(function(){
	 var Tree = Ext.tree;
        var root=new Tree.TreeNode({
               id:m_id,
               text:m_name,
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
        
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                //是否显示跟节点 rootVisible:false,
                 containerScroll: true});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
         treePanel.on('click',function(node,event){
         if(node.attributes.text==''){
         	alert("没有要选择的对象!");
         	return;
         }
      	RightGo(node.attributes.id,node.attributes.text);
      });
      });
</script>
	</head>
	<body>
	<!-- 
	 <input type="radio" name="rgname" checked="checked"/>组织机构&nbsp;&nbsp;<input type="radio" name="rgname" onclick="changeVg()"/>人员群组
	 -->
	<div id="tree"
			style="overflow: auto; height: 89%; width: 100%;"></div>
	</body>
</html>
