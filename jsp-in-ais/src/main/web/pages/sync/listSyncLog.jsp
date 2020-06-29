<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>一体化日志列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript">
        /*
		* 查询
		*/
        function doSearch(){
            $('#list').datagrid({
                queryParams:form2Json('searchForm')
            });
            $('#dlgSearch').dialog('close');
        }
        /*
		* 取消
		*/
        function doCancel(){
            $('#dlgSearch').dialog('close');
        }
        /**
         重置
         */
        function restal(){
            resetForm('searchForm');
        }
        /*
        重新同步
         */
        function reSync(guid) {
            $.ajax({
                dataType:'json',
                url:"<%=request.getContextPath()%>/sync/redoOneSyncLog.action?guid="+guid,
                type:"POST",
                success:function(data){
                    showMessage1(data.msg);
                    $('#list').datagrid('reload');
                }
            });
        }

        function validateDel(ids,idsLength){
            $.messager.confirm('确认','确认删除这'+idsLength+'条数据吗？',function(flag){
                if(flag){
                    $.ajax({
                        url : '${pageContext.request.contextPath}/sync/delete.action',
                        type : "POST",
                        data : {"ids" : ids},
                        success : function(){
                            showMessage1('删除成功！');
                            window.location.reload();
                        }
                    });
                }
            });
        }

    </script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">

    <div region="center" >
        <table id="list"></table>
    </div>
    <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />

    <div id="dlgSearch" class="searchWindow">
        <div class="search_head">
            <input type="hidden" name="listStatus" value="${listStatus}" id="listStatus"/>
            <s:form namespace="/sync" action="listSyncLog" id="searchForm" name="searchForm">
                <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                    <tr >
                        <td class="EditHead" style="width:15%">
                            类型
                        </td>
                        <td class="editTd" style="width:35%">
                            <select class="easyui-combobox" id="type" editable="false" name="syncLog.type" style="width:150px;" panelHeight="auto">
                                <option value="">请选择</option>
                                <s:iterator value='#@java.util.LinkedHashMap@{"user":"用户","group":"机构","bsdw":"被审单位","project":"项目"}'>
                                    <option value="<s:property value="key"/>"> <s:property value="value"/></option>
                                </s:iterator>
                            </select>
                        </td>
                        <td class="EditHead" style="width:15%">
                            动作
                        </td>
                        <td class="editTd" style="width:35%">
                            <select class="easyui-combobox" id="action" editable="false" name="syncLog.action" style="width:150px;" panelHeight="auto">
                                <option value="">请选择</option>
                                <s:iterator value='#@java.util.LinkedHashMap@{"add":"增加","edit":"修改","delete":"删除"}'>
                                    <option value="<s:property value="key"/>"> <s:property value="value"/></option>
                                </s:iterator>
                            </select>
                        </td>
                    </tr>
                    <tr >
                        <td class="EditHead" style="width:15%">
                            同步结果
                        </td>
                        <td class="editTd" style="width:35%">
                            <select class="easyui-combobox" id="success" editable="false" name="syncLog.success" style="width:150px;" panelHeight="auto">
                                <option value="">请选择</option>
                                <s:iterator value='#@java.util.LinkedHashMap@{"1":"成功","0":"失败"}'>
                                    <option value="<s:property value="key"/>"> <s:property value="value"/></option>
                                </s:iterator>
                            </select>
                        </td>
                        <td class="EditHead" style="width:15%">
                        </td>
                        <td class="editTd" style="width:35%">
                        </td>
                    </tr>
                </TABLE>
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
        $(function(){
            var bodyW = $('body').width();
            //初始化生成表格
            $('#list').datagrid({
                url : "<%=request.getContextPath()%>/sync/listSyncLog.action?querySource=grid",
                method:'post',
                showFooter:false,
                rownumbers:true,
                pagination:true,
                striped:true,
                autoRowHeight:false,
                fit: true,
                pageSize:10,
                pageList: [10,15,20],
                fitColumns: true,
                idField:'guid',
                border:false,
                singleSelect:false,
                toolbar:[{
                    id:'search',
                    text:'查询',
                    iconCls:'icon-search',
                    handler:function(){
                        searchWindShow('dlgSearch',750,350);
                    }
                }, {
                    id: 'delete',
                    text: '删除',
                    iconCls: 'icon-delete',
                    handler:function(){
                        var ids = new Array();
                        var rows = $("#list").datagrid('getChecked');
                        for(i in rows) {
                            if(typeof rows[i].guid != 'undefined') {
                                ids.push(rows[i].guid);
                            }
                        }
                        if(rows.length > 0) {
                            validateDel(ids.join(","),rows.length);
                        } else {
                            showMessage1("请选择数据！");
                        }
                    }
                },{
                    id:'yhjgReload',
                    text:'用户机构同步',
                    iconCls:'icon-reload',
                    handler:function(){
                        var msg = "同步用户机构会删除所有数据，确认同步吗？";
                        $.messager.confirm("确认",msg,function(flag){
                            if(flag){
                                $.ajax({
                                    url:"<%=request.getContextPath()%>/sync/yhjgReloadToNC.action",
                                    type:'post',
                                    cache:false,
                                    async:true,
                                    dataType:'json',
                                    success:function(data){
                                        frloadClose();
                                        showMessage1(data.msg);
                                    }
                                });
                                frloadOpen();
                            }else{
                                return false;
                            }
                        })
                    }
                },{
                    id:'bsdwReload',
                    text:'被审单位同步',
                    iconCls:'icon-reload',
                    handler:function(){
                        var msg = "同步被审单位会删除所有数据，确认同步吗？";
                        $.messager.confirm("确认",msg,function(flag){
                            if(flag){
                                $.ajax({
                                    url:"<%=request.getContextPath()%>/sync/bsdwReloadToNC.action",
                                    type:'post',
                                    cache:false,
                                    dataType:'json',
                                    success:function(data){
                                        frloadClose();
                                        showMessage1(data.msg);
                                    }
                                });
                                frloadOpen();
                            }else{
                                return false;
                            }
                        })
                    }
                },{
                    id:'sjxmReload',
                    text:'审计项目同步',
                    iconCls:'icon-reload',
                    handler:function(){
                        var msg = "同步审计项目会删除所有数据，确认同步吗？";
                        $.messager.confirm("确认",msg,function(flag){
                            if(flag){
                                $.ajax({
                                    url:"<%=request.getContextPath()%>/sync/sjxmReloadToNC.action",
                                    type:'post',
                                    cache:false,
                                    dataType:'json',
                                    success:function(data){
                                        frloadClose();
                                        showMessage1(data.msg);
                                    }
                                });
                                frloadOpen();
                            }else{
                                return false;
                            }
                        })
                    }
                }
                ],
                frozenColumns:[[
                    {field:'guid',checkbox:true, align:'center',title:'选择'},
                ]],
                columns:[[
                    {
                        field: 'action',
                        title: '动作',
                        width: bodyW * 0.06 + 'px',
                        halign: 'center',
                        align: 'center',
                        sortable: true,
                        formatter:function(value,row,rowIndex){
                            if (value=='add'){return "增加";}
                            if (value=='edit'){return "修改";}
                            if (value=='delete'){return "删除";}
                        }
                    },
                    {
                        field: 'type',
                        title: '类型',
                        width: bodyW * 0.06 + 'px',
                        halign: 'center',
                        align: 'center',
                        sortable: true,
                        formatter:function(value,row,rowIndex){
                            if (value=='user'){return "用户";}
                            if (value=='group'){return "机构";}
                            if (value=='bsdw'){return "被审单位";}
                            if (value=='project'){return "项目";}
                        }
                    },
                    {
                        field: 'pk',
                        title: '实体Id',
                        width: bodyW * 0.23 + 'px',
                        halign: 'center',
                        align: 'center',
                        sortable: true
                    },
                    {
                        field: 'success',
                        title: '同步结果',
                        width: bodyW * 0.06 + 'px',
                        halign: 'center',
                        align: 'center',
                        sortable: true,
                        formatter:function(value,row,rowIndex){
                            if (value=='1'){return "成功";}
                            if (value=='0'){return "失败";}
                        }
                    },
                    {
                        field: 'msg',
                        title: '信息',
                        width: bodyW * 0.3 + 'px',
                        halign: 'center',
                        align: 'center',
                        sortable: false
                    },
                    {
                        field: 'updateTime',
                        title: '记录更新时间',
                        width: bodyW * 0.1 + 'px',
                        halign: 'center',
                        align: 'center',
                        sortable: false
                    },
                    {field:'operate',
                        title:'操作',
                        width: bodyW * 0.06 + 'px',
                        halign:'center',
                        align:'center',
                        sortable:true,
                        formatter:function(value,rowData,rowIndex){
                            if(rowData.success == "0"){
                                return  '<a href=\"javascript:void(0)\" onclick=\"reSync(\''+rowData.guid +'\');\">重新同步</a>';
                            }
                        }
                    }
                ]]
            });
            showWin('dlgSearch');
        });


    </script>
</body>
</html>
