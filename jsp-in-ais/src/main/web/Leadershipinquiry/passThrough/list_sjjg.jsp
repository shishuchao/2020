<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计机构穿透页面</title>
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
		<s:form id="searchForm" name="searchForm" action="sjjgCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
			<s:token/>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead">
						审计机构名称
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="project_name"  />
					</td>
					<td class="EditHead">行业名称</td>
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
            url : "<%=request.getContextPath()%>/Leadershipinquiry/sjjgCountByFwAndNd.action?querySource=grid&proyear=${param.proyear}&sjdw=${param.sjdw}&t="+new Date().getTime() ,
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
                    field: 'fname',
                    title: '审计机构名称',
                    width: bodyW * 0.1 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'ftype',
                    title: '审计机构类型',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
					formatter:function (value, rowData) {
                        debugger;
						if(rowData.ftype == 'C'){
						    return '公司';
						}
						if(rowData.ftype == 'D'){
						    return '部门';
						}
                    }
                },
                {
                    field: 'fstatus',
                    title: '是否启用',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter:function (value, rowData) {
                        if(rowData.fstatus == 'Y'){
                            return '启用';
                        }
                        if(rowData.fstatus == 'D'){
                            return '未启用';
                        }
                    }
                },{
                    field: 'auditName',
                    title: '审计单位',
                    width: bodyW * 0.1 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },{
                    field: 'orgType',
                    title: '组织机构种类',
                    width: bodyW * 0.08 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter:function (value, rowData) {
                        if(rowData.orgType == '1'){
                            return '审计部门';
                        }
                        if(rowData.orgType == '2'){
                            return '非审计部门';
                        }
                    }
                },{
                    field: 'cityName',
                    title: '城市',
                    width: bodyW * 0.06 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },{
                    field: 'levelName',
                    title: '机构级次名称',
                    width: bodyW * 0.06 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },{
                    field: 'tradePlateName',
                    title: '所属行业',
                    width: bodyW * 0.1 + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
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