<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>项目列表-项目浏览页</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
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
        <s:form id="myform" name="myform" action="listAll.action" namespace="/project" method="post">
            <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                        <%-- <td  class="EditHead" style="width:15%">
                            项目编号
                        </td>
                        <td class="editTd" style="width:35%">
                            <s:textfield cssClass="noborder" name="crudObject.project_code" cssStyle="width:80%" maxlength="50"/>
                        </td> --%>
                    <td class="EditHead" style="width:20%">
                        项目编号
                    </td>
                    <td class="editTd" style="width:33%">
                        <s:textfield cssClass="noborder" name="crudObject.project_code" cssStyle="width:80%" maxlength="50"/>
                    </td>
                    <td class="EditHead" style="width:15%">
                        项目名称
                    </td>
                    <td class="editTd" style="width:32%">
                        <s:textfield cssClass="noborder" name="crudObject.project_name" cssStyle="width:80%" maxlength="50"/>
                    </td>
                </tr>
                <s:if test="'${projectType}'!=@ais.project.ProjectContant@NBZWPG">
                    <tr>
                        <td class="EditHead">
                            计划类别
                        </td>
                        <td class="editTd">
                            <select id="plantype" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.plan_type" style="width:80%" editable="false">
                                <option value="<s:property value="code"/>">请选择</option>
                                <s:iterator value="basicUtil.planTypeList">
                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:iterator>
                            </select>
                        </td>
                        <td class="EditHead">
                            项目类别
                        </td>
                        <td class="editTd">
                            <!--<s:doubleselect id="pro_type" doubleId="pro_type_child"
								doubleList="basicUtil.planTypeList[top]"
								doubleListKey="code" doubleListValue="name" listKey="code"
								listValue="name" name="crudObject.pro_type"
								list="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()"
								doubleName="crudObject.pro_type_child" theme="ufaud_simple"
								templateDir="/strutsTemplate" display="${varMap['pro_typeRead']}"
								emptyOption="true" />-->
                            <select class="easyui-combobox" data-options="panelHeight:'auto'" name="crudObject.pro_type" style="width:80%" editable="false">
                                <option value="">请选择</option>
                                <s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:iterator>
                            </select>
                        </td>
                    </tr>
                </s:if>
                <tr>
                    <td class="EditHead">
                        所属单位
                    </td>
                    <td class="editTd">
                        <s:buttonText2 name="crudObject.audit_dept_name" cssClass="noborder"
                                       hiddenName="crudObject.audit_dept" cssStyle="width:80%"
                                       doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'请选择审计单位',
                                 param:{
								    'p_item':3
                             			},
								})"
                                       doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                       doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
                    </td>
                    <td class="EditHead">
                        被审计单位
                    </td>
                    <td class="editTd">
                        <s:buttonText2 name="crudObject.audit_object_name" cssClass="noborder"
                                       hiddenName="crudObject.audit_object" cssStyle="width:80%"
                                       doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,
							  checkbox:true,
							  param:{
							    'departmentId':'${magOrganization.fid}'
							  },
							  title:'请选择被审计单位'
							})"
                                       doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                       doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        当前阶段
                    </td>
                    <td class="editTd">
                        <select class="easyui-combobox" data-options="panelHeight:'auto'" name="crudObject.stageStatus" style="width:80%" editable="false">
                            <option value="">请选择</option>
                            <s:iterator value="#@java.util.LinkedHashMap@{'准备':'准备','实施|终结':'实施|终结','归档':'归档','整改':'整改','完结':'完结'}" id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>
                        </select>
                    </td>
                    <td class="EditHead">
                        项目年度
                    </td>
                    <td class="editTd">
                        <select class="easyui-combobox" name="crudObject.pro_year" id="pro_year" style="width:80%" editable="false">
                            <option value="">请选择</option>
                            <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        作业模式
                    </td>
                    <td class="editTd">
                        <select class="easyui-combobox" name="crudObject.xmType" id="xmType" style="width:80%" editable="false">
                            <option value="">请选择</option>
                            <s:iterator value='#@java.util.LinkedHashMap@{"bs":"在线","syOff":"离线"}' id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>
                        </select>
                    </td>
                </tr>
                <input type="hidden" name="condition" value="yes" reload="false"/>
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
    <table id="projectList"></table>
</div>
<script type="text/javascript">
    function freshGrid() {
        $('#dlgSearch').dialog('open');
    }

    /*
    * 查询
    */
    function doSearch() {
        datagrid.datagrid('options').queryParams = form2Json('myform');
        datagrid.datagrid('reload');
        $('#dlgSearch').dialog('close');
    }

    /*
    * 取消
    */
    function doCancel() {
        $('#dlgSearch').dialog('close');
    }

    /**
     重置
     */
    function restal() {
        resetForm('myform');
        /*doSearch();*/
    }

    function showProjectAuditObjectData(id, project_name) {
        // alert('显示项目采集数据：' + id + '\n' + name);
        var url = '${contextPath}/mng/audobj/data/listAuditObjectDataByProject.action?view=${"temp"==user.flevel}&projectId=' + id;
        aud$openNewTab('离线采集数据-' + project_name, url, false);
    }

    var datagrid;
    $(function () {
        var bodyW = $('body').width();
        var isCommon = '${isCommon}';
        showWin('dlgSearch');
        //  $('body').layout('collapse','north');
        //  $(document).bind("contextmenu",function(e){return false;});//禁用右键菜单
        //if('${empty crudObject.pro_year}'=='true'){
        var d = new Date();
        $('#pro_year').combobox('setValue', d.getFullYear());
        //	$('#pro_year').combo('setText',d.getFullYear());
        //}
        // 初始化生成表格
        datagrid = $('#projectList').datagrid({
            url : "<%=request.getContextPath()%>/project/listMyProject.action?querySource=grid&audobj_data",
            method: 'post',
            showFooter: false,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            pageSize: 20,
            fitColumns: true,
            border: false,
            remoteSort: false,
            singleSelect: true,
            toolbar: [{
                id: 'search',
                text: '查询',
                iconCls: 'icon-search',
                handler: function () {
                    searchWindShow('dlgSearch');
                }
            }, '-', helpBtn
            ],
            onLoadSuccess: function () {
                initHelpBtn();
            },
            frozenColumns:[[
                {
                    field: 'is_closed', title: '状态', halign: 'center', align: 'center', sortable: true, width: 0.06 * bodyW + 'px',
                    formatter: function (value, rowData, rowIndex) {
                        if (rowData.rework_closed == '1') {
                            return "已完结";
                        } else {
                            if (rowData.is_closed == 'closed') {
                                return '已关闭';
                            } else if (rowData.is_closed == 'running') {
                                return '进行中';
                            }
                        }
                    }
                },
                {
                    field: 'pro_year',
                    title: '项目年度',
                    halign: 'center',
                    width: 0.06 * bodyW + 'px',
                    sortable: true,
                    align: 'center',
                    hidden: true
                },
                {field: 'project_code', title: '项目编号', width: 0.2 * bodyW + 'px', sortable: true, halign: 'center', align: 'left'},
                {
                    field: 'project_name',
                    title: '项目名称',
                    width: 0.25 * bodyW + 'px',
                    halign: 'center',
                    align: 'left',
                    sortable: true,
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:" onclick="showProjectAuditObjectData(\'' + rowData.formId + '\', \'' + rowData.project_name + '\')">' + value + '</a>';
                    }
                },
                {
                    field: 'pro_type_name',
                    title: '项目类别',
                    halign: 'center',
                    width: 0.1 * bodyW + 'px',
                    align: 'left',
                    sortable: true,
                    formatter: function (value, rowData, rowIndex) {
                        if (rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
                            return rowData.pro_type_child_name;
                        } else {
                            return value;
                        }
                    }
                }
            ]],
            columns: [[
                {
                    field: 'audit_dept_name',
                    title: '审计单位',
                    width: 0.15 * bodyW + 'px',
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'audit_object_name',
                    title: '被审计单位',
                    width: 0.15 * bodyW + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'xmType',
                    title: '作业模式',
                    halign: 'center',
                    width: 0.06 * bodyW + 'px',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, rowData, rowIndex) {
                        if (value == 'syOff') {
                            return "离线";
                        } else {
                            return "在线";
                        }
                    }
                },
                {
                    field: 'zz',
                    title: '组长',
                    width: 0.06 * bodyW + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'zs',
                    title: '主审',
                    width: 0.06 * bodyW + 'px',
                    halign: 'center',
                    align: 'center',
                    sortable: true
                },
                {
                    field: 'curStep',
                    title: '当前阶段',
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    width: 0.06 * bodyW + 'px',
                    formatter: function (value, rowData, rowIndex) {
                        if (rowData.xmType == 'syOff') {
                            debugger;
                            var stagename = rowData.processName;
                            if (stagename == null || stagename == '') {
                                stagename = '准备';
                            } else if (stagename == '已完成') {
                                stagename = '完结';
                            } else if(stagename == '实施' || stagename == '终结') {
                                stagename = '实施|终结';
                            }
                            return stagename;
                        } else {
                            if (rowData.prepare_closed == null || rowData.prepare_closed == '' || rowData.prepare_closed == '0') {
                                return '准备'
                            }
                            if (rowData.report_closed == null || rowData.report_closed == '' || rowData.report_closed == '0') {
                                return '实施|终结'
                            }
                            if (rowData.archives_closed == null || rowData.archives_closed == '' || rowData.archives_closed == '0') {
                                return '归档'
                            }
                            if (rowData.rework_closed == null || rowData.rework_closed == '' || rowData.rework_closed == '0') {
                                return '整改'
                            } else {
                                return '完结'
                            }
                        }
                    }
                }
            ]]
        }).datagrid('doCellTip', {
            onlyShowInterrupt: true,
            position: 'bottom',
            maxWidth: '200px',
            tipStyler: {
                'backgroundColor': '#EFF5FF',
                borderColor: '#95B8E7',
                boxShadow: '1px 1px 3px #292929'
            }
        });
    });

</script>
</body>
</html>
