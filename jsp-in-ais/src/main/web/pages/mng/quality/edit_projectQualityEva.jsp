<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<title>审计项目质量抽检项目评价</title>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
    </head>
<body>
    <s:form id="saveScoreFormId" action="saveMaintain" namespace="/quality/sampling">
        <s:hidden name="pQ.formId" id="pQFormId"/>
        <div style="width: 100%;position:fixed;top:0;" align="center">
            <table class="ListTable" align="center" style="width: 100%; padding: 0; margin: 0;">
                <tr class="EditHead">
                    <td>
                        <a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveScore('1')">保存</a>&nbsp;
                        <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveScore('2')">提交</a>&nbsp;
                        <a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a>
                    </td>
                </tr>
            </table>
        </div>
    </s:form>
    <div cellpadding=0 cellspacing=0 border=0 region="center" style="padding:32px 0;">
        <table id="dg"  style="height:auto;"></table>
    </div>
</body>
<script type="text/javascript">
    var editIndex = undefined;
    $(function() {
        if ("${suc}" == '1') {
            top.$.messager.show({
                title: '提示消息',
                msg: "保存成功！",
                timeout: 5000,
                showType: 'slide'
            });
        }

        var bodyW = $('body').width();
        $('#dg').datagrid({
            url: '<%=request.getContextPath()%>/quality/sampling/getUseScoringList.action?formId=${pQ.formId}',
            method: 'post',
            singleSelect: true,
            fitColumns: true,
            autoRowHeight: true,
            rownumbers: false,
            showFooter: true,
            onLoadSuccess: heji,
            onClickRow: onClickRow,
            columns: [[
                {field: 'orderNumber', halign: 'center', align: 'center', width: bodyW * 0.1 + 'px', title: '序号'},
                {field: 'check_point', halign: 'center', align: 'left', width: bodyW * 0.3 + 'px', title: '检查要点'},
                {field: 'full_marks', halign: 'center', align: 'center', width: bodyW * 0.15 + 'px', title: '标准满分'},
                {
                    field: 'score', halign: 'center', align: 'center', width: bodyW * 0.15 + 'px', title: '打分', editor: {
                        type: 'numberbox',
                        options: {
                            required: true,
                            precision: 1,
                            min: 0,
                            missingMessage: '0-标准满分',
                            onChange: function (newValue, oldValue) {
                            },
                            inputEvents: {
                                blur: function (e) {
                                    var tg = e.data.target;
                                    $(tg).numberbox('setValue', $(tg).numberbox('getText'));
                                }
                            }
                        }
                    }
                },
                {
                    field: 'eva_result', halign: 'center', align: 'left', width: bodyW * 0.2 + 'px', title: '评价结果', editor: {
                        type: 'textarea',
                        options: {
                            required: false,
                            missingMessage: '不得超过2000字',
                            validType: 'length[1,2000]'
                        }
                    }
                }
            ]]
        }).datagrid('doCellTip', {
            onlyShowInterrupt: 'true',
            position: 'bottom',
            maxWidth: '150px',
            tipStyler: {
                'backgroundColor': '#EFF5FF',
                borderColor: '#95B8E7',
                boxShadow: '1px 1px 3px #292929'
            }
        });
    });
    /* 保存 */
    function saveScore(subMsg) {
    	$('#dg').datagrid('endEdit', editIndex);
        editIndex = undefined;
        var saveScoreFormId = document.getElementById("saveScoreFormId");
        if (!checkUseScore()) {
            return false;
        }
        var rows = $("#dg").datagrid('getRows');
        var rowstr = JSON.stringify(rows);
        var pQFormId = document.getElementById("pQFormId").value;
        $.ajax({
            url: '<%=request.getContextPath()%>/quality/sampling/saveScoreList.action',
            async: false,
            type: 'POST',
            data: {
                'rowstr': rowstr,
                "pQFormId": pQFormId,
                "subMsg":subMsg
            },
            success: function(data) {
            	if ( data == "1" ||  data == "2" ){
                    top.$.messager.show({
                        title: "提示消息",
                        msg: "保存成功",
                        showType: 'slide'
                    });
                if( data == "2" ){
                	window.location.href = "<%=request.getContextPath()%>/quality/sampling/getProjectQualityEvaList.action" ;
                }else{
                	window.location.href = "<%=request.getContextPath()%>/quality/sampling/edit.action?formId=" + pQFormId;
                }

               }else{
                    top.$.messager.show({
                        title: "提示消息",
                        msg: "保存失败！",
                        showType: 'slide'
                    });
            	}

            }
        });
    }


    /**
  	保存校验
  	*/
    function checkUseScore() {
        var result = true;
        if (!heji()) {
            return false;
        }

        var rows = $('#dg').datagrid('getRows');
        for(var i = 0; i < rows.length; i++) {
            if(rows[i].score == null || rows[i].score == '') {
                result = false;
                showMessage1("第" + (i + 1) + "行打分不能为空！");
                onClickRow(i);
                break;
            } else if(rows[i].score * 1 > rows[i].full_marks * 1) {
                result = false;
                showMessage1("第" + (i + 1) + "行打分不能超过标准满分！");
                onClickRow(i);
                break;
            }
        }
        return result;
    }
    /* 修改统计数据	 */
    function heji() {
        var f = true;
        var rows = $('#dg').datagrid('getRows');
        var k = 0.0;
        var full = 0.0;
        if (rows) {
            for (var i = 0; i < rows.length; i++) {
                if (typeof(rows[i].score) == 'number') {
                    k += rows[i].score;
                }
                if (typeof(rows[i].score) == 'string') {
                    var score = ((rows[i].score) * 1);
                    k += score;
                }
                if (typeof(rows[i].full_marks) == 'number') {
                    full += rows[i].full_marks;
                }
                if (typeof(rows[i].full_marks) == 'string') {
                    var fm = ((rows[i].full_marks) * 1);
                    full += fm;
                }
            }
        }
        $('#dg').datagrid('reloadFooter', [{
          //  orderNumber: rows.length + 1,
            check_point: '合计',
            full_marks: full,
            score: k
        }]);
        $('#dg').datagrid('reloadFooter');
        return f;
    }

    function endEditing() {
        if (editIndex == undefined) {
            return true
        }
        if ($('#dg').datagrid('validateRow', editIndex)) {
            $('#dg').datagrid('endEdit', editIndex);
            editIndex = undefined;
            heji();
            return true;
        } else {
            return false;
        }
    }

    function onClickRow(index) {
        if (editIndex != index) {
            if (endEditing()) {
                $('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
                editIndex = index;
            } else {
                $('#dg').datagrid('selectRow', editIndex);
            }
        }
    }

    function accept() {
        if (endEditing()) {
            $('#dg').datagrid('acceptChanges');
        }
    }

    function reject() {
        $('#dg').datagrid('rejectChanges');
        editIndex = undefined;
    }

    function getChanges() {
        var rows = $('#dg').datagrid('getChanges');
        alert(rows.length + ' rows are changed!');
    }

    function back(){
    	window.location.href="<%=request.getContextPath()%>/quality/sampling/getProjectQualityEvaList.action";
    }
</script>
</html>