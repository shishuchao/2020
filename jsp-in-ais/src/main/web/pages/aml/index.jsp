<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>审计事项库管理</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        .buttons {
            position: fixed;
            width:100%
        }
        .buttons .ListTable {
            margin:0;
        }
        .buttons .easyui-linkbutton {
            margin: 0 10px;
        }
    </style>
</head>
<body class="easyui-layout">

<!-- left -->
<div region="west" split="true" title="审计事项类别" style="overflow:auto;width:300px;">
    <div id="treeMatter"></div>
</div>

<!-- center -->
<div region="center" border="0">
    <div id="matterPanel" class="easyui-panel" title="审计事项类别查看" style="margin:0;padding:0;width:100%;height:100%;border:0;overflow:scroll;">
        <s:if test="${flag != '1'}">
        <div class="buttons">
            <table class="ListTable">
                <tr class="EditHead">
                    <td style="float:left">
                        <a id="btnAddNode" class="easyui-linkbutton" iconCls="icon-add" onclick="onBtnAddNode()">增加类别</a>
                        <a id="btnSaveNode" class="easyui-linkbutton" iconCls="icon-save" onclick="onBtnSaveNode()">保存类别</a>
                        <a id="btnSaveLeaf" class="easyui-linkbutton" iconCls="icon-save" onclick="onBtnSaveLeaf()">保存审计事项</a>
                        <a id="btnDelNode" class="easyui-linkbutton" iconCls="icon-delete" onclick="onBtnDelNode()">删除类别</a>
                        <a id="btnDelLeaf" class="easyui-linkbutton" iconCls="icon-delete" onclick="onBtnDelLeaf()">删除审计事项</a>
                        <s:if test="${flag != '3'}">
                        <a id="btnImportExport" class="easyui-linkbutton" iconCls="icon-import" onclick="onBtnImportExport()">导入/导出审计事项</a>
                        <a id="btnAddLeaf" class="easyui-linkbutton" iconCls="icon-add" onclick="onBtnAddLeaf()">增加审计事项</a>
                        </s:if>
                    </td>
                </tr>
            </table>
        </div>
        </s:if>

        <div style="padding: 30px 0;">
            <div id="importMsg">${importMsg}</div>
            <form id="matterNodeForm">
                <table class="ListTable" align="center">
                    <tr>
                        <td class="EditHead" nowrap sytle="width:17%">
                            <font color="red">*</font>事项类别编号
                        </td>
                        <td class="editTd" sytle="width:33%">
                            <input type="text" name="sjsx_id" class="noborder">
                        </td>
                        <td class="EditHead" nowrap sytle="width:17%">
                            <font color="red">*</font>事项名称
                        </td>
                        <td class="editTd" sytle="width:33%">
                            <input type="text" name="sjsx_name" class="noborder">
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead" nowrap>
                            <font color="red">*</font>父节点编号
                        </td>
                        <td class="editTd">
                            <input type="text" name="sjsx_parentId" class="noborder">
                        </td>
                        <td class="EditHead">
                            审计事项序号
                        </td>
                        <td class="editTd">
                            <input type="text" name="sjlb_taskorder" class="noborder"/>
                        </td>
                    </tr>

                    <s:if test="${flag == '3'}">
                        <tr>
                            <td class="EditHead" nowrap>
                                创建人
                            </td>
                            <td class="editTd">
                                <input type="text" name="sjsx_creator" class="noborder">
                                <input type="hidden" name="sjsx_creatorCode">
                            </td>
                            <td class="EditHead">
                                创建人所属单位
                            </td>
                            <td class="editTd">
                                <input type="text" name="sjsx_company" class="noborder"/>
                                <input type="hidden" name="sjsx_companyCode">
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead" nowrap>
                                创建日期
                            </td>
                            <td class="editTd">
                                <input type="text" name="sjsx_dateCreated" class="noborder">
                            </td>
                            <td class="EditHead">
                                <font color="red">*</font>类别所属单位
                            </td>
                            <td class="editTd">
                                <s:buttonText name="sjsx_amCompany" hiddenName="sjsx_amCompanyCode"
                                              readonly="true"
                                              doubleDisabled="false"
                                              doubleSrc="/easyui/1.4/themes/icons/search.png" cssClass="noborder"
                                              doubleOnclick="showSysTree(this,{
                                                 url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                                 title:'请选择所属单位',
                                                 param:{
                                                     'p_item':1,
                                                     'orgtype':1
                                                 },
                                                 defaultDeptId:'${user.fdepid}'
                                             })"/>
                            </td>
                        </tr>
                    </s:if>
                </table>
            </form>
            <form id="matterLeafForm">
                <table class="ListTable" align="center">
                    <tr>
                        <td class="EditHead" nowrap style="width: 15%;">
                            <font color="red">*</font>&nbsp;审计事项编号
                        </td>
                        <td class="editTd" style="width: 35%;">
                            <input type="text" name="sjsx_bh" class="noborder"/>
                        </td>
                        <td class="EditHead" nowrap style="width: 15%;">
                            <font color="red">*</font>&nbsp;父节点编号
                        </td>
                        <td class="editTd" nowrap style="width: 35%;">
                            <input type="text" name="sjsx_id2" class="noborder"/>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap class="EditHead">
                            <font color="red">*</font>&nbsp;审计事项名称
                        </td>
                        <td nowrap class="editTd">
                            <input type="text" name="sjsx_dname" class="noborder"/>
                        </td>
                        <td nowrap class="EditHead">
                            审计事项序号
                        </td>
                        <td class="editTd">
                            <input type="text" name="sjsx_taskorder" class="noborder"/>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap class="EditHead">
                            审计程序和方法
                        </td>
                        <td class="editTd" colspan=3>
                            <textarea name="sjsx_riskpoint" style="width:100%"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap class="EditHead">
                            相关法律法规和监管规定
                        </td>
                        <td class="editTd" colspan=3>
                            <textarea name="sjsx_law" class="noborder" style="width:100%"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">所需资料</td>
                        <td class="editTd" colspan=3>
                            <textarea name="sjsx_taskTarget" class="noborder" style="width:100%"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap class="EditHead">
                            审计查证要点
                            <div><font color="#a9a9a9">(限5000字)</font></div>
                        </td>
                        <td class="editTd" colspan=3>
                            <textarea name="sjsx_method" class="noborder" style="width:100%" maxlength="5000"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap class="EditHead">重点关注内容</td>
                        <td class="editTd" colspan=3>
                            <textarea name="pointContent" sclass="noborder" style="width:100%"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<div id="importExportDlg">
    <div style="padding: 10px;">
        <a id='btnExportTemplate' class="easyui-linkbutton" iconCls="icon-export" onclick="onBtnExportTemplate()">导出Excel模板</a>
        <a id='btnExportNode' class="easyui-linkbutton" iconCls="icon-export" onclick="onBtnExportNode()">导出审计事项</a>
        <a id='btnImportTemplate' class="easyui-linkbutton" iconCls="icon-import" onclick="onBtnImportTemplate()">导入Excel模板</a>
        <a id='btnImportLeaf' class="easyui-linkbutton" iconCls="icon-import" onclick="onBtnImportLeaf()">导入审计事项</a>
    </div>

    <form id="exportForm" target="importExportFrame" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="excelType">
        <table class="ListTable" align="center">
            <tr>
                <td class="EditHead">
                    导入的Excel文件(支持MS Office Excel 2003)<%-- 实际后台也支持2007 --%>
                </td>
                <td class="editTd">
                    <s:file name="sjsx_file" id='sjsx_file'/>
                </td>
            </tr>
        </table>
    </form>
    <iframe id="importExportFrame" style="display:none;"></iframe>
</div>

<script type="text/javascript">
    $(function () {
        // 审计事项类别导入/导出对话框
        generateWin('importExportDlg');
        // 审计事项类别树
        loadSjsxLbTree();
    });
</script>
<script type="text/javascript">
    <%--
    flag: null-编辑，1-查看，3-一级分类维护
    --%>
    var flag = '${flag}';

    Date.prototype.format = function (fmt) {
        var o = {
            "q+": Math.floor((this.getMonth() + 3) / 3),    //季度
            "M+": this.getMonth() + 1,                      //月份
            "d+": this.getDate(),                           //日
            "h+": this.getHours(),                          //小时
            "m+": this.getMinutes(),                        //分
            "s+": this.getSeconds(),                        //秒
            "S": this.getMilliseconds()                     //毫秒
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (var k in o) {
            if (new RegExp("(" + k + ")").test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            }
        }
        return fmt;
    };

    // 加载审计事项类别树
    function loadSjsxLbTree() {
        var treeMatter = $('#treeMatter');
        showSysTree(treeMatter[0], {
            container: treeMatter[0],
            url: '${contextPath}/aml/getSjsxTree.action?flag=${flag}&amCompanyCode=${magOrganization.fid}',
            cache: false,
            checkbox: false,
            onTreeClick: onTreeMatterClick,
            onTreeLoadSuccess: onTreeMatterLoadSuccess
        });
    }

    function onTreeMatterLoadSuccess(node, data) {
        var treeMatter = $('#treeMatter');
        if (data && data.length) {
            var selection = treeMatter.tree('getSelected');
            if (selection == null) {
                selection = treeMatter.tree('find', '1');
                if (selection) {
                    treeMatter.tree('select', selection.target);
                    onTreeMatterClick(selection);
                }
            }
        }
    }

    function onTreeMatterClick(node) {
        $.ajax({
            url: '${contextPath}/aml/getAuditMatterInfo.action',
            data: {id: node.id},
            type: "POST",
            dataType: 'json',
            async: false,
            success: function (data) {
                if (data.type == 'success') {
                    node.leaf == '1' ? editMatterLeaf(data.msg) : editMatterNode(data.msg);
                }
            },
            error: function () {
                showMessage1('请求失败！');
            }
        });
    }

    // 编辑审计事项分类
    function editMatterNode(data) {
        // 标题
        $('#matterPanel').panel('setTitle', '审计事项类别' + (flag == '1' ? '查看' : '编辑'));

        // 按钮
        if (data.pid == null || data.pid == '') {
            // 1级事项类别
            flag == '3' ? switchButtons(['btnAddNode', 'btnSaveNode', 'btnDelNode']) : switchButtons();
        } else if (data.pid == '1') {
            // 2级事项类别
            flag == '3' ? switchButtons(['btnSaveNode', 'btnDelNode']) : switchButtons(['btnAddNode', 'btnImportExport', 'btnAddLeaf']);
        } else {
            // 2级以下事项类别
            flag == '3' ?  switchButtons() : switchButtons(['btnAddNode', 'btnSaveNode', 'btnDelNode', 'btnImportExport', 'btnAddLeaf']);
        }

        // 表单
        $('#matterLeafForm').hide();
        $('#matterNodeForm').show();
        switchEnabledFields('matterNodeForm', ['sjsx_name', 'sjlb_taskorder']);
        $('[name="sjsx_id"]').val(data.id);
        $('[name="sjsx_name"]').val(data.name);
        $('[name="sjsx_parentId"]').val(data.pid);
        $('[name="sjlb_taskorder"]').val(data.taskorder);
        $('[name="sjsx_creator"]').val(data.creator);
        $('[name="sjsx_creatorCode"]').val(data.creatorCode);
        $('[name="sjsx_company"]').val(data.company);
        $('[name="sjsx_companyCode"]').val(data.companyCode);
        $('[name="sjsx_dateCreated"]').val(data.dateCreated ? new Date(data.dateCreated).format("yyyy-MM-dd") : null);
        $('[name="sjsx_amCompany"]').val(data.amCompany);
        $('[name="sjsx_amCompanyCode"]').val(data.amCompanyCode);
        $("#matterNodeForm").find("textarea").each(function () {
            autoTextarea(this);
        });
    }

    // 编辑审计事项
    function editMatterLeaf(data) {
        // 标题
        $('#matterPanel').panel('setTitle', '审计事项' + (flag == '1' ? '查看' : '编辑'));

        // 按钮
        switchButtons(['btnSaveLeaf', 'btnDelLeaf']);

        // 表单
        $('#matterNodeForm').hide();
        $('#matterLeafForm').show();
        switchEnabledFields(
            'matterLeafForm',
            [
                'sjsx_dname',       // 审计事项名称
                'sjsx_taskorder',   // 审计事项序号
                'sjsx_riskpoint',   // 审计程序和方法
                'sjsx_law',         // 相关法律法规和监管规定
                'sjsx_taskTarget',  // 所需资料
                'sjsx_method',      // 审计查证要点
                'pointContent'      // 重点关注内容
            ]
        );
        $('[name="sjsx_bh"]').val(data.id);
        $('[name="sjsx_id2"]').val(data.pid);
        $('[name="sjsx_dname"]').val(data.name);
        $('[name="sjsx_taskorder"]').val(data.taskorder);
        $('[name="sjsx_riskpoint"]').val(data.riskPoint);
        $('[name="sjsx_law"]').val(data.law);
        $('[name="sjsx_taskTarget"]').val(data.taskTarget);
        $('[name="sjsx_method"]').val(data.method);
        $('[name="pointContent"]').val(data.pointContent);
        $("#matterLeafForm").find("textarea").each(function () {
            autoTextarea(this);
        });
    }

    // 增加事项类别按钮
    function onBtnAddNode() {
        var sjsx_id = $('#matterNodeForm').find('[name="sjsx_id"]');

        var isIdReadonly = sjsx_id.attr('readonly');
        if (isIdReadonly) {
            editMatterNode({pid: sjsx_id.val(), dateCreated:new Date()});
            switchButtons(['btnSaveNode']);
            switchEnabledFields('matterNodeForm', ['sjsx_id', 'sjsx_name', 'sjlb_taskorder']);
        } else {
            showMessage1("请先保存当前类别！");
        }
    }

    // 保存事项类别按钮
    function onBtnSaveNode() {
        var treeMatter = $('#treeMatter');
        var form = $('#matterNodeForm');

        var existMatter = null;
        var sjsx_id = form.find('[name="sjsx_id"]');
        if (!sjsx_id.attr('readonly')) {
            $.ajax({
                url: '${contextPath}/aml/getAuditMatterInfo.action',
                data: {id: sjsx_id.val()},
                type: "POST",
                dataType: 'json',
                async: false,
                success: function (data) {
                    existMatter = data.type == 'success' ? data.msg : null;
                }
            });
        }
        if (existMatter) {
            showMessage1('审计事项类别编号重复：' + existMatter.id + ' - ' + existMatter.name);
            return;
        }

        $.ajax({
            url: "${contextPath}/aml/saveSjsxLb.action",
            data: form.serialize(),
            type: "POST",
            dataType: 'json',
            beforeSend: function() {
                return validateNode();
            },
            success: function (data) {
                showMessage1(data.msg);
                var node = treeMatter.tree('find', form.find('[name="sjsx_parentId"]').val());
                var rootNode = treeMatter.tree('getRoot');
                if (rootNode.id == node.id) {
                    treeMatter.tree('reload', node.target);
                } else {
                    refreshTreeNode(node);
                }
            },
            error: function () {
                showMessage1('请求失败！');
            }
        });
    }

    // 删除事项类别按钮
    function onBtnDelNode() {
        var treeMatter = $('#treeMatter');
        var form = $('#matterNodeForm');

        var node = treeMatter.tree('getSelected');
        if (!node) {
            showMessage1('请选择一个节点');
            return;
        }
        if (node.leaf == '1') {
            showMessage1('所选节点不是事项类别');
            return;
        }
        if (node.parentId == null || node.parentId == '') {
            showMessage1('根节点不能删除');
            return;
        }

        $.messager.confirm('提示信息', '删除后会丢失该类别下的所有相关事项，确认删除事项类别吗？', function (yes) {
            if (yes) {
                $.ajax({
                    url: "${contextPath}/aml/deleteSjsxByTypeId.action",
                    data: form.serialize(),
                    type: "POST",
                    dataType: 'json',
                    beforeSend: function() {
                        return validateNode();
                    },
                    success: function (data) {
                        showMessage1(data.msg);
                        refreshTreeNode(treeMatter.tree('getParent', node.target));
                    },
                    error: function () {
                        showMessage1('请求失败！');
                    }
                })
            }
        });
    }

    // 增加事项按钮
    function onBtnAddLeaf() {
        editMatterLeaf({pid: $('#matterNodeForm').find('[name="sjsx_id"]').val()});
        switchButtons(['btnSaveLeaf']);
        switchEnabledFields(
            'matterLeafForm',
            [
                'sjsx_bh',          // 审计事项编号
                'sjsx_dname',       // 审计事项名称
                'sjsx_taskorder',   // 审计事项序号
                'sjsx_riskpoint',   // 审计程序和方法
                'sjsx_law',         // 相关法律法规和监管规定
                'sjsx_taskTarget',  // 所需资料
                'sjsx_method',      // 审计查证要点
                'pointContent'      // 重点关注内容
            ]
        );
    }

    // 保存事项按钮
    function onBtnSaveLeaf() {
        var treeMatter = $('#treeMatter');
        var form = $('#matterLeafForm');

        var existMatter = null;
        var sjsx_bh = form.find('[name="sjsx_bh"]');
        if (!sjsx_bh.attr('readonly')) {
            $.ajax({
                url: '${contextPath}/aml/getAuditMatterInfo.action',
                data: {id: sjsx_bh.val()},
                type: "POST",
                dataType: 'json',
                async: false,
                success: function (data) {
                    existMatter = data.type == 'success' ? data.msg : null;
                }
            });
        }
        if (existMatter) {
            showMessage1('审计事项编号重复：' + existMatter.id + ' - ' + existMatter.name);
            return;
        }

        $.ajax({
            url: "${contextPath}/aml/saveSjsx.action",
            data: form.serialize(),
            type: "POST",
            dataType: 'json',
            beforeSend: function() {
                return validateLeaf();
            },
            success: function (data) {
                showMessage1(data.msg);
                if (data.type != 'error') {
                    refreshTreeNode(treeMatter.tree('find', form.find('[name="sjsx_id2"]').val()));
                }
            },
            error: function() {
                showMessage1('请求失败！');
            }
        });
    }

    // 删除事项按钮
    function onBtnDelLeaf() {
        var treeMatter = $('#treeMatter');
        var form = $('#matterLeafForm');
        var id = form.find('[name="sjsx_bh"]').val();
        var parentId = form.find('[name="sjsx_id2"]').val();
        $.messager.confirm('提示信息', '确认删除审计事项吗？', function (yes) {
            if (yes) {
                $.ajax({
                    url: "${contextPath}/aml/deleteSjsxLb.action",
                    data: {
                        sjsx_id: id,
                        sjsx_parentId: parentId
                    },
                    type: "POST",
                    dataType: 'json',
                    beforeSend: function () {
                        return validateLeaf();
                    },
                    success: function (data) {
                        showMessage1(data.msg);
                        if (data.type != 'error') {
                            refreshTreeNode(treeMatter.tree('find', parentId));
                        }
                    },
                    error: function () {
                        showMessage1('请求失败！');
                    }
                });
            }
        });
    }

    // 导入/导出按钮
    function onBtnImportExport() {
        openWin('importExportDlg', '审计事项类别导入/导出');
    }

    // 导出Excel模板按钮
    function onBtnExportTemplate() {
        $.ajax({
            type: 'POST',
            url: '${contextPath}/aml/exportSjsxTemplate!checkSjsxTemplate.action',
            success: function (msg) {
                if (msg == 1) {
                    window.location = '${contextPath}/aml/exportSjsxTemplate.action';
                } else {
                    showMessage1('请先上传模板文件！');
                }
            },
            error: function () {
                showMessage1('请求失败！');
            }
        });
    }

    // 导出审计事项按钮
    function onBtnExportNode() {
        window.location = '${contextPath}/aml/exportSjsxLb.action';
    }

    // 导入Excel模板按钮
    function onBtnImportTemplate() {
        var sjsx_file = $('#sjsx_file');
        var pathArr = sjsx_file.val().split('.');
        var suffix = pathArr[pathArr.length - 1];
        if (suffix != 'xls') {
            showMessage1('导入文件后缀名错误，请导入 .xls 后缀Excel文档类型文件！');
            sjsx_file.val('');
        } else {
            $('#exportForm').attr('action', '${contextPath}/aml/importSjsxTemplate.action').submit();
        }
    }

    // 导入审计事项按钮
    function onBtnImportLeaf() {
        var sjsx_file = $('#sjsx_file');
        var pathArr = sjsx_file.val().split('.');
        var suffix = pathArr[pathArr.length - 1];
        if (suffix != 'xls') {
            showMessage1('导入文件后缀名错误，请导入 .xls 后缀Excel文档类型文件！');
            sjsx_file.val('');
        } else {
            $('#excelType').val('2003');
            $('#exportForm').attr('action', '${contextPath}/aml/importSjsxLb.action').submit();
            $('#btnImportLeaf').attr('disabled', true);
        }
    }

    // 校验审计事项类别表单
    function validateNode() {
        var names = ['sjsx_id', 'sjsx_name', 'sjsx_parentId'];
        var titles = ['事项类别编号', '事项名称', '父节点编号'];
        if (flag == '3') {
            names.push('sjsx_amCompany');
            titles.push('类别所属单位');
        }
        for (var i = 0; i < names.length; i++) {
            var field = $('#matterNodeForm').find('[name="' + names[i] + '"]');
            if (!field.val()) {
                showMessage1('【' + titles[i] + '】不能为空');
                field.focus();
                return false;
            }
        }
        return true;
    }

    // 校验审计事项表单
    function validateLeaf() {
        var names = ['sjsx_bh', 'sjsx_id2', 'sjsx_dname'];
        var titles = ['审计事项编号', '父节点编号', '审计事项名称'];
        for (var i = 0; i < names.length; i++) {
            var field = $('#matterLeafForm').find('[name="' + names[i] + '"]');
            if (!field.val()) {
                showMessage1('【' + titles[i] + '】不能为空');
                field.focus();
                return false;
            }
        }
        return true;
    }

    function refreshTreeNode(node) {
        var treeMatter = $('#treeMatter');
        var rootNode = treeMatter.tree('getRoot');

        function refresh(node) {
            var parentNode = treeMatter.tree('getParent', node.target);
            if (parentNode && parentNode.id != rootNode.id) {
                refresh(parentNode);
                if (parentNode.state != 'open') {
                    treeMatter.tree('expand', parentNode.target);
                }
            } else {
            	if (parentNode ){
            		treeMatter.tree('expand', parentNode.target);
            	}
                treeMatter.tree('reload', node.target);
            }
        }

        refresh(node);
        treeMatter.tree('select', node.target);
        onTreeMatterClick(node);
    }

    function switchButtons(ids) {
        $('.buttons .easyui-linkbutton').hide();
        if (ids && ids.length) {
            $.each(ids, function (i, id) {
                $('#' + id).show();
            });
        }
    }

    function switchEnabledFields(formId, names) {
        var form = $('#' + formId);
        form.find('input,textarea').attr('readonly', 'readonly');
        if (flag != '1') {
            if (names && names.length) {
                $.each(names, function (i, name) {
                    form.find('[name="' + name + '"]').removeAttr('readonly');
                });
            }
        }
    }
</script>
</body>
</html>