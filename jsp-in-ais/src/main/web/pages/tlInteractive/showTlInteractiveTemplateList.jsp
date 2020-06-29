<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>两级交互-交互任务</title>
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
	isdebug = true;
	//alert(isAdmin ? "" : " ((isPublic = 1 and receiveOrgId like \'\%${user.fdepid}\%\') or (isPublic = 0 )) ")
    var g2 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#templateTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'TlInterSqlTemplate',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'templateId',
        order:'desc',
        sort:'templateName',
        'whereSql': isAdmin ? "" : " (isPublic = 1 and receiveOrgId like \'\%${user.fdepid}\%\')  ",
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:[{   
	                text:'添加',
	                iconCls:'icon-add',
	                handler:function(){
	                	$('#templateWin').dialog('open');
	                }
	            },'-',{   
	                text:'执行',
	                iconCls:'icon-ok',
	                handler:issueData
	            },'-'
	        ],
            onClickCell:function(rowIndex, field, value){
                if(field == 'templateName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    if(isAdmin){
                    	aud$editRow(row, 'templateForm', 'templateWin', 'tlInterTp');
	                    $('#tlInterTp_isPublic').combobox('setValue', row['isPublic']);
	                    $('#tlInterTp_paging').combobox('setValue', row['paging']);
	                    $('#tlInterTp_ignoreEx').combobox('setValue', row['ignoreEx']);
	                    $('#tlInterTp_beforeSaveDel').combobox('setValue', row['beforeSaveDel']);
	                    $('#tlInterTp_scheduleTask').combobox('setValue', row['scheduleTask']);
	                    setComboboxStatus(row['paging']);
                    }else{
                    	aud$viewRow(row, 'templateForm', 'templateWin', 'view');
                    	$('#view_isPublic').text(row['isPublic'] == '1' ? '公开':'私有');
                    	$('#view_paging').text(row['paging'] == '1' ? '是':'否');
                    	$('#view_ignoreEx').text(row['ignoreEx'] == '1' ? '是':'否');
                    	$('#view_beforeSaveDel').text(row['beforeSaveDel'] == '1' ? '是':'否');
                     	$('#view_scheduleTask').text(row['scheduleTask'] == '1' ? '是':'否');
                    	setComboboxStatus(row['paging']);
                    }
                }
            },	
    		columns:[[
                {field:'templateId',  title:'选择',   width:'20px', checkbox:true, align:'center', halign:'center', show:'false'},      
                {field:'templateName',title:'任务名称',width:'210px',align:'left',  halign:'center', sortable:true,	
                	fixed:true,
                	formatter:function(value,rowData,rowIndex){
                   		return  ["<label title='单击编辑或查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
                }},
                {field:'tableNameDesc', title:'源数据表中文名', width:'150px',align:'left',  halign:'center',  sortable:true},
                {field:'tableName',     title:'源数据表英文名', width:'150px',align:'left',  halign:'center',  sortable:true},
                {field:'tablePk',       title:'源数据表主键',   width:'100px',align:'left', halign:'center',sortable:true},
                {field:'attachCols',    title:'附件字段', width:'100px',align:'left', halign:'center',sortable:true},
                {field:'targetTableNameDesc',title:'目标数据表中文名', width:'150px',align:'left', halign:'center',sortable:true},
                {field:'targetTableName',    title:'目标数据表英文名', width:'150px',align:'left',   halign:'center',sortable:true},
                {field:'receiveOrgName',title:'数据接收机构', width:'200px',align:'left',  halign:'center',  sortable:true},
                {field:'executeSql',   title:'执行SQL',     width:'220px',align:'left',  halign:'center',  sortable:false},
                {field:'execSqlRemark',title:'执行SQL说明',  width:'220px',align:'left',  halign:'center',  sortable:false},
                {field:'templateRemark',title:'任务说明', width:'200px',align:'center', halign:'center',sortable:false},
                {field:'isPublic',title:'是否公开', width:'70px',align:'center', halign:'center',sortable:true,
                	formatter:function(value,rowData,rowIndex){
                   		return value == '1' ? '<strong><font color=green>公开</font></strong>':'私有' ;
                }},
                {field:'scheduleTask',     title:'是否定时任务', width:'100px',align:'center',  halign:'center',  sortable:true,
                	formatter:function(value,rowData,rowIndex){
                   		return  value == '1' ? "<strong><font color='green'>是</fornt></strong>":'否' ;
                }},
                {field:'taskLevel',     title:'任务等级', width:'80px',align:'center',  halign:'center',  sortable:true},
                {field:'paging',     title:'是否分页', width:'80px',align:'center',  halign:'center',  sortable:true,
                	formatter:function(value,rowData,rowIndex){
                   		return  value == '1' ? "<strong><font color='green'>是</fornt></strong>":'否' ;
                }},
                {field:'ignoreEx',     title:'是否忽略异常', width:'100px',align:'center',  halign:'center',  sortable:true,
                	formatter:function(value,rowData,rowIndex){
                   		return  value == '1' ? "<strong><font color='green'>是</fornt></strong>":'否' ;
                }},
                {field:'beforeSaveDel',  title:'是否清空目标数据表', width:'150px',align:'center',  halign:'center',  sortable:true,
                	formatter:function(value,rowData,rowIndex){
                   		return  value == '1' ? "<strong><font color='green'>是</fornt></strong>":'否' ;
                }},
                
                {field:'creator',   title:'创建人',   width:'110px', align:'center',  sortable:true},
                {field:'createTime',title:'创建时间', width:'140px', align:'center',  halign:'center',sortable:true},
                {field:'modifier',  title:'修改人',   width:'110px', align:'center',  sortable:true},
                {field:'modifyTime',title:'修改时间', width:'140px',  align:'center', halign:'center',sortable:true}
          ]]
        }
    });

    
    // 下发数据
    function issueData(){
    	try{
    		var ckrows = $('#templateTable').datagrid('getChecked');
    		if(ckrows && ckrows.length){
    			$('#tlLogWin').dialog('open');
    			$('#tlLogContent').html('');
    			var error = 0;
    			var success = 0;
    			var rowLen = ckrows.length;
    			for(var i = 0; i < rowLen; i++){
    				var row = ckrows[i]; 
                    $.ajax({
                        url : "${contextPath}/tlInteractive/issueData.action",
                        dataType:'json',
                        type: "post",
                        timeout:3600000,
                        data: {
                            'templateId':row.templateId,
                            'templateName':row.templateName,
                            'tableName':row.tableName,
                            'tableNameDesc':row.tableNameDesc,
                            'rowIndex':i+1
                        },
                        beforeSend:function(){
                        	frloadOpen();
                        	$('#tlLogSum').html("");
                        	return true;
                        },
                        success: function(data){
                            $('#templateTable').datagrid('clearSelections');   
                            $('#templateTable').datagrid('clearChecked');   
                            var dtype = data.type;
                            if(data.msg){
                            	var rowIndex = data.rowIndex;
                            	$('#tlLogContent').append("<div style='text-align:left;border-bottom-width:1px;border-bottom-style:solid;line-height:30px;'><strong>"+rowIndex+".&nbsp;发送【"+data.tableNameDesc+"】数据</strong></div>");
                            	var msg = data.msg;
                            	/*
                            	if(dtype == 'error'){
                            		msg = "<font color='red'><strong>"+msg+"</strong></font>";
                            	}*/
                            	var arr = msg.split("|");
                            	$.each(arr, function(j, ele){
                            		var s = "<div style='padding:5px 2px 5px 2px;word-wrap:break-word;border-bottom-width:1px;border-bottom-style:dotted;'>"+ele+"</div>"
                            		$('#tlLogContent').append(s);
                            	});
                            	$('#tlLogContent').append('</br>')
                            }
                            
                            if(dtype == 'error'){
                            	error++;
                            }else if(dtype == 'info'){
                            	success++;
                            }
                            var logContentDiv = $('#tlLogContent')[0];
                            logContentDiv.scrollTop = logContentDiv.scrollHeight;
                            
            				var tm = "执行【"+rowLen+"】个任务，成功【"+success+"】个，失败【"+error+"】个， 正在处理【"+(rowLen - success - error)+"】个。";
            				$('#tlLogSum').html(tm);
            				if(i == (error + success)){
	            				frloadClose();        					
            				}
            				
                        },
                        error:function(XMLHttpRequest, textStatus, errorThrown){
                        	if(textStatus != 'timeout'){
	                        	$('#tlLogSum').html($('#tlLogSum').text() +" 部分数据发送失败!"+textStatus);
	                        	frloadClose();
	                            top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});                       		
                        	}
                        }
                    });
    			}
    		}else{
    			showMessage1('请选择交互任务');
    		}
    	}catch(e){
    		frloadClose();
    		isdebug ? alert('issueData:\n'+e.message) : null;
    	}
    }

   
    
    $('#templateWin').dialog({
        title:'交互任务',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('templateWin');
			audEvd$clearform('templateForm');
			$('#tlInterTp_isPublic').combobox('setValue', "0");
			$('#tlInterTp_paging').combobox('setValue', "1");
			$('#tlInterTp_maxPageSize').val(100);
			setComboboxStatus("1");
		},
        buttons:[{
             text:'保存',
             id:'tpSaveBtn',
             iconCls:'icon-save',
             handler:function(){
            	 aud$saveForm('templateForm', "${contextPath}/tlInteractive/saveSqlTemplate.action", function(data){
            		 if(data){
            			 data.type == 'info' ? (g2.refresh(),$('#templateWin').dialog('close')) : null;
            			 data.msg ? showMessage1(data.msg) : null;	 
            		 }
            	 });
             }
         },{
             text:'清空',
             id:'tpClearBtn',
             iconCls:'icon-reload',
             handler:function(){
            	 audEvd$clearform('templateForm');
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#templateWin').dialog('close');
             }
         }]
    });

 	
	$('#templateTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
	
    if(isAdmin){ 	
	    g2.batchSetBtn([{'index':4, 'display':false},
	                    {'index':5, 'display':false},
	                    {'index':6, 'display':false}
	    			   ]);
	    $('.viewElement').hide();
    }else{
    	g2.batchSetBtn([{'index':1, 'display':false},
    	                {'index':2, 'display':true},
    	                {'index':3, 'display':false},
    	                {'index':4, 'display':false},
    	                {'index':5, 'display':false},
    	                {'index':6, 'display':false}]);
    	 $('.editElement, .combo').hide();
    	 $('#tpSaveBtn,#tpClearBtn').hide();
    	
    }
    
    $('#tlLogWin').dialog({
    	onClose:function(){//刷新日志
			parent.$('#tlLogIfm')[0].contentWindow.logDatagrid.refresh();   		
    	}
    });
    
	
	$('#tableNameSelectBtn').bind('click', function(){		
	    var treeTarget = $('#tableNameSelectBtn')[0];
	    var winJson = showSysTree(treeTarget,{
	        title:'请选择-源数据表',
	        treeTabTitle1:'源数据表',
	        queryBox:false, 
	        noMsg:true,
	        onlyLeafClick:true,
	        param:{
	          'rootParentId':'notnull',
	          'beanName':'TlInterTable',
	          'treeId'  :'tableName',
	          'treeText':'tableNameDesc',
	          'treeParentId':'tableId',
	          'treeOrder':'createTime',
	          'customRoot':'两级交互源数据表',
	          'allleaf':true,
	          'treeAtrributes':'targetTableName,targetTableNameDesc'
	        },                             
	 	    //onTreeClick:aud$genTemplateSql,
	 	    onAfterSure:function(dms, mcs){
	 		   var jqTree = winJson.win.param.jqtree;
	 		   var node = $(jqTree).tree('getSelected');
	 		   node ? aud$genTemplateSql(node) : null;
	 	    }
		})
	});
	
	
	$('#tlInterTp_paging').combobox({
		onSelect:function(record){
			//for(var p in record) alert(p+"="+record[p])
			setComboboxStatus(record.value);
		}
	});
	
	// 设置其它按钮的状态
	function setComboboxStatus(value){
		if(value == "0"){
			$('#tlInterTp_maxPageSize').attr('disabled','disabled');
			//$('#tlInterTp_ignoreEx').combobox('disable');
			//$('#tlInterTp_ignoreEx, #tlInterTp_beforeSaveDel').combobox('disable');
		}else if(value == "1"){
			$('#tlInterTp_maxPageSize').removeAttr('disabled','disabled');
			//$('#tlInterTp_ignoreEx').combobox('enable');
			//$('#tlInterTp_ignoreEx, #tlInterTp_beforeSaveDel').combobox('enable');
		}
	}
	
});

function aud$afterRec(nodeIds, nodeNames){
	try{         
       if(nodeNames){
	   		var arr = new String(nodeNames).split(',');
			var names = [];
			$.each(arr, function(i, name){
				names.push(name.replace('铁路局','').replace('审计和考核局',''));
			});
			var oldVal = $('#tlInterTp_templateName').val();
			//alert(typeof oldVal)
			var oldVal = oldVal.substr(oldVal.indexOf("["));
			$('#tlInterTp_templateName').val(names.join('_')+oldVal);
       }
	}catch(e){
		isdebug ? alert('aud$afterRec:\n'+e.message) : null;
	}
}


</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'>	
    	 	
	<table id='templateTable'></table>
	
	<!-- 两级交互 - 任务执行结果 -->
	<div id='tlLogWin' name='tlLogWin'  class="easyui-dialog" title="任务执行结果" style="width:80%;height:380px;"   
        	data-options="resizable:true,maximizable:true,collapsible:true,modal:true, closed:true">
        <div class='easyui-layout' fit='true' border='0'>
        	<div region='center' border='0' id='tlLogContent' style='padding:10px; overflow-y:auto; overflow-x:hidden;'></div> 
			<div region='south'  border='0'  style='height:30px;line-height:30px;overflow:hidden;'>
				<div  class='EditHead' style='display:inline;border-right-width:0px;float:left;text-align:right; width:15%;overflow:hidden;'>统计:</div>
				<div  class='editTd'   style='display:inline;border-right-width:0px;float:left;text-align:left;  width:82%;overflow:hidden;' id='tlLogSum' ></div>
			</div>
        </div>
	</div>
		
	<!-- 任务 -->
	<div id='templateWin' name='templateWin'>
		<form id='templateForm' name='templateForm'>
			<input type='hidden'  id='tlInterTp_templateId' name='tlInterTp.templateId' class="noborder  clear ">
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>源数据表</td>
					<td class="editTd" style='min-width:150px;'>
						<input type='text' title='源数据表中文名' id='tlInterTp_tableNameDesc' readonly='readonly' style='width:80%;'
						name='tlInterTp.tableNameDesc'  class="noborder required editElement clear">
						<input type='hidden' title='源数据表英文名' id='tlInterTp_tableName' name='tlInterTp.tableName'  
						class="noborder required editElement clear">
                        <a class="easyui-linkbutton editElement"  iconCls="icon-search" id='tableNameSelectBtn'></a>
                        <div id='view_tableNameDesc' class="noborder viewElement clear"  style='width:100%;'></div>
					</td>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>源数据表别名</td>
					<td class="editTd" style='min-width:150px;'>
						<input type='text' title='数据表别名' id='tlInterTp_tableAlias' style='width:85%;'
						name='tlInterTp.tableAlias'  class="noborder required editElement clear">
						<div id='view_tableAlias' class="noborder viewElement clear"  style='width:100%;'></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font color=red>*</font>源数据表主键</td>
					<td class="editTd" >
						<input type='text' title='源数据表主键' id='tlInterTp_tablePk' style='width:80%;'
						name='tlInterTp.tablePk'  class="noborder required editElement clear">
						<div id='view_tablePk' class="noborder viewElement clear"  style='width:100%;'></div>
					</td>
					<td class="EditHead" >附件字段（多个字段用逗号隔开）</td>
					<td class="editTd" >
						<input type='text' title='附件字段' id='tlInterTp_attachCols' style='width:85%;'
						name='tlInterTp.attachCols'  class="noborder editElement clear">
						<div id='view_attachCols' class="noborder viewElement clear"  style='width:100%;'></div>
					</td>
				</tr>
				<tr>	
					<td class="EditHead"><font color=red>*</font>目标数据表</td>
					<td class="editTd" style='min-width:150px;' colspan='3'>
						<input type='text' title='目标数据表中文名' id='tlInterTp_targetTableNameDesc'  style='width:26%;'
						name='tlInterTp.targetTableNameDesc'  class="noborder required editElement clear">
                         <div id='view_targetTableNameDesc' class="noborder viewElement clear" style='width:50%;display:inline;'></div>

						<input type='text' title='目标数据表英文名' id='tlInterTp_targetTableName' name='tlInterTp.targetTableName'  
						class="noborder required editElement clear" style='width:27%;'>
                         <div id='view_targetTableName' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
			    </tr>
				<tr>
					<td class="EditHead" ><font color=red>*</font>任务名称</td>
					<td class="editTd" >
						<input type='text' title='任务名称' id='tlInterTp_templateName' style='width:80%;'
						name='tlInterTp.templateName'  class="noborder required editElement clear">
						<div id='view_templateName' class="noborder viewElement clear" style='width:100%;'></div>
					</td>
					<td class="EditHead">任务是否公开</td>
					<td class="editTd" >
						<select title='任务是否公开' id='tlInterTp_isPublic' name='tlInterTp.isPublic' 
							class="easyui-combobox editElement" panelHeight='60px'>
							<option value="1">公开</option>
							<option value="0">私有</option>
						</select>
						<div id='view_isPublic' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >是否定时任务</td>
					<td class="editTd" >
						<select title='是否定时任务' id='tlInterTp_scheduleTask' name='tlInterTp.scheduleTask' 
							 data-options="editable:false"
							class="easyui-combobox editElement" panelHeight='60px'>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
						<div id='view_scheduleTask' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
					<td class="EditHead">任务等级</td>
					<td class="editTd" >
						<input type='text' title='任务等级' id='tlInterTp_taskLevel' style='width:85%;'
						name='tlInterTp.taskLevel'  class="noborder required editElement " value="">
						<div id='view_taskLevel' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
				</tr>
				
				</tr>
					<td class="EditHead">是否分页发送</td>
					<td class="editTd">
						<select title='是否分页发送' id='tlInterTp_paging' name='tlInterTp.paging' 
							 data-options="editable:false"
							class="easyui-combobox editElement" panelHeight='60px'>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
						<div id='view_paging' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
					<td class="EditHead">每页记录数</td>
					<td class="editTd">
						<input type='text' title='每页记录数' id='tlInterTp_maxPageSize' style='width:85%;'
						name='tlInterTp.maxPageSize'  class="noborder required editElement " value="100">
						<div id='view_maxPageSize' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
				</tr>
				</tr>
					<td class="EditHead">是否忽略异常</td>
					<td class="editTd">
						<select title='是否忽略异常' id='tlInterTp_ignoreEx' name='tlInterTp.ignoreEx' 
							 data-options="editable:false"
							class="easyui-combobox editElement" panelHeight='60px'>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
						<div id='view_ignoreEx' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
					<td class="EditHead">是否清空目标数据表</td>
					<td class="editTd">
						<select title='是否清空目标数据表' id='tlInterTp_beforeSaveDel' name='tlInterTp.beforeSaveDel' 
							 data-options="editable:false"
							class="easyui-combobox editElement" panelHeight='60px'>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
						<div id='view_beforeSaveDel' class="noborder viewElement clear" style='width:50%;display:inline;'></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead"><font color=red>*</font>数据接收机构</td>
					<td class="editTd" style='min-width:150px;' colspan='3'>
						<input type='text' title='数据接收机构名' id='tlInterTp_receiveOrgName' readonly='readonly' style='width:95%;'
						name='tlInterTp.receiveOrgName'  class="noborder required editElement clear">
						<input type='hidden' title='数据接收机构ID' id='tlInterTp_receiveOrgId' name='tlInterTp.receiveOrgId'  
						class="noborder required editElement clear">
                        <a class="easyui-linkbutton editElement"  iconCls="icon-search"
                            onclick="showSysTree(this,{
                                   title:'请选择-下发数据接收机构',
                                   treeTabTitle1:'接收机构', 
                                   checkbox:true,
                                   onlyLeafClick:true,
                                   noMsg:true,
                                   defaultDeptId:'${user.fdepid}',
                                   param:{
                                     'beanName':'FrReportFlowWsConfig',
                                     'customRoot':'部署节点',
                                     'rootParentId':'null',
                                     'treeId'  :'orgId',
                                     'treeText':'dpmNodeName',
                                     'treeParentId':'orgPid',
                                     'treeOrder':'createTime',
                                     'allleaf':true
                                  },
                                  onAfterSure:aud$afterRec
                         })"></a>
                         <div id='view_receiveOrgName' class="noborder viewElement clear"  style='width:100%;'></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<font color=red>*</font>执行SQL</br>
						<div style='font-size:14px;font-weight:normal;padding:10px;' class='editElement'>
							参数：':recOrgId' -- 数据接收机构ID
						</div>
					</td>
					<td class="editTd" colspan='3'>			
						<s:if test="${editable == true }">
							<textarea  title='执行SQL' id='tlInterTp_executeSql' name='tlInterTp.executeSql'  
							class="noborder required editElement clear"
							style="width:99%;height:100px;overflow:hidden;padding:10px 0px 10px 5px;"></textarea>
				        </s:if>
				        <s:else>
							<textarea  title='执行SQL' id='tlInterTp_executeSql' name='tlInterTp.executeSql'  readonly='readonly'
							class="noborder required editElement clear"
							style="border-width:0px;width:99%;height:100px;overflow:hidden;padding:10px 0px 10px 5px;"></textarea>						
						</s:else>
						<div id='view_executeSql' class="noborder viewElement clear"
							style="width:99%;height:50px;overflow:hidden;padding:10px 0px 10px 5px;"></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead">执行SQL-说明</td>
					<td class="editTd" colspan='3'>
						<textarea title='执行SQL-说明' id='tlInterTp_execSqlRemark' name='tlInterTp.execSqlRemark'  
						class="noborder editElement clear"
						style="width:99%;height:50px;overflow:hidden;padding:10px 0px 10px 5px;"></textarea>
						<div id='view_execSqlRemark' class="noborder viewElement clear"
							style="width:99%;height:50px;overflow:hidden;padding:10px 0px 10px 5px;"></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead">备注说明</td>
					<td class="editTd" colspan='3'>
						<textarea title='备注说明' id='tlInterTp_templateRemark' name='tlInterTp.templateRemark'  
						class="noborder editElement clear"
						style="width:99%;height:50px;overflow:hidden;padding:10px 0px 10px 5px;"></textarea>
						<div id='view_templateRemark' class="noborder viewElement clear"
							style="width:99%;height:50px;overflow:hidden;padding:10px 0px 10px 5px;"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>	
	
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>