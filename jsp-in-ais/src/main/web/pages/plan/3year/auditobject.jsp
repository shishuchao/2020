<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>三年计划列表</title>
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
    //查询
    showWin('dlgSearch');
    // 初始化生成表格
    $('#auditObjectList').datagrid({
        url : "<%=request.getContextPath()%>/plan/3year/queryCoverUncoverAuditObject.action?querySource=grid",
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
        singleSelect:true,
        remoteSort: false,
        cache:false,
        queryParams:{
          'cover':'1',
          'yearPlanId':'${yearPlanId}'
        },
        toolbar:[{
            id:'search',
            text:'查询',
            iconCls:'icon-search',
            handler:function(){
                searchWindShow('dlgSearch',750);
            }
        }],
        columns:[[
            {field:'name',
                title:'被审计单位名称',
                width:300,
                halign:'center',
                align:'left',
                sortable:true
            },
            {field:'currentCode',
                title:'被审计单位编码',
                width:200,
                sortable:true,
                halign:'center',
                align:'left'
            }
        ]]
    });
});

/*
* 查询
*/
function doSearch(cover){
    if(cover){
        $('#cover').val(cover);
    }
    var centerPanel = $('#layer').layout('panel',"center");
    if(cover == '0'){
        centerPanel.panel('setTitle','未覆盖单位列表');
    }else{
        centerPanel.panel('setTitle','已覆盖单位列表');
    }
    $('#auditObjectList').datagrid({
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
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" id="layer">
    <div id="dlgSearch" class="searchWindow">
        <div class="search_head">
            <s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
                <s:token/>
                <s:hidden name="cover" id="cover"/>
                <s:hidden name="yearPlanId" id="yearPlanId" value="${yearPlanId}"/>
                <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                    <tr>
                        <td class="EditHead" >被审计单位名称</td>
                        <td class="editTd">
                            <s:textfield cssClass="noborder" cssStyle="width:80%;" name="audit_object_name" maxlength="50" />
                        </td>
                        <td id="w_charge_number_name" class="EditHead" style="width:20%;">被审计单位编码</td>
                        <td class="editTd" style="width:30%;" >
                            <s:textfield cssClass="noborder" cssStyle="width:80%;"  name="currentCode" maxlength="50" />
                        </td>
                    </tr>
                </table>
            </s:form>
        </div>
        <div class="serch_foot">
            <div class="search_btn" style="text-align: right;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
            </div>
        </div>
    </div>
    <div region="west" title="三年计划覆盖情况" style="width: 240px;" split="false">
        <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="margin-top: 40px;">
            <tr>
                <td class="editTd" style="text-align: right;border: none;width: 60%;">已覆盖单位数：</td>
                <td class="editTd" style="border: none;width: 40%;">
                    <a href="javascript:;" onclick="doSearch('1')">${covered}家</a>
                </td>
            </tr>
            <tr>
                <td class="editTd" style="text-align: right;border: none;">未覆盖单位数：</td>
                <td class="editTd" style="border: none;">
                    <a href="javascript:;" onclick="doSearch('0')">${uncovered}家</a>
                </td>
            </tr>
            <tr>
                <td class="editTd" style="text-align: right;border: none;">单位数量覆盖率：</td>
                <td class="editTd" style="border: none;">
                    ${coverRate}
                </td>
            </tr>
        </table>
    </div>
    <div region="center" title="已覆盖单位列表">
        <table id='auditObjectList'></table>
    </div>

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>