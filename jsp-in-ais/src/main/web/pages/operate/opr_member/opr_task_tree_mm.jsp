<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="ais.operate.task.model.AudMember"%>
<%@ page import="ais.sysparam.util.SysParamUtil"%>
<s:text id="title" name="'项目组员列表'"></s:text>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>		
		<script lang="javascript">
		
		    
		    /**
			*	打开增加外部用户页面
			*/
			function openAddOutSystemMemberPage(){
				window.open('${contextPath}/project/members/editMember.action?projectFormId=${project_id}&addMemberOption=outSystem',750,660,'title');
			}
			
			/**
				打开添加组员页面
			*/
			function openAddMemberPage(){
			  	window.open('${contextPath}/project/members/editMember.action?projectFormId=${project_id}',750,660,'title');
			}
		   
		function checkTree(checked,userId){
				window.parent.frames['f_left'].checkTreeSelect(checked,userId);
			}

        
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
			    //$.messager.alert('提示信息','请选择项目成员!','info');
			    return false;  	
			    
          }
          
	function viewMemberInfo(user_code){
		var url = '<%=request.getContextPath()%>/mng/employee/employeeInfoView.action?ul='+user_code;
		parent.parent.addTab('tabs','人员信息详情','memeberInfoDesc',url,true);
		//window.open(url,750,660,'人员信息');
	}       
	
	function getAlLCheckedMemberData(){
    	var selectedRows = $('#myDataList').datagrid('getChecked');//返回是个数组; 
    	var flag = selectedRows && selectedRows.length>0;
        if(!flag){
            //$.messager.alert('提示信息','请选择项目成员!','info');
            $("#manuIds").val("");
        }else{
	        var str = new Array();
	        for(i=0;i <selectedRows.length;i++){
	        	 str.push(selectedRows[i].user_code);
	        	 str.push(",");
	        	 str.push(selectedRows[i].user_name);
	        	 str.push(",");
	        	 str.push(selectedRows[i].proMemberId);
	        	 str.push(",");
	        	 str.push(selectedRows[i].groupId);
	        	 if(i!=selectedRows.length-1){
	        	 	str.push(";");
	        	 }
	        }   
	        $("#manuIds").val(str.join(""));     
        }
	} 
	
	
	// 根据审计事项分配, 设置datagrid的checkbox 选中或者取消选中
	function setPMGridCheckbox(taskAssign, checked){
		//alert(taskAssign)
		/**/
		if(taskAssign){
			var rows = $('#myDataList').datagrid('getRows');
			if(rows && rows.length){
				$.each(rows, function(i, row){
					var usercode = row.user_code;
					if(usercode && taskAssign.indexOf(usercode) != -1){
						//alert(usercode+' selected')
						$('#myDataList').datagrid(checked ? 'selectRow' : 'unselectRow', i);
					}else{
                        $('#myDataList').datagrid('unselectRow',i);
                    }
				});
			}
		}else{
			$('#myDataList').datagrid('uncheckAll');
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
					border:false,
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
							halign:'center',
							align:'center'
						},
						/* {field:'group',
							title:'组别',
							halign:'center',
							align:'center', 
							width:'150px',
							sortable:true
						}, */
						{field:'user_name',
							title:'姓名',
							sortable:true, 
							width:'100px',
							halign:'center',
							align:'center',
							formatter:function(value,row,index){
							 	var rV = value;
							 	if('1'==row.work){
								 	if(row.user_code == "${user.floginname}"){
								 		rV = "<img src='/ais/pages/operate/task/person.gif' title='已分工'/>" + value;
								 	}else{
								 		rV = "<img src='/ais/cloud/images/edit.gif' title='已分工'/>" + value;
								 	}
							 	}
								return rV;
							}								
						},
						{field:'duty',
							 title:'职务', 
							 align:'center', 
							 width:'100px',
							 sortable:true
						},						
						{field:'operate',
							 title:'操作',
							 width:'120px',
							 align:'center', 
							 halign:'center',
							 sortable:false,
							 formatter:function(value,row,index){
								 if(row.isOutSystem != 'Y'){
	  								return '<a href=\"javascript:void(0)\" onclick=\"viewMemberInfo(\''+row.user_code+'\');\">人员信息</a>';
								 }else{
									return '外部审计人员';
								 }
							 }
						}
					]]   
				}); 
			});          

       </script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border='0'>
		<s:hidden name="taskPid" />
		<s:hidden name="memIds" />
		<s:hidden name="memAllIds" />
		<s:hidden name="taskTemplateId" />
		<s:hidden name="tree" />
		
		<input name="manuIds" id="manuIds"/>
		<div region="center" title="项目组成员列表" border='0'>
			<table id="myDataList"></table>
		</div>
	</body>
</html>
