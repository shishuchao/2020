<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>项目分组列表</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">

$(function(){
	var projectFormId= "${projectFormId}";
	var isView = "${view}";
	var parentTabId = "${parentTabId}";
	var isView = "${view}";
	var editUrl = '${contextPath}/intctet/prepare/assessScheme/addProteam.action?view=${view}&parentTabId='+parentTabId+'&projectFormId='+projectFormId;
	var tabTitle = isView ? "查看" : "编辑";
	var addBtn = {   
            text:'新增',
            iconCls:'icon-add',
            handler:function(){
            	//aud$openNewTab('新增分组', editUrl);
            	$('#proTeamWin').dialog('open');
            }
        }; 
	
	var reloadBtn = {   
	         text:'刷新',
	         iconCls:'icon-reload',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/prepare/assessScheme/initProTeam.action?view=${view}&projectFormId="+projectFormId;
	         }
	 };
	var cusToolbar = [];	
	if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
		cusToolbar.push(reloadBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "proTeamList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'InterMemberGroup',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'groupId',
        order :'desc',
        sort  :'createTime',
		winWidth:800,
	    winHeight:250,
	    myToolbar:['delete', 'export', 'search'],
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		/*
    		if(rows){			
    			for(var i=0; i<rows.length; i++){
    				var row = rows[i];
    				alert(row.attachmentId)
    			}
    		}*/
    		return true;
    	},
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	queryParams:{'query_eq_projectFormId':"${projectFormId}"},
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'groupName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$openNewTab("项目分组"+tabTitle, editUrl+"&groupId="+row['groupId']+(isView ? "&view=true" : ""),true);
                }
            },	
    		columns:[[
                {field:'groupId',  title:'选择',checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'groupName',title:'分组名称', width:'500px',align:'center',   halign:'center',  sortable:true, oper:'like',formatter:formatterClick},
                {field:'belongToUnitName',title:'被评价单位', width:'500px',align:'center',   halign:'center',  sortable:true} 
          ]]
        }
    });
    
    window.proTeamList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    isView? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
    // 查询按钮权限
    /* g1.batchSetBtn([ {'id':gridTableId+'_search','remove':true} ]); */   
     $('#proTeamWin').show();
	
    $('#proTeamWin').dialog({
    	title:'',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('proTeamWin');
			audEvd$clearform('proMemberGroupForm');
		},
        toolbar:isView ? [{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#proTeamWin').dialog('close');
                }
            }   	
        ] : [{
             text:'保存',
             id:'listSaveBtn',
             iconCls:'icon-save',
             handler:function(){
            	 var value = $('#pmg_belongToUnitId').combobox('getText');
            	 $("#pmg_belongToUnitName").val(value);
            	 aud$saveForm('proMemberGroupForm', "${contextPath}/intctet/prepare/assessScheme/saveProteam.action?projectFormId="+projectFormId, function(data){
            		 if(data){
            			data.msg ? showMessage1(data.msg) : null;	
            			if(data.type == 'info'){
            				var groupId = data.groupId;
    						if(groupId){
            					$('#pmg_groupId').val(groupId);
    						}
    						g1.refresh();
    						$('#proTeamWin').dialog('close');
            			}
            		 }
            	 });
             }
         },{
             text:'清空',
             id:'clearBtn',
             iconCls:'icon-empty',
             handler:function(){
            	 audEvd$clearform('proMemberGroupForm');
            	 //$('#sortCode').combobox('setValues', '');
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#proTeamWin').dialog('close');
             }
         }]
    }); 
    
    function formatterClick(value){
    	return  ["<label title='单击编辑或查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }

});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='proTeamList'></table>
	<div id='proTeamWin' name='proTeamWin' style='display:none;'>
		<div region='center' border='0'>
		 <form  id='proMemberGroupForm' name='proMemberGroupForm' method="POST" > 
			<input type='hidden' id="pmg_groupId" name="pmg.groupId"  class="noborder editElement clear" value="${pmg.groupId}"/>
			<input type='hidden' id="pmg_projectFormId" name="pmg.projectFormId"  class="noborder editElement clear" value="${projectFormId}"/>
			<input type='hidden' id="pmg_groupType" name="pmg.groupType"  class="noborder editElement clear" value="${pmg.groupType}"/>
			<input type='hidden' id="pmg_groupTypeName" name="pmg.groupTypeName"  class="noborder editElement clear" value="${pmg.groupTypeName}"/>
  			 <s:hidden name="crudId"/>
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>分组名称</td>
					<td class="editTd" style="width:35%;">
					 	<input type='text' id='pmg_groupName' name='pmg.groupName' value="${pmg.groupName}"
						title='分组名称' class="noborder editElement clear required" />
						<span id='view_groupName' class="noborder viewElement clear" >${pmg.groupName}</span>  
						
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>被评价单位</td>
					<td class="editTd" style="width:35%;">
						<input type='hidden' id='pmg_belongToUnitName' name='pmg.belongToUnitName' title="被评价单位" value="${pmg.belongToUnitName}"
						  class="noborder editElement clear required" readonly/>
						 <s:if test="${view != true}">
						 	<select class="easyui-combobox" name="pmg.belongToUnitId" style="width:150px;" id="pmg_belongToUnitId" panelHeight="auto">
							   <option value="">&nbsp;</option>
							   <s:iterator value="mapss">
							       		<s:if test="${pmg.belongToUnitId == key}">
											<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
										</s:if>
								 		<s:else> 
											<option value="<s:property value="key"/>"><s:property value="value"/></option>
								 		 </s:else>  
							    </s:iterator> 
							</select>
						 </s:if>
						<s:else>
							<span id='view_belongToUnitName' class="noborder viewElement clear" >${pmg.belongToUnitName}</span>
						</s:else>
					</td>
				</tr>
				
			</table>
		 </form> 		
	  </div> 
	</div> 
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>