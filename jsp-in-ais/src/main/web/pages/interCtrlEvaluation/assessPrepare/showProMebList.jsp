<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML >
<html>
<title>项目组员列表</title>
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
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

<script type="text/javascript">
$(function(){
	initCombobox('pm_checkAuthority');
	var isView = "${view}";
	var projectFormId = "${projectFormId}";
	var parentTabId = "${parentTabId}";
	var curTabId = "${curTabId}";
	var curTabId2 = aud$getActiveTabId();
	var tabTitle = isView ? "查看" : "编辑";
	var editUrl = '${contextPath}/intctet/prepare/assessScheme/editMember.action?view=${view}&parentTabId='+parentTabId+'&projectFormId='+projectFormId;
	var addBtn = {   
            text:'新增',
            iconCls:'icon-add',
            handler:function(){
            	//aud$openNewTab('新增项目成员', editUrl);
            	$('#proMemberWin').dialog('open')
            }
        };  
	var reloadBtn = {   
	         text:'刷新',
	         iconCls:'icon-reload',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/prepare/assessScheme/initProMeb.action?view=${view}&projectFormId="+projectFormId;
	         }
	 };
	var cusToolbar = [];	
	if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
		cusToolbar.push(reloadBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "proMebList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'InterMember',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'proMemberId',
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
                if(field == 'atgroup'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$openNewTab("项目组员"+tabTitle, editUrl+"&proMemberId="+row['proMemberId']+(isView ? "&view=true" : ""),true);
                }
            },	
    		columns:[[
                {field:'proMemberId',  title:'选择',checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'atgroup',title:'所属分组', width:'200px',align:'center',   halign:'center',  sortable:true, oper:'like',formatter:formatterClick},
                {field:'userName',title:'姓名', width:'200px',align:'center',   halign:'center',  sortable:true}, 
                {field:'roleName', title:'项目角色', width:'200px',align:'center', halign:'center',  sortable:true, oper:'like'},
                {field:'checkAuthority',title:'复核权限', width:'200px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'belongToUnitName',  title:'所属单位', width:'200px',align:'center', halign:'center',  sortable:true, show:false}
          ]]
        }
    });
    
    window.proMebList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    isView? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
    // 查询按钮权限
    /* g1.batchSetBtn([ {'id':gridTableId+'_search','remove':true} ]); */   
  
     $('#proMemberWin').show();
	
    $('#proMemberWin').dialog({
    	title:'',
        closed:true,
        collapsible:true,
        modal:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('proMemberWin');
			audEvd$clearform('proMemberForm');
		},
        toolbar:isView ? [{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#proMemberWin').dialog('close');
                }
            }   	
        ] : [{
             text:'保存',
             id:'listSaveBtn',
             iconCls:'icon-save',
             handler:function(){
            	 var value = $('#pm_role').combobox('getText');//角色
            	 $("#pm_roleName").val(value);
            	 var groupId = $('#pm_groupId').combobox('getText');//所属分组
        		 $("#pm_atgroup").val(groupId);
            	 aud$saveForm('proMemberForm', "${contextPath}/intctet/prepare/assessScheme/saveProMember.action?projectFormId="+projectFormId, function(data){
            		 if(data){
            			data.msg ? showMessage1(data.msg) : null;	
            			if(data.type == 'info'){
            				var proMemberId = data.proMemberId;
    						if(proMemberId){
    							 $('#pm_proMemberId').val(proMemberId);
    						}
    						g1.refresh();
    						$('#proMemberWin').dialog('close');
            			}
            		 }
            	 });
             }
         },{
             text:'清空',
             id:'clearBtn',
             iconCls:'icon-empty',
             handler:function(){
            	 audEvd$clearform('proMemberForm');
            	 //$('#sortCode').combobox('setValues', '');
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#proMemberWin').dialog('close');
             }
         }]
    });

    function formatterClick(value){
    	return  ["<label title='单击编辑或查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }

    
    function initCombobox(id){  
        var value = "";  
        //加载下拉框复选框  
        $('#'+id).combobox({  
            url:'${contextPath}/intctet/prepare/assessScheme/getComboboxData.action', //后台获取下拉框数据的url  
            method:'post',  
            panelHeight:200,//设置为固定高度，combobox出现竖直滚动条  
            valueField:'CODE',  
            textField:'NAME',  
            multiple:true,  
           formatter: function (row) { //formatter方法就是实现了在每个下拉选项前面增加checkbox框的方法  
                var opts = $(this).combobox('options');  
                return '<input type="checkbox" class="combobox-checkbox">' + row[opts.textField]  
            },  
           onLoadSuccess: function () {  //下拉框数据加载成功调用  
                var opts = $(this).combobox('options');  
                var target = this;  
                var values = $(target).combobox('getValues');//获取选中的值的values  
               $.map(values, function (value) {  
                    var el = opts.finder.getEl(target, value);  
                   el.find('input.combobox-checkbox')._propAttr('checked', true);   
              })  
           },  
           onSelect: function (row) { //选中一个选项时调用  
                var opts = $(this).combobox('options');  
                //获取选中的值的values  
               $("#"+id).val($(this).combobox('getValues'));  
                 
               //设置选中值所对应的复选框为选中状态  
                var el = opts.finder.getEl(this, row[opts.valueField]);  
                el.find('input.combobox-checkbox')._propAttr('checked', true);  
          },  
            onUnselect: function (row) {//不选中一个选项时调用  
                var opts = $(this).combobox('options');  
                //获取选中的值的values  
                $("#"+id).val($(this).combobox('getValues'));  
                var el = opts.finder.getEl(this, row[opts.valueField]);  
               el.find('input.combobox-checkbox')._propAttr('checked', false);  
            }  
        });  
    }  

});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='proMebList'></table>
	<div id='proMemberWin' name='proMemberWin' style='display:none;'>
		<div region='center' border='0'>
		<form  id='proMemberForm' name='proMemberForm' method="POST" >
	 	    <input type='hidden' id="pm_projectFormId" name="pm.projectFormId"  class="noborder editElement clear" value="${projectFormId}"/>
			<input type='hidden' id="pm_proMemberId" name="pm.proMemberId"  class="noborder editElement clear" value="${pm.proMemberId}"/>
			
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>所属小组</td>
					<td class="editTd" style="width:35%;">
					   <input type='hidden' id="pm_atgroup" name="pm.atgroup"  class="noborder editElement clear" value="${pm.atgroup}"/>
						 <s:if test="${view != true}">
						 	<select class="easyui-combobox" name="pm.groupId" style="width:150px;" id="pm_groupId"  panelHeight="auto">
							   <option value="">&nbsp;</option>
							   <s:iterator value="allgroupName">
							       		<s:if test="${pm.groupId== key}">
											<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
										</s:if>
								 		<s:else> 
											<option value="<s:property value="key"/>"><s:property value="value"/></option>
								 		 </s:else>  
							    </s:iterator> 
							</select>
						 </s:if>
						<s:else>
							<span id='view_atgroup' class="noborder viewElement clear" >${pm.atgroup}</span>
						</s:else>
					</td>
					<td class="EditHead"><font class="editElement"  color=red>*</font>项目角色</td>
					<td class="editTd">
					<input type='hidden' id='pm_roleName' name='pm.roleName' title="项目角色" value="${pm.roleName}"
						  class="noborder editElement clear required" readonly/>
					 <s:if test="${view != true}">
						<select class="easyui-combobox" id="pm_role" name="pm.role" style="width:80%;" panelHeight="auto">
						   	   	<option value="">&nbsp;</option>
								<s:iterator value="@ais.project.ProjectUtil@getProRolesList()" id="yeartype">
						       	<option value="<s:property value="key"/>"><s:property value="value"/></option>
						    	</s:iterator>
						</select>
					</s:if>
					<s:else>
						<span id='view_roleName' class="noborder viewElement clear" >${pm.roleName}</span>
					</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>姓名</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='pm_userName' name='pm.userName' title="人员" value="${pm.userName}"
						 class="noborder editElement clear required" readonly/>
						<input type='hidden' id='pm_userId' name='pm.userId' title="人员Code"  value="${pm.userId}"
						class="noborder editElemepmnt clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
                                  title:'请选择姓名',
                                  type:'treeAndUser',
                                 // defaultDeptId:'${user.fdepid}',
                                  //defaultUserId:'${user.floginname}',
                                  // 是否显示复选框
                                  checkbox:true,
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
						})"></img>
						<span id='view_userName' class="noborder viewElement clear" style='width:50%;display:inline;'>${pm.userName}</span>
						
					<td class="EditHead">复核级次</td>
					<td class="editTd">
 						 <input id='pm_checkAuthority' name='pm.checkAuthority' class="easyui-combobox  noborder editElement clear"
						title='复核级次' style="width: 240px;" panelHeight="auto" />  
					</td>
				</tr>
			</table>
			
		</form>			
	</div>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
   <!-- 自定义查询条件 -->
   
</body>
</html>