<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>被审计单位资料模板</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>

	<script type="text/javascript">
		$(function () {
            var defaultUrl = "${contextPath}/auditobject/material/editMaterialCategory.action?category.categoryId=0&view=${view}";
            $('#editIframe').attr('src', defaultUrl);
            var treeObj = $('#categoryTree')[0];

            var winJson = showSysTree(treeObj,{
                container:treeObj,
                noMsg:true,
                queryBox:false,
                param:{
                    'rootParentId':'-1',
                    'beanName':'MaterialCategory',
                    'treeId'  :'categoryId',
                    'treeText':'categoryCNName',
                    'treeParentId':'parentId',
                    'treeOrder':'currentIndex',
                    'serverCache':false
                },
                onLoadSuccess:aud$expandAll,
                onTreeClick:function(node, treeDom){
                    var rightIfmUrl = "${contextPath}/auditobject/material/editMaterialCategory.action?category.categoryId="+node.id+"&view=${view}";
                    if(rightIfmUrl){
                        $('#editIframe').attr('src', rightIfmUrl);
                    }
                }
            });
            var winOption = winJson.win.param;
            var jqtree = winOption.jqtree;
            window.left$tree = jqtree;

            function aud$expandAll(){
                var roots = $(left$tree).tree('getRoots');
                $.each(roots, function(i, root){
                    $(left$tree).tree('expandAll', root.target);
                });
            }
        });
        //定位树形节点
        function aud$locationLeftTreeNode(nodeId){
            $(left$tree).tree('reload');
            if(nodeId){
                window.setTimeout(function(){
                    aud$expandAll();
                    var snode = $(left$tree).tree('find', nodeId);
                    if(snode){
                        QUtil.selectedSpecifiedNode(window.left$tree, snode, snode.text );
                        $(left$tree).tree('expand', snode.target);
                    }
                },100);
            }
        }
	</script>
	<body class="easyui-layout" style="overflow:hidden;">
		 <div title="资料分类" region="west" style="width: 200px;">
			 <ul id="categoryTree"></ul>
		 </div>
		 <div title="分类维护" region="center">
			 <iframe id="editIframe" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0"></iframe>
		 </div>
	</body>
</html>