<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>两级交互-日志</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script> 
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
    var tlerrorMsg = "${tlerrorMsg}"; 
    var isAdmin = "${isAdmin}" == 'true' ? true :  false;
    var g3 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#logTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'TlInterLog',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'logId',
        order:'desc',
        sort:'createTime',
        'whereSql': isAdmin ? "" : " ( receiveOrgId like \'\%${user.fdepid}\%\') ",
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            queryParams:{},
            onClickCell:function(rowIndex, field, value){
                if(field == 'result'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$viewRow(row, 'tlLogViewDiv', 'tlLogWin', 'view');
                }
            },
    		columns:[[
                {field:'logId',       title:'选择',   width:'20px', checkbox:true, align:'center', halign:'center', show:'false', hidden:"${isAdmin}" == 'true' ? false : true},      
                {field:'result',      title:'执行结果', width:'100px',align:'center', halign:'center',sortable:true,	
                	formatter:function(value,rowData,rowIndex){
                   		var newVal = rowData['resultCode'] == '0' ? ["<strong><font color='red'>",value,"</font></strong>"].join('') : value;
                   		return  ["<label title='单击查看' style='cursor:pointer;color:blue;'>",newVal,"</label>"].join('') ;
                 }},
                {field:'templateName',title:'任务名称',width:'250px',align:'left',  halign:'center', sortable:true},
                {field:'tableName',   title:'源数据表英文名',width:'180px',align:'left',  halign:'center',  sortable:true},
                {field:'targetTableName',title:'目标数据表英文名', width:'180px',align:'left',   halign:'center',sortable:true},
                {field:'issueOrgName',title:'下发机构', width:'250px',align:'center', halign:'center',sortable:true},
                {field:'receiveOrgName',title:'数据接收机构', width:'250px',align:'left',  halign:'center',  sortable:true},
                {field:'creator',     title:'执行人',   width:'120px', align:'center',  sortable:true},
                {field:'createTime',  title:'执行时间', width:'150px',align:'center', halign:'center',sortable:true},
                {field:'creatorOrgName',  title:'执行人所属机构',   width:'250px', align:'center',  sortable:true}
                
          ]]
        }
    });
    
    if(isAdmin){
	    g3.batchSetBtn([{'index':2, 'display':false},
	                    {'index':3, 'display':false},
	                    {'index':4, 'display':false}]);	
    }else{
    	g3.batchSetBtn([{'index':1, 'display':false}, 
    	                {'index':3, 'display':false},
    	                {'index':4, 'display':false}]);	
    }
    
    window.logDatagrid = g3;
    
	$('#logTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
	
	
    $('#tlLogWin').dialog({
        title:'日志查看',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('tlLogWin');
			audEvd$clearform('tlLogForm');
		},
        buttons:[{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#tlLogWin').dialog('close');
             }
         }]
    });
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'>	  
	<table id='logTable'></table>
	
	<div id='tlLogWin' name='tlLogWin'>
		<div id='tlLogViewDiv' name='tlLogViewDiv'>
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>	
					<td class="EditHead" style="width:15%;">任务名称</td>
					<td class="editTd">
						<label id='view_templateName'></label>
					</td>
					<td class="EditHead" style="width:15%;">数据表</td>
					<td class="editTd" >
						<label id='view_tableName'></label>&nbsp;-->&nbsp;<label id='view_targetTableName'></label>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >下发机构</td>
					<td class="editTd" >
						<label id='view_issueOrgName'></label>
					</td>
					<td class="EditHead" >数据接收机构</td>
					<td class="editTd">
						<label id='view_receiveOrgName'></label>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >执行结果</td>
					<td class="editTd" colspan='3'>
						<label id='view_result' ></label>
					</td>	
				</tr>				
				<tr>
					<td class="EditHead" >执行情况</td>
					<td class="editTd" colspan='3'>
						<div id='view_content' style='padding:5px;height:150px;overflow:auto;word-break:break-all;'></div>
					</td>
				</tr>
				<tr>				
					<td class="EditHead" >执行SQL</td>
					<td class="editTd" colspan='3'>
						<div id='view_executeSql' style='padding:5px;height:80px;overflow:auto;word-break:break-all;'></div>
					</td>
				</tr>
				<tr>		
					<td class="EditHead" >执行人</td>
					<td class="editTd" >
						<label id='view_creator'></label>
					</td>
					<td class="EditHead" >执行时间</td>
					<td class="editTd">
						<label id='view_createTime'></label>
					</td>
				</tr>
				<tr>		
					<td class="EditHead" >执行人所在机构</td>
					<td class="editTd" colspan='3'>
						<label id='view_creatorOrgName'></label>
					</td>
				</tr>
			</table>
		</div>
	</div>	
</body>
</html>