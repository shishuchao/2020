<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<HTML>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>违规问题库总页</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript">
        $(function () {
            var dnd = '${param.view}' == 'yes' ? false : true;

            $('#tjlbTreeSelect').tree({
                url: '/ais/ledger/problemledger/treeExpand.action',
                checkbox: false,
                animate: false,
                lines: true,
                dnd: dnd,
                onClick: function (node) {
                    var state = node.state;
                    var id = node.id;
                    //if(isLeaf == 'N'){
                    var src = '<%=request.getContextPath()%>/ledger/problemledger/problemListFrame.action?view=<%=request.getParameter("view")%>&id=' + id;
                    $('#childBasefrm').attr('src', src);
                    //}
                },
                onBeforeDrag: function (node) {
                    if (node.parentId == '0') {
                        return false;
                    }
                },
                onBeforeDrop: function (target, source, point) {
                    var targetNode = $('#tjlbTreeSelect').tree('getNode', target);
                    if (targetNode.leaf == '1' && point == 'append') {
                        return false;
                    }
                    if (targetNode.parentId == '0' && point != 'append') {
                        return false;
                    }
                },
                onDrop: function (target, source, point) {
                    var targetNode = $('#tjlbTreeSelect').tree('getNode', target);
                    updateNode(targetNode.id, source.id, point);
                },
                onContextMenu: function (e, node) {
                    e.preventDefault();
                    var parent = $('#tjlbTreeSelect').tree('getParent', node.target);
                    if (parent.length <= 0)
                        return false;

                    $('#tjlbTreeSelect').tree('select', node.target);
                    $('#mm').menu('show', {
                        left: e.pageX,
                        top: e.pageY
                    });
                    if (node.leaf == '1') {
                        $('#mm').menu('disableItem', $('#pasteMenu'));
                    } else {
                        $('#mm').menu('enableItem', $('#pasteMenu'));
                    }
                    $('#mm').menu({
                        onClick: function (item) {
                            if (item.id == 'copyMenu') {
                                problemId = node.id;
                                problemName = node.text;
                            } else if (item.id == 'pasteMenu') {
                                if (problemId == null || problemId == '') {
                                    showMessage1('请先复制问题再执行粘贴操作!');
                                    return;
                                }
                                top.$.messager.confirm('确认', '确认要复制问题[<span style=\"color:red\" title="' + problemName + '">' + (problemName.length > 20 ? problemName.substring(0, 20) : problemName) + '...</span>]到[<span style=\"color:red\" title="' + node.text + '">' + (node.text.length > 20 ? node.text.substring(0, 20) : node.text) + '...</span>]下吗?', function (r) {
                                    if (r) {
                                        $.ajax({
                                            url: '<%=request.getContextPath()%>/ledger/problemledger/copyProblemNode.action',
                                            type: 'get',
                                            cache: false,
                                            data: {
                                                'problemId': problemId,
                                                'pasteProblemId': node.id
                                            },
                                            success: function (data) {
                                                if (data.indexOf('ok') != -1) {
                                                    var newNodeId = data.split("&")[1];
                                                    reloadTree(newNodeId);
                                                    problemId = '';
                                                    problemName = '';
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    });
                }
            });
        });

        /************** 公共方法 ***************/
        // 重新加载树形
        function reloadTree(nodeId) {
            var node = $('#tjlbTreeSelect').tree('getSelected');
            $('#tjlbTreeSelect').tree('reload', node.target);
        }

        function updateNode(toNodeId, sourceNodeId, point) {
            $.ajax({
                url: '<%=request.getContextPath()%>/ledger/problemledger/updateNode.action',
                type: 'get',
                cache: false,
                data: {
                    toNodeId: toNodeId,
                    sourceNodeId: sourceNodeId,
                    point: point
                },
                success: function (data) {
                    if (data != 'ok') {
                        showMessage1(data);
                    }
                }
            });
        }

        function reloadSelectedNode(type, node) {
            if (!node) {
                var node = $('#tjlbTreeSelect').tree('getSelected');
                var isLeaf = $('#tjlbTreeSelect').tree('isLeaf', node.target);
                if (isLeaf || type == 'deltype') {
                    var node = $('#tjlbTreeSelect').tree('getParent', node.target);
                }
                if (type == 'add') {
                    $('#childBasefrm').attr('src', '<%=request.getContextPath()%>/ledger/problemledger/add_problempoint.action?type=add&ledgerTemplateNew.id=' + node.id);
                } else if (type == 'delete' || type == null || type == "") {
                    $('#childBasefrm').attr('src', '<%=request.getContextPath()%>/ledger/problemledger/problemListFrame.action?view=<%=request.getParameter("view")%>&id=' + node.id);
                }
                $('#tjlbTreeSelect').tree('reload', node.target);
            }
        }
    </script>
</head>

<body class="easyui-layout" id="codenameLayout" style="overflow:hidden;">
<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center" style="display: none;">
    <tr class="listtablehead">
        <td colspan="5" align="left" class="edithead">
            <s:if test="${param.view eq 'yes'}">
                <s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/ledger/problem_tree/problemindex.jsp?view=yes')"/>
            </s:if>
            <s:else>
                <s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/ledger/problem_tree/problemindex.jsp')"/>
            </s:else>
        </td>
    </tr>
</table>
<div region="west" title="违规问题设置" style="width:300px;height: 100%" split="true">
    <div id="content" style="width: 100%;height: 100%">
        <br>
        <ul id="tjlbTreeSelect" class='easyui-tree'></ul>
        <div id="mm" class="easyui-menu" style="width:120px;">
            <div data-options="iconCls:'icon-edit'" id="copyMenu">复制</div>
            <div data-options="iconCls:'icon-copy'" id="pasteMenu">粘贴</div>
        </div>
        <br>
    </div>
</div>
<div region="center" style="overflow: hidden;">
    <iframe id="childBasefrm" name="childBasefrm" src="<%=request.getContextPath()%>/pages/assist/suport/lawsLib/tishiView.jsp" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
</div>
</body>
</HTML>
