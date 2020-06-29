<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>实施专项填报任务</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
<%--
    <link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <style>
        .pagination span  {
            color:#646464
        }
    </style>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="myform" name="myform" action="listReportKeyRiskMonitor.action" namespace="/riskManagement/keyRiskMonitor/reportKeyRiskMonitor" method="post">
            <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td class="EditHead" style="width:20%">
                        编号
                    </td>
                    <td class="editTd" style="width:33%">
                        <s:textfield cssClass="noborder" name="reportKeyRiskMonitor.sn" cssStyle="width:80%" maxlength="50"/>
                    </td>
                    <td class="EditHead">
                        年度
                    </td>
                    <td class="editTd">
                        <select class="easyui-combobox" name="reportKeyRiskMonitor.year" id="pro_year" style="width:80%"  editable="false">
                            <option value="">请选择</option>
                            <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(5,5)" id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%">
                        专项填报任务名称
                    </td>
                    <td class="editTd" style="width:32%">
                        <s:textfield cssClass="noborder" name="reportKeyRiskMonitor.start_name" cssStyle="width:80%" maxlength="50"/>
                    </td>
                    <td class="EditHead">
                        填报时间
                    </td>
                    <td class="editTd">
                        <input type="text" class="easyui-datebox" name="reportKeyRiskMonitor.start_time"  style="width: 40%" title="单击选择日期"	editable="false" /> 至
                        <input type="text" Class="easyui-datebox" style="width: 40%"
                               name="reportKeyRiskMonitor.end_time" title="单击选择日期"
                               editable="false" />
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
<div region="center" border='0'>
    <table id="projectList"></table>
</div>
<div id="myDiv01" style="float:center">
    <s:form id="myForm01">
        <s:hidden name="reportKeyRiskMonitor.formId" id="reportKeyRM_id"></s:hidden>
        <s:hidden name="reportKeyRiskMonitor.dutyDeptId" id="reportKeyRM_dutyDeptId"></s:hidden>
        <s:hidden name="type" id="type"></s:hidden>
        <table cellpadding=1 cellspacing=1 border=0 class="ListTable">
            <tr>
                <td ></td>
                <td class="EditHead"><font color="red">*</font>分发填报单位</td>
                <td class="editTd">
                    <s:buttonText2 id="impDeptName" hiddenId="impDept" cssClass="noborder"
                                   name="reportKeyRiskMonitor.impDeptName"
                                   hiddenName="reportKeyRiskMonitor.impDept"
                                   doubleOnclick="getEvaluateDep(this)"
                                   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                   doubleCssStyle="cursor:pointer;border:0"
                                   readonly="true"
                                   title="分发填报单位" maxlength="100"/>
                </td>
            </tr>
        </table>
    </s:form>
    <div style="text-align:center;margin-top:10px;margin-bottom:10px;padding-right:18px;">
        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="adjust01();">确定</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWin01();">关闭</a>
    </div>
</div>

<script type="text/javascript">
    /*
        * 查询
        */
    function doSearch(){
        datagrid.datagrid('options').queryParams = form2Json('myform');
        datagrid.datagrid('reload');
        $('#dlgSearch').dialog('close');
    }
    /**
     重置
     */
    function restal(){
        resetForm('myform');
       // doSearch();
    }
    /*
        * 取消
        */
    function doCancel(){
        $('#dlgSearch').dialog('close');
    }
    var datagrid;
    $(function () {
        var bodyW = $('body').width();
        showWin('dlgSearch');
        datagrid = $('#projectList').datagrid({
            url:"<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/listReportKeyRiskMonitor.action?querySource=grid",
            method:'post',
            showFooter:false,
            rownumbers:true,
            pagination:true,
            striped:true,
            autoRowHeight:false,
            fit: true,
            pageSize: 20,
            singleSelect:true,
            fitColumns:true,
            idField:'formId',
            border:false,
            remoteSort: true,
            toolbar:[{
                id:'search',
                text:'查询',
                iconCls:'icon-search',
                handler:function(){
                    searchWindShow('dlgSearch',800);
                }
            },'-',helpBtn
                /*,'-',
                {
                    text:'分发填报单位',
                    iconCls:'icon-add',
                    handler:function() {
                        var rows = $('#projectList').datagrid('getSelections');
                        if(rows.length > 0) {
                            if((rows[0].impDeptName == '' || rows[0].impDeptName == null) && rows[0].status != '030') {
                                $('#reportKeyRM_id').val(rows[0].id);
                                $('#reportKeyRM_dutyDeptId').val(rows[0].dutyDeptId);
                                $('#type').val('1');
                                $('#myDiv01').window('open');
                            } else {
                                showMessage1('请选择分发填报单位为空的填报中数据！');
                            }
                        } else {
                            showMessage1('请选择数据！');
                        }
                    }
                }*/
            ],
            onLoadSuccess:function(){
                initHelpBtn();
            },
            frozenColumns:[[
                {field:'status_name',
                    title:'填报状态',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    width:0.08*bodyW + 'px'
                },
                {field:'start_name',
                    title:'专项填报任务名称',
                    halign:'center',
                    width:0.15*bodyW + 'px',
                    sortable:true,
                    align:'left'/*,
                    formatter:function(value,rowData,rowIndex){
                        return "<a href='#' onclick=\"view('" + rowData.year + "','"+rowData.dutyDeptId+"','"+rowData.formId+"')\">" + rowData.start_name + "</a>";
                    }*/
                },

            ]],
            columns:[[
                {field:'sn',title:'编号',halign:'center',align:'center',sortable:true, width:0.1*bodyW + 'px'},
                {field:'year',title:'年度',width:0.05*bodyW + 'px',sortable:true,halign:'center',align:'center'},
                {field:'taskType',
                    title:'任务类型',
                    width:0.08*bodyW + 'px',
                    halign:'center',
                    align:'center',
                    sortable:true
                },
                {field:'impDeptName',
                    title:'发起单位部门',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    width:0.1*bodyW + 'px'
                },
                {field:'impPersonName',
                    title:'发起人',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    width:0.08*bodyW + 'px'
                },
                {field:'start_time',
                    title:'填报开始时间',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    width:0.08*bodyW + 'px',
                    formatter:function(value,rowData,rowIndex){
                        if (value != null &&  value.length >9  ){
                            return value.substring(0,10);
                        }
                    }

                },
                {field:'end_time',
                    title:'填报截止时间',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    width:0.08*bodyW + 'px',
                    formatter:function(value,rowData,rowIndex){
                        if (value != null &&  value.length >9  ){
                            return value.substring(0,10);
                        }
                    }
                },
                {field:'rework_closed',
                    title:'操作',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    width:0.1*bodyW + 'px',
                    formatter:function(value,rowData,rowIndex){
                        if(rowData.status == '010' || rowData.status == '000' ){
                            var param = [rowData.year,rowData.dutyDeptId,rowData.formId];
                            var btn2 = "填报,edit,"+param.join(',');
                            return ganerateBtn(btn2);
                        }else if(rowData.status == '020'||rowData.status=='030'){
                            var param = [rowData.year,rowData.dutyDeptId,rowData.formId];
                            var btn2 = "查看,viewre,"+param.join(',');
                            return ganerateBtn(btn2);
                        }

                    }
                }
            ]]
        });
        //单元格tooltip提示
        $('#projectList').datagrid('doCellTip', {
            onlyShowInterrupt:true,
            position : 'bottom',
            maxWidth : '200px',
            tipStyler : {
                'backgroundColor' : '#EFF5FF',
                borderColor : '#95B8E7',
                boxShadow : '1px 1px 3px #292929'
            }

        });
        $('#myDiv01').window({
            title:'分发填报单位',
            width:600,
            height:200,
            closed:true
        });
    });
    function edit(year, dutyDeptId,formId) {
        var url = "${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/edit.action?from=${from}&crudId="+formId;
        window.location.href=url;
    }
    function view(year, dutyDeptId,formId) {
        var url = "${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/view.action?from=${from}&formId="+formId;
        aud$openNewTab('查看', url, true);
    }
    function viewre(year, dutyDeptId,formId) {
        var url = "${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/viewre.action?from=${from}&formId="+formId;
        aud$openNewTab('查看', url, true);
    }
    function closeWin01() {
        $('#myDiv01').window('close');
    }
    function adjust01() {
        var obj = $('#projectList').datagrid('getSelections');
        var id = obj[0].formId;
        if(audEvd$validateform('myForm01')) {
            $.ajax({
                url:'${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/addEvDepartment.action?formId='+id,
                type:'post',
                async:false,
                data:$('#myForm01').serialize(),
                success:function(data){
                    if(data == '1') {
                        showMessage1('分配具体填报单位成功！');
                        $('#myDiv01').window('close');
                        $('#projectList').datagrid('reload');
                    } else {
                        showMessage1('分配失败！');
                    }
                }
            });
        }
    }
    function getEvaluateDep(asd) {
        showSysTree(asd,
            {
                title:'填报单位',
                cache:false,
                param:{
                    'serverCache':false,
                    'rootParentId':$('#reportKeyRM_dutyDeptId').val(),
                    'beanName':'UOrganization',
                    // 'whereHql':'ftype=\'D\'',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode',
                },
                onAfterSure:function(){
                },
                checkbox:true,
                cache:false
            });
    }
</script>
</body>
</html>
