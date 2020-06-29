<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计作业菜单列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<link href="${contextPath}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
	 <script type="text/javascript">
	 $(document).ready(function(){
	 		$("#menuTree").tree({
	 			url:'/ais/operate/menu/menuTree.action?parentId=',
	 			animate:true,
	 			onClick:function(node){
	 					editMenu(node);
	 			},
				onLoadSuccess:function(node, data){
					$.each( data, function(i, n){
						var node = $('#menuTree').tree('find', data[i].id);
						$('#menuTree').tree('expand', node.target);
					});
				}
	 		});
	 		 $("#menuTree").tree('expandAll');

         //菜单图标窗口
         $('#iconWin').dialog({
             title: '选择菜单图标',
             width: 400,
             height: 220,
             closed: true,
             modal: true
         });

         $('#iconTable').find('td').each(function(){
             $(this).attr('style','border: 1px solid #ccc;cursor:pointer;');
         });
         $('#iconTable').on('click','td',function(){
             var icon = $(this).children('i').attr('class');
             $('#iconShow').attr('class',icon);
             $('#menuIcons').val(icon);
         });
	 	});
	
	 function editMenu(node){
		 var flag = false;
		 $.ajax({
			url:'/ais/operate/menu/edit.action?parentId='+node.attributes.parentId+"&operateMenu.menuId="+node.id,
			cache:false,
			async:false,
			success:function(data){
				$("#form").html(data);
				flag = true;
			}
		 });
		 if(flag){
			 if($('#addBtn').length > 0){
				 $('#addBtn').linkbutton({
					iconCls:'icon-add'
				 });
			 }
			 if($('#saveBtn').length > 0){
				 $('#saveBtn').linkbutton({
					 iconCls:'icon-save'
				 });
			 }
			 if($('#delBtn').length > 0){
				 $('#delBtn').linkbutton({
					 iconCls:'icon-delete'
				 });
			 }
			 $('#toolbar').datagrid({
				 toolbar:'#tools'
			 });
		 }
	 }
	 function addOperateMenu(parentId){
		 var flag = false;
		 $.ajax({
				url:'/ais/operate/menu/edit.action?add=yes&parentId='+parentId+'&operateMenu.menuId=',
				cache:false,
				async:false,
				success:function(data){
					$("#form").html(data);
					flag = true;
				}
			 });
		 if(flag){
			 if($('#saveBtn').length > 0){
				 $('#saveBtn').linkbutton({
					 iconCls:'icon-save'
				 });
			 }
			 if($('#backBtn').length > 0){
				 $('#backBtn').linkbutton({
					 iconCls:'icon-back'
				 });
			 }
			 $('#toolbar').datagrid({
				 toolbar:'#addtool'
			 });
		 }
	 }
	 
	 function backOperateMenu(menuId){
		 var flag = false;
		 var parentId = menuId.substring(0,menuId.length-2);
		 if(parentId.length<1){
			 parentId=-1;
		 }
		 $.ajax({
			url:'/ais/operate/menu/edit.action?operateMenu.menuId='+parentId,
			cache:false,
			async:false,
			success:function(data){
				$("#form").html(data);
				flag = true;
			}
		 });
		 if(flag){
			 if($('#addBtn').length > 0){
				 $('#addBtn').linkbutton({
					iconCls:'icon-add'
				 });
			 }
			 if($('#saveBtn').length > 0){
				 $('#saveBtn').linkbutton({
					 iconCls:'icon-save'
				 });
			 }
			 if($('#delBtn').length > 0){
				 $('#delBtn').linkbutton({
					 iconCls:'icon-delete'
				 });
			 }
			 $('#toolbar').datagrid({
				 toolbar:'#tools'
			 });
		 }
	 }
	 
	 function saveOperateMenu(){
		 $('#menuForm').form({  
			    url:'/ais/operate/menu/save.action',  
			    onSubmit: function(){  
			    	if($("#menuName").val()==null||$("#menuName").val()==''){
			    		showMessage1('菜单名称不能为空！');
			    		return false;
			    	}
			    	if($("#orderBy").val()==null||$("#orderBy").val()==''){
			    		showMessage1('排序不能为空！');
			    		return false;
			    	}
			    	//排序只能输入整数
			    	var reg = new RegExp("^[0-9]*$");  
			    	var obj = document.getElementById("orderBy");  
			    	if(!reg.test(obj.value)){  
			    		showMessage1("请输入数字!");  
			    	        return false;
			    	 }  
		    	   if(!/^[0-9]*$/.test(obj.value)){  
		    		   showMessage1("请输入数字!");  
			            return false;
		    	    }  
			    },  
			    success:function(data){  
			        if(data=='true'){
						top.$.messager.show({
							title:'提示消息',
							msg:"保存成功！",
							timeout:5000,
							showType:'slide'
						});
			        	window.location.reload();
			        }
			    }  
			});  
			$('#menuForm').submit(); 
	 }
	 function deleteOperateMenu(menuId,hasChild){
		 if(hasChild=='true'){
			 $.messager.confirm('提示信息','您要删除的菜单包含子菜单是否确定删除？',function(r){
				if(r) execDelete(menuId); 
			 });
		 }else{
			 $.messager.confirm('提示信息','是否确定删除？',function(r){
				if(r) execDelete(menuId); 
			 });
		 }
		 
	 }
	 function execDelete(menuId){
		 $.ajax({
				url:'/ais/operate/menu/delete.action',
				data:{'operateMenu.menuId':menuId},
				cache:false,
				success:function(data){
					if(data=='true'){
						top.$.messager.show({
							title:'提示消息',
							msg:"删除成功！",
							timeout:5000,
							showType:'slide'
						});
			        	window.location.reload();
			        }
				}
			 });
	 }
	 function changeMenuLink(value){
		 $("#menuLink").val(value);
		 $("#menuName").val($("#mc").find('option:selected').text());
	 }
     function showIconWin(){
         $('#iconWin').window('open');
     }
	 </script>	
	</head>
	<body class="easyui-layout">
		<div region="west" style="width:200px;height:600px;" split="true">
			<ul id="menuTree" style="padding:5px 0 0 5px"></ul>
		</div>
		<div region="center" id="form" style="height:600px;">
		</div>
		<!--一级菜单图标-->
		<div id="iconWin">
			<table cellpadding=0 cellspacing=0 border=0 align="center" id="iconTable" style="width: 98%;font-size: 22px;text-align: center;border-collapse: collapse;">
				<tr>
					<td><i class="icon-user" style="background: none;"/></td>
					<td><i class="icon-users"/></td>
					<td><i class="icon-speedometer"/></td>
					<td><i class="icon-screen-tablet"/></td>
					<td><i class="icon-screen-desktop"/></td>
				</tr>
				<tr>
					<td><i class="icon-settings"/></td>
					<td><i class="icon-notebook"/></td>
					<td><i class="icon-graduation"/></td>
					<td><i class="icon-envelope-open"/></td>
					<td><i class="icon-envelope-letter"/></td>
				</tr>
				<tr>
					<td><i class="icon-compass"/></td>
					<td><i class="icon-diamond"/></td>
					<td><i class="icon-directions"/></td>
					<td><i class="icon-docs"/></td>
					<td><i class="icon-drawer"/></td>
				</tr>
				<tr>
					<td><i class="icon-globe-alt"/></td>
					<td><i class="icon-folder-alt"/></td>
					<td><i class="icon-globe"/></td>
					<td><i class="icon-layers"/></td>
					<td><i class="icon-grid"/></td>
				</tr>
				<tr>
					<td><i class="icon-home"/></td>
					<td><i class="icon-like"/></td>
					<td><i class="icon-list"/></td>
					<td><i class="icon-pie-chart"/></td>
					<td><i class="icon-share"/></td>
				</tr>
				<tr>
					<td><i class="icon-support"/></td>
					<td><i class="icon-eye"/></td>
					<td><i class="icon-folder"/></td>
					<td><i class="icon-flag"/></td>
					<td><i class="icon-star"/></td>
				</tr>
				<tr>
					<td><i class="icon-paper-plane"/></td>
					<td><i class="icon-target"/></td>
					<td><i class="icon-info"/></td>
					<td><i class="icon-link"/></td>
					<td><i class="icon-heart"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>
