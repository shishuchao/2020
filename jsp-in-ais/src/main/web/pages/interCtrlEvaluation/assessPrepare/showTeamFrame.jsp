<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>内控-准备-评价组织，添加、查看、修改小组和成员</title>
<head>
<title>评价组织</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>	
<script type="text/javascript">
$(function(){	
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var projectId = '${projectId}';
	var tabTitle = isView ? "查看" : "编辑";
	
	var groupTableId = "groupList";
	var editGroupUrl = '${contextPath}/intctet/prepare/assessScheme/editProjectGroup.action?view=${view}&projectId=${projectId}';
	var groupAddBtn = {   
        text:'新增',
        iconCls:'icon-add',
        handler:function(){
    		new aud$createTopDialog({
    			title:'项目分组添加',
    			url  :editGroupUrl,
    			width:780,
    			height:400
    		}).open();
        }
    }; 
	var groupCusToolbar = isView ? [] : [groupAddBtn,'-'];
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+groupTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'InterMemberGroup',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'groupId',
        sort  :'groupType desc, groupName asc',
		winWidth:800,
	    winHeight:250,
	    myToolbar:isView ? ['search', 'export', 'reload'] : ['delete', 'search', 'export', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        whereSql:"projectFormId = '${projectId}' ",
		//删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject)
		afterRemoveRowsFn:function(rows, gridObject){
			$('#curGroupId, #curGroupName, #curGroupType, #curGroupTypeName').val('');
			//刷新成员列表
			if(rows && rows.length){
				g2.refresh();
			}
		},
	   	//过滤选择的记录
	   	removeFilter:function(rows){
	   		var delIdArr = [];
			$.each(rows, function(i, row){
				if(row['groupType'] != "zhengti"){
					delIdArr.push(row['groupId']);
				}else{
					showMessage1("整体组不能删除");
					$('#'+groupTableId).datagrid('unselectAll');
					$('#'+groupTableId).datagrid('uncheckAll');
					return true;
				}
			});	
	   		return delIdArr;
	   	},
        gridJson:{	
        	pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
            toolbar:groupCusToolbar,
            onLoadSuccess:function(data){
            	if(data && data.rows && data.rows.length){
        			parent.$('#qtab').tabs('enableTab',3);
        			//parent.$('#qtab').tabs('select',3);
            	}
            },
        	onClickCell:function(rowIndex, field){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'groupName'){
            		new aud$createTopDialog({
            			title:'项目分组'+tabTitle,
            			url:editGroupUrl+"&groupId="+row['groupId'],
            			width:780,
            			height:400
            		}).open(); 					
                }else{//刷新成员列表
                	$('#curGroupId').val(row['groupId']);
                	$('#curGroupName').val(row['groupName']);
					$('#curGroupType').val(row['groupType']);
					$('#curGroupTypeName').val(row['groupTypeName']);
        	    	g2.refresh({
        	    		'query_eq_groupId':row['groupId']
        	    	});
                }
    		},
    		frozenColumns:[[
                {field:'groupId',  title:'选择',checkbox:true,  align:'center', halign:'center', show:'false',hidden:isView},
                {field:'groupName',title:'分组名称', width:'80px',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:function(value,row,index){
                		var ucolor = "#4169E1";
                		var r = row['groupType'];
                		var picName = "User_Clients.png";
                		if(r == "zhengti"){
                			ucolor = "#191970";
                			picName = "User_Group.png";
                		}
                		var imgStr = "<img src='${contextPath}/easyui/1.4/themes/icons/"+picName+"'></img>";
                		return [imgStr,"&nbsp;<label title='单击"+tabTitle+"' style='cursor:pointer;color:"+ucolor+";'>",value,"</label>"].join('') ;
                }}
    		]],
    		columns:[[
                {field:'groupTypeName',title:'类型', width:'60px',align:'center',   halign:'center',  sortable:true,
                	type:'custom', target:$('#queryCond22')[0]},
                {field:'belongToUnitName',title:'被评价单位', width:'70%',align:'left',   halign:'center',  sortable:true,
                	type:'custom', target:$('#queryCond44')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
                } 
          ]]
        }
    });
    window.groupList = g1;
	
    var memberTableId = "memberList";
    var editMemeberUrl = '${contextPath}/intctet/prepare/assessScheme/editProjectMember.action?view=${view}&projectId=${projectId}';
	var memberAddBtn = {   
        text:'新增',
        iconCls:'icon-add',
        handler:function(){
    		new aud$createTopDialog({
    			title:'项目组成员添加',
    			url  :editMemeberUrl,
    			width:780,
    			height:400
    		}).open();
        }
    }; 	
	var memeberCusToolbar = isView ? [] : [memberAddBtn,'-'];
    var g2 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+memberTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'InterMember',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'proMemberId',
        sort  :'groupType desc, atgroup, role asc',
		winWidth:800,
	    winHeight:250,
	    myToolbar:isView ? ['search', 'export','reload'] : ['delete', 'search', 'export', 'reload'],
	   	whereSql:"projectFormId = '${projectId}' ",
	   	//删除记录后，是否刷新列表
	   	delRefresh:false,
	   	afterRemoveRowsFn:function(rows, gridObject){
	   		var curGroupId = $('#curGroupId').val();
	   		if (curGroupId != "") {
	   			g2.refresh({
		   			"query_eq_groupId": curGroupId
		   		});
	   		} else {
	   			g2.refresh();
	   		}
	   	},
	   	//过滤选择的记录
	   	removeFilter:function(rows){
	   		var delIdArr = [];
			$.each(rows, function(i, row){
				if(row['groupType'] == "zhengti" && row['role'] == "zuzhang"){
					showMessage1("整体组-组长-不能删除");
					$('#'+memberTableId).datagrid('unselectAll');
					$('#'+memberTableId).datagrid('uncheckAll');
					return true;
				}else{
					delIdArr.push(row['proMemberId']);
				}
			});	
	   		return delIdArr;
	   	},
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	pageSize:20,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:memeberCusToolbar,
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
                if(field == 'userName'){
                	var ztleader = row['groupType'] == "zhengti" && row['role'] == "zuzhang";
            		new aud$createTopDialog({
            			title:'项目组成员'+tabTitle,
            			url  :editMemeberUrl+"&ztleader="+ztleader+"&proMemberId="+row['proMemberId'],
            			width:780,
            			height:400
            		}).open();					
                }          		
            },
			rowStyler: function(index,row){
				if (row.role == "zuzhang" || row.role == "xiaozuzhang"){
					//return 'background-color:#87CEFA;';
				}
			},
            frozenColumns:[[           	
                {field:'proMemberId',  title:'选择',checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'userName',title:'姓名', width:'120px',align:'left',   halign:'center',  sortable:true, oper:'like',
                	formatter:function(value,row,index){
                		var ucolor = "#4169E1";
                		var r = row['role'];
                		var picName = "User_16px_516303.png";
                		if(r == "zuzhang"){
                			ucolor = "#191970";
                			picName = "User_16px_516302.png";
                		}else if(r == "xiaozuzhang"){
                			ucolor = "#006400";
                			picName = "user_03.png";
                		}else if(r == "zhushen"){
                			ucolor = "#2E8B57";
                			picName = "User_16px_516303.png";
                		}else{
                			picName = "user_04.png";
                		}
                		var imgStr = "<img style='border:0px;width:16px;height:16px;' src='${contextPath}/easyui/1.4/themes/icons/"+picName+"'></img>";
                		
                		return [imgStr,"&nbsp;<label title='单击"+tabTitle+"' style='cursor:pointer;color:"+ucolor+";'>",value,"</label>"].join('') ;
                	}},
                {field:'roleName', title:'项目角色', width:'80px',align:'center', halign:'center',  sortable:true, 
                		type:'custom', target:$('#queryCond1')[0]},
                {field:'atgroup',  title:'所属分组', width:'80px',align:'center', halign:'center',  sortable:true, oper:'like'},
                {field:'groupTypeName',title:'分组类型', width:'80px',align:'center',   halign:'center',  sortable:true,
                	type:'custom', target:$('#queryCond2')[0]},
            ]],
    		columns:[[
                {field:'checkAuthority',title:'复核权限',   width:'35%',align:'left', halign:'center',  sortable:true,
                	type:'custom', target:$('#queryCond3')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
                }
          ]]
        }
    });
    window.memberList = g2;
    
    var mrStr = "${mrStr}";
    if(mrStr){
    	var mrArr = mrStr.split(",");
    	if(mrArr && mrArr.length){
    		$.each(mrArr, function(i, mrObj){
    			var arr = mrObj.split("|");
    			var mrlId = arr[0];
    			var mrlName = arr[1];
    			//alert(mrlId+"\n"+mrlName)
    			$('#query_checkAuthorityCode').append("<option value='"+$.trim(mrlId)+"'>"+$.trim(mrlName)+"</option>");
    		});
    	}
    }
	$('#query_checkAuthorityCode').combobox({
		editable:false,
		multiple:false,
		panelHeight:'auto'
	});
});

function refresh() {
	$('#groupList').datagrid('reload');
}

function memberListrefresh() {
	$('#memberList').datagrid('reload');
}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:0">
	<div region="west" border="0" style='width:40%;' title="分组" split="true">   
		<table id="groupList"></table>
	</div>
	<div region="center" border="0"  title="成员" >
		<table id="memberList"></table>
	</div>	
	<input type="hidden" id="curGroupId"/>
	<input type="hidden" id="curGroupName"/>
	<input type="hidden" id="curGroupType"/>
	<input type="hidden" id="curGroupTypeName"/>
	
	<!-- 自定义查询条件 -->	
	<div id="queryCond1">
		<select name='query_eq_role' style='background: transparent;border: 1px solid #ccc;' 
			panelHeight="auto" editable='false' class="easyui-combobox">
			<option value='' selected>全部</option>
			<option value='zuyuan'>组员</option>
			<option value='zhushen'>主审</option>
			<option value='zuzhang'>组长</option>
			<option value='xiaozuzhang'>小组长</option>
		</select>
	</div>	
	<div id="queryCond2">
		<select name='query_eq_groupType' style='background: transparent;border: 1px solid #ccc;' 
			panelHeight="auto" editable='false' class="easyui-combobox">
			<option value='' selected>全部</option>
			<option value='zhengti'>整体</option>
			<option value='fenbu'>分部</option>
		</select>
	</div>	
	<div id="queryCond22">
		<select name='query_eq_groupType' style='background: transparent;border: 1px solid #ccc;' 
			panelHeight="auto" editable='false' class="easyui-combobox">
			<option value='' selected>全部</option>
			<option value='zhengti'>整体</option>
			<option value='fenbu'>分部</option>
		</select>
	</div>	
	<div id="queryCond3">
		<select id="query_checkAuthorityCode" name='query_like_checkAuthorityCode' 
			style='background: transparent;border: 1px solid #ccc;' >
			<option value='' selected>全部</option>
		</select>
	</div>
	<div id="queryCond4">
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_belongToUnitId' class="noborder editElement clear" readonly/>
		<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
                  title:'被评价单位选择',
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
	<div id="queryCond44">
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_belongToUnitId' class="noborder editElement clear" readonly/>
		<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
                  title:'被评价单位选择',
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
</body>
<script type="text/javascript">
    //重新设置页面的topDialogTargetId
    resetTopDialogTargetId();
</script>
</html>