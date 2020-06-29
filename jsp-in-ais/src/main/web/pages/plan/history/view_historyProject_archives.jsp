<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目档案归档流程</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
</head>
	<body >

	<!-- <div style="margin-bottom: 50px;"> -->
<div class="easyui-layout" fit="true" id="layout">
    <s:form action="save" namespace="/archives/pigeonhole" id="myform" name="myform" method="post">
         			<div style="width: 60%;position:absolute;top:0px;right:10px;text-align: right;z-index: 1000;">
	
	          <s:if test="${param.noBack != '1' }">
                   <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="return backURLFun()">返回</a>&nbsp;&nbsp;
              </s:if>     	
			</div>
<div region="center">
    <div class="easyui-tabs" fit="true" id="yearTabs" border='0'>
        <div title="基本信息">
  <%--           <s:if test="isUseTableName!='noUse'">
                <table cellpadding="0" cellspacing="1" border="0" class="ListTable" width="100%" align="center">
                    <tr>
                        <td colspan="4" class="EditHead" style="text-align: left; width: 90%;">
                        </td>
                        <td class="EditHead" style="text-align: right; width: 10%; border-left: 0px" nowrap="nowrap">	<a href="javascript:void(0);" onclick="triggerProjectInfoDiv();" title="项目信息">
								展开项目信息 </a>
                        </td>
                    </tr>
                </table>
            </s:if><s:token/> --%>
            <div id="proInfoDiv" >
                <%@include file="/pages/plan/history/view_workplan_history_archives.jsp" %>
            </div>
         <%--    <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td align="left" class="EditHead" style="width:10%;">项目名称</td>
                    <td class="editTd" align="right" style="width:40%;">
                      <s:property value="crudObject.archives_name"/>
                    </td>
                    <td align="left" class="EditHead" style="width:10%;">档案号</td>
                    <td class="editTd" align="right" style="width:40%;">
                      <s:property value="crudObject.archives_code"/>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">档案类型</td>
                    <td class="editTd" align="right">
                     <s:property value="crudObject.archives_type_name"/>
                    </td>
                    <td align="left" class="EditHead">档案状态</td>
                    <td class="editTd" align="right">
                       <s:property value="crudObject.archives_status_name"/>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">所属年度</td>
                    <td class="editTd" align="right">
                        <s:property value="crudObject.audit_start_time" />
                    </td>
                    <td align="left" class="EditHead">
                    <td class="editTd" align="right">
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">工作组负责人</td>
                    <td class="editTd"><s:property value="crudObject.principal" /><s:hidden name="crudObject.principal" />
                    </td>
                    <td align="left" class="EditHead">立档单位</td>
                    <td class="editTd" align="right">
                      <s:property value="crudObject.archives_unit_name" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">归档人</td>
                    <td class="editTd" align="right"><s:property value="crudObject.archives_start_man_name" /><s:hidden value="crudObject.archives_start_man_name" /><s:hidden name="crudObject.archives_start_man" />
                    </td>
                    <td align="left" class="EditHead">归档时间</td>
                    <td class="editTd" align="left"><s:property value="crudObject.archives_time" /><s:hidden name="crudObject.archives_time" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">项目时间</td>
                    <td class="editTd" align="right"><s:property value="crudObject.start_time" />
                        <s:if test="crudObject.start_time != null && crudObject.end_time != null">&nbsp;至&nbsp;</s:if><s:property value="crudObject.end_time" /><s:hidden name="crudObject.end_time" /><s:hidden name="crudObject.start_time" />
                    </td>
                    <td align="left" class="EditHead">被审计单位</td>
                    <td class="editTd"><s:property value="crudObject.audit_object_name" /><s:hidden name="crudObject.audit_object_or_jjzrrname" />
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">备注说明
                        <div><font color=DarkGray>(限1000字)</font>
                        </div>
                    </td>
                    <td class="editTd" colspan="3">
                    <s:textarea id="archivers_comment" name="crudObject.archivers_comment" cssStyle="width:98%" cssClass="noborder" rows="10" onchange="doWhithOne(this)" />
                        <input type="hidden" id="crudObject.archivers_comment.maxlength" value="1000" />
                        <s:hidden name="crudObject.archives_secrecy"></s:hidden>
                    </td>
                </tr>
            </table> --%>
            <div align="right" style="width: 97%; margin: 10px auto;">
              <!--   <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="return backURLFun()">返回</a>&nbsp;&nbsp;	 -->
            </div>
   <%--          <div region="south" style="height: 200px;">
                <div align="center">
                    <jsp:include flush="false" page="/pages/bpm/list_transition.jsp" />
                    <jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
                </div>
            </div> --%>
            <!-- 隐藏字段 -->
            <s:hidden name="crudObject.project_id" />
            <s:hidden name="crudObject.project_code" />
            <s:hidden name="crudObject.project_name" />
            <s:hidden name="crudObject.plan_code" />
            <s:hidden name="crudObject.plan_id" />
            <s:hidden name="project_id" value="${projectStartObject.formId}"/>
            <s:hidden name="crudObject.formId" />
            <s:hidden name="crudObject.archives_status" />
            <s:hidden name="isUseTableName" />
            <s:hidden name="crudObject.operateSystemType" />
            <s:hidden name="crudObject.pro_type" />
            <s:hidden name="crudObject.pro_type_name"
            /><s:hidden name="crudObject.audit_object" />
            <s:hidden name="crudObject.audit_object_name" />
            <s:hidden name="backURL"></s:hidden>
            <!-- </div>  -->
        </div>
      <div title="审计文书" style="overflow: hidden;">
            <iframe id="editFileHis"  width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
        </div>
        <div title="整改问题" style="overflow: hidden;">
            <iframe id="problemId"  width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden"></iframe>
         </div> 
</div>
</s:form>
</div>


	</body>
	<script type="text/javascript">

   /*
	* 显示或隐藏项目基本信息
	*/
	function triggerProjectInfoDiv(){
		/* var evt = window.event;
		var eventSrc = evt.target || evt.srcElement;
		var proInfoDiv = document.getElementById('proInfoDiv');
		if(proInfoDiv.style.display=='none'){
			eventSrc.innerText="隐藏项目信息";
			proInfoDiv.style.display='';
		}else{
			eventSrc.innerText="展开项目信息";
			proInfoDiv.style.display='none';
		} */
	}
	
	/*
	 * 返回
	 */
	function backURLFun(){
		window.location.href='${contextPath}/plan/history/historyWorkplanList.action';
	}
	
	$(function(){
        $('#yearTabs').tabs({
            onSelect:function(title){
                if(title == '审计文书') {
                	var editFileSrc = document.getElementById("editFileHis").src;
                	if ( editFileSrc ==  null || editFileSrc ==""){
                        var url = "<%=request.getContextPath()%>/archives/workprogram/pigeonhole/editArchivesFile.action?sourceSite=${sourceSite}&editFile=view&view=view&project_id=${project_id}";
                        $('#editFileHis').attr('src', url);
                	}

                } else if(title == '整改问题') {
                	var problemIdSrc = document.getElementById("problemId").src;
                	if ( problemIdSrc ==  null || problemIdSrc ==""){
                        var url = "<%=request.getContextPath()%>/proledger/problem/decideLedgerProblemMain.action?sourceSite=${sourceSite}&editFile=view&view=view&project_id=${project_id}";
                        $('#problemId').attr('src', url);
                	}

                }
            }
        });
        
        $('#yearTabs').tabs('select','审计文书');
	});
	</script>
</html>
