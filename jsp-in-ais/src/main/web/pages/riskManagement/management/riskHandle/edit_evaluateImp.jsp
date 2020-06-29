<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>执行评价</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript">
 var editFlag = undefined;
 var parentTabId = '${parentTabId}';
 var curTabId = aud$getActiveTabId();
 var g1;

 $(function(){
	 $('#head'+"_${handleProject.file_id}").fileUpload({
			fileGuid:'${handleProject.file_id}' == ''?'1':'${handleProject.file_id}',
			echoType:2,
			isDel:false,
			isEdit:false,
			uploadFace:1,
			triggerId:'content'+'_${handleProject.file_id}'
		});
	 var bodyW = $('body').width();    
	 var bodyH = $('body').height(); 
	 frloadOpen();
	 g1 = new createQDatagrid({
	        // 表格dom对象，必填
	        gridObject:$('#measureTable')[0],
	        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
	        boName:'HandleMeasure',
	        // 对象主键,删除数据时使用-默认为“id”；必填
	        pkName:'id',
	        whereSql:'proId=\'${handleProject.formId}\'',
	        order:'asc',
	        sort:'sn',
	        winWidth:800,
	        winHeight:250,
	        gridJson:{    
	            checkOnSelect:false,
	            selectOnCheck:true,
	            singleSelect:false,
	            onLoadSuccess:frloadClose,
	            frozenColumns:[[
					{field:'id', title:'选择',hidden:true},
					{field:'sn',title:'编号', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'eq'},
					{field:'meaName',title:'措施名称', width:bodyW*0.1 + 'px',align:'center', sortable:true, oper:'like'},
					{field:'meaDescribe',title:'措施具体描述', width:bodyW*0.14 + 'px',align:'center', sortable:true, oper:'like'}
	            ]],
	            columns:[[
	               {field:'source',width:bodyW*0.1 + 'px',title:'所需资源', align:'center', sortable:true, oper:'like'},
	               {field:'dutyDeptName',width:bodyW*0.14 + 'px',title:'责任部门', align:'center', sortable:true, oper:'like'},
	               {field:'dutyPersonName',width:bodyW*0.125 + 'px',title:'责任人', align:'center', sortable:true, oper:'like'},
	               {field:'remark',width:bodyW*0.14 + 'px',title:'备注', align:'center', sortable:true, show:'true', oper:'like'},
	               {field:'operation',width:bodyW*0.13 + 'px',title:'操作', align:'center',show:'false',
	            	   formatter:function(value,rowData,rowIndex){
	            		   var url = '${contextPath}/riskManagement/management/riskHandle/enterEvaluateImpInfo.action?hmId=' + rowData.id;
	            	       return '<a href=\'#\' onclick="enter(\'' + url + '\')">执行评价</a>';
	            	   }
	               }
	        	]]
	        }
	    });	
	    g1.batchSetBtn([
			{'index':1, 'display':false},
			{'index':2, 'display':false},
			{'index':3, 'display':true},
			{'index':4, 'display':false},
			{'index':5, 'display':false},
			{'index':6, 'display':false},
	        {'index':7, 'display':false},
	        {'index':8, 'display':false}
	    ]);
});

 function check() {
	 var result = audEvd$validateform('myForm');
	 if(result) {
		 var file_id = '${handleProject.file_id}';
		 parent.asignByiframe3(
					$('#rcsEvaluate').val(),
					$('#handleProject_impEvaluate').val(),
					$('#handleProject_remark3').val(),
					$('#impEvaluater').val(),
					$('#impEvaluaterName').val(),
					$('#impEvaluateTime').val(),
					file_id
					);
	 }
	 return result;
 }
 
 function saveForm() {
	 if (audEvd$validateform('myForm')) {
			$.post('${contextPath}/riskManagement/management/riskHandle/saveEvaluateImp.action',$('#myForm').serialize(),
									function(data) {
									if (data == '1') {
										//init();
										var file_id = '${handleProject.file_id}';
										parent.asignByiframe3(
												$('#rcsEvaluate').val(),
												$('#handleProject_impEvaluate').val(),
												$('#handleProject_remark3').val(),
												$('#impEvaluater').val(),
												$('#impEvaluaterName').val(),
												$('#impEvaluateTime').val(),
												file_id
												);
										showMessage1('保存成功！');
									} else {
										showMessage1('保存失败！');
									}
								});
	}
 }
 
 function enter(url) {
	 aud$openNewTab('录入执行评价',url,true);
 }
</script>
</head>
<body>
       	<div data-options="region:'center',split:true">
    	<s:form id="myForm">
    		<s:hidden name="handleProject.formId" id="id"></s:hidden>
    		<s:hidden name="handleProject.retId"></s:hidden>
    		<s:hidden name="crudId"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
	   				<td class="EditHead"><font color="red">*</font>风险控制状态执行评价</td>
    				<td class="editTd" colspan="3">
    					<select name="handleProject.rcsEvaluate" id="rcsEvaluate">
    						<s:iterator value="basicUtil.riskChargeList">
    							<s:if test="${handleProject.rcsEvaluate == code}">
    								<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value="code"/>"><s:property value="name"/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>方案执行情况执行评价
    				</td>
    				<td class="editTd">
						<textarea type='text' id='handleProject_impEvaluate' name='handleProject.impEvaluate'
				 			class="noborder editElement required clear len1000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${handleProject.impEvaluate}</textarea>
					</td>
					
					<td class="EditHead">
    					备注
    				</td>
    				<td class="editTd" >
						<textarea type='text' id='handleProject_remark3' name='handleProject.remark3'
				 			class="noborder editElement clear len1000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${handleProject.remark3}</textarea>
					</td>
    			</tr>
    			
    			<tr>
	   				<td class="EditHead">执行评价人</td>
    				<td class="editTd">
    					<s:property value="handleProject.impEvaluaterName"/>
    					<s:hidden name="handleProject.impEvaluaterName" id="impEvaluaterName"></s:hidden>
    					<s:hidden name="handleProject.impEvaluater" id="impEvaluater"></s:hidden>
    				</td>
    				
    				<td class="EditHead">执行评价时间</td>
    				<td class="editTd">
    					<s:property value="handleProject.impEvaluateTime" />
    					<s:hidden name="handleProject.impEvaluateTime" id="impEvaluateTime"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					附件
					</td>
    				<td class="editTd" colspan="3">
    					<div id="head_${handleProject.file_id}" style="float: left"></div>
    					<div id="content_${handleProject.file_id}" style="float: right"></div>
    				</td>
    			</tr>
    		</table>
    	</s:form>
    	</div>
    	<div id="measureDiv" data-options="region:'south',split:true" style="height:40%">  
            <table id='measureTable' title="执行评价"></table>
       	</div>
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
