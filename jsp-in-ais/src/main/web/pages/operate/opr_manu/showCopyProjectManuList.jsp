<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<title>显示和当前项目相同类型的项目-底稿</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>    
<script type="text/javascript">
$(function(){
    aud$loadClose();

	var busId = "manuList";
	var copyManuBtn = {
        text:'确定复制',
        iconCls:'icon-copy',
        handler:function(){
        	var rows = $('#'+busId).datagrid("getChecked");
        	if(rows == null || rows.length == 0){
        		showMessage1("请选择要复制的底稿");
        	}else{
        		var manuIdsArr = [];
        		$.each(rows, function(i, row){  
        			manuIdsArr.push(row.formId);
        		});
        		//alert($('body').attr("parentDialogId"))
        		if(manuIdsArr.length){//补充底稿信息
        			var url = "${contextPath}/project/copyProjectManus.action?curProjectId=${curProjectId}&projectId=${projectId}&manuIds="+manuIdsArr.join(",");        	
        			new aud$createTopDialog({
        			    title:"复制底稿",
        			    url:url,
        			    parentDialogId:$('body').attr("parentDialogId"),
        			    width:800,
        			    height:450
        			}).open();
        			//setTimeout(aud$closeTab, 100);
        		}else{
        			showMessage1("无法获得底稿ID");
        		}
        	}
        }
	};

    var cusToolbar = [copyManuBtn,"-"];
    var g1 = new createQDatagrid({
        gridObject:$('#'+busId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'AudManuscript',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        sort  :'ms_code desc',
	  	/*
	  	添加全局属性 selectAll，类型为boolean，true/false, true:用selectColum来查询；false：查询全部，即使selectColum有值，也不起作用；
	  	columns:[[{field:...添加real属性，布尔值true/false，默认值为true，如果属性字段是虚拟字段，real要设置为false;
		*/
    	selectAll:false,
    	//添加不在columns中而又要用到field
    	selectColum:['ms_date','ms_status'],
        winWidth:800,
        winHeight:200,
        myToolbar: ['search', 'export', 'reload', 'close'],
       	//全局查询参数, 如果查询form中的name值和gqueryParams的值相同(pro_year)，会覆盖gqueryParams，此时如果不想被覆盖，可以把此条件写在whereSql中
         	gqueryParams:{//默认查询当前年的数据
       		'query_eq_project_id':'${projectId}',
       		'query_like_ms_name':'${manuName}',
       		'query_like_task_name':'${manuTaskName}'
       			<s:if test="${userRole == '1'}">
       		        ,
			      'query_eq_ms_author':'${user.floginname}'
				</s:if>
		 },
	
        gridJson:{    
			queryParams:{},
           	pageSize:20,
          	singleSelect:true,
            checkOnSelect:false,
            selectOnCheck:false,
            border:0, 
            toolbar:cusToolbar,
			frozenColumns:[[
       			{field:'formId', halign:'center',checkbox:true, align:'center', show:'false'},
				{field:'ms_name',title:'底稿名称',halign:'center',width:250,sortable:true,align:'left',oper:'like',
       				formatter:function(value,row,rowIndex){
						return "<a href=\"javascript:void(0)\" title='单击查看底稿' onclick=\"aud$viewManu('"+row.formId+"')\">"+row.ms_name+"</a>"
					}	
				},
				{field:'ms_statusName',title:'底稿状态',halign:'center',width:80,sortable:true,align:'center',show:false,real:false,
					formatter:function(value,row,rowIndex){
						if (row.ms_status=='010'){
							return '底稿草稿'
						}else if (row.ms_status=='020'){
							return '正在征求'
						}else if (row.ms_status=='030'){
							return '等待复核'
						}else if (row.ms_status=='040'){
							return '正在复核'
						}else if (row.ms_status=='050'){
							return '复核完毕'
						}else if (row.ms_status=='060'){
							return '已经注销'
						}else{
							return '';
						}
					}}
    		]],
			columns:[[  
				{field:'task_name',title:'审计事项',halign:'center',width:250,sortable:true,align:'left',oper:'like'},	
				{field:'ms_author_name',title:'撰写人',halign:'center',width:80,sortable:true,align:'center', show:false},
				{field:'prom',title:'问题',halign:'center',width:50,sortable:true,align:'center', show:false},	
				{field:'fileCount',   title:'附件',halign:'center',width:50,sortable:true,align:'center', show:false,real:false,hidden:true},	
				{field:'ms_date_view',title:'创建日期',halign:'center',width:110,sortable:true,align:'center', show:false,real:false},
				{field:'subms_date',  title:'最后修改日期',halign:'center',width:110,sortable:true,align:'center', show:false}
			]]  
        }
    });
    var  manuName = "${manuName}";
    $("#ms_name_manuList").val(manuName)
      var  manuTaskName = "${manuTaskName}";
    $("#task_name_manuList").val(manuTaskName)
});
//查看疑点  
function aud$viewManu(id){
	var url = "${contextPath}/operate/manu/view.action?crudId="+id;        	
	new aud$createTopDialog({
	    title:"审计底稿查看",
	    url:url
	}).open();
}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:0"  >
	<div region="center" border="0"  >
	     <table id="manuList"></table>
	</div>
</body>
</html>