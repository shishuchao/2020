<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>新增风险列表</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">
var editFlag = undefined;
var g1;

$(function(){
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
 	var createrDeptId = '${user.fdepid}';
    $('#query_status').show();
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'RiskTask',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        whereSql: 'operateType=\'2\' and createrDeptId=\'' + createrDeptId + '\'',
        order:'asc',
        sort:'taskCode',
        winWidth: 800,
        winHeight: 250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            toolbar:[{
            	text:'新增',
            	iconCls:'icon-add',
            	handler:function () {
            		var editUrl = '${contextPath}/riskManagement/management/majorRiskReport/edit.action';
            		window.location.href=editUrl;
            		//aud$openNewTab('新增风险', editUrl);
            	}
            }] ,
            frozenColumns:[[
				{field:'taskId', title:'选择', hidden:true, align:'center', show:'false'},      
				{field:'taskCode',title:'编号', width:bodyW*0.12 + 'px',align:'center', sortable:true, hidden:true, show:'false'},
				{field:'taskName',title:'风险事项', width:bodyW*0.12 + 'px',align:'left', halign:'center',sortable:true, oper:'like'},
				{field:'riskDescription',title:'风险描述', width:bodyW*0.12 + 'px',align:'left', halign:'center', sortable:true, show:'false'},
				{field:'status',width:bodyW*0.1 + 'px',title:'状态', align:'center', sortable:true, type:'custom', target:$('#query_status')[0],
					formatter: function(value, rowData, rowIndex) {
						if(value == '0')
							return '进行中';
						else
							return '已完成';
					}
				}
            ]],
            columns:[[
               {field:'influenceDescription',title:'影响描述', width:bodyW*0.12 + 'px',align:'left', halign:'center',sortable:true, show:'false'},
               {field:'taskPname',title:'风险分类', width:bodyW*0.1 + 'px',align:'left', halign:'center',sortable:true, type:'custom',target:$('#queryCond1')[0]},
               {field:'affiliatedDeptName',width:bodyW*0.11 + 'px',title:'所属单位', align:'left', halign:'center', sortable:true, type:'custom',target:$('#queryCond2')[0]},
               {field:'majorDutyDeptName',width:bodyW*0.11 + 'px',title:'主责部门', align:'left', halign:'center', sortable:true, type:'custom',target:$('#queryCond3')[0]},
               {field:'createTime',width:bodyW*0.13 + 'px',title:'上报时间', align:'center', sortable:true, type:'custom',target:$('#queryCond4')[0]},
               {field:'operate',width:bodyW*0.1 + 'px',title:'操作', align:'center', sortable:false, show:'false',
            	   formatter:function(value,rowData,rowIndex) {
            		   if(rowData.status == '0') {
            			   var url = '${contextPath}/riskManagement/management/majorRiskReport/edit.action?crudId=' + rowData.formId;
            			   var delUrl = '${contextPath}/riskManagement/management/majorRiskReport/delMajorRisk.action?crudId=' + rowData.formId;
            			   return '<a href=\'#\' onclick="edit(\'' + url + '\')">编辑</a> ' + ' <a href=\'#\' onclick="del(\'' + delUrl + '\')">删除</a>';
            		   }else {
            			   var url = '${contextPath}/riskManagement/management/majorRiskReport/edit.action?isView=Y&crudId=' + rowData.formId;
            			   return '<a href=\'#\' onclick="view(\'' + url + '\')">查看</a> ';
            		   }
            	   }
               }
        	]],
        }
    });	
    g1.batchSetBtn([
		{'index':1, 'display':true},
		{'index':2, 'display':false},
		{'index':3, 'display':true},
		{'index':4, 'display':false},
		{'index':5, 'display':false},
		{'index':6, 'display':false},
        {'index':7, 'display':false},
        {'index':8, 'display':false}
    ]);
    
    $('#sDTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
    
    var query_status = [{"code":"1","name":"进行中"},{"code":"2","name":"已完成"}];
    genSelectOption("query_status",query_status);
    
    // 生成下拉选择
    function genSelectOption(selectObjId, arr, defaultVal){
        try{
            var selectObj = $('#'+selectObjId);
            if(selectObj && selectObj.length && arr && arr.length){
                selectObj.append("<option value=''></option>");
                for(var i=0; i<arr.length; i++){
                    var  ele = arr[i];
                    //alert(ele)
                    if(defaultVal != null && defaultVal == ele.code){
                        selectObj.append("<option value='"+ele.code+"' selected>"+ele.name+"</option>");
                    }else{
                        selectObj.append("<option value='"+ele.code+"'>"+ele.name+"</option>");
                    }
                    
                }
            }
        }catch(e){
            isdebug ? alert('genSelectOption:\n'+e.message) : null;
        }
    } 
});

function edit(url) {
	//aud$openNewTab('新增风险-修改', url);
	window.location.href=url;
}

function view(url) {
	aud$openNewTab('查看',url,true);
}

function del(delUrl) {
	$.messager.confirm('提示信息','确认删除吗？',function(data){
		if(data) {
			$.ajax({
				url:delUrl,
				type:'POST',
				async:false,
				success:function(data) {
					if(data == '1') {
						showMessage1('删除成功！');
						$('#sDTable').datagrid('reload');
					}
				}
			});
		}
	});
}
</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
    
    <div id='queryCond1'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_taskPid' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'风险分类',
				 param:{
				'rootParentId':'-1',
				'whereHql':'template_type != \'2\'',
				'beanName':'RiskTaskTemplateTree',
				'treeId':'taskId',
				'treeText':'taskName',
				'treeParentId':'taskPid',
				'treeOrder':'taskCode',
				'treeAtrributes':'template_type'
				 }
			})"></a>
	</div>
   
   <div id='queryCond2'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_affiliatedDeptId' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'所属单位',
				 param:{
				'rootParentId':'0',
				'beanName':'UOrganizationTree',
				'treeId':'fid',
				'treeText':'fname',
				'treeParentId':'fpid',
				'treeOrder':'fcode'
				 }
			})"></a>
   </div>
   
   <div id='queryCond3'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_majorDutyDeptId' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'主责部门',
				 param:{
				'rootParentId':'0',
				'beanName':'UOrganizationTree',
				'treeId':'fid',
				'treeText':'fname',
				'treeParentId':'fpid',
				'treeOrder':'fcode'
				 }
			})"></a>
   </div>
   
   <div id='queryCond4'>
 		<input type='text'  name='query_mtq_createTime' class="easyui-datebox noborder clear" editable="false"/> 至 
 		<input type='text'  name='query_ltq_createTime' class="easyui-datebox noborder clear" editable="false"/>
   </div>
    <select id="query_status" name="query_status" style="display:none;" class="noborder"></select>
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
