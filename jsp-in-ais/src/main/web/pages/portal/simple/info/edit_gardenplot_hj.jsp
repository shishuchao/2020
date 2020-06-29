<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>交流园地</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body class="easyui-layout" style="overflow-y: auto">
    <div region="center" border='0'>
        <div style="position: fixed; top: 0; background-color: #FAFAFA; width: 100%; text-align: right; z-index: 99999; height: 40px;">
            <div style="padding:5px 10px;">
            <a onclick="saveForm();" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:window.location='${contextPath}/portal/simple/information/searchStudyGarden.action';">返回</a>
            </div>
        </div>
        <s:form id="myform" name="myform" action="/portal/simple/information/saveStudyGarden.action" method="post" cssStyle="margin-top: 40px;">
            <table id="portalTab" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%">
                <tr>
                    <td class="EditHead" style="width:15%;">
                        <font color="red">*</font>&nbsp;标题
                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap">
                        <s:textfield cssClass="noborder" maxlength="60" size="71" name="studyGardenPlot.title" id="ptitle"/>
                    </td>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;关键字

                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap">
                        <s:textfield cssClass="noborder" name="studyGardenPlot.keyword" size="35" id="pkeyword"/>
                    </td>
                </tr>
               <%--  <tr>
                    <td class="EditHead">
                        限定受众-个人
                    </td>
                    <td class="editTd" style="width:30%" id="appointTD1" valign="center">
                        <s:buttonText2 cssClass="noborder" cssStyle="width:90%;" id="userNames" name="studyGardenPlot.acceptorString.userNames"
                                       hiddenId="users"
                                       hiddenName="studyGardenPlot.acceptorString.users" doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
									  title:'请选择人员',
									  type:'treeAndUser'
									})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
                    </td>
                    <td class="EditHead">
                        限定受众-部门
                    </td>
                    <td class="editTd" style="width:30%" id="appointTD2" valign="center">
                        <s:buttonText2 cssClass="noborder" cssStyle="width:90%;" id="orgNames" name="studyGardenPlot.acceptorString.orgNames"
                                       hiddenId="orgs" hiddenName="studyGardenPlot.acceptorString.orgs" doubleOnclick="showSysTree(this,{
										title:'请选择组织机构',
										checkbox:true,
										defaultDeptId:'${user.fdepid}',
										url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1'
									})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0;" readonly="true" />
                    </td>
                </tr> --%>
                <tr>
                    <td class="EditHead" style="width:15%;">
                        正文
                    </td>
                    <td class="editTd" colspan="3">
                        <!-- 加载编辑器的容器 -->
                        <script id="container" name="content" type="text/plain" style="width: 100%;">
                        </script>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        附件
                    </td>
                    <td class="editTd" colspan="3">
                        <div data-options="fileGuid:'${studyGardenPlot.guid}'"  class="easyui-fileUpload"></div>
                    </td>
                </tr>
            </table>
            <s:hidden name="studyGardenPlot.id" />
            <s:hidden name="studyGardenPlot.create_date"/>
            <s:hidden name="studyGardenPlot.company_id"/>
            <s:hidden name="studyGardenPlot.company_name"/>
            <s:hidden name="studyGardenPlot.creator_code" />
            <s:hidden name="studyGardenPlot.creator_name" />
            <s:hidden name="studyGardenPlot.guid" />
            <s:hidden name="studyGardenPlot.content" id="infoContent"/>

        </s:form>

    </div>
    <script type="text/javascript">
        //var ue = UE.getEditor('container',{initialFrameWidth:1000,elementPathEnabled:false});
        var ue = UE.getEditor('container', {elementPathEnabled:false});
        ue.ready(function() {
            ue.setContent('${studyGardenPlot.content}');
        });

        function saveForm(){
            var ptitle = $("#ptitle").val();
            if (!aud$isNotBlank(ptitle)){
                showMessage1("标题不能为空！");
                return false;
            }
            var pkeyword = $("#pkeyword").val();
            if (!aud$isNotBlank(pkeyword)){
                showMessage1("关键字不能为空！");
                return false;
            }
            $('#infoContent').val(ue.getContent());
            $('#myform').submit();
        }
    </script>
</body>
</html>
