<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="../css/site.css" rel="stylesheet" type="text/css">
		<title>组织机构设置</title>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	Ext.onReady(function(){
	Ext.QuickTips.init();
	 var Tree = Ext.tree;
	 <s:iterator value="orglist">
	 	<s:if test="${fpid=='0'}">
        var root=new Tree.TreeNode({id:'${fid}',text:'<s:property value="fname"/>',href:'<%=request.getContextPath()%>/resmngt/integory/search_auth.action?auditunitid=${fid}',hrefTarget:'childBasefrm',draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
        var node_${fid}=root;
       </s:if>
      <s:else>
      	<s:if test="${!isHaveChild}">
      		<s:if test="${orgType=='1'}">
      			var node_${treefid}=new Tree.TreeNode({id:'${fid}',qtip:'${fname}',text:'${fname}',href:'<%=request.getContextPath()%>/resmngt/integory/search_auth.action?auditunitid=${fid}',leaf:false,hrefTarget:'childBasefrm'});
      		</s:if>
      		<s:else>
      			var node_${treefid}=new Tree.TreeNode({id:'${fid}',qtip:'${fname}',text:'${fname}',href:'',leaf:false,hrefTarget:'childBasefrm',
      					listeners:{
							"click":function(){
									alert("非审计单位，不能操作！");
							}
		            	}});
      		</s:else> 
      	</s:if>
      	<s:else>
      		<s:if test="${orgType=='1'}">
      			var node_${treefid}=new Tree.TreeNode({id:'${fid}',qtip:'${fname}',text:'${fname}',href:'<%=request.getContextPath()%>/resmngt/integory/search_auth.action?auditunitid=${fid}',leaf:false,hrefTarget:'childBasefrm'});
      		</s:if>
      		<s:else>
      			var node_${treefid}=new Tree.TreeNode({id:'${fid}',qtip:'${fname}',text:'${fname}',href:'',leaf:false,hrefTarget:'childBasefrm',
      					listeners:{
							"onclick":function(){
									var s = document.getElementById('${fid}').value;
									alert(s + "是非审计单位！");
							}
		            	}});
      		</s:else> 
      	</s:else>
      </s:else> 
	</s:iterator>
	<s:iterator value="orglist">
		<s:if test="${ fpid!='0'}">
		try{
			node_${treefpid}.appendChild(node_${treefid});
		}catch(e){}
		</s:if>
	</s:iterator>
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
      });
</script>
	</head>
	<body>
		<div id="tree"
			style="height: 100%; width: 100%;"></div>
	</body>
</html>
