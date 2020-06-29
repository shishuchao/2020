<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
<title>审计案例维护树</title>
<script type="text/javascript">
	Ext.onReady(function(){
//     var url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/listByTypeKey.action?mCodeType=${mCodeType}&nodeid=${id}";
//     var url2 = url.replace("&","*");
//     var url3 = url + "&backUrl="+url2;
//	 var url3 = url;
 //    alert("url3=" + url3);
	 var Tree = Ext.tree;
	 
	 <s:iterator value="m_list">
	 	<s:if test="${empty(parent_id)}">
	 	var id_1 = '<s:property value="id"/>';
	 //	alert("id=" + ${id});
	 //	alert("obj.id"+${obj.id});
	// 	alert("#obj.id"+${#obj.id});
        var root=new Tree.TreeNode({
               id:'${id}',
               text:'<s:property value="category_name"/>',
               href:'../lawsLib/listByTypeKey.action?mCodeType=${mCodeType}&nodeid='+id_1+'',
               hrefTarget:'childBasefrm',
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
        var node_${id}=root;
       </s:if>
      <s:else>
      		var id_2 = '<s:property value="id"/>';
      	//	var test = '${id}';
      //		alert("test="+'${id}');
     //		alert("id=" + ${id});
	//	 	alert("obj.id"+${obj.id});
	//	 	alert("#obj.id"+${#obj.id});
      	<s:if test="${!isHaveChild}">
      	 	var url3 = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/listByTypeKey.action?mCodeType=${mCodeType}&nodeid="+id_2+"";
      		var node_${id}=new Tree.TreeNode({id:id_2,text:'<s:property value="category_name"/>',href:url3,leaf:true,hrefTarget:'childBasefrm'});
      	</s:if>
      	<s:else>
      		var node_${id}=new Tree.TreeNode({id:id_2,text:'<s:property value="category_name"/>',href:url3,leaf:false,hrefTarget:'childBasefrm'});
      	</s:else>
      </s:else> 
	</s:iterator>
	<s:iterator value="m_list">
			var id_3 = '<s:property value="id"/>';
      	//	alert("id=" + ${id});
		// 	alert("o.id"+${o.id});
		// 	alert("#o.id"+${#o.id});
		<s:if test="${ not empty(parent_id)}">
		node_${parent_id}.appendChild(node_${id});
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
			style="height: auto; width: 100%;"></div>
<body>
</html>