<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>通知公告列表</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="searchForm" name="searchForm" action="searchStudyGarden" namespace="/portal/simple/information" method="post">
            <s:token/>
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr >
                    <td class="EditHead" style="width: 15%;">标题</td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:80%;"  name="studyGardenPlot.title" maxlength="50" />
                    </td>
                    <td class="EditHead" style="width: 15%;">关键字</td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:80%;"  name="studyGardenPlot.keyword" maxlength="50" />
                    </td>

                </tr>
            </table>
        </s:form>
    </div>
    <div class="serch_foot">
        <div class="search_btn" style="text-align: center;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
        </div>
    </div>
</div>
<div region="center" border='0'>
    <table id="infoList"></table>
</div>
<script type="text/javascript">
    function freshGrid(){
        $('#dlgSearch').dialog('open');
    }
    /*
     * 查询
     */
    function doSearch(){
        $('#infoList').datagrid({
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
        //doSearch();
    }
    $(function(){
        var bodyW = $('body').width();
        //查询
        showWin('dlgSearch');
        var d = new Date();
        // 初始化生成表格
        $('#infoList').datagrid({
            url : "<%=request.getContextPath()%>/portal/simple/information/searchStudyGarden.action?grid=grid&t="+new Date().getTime() ,
            method:'post',
            showFooter:false,
            rownumbers:true,
            pagination:true,
            striped:true,
            autoRowHeight:false,
            fit: true,
            pageSize: 20,
            fitColumns:true,
            idField:'id',
            border:false,
            toolbar:[{
                id:'search',
                text:'查询',
                iconCls:'icon-search',
                handler:function(){
                    searchWindShow('dlgSearch',750);
                }
            }
            <s:if test="${view ne 'view'}">
            ,'-',{
                    id:'newInfo',
                    text:'新增',
                    iconCls:'icon-add',
                    handler:function(){
                        window.location.href = '${contextPath}/portal/simple/information/editStudyGarden.action';
                    }
                },'-',
/*                {
                    id:'modify',
                    text:'修改',
                    iconCls:'icon-edit',
                    handler:function(){
                        editStudyGarden();
                    }
                },'-',*/
                {
                    id:'delete',
                    text:'删除',
                    iconCls:'icon-delete',
                    handler:function(){
                        deleteStudyGardens();
                    }
                },'-',helpBtn
                </s:if>
            ],
            onLoadSuccess:function(){
                if('${view}' != 'view') {
                    initHelpBtn();
                }
            },
            onClickCell:function(rowIndex, field, value) {
                if(field == 'title') {
                    var rows = $('#infoList').datagrid('getRows');
                    var row = rows[rowIndex];
                    if(row.creator_code == '${user.floginname}') {
                        window.location.href = '${contextPath}/portal/simple/information/editStudyGarden.action?studyGardenPlot.id='+row.id;
                    } else {
                        var url = '${contextPath}/portal/simple/information/viewStudyGarden.action?studyGardenPlot.id='+row.id;
                        aud$openNewTab(row.title,url,true);
                    }
                }
            },
            frozenColumns:[[
                <s:if test="${view ne 'view'}">
                {field:'id',checkbox:true,title:'主键'},
                </s:if>
                {field:'title',
                    title:'标题',
                    width:0.3*bodyW + 'px',
                    sortable:true,
                    halign:'center',
                    align:'left',
                    formatter:function(value,row,index){
                        debugger;
                        var result = '';
                        if(row.creator_code == '${user.floginname}') {
                            result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
                        } else {
                            result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
                        }
                        return result;
                    }
                }
            ]],
            columns:[[
                {field:'keyword',
                    title:'关键字',
                    width:0.4*bodyW + 'px',
                    sortable:true,
                    halign:'center',
                    align:'left'
                },
                {field:'create_date',
                    title:'创建时间',
                    width:0.1*bodyW + 'px',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    formatter:function(value,row,index){
                        return value.substring(0,10);
                    }
                },
                {field:'creator_name',
                    title:'创建人',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    width:0.1*bodyW + 'px'
                }
            ]]
        });
        //单元格tooltip提示
        $('#infoList').datagrid('doCellTip', {
            onlyShowInterrupt: true,
            position : 'bottom',
            maxWidth : '200px',
            tipStyler : {
                'backgroundColor' : '#EFF5FF',
                borderColor : '#95B8E7',
                boxShadow : '1px 1px 3px #292929'
            }
        });
    });

    /**
     * 编辑通知公告
     */
    function editStudyGarden(){
        var rows = $('#infoList').datagrid('getChecked');
        if(rows.length == 0||rows.length > 1){
            showMessage2('请选择一条数据修改','错误',null,null);
        }else if(rows[0].creator_code != '${user.floginname}'){
            showMessage2('非本人创建的内容不可修改','错误',null,null);
        }else{
            window.location.href = '${contextPath}/portal/simple/information/editStudyGarden.action?studyGardenPlot.id='+rows[0].id;
        }

    }


    /**
     * 删除通知公告
     */
    function deleteStudyGardens(){
        var rows = $('#infoList').datagrid('getChecked');
        if(rows.length > 0){
            var ids = [];
            var canDel = true;
            for(var i = 0;i<rows.length;i++){
                if('${user.floginname}'!=rows[i].creator_code){
                    canDel = false;
                    break;
                }else{
                    ids.push(rows[i].id);
                }

            }
            if(canDel){
                top.$.messager.confirm('确认','确定要删除选择的记录吗？',function(r){
                    if(r){
                        $.ajax({
                            url:'${contextPath}/portal/simple/information/deleteStudyGardens.action',
                            type:'post',
                            data:{
                                'infoIds':ids.join(',')
                            },
                            success:function(data){
                                if(data == 'true'){
                                    showMessage2('操作成功！','成功',null,null);
                                    $('#infoList').datagrid('reload');
                                }else{
                                    showMessage2('操作失败，请刷新页面重试','错误',null,null);
                                }
                            }
                        });
                    }
                });
            }else{
                showMessage2('记录中包含非本人创建的内容','错误',null,null);
            }
        }else{
            showMessage2('请至少选择一条记录','错误',null,null);
        }

    }
</script>
</body>
</html>
