<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>执行结果</title>
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
	 var bodyW = $('body').width();    
	 var bodyH = $('body').height(); 
	 frloadOpen();
	 g1 = new createQDatagrid({
	        // 表格dom对象，必填
	        gridObject:$('#fdTable')[0],
	        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
	        boName:'RiskRegister',
	        // 对象主键,删除数据时使用-默认为“id”；必填
	        pkName:'formId',
	        whereSql:'rctFormId=\'${riskCollectTask.formId}\'',
	        order:'asc',
	        sort:'fdTime',
	        winWidth:800,
	        winHeight:250,
	        gridJson:{    
	            checkOnSelect:false,
	            selectOnCheck:true,
	            singleSelect:false,
	            onLoadSuccess:frloadClose,
	            columns:[[
				   {field:'formId', title:'选择',hidden:true},
				   {field:'acceptingDepName',title:'接收部门', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'eq'},
	               {field:'existedNR',width:bodyW*0.1 + 'px',title:'是否存在新风险', align:'center', sortable:true, 
				   		formatter:function(value, rowData, rowIndex) {
				   			if(value == '0')
				   				return '是';
				   			else
				   				return '否';
				   		}
	               },
	               {field:'adjustedOR',width:bodyW*0.14 + 'px',title:'是否调整风险库现有风险', align:'center', sortable:true,
	               		formatter:function(value, rowData, rowIndex) {
	               			if(value == '0')
				   				return '是';
				   			else
				   				return '否';
	               		}
	               },
	               {field:'illustration',width:bodyW*0.125 + 'px',title:'说明', align:'center', sortable:true},
	               {field:'fdPersonName',width:bodyW*0.14 + 'px',title:'反馈人', align:'center', sortable:true},
	               {field:'fdTime',width:bodyW*0.14 + 'px',title:'反馈时间', align:'center', sortable:true},
	               {field:'operation',width:bodyW*0.13 + 'px',title:'操作', align:'center',show:'false',
	            	   formatter:function(value,rowData,rowIndex){
	            	       return '<a href=\'#\' onclick="viewRisk(\'' + rowData.acceptingDep + '\',\''+rowData.formId+'\',\'${param.riskType}\')">查看</a> ';
	            	   }
	               }
	        	]]
	        }
	    });	
	    g1.batchSetBtn([
			{'index':1, 'display':false},
			{'index':2, 'display':false},
			{'index':3, 'display':false},
			{'index':4, 'display':false},
			{'index':5, 'display':false},
			{'index':6, 'display':false},
	        {'index':7, 'display':false},
	        {'index':8, 'display':false}
	    ]);
});

	
	function viewRisk(dep,formId,riskType) {
		var url = '${contextPath}/riskManagement/management/riskRegister/viewRegisterRisk.action?riskType='+riskType+'&rctFormId='+formId+'&fdepid='+dep;
		aud$openNewTab('查看反馈',url,true);
	}
</script>
</head>
<body>
       	<div data-options="region:'center',split:true">
    		<s:hidden name="riskCollectTask.formId" id="id"/>
    		<table id='myTable' align="center" class="ListTable" style='margin-top: 40px; overflow: auto;'>
    			<tr>
    				<td class="EditHead">编号</td>
    				<td class="editTd">
    					<s:textfield id="sn" name="riskCollectTask.sn" readonly="true" cssClass="noborder"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>年度</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskCollectTask.year" disabled="disabled">
    						<s:iterator value="@ais.framework.util.DateUtil@getIncrementYearList(10,5)" id="entry">
    							<s:if test="${riskCollectTask.year == entry}">
    								<option selected="selected" value="${entry}">${entry}</option>
    							</s:if>
    							<s:else>
    								<option value="${entry}">${entry}</option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead"><font color="red">*</font>风险信息收集任务</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.taskName"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>适用风险分类体系</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskCollectTask.riskType" disabled="disabled">
    						<s:iterator value="riskTemplates">
    							<s:if test="${riskCollectTask.riskType == templateId }">
    								<option selected="selected" value="<s:property value="templateId"/>"><s:property value="templateName"/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value="templateId"/>"><s:property value="templateName"/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead"><font color="red">*</font>接收单位</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.acceptingUnitName" />
    				</td>
    				<td class="EditHead"><font color="red">*</font>接收部门</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.acceptingDepName" />
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead"><font color="red">*</font>收集开始时间</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.collectStartTime"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>收集截至时间</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.collectEndTime"/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">发起单位</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiateUnitName"></s:property>
    				</td>
    				<td class="EditHead">发起部门</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiateDepName"></s:property>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">发起人</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiatePersonName"></s:property>
    				</td>
    				<td class="EditHead">发起时间</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiateTime"></s:property>
    				</td>
    			</tr>
    		</table>
    	</div>
    	<div id="measureDiv" data-options="region:'south',split:true" style="height:40%">  
            <table id='fdTable' title="反馈情况"></table>
       	</div>
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
