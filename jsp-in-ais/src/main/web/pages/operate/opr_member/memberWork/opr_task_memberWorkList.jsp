<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<title>审计分工</title>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
    </head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	    <div region="center" border='0'>
			<table id="dg"></table>
		</div>
</body>
<script type="text/javascript">
    var editIndex = undefined;
    var rowIndexdd;
	$(function(){
		//showWin('dlgSearch');
		var bodyW = $('body').width();
	    // 初始化生成表格
	    $('#dg').datagrid({
		    url:"<%=request.getContextPath()%>/project/proMemberWorkList.action?view=${view}&project_id=${project_id}&querySource=grid",
			method:'post',
			showFooter:true,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize: 20,
			fitColumns:true,
			idField:'formId',
			border:false,
			remoteSort: false,
			singleSelect:true,
			//onClickRow: onClickRow,
			 <s:if test="${view != 'view' && crudObject.prepare_closed != '1'}">
			toolbar:[{
					id:'saveWork',
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						saveWork();
					}
				}
			],
			 </s:if>
			columns: [[
				{
					field: 'userName',
					title: '姓名',
					width: 0.08 * bodyW + 'px',
					halign: 'center',
					align: 'left',
					sortable: true
				},
				{field:'roleName',title:'项目角色',width:0.08 * bodyW + 'px',halign:'center',align:'center',sortable:true},
				{
					field: 'groupName',
					title: '所属分组',
					halign: 'center',
					width: 0.1 * bodyW + 'px',
					sortable: true,
					align: 'center'
				},
				{field: 'proMemberId', title: '用户id', width: 0.1 * bodyW + 'px', align: 'left', halign: 'center', hidden: true},
				{field: 'taskAssignName', title: '已分配事项', width: 0.15 * bodyW + 'px', align: 'left', halign: 'center'},
				{
					field: 'audit_object', title: '按被审计单位分配Id', width: '2%', align: 'left', halign: 'center', hidden: true, editor: {//设置其为可编辑
						type: 'text'
					}
				},
				{
					field: 'audit_object_name', title: '按被审计单位分配', width: 0.15 * bodyW + 'px', align: 'left', halign: 'center', sortable: true,
					editor: {//设置其为可编辑
						type: 'qtree',
						options: {required: true}
					}
				},
				<s:if test="${crudObject.prepare_closed != '1'}">
				{
					field: 'sjsxfp',
					title: '按审计事项分配',
					halign: 'center',
					width: 0.1 * bodyW + 'px',
					align: 'center',
					sortable: true,
					formatter: function (value, rowDate, rowIndex) {
						var a = "";
						<s:if test="${view != 'view'}">
						var groupId = rowDate.group.groupId
						var roleGroupIds = "${roleGroupIds}";

						if ("${roleView}" == "1" || (roleGroupIds != null && roleGroupIds != "" && roleGroupIds.indexOf(groupId) != -1)) {
							t = "1";
							a = '<a href="javascript:;"  onclick="editTaskBtn(\'' + rowDate.group.groupId + '\',\'' + rowDate.proMemberId + '\')">分配审计事项</a>';
						}
						</s:if>
						if (a == "") {
							a = '<a href="javascript:;"  onclick="viewTaskBtn(\'' + rowDate.group.groupId + '\',\'' + rowDate.proMemberId + '\')">分配审计事项</a>';
						}
						return a;
					}

				},
				</s:if>
				{
					field: 'workExplain',
					title: '分工说明',
					halign: 'center',
					width: 0.15 * bodyW + 'px',
					align: 'center',
					sortable: true,
					editor: {
						type: 'text'
					}
				}

			]],
		    
    	onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
    		editIndex = undefined;//重置
    	},
    	onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
   		  <s:if test="${view != 'view'}">
  		    var rows = $("#dg").datagrid("getRows");
		    var row = rows[rowIndex];//index为行号
		    var groupId = row.group.groupId
   		    var roleGroupIds = "${roleGroupIds}";
   		    if ("${roleView}" == "1" || ( roleGroupIds != null && roleGroupIds != "" && roleGroupIds.indexOf(groupId) != -1)){
   	       		if (editIndex != undefined) {
   	       			$("#dg").datagrid('endEdit', editIndex);//结束编辑，传入之前编辑的行
   	       		}
   	       		if (editIndex == undefined) {
   	       			$("#dg").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
   	       			editIndex = rowIndex;
   	       		}
   	       		rowIndexdd = rowIndex;
   		    }
         </s:if>
       }
		});
		//单元格tooltip提示
		$('#dg').datagrid('doCellTip', {
			position : 'bottom',
			maxWidth : '200px',
			tipStyler : {
				'backgroundColor' : '#EFF5FF',
				borderColor : '#95B8E7',
				boxShadow : '1px 1px 3px #292929'
			}
		
		});
		
	});
	
	// 保存信息
	function saveWork(){
		endEditing();
		var rows = $("#dg").datagrid('getChanges');
		var m = "1";
		for( var i =0;i<rows.length;i++){
			if (rows[i].workExplain.length >100){
				m ="2";
			}
		}
		var rowstr = JSON.stringify(rows);
		if ( m == "1"){
			$.ajax({
				url:'<%=request.getContextPath()%>/project/saveMemberWork.action',
				type:'post',
				async:false,
				data:{
					'rowstr': rowstr
				},
				success:function(data){
					if ( data == "1"){
						top.$.messager.show({title:'提示消息',msg:'保存成功！'});
						$("#dg").datagrid('reload');
					}else{
						$.messager.show({title:'提示消息',msg:'保存失败！'})
					}
				}
			})
		}else{
			$.messager.show({title:'提示消息',msg:'分工说明字段长度不能大于100字！'})	
		}

	}
	
    function endEditing() {
        if (editIndex == undefined) {
            return true
        }
        if ($('#dg').datagrid('validateRow', editIndex)) {
            $('#dg').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }

/*     function onClickRow(index) {
        if (editIndex != index) {
            if (endEditing()) {
                $('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
                editIndex = index;
            } else {
                $('#dg').datagrid('selectRow', editIndex);
            }
        }
        alert(123)
		rowIndexdd = rowIndex;
    } */

    function accept() {
        if (endEditing()) {
            $('#dg').datagrid('acceptChanges');
        }
    }

    function reject() {
        $('#dg').datagrid('rejectChanges');
        editIndex = undefined;
    }

    function getChanges() {
        var rows = $('#dg').datagrid('getChanges');
        alert(rows.length + ' rows are changed!');
    }
    
	
	function editTaskBtn(group_id,proMemberId){
		if ( "${audProgramme}" == "1"){
			var temp = '${contextPath}/operate/task/project/mainReadyMemberWork.action?project_id=${project_id}&group_id='+group_id+"&proMemberId="+proMemberId;
			   // window.parent.addTab('tabs','审计分组分工','tempframe123',temp,true);
				aud$openNewTab('审计人员分工',temp,true);
		}else{
			$.messager.show({title:'提示消息',msg:'请先创建实施方案！'})	;
		}

	}
	
	function viewTaskBtn(group_id,proMemberId){
		if ( "${audProgramme}" == "1"){
			var temp = '${contextPath}/operate/task/project/mainReadyMemberWork.action?view=view&project_id=${project_id}&group_id='+group_id+"&proMemberId="+proMemberId;
			aud$openNewTab('审计人员分工查看',temp,true);
		}else{
			$.messager.show({title:'提示消息',msg:'请先创建实施方案！'})	;
		}

	}
	
	
	$.extend($.fn.datagrid.defaults.editors, {    
	    qtree: {    
	        init: function(container, options){
	        	var wrap = $('<div></div>').appendTo(container);
	            var input = $('<input type="text" style="width:80%" readonly>').appendTo(wrap[0]).bind('click', function(){
	            	trigger.trigger('click');
	            }); 
	            input.validatebox(options);
	            
	            $('<input type="hidden" readonly>').appendTo(wrap[0]);
	            var trigger = $("<label></label>")
               .appendTo(wrap[0]).bind('click', function(){
	            	aud$editorQtree(this);
	            });
	            return input;    
	        },    
	        getValue: function(target){ 
	            return $(target).val();    
	        },    
	        setValue: function(target, value){   
	            $(target).val(value);    
	        },    
	        resize: function(target, width){    
	            var input = $(target);    
	            if ($.boxModel == true){    
	                input.width(width - (input.outerWidth() - input.width()));    
	            } else {    
	                input.width(width);    
	            }    
	        }
	    }    
	}); 

	

	function aud$editorQtree(target){
		var rowIndex = rowIndexdd;
		var rows = $("#dg").datagrid("getRows");
		var row = rows[rowIndex];//index为行号
		var auditObject = row.group.auditObject
		var s = "";
		var g = auditObject.split(",");
		for( var i=0;i<g.length;i++){
			s +="'"+g[i]+"',";
		}
		if (s != ""){
			s = s.substr(0,s.length-1);
		}
		s = " id in ("+s+")";
		var audittree = showSysTree(target,
				{ 
		    title:'请选择被审计单位',
		    checkbox:true,
		    cache:false,
			param:{
				'serverCache':false,
		        "whereHql":s,
			  	"rootParentId":"auditingObjectnull",
                "beanName":"AuditingObject",
                "treeId"  :"id",
                "treeText":"name",
                "treeParentId":"parentId",
               "treeOrder":"currentCode"
		   },
		   onAfterSure:function(){
		 		var jqTree = audittree.win.param.jqtree;
				var nodes = $(jqTree).tree('getChecked');
				var ids ="";
				var texts = "";
				for(var i= 0;i<nodes.length;i++){
					ids += nodes[i].id+",";
					texts += nodes[i].text+",";
				}
				if(ids){
					ids = ids.substr(0,ids.length-1);
				}
				if(texts){
					texts = texts.substr(0,texts.length-1);
				}
				var row = $('#dg').datagrid('getRows')[rowIndex];
				//row.audit_object = ids;
				$('#dg').data('audit_object', ids);
				row.audit_object_name = texts;
				
		   } 
		}); 
	}
</script>
</html>