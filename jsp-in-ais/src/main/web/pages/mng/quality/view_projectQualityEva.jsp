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
    <div>
        <table id="dg"></table>
    </div>
</body>
<script type="text/javascript">
    var editIndex = undefined;
    $(function() {
        var bodyW = $('body').width();
        $('#dg').datagrid({
            url: '<%=request.getContextPath()%>/quality/sampling/getUseScoringList.action?formId=${pQ.formId}',
            method: 'post',
            singleSelect: true,
            fitColumns: true,
            autoRowHeight:true,
            rownumbers: false,
            showFooter:true,
            onLoadSuccess:heji,
            columns: [[
                {field: 'orderNumber', halign: 'center', align: 'center', width: bodyW * 0.1 + 'px', title: '序号'},
                {field: 'check_point', halign: 'center', align: 'left', width: bodyW * 0.3 + 'px', title: '检查要点'},
                {field: 'full_marks', halign: 'center', align: 'center', width: bodyW * 0.15 + 'px', title: '标准满分'},
                {field: 'score', halign: 'center', align: 'center', width: bodyW * 0.15 + 'px', title: '打分'},
                {field: 'eva_result', halign: 'center', align: 'left', width: bodyW * 0.2 + 'px', title: '评价结果'}
            ]]
        }).datagrid('doCellTip', {
            position: 'bottom',
            maxWidth: '150px',
            tipStyler: {
                'backgroundColor': '#EFF5FF',
                borderColor: '#95B8E7',
                boxShadow: '1px 1px 3px #292929'
            }
        });
    });

    

    /* 修改统计数据	 */
    function heji() {
        var f = true;
        var rows = $('#dg').datagrid('getRows');
        var k = 0.0;
        var full = 0.0;
        if (rows) {
            for (var i = 0; i < rows.length; i++) {
                if (typeof(rows[i].score) == 'number') {
                    if (rows[i].score != 0) {
                        if (rows[i].score > rows[i].full_marks) {
                            top.$.messager.show({
                                title: '提示消息',
                                msg: "第" + (i + 1) + '行打分要小于满分分值！',
                                titmeout: '5000',
                                showType: 'slide'
                            });
                            f = false;
                        } else {
                            k += rows[i].score;
                        }
                    }
                }
                if (typeof(rows[i].score) == 'string') {
                    var score = ((rows[i].score) * 1);
                    if (score > rows[i].full_marks) {
                        top.$.messager.show({
                            title: '提示消息',
                            msg: "第" + (i + 1) + '行评分要小于满分分值！',
                            titmeout: '5000',
                            showType: 'slide'
                        });
                        f = false;
                    } else {
                        k += score;
                    }
                }
                if (typeof(rows[i].full_marks) == 'number') {
                    full += rows[i].full_marks;
                }
                if (typeof(rows[i].full_marks) == 'string') {
                    var fm = ((rows[i].full_marks) * 1);
                    full += rows[i].full_marks;
                }
            }
        }
        $('#dg').datagrid('reloadFooter', [{
			check_point: '合计',
            full_marks: full,
            score: k
        }]);
        $('#dg').datagrid('reloadFooter');
        return f;
    }


    
    function back(){
        window.parent.closeWin('viewProjectEvaDlg');
    	if ("${backPage}" == '1'){
    		window.location.href="<%=request.getContextPath()%>/quality/sampling/projectQualityEvaResultList.action";
    	}else{
    		window.location.href="<%=request.getContextPath()%>/quality/sampling/getProjectQualityEvaList.action";
    	}
    	
    }
</script>
</html>