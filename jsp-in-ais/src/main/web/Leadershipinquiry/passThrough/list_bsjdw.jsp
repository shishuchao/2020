<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>被审计单位穿透页面</title>
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
		<s:form id="searchForm" name="searchForm" action="bsjdwCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
			<s:token/>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead">
						被审计单位名称
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="project_name"  />
					</td>
					<td class="EditHead">所属审计单位</td>
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


    $(function(){
        var bodyW = $('body').width();
        //查询
        showWin('dlgSearch');
        loadSelectH();
        // 初始化生成表格
        $('#yearList').datagrid({
            url : "<%=request.getContextPath()%>/Leadershipinquiry/bsjdwCountByFwAndNd.action?querySource=grid&proyear=${param.proyear}&sjdw=${param.sjdw}&t="+new Date().getTime() ,
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
                    title: '单位名称',
                    width: bodyW * 0.06 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'parentName',
                    title: '上级单位名称',
                    width: bodyW * 0.06 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'currentCode',
                    title: '组织结构编码',
                    width: bodyW * 0.06 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'superiorCode',
                    title: '上级组织结构编码',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'nameEng',
                    title: '机构英文名称',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'regCapital',
                    title: '注册资本(/万元)',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'mngSubject',
                    title: '管理主体',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'departmentName',
                    title: '所属审计单位',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'auditCover',
                    title: '是否属于覆盖范围',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter:function (value, rowData) {
                        if(rowData.auditCover == '1'){
                            return '是';
                        }
                        if(rowData.auditCover == '0'){
                            return '否';
                        }
                    }
                },
                {
                    field: 'officeAddress',
                    title: '总部办公地址',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'director',
                    title: '单位负责人',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'financialDirector',
                    title: '财务负责人',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'financialLinkman',
                    title: '财务联系人',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'comTypeName',
                    title: '单位性质',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'officePhone',
                    title: '单位电话',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'faxCode',
                    title: '单位传真',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'employeesNum',
                    title: '人员数量',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'updatePersonName',
                    title: '最近更新人',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },
                {
                    field: 'updateDate',
                    title: '更新时间',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                },


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