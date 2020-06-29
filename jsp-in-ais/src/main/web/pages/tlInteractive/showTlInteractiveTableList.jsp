<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>两级交互-数据表</title>
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
    var isAdmin = "${isAdmin}" == 'true' ? true : false;
    if(tlerrorMsg){
        top.$.messager.alert('提示信息', tlerrorMsg, 'error', function(){
            var selectedTab = top.$('#tabs').tabs('getSelected');
            if(selectedTab){
                var tabIndex = top.$('#tabs').tabs('getTabIndex', selectedTab);
                top.$('#tabs').tabs('close', tabIndex);
            }
        });
        $('body').html('');
        return;
    }
	//isdebug = true;
	var reqPrefix = "${contextPath}/tlInteractive/";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#dbtable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'TlInterTable',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'tableId',
        order:'desc',
        sort:'createTime',
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:[{   
	                text:'添加',
	                iconCls:'icon-add',
	                handler:function(){
	                	$('#dbTableWin').dialog('open');
	                }
	            },'-'
	        ],
            onClickCell:function(rowIndex, field, value){
                if(field == 'tableNameDesc' && isAdmin){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$editRow(row, 'dbTableForm', 'dbTableWin', 'tlInterTb');
                }
            },	
    		columns:[[
                {field:'tableId',      title:'选择',   width:'10px', checkbox:true, align:'center', halign:'center', show:'false', hidden:"${isAdmin}" == 'true' ? false : true},
                {field:'tableNameDesc',title:'源数据表中文名', width:'200px',align:'center', halign:'center',sortable:true,
                	formatter:function(value,rowData,rowIndex){
                    	return  isAdmin ? ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') : value;
                }},
                {field:'tableName',    title:'源数据表英文名', width:'220px',align:'left',  halign:'center',  sortable:true},
                {field:'targetTableNameDesc',title:'目标数据表中文名', width:'200px',align:'center', halign:'center',sortable:true},
                {field:'targetTableName',    title:'目标数据表英文名', width:'200px',align:'left',   halign:'center',sortable:true},
                {field:'creator',   title:'创建人',   width:'110px', align:'center',  sortable:true},
                {field:'createTime',title:'创建时间', width:'150px',align:'center', halign:'center',sortable:true},
                {field:'modifier',  title:'修改人',   width:'110px', align:'center',sortable:true},
                {field:'modifyTime',title:'修改时间', width:'150px',align:'center', halign:'center',sortable:true}
          ]]
        }
    });
    if(isAdmin){
    	g1.batchSetBtn([{'index':3, 'display':false},
    	                {'index':4, 'display':false},
    	                {'index':5, 'display':false}]);
    }else{
    	g1.batchSetBtn([{'index':1, 'display':false},
    	                {'index':2, 'display':false},
    	                {'index':3, 'display':false},
    	                {'index':4, 'display':false},
    	                {'index':5, 'display':false}]);
    }
    

    $('#dbTableWin').dialog({
        title:'数据表',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('dbTableWin');
			audEvd$clearform('dbTableForm');
		},
        buttons:[{
             text:'保存',
             iconCls:'icon-save',
             handler:function(){
            	 aud$saveForm('dbTableForm', reqPrefix + "saveDbTable.action", function(data){
            		 if(data){
            			 data.type == 'info' ? (g1.refresh(),$('#dbTableWin').dialog('close')) : null;
            			 data.msg ? showMessage1(data.msg) : null;	 
            		 }
            	 });
             }
         },{
             text:'清空',
             iconCls:'icon-reload',
             handler:function(){
            	 audEvd$clearform('dbTableForm');
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#dbTableWin').dialog('close');
             }
         }]
    });

	$('#dbtable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
	
	$('#tlInterTb_tableName').bind('change', function(){
		$('#tlInterTb_targetTableName').val($(this).val());
	});
	$('#tlInterTb_tableNameDesc').bind('change', function(){
		$('#tlInterTb_targetTableNameDesc').val($(this).val());
	});	
});

</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'>	
 	    	 	
	<table id='dbtable'></table>
	
	<!-- 数据表 -->
	<div id='dbTableWin' name='dbTableWin'>
		<form id='dbTableForm' name='dbTableForm'>
			<input type='hidden'  id='tlInterTb_tableId' name='tlInterTb.tableId' class="noborder  clear ">
			<table class="ListTable" align="center" >
				<tr>
					<td class="EditHead"><font color=red>*</font>源数据表英文名</td>
					<td class="editTd">
						<input type='text' title='源数据表英文名' id='tlInterTb_tableName' style='width:60%;'
						name='tlInterTb.tableName'  class="noborder required clear editElement">
					</td>
					<td class="EditHead"><font color=red>*</font>源数据表中文名</td>
					<td class="editTd" >
						<input type='text'  title='源数据表中文名' id='tlInterTb_tableNameDesc' name='tlInterTb.tableNameDesc'  style='width:60%;' 
						class="noborder required clear editElement">
					</td>
				</tr>
				<tr>
					<td class="EditHead"><font color=red>*</font>目标数据表英文名</td>
					<td class="editTd">
						<input type='text' title='目标数据表英文名' id='tlInterTb_targetTableName' style='width:60%;'
						name='tlInterTb.targetTableName'  class="noborder required clear editElement">
					</td>
					<td class="EditHead"><font color=red>*</font>目标数据表中文名</td>
					<td class="editTd" >
						<input type='text'  title='目标数据表中文名' id='tlInterTb_targetTableNameDesc' name='tlInterTb.targetTableNameDesc'  style='width:60%;' 
						class="noborder required clear editElement">
					</td>
				</tr>
			</table>
		</form>
	</div>
	

	
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>