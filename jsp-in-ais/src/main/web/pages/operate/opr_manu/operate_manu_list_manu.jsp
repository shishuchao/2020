<!DOCTYPE HTML>
 <%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计底稿列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
	    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>
	</head>
	<body  class="easyui-layout" fit='true' border='0'>
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">	
			<s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
				<s:hidden name="manuIds2" id="manuIds2"/>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
					<td class="EditHead">项目编号</td>
						<td class="editTd">
						    <s:textfield cssClass="noborder" name="projectStartObject.project_code" maxlength="50" cssStyle="width:80%"/>
						</td>
					 <td class="EditHead" style="width:15%">项目名称</td>
						<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="audManuscript.project_name" maxlength="50" cssStyle="width:80%"/>
						</td>
					</tr>
					<tr >
					<td class="EditHead" style="width:15%">底稿名称</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="audManuscript.ms_name" maxlength="50" cssStyle="width:80%"/>
						</td>
							<td class="EditHead">撰写人</td>
						<td class="editTd">
						    <s:textfield cssClass="noborder" name="audManuscript.ms_author_name" maxlength="50" cssStyle="width:80%"/>
						</td>
						
					</tr>	
					<tr >
					<td class="EditHead">被审计单位</td>
						<td class="editTd">
						  <s:textfield cssClass="noborder" name="audManuscript.audit_dept_name" maxlength="50" cssStyle="width:80%"/>
						</td>
					<td class="EditHead">		
						项目年度
					</td>
					<td class="editTd">
						<select class="easyui-combobox" name="projectStartObject.pro_year" id="pro_year" style="width:80%"  editable="false">
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					</td>
					</tr>											
				</table>
				<s:hidden name="ifFirstQuery" value="no"/>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
		    </div>
		</div>
		<div region="center" border='0'>
			<table id="manuList"></table>
		</div>
		<script type="text/javascript">
		/*
		* 查询
		*/
		function doSearch(){
        	$("#manuList").datagrid({
				queryParams:form2Json("searchForm")
			});
    		$('#dlgSearch').dialog('close');
        }
        /*
		* 取消
		*/
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}

		//重置查询条件
		function restal(){
			resetForm('searchForm');
			//doSearch();
		}
			
		//是否选中一条记录
		function isSingle(rows){
			if(rows!=null && rows.length>0){
				if(rows.length==1){
					return true;
     			}else{
					showMessage1('请选择一条记录!');
					return false;	     			
     			}				
			}else{
				showMessage1('请选择一条记录!');
				return false;
			}	
		}			
		
     function del(){
     		var rows = $('#manuList').datagrid('getChecked');//返回是个数组
	      	if(isSingle(rows)){
	      		var row = rows[0];    
	            var groupId = row.groupId;
		        var project_id = row.project_id;   
	            var id=row.formId;
	            top.$.messager.confirm('确认对话框', '确认删除吗？', function(r){
		    		if (r){
	    			jQuery.ajax({
	    				url:'${contextPath}/operate/manuExt/manuDel.action',
	    				type:'POST',
	    				data:{"audManuscript.formId":id},
	    				dataType:'text',
	    				async:false,
	    				success:function(data){
	    					if(data == "suc") {
	    						$('#manuList').datagrid('clearSelections');
	    						doSearch();
	    						showMessage2('删除成功！');
	    					}else{
								showMessage2('删除失败！');
	    					}
	    				},
	    				error:function(){
							showMessage2('删除底稿出错了！');
	    				}
	    			});
	    		}
	    	});
	
	      }
        
      }					
     function piliangDel(){
        var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组
        
        var str = "";
        var myManu=new Array()
 		//一条数据，走单独删除
 		if(selectedRows.length < 1){
 			showMessage1('请选择一条记录!');
 			return false;
 		}		
        if(selectedRows && selectedRows.length==1){
           	del();
        }else{
        	 top.$.messager.confirm('确认对话框', "确认删除这 "+selectedRows.length+" 条数据吗？", function(r){
          	   if (r){
           for(i=0;i <selectedRows.length;i++){
                var ms_author = selectedRows[i].ms_author;
		        var ms_status = selectedRows[i].ms_status;
			  	var project_id = selectedRows[i].project_id;   
          
        		   for(i=0;i <selectedRows.length;i++){
                	   str += selectedRows[i].formId + ","; 
                           }
   			   jQuery.ajax({
   					url:'${contextPath}/operate/manuExt/manuDel.action',
   					type:'POST',
   					data:{"audManuscript.formId":str},
   					dataType:'text',
   					async:false,
   					success:function(data){
   						if(data == "suc") {
   							$('#manuList').datagrid('clearSelections');
   							doSearch();
   							showMessage2("删除成功！");
   						}else{
   							showMessage1("删除失败！");
   						}
   					},
   					error:function(){
   						showMessage1("删除底稿出错了！");
   					}
                 });	
   			   }
          	   }
           });
     	  
    	}	
     }	
			$(function(){
				showWin('dlgSearch');
				var d = new Date();
				loadSelectH();
				$('#pro_year').combobox('setValue',d.getFullYear());
				// 初始化生成表格
				$('#manuList').datagrid({
					url : "<%=request.getContextPath()%>/operate/manuExt/manuUilist.action?querySource=grid&t="+new Date().getTime(),
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit:true,
					idField:'formId',
					fitColumns: false,	
					border:false,
					singleSelect:false,
					remoteSort: false,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						},
						{
							id:'delObj',
							text:'删除',
							iconCls:'icon-delete',
							handler:function(){
								piliangDel();
							}
						}				
					],
					frozenColumns:[[
					       			{field:'formId',title:"复选框", halign:'center',checkbox:true, align:'center'},
					       			{field:'project_code',title:'项目编号',halign:'center',width:200,sortable:true,align:'center'},	
					       			{field:'project_name',title:'项目名称',halign:'center',width:200,sortable:true,align:'center'},	
		       						{field:'ms_name',title:'底稿名称',halign:'center',width:280,sortable:true,align:'left',
					       				/* formatter:function(value,row,rowIndex){
											return "<a href=\"javascript:void(0)\" onclick=\"viewManu('"+row.formId+"')\">"+row.ms_name+"</a>"
										}	 */
		       						}
					    		]],
					columns:[[  
		 /*       			{field:'manuTypeName',title:'底稿类型',halign:'center',width:80,sortable:true,align:'center',
		       				formatter:function(value,row,rowIndex){
	       						var manuTypeName = row.manuTypeName;
	       						
	       						if(null!=manuTypeName){
	       						   if ( manuTypeName == "COMPREHENSIVE"){
	       							return "综合";
	       						   }else{
	       							return "单项";  
	       						   }
							
	       						}else{
	       							return "";
	       						}
						}
		       			},	 */	
		       			{field:'task_name',title:'审计事项',halign:'center',width:350,sortable:true,align:'left'},	
		       			{field:'ms_author_name',title:'撰写人',halign:'center',width:80,sortable:true,align:'left'},
		       			{field:'audit_dept_name',title:'被审计单位',halign:'center',width:120,sortable:true,align:'left'},
		       		/* 	{field:'fileCount',title:'附件',halign:'center',width:60,sortable:true,align:'center'},	 */
		       			{field:'audit_found',title:'关联疑点',halign:'center',width:80,sortable:true,align:'left',
		       				formatter:function(value,row,rowIndex){
		       						var audit_found = row.audit_found;
		       						if(null!=audit_found){
		       						var manuId = audit_found.split(',');
									return manuId[1];
		       						}else{
		       							return "";
		       						}
							}},
		       			{field:'ms_date_view',title:'创建日期',halign:'center',width:80,sortable:true,align:'center'}
					
					]]   
				});
				//单元格tooltip提示
			 $('#manuList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				}); 
				
			});
		</script>	      
	</body>
</html> 