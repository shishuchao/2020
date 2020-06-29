<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>待办事项</title>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
    <script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript">
        $(function(){
            var gridTableId = "SpAccountList";
            var g1 = new createQDatagrid({
                // 表格dom对象，必填
                gridObject:$('#'+gridTableId)[0],
                // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
                boName:'SpAccount',
                // 对象主键,删除数据时使用-默认为“id”；必填
                pkName:'said',
                whereSql:'currentUserId=\'${currentUser}\'',
                order :'desc',
                /*sort  :'createTime',*/
                winWidth:800,
                winHeight:250,
                // 删除前的校验，如果返回true可以删除，否则为false
                beforeRemoveRowsFn:function(rows, datagridObj){
                    return true;
                },
                //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
                myToolbar:[],
                // 表格控件dataGrid配置参数; 必填
                gridJson:{
                    singleSelect:false,
                    checkOnSelect:false,
                    selectOnCheck:false,
                    columns:[[
                        {field:'apName',title:'项目名称', width:'30%',align:'center',   halign:'center',  sortable:true, oper:'like'},
                        {field:'type', title:'任务名称', width:'30%',align:'center', halign:'center',  sortable:true, show:false,
                            formatter:function(value,row,index){
                                if(row.type=="account"){
                                    value="审计台账";
                                }else{
                                    value="审计报告";
                                }
                                return value;
                            }},
                        {field:'currentUser',title:'上一步处理人', width:'20%',align:'center', halign:'center',  sortable:true, show:false},
                        {field:'operation',title:'操作', width:'15%',align:'center', halign:'center',sortable:true, show:false,
                            formatter:function(value,row,index){
                                var result;
                                if(row.type=="account"){
                                    result ="<a href='javascript:;' onclick=\"parent.parent.goMenu('台账处理','${contextPath}/ea/audAccount/initPage.action?apId="+row.apId+"','2')\">处理</a>";
                                }else{
                                   result ="<a href='javascript:;' onclick=\"parent.goMenu('审计报告处理','${contextPath}/ea/audAccount/initClusionPage.action?apId="+row.apId+"','2')\">处理</a>"
                                }
                                return result;
                            }}
                    ]]
                }
            });

            window.tenderInfoList = g1;
        });
    </script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
<table id='SpAccountList'></table>

<!-- 引入公共文件 -->
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>