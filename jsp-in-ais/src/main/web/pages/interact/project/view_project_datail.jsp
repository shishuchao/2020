<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'流程定义'"></s:text>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title><s:property value="#title" />
    </title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <s:head theme="ajax" />
</head>
<body  style="overflow:hidden;" class="easyui-layout">
<div region="center" border="0px">
    <div class="easyui-tabs" fit="true" id="test" border="0px">
        <div title="基本信息" style="overflow:hidden;" border="0px">
            <iframe id="workplanId" src="${pageContext.request.contextPath}/plan/detail/view.action?crudId=${projectStartObject.plan_form_id}"
                    frameborder=0 width="100%" height="100%"></iframe>
        </div>

        <s:if test="${projectStartObject.xmType=='syOff' }">
         <div title="审计档案" style="overflow:hidden;" border="0px">
            <iframe id="archivesId" src=""
                    frameborder=0 width="100%" height="100%"></iframe>
         </div>
         <div title="整改问题" style="overflow:hidden;" border="0px">
            <iframe id="midProblemId" src=""
                    frameborder=0 width="100%" height="100%"></iframe>
         </div>
        </s:if>
        <s:else>
           <div title="审计文书" style="overflow:hidden;" border="0px">
            <iframe id="workProgramId" src=""
                    frameborder=0 width="100%" height="100%"></iframe>
           </div>
          <div title="工作底稿" style="overflow:hidden;" border="0px">
            <iframe id="manuId" src=""
                    frameborder=0 width="100%" height="100%"></iframe>
          </div>
           <div title="审计问题" style="overflow:hidden;" border="0px">
            <iframe id="problemId" src=""
                    frameborder=0 width="100%" height="100%"></iframe>
           </div>
        </s:else>
    </div>
</div>
<script type="text/javascript">
 $(function(){
		 $('#test').tabs({		 
		 onSelect:function(title){
			 if ( title == "审计文书"){
				 if ($('#workProgramId')){
                     var url = "<%=request.getContextPath()%>/workprogram/editWorkProgramProjectDetail.action?view=view&projectid=${projectStartObject.formId}";
                     $('#workProgramId').attr('src', url);
                 }
			 } else if (title == "审计档案"){
				 if ($('#archivesId')){
                     var url = "<%=request.getContextPath()%>/archives/workprogram/pigeonhole/editArchivesFile.action?editFile=view&view=view&project_id=${projectStartObject.formId}";
                     $('#archivesId').attr('src', url);
                 }
			 }else if (title == "审计问题" ){
				 if ($('#problemId')){
                     var url = "<%=request.getContextPath()%>/proledger/problem/mainUi.action?projectview=view&view=view&project_id=${projectStartObject.formId}";
                     $('#problemId').attr('src', url);
                 }
			 }else if (title == "工作底稿" ){
				 if ($('#manuId')){
                     var url = "<%=request.getContextPath()%>/operate/manuExt/mainUi.action?view=view&projectview=view&project_id=${projectStartObject.formId}";
                     $('#manuId').attr('src', url);
                 }
			 }else if (title == "整改问题" ){
				 if ($('#midProblemId')){
                     var url = "<%=request.getContextPath()%>/proledger/problem/decideLedgerProblemMain.action?view=view&project_id=${projectStartObject.formId}";
                     $('#midProblemId').attr('src', url);
                 }
			 }
		 }
	 });
 })


</script>
</body>
</html>
