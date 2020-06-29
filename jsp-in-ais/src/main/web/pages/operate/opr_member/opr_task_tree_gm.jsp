<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="ais.operate.task.model.AudMember"%>
<%@ page import="ais.sysparam.util.SysParamUtil"%>
<s:text id="title" name="'项目组员列表'"></s:text>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>		
	<script lang="javascript">
		
       function closeGenM(){
         window.parent.closeGenW('MS');
         window.close()
       }
 
         function checkSelect(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			       if(checkbox[i].checked==true){
			        return true;
			       }
			    }
			    //$.messager.alert('提示信息','请选择项目小组!','info');
			    return false;  	
			    
          }
	
	function getAlLCheckedGroupData(){
    	var selectedRows = $('#myDataList').datagrid('getChecked');//返回是个数组; 
    	var flag = selectedRows && selectedRows.length>0;
        if(!flag){
            //$.messager.alert('提示信息','请选择请项目小组!','info');
            $("#manuIds").val("");
        }else{
	        var str = new Array();
	        for(i=0;i <selectedRows.length;i++){
	        	 str.push(selectedRows[i].user_code);
	        	 str.push(",");
	        	 str.push(selectedRows[i].user_name);
	        	 if(i!=selectedRows.length-1){
	        	 	str.push(";");
	        	 }
	        }   
	        $("#manuIds").val(str.join(""));     
        }
	}   
          
			$(function(){
				// 初始化生成表格
				$('#myDataList').datagrid({
					url : "<%=request.getContextPath()%>/operate/task/project/showContentEditGroupOrMember.action?querySource=grid&project_id=${project_id}&gm=${gm}&taskPid=${taskPid}&taskTemplateId=${taskTemplateId}&t="+new Date().getTime() ,
					method:'post',
					showFooter:false,
					rownumbers:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					//如果有此字段，通过getChecked只能获取一个值，而不能获取多选的所有值
					//idField:'id',	
					border:false,
					singleSelect:false,
					remoteSort: false,
					onCheck:function(index,row){
						checkTree(true,row.user_code);
					},			
					onUncheck:function(index,row){
						checkTree(false,row.user_code);
					},									
					columns:[[
						{field:'user_code',
							title:"选择",
							checkbox:true,
							align:'center'},
						{field:'user_name',
							title:'组名',
							halign:'center',
							align:'left', 
							sortable:true,
							formatter:function(value,row,index){
								var rV = value;
								if('1'==row.work){
									rV = "<img src='/ais/cloud/images/edit.gif' title='已分工'/>" + value;
								}
							 	return rV;
							}								
						}				
					]]   
				}); 
			});          
			function checkTree(checked,userId){
				window.parent.frames['f_left'].checkTreeSelect(checked,userId);
			}
       </script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:hidden name="project_id" />
		<s:hidden name="taskPid" />
		<s:hidden name="taskTemplateId" />
		<s:hidden name="tree" />
		<s:hidden name="path" />
		<s:hidden name="node" />	
					
		<input name="manuIds" id="manuIds"/>
		<div region="center" title="项目小组列表">
			<table id="myDataList"></table>
		</div>
	</body>
</html>
