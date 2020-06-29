<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>应对方案</title>
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
	<style type="text/css">
		.EditHead {
			width: 20%;
		}
		
		.editTd {
			width: 30%;
		}
	</style>
<script type="text/javascript">
 var editFlag = undefined;
 var parentTabId = '${parentTabId}';
 var curTabId = aud$getActiveTabId();

 $(function(){
	var proId = '${handleProject.proName}';
	if(proId != ''){
		init();
	}
		
});
 
 function init() {
	 var bodyW = $('body').width();    
	 var bodyH = $('body').height(); 
	 frloadOpen();
	 var g1 = new createQDatagrid({
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
					{field:'id', title:'选择', checkbox:true, align:'center', show:'false'},
					{field:'proId', title:'应对方案主键', hidden:true},
					{field:'sn',title:'编号', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'eq'
					},
					{field:'meaName',title:'措施名称', width:bodyW*0.14 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_sdYear')[0]
					}
	            ]],
	            columns:[[
	               {field:'meaDescribe',title:'措施具体描述', width:bodyW*0.14 + 'px',align:'center', sortable:true, show:'true', oper:'like'
	               },
	               {field:'source',width:bodyW*0.14 + 'px',title:'所需资源', align:'center', sortable:true, type:'custom', target:$('#query_tradePlate')[0]
	               },
	               {field:'dutyDeptName',width:bodyW*0.14 + 'px',title:'责任部门', align:'center', sortable:true, show:'true', oper:'eq'
	               },
	               {field:'dutyPersonName',width:bodyW*0.14 + 'px',title:'责任人', align:'center', sortable:true, show:'true', oper:'eq'
	               },
	               {field:'remark',width:bodyW*0.14 + 'px',title:'备注', align:'center', sortable:true, show:'true', oper:'eq'
	               },
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
 }
</script>
</head>
<body>
    	<div data-options="region:'north',split:true">   	 	
            	<table id='sDTable'></table>
       	</div>
       	<div data-options="region:'center',split:true">
    	<s:form id="myForm">
    		<s:hidden name="handleProject.formId" id="id"></s:hidden>
    		<s:hidden name="handleProject.retId"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
	   				<td class="EditHead">方案名称</td>
    				<td class="editTd">
    					<s:property value="handleProject.proName"/>
    				</td>
    				
    				<td class="EditHead">方案解决的具体目标</td>
    				<td class="editTd">
    					<s:property value="handleProject.proTarget"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					方案描述
    				</td>
    				<td class="editTd" colspan="3">
						<s:property value='handleProject.proDescribe'/>
					</td>
    			</tr>
    			<tr>
	   				<td class="EditHead">所需的组织领导</td>
    				<td class="editTd">
    					<s:property value="handleProject.orgLeader"/>
    				</td>
    				
    				<td class="EditHead">所涉及的管理及业务流程</td>
    				<td class="editTd">
    					<s:property value="handleProject.flow"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					所需的条件、手段等资源
    				</td>
    				<td class="editTd" colspan="3">
						<s:property value='handleProject.source'/>
					</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					风险管理工具
    				</td>
    				<td class="editTd" colspan="3">
						<s:property value='handleProject.tool'/>
					</td>
    			</tr>
    			<tr>
	   				<td class="EditHead">计划开始时间</td>
    				<td class="editTd">
    					<s:property value="handleProject.planStartTime"/>
    				</td>
    				
    				<td class="EditHead">计划完成时间</td>
    				<td class="editTd">
    					<s:property value="handleProject.planEndTime"/>
    				</td>
    			</tr>
    			<tr>
	   				<td class="EditHead">编制人</td>
    				<td class="editTd">
    					<s:property value="handleProject.createrName"/>
    				</td>
    				
    				<td class="EditHead">编制时间</td>
    				<td class="editTd">
    					<s:property value="handleProject.createTime"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					备注
    				</td>
    				<td class="editTd" colspan="3">
						<s:property value='handleProject.remark1'/>
					</td>
    			</tr>
    		</table>
    	</s:form>
    	</div>
    	<div id="measureDiv" data-options="region:'south',split:true" style="height:50%">   	 	
            <table id='measureTable' title="应对措施列表"></table>
       	</div>
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
