<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>离线采集数据管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <style type="text/css">
        #content {
            width: 20%;
        }
    </style>
    <script type="text/javascript">
        var dpetId = '${root_audit_object}';
        var frmUrl = '${contextPath}/pages/mng/audobj/data/mng.jsp?root_audit_object=';
        $(function () {
            var obj = $('#zcfgTreeSelect')[0];
            var winJson = showSysTree(obj, {
                param: {'beanName': 'AuditingObjectTree'},
                container: obj,
                url: '${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action?departmentId=' + dpetId,
                defaultDeptId: dpetId,
                cache: false,
                checkbox: false,
                treeTabTitle1: "被审计单位",
                onTreeClick: function (node, treeDom) {
                    $('#childBasefrm').attr('src', frmUrl + node.id);
                },
                onTreeLoadSuccess: function (node, data) {
                    if (data.length == 1) {
                        $('#childBasefrm').attr('src', frmUrl + data[0].id);
                    }
                }
            });
            var winOption = winJson.win.param;
            window.left$tree = winOption.jqtree;
        });

        //定位树形节点
        function aud$locationLeftTreeNode(nodeId) {
            $(left$tree).tree('reload');
            if (nodeId) {
                window.setTimeout(function () {
                    var snode = $(left$tree).tree('find', nodeId);
                    if (snode) {
                        QUtil.selectedSpecifiedNode(window.left$tree, snode, snode.text);
                        $(left$tree).tree('expand', snode.target);
                        $('#childBasefrm').attr('src', frmUrl + nodeId);
                    }
                }, 2000);
            }
        }
    </script>
</head>
<body id="codenameLayout" class='easyui-layout' fit='true' border="0">
<div id='content' region="west" border="0" split="true" style='overflow:hidden;width:300px;'>
    <div id='zcfgTreeSelect'></div>
</div>
<div region="center" border="0" style="overflow:hidden;">
    <iframe id="childBasefrm" name="childBasefrm" width="100%" frameborder="0" height="100%" src=""></iframe>
</div>
</body>
</html>