<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<title>显示和当前项目相同类型的项目</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>    
<script type="text/javascript">
$(function(){
    var currentYear = "${currentYear}";
    var offsetYear = 5;
    var yearArr = [];
    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
        yearArr.push({
            'code':i,
            'name':i
        });
    }
    aud$genSelectOption("query_year", yearArr, currentYear);    
	var busId = "projectList";
	var cusToolbar = [];
    var g1 = new createQDatagrid({
        serviceInstance:'projectStartService',
        serviceMethod:'queryManuAnaly',
	  	/*
	  	添加全局属性 selectAll，类型为boolean，true/false, true:用selectColum来查询；false：查询全部，即使selectColum有值，也不起作用；
	  	columns:[[{field:...添加real属性，布尔值true/false，默认值为true，如果属性字段是虚拟字段，real要设置为false;
		*/
    	selectAll:false,
    	//添加不在columns中而又要用到field
    	selectColum:['is_closed','prepare_closed','actualize_closed','report_closed','archives_closed','rework_closed'],
    	// 表格dom对象，必填
        gridObject:$('#'+busId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'projectStartObject',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        sort  :'project_code',
        winWidth:800,
        winHeight:250,
        myToolbar: ['search','reload', 'close'],
        // 表格控件dataGrid配置参数; 必填
        //whereSql: "",
       	//全局查询参数, 如果查询form中的name值和gqueryParams的值相同(pro_year)，会覆盖gqueryParams，此时如果不想被覆盖，可以把此条件写在whereSql中
       	gqueryParams:{//默认查询当前年的数据
       //		'query_eq_pro_year':'${currentYear}',
		//	'query_eq_pro_type':'${proTypeCode}',
		//	'query_eq_pro_type_child':"${proTypeChildCode}",
			'customParam':"a.xmType='bs' and exists (select 1 from ProMember b where a.formId = b.proInfo.formId and b.state='Y' and b.userId='${user.floginname}')"
       	},
        gridJson:{    
			queryParams:{},
           	pageSize:20,
          	singleSelect:true,
            checkOnSelect:false,
            selectOnCheck:false,
            border:0,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field){
            	var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                var manuName = $("#manuName").val();
                var manuTaskName = $("#manuTaskName").val();
                $(this).datagrid('unselectRow',rowIndex);
                if(field == 'project_name'){
                	new aud$createTopDialog({
                    	title:row['audit_dept_name']+"("+row['project_name']+")("+row['pro_type_name']+") - 底稿",
                        parentDialogId:$('body').attr("parentDialogId"),
                        url:'${contextPath}/project/showCopyProjectManuList.action?curProjectId=${projectId}&manuName='+manuName+'&manuTaskName='+manuTaskName+'&projectId='+row['formId']
                	}).open(); 
                	//setTimeout(aud$closeTab, 100);
                }
            },
			frozenColumns:[[
				{field:'formId',width:'50',halign:'center', align:'center',hidden:true, show:false},
       			{field:'is_closedName',title:'状态',halign:'center',width:'70px',align:'center',real:false, show:false
					,formatter:function(value,rowData,rowIndex){
						if(rowData.is_closed=='closed'){
							return '已关闭';
						}else{
							return '进行中';
						}
					}
				},
       			{field:'project_code',title:'项目编号',width:'20%',halign:'center',sortable:true,align:'left',oper:'like'},
				{field:'project_name',title:'项目名称',width:'25%',halign:'center',	align:'left', sortable:true,oper:'like',
					formatter:function(value ,rowData,rowIndex){
						return ["<label title='单击查看此项目下的底稿，选择需要复制的记录' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
					}	
				}
    		]],
			columns:[[  
				{field:'pro_type_name',title:'项目类别',width:'100px',halign:'center',sortable:true, align:'center', queryText:'计划类别',type:'custom', target:$('#queryCond1')[0]},
				{field:'audit_dept_name',title:'所属单位',width:'25%',halign:'center',align:'left',sortable:true, type:'custom', target:$('#queryCond2')[0]},
				{field:'curStep',
					title:'当前阶段',
					halign:'center',
					align:'center',
					sortable:true,
					show: false,
					real: false,
					width:100,
					formatter:function(value, rowData, rowIndex){
						if(rowData.prepare_closed==null || rowData.prepare_closed == '' || rowData.prepare_closed=='0'){
							return '准备'
						}
						if (rowData.report_closed==null || rowData.report_closed == '' || rowData.report_closed=='0'){
							return '实施|终结'
						}
						if (rowData.archives_closed==null || rowData.archives_closed == '' || rowData.archives_closed=='0'){
							return '档案'
						}
						if (rowData.rework_closed==null || rowData.rework_closed== ''|| rowData.rework_closed=='0'){
							return '整改'
						}
					}
				},
				{field:'prepare_closedName',title:'准备', halign:'center', align:'center', sortable:true, width:'50px',real:false, queryText:'阶段状态',type:'custom', target:$('#queryCond4')[0],hidden:true
					,formatter:function(value ,rowData,rowIndex){
						if(rowData.prepare_closed==null){
							return '未执行';
						}else if(rowData.prepare_closed=='1'){
							return '已完成';
						}else if(rowData.prepare_closed=='0'){
							return '进行中';
						}else{
							return '未执行';
							}
					}
				},
				{field:'actualize_closedName',title:'实施',halign:'center',align:'center',  sortable:true, width:'50px',real:false, queryText:'年度',type:'custom', target:$('#queryCond3')[0],hidden:true
					,formatter:function(value ,rowData,rowIndex){
					 if(rowData.report_closed==null){
							return '未执行';
						}else if(rowData.report_closed=='2' || rowData.report_closed=='1'){
							return '已完成';
						}else if(rowData.report_closed=='0'){
							return '进行中';
						}else{
							return '未执行';
						}
					}
				},
				{field:'report_closedName',title:'终结',halign:'center',align:'center',  sortable:true, width:'50px',real:false, show:false,hidden:true
					,formatter:function(value ,rowData,rowIndex){
						if(rowData.report_closed==null){
							return '未执行';
						}else if(rowData.report_closed=='1'){
							return '已完成';
						}else if( rowData.report_closed=='2'|| rowData.report_closed=='0'){
							return '进行中';
						}else{
							return '未执行';
						}
					}
				},
				{field:'archives_closedName', title:'档案',queryText:'底稿名称',target:$('#queryCond5')[0],halign:'center',align:'center',  sortable:true, width:'50px',type:'custom',real:false,hidden:true
					,formatter:function(value ,rowData,rowIndex){
						if(rowData.archives_closed==null){
							return '未执行';
						}else if(rowData.archives_closed=='1'){
							return '已完成';
						}else if(rowData.archives_closed=='0' ){
							return '进行中';
						}else{
							return '未执行';
						}
					}
				},
				{field:'rework_closedName', title:'整改',queryText:'审计事项',target:$('#queryCond6')[0],halign:'center', align:'center',  sortable:true, width:'50px',type:'custom',real:false,hidden:true
					,formatter:function(value ,rowData,rowIndex){
						if(rowData.rework_closed==null){
							return '未执行';
						}else if(rowData.rework_closed=='1'){
							return '已完成';
						}else if(rowData.rework_closed=='0' ){
							return '进行中';
						}else{
							return '未执行';
						}
					}
				}
			]]   
        }
    });
    $('#queryStageParam').val('').removeAttr("name");
    
});

function aud$Select1(r){
	if(r.value){
		$('#queryStageParam').attr("name", "query_eq_"+r.value);
	}else{
		$('#queryStageParam').removeAttr("name");
	}
}
function aud$Select2(r){
	var v = r.value;
	$('#queryStageParam').val(v == null || v == "null" || v == "" ? "isnull" : v);
}

// 生成下拉选择
function aud$genSelectOption(selectObjId, arr, defaultVal){
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
        selectObj.combobox({
        	'panelHeight':'auto'
        });
    }catch(e){
       alert('aud$genSelectOption:\n'+e.message);
    }
} 
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:0">
	<div region="center" border="0"  >
	     <table id="projectList"></table>
	</div>  
	<!-- 自定义查询条件 --> 
	<div id="queryCond1">
	    <select editable="false" id="plan_type" data-options="panelHeight:'auto'" class="easyui-combobox" name="query_eq_plan_type"  >
	       <option value="">&nbsp;</option>
	       <s:iterator value="basicUtil.planTypeList" id="entry">
	         <option value="<s:property value="code"/>"><s:property value="name"/></option>
	       </s:iterator>
	    </select>
	</div>
	<div id="queryCond2">
	    <input type='text' class="noborder editElement clear " readonly/>
	    <input type='hidden'  name='query_in_audit_dept' class="noborder editElement clear" readonly/>
	    <a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
	          onclick="showSysTree(this,{
	           title:'所属单位选择',
	           param:{
	             'rootParentId':'0',
	             'beanName':'UOrganizationTree',
	             'treeId'  :'fid',
	             'treeText':'fname',
	             'treeParentId':'fpid',
	             'treeOrder':'fcode'
	          },
	          singleSelect:true
	    })"></a>
	</div> 
	<div id="queryCond3">
		<select id="query_year" name="query_eq_pro_year" ></select>
	</div>
	<div id="queryCond4">
	    <select editable="false" id="searchStage" data-options="panelHeight:'auto', onSelect:aud$Select1" class="easyui-combobox"  style="width:45%" >
	       <option value="">&nbsp;</option>
	       <s:iterator value="@ais.project.ProjectUtil@getProjectAllStageFieldName()" id="entry">
	         <option value="<s:property value="key"/>"><s:property value="value"/></option>
	       </s:iterator>
	    </select>
	    <select  editable="false" id="stageStatus" data-options="panelHeight:'auto', onSelect:aud$Select2" class="easyui-combobox"  style="width:45%" >
	       <option value="">&nbsp;</option>
	       <s:iterator value="#@java.util.LinkedHashMap@{'null':'未执行','0':'进行中','1':'已完成'}" id="entry">
	         <option value="<s:property value="key"/>"><s:property value="value"/></option>
	       </s:iterator>
	    </select>
	    <input id="queryStageParam"  type="hidden" value=""/>
	</div>
	<div id="queryCond5">
	 <input type='text' id='manuName' name='manuName'
			title='底稿名称 ' class="noborder editElement clear" />
  	</div>
	<div id="queryCond6">
	   <input type="text"  id="manuTaskName" name="manuTaskName"  title="审计事项"
			 class="editElement noborder clear" style="width:80px!important;"/>&nbsp;&nbsp;
	</div>
</body>
</html>