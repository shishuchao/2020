<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>任务分配</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript">

        function refresh() {
            var value = document.getElementsByName('bpmTask.task_assign_policy')[0].value;
            var task_assign_policy = document.getElementsByName('bpmTask.task_assign_policy')[0].value;
            if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYUSER"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYUSER"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYLASTOPTER"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYLASTOPTER"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE_GLOBAL"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE_GLOBAL"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYTABLEFIELD"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYTABLEFIELD"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_ADDIN"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_ADDIN"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_TODRAFTMAN"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_TODRAFTMAN"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_TOLASTOPTER"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_TOLASTOPTER"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYNODE"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYNODE"/></s:url>';
            } else if (value == '<s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_PROJECT_MEMBER"/>') {
                window.location.href = '<s:url includeParams="get"><s:param name="task_assign_policy" value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_PROJECT_MEMBER"/></s:url>';
            }
        }
    </script>
</head>
<body class="easyui-layout">
<div region="center">
    <s:form action="saveOrUpdateTask" namespace="/bpm/task" name="myform"
            theme="simple">
        <table id="planTable" cellpadding=0 cellspacing=1 border=0
               class="ListTable">
            <tr>
                <td class="EditHead">
                    任务分配策略：
                </td>
                <td class="editTd">
                    <s:if
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYUSER">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYUSER"></s:select>
                    </s:if>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYLASTOPTER">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYLASTOPTER"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYTABLEFIELD">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYTABLEFIELD"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE_GLOBAL">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE_GLOBAL"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_ADDIN">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_ADDIN"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_TODRAFTMAN">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_TODRAFTMAN"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYNODE">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYNODE"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_TOLASTOPTER">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_TOLASTOPTER"></s:select>
                    </s:elseif>
                    <s:elseif
                            test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_PROJECT_MEMBER">
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"
                                  value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_PROJECT_MEMBER"></s:select>
                    </s:elseif>
                    <s:else>
                        <s:select name="bpmTask.task_assign_policy" listKey="id"
                                  listValue="name"
                                  list="@ais.bpm.model.BpmTask@getAssignPolicyList('${param.begin_nodeId}')"
                                  onchange="refresh();"></s:select>
                    </s:else>
                </td>
            </tr>
            <s:if
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYUSER">
                <tr>
                    <td class="EditHead">
                        <span>选择人员</span>：
                    </td>
                    <td class="editTd">
                            <%--<s:if test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYUSER">--%>
                            <%--<s:buttonText name="bpmTask.assign_policy_description"--%>
                            <%--cssStyle="width:90%"--%>
                            <%--hiddenName="bpmTask.assign_policy_string"--%>
                            <%--doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=bpmTask.assign_policy_description&paraid=bpmTask.assign_policy_string',600,450)"--%>
                            <%--doubleSrc="/resources/images/s_search.gif"--%>
                            <%--doubleCssStyle="cursor:hand;border:0" readonly="true"--%>
                            <%--display="true" doubleDisabled="false" />--%>
                            <%--</s:if>--%>
                            <%--<s:else>--%>
                            <%--<s:buttonText name="bpmTask.assign_policy_description"--%>
                            <%--cssStyle="width:90%"--%>
                            <%--hiddenName="bpmTask.assign_policy_string" value=""--%>
                            <%--hiddenValue=""--%>
                            <%--doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=bpmTask.assign_policy_description&paraid=bpmTask.assign_policy_string',600,450)"--%>
                            <%--doubleSrc="/resources/images/s_search.gif"--%>
                            <%--doubleCssStyle="cursor:hand;border:0" readonly="true"--%>
                            <%--display="true" doubleDisabled="false" />--%>
                            <%--</s:else>--%>
                        <s:if test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYUSER">
                            <s:buttonText name="bpmTask.assign_policy_description" cssClass="noborder"
                                          cssStyle="width:90%"
                                          hiddenName="bpmTask.assign_policy_string"
                                          doubleOnclick="showSysTree(this,
															{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
																title:'选择人员',
																defaultDeptId:'1',
																type:'treeAndUser'
															})"
                                          doubleSrc="/easyui/1.4/themes/icons/search.png"
                                          doubleCssStyle="cursor:pointer;border:0" readonly="true"
                                          display="true" doubleDisabled="false"/>
                        </s:if>
                        <s:else>
                            <s:buttonText name="bpmTask.assign_policy_description"
                                          cssStyle="width:90%" cssClass="noborder"
                                          hiddenName="bpmTask.assign_policy_string" value=""
                                          hiddenValue=""
                                          doubleOnclick="showSysTree(this,
															{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
																title:'选择人员',
																defaultDeptId:'1',
																type:'treeAndUser'
															})"
                                          doubleSrc="/easyui/1.4/themes/icons/search.png"
                                          doubleCssStyle="cursor:pointer;border:0" readonly="true"
                                          display="true" doubleDisabled="false"/>
                        </s:else>
                    </td>
                </tr>
            </s:if>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYLASTOPTER">
                <s:hidden name="bpmTask.assign_policy_string" value=""/>
                <s:hidden name="bpmTask.assign_policy_description" value=""/>
            </s:elseif>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE">
                <tr>
                    <td class="EditHead">
                        <span>选择业务角色</span>：
                    </td>
                    <td class="editTd">
                        <s:if
                                test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE">
                            <s:buttonText name="bpmTask.assign_policy_description" id="assign_policy_description"
                                          cssStyle="width:90%" cssClass="noborder" hiddenId="assign_policy_string"
                                          hiddenName="bpmTask.assign_policy_string"
                                          doubleOnclick="showRoleWindow()"
                                          doubleSrc="/easyui/1.4/themes/icons/search.png"
                                          doubleCssStyle="cursor:pointer;border:0" readonly="true"
                                          display="true" doubleDisabled="false"/>
                        </s:if>
                        <s:else>
                            <s:buttonText name="bpmTask.assign_policy_description" id="assign_policy_description"
                                          cssStyle="width:90%" cssClass="noborder" hiddenId="assign_policy_string"
                                          hiddenName="bpmTask.assign_policy_string" value="" hiddenValue=""
                                          doubleOnclick="showRoleWindow()"
                                          doubleSrc="/easyui/1.4/themes/icons/search.png"
                                          doubleCssStyle="cursor:pointer;border:0" readonly="true"
                                          display="true" doubleDisabled="false"/>
                        </s:else>
                    </td>
                </tr>
            </s:elseif>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE_GLOBAL">
                <tr>
                    <td class="EditHead">
                        <span>选择角色模板</span>：
                    </td>
                    <td class="editTd">
                        <s:if
                                test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE_GLOBAL">
                            <s:select name="bpmTask.assign_policy_string"
                                      list="businessRolesGlobal" listKey="froleid"
                                      listValue="fname"></s:select>
                        </s:if>
                        <s:else>
                            <s:select name="bpmTask.assign_policy_string"
                                      list="businessRolesGlobal" listKey="froleid"
                                      listValue="fname" value=""></s:select>
                        </s:else>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        <span>选择公司级次</span>：
                    </td>
                    <td class="editTd">
                        <s:if
                                test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYROLE_GLOBAL">
                            <s:select name="bpmTask.org_level"
                                      list="#@java.util.LinkedHashMap@{'1':'本级','2':'上级','3':'下级'}"/>
                        </s:if>
                        <s:else>
                            <s:select name="bpmTask.org_level"
                                      list="#@java.util.LinkedHashMap@{'1':'本级','2':'上级','3':'下级'}" value=""/>
                        </s:else>
                    </td>
                </tr>


            </s:elseif>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYNODE">
                <tr>
                    <td class="EditHead">
                        <span>选择节点</span>：
                    </td>
                    <td class="editTd">
                        <s:if
                                test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYNODE">
                            <s:select name="bpmTask.assign_policy_string" list="nodeList"
                                      listKey="name" listValue="name"></s:select>
                        </s:if>
                        <s:else>
                            <s:select name="bpmTask.assign_policy_string" list="nodeList"
                                      listKey="name" listValue="name" value=""></s:select>
                        </s:else>
                    </td>
                </tr>
            </s:elseif>

            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYTABLEFIELD">
                <tr>
                    <td class="EditHead">
                        <span>选择字段</span>：
                    </td>
                    <td class="editTd">
                        <s:if
                                test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYTABLEFIELD">
                            <s:select name="bpmTask.assign_policy_string" list="fieldList"
                                      listKey="code" listValue="name"></s:select>
                        </s:if>
                        <s:else>
                            <s:select name="bpmTask.assign_policy_string" list="fieldList"
                                      listKey="code" listValue="name" value=""></s:select>
                        </s:else>
                    </td>
                </tr>
            </s:elseif>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_ADDIN">
                <tr>
                    <td class="EditHead">
                        <span>选择字段</span>：
                    </td>
                    <td class="editTd">
                        <s:if
                                test="bpmTask.task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_ADDIN">
                            <s:select name="bpmTask.assign_policy_string"
                                      list="fieldListFromPso" listKey="code" listValue="name"></s:select>
                        </s:if>
                        <s:else>
                            <s:select name="bpmTask.assign_policy_string"
                                      list="fieldListFromPso" listKey="code" listValue="name"
                                      value=""></s:select>
                        </s:else>
                    </td>
                </tr>
            </s:elseif>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_TODRAFTMAN">
                <s:hidden name="bpmTask.assign_policy_string" value=""/>
                <s:hidden name="bpmTask.assign_policy_description" value=""/>
            </s:elseif>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_TOLASTOPTER">
                <s:hidden name="bpmTask.assign_policy_string" value=""/>
                <s:hidden name="bpmTask.assign_policy_description" value=""/>
            </s:elseif>
            <s:elseif
                    test="task_assign_policy==@ais.bpm.model.BpmTask@ASSIGN_POLICY_PROJECT_MEMBER">
                <s:hidden name="bpmTask.assign_policy_string" value=""/>
                <s:hidden name="bpmTask.assign_policy_description" value=""/>
            </s:elseif>
            <s:else>
                <tr>
                    <td class="EditHead">
                        <span>选择人员</span>：
                    </td>
                    <td class="editTd">
                        <s:buttonText name="bpmTask.assign_policy_description"
                                      cssStyle="width:90%" hiddenName="bpmTask.assign_policy_string"
                                      doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
								title:'选择人员',
								defaultDeptId:'1',
								type:'treeAndUser'
								})"
                                      doubleSrc="/resources/images/s_search.gif"
                                      doubleCssStyle="cursor:hand;border:0" readonly="true"
                                      display="true" doubleDisabled="false"/>
                    </td>
                        <%--doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/mutiselect.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=bpmTask.assign_policy_description&paraid=bpmTask.assign_policy_string',600,450)"
--%>
                </tr>
            </s:else>
            <s:if test="bpmTask.id==null||bpmTask.id==''">
                <s:hidden name="bpmTask.definition_id"
                          value="%{#parameters['bpmDefinition.id']}"></s:hidden>
                <s:hidden name="bpmTask.group_id"
                          value="%{#parameters['bpmGroup.id']}"></s:hidden>
                <input type="hidden" name="bpmTask.node_code" value="${nodeid}">
            </s:if>
            <s:else>
                <s:hidden name="bpmTask.definition_id"></s:hidden>
                <s:hidden name="bpmTask.group_id"></s:hidden>
                <s:hidden name="bpmTask.node_code"></s:hidden>
            </s:else>
            <s:hidden name="bpmTask.id"></s:hidden>
                <%--<tr>
                    <td class="EditHead">
                        是否禁用批量操作：
                    </td>
                    <td class="editTd">
                        <s:checkboxlist name="bpmTask.is_batch_op" list="#@java.util.LinkedHashMap@{'1':'禁用'}"></s:checkboxlist>
                    </td>
                </tr>--%>
            <tr>
                <td colspan="2" class="editTd" style="text-align: right;">
                    <a class="easyui-linkbutton" iconCls="icon-save" onclick="save()">保存</a>
                </td>
            </tr>
        </table>
        <s:hidden name="begin_nodeId" value="${param.begin_nodeId}"></s:hidden>
    </s:form>
</div>
<div id="roleWin">
    <div id="layoutDiv">
        <div region="west" style="width: 200px;" title="组织机构" split="false">
            <ul id="orgTree"></ul>
        </div>
        <div region="center" title="业务角色">
            <table id="roleList"></table>
        </div>
    </div>
</div>
<SCRIPT type="text/javascript">
    function save() {
        if (${task_assign_policy}!=
        <s:property value="@ais.bpm.model.BpmTask@ASSIGN_POLICY_BYLASTOPTER"/>)
        {
            var str = document.getElementsByName("bpmTask.assign_policy_string")[0].value;
            if (str == null || str == "") {
                showMessage1(document.getElementById("word").innerText + "不能为空！");
                return false;
            }
        }
        myform.submit();
    }
</SCRIPT>
<script type="text/javascript">
    $(function () {
        <c:if test="${param.task_assign_policy==0}">
        showMessage1('保存成功！');
        </c:if>
        //根据业务角色指定
        $('#layoutDiv').layout({
            fit: true
        });

    });

    //业务角色表格
    function refreshGrid(deptId, deptName) {
        $('#roleList').datagrid({
            url: '<%=request.getContextPath()%>/systemnew/getRoleListByCompany.action?source=grid',
            queryParams: {
                'p_deptid': deptId,
                'p_deptname': deptName
            },
            method: 'post',
            showFooter: false,
            striped: true,
            autoRowHeight: false,
            fit: true,
            fitColumns: true,
            idField: 'froleid',
            border: false,
            singleSelect: false,
            remoteSort: false,
            toolbar: [{
                id: 'ok',
                text: '确定',
                iconCls: 'icon-ok',
                handler: function () {
                    var rows = $('#roleList').datagrid('getChecked');
                    if (rows.length > 0) {
                        var ids = '';
                        var names = '';
                        for (var i = 0; i < rows.length; i++) {
                            if (i == rows.length - 1) {
                                ids = ids + rows[i].froleid;
                                names = names + rows[i].fname;
                            } else {
                                ids = ids + rows[i].froleid + ',';
                                names = names + rows[i].fname + ',';
                            }
                        }
                        $('#assign_policy_string').val(ids);
                        $('#assign_policy_description').val(names);
                        $('#roleWin').window('close');
                    } else {
                        showMessage1('请选择要指定的业务角色!');
                        return;
                    }
                }
            }, {
                id: 'cancel',
                text: '清空',
                iconCls: 'icon-empty',
                handler: function () {
                    $('#assign_policy_string').val('');
                    $('#assign_policy_description').val('');
                    $('#roleWin').window('close');
                }
            }],
            columns: [[
                {field: 'froleid', halign: 'center', checkbox: true, align: 'center'},
                {
                    field: 'fname',
                    title: '角色名称',
                    sortable: true,
                    width: 300,
                    halign: 'center',
                    align: 'left'
                }
            ]],
            onLoadSuccess: function (data) {
                var ids = $('#assign_policy_string').val();
                if (ids != null && ids != '') {
                    var rows = $('#roleList').datagrid('getRows');
                    if (rows.length > 0) {
                        ids = ids + ',';
                        for (var i = 0; i < rows.length; i++) {
                            if (ids.indexOf(rows[i].froleid) > -1) {
                                $('#roleList').datagrid('checkRow', $('#roleList').datagrid('getRowIndex', rows[i]));
                            }
                        }
                    }
                }
            }
        });
    }

    //根据业务角色指定树形及窗口
    function showRoleWindow() {
        var orgTree = $('#orgTree');
        orgTree.tree({
            url: '<%=request.getContextPath()%>/admin/asyUorg4User.action?querySource=tree',
            checkbox: false,
            animate: false,
            lines: true,
            dnd: false,
            onClick: function (node) {
                $('#roleList').datagrid({
                    queryParams: {
                        'p_deptid': node.id,
                        'p_deptname': node.text
                    }
                });
            },
            onExpand: function (node) {
                var rootNode = orgTree.tree('getRoot');
                if (node.id == rootNode.id) {
                    orgTree.tree('expand', node.target);
                }
                if (node && !orgTree.tree('getParent', node.target)) {
                    refreshGrid(node.id, node.text);
                }
            }
        });
        $('#roleWin').dialog({
            title: '根据业务角色指定',
            width: 750,
            height: 400,
            modal: true
        });
    }
</script>
</body>
</html>
