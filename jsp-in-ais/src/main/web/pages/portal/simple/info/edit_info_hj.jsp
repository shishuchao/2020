<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>通知公告</title>
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
        <s:form id="myform" name="myform" action="/portal/simple/information/saveInfo.action" method="post">
            <table id="portalTab" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%">
                <tr>
                    <td class="EditHead" style="width:15%;">
                        <font color="red">*</font>&nbsp;标题
                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap">
                        <input type='text' id='defect_defectName' name='information.title' value="${information.title}"
                               title='标题' class="noborder editElement clear required len60" />
                    </td>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;类别
                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap" colspan='3'>
                        <input name="information.type" id="type">
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        <font color="red">*</font>&nbsp;关键字

                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap">
                        <input type='text' id='infkey' name='information.infkey' value="${information.infkey}"
                               title='关键字' class="noborder editElement clear required len35" />
                    </td>
                    <td class="EditHead">
                        优先级
                    </td>
                    <td class="editTd" style="width:30%" nowrap="nowrap">
                        <s:textfield cssClass="noborder" name="information.customSort" />
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        限定受众-个人
                    </td>
                    <td class="editTd" style="width:30%" id="appointTD1" valign="center">
                        <s:buttonText2 cssClass="noborder" cssStyle="width:90%;" id="userNames" name="information.acceptorString.userNames"
                                       hiddenId="users"
                                       hiddenName="information.acceptorString.users" doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
									  title:'请选择人员',
									  type:'treeAndUser'
									})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
                    </td>
                    <td class="EditHead">
                        限定受众-部门
                    </td>
                    <td class="editTd" style="width:30%" id="appointTD2" valign="center">
                        <s:buttonText2 cssClass="noborder" cssStyle="width:90%;" id="orgNames" name="information.acceptorString.orgNames"
                                       hiddenId="orgs" hiddenName="information.acceptorString.orgs" doubleOnclick="showSysTree(this,{
										title:'请选择组织机构',
										checkbox:true,
										defaultDeptId:'${user.fdepid}',
										url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1'
									})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0;" readonly="true" />
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        发布状态
                    </td>
                    <td style="width:30%" id="td_pub" class="editTd" valign="center" colspan="3">
                        <s:if test="${information.infstatus eq 'Y'}">已发布</s:if>
                        <s:else>未发布</s:else>
                    </td>
                </tr>
                <tr id="newsCover">
                    <td class="EditHead">
                        新闻封面图<br><div id="coverBtn" style="float: right;"></div>
                    </td>
                    <td class="editTd" colspan="3">
                        <div id="newsCoverComponent" data-options="fileGuid:'${information.uuid2}',totalFileCount:1,echoType:2,uploadFace:1,triggerId:'coverBtn'"  class="easyui-fileUpload"></div>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%;">
                        正文
                    </td>
                    <td class="editTd" colspan="3">
                        <!-- 加载编辑器的容器 -->
                        <script id="container" name="content" type="text/plain" style="width: 100%">
                        </script>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        附件
                    </td>
                    <td class="editTd" colspan="3">
                        <div data-options="fileGuid:'${information.uuid}'"  class="easyui-fileUpload"></div>
                    </td>
                </tr>
            </table>
            <s:hidden name="information.id" />
            <s:hidden name="information.createdate"/>
            <s:hidden name="information.fcompanyid"/>
            <s:hidden name="information.fcompanyname"/>
            <s:hidden name="information.infstatus"/>
            <s:hidden name="information.create_man" />
            <s:hidden name="information.createManName" />
            <s:hidden name="information.publisher_name" />
            <s:hidden name="information.publisher_code" />
            <s:hidden name="information.uuid" />
            <s:hidden name="information.uuid2" />
            <s:hidden name="information.content" id="infoContent"/>
            <div style="text-align: center">
                <a onclick="saveForm();" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >保存</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:window.location='${contextPath}/portal/simple/information/searchInfo.action';">返回</a>
            </div>
        </s:form>

    </div>
    <script type="text/javascript">
        //var ue = UE.getEditor('container',{initialFrameWidth:1000,elementPathEnabled:false});
        var ue = UE.getEditor('container',{elementPathEnabled:false});
        ue.ready(function() {
            ue.setContent('${information.content}');
        });

        $(function(){
        	$('#type').combobox({
        		url:'${contextPath}/pages/portal/simple/info/combobox_data.json',
        	    valueField:'id',
        	    textField:'text',
                onChange:function (newValue,oldValue) {
                    if(true){
                        $('#newsCover').show();
                    }else{
                        var uploadFiles = $('#newsCoverComponent').fileUpload('getUploadFiles');
                        if (uploadFiles&&uploadFiles.length > 0) {
                            top.$.messager.confirm('确认', '新闻更改为其他类型将删除已上传的封面图，确定吗？', function (r) {
                                if (r) {
                                    $('#newsCoverComponent').fileUpload('deleteAll');
                                    $('#newsCover').hide();
                                } else {
                                    return false;
                                }
                            });
                        }else{
                            $('#newsCover').hide();
                        }
                    }
                }
             });
            if('${information.id}' != ''){
            	var typeValue = '${information.type}';
            	if(typeValue != null) {
            		$('#type').combobox('setValue','${information.type}') ;
            	}
            }else{
                $('#newsCover').hide();
            }
        });
        function saveForm(){
            if (!audEvd$validateform("myform")){
                return false;
            }
            var mytype = $("#type").combobox("getValue");
            if (!aud$isNotBlank(mytype)){
                showMessage1("类别不能为空！");
                return false;
            }
            $('#infoContent').val(ue.getContent());
            $('#myform').submit();
        }
    </script>
</body>
</html>
