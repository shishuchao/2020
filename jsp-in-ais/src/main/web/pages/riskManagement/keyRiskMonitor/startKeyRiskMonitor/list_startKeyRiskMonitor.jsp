<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>发起专项填报任务</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="myform" name="myform" action="startKeyRiskMonitorList.action" namespace="/riskManagement/keyRiskMonitor/startKeyRiskMonitor" method="post">
            <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td class="EditHead" style="width:20%">
                        编号
                    </td>
                    <td class="editTd" style="width:33%">
                        <s:textfield cssClass="noborder" name="keyRiskMonitor.start_code" cssStyle="width:80%" maxlength="50"/>
                    </td>
                    <td class="EditHead">
                        年度
                    </td>
                    <td class="editTd">
                        <select class="easyui-combobox" name="keyRiskMonitor.year" id="pro_year" style="width:80%"  editable="false">
                            <option value="">请选择</option>
                            <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(5,5)" id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%">
                        专项填报任务
                    </td>
                    <td class="editTd" style="width:32%">
                        <s:textfield cssClass="noborder" name="keyRiskMonitor.start_name" cssStyle="width:80%" maxlength="50"/>
                    </td>
                    <td class="EditHead">
                        填报时间
                    </td>
                    <td class="editTd">
                        <input type="text" class="easyui-datebox" name="keyRiskMonitor.start_time"  style="width: 40%" title="单击选择日期"	editable="false" /> 至
                        <input type="text" Class="easyui-datebox" style="width: 40%"
                               name="keyRiskMonitor.end_time" title="单击选择日期"
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
<%--<div id="myDiv" style="float:center" >
    <table cellpadding=1 cellspacing=1 border=0 class="ListTable">
        <tr>
            <td class="EditHead"><font color="red">*</font>截止日期(调整)</td>
            <td class="editTd">
                <input type="text" id="endTime" class="easyui-datebox" editable="false"/>

            </td>
            <s:hidden name="timeFormId" id="timeFormId"/>
        </tr>
    </table>
    <div style="text-align:right;margin-top:10px;margin-bottom:10px;padding-right:18px;">
        <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="sureWin();">确定</a>
        <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWin();">关闭</a>
    </div>
</div>--%>

<script type="text/javascript">
    /**
     * 查询
     */
    function doSearch(){
        datagrid.datagrid('options').queryParams = form2Json('myform');
        datagrid.datagrid('reload');
        $('#dlgSearch').dialog('close');
    }
    /**
     * 重置
     */
    function restal(){
        resetForm('myform');
        //doSearch();
    }
    /**
     * 取消
     */
    function doCancel(){
        $('#dlgSearch').dialog('close');
    }
    var datagrid;
    $(function () {
        var bodyW = $('body').width();
        showWin('dlgSearch');
        //初始化生成表格
        datagrid = $('#projectList').datagrid({
            url:"<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/startKeyRiskMonitor/startKeyRiskMonitorList.action?view=${view}&querySource=grid",
            method:'post',
            showFooter:false,
            rownumbers:true,
            singleSelect:true,
            pagination:true,
            striped:true,
            autoRowHeight:false,
            fit: true,
            pageSize: 20,
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
            },'-',{
                id:'toadd',
                text:'新增',
                iconCls:'icon-add',
                handler:function(){
                    addInfo();
                }
            },'-',{
                id:'toDelete',
                text:'删除',
                iconCls:'icon-delete',
                handler:function(){
                    deleteInfo();
                }
            },'-',helpBtn
            ],
            onLoadSuccess:function(){
                initHelpBtn();
            },
            onClickCell:function(rowIndex, field, value) {
                if(field == 'start_name') {
                    var rows = $('#projectList').datagrid('getRows');
                    var row = rows[rowIndex];
                    if(row.status&&row.status=='010') {
                        var url = '${contextPath}/riskManagement/keyRiskMonitor/startKeyRiskMonitor/edit.action?formId='+row.formId;
                        infoBttn(url);
                    } else {
                        var viewUrl = '${contextPath}/riskManagement/keyRiskMonitor/startKeyRiskMonitor/view.action?view=${view}&formId='+row.formId;
                        infoBttnView(viewUrl);
                    }
                }
            },
            frozenColumns:[[
                {field:'status_name',
                    title:'填报状态',
                    halign:'center',
                    align:'center',
                    width:0.08*bodyW + 'px',
                    sortable:true
                },
                {field:'start_name',
                    title:'专项填报任务名称',
                    halign:'center',
                    align:'left',
                    width:0.15*bodyW + 'px',
                    sortable:true,
                    formatter:function(value,rowData,index){
                        var result;
                        if(rowData.status=='010') {
                            result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
                        } else {
                            result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
                        }
                        return result;
                    }
                }
            ]],
            columns:[[
                {field:'start_code',title:'编号',halign:'center',align:'center',sortable:true, width:0.08*bodyW + 'px'},
                {field:'year',title:'年度',width:0.05*bodyW + 'px',sortable:true,halign:'center',align:'center'},
                {field:'taskType',
                    title:'任务类型',
                    width:0.08*bodyW + 'px',
                    halign:'center',
                    align:'center',
                    sortable:true
                },
                {field:'dutyDeptName',
                    title:'填报单位',
                    width:0.15*bodyW + 'px',
                    halign:'center',
                    align:'left',
                    sortable:true
                },
                {field:'applicant_name',
                    title:'填报人',
                    width:0.08*bodyW + 'px',
                    halign:'center',
                    align:'left',
                    sortable:true
                },
                {field:'start_time',
                    title:'填报开始时间',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    width:0.08*bodyW + 'px',
                    formatter:function(value,rowData,rowIndex){
                        if (value != null && value.length >9  ){
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
                }/*,
                {field:'rework_closed',
                    title:'操作',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    width:0.13*bodyW + 'px',
                    formatter:function(value,rowData,rowIndex){
                        var re = "";
                        var url = '${contextPath}/riskManagement/keyRiskMonitor/startKeyRiskMonitor/edit.action?formId='+rowData.formId;
                        var viewUrl = '${contextPath}/riskManagement/keyRiskMonitor/startKeyRiskMonitor/view.action?view=${view}&formId='+rowData.formId;
                        if(rowData.status == '010' && "${view}" != 'view'){
                            re =  "<a href=\"javaScript:void(0)\" onclick=\"infoBttn('"+url+"')\" >修改</a>";
                        }else{
                            re =  "<a href=\"javaScript:void(0)\" onclick=\"infoBttnView('"+viewUrl+"')\" >查看反馈</a>";
                        }
                        if(rowData.status_name == '填报中'){
                            var curTime = new Date();
                            curTime.setDate(curTime.getDate() - 1);
                            var end_time = new Date(rowData.end_time);
                        }
                        return re;
                    }
                }*/
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
        /*$('#myDiv').window({
            title:'延期',
            width:600,
            height:170,
            closed:true
        });*/
    });

    function infoBttn(u){
        window.location.href= u;
    }

    function refresh(){
        $("#projectList").datagrid('reload');
    }

    function infoBttnView(u){
        aud$openNewTab('查看',u,true);
    }

    /* 新增 */
    function addInfo(){
        window.location.href = "${contextPath}/riskManagement/keyRiskMonitor/startKeyRiskMonitor/edit.action";
    }

    /* 删除信息 */
    function deleteInfo(){
        var rows = $("#projectList").datagrid("getSelections");
        if (rows.length < 1){
            $.messager.show({
                title:'提示消息',
                msg:'请选择一条记录！'
            })
            return false;
        }
        var formIds = "";
        var check = false;
        for(var i=0;i<rows.length;i++){
            formIds += rows[i].formId+",";
            if ( rows[i].status != "010"){
                check = true;
            }
        }
        if (check){
            $.messager.show({
                title:'提示消息',
                msg:'【填报中及已完成】状态不可删除，只可删除【草稿】状态'
            })
            return false;
        }
        top.$.messager.confirm('提示信息','确定删除吗？',function(r){
            if (r){
                $.ajax({
                    url:'{contextPath}/riskManagement/keyRiskMonitor/startKeyRiskMonitor/deleteInfo.action?formIds='+formIds,
                    type:'post',
                    async:false,
                    success:function(data){
                        if (data == "1"){
                            top.$.messager.show({
                                title:'提示消息',
                                msg:'删除成功！'
                            })
                            $("#projectList").datagrid("reload");
                        }else{
                            top.$.messager.show({
                                title:'提示消息',
                                msg:'删除出错！'
                            })
                        }
                    }
                })
            }
        })

    }

    function delay(end_time,id) {
        $('#endTime').datebox('setValue',end_time);
        $('#timeFormId').val(id);
        $('#myDiv').window('open');
    }

    function closeWin(){
        $('#myDiv').window('close');
    }

    function sureWin(){
        var endTime = $('#endTime').datebox('getValue');
        var timeFormId = $("#timeFormId").val();
        if(endTime != '') {
            $.ajax({
                url:'',
                type:'post',
                async:false,
                data:{'end_time':endTime,'timeFormId':timeFormId},
                success:function(data) {
                    if(data == '1') {
                        showMessage1('延期成功');
                        $('#myDiv').window('close');
                        window.location.reload();
                    }
                }
            });

        }else{
            showMessage1('请选择截止日期！');
        }

    }
</script>

</body>
</html>
