<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>审计报告查阅</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="searchForm" name="searchForm" action="reportCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
            <s:token/>
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr >
                    <td class="EditHead">
                        项目名称
                    </td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="project_name"  />
                    </td>
                    <td class="EditHead">审计报告名称</td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:160px;"  name="problem_title"  />
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

<div region="center" >
    <table id="resultList"></table>
</div>
<script type="text/javascript">


    /*
    * 查询
    */
    function doSearch(){

        $('#resultList').datagrid({
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
        resetForm("dlgSearch");
        //doSearch();
    }


    $(function(){
        $('#closeWin').bind('click',function(){
            document.getElementById("authorizedName").value = "";
            document.getElementById("authorized").value = "";
            $('#consult_startTime').datebox('setValue', '');
            $('#consult_endTime').datebox('setValue', '');
            $('#project_id').val("");
            $('#projdetailid').val("");
            $('#reportAuthoritySetting_div').window('close');
        });
        $('#saveSetting').bind('click',function(){
            var authorizedName = document.getElementById("authorizedName").value;
            var authorized = document.getElementById("authorized").value;
            if(authorizedName == null || authorizedName == ''){
                showMessage1("请选择授予用户！");
                return false;
            }
            var consult_startTime =  $('#consult_startTime').datebox('getValue');
            if(consult_startTime == null || consult_startTime == ''){
                showMessage1("请填写查看期限！");
                return false;
            }
            var consult_endTime = $('#consult_endTime').datebox('getValue');
            if(consult_endTime == null || consult_endTime == ''){
                showMessage1("请填写查看期限！");
                return false;
            }
            if (!validateDate('consult_startTime','consult_endTime','查看期限')){
                return false;
            }
            var fileIds = document.getElementsByName("fileIds");
            var fileIdsString ="";
            if(fileIds != null && fileIds.length > 0){
                for(var i=0;i<fileIds.length;i++){
                    if(fileIds[i].checked){
                        fileIdsString += fileIds[i].value+",";
                    }
                }
            }
            if(fileIdsString == null || fileIdsString == ''){
                showMessage1("请选择授权文件！");
                return false;
            }
            var createTime = document.getElementById("createTime").value;
            var project_id = document.getElementById("project_id").value;
            var projdetailid = document.getElementById("projdetailid").value;
            $.ajax({
                type: "POST",
                url: "${contextPath}/archives/workprogram/pigeonhole/reportAuthoritySetting.action",
                data: {
                    "projdetailid":projdetailid,
                    "project_id":project_id,
                    "authorized":authorized,
                    "authorizedName":authorizedName,
                    "consult_startTime":consult_startTime,
                    "consult_endTime":consult_endTime,
                    "fileIdsString":fileIdsString,
                    "createTime":createTime
                },
                dataType:"json",
                success: function(data){
                    if(data.msg == '1'){
                        document.getElementById("authorizedName").value = "";
                        document.getElementById("authorized").value = "";
                        $('#consult_startTime').datebox('setValue', '');
                        $('#consult_endTime').datebox('setValue', '');
                        $('#project_id').val("");
                        $('#reportAuthoritySetting_div').window('close');
                        showMessage1("授权成功！");
                    }
                }
            });
        });
        showWin('dlgSearch');
        doSearch();
        var isLeader = '${isLeader}';
        $('#resultList').datagrid({
            url : "<%=request.getContextPath()%>/Leadershipinquiry/reportCountByFwAndNd.action?querySource=grid&proyear=${param.proyear}&sjdw=${param.sjdw}&isLeader="+isLeader,
            method:'post',
            showFooter:false,
            rownumbers:true,
            pagination:true,
            striped:true,
            autoRowHeight:true,
            fit: true,
            pageSize: 20,
            fitColumns:true,
            idField:'id',
            singleSelect:false,
            remoteSort: true,
            border:false,
            toolbar:[{
                id:'search',
                text:'查询',
                iconCls:'icon-search',
                handler:function(){
                    searchWindShow('dlgSearch',750);
                }
            }
            ],
            frozenColumns:[[
            ]],
            columns:[[
                {field:'project_code',
                    title:'项目编码',
                    width:'15%',
                    halign:'center',
                    align:'left',
                    sortable:true
                },
                {field:'project_name',
                    title:'项目名称',
                    width:'15%',
                    halign:'center',
                    align:'left',
                    sortable:true

                },
                {field:'reportFile',title:'审计报告',halign:'center',width:'15%',align:'left',sortable:true
                },
                {field:'pro_type_name',
                    title:'项目类型',
                    width:'8%',
                    halign:'center',
                    align:'left',
                    sortable:true
                },
                {field:'pro_year',
                    title:'项目年度',
                    width:'7%',
                    halign:'center',
                    align:'center',
                    sortable:true
                },
                {field:'audit_dept_name',
                    title:'审计单位',
                    width:'15%',
                    halign:'center',
                    align:'left',
                    sortable:true
                },
                {field:'audit_object_name',
                    title:'被审计单位',
                    width:'15%',
                    halign:'center',
                    align:'left',
                    sortable:true
                }
            ]]
        });

        $('#resultList').datagrid('doCellTip', {
            position : 'bottom',
            maxWidth : '200px',
            tipStyler : {
                'backgroundColor' : '#EFF5FF',
                borderColor : '#95B8E7',
                boxShadow : '1px 1px 3px #292929'
            }
        });
        $('#reportAuthoritySetting_div').window({
            width:500,
            height:290,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            closed:true
        });
        $('#planName1').window({
            width:950,
            height:450,
            modal:true,
            collapsible:false,
            maximizable:true,
            minimizable:false,
            closed:true,
            maximized:true
        });
    });
    function validateDate(beginDateId,endDateId,msg){
        var s1 = $('#'+beginDateId);
        var e1 = $('#'+endDateId);
        if(s1 && e1){
            var s = s1.datebox('getValue');
            var e = e1.datebox('getValue');
            if(s!='' && e!=''){
                var s_date=new Date(s.replace("-","/"));
                var e_date=new Date(e.replace("-","/"));
                if(s_date.getTime()>e_date.getTime()){
                    $.messager.alert("错误",msg+"开始必须小于等于结束!");
                    return false;
                }
            }
        }
        return true;
    }


    function exportReportZip() {

        var selectedReoprtRows = $('#resultList').datagrid('getChecked');


        var sjAndzgReportFileids = [];

        for(var i = 0; i < selectedReoprtRows.length; i++){


            var sjSplitFileidHref = selectedReoprtRows[i].reportFile.split('<br/>');
            var zgSplitFileidHref = selectedReoprtRows[i].reworkFile.split('<br/>');
            var sjAndZgArr = sjSplitFileidHref.concat(zgSplitFileidHref);

            for(var j = 0;j<sjAndZgArr.length;j++){
                if(sjAndZgArr[j] == ''){
                }else{
                    var reg=/<a href="\/.+?\/.+?\/.+?\/.+?\?fileId=(.+?)";>(.+?)<\/a>/g;
                    var val = reg.exec(sjAndZgArr[j]);
                    sjAndzgReportFileids.push(val[1]);
                }
            }

        }

        $.ajax({
            url:'${contextPath}/archives/workprogram/pigeonhole/sjAndZgReportExportZip.action?sjAndZgIds='+sjAndzgReportFileids+'&'+new Date().getTime(),
            dataType:'json',
            method:'post',
            async:false,
            success:function (data) {
                var tempZipName = data["tempZipName"];
                if(tempZipName!='NO'){
                    var url="${contextPath}/archives/workprogram/pigeonhole/batchExportFilesjAndZgZip.action";
                    document.location.href=url;
                }else{
                    $.messager.show({
                        title:'提示信息',
                        msg:'文件压缩失败!',
                        timeout:5000,
                        showType:'slide'
                    });
                }
            }

        })


    }

    function exportReportZipBySj() {

        var selectedReoprtRows = $('#resultList').datagrid('getChecked');


        var sjAndzgReportFileids = [];

        for(var i = 0; i < selectedReoprtRows.length; i++){


            var sjSplitFileidHref = selectedReoprtRows[i].reportFile.split('<br/>');

            for(var j = 0;j<sjSplitFileidHref.length;j++){
                if(sjSplitFileidHref[j] == ''){
                }else{
                    var reg=/<a href="\/.+?\/.+?\/.+?\/.+?\?fileId=(.+?)";>(.+?)<\/a>/g;
                    var val = reg.exec(sjSplitFileidHref[j]);
                    sjAndzgReportFileids.push(val[1]);
                }
            }

        }

        $.ajax({
            url:'${contextPath}/archives/workprogram/pigeonhole/sjAndZgReportExportZip.action?sjAndZgIds='+sjAndzgReportFileids+'&'+new Date().getTime(),
            dataType:'json',
            method:'post',
            async:false,
            success:function (data) {
                var tempZipName = data["tempZipName"];
                if(tempZipName!='NO'){
                    var url="${contextPath}/archives/workprogram/pigeonhole/batchExportFilesjAndZgZip.action";
                    document.location.href=url;
                }else{
                    $.messager.show({
                        title:'提示信息',
                        msg:'文件压缩失败!',
                        timeout:5000,
                        showType:'slide'
                    });
                }
            }

        })

    }

    function exportReportZipByZg() {

        var selectedReoprtRows = $('#resultList').datagrid('getChecked');


        var sjAndzgReportFileids = [];

        for(var i = 0; i < selectedReoprtRows.length; i++){


            var zgSplitFileidHref = selectedReoprtRows[i].reworkFile.split('<br/>');

            for(var j = 0;j<zgSplitFileidHref.length;j++){
                if(zgSplitFileidHref[j] == ''){
                }else{
                    var reg=/<a href="\/.+?\/.+?\/.+?\/.+?\?fileId=(.+?)";>(.+?)<\/a>/g;
                    var val = reg.exec(zgSplitFileidHref[j]);
                    sjAndzgReportFileids.push(val[1]);
                }
            }

        }

        $.ajax({
            url:'${contextPath}/archives/workprogram/pigeonhole/sjAndZgReportExportZip.action?sjAndZgIds='+sjAndzgReportFileids+'&'+new Date().getTime(),
            dataType:'json',
            method:'post',
            async:false,
            success:function (data) {
                var tempZipName = data["tempZipName"];
                if(tempZipName!='NO'){
                    var url="${contextPath}/archives/workprogram/pigeonhole/batchExportFilesjAndZgZip.action";
                    document.location.href=url;
                }else{
                    $.messager.show({
                        title:'提示信息',
                        msg:'文件压缩失败!',
                        timeout:5000,
                        showType:'slide'
                    });
                }
            }

        })


    }


    function  jlsy() {


    }


</script>
</body>
</html>
