<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计人员穿透页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="dlgSearch" class="searchWindow">
	<div class="search_head">
		<s:form id="searchForm" name="searchForm" action="sjrcCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
			<s:token/>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead">
						姓名
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="project_name"  />
					</td>
					<td class="EditHead">所属单位名称</td>
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

<div region="center" border='0'>
	<table id="yearList"></table>
</div>
<script type="text/javascript">

    function doSearch(){
        $('#yearList').datagrid({
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
        // doSearch();
    }

    function diffDate(sDate1,sDate2){
        var result = {};
        var days1 = (sDate1.getTime() / 3600000 / 24).toFixed();
        var days2 = (sDate2.getTime() / 3600000 / 24).toFixed();
        var diff = days2 - days1;

        if (diff > 0) {
            result.y = (diff / 365).toFixed();
            result.m = (diff % 365 / 30).toFixed();
            result.d = diff % 365 % 30;
        }
        return result;
    }

    $(function(){
        var bodyW = $('body').width();
        //查询
        showWin('dlgSearch');
        loadSelectH();
        // 初始化生成表格
        $('#yearList').datagrid({
            url : "<%=request.getContextPath()%>/Leadershipinquiry/sjrcCountByFwAndNd.action?querySource=grid&proyear=${param.proyear}&sjdw=${param.sjdw}&t="+new Date().getTime() ,
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
            remoteSort: true,
            toolbar:[{
                id:'search',
                text:'查询',
                iconCls:'icon-search',
                handler:function(){
                    searchWindShow('dlgSearch',750);
                }
            }
            ],
            onLoadSuccess:function(){
                initHelpBtn();
            },
            columns:[[
                {
                    field: 'name',
                    title: '姓名',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'personnelCode',
                    title: '工号',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'sex',
                    title: '性别',
                    width: 50,
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'company',
                    title: '所属单位',
                    width: bodyW * 0.1 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'technicalPost',
                    title: '职称级别',
                    width: bodyW * 0.05 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'duty',
                    title: '职位',
                    width: bodyW * 0.05 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'birthday',
                    title: '出生日期',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'diploma',
                    title: '最高学历',
                    width: bodyW * 0.07 + 'px',
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'speciality_high',
                    title: '最高学历所学专业',
                    width: bodyW * 0.1 + 'px',
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'graduateAcademy_high',
                    title: '最高学历毕业学校',
                    width: bodyW * 0.1 + 'px',
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'year_from_joinCorpDate',
                    title: '内审从事年数',
                    width: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: false,
                    formatter: function (value, rowData) {
                        value = rowData.joinCorpDate;
                        if (value) {
                            var now = new Date();
                            var joinCorpDate = new Date(value);
                            if (now.getTime() - joinCorpDate.getTime() > 1000 * 60 * 60 * 24) {
                                var diff = diffDate(joinCorpDate, now);
                                var text = '';
                                if (diff.y && diff.y > 0) {
                                    text += diff.y + '年';
                                }
                                if (diff.m && diff.m > 0) {
                                    text += diff.m + '月'
                                }
                                if (diff.d && diff.d > 0) {
                                    text += diff.d + '天'
                                }
                                return text;
                            }
                        }
                        return '';
                    }
                },
                {
                    field: 'year_from_beginWorkDate',
                    title: '司龄',
                    width: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: false,
                    formatter: function (value, rowData) {
                        value = rowData.beginWorkDate;
                        if (value) {
                            var now = new Date();
                            var beginWorkDate = new Date(value);
                            if (now.getTime() - beginWorkDate.getTime() > 1000 * 60 * 60 * 24) {
                                var diff = diffDate(beginWorkDate, now);
                                var text = '';
                                if (diff.y && diff.y > 0) {
                                    text += diff.y + '年';
                                }
                                if (diff.m && diff.m > 0) {
                                    text += diff.m + '月'
                                }
                                if (diff.d && diff.d > 0) {
                                    text += diff.d + '天'
                                }
                                return text;
                            }
                        }
                        return '';
                    }
                },
                {
                    field: 'masterfield',
                    title: '精通领域',
                    width: 150,
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'honours',
                    title: '所获荣誉',
                    width: 150,
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'qualification_names',
                    title: '职业资质',
                    width: 150,
                    halign: 'center',
                    align: 'center',
                    sortable: true
                }

            ]]
        });
        //单元格tooltip提示
        $('#yearList').datagrid('doCellTip', {
            onlyShowInterrupt:true,
            position : 'bottom',
            maxWidth : '200px',
            tipStyler : {
                'backgroundColor' : '#EFF5FF',
                borderColor : '#95B8E7',
                boxShadow : '1px 1px 3px #292929'
            }
        });
    });
</script>
</body>
</html>