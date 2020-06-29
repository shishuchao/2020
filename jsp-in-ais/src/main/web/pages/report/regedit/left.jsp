<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
			
<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	Ext.onReady(function(){
	 var Tree = Ext.tree;
	  var root=new Tree.TreeNode({
               id:'0',
              <s:if test="${empty apply}">
               text:'报表注册',
               href:'regAction!edit.action?register.id=&view=view',
               hrefTarget:'right',
              </s:if>
              <s:else>
               text:'报表查看',
              </s:else>
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
      <s:if test="${empty apply}">
		  <s:iterator value="list">
	      	var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}_${order}',href:'regAction!edit.action?register.id=${id}&view=view',leaf:false,hrefTarget:'right'});
	      </s:iterator>
      </s:if>
      <s:else>
          <s:iterator value="list">
          	<s:if test="${dataSource=='sql'}">
	      	var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}',href:'<%=request.getContextPath()%>/report/apply/reportAction!reportToView.action?id=${id}',leaf:false,hrefTarget:'right'});
          	</s:if><s:else>
	      	var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}',href:'<%=request.getContextPath()%>/${fn:replace ( handleCls,".class",".r" )}?method=reportView',leaf:false,hrefTarget:'right'});
          	</s:else>
	      </s:iterator> 
     </s:else>      
	<s:iterator value="list">
		root.appendChild(node_${id});
	</s:iterator>
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 autoHeight:true,
                //是否显示跟节点 rootVisible:false,
                 containerScroll: true});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
      });
</script>
</head>
<body><%--  overflow: auto; --%>
<div id="tree"
			style=" height: 100%; width: 100%;"></div>
</body>
</html>