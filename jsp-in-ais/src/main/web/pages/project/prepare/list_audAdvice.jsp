<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题一览</title>
		<link href="${pageContext.request.contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="overflow:hidden;" class="easyui-layout">
		  <div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="true"  style="width:600px;height:300px;overflow:hidden">
		<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 584px; height: 234px;">
		<s:form id="myForm" action="list" method="post" namespace="/project/prepare/audAdvice" >
			<table class="ListTable" align="center">
				<tr >
					<td align="left" class="EditHead">
						项目计划编号
					</td>
					<td align="left" class="editTd">
					<input id="plan_code" name="projectStartObject.plan_code" class="easyui-textbox" >
					<!--<s:textfield id="plan_code" name="projectStartObject.plan_code" cssClass="noborder" />-->
					</td>
					<td align="left" class="EditHead">
						项目名称
					</td>
					<td align="left" class="editTd">
						<input id="project_name" name="projectStartObject.project_name" class="easyui-textbox" >
						<!--<s:textfield name="projectStartObject.project_name" id="project_name" cssClass="noborder"/> -->
					</td>
				</tr>
			  <tr >
					<td align="left" class="EditHead">
						审计通知书编号
					</td>
					<td align="left" class="editTd">
						<input id="audit_notice_code" name="projectStartObject.audit_notice_code" class="easyui-textbox" >
						<!--<s:textfield id="audit_notice_code" name="projectStartObject.audit_notice_code" cssClass="noborder" />-->
					</td>
					<td align="left" class="EditHead">
							文件名称
					</td>
					<td align="left" class="editTd">
						<input id="fileName" name="fileBean.fileName" class="easyui-textbox" >
						<!--<s:textfield id="fileName" name="fileBean.fileName" cssClass="noborder" />-->
					</td>
				</tr>  
				<tr>
					<td align="left" class="EditHead">
						项目年度
					</td>
					<td align="left" class="editTd">
						<!-- <input id="pro_year" name="projectStartObject.pro_year" class="easyui-textbox" > -->
						<select id="pro_year" class="easyui-combobox" name="projectStartObject.pro_year" style="width:163px;height:23px;" data-options="panelHeight:'auto',editable:false">
						   <option value="">&nbsp;</option>
						   <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)">
							 <s:if test="${projectStartObject.pro_year==key}">
								<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
							 </s:if>
							 <s:else>
								 <option value="<s:property value="key"/>"><s:property value="value"/></option>
							 </s:else>
						   </s:iterator>
						</select>
					</td>
				</tr>
			</table>
			<s:hidden name="ifFirstQuery" value="no"/>
		</s:form>
		</div>
		<div region="south" border="false" style="text-align: right; padding-right: 20px; width: 566px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
			<div style="display: inline;" align="right">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetBook()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div>
	
	
	
	
	
<div id="listaudAdvice">
		</div>
	<div id='atTreeWrap' title='审计通知书编号' style='overflow:hidden;padding:0px;'>
		 	 <div style="text-align:left;padding:0 0 2px 5px;padding-top:30px;"><!-- 审计通知书编号:&nbsp;&nbsp; -->
		 	    <span id="contion_tong"></span>
              
               	<s:hidden name="contion_tongname" id="contion_tongcode"/>
               	
               	
		 	    <s:textfield id="contion_year"  maxLength="4" cssStyle="width:12%;height:24px;padding-top:5px;" ></s:textfield>&nbsp;&nbsp;
		 	  
		 	   <span id="contion_kuohao"></span>
            
              <s:textfield id="contion_audAdviceNum"  maxLength="6" cssStyle="width:15%;height:24px;padding-top:5px;" ></s:textfield>
               	
               	 <span id="contion_hao"></span>
		 	  &nbsp;&nbsp;
		 	    <a id='sureAtBook'  class="easyui-linkbutton"  iconCls="icon-save">确定</a>&nbsp;&nbsp;
		 		<a  id='clearAtBook'  class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>&nbsp;&nbsp;
		 	  </div> 
		 	</div> 
</body>
<script type="text/javascript">
 $(function(){
	 setDefaultSearchTime();
	$('#listaudAdvice').datagrid({
		url : "<%=request.getContextPath()%>/project/prepare/audAdvice/list.action?querySource=grid",
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
		singleSelect:true,
		remoteSort: false,

		toolbar:[{id:'changeLedgerNum',text:'审计通知书编号调整',iconCls:'icon-edit',
			handler:function(){
				changeAuditNoticeNum();
			}
		},
		 {id:'searchaudAdviceOwner',text:'查询',iconCls:'icon-search',
			handler:function(){
				searchaudAdviceOwner();
			}},
				{id:'viewaudAdviceOwner',text:'查看',iconCls:'icon-view',
			handler:function(){
				viewaudAdvice();
			}},
		{id:'editaudAdviceOwner',text:'修改',iconCls:'icon-edit',
			handler:function(){
				audAdviceModify();
			}} 
	 ],
	 frozenColumns:[[
	             	{field:'plan_code', title:'项目计划编号',width:150,halign:'center',align:'left',sortable:true}, 
					{field:'project_name', title:'项目名称',width:150,halign:'center',align:'left',sortable:true}, 
					{field:'audit_notice_code', title:'审计通知书编号',width:170,halign:'center',align:'left',sortable:true,
						sorter:function( value1,value2 ) {
							value1Temp1 = parseInt( value1.substring( 4,8 ) );
							value1Temp2 = parseInt( value1.substring( 9,value1.length-1 ) );
							value2Temp1 = parseInt( value2.substring( 4,8 ) );
							value2Temp2 = parseInt( value2.substring( 9,value2.length-1 ) );				
							if( value1Temp1 == value2Temp1 ) {
								return ( value1Temp2 > value2Temp2?1:-1 );
							}else{
								return ( value1Temp1 > value2Temp1?1:-1 );
							}
						}		
					}, 
	]],
	 columns:[[ 
			
				{field:'fileName', title:'文件名称',width:150,halign:'center',align:'left',sortable:true}, 
				{field:'audit_dept_name', title:'审计单位',width:150,halign:'center',align:'left',sortable:true}, 
				{field:'audit_object_name', title:'被审计单位',width:150,halign:'center',align:'left',sortable:true}, 
				{field:'uploader_name', title:'创建人',width:120,halign:'center',align:'left',sortable:true},
				{field:'pro_year', title:'项目年度',width:120,halign:'center',align:'left',sortable:true
				/* 	formatter:function(value,rowData,rowIndex){
						if(value != null){ 
							return value.substring(0,10);
						}
					 } */
				}, 
			]] 
		});
	$('#listaudAdvice').datagrid('sort', 'audit_notice_code');// 排序一个列
	$('#listaudAdvice').datagrid('sort', { // 指定了排序顺序的列
		sortName: 'audit_notice_code',
		sortOrder: 'asc'
	});
 });

 function setDefaultSearchTime(){
	 var currentDate = new Date();
	 currentDateYear = currentDate.getFullYear();
	 if('${projectStartObject.pro_year}' == null||'' == '${projectStartObject.pro_year}'){
		$('#pro_year').combobox('setValue',currentDateYear);
	}
 }
 
function audAdviceModify(){
	 var ids = $('#listaudAdvice').datagrid('getSelections');
		if (ids.length  != 1 ) {
			$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
			return false;
		}
	  var fileId = ids[0].fileId;
	window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId='+fileId+'','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')

}
 function viewaudAdvice(){
	 var ids = $('#listaudAdvice').datagrid('getSelections');
		if (ids.length  != 1 ) {
			$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
			return false;
		}
	  var fileId = ids[0].fileId; 
	window.open('${contextPath}/commons/file/downloadFile.action?fileId='+fileId+'','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')

 }
 
 function changeAuditNoticeNum(){
	   
	 var ids = $('#listaudAdvice').datagrid('getSelections');

		if (ids.length  != 1 ) {
			$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
			return false;
		}
	  var idV = ids[0].project_id;
	
		$.messager.confirm('提示信息', '确定要更改通知书编号吗?', function(is){
			if(is){
 	    $.ajax({
				  url:"${contextPath}/project/prepare/audAdvice/changeaudAdviceNum.action",
				  type:'POST',
				   data: {"project_id":idV},
				  success: function(data){
						if(data.tong != null && data.tong !=""){
							document.getElementById('contion_tong').innerHTML=data.tong;	
							$("#contion_tongcode").val(data.tong);
							$("#contion_year").val(data.year);
							document.getElementById('contion_kuohao').innerHTML="）";	
							$("#contion_audAdviceNum").val(data.audAdviceNum);
			                document.getElementById('contion_hao').innerHTML=data.hao;
							$('#atTreeWrap').window('open');
						}else{
							$.messager.show({title:'提示信息',msg:'原编码错误 ！'});
						}
				  }
			   }); 
			
    } ;
		 }); 
} 
 jQuery(document).ready(function(){
	 $('#atTreeWrap').window({   
			width:500,   
			height:150,   
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true
		}); 
	 	$('#sureAtBook').bind('click',function(){
		
			
			var ids = $('#listaudAdvice').datagrid('getSelections');
			if (ids.length  != 1 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
		
			var idV = ids[0].project_id;
			var contion_tongcode = $("#contion_tongcode").val();
			var contion_year = $("#contion_year").val();
			var contion_audAdviceNum = $("#contion_audAdviceNum").val();
			
			if(contion_year != null && contion_year != ""  ){
				  var  vatest=/^[0-9]*[1-9][0-9]*$/;
				  var va= vatest.test(contion_year);
				  if(!va){
						$.messager.show({title:'提示信息',msg:'输入必须为整数数字！'});
					  return false;
				   }
				  
				  var va1= vatest.test(contion_audAdviceNum);
				  if(!va1){
						$.messager.show({title:'提示信息',msg:'输入必须为整数数字！'});
					  return false;
				   }
				  
				 var  audAdviceNum=contion_tongcode+contion_year+"）"+contion_audAdviceNum+"号";
				 $.ajax({
					  url:"${contextPath}/project/prepare/audAdvice/editaudAdviceNum.action",
					  type:'POST',
					   data: {"project_id":idV,"audAdviceNum":audAdviceNum},
					  success: function(data){
							 if(data.saveaudAdviceNum == 1){
								 $.messager.show({title:'提示信息',msg:'保存编号成功 ！'});
						
									$.messager.confirm('提示信息', '请编辑通知书编号！', function(is){
										if(is){
											$("#myForm").submit();	
										}
									});
							}else if (data.saveaudAdviceNum == 0){
								$.messager.show({title:'提示信息',msg:'审计通知书编号已经存在！'});
							}else{
								$.messager.show({title:'提示信息',msg:'保存失败 ！'});
							}  
							
					  }
				   });
				
				
				
			}else{
				$.messager.show({title:'提示信息',msg:'审计通知书编号不能为空 ！'});
			}
		});    
		$('#clearAtBook').bind('click',function(){
			$('#atTreeWrap').window('close');
			}); 
});	
 
 /* 
  查询 
  */
  	function searchaudAdviceOwner(){
  		$('#dlgSearch').dialog('open');
	}	
 
 function doSearch(){
	 $("#listaudAdvice").datagrid({
 		queryParams:form2Json('myForm')
 	});
		$('#dlgSearch').window('close')
 }
	/*
	* 重置
	*/
	function resetBook(){
		resetForm('myForm');
		doSearch();
	}
	/*
	* 取消
	*/
	function doCancel(){
		$('#dlgSearch').dialog('close');
	}
</script>

</html>