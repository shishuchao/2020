<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <title> 用户授权设置 </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
</head>
<body class="easyui-layout" id="codenameLayout">
<!-- 组织树 -->
<div region="west" title="用户权限" style="width:200px;height: 100%;overflow:auto;" split="true">
    <ul id="orgTree" style="margin-top: 10px;"></ul>
</div>
<!-- 主页面列表 -->
<div region="center">
    <table id="userList"></table>
</div>

<!-- 用户角色 -->
<div id="userRoles">
    <table id="roleList"></table>
</div>
<!-- 用户授权 -->
<div id="winPage"></div>
<!-- 查询 -->
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="searchForm">
            <s:hidden id="p_deptid" name="p_deptid"/>
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="searchTable">
                <tr>
                    <td align="left" class="EditHead">
                        系统账号：
                    </td>
                    <td align="left" class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:160px;" id="floginname" name="floginname"/>
                    </td>
                    <td align="left" class="EditHead">
                        真实姓名：
                    </td>
                    <td align="left" class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="fname"/>
                    </td>
                </tr>
            </table>
        </s:form>
    </div>
    <div class="serch_foot">
        <div class="search_btn">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        showWin('dlgSearch');

        var orgTree = $('#orgTree');
        orgTree.tree({
            url: '<%=request.getContextPath()%>/admin/asyUorg4User.action?querySource=tree',
            checkbox: false,
            animate: false,
            lines: true,
            dnd: false,
            onClick: function (node) {
                $('#p_deptid').val(node.id);
                $('#userList').datagrid({
                    queryParams: {
                        'p_deptid': node.id
                    }
                });
            },
            onLoadSuccess: function (node, data) {
                var rootNode = orgTree.tree('getRoot');
                if (rootNode)
                    orgTree.tree('expand', rootNode.target);
                if (node && !orgTree.tree('getParent', node.target)) {
                    refreshGrid(node.id);
                } else if (!node && rootNode && rootNode.id != "") {//node 为空时
                    refreshGrid(rootNode.id);
                }
            }
        });
    });

    function refreshGrid(deptId) {
        $('#p_deptid').val(deptId);
        var bodyW = $('body').width();
        $('#userList').datagrid({
            url: '<%=request.getContextPath()%>/system/getUserListByOrg.action',
            queryParams: form2Json('searchForm'),
            method: 'post',
            showFooter: false,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            pageSize: 20,
            fitColumns: true,
            idField: 'fuserid',
            border: false,
            singleSelect: true,
            remoteSort: false,
            toolbar: [{
                id: 'search',
                text: '查询',
                iconCls: 'icon-search',
                handler: function () {
                    searchWindShow('dlgSearch');
                }
            }],
            columns: [[
                {
                    field: 'floginname',
                    title: '系统账号',
                    width: bodyW*0.1+'px',
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'fname',
                    title: '真实姓名',
                    sortable: true,
                    halign: 'center',
                    align: 'left',
                    width: bodyW*0.1+'px',
                },
                {
                    field: 'flevel',
                    title: '角色类型',
                    width: bodyW*0.1+'px',
                    align: 'center',
                    formatter: function (value, row, index) {
                        return value == 'general' ? '业务角色' : '管理角色';
                    }
                },
                {
                    field: 'fdepname',
                    title: '所属单位',
                    halign: 'center',
                    align: 'center',
                    width: bodyW*0.15+'px',
                    sortable: true
                },
                {
                    field: 'operate',
                    title: '操作',
                    width: bodyW*0.2+'px',
                    halign: 'center',
                    align: 'center',
                    sortable: false,
                    formatter: function (value, row, index) {
                        var link = "<a href=\"javascript:void(0)\"  onclick=\"showAllUserRoles('" + row.floginname + "')\">用户角色</a>";
                        link = link + "|<a href=\"javascript:void(0)\"  onclick=\"doPermission('" + row.floginname + "')\">用户授权</a>";
                        return link;
                    }
                }
            ]]
        });
    }

    function showAllUserRoles(floginname) {
        $('#roleList').datagrid({
            url: '<%=request.getContextPath()%>/system/authAuthorityAction!authAllRoleSet.action?querySource=grid',
            queryParams: {
                'p_floginname': floginname
            },
            method: 'post',
            showFooter: false,
            striped: true,
            autoRowHeight: false,
            fit: true,
            fitColumns: true,
            idField: 'froleid',
            border: false,
            singleSelect: true,
            remoteSort: false,
            columns: [[
                {
                    field: 'frolename',
                    title: '角色名称',
                    width: 100,
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'fcompanyname',
                    title: '公司名称',
                    width: 100,
                    sortable: true,
                    halign: 'center',
                    align: 'center'
                }
            ]]
        });

        $('#userRoles').dialog({
            title: '用户角色',
            width: 750,
            height: 400,
            cache: false,
            modal: true
        });
    }

    function doPermission(loginname) {
        var url = "<%=request.getContextPath()%>/system/authAuthorityAction!authoritySet.action?p_floginname=" + loginname;
        $('#winPage').dialog({
            title: '用户授权',
            width: 750,
            height: 450,
            closed: false,
            cache: false,
            modal: true,
            content: '<iframe  id="rolesFrame" src="' + url + '" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
        });
    }

    function doSearch() {
        $('#userList').datagrid({
            queryParams: form2Json('searchForm')
        });
        $('#dlgSearch').dialog('close');
    }

    function restal() {
        var deptIdObj = $('#p_deptid');
        var deptId = deptIdObj.val();
        resetForm('searchForm');
        deptIdObj.val(deptId);
    }

    function doCancel() {
        $('#dlgSearch').dialog('close');
    }
</script>
</body>
</html>