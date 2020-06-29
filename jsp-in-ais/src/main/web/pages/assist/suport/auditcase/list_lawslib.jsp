<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>审计案例</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;visibility:hidden;" class="easyui-layout" onload="resetForm('lawsForm');">
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form action="delete" namespace="/pages/assist/suport/lawsLib" method="post" name="lawsForm" id="lawsForm">
            <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td class="EditHead">
                        名称
                    </td>
                    <td class="editTd">
                        <s:textfield name="assistSuportLawslib.title" cssStyle="width:80%" cssClass="noborder"/>
                    </td>
                    <td class="EditHead">
                        案例编号
                    </td>
                    <td class="editTd">
                        <s:textfield name="assistSuportLawslib.codification" cssStyle="width:80%" cssClass="noborder"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        类别
                    </td>
                    <td class="editTd">
                        <div>
                            <s:textfield readonly="true" cssClass="noborder" id="pro_type_name" cssStyle="width:80%"/>
                            <input id="lbCode" name="" type="hidden" value=""/>
                            <img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                 onclick="getItem('/ais/pages/assist/suport/auditcase/searchdate_ajal.jsp','选择类别',500,400)"></img>
                        </div>
                    </td>
                    <td class="EditHead">
                        发布状态
                    </td>
                    <td class="editTd">
                        <!--<s:select list="#@java.util.LinkedHashMap@{'Y':'是','N':'否'}"
							emptyOption="true" name="assistSuportLawslib.pub_state"
							cssStyle="width:160px" />-->
                        <select class="easyui-combobox" name="assistSuportLawslib.pub_state" data-options="panelHeight:'auto'" style="width:80%;" editable="false">
                            <option value="">&nbsp;</option>
                            <s:iterator value="#@java.util.LinkedHashMap@{'Y':'是','N':'否'}" id="entry">
                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
                            </s:iterator>
                        </select>
                    </td>

                </tr>
                <tr>
                    <td class="EditHead">
                        创建单位
                    </td>
                    <td class="editTd">
                        <s:textfield name="assistSuportLawslib.sundept" cssStyle="width:80%" cssClass="noborder"/>
                    </td>
                    <td class="EditHead">
                        正文
                    </td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:80%" name="assistSuportLawslib.content"/>
                    </td>

                </tr>
                <tr>
                    <td class="EditHead">
                        创建日期
                    </td>
                    <td class="editTd" colspan="4">
                        <input type="text" class="easyui-datebox" name="assistSuportLawslib.createDateStart" style="width: 26%"
                               editable="false"/>&nbsp;至
                        <input class="easyui-datebox" name="assistSuportLawslib.createDateEnd" style="width: 26%"
                               type="text" editable="false"/>
                    </td>
                </tr>
                <s:if test="m_view!=null&&m_view=='view'">
                    <input type="hidden" name="assistSuportLawslib.pub_state" value="Y">
                </s:if>
                <s:hidden name="assistSuportLawslib.categoryFk" value="${nodeid }"/>
            </table>
            <s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
            <s:hidden name="nodeid" value="${nodeid}"></s:hidden><br>
            <s:hidden name="ids" id="ids"></s:hidden>
            <s:hidden name="assistSuportLawslib.id" id="assistSuportLawslib_id"></s:hidden>
        </s:form>
    </div>
    <div class="serch_foot">
        <div class="search_btn">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
        </div>
    </div>
</div>
<div region="center" border="0">
    <table id="objectList"></table>
</div>
<div id="subwindow" class="easyui-window" title="类别" style="overflow:hidden;" closed="true">
    <div class="easyui-layout" border="0" fit="true" style="overflow:hidden;">
        <div region="center" border="false" style="background:#fff;border:1px solid #ccc;overflow:hidden;">
            <iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" style="overflow:hidden;"></iframe>
        </div>
        <div region="south" border="false" style="text-align:right;padding:5px 0;">
            <div style="display: inline;" align="right">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveF()">确定</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-tip'" onclick="cleanF()">清空</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWin()">关闭</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	function getUrlParam() {
		return "&mCodeType=${mCodeType}";
	}

	/*
    * 查询
    */
	function doSearch() {
		var code = document.getElementById('lbCode').value
		var obj = form2Json('lawsForm');
		if (code != '' && code != null) {
			obj.nodeid = code;
		}
		$('#objectList').datagrid({
			queryParams: obj
		});
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
		resetForm('lawsForm');
		//doSearch();
	}

	function mydelSubmit(id) {
		if (mydelCheck()) {
			$.messager.confirm('确认', '确认删除吗？', function (isDel) {
				if (isDel) {
					var s = $('#objectList').datagrid('getSelections');
					var ids = [];
					for (var i = 0; i < s.length; i++) {
						ids.push(s[i].id);
					}
					DWREngine.setAsync(false);
					DWREngine.setAsync(false);
					DWRActionUtil.execute(
							{namespace: '/pages/assist/suport/lawsLib', action: 'deleteisnot', executeResult: 'false'},
							{'ids': ids.join(",")},
							xxx);

					function xxx(rs) {
						if (rs['exis'] == 'false') {
							showMessage1('所选信息当中，有处于已发布状态，请先执行撤消操作！');
							return false;
						} else {
							$('#objectList').datagrid('reload');
							showMessage2('删除成功！');
						}
					}
				} else {
					return false;
				}
			});
		} else {
			return false;
		}
	}

	function myeditSubmit(id, type, state) {
		if (state == 'Y') {
			showMessage1('已发布状态不允许修改！');
			return;
		}
		$('#assistSuportLawslib_id').attr('value', id);
		lawsForm.action = "../lawsLib/edit.action?isLeader=${isLeader}&editType=edit";
		lawsForm.submit();
	}

	function myaddSubmit() {
		url = "../lawsLib/add.action?isLeader=${isLeader}&editType=save&mCodeType=${mCodeType}&nodeid=${nodeid}";
		window.location = url;
	}

	function mydelCheck() {
		var s = $('#objectList').datagrid('getSelections');
		var j = 0;
		var ids = "";
		for (var i = 0; i < s.length; i++) {
			ids = ids + s[i].id + ",";
			j = j + 1;
		}
		if (j < 1) {
			showMessage1('请先选中记录再进行删除操作！');
			return false;
		}
		document.getElementById("ids").value = ids;
		return true;
	}

	function myeditCheck() {
		var s = $('#objectList').datagrid('getSelections');
		var j = 0;
		var id = document.getElementsByName("assistSuportLawslib.id");
		for (var i = 0; i < s.length; i++) {
			id.value = s[i].id + ",";
			j = j + 1;
		}
		if (j < 1) {
			showMessage1('请先选择一个再进行修改!');
			return false;
		}
		if (j > 1) {
			showMessage1('修改操作只能选择一个进行修改!');
			return false;
		}
		return true;
	}

	//批量发布  撤销批量发布
	function mypub(status) {
		if (status == "Y") {
			url = "../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=Y";
		} else {
			url = "../lawsLib/publish.action?mCodeType=${mCodeType}&nodeid=${nodeid}&listpub=N";
		}
		var chkboxs = $('#objectList').datagrid('getSelections');
		var counter = 0;
		var ids = "";
		if (chkboxs.length < 1) {
			showMessage1("请选择一条记录进行发布！");
			return false;
		}
		for (i = 0; i < chkboxs.length; i++) {
			if (chkboxs[i].pub_state != status) {
				ids = ids + chkboxs[i].id + ",";
				counter++;
			}
		}
		if (counter < 1) {
			if (status == "Y")
				showMessage1("请至少选择一条未发布记录进行发布！");
			else
				showMessage1("请至少选择一条已发布记录进行撤销发布！");
			return false;
		}
		<%--window.location= url + "&ids=" + ids + "&backUrl=${backUrl}";--%>

		$.ajax({
			url: url + "&ids=" + ids + "&backUrl=${backUrl}",
			async: false,
			type: 'GET',
			success: function (data) {
				doSearch();
			}
		});
	}

	//查询
	function mSearchSub() {
		document.forms[0].action = "search.action";
		document.forms[0].submit();
	}
</script>
<script type="text/javascript">
    var nodeid = $("input[name=nodeid]").val();
    $(function () {
        showWin('dlgSearch');
        generateWin('subwindow');

        $('body').css('visibility', 'visible');

        // 初始化生成表格
        $('#objectList').datagrid({
            url: "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/listByTypeKey.action?sjdw=${sjdw}&querySource=grid&mCodeType=${mCodeType}&nodeid=" + nodeid,
            method: 'post',
            showFooter: false,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            pageSize: 20,
            fitColumns: true,
            idField: 'id',
            border: false,
            singleSelect: false,
            remoteSort: true,
            toolbar: [{
                id: 'search',
                text: '查询',
                iconCls: 'icon-search',
                handler: function () {
                    searchWindShow('dlgSearch');
                }
            }, {
                id: 'toAdd',
                text: '增加',
                iconCls: 'icon-add',
                handler: function () {
                    myaddSubmit();
                }
            }, {
                id: 'toDelete',
                text: '删除',
                iconCls: 'icon-delete',
                handler: function () {
                    mydelSubmit();
                }
            },
                <s:if test="${isLeader == true}">
                {
                    id: 'toFaBu',
                    text: '批量发布',
                    iconCls: 'icon-edit',
                    handler: function () {
                        mypub('Y');
                    }
                },
                {
                    id: 'toCheXiao',
                    text: '批量撤销发布',
                    iconCls: 'icon-undo',
                    handler: function () {
                        mypub('N');
                    }
                }
                </s:if>
            ],
            frozenColumns: [[
                {field: 'id', width: 50, checkbox: true, halign: 'center', align: 'center'},
            ]],
            columns: [[
                {
                    field: 'title', title: '名称', width: 200, halign: 'center', align: 'left', sortable: true,
                    formatter: function (value, row) {
                        return '<a href="javascript:myeditSubmit(\'' +
                            row.id +
                            '\',\'' +
                            row.type +
                            '\',\'' +
                            row.pub_state +
                            '\')">' + value + '</a>';
                    }
                },
                {
                    field: 'createDate', title: '创建日期', width: 100, sortable: true, halign: 'center', align: 'center',
                    formatter: function (value, row, rowIndex) {
                        if (value != null && value != '') {
                            return row.createDate.substring(0, 10);
                        }
                    }
                },
                {
                    field: 'sundept',
                    title: '创建单位',
                    width: 200,
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'codification',
                    title: '案例编号',
                    width: 80,
                    sortable: true,
                    halign: 'center',
                    align: 'right',
                    formatter: function (value, row, rowIndex) {
                        return row.codification;
                    }
                },
                {
                    field: 'category',
                    title: '类别',
                    width: 150,
                    halign: 'center',
                    align: 'left',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        return row.category;
                    }
                },
                {
                    field: 'pub_state',
                    title: '发布状态',
                    width: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if (row.pub_state == 'Y') {
                            return '是';
                        } else {
                            return '否';
                        }
                    }
                }
            ]]
        });
    });

    function getItem(url, title, width, height) {
        $('#item_ifr').attr('src', url);
        openWin('subwindow', title, width, height);
    }

    function saveF() {
        var ayy = $('#item_ifr')[0].contentWindow.saveF();
        document.all('pro_type_name').value = ayy[0];
        document.getElementById('lbCode').value = ayy[1];
        closeWin()
    }

    function cleanF() {
        document.all('pro_type_name').value = '';
        closeWin();
    }

    function closeWin() {
        $('#subwindow').window('close');
    }
</script>
</body>
</html>