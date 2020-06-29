<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<div id="reviewInfoDiv" style="height:300px;padding:0px;">
	<table id="reviewInfoTable"></table>
</div>

<script type='text/javascript'>
$(function(){
	
	if("${manu.manuStatusCode}" != -1){
		//流转信息查看
		new createQDatagrid({
	        // 表格dom对象，必填
	        gridObject:$('#reviewInfoTable')[0],
	        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
	        boName:'ReviewInfo',
	        // 对象主键,删除数据时使用-默认为“id”；必填
	        pkName:'rvId',
	        order :'asc',
	        sort  :'createTime',
		    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
		    myToolbar:['export', 'reload'],
			//定制查询
			whereSql: " manuId='${manu.manuId}' and projectId='${manu.projectId}' ",
	        gridJson:{
				title: $('#rvSaveBtn').length ? '' :'复核流转信息',
			    pageSize:10,
	        	singleSelect:true,
	        	checkOnSelect:false,
	        	selectOnCheck:false,
	    		border:0,
	    		fit:true,
	    		toolbar:[],
	    		columns:[[
					{field:'rvLevelName',title:"复核级次", width:'100px', align:'center', halign:'center',sortable:true},
					{field:'rvAdvice',  title:"复核意见",  width:'70px', align:'center', halign:'center',sortable:true},			
					{field:'rvExplain', title:"意见说明",  width:'150px', align:'left', halign:'center',sortable:true,
						formatter:function(value,row,index){
							return value ? "<label title='"+value+"'>"+value+"</label>" : "";
						}
					},
	    			{field:'preRvPerson', title:"上一步处理人",   width:'100px',  align:'center', halign:'center',sortable:true},
	    			{field:'preRvDate',   title:"上一步处理时间",  width:'120px',  align:'center', halign:'center',sortable:true},
	    			{field:'nextRvPerson',title:"下一步处理人",   width:'100px',  align:'center', halign:'center',sortable:true},
					{field:'isEnd',     title:"是否结束",  width:'80px', align:'center', halign:'center',sortable:true,show:'false',
						formatter:function(value, row, index){
							return value == 1 ? "<font color='red'><strong>已结束</strong></fornt>" : "进行中";
						}
					},
	    			{field:'rvPerson',  title:"复核人",   width:'80px',  align:'center', halign:'center',sortable:true},
					{field:'rvDate',    title:"复核时间",  width:'100px', align:'center', halign:'center',sortable:true}
	          ]]
	        }
	    });
	}else{
		$('#reviewInfoDiv').remove();
	}
	
});
</script>