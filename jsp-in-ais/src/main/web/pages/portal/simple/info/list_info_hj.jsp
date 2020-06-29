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
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="searchForm" name="searchForm" action="searchInfo" namespace="/portal/simple/information" method="post">
            <s:token/>
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr >
                    <td class="EditHead" style="width: 15%;">标题</td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:80%;"  name="information.title" maxlength="50" />
                    </td>
                    <td class="EditHead" style="width: 15%;">关键字</td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:80%;"  name="information.infkey" maxlength="50" />
                    </td>

                </tr>
                <tr >
                    <td class="EditHead" style="width: 15%;">
                        类别
                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap">
                        <select class="easyui-combobox" name="information.type">
                            <option value=""></option>
                            <option value="30">审计新闻</option>
                            <option value="31">通知公告</option>
                            <option value="32">工作动态</option>
                            <option value="33">工作研究</option>
                            <option value="34">党建队建</option>
                        </select>
                    </td>
                    <td class="EditHead" style="width: 15%;">
                        状态
                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap">
                        <select class="easyui-combobox" name="information.infstatus">
                            <option value=""></option>
                            <option value="N">未发布</option>
                            <option value="Y">已发布</option>
                        </select>
                    </td>
                    <!--
                    <td class="EditHead" style="width: 15%;">
                        创建时间
                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap" colspan='3'>
                        <input type="text" id="createdate" name="information.createdate"/>
                    </td>
                    -->
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
        //查询
        showWin('dlgSearch');
        var d = new Date();
        // 初始化生成表格
        $('#infoList').datagrid({
            url : "<%=request.getContextPath()%>/portal/simple/information/searchInfo.action?from=${from}&grid=grid&t="+new Date().getTime() ,
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
                ,{
                    id:'newInfo',
                    text:'新增',
                    iconCls:'icon-add',
                    handler:function(){
                        window.location.href = '${contextPath}/portal/simple/information/editInfo.action';
                    }
                },
                {
                    id:'modify',
                    text:'修改',
                    iconCls:'icon-edit',
                    handler:function(){
                        editInfo();
                    }
                },
                {
                    id:'delete',
                    text:'删除',
                    iconCls:'icon-delete',
                    handler:function(){
                        deleteInfos();
                    }
                },
                {
                    id:'batchPublish',
                    text:'批量发布',
                    iconCls:'icon-publish',
                    handler:function(){
                        publishOrUnpublish(true);
                    }
                },
                {
                    id:'batchUnPublish',
                    text:'批量撤销发布',
                    iconCls:'icon-undo',
                    handler:function(){
                        publishOrUnpublish(false);
                    }
                }
                </s:if>
            ],
            frozenColumns:[[
                {field:'id',checkbox:true},
                {
                    field:'title',
                    title:'标题',
                    width:300,
                    sortable:true,
                    halign:'center',
                    align:'left',
                    formatter:function(value,row,index){
                        return '<a href="javascript:;" onclick="parent.goMenu(\''+value+'\',\'${contextPath}/portal/simple/information/viewInfo.action?information.id='+row.id+'\',\'news'+index+'\')">'+value+'</a>';
                    }
                }
            ]],
            columns:[[
                {field:'type',
                    title:'类别',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    formatter:function(value,row,index){
                        if(value=='30'){
                            return '审计新闻';
                        }else if(value == '31'){
                            return '通知公告';
                        }else if(value == '32'){
                            return '工作动态';
                        }else if(value == '33'){
                            return '工作研究';
                        }else if(value == '34'){
                            return '党建队建';
                        }else{
                            return '未知';
                        }
                    }
                },
                {field:'infkey',
                    title:'关键字',
                    width:200,
                    sortable:true,
                    halign:'center',
                    align:'left'
                },
                {field:'infstatus',
                    title:'状态',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    formatter:function(value,row,index){
                        return value == 'Y'?'已发布':'未发布';
                    }
                },
                {field:'createdate',
                    title:'创建时间',
                    width:100,
                    halign:'center',
                    align:'center',
                    sortable:true,
                    formatter:function(value,row,index){
                        return value.substring(0,10);
                    }
                },
                {field:'createManName',
                    title:'创建人',
                    halign:'center',
                    align:'center',
                    sortable:false
                },
                {field:'customSort',
                    title:'优先级',
                    halign:'center',
                    align:'center',
                    sortable:true
                }
            ]]
        });
        //单元格tooltip提示
        $('#infoList').datagrid('doCellTip', {
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
    function editInfo(){
        var rows = $('#infoList').datagrid('getChecked');
        if(rows.length == 0||rows.length > 1){
            showMessage2('请选择一条数据修改','错误',null,null);
        }else if(rows[0].create_man != '${user.floginname}'){
            showMessage2('非本人创建的公告不可修改','错误',null,null);
        }else if(rows[0].infstatus == 'Y'){
            showMessage2('已发布的公告不可修改','错误',null,null);
        }else{
            window.location.href = '${contextPath}/portal/simple/information/editInfo.action?information.id='+rows[0].id;
        }

    }

    /**
     * 批量发布或撤销发布
     * @param isPublish
     */
    function publishOrUnpublish(isPublish){
        var rows = $('#infoList').datagrid('getChecked');
        if(rows.length > 0){
            var ids = [];
            var canDel = true;
            for(var i = 0;i<rows.length;i++){
                if(isPublish&&rows[i].infstatus == 'Y'){
                    canDel = false;
                    break;
                }else if(!isPublish&&rows[i].infstatus == 'N'){
                    canDel = false;
                    break;
                }else if('${user.floginname}'!=rows[i].create_man){
                    canDel = false;
                    break;
                }else{
                    ids.push(rows[i].id);
                }

            }
            if(canDel){
                var msg = isPublish?'确定执行批量发布？':'确定执行批量撤销发布？';
                top.$.messager.confirm('确认',msg,function(r){
                    if(r){
                        $.ajax({
                            url:'${contextPath}/portal/simple/information/publishOrUnpublishInfos.action',
                            type:'post',
                            data:{
                                'infoIds':ids.join(','),
                                'isPublish':isPublish
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
                showMessage2('记录中包含'+(isPublish?'已发布':'未发布')+'或非本人创建的通知公告','错误',null,null);
            }
        }else{
            showMessage2('请至少选择一条记录','错误',null,null);
        }

    }

    /**
     * 删除通知公告
     */
    function deleteInfos(){
        var rows = $('#infoList').datagrid('getChecked');
        if(rows.length > 0){
            var ids = [];
            var canDel = true;
            for(var i = 0;i<rows.length;i++){
                if(rows[i].infstatus == 'Y'||'${user.floginname}'!=rows[i].create_man){
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
                            url:'${contextPath}/portal/simple/information/deleteInfos.action',
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
                showMessage2('记录中包含已发布或非本人创建的通知公告','错误',null,null);
            }
        }else{
            showMessage2('请至少选择一条记录','错误',null,null);
        }

    }
</script>
</body>
</html>
