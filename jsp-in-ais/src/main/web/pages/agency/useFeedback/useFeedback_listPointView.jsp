<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>查询</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head> 

	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">


 	  <div id="dlgSearch" class="searchWindow" title="查询条件" >
		    <div class="search_head">
		  <s:form   id="myForm" action="getListuseFeedback" namespace="/agency/useFeedback" method="post">
		     <table class="ListTable" align="center">
		       <tr>
		         <td class="EditHead" align="left" style="width:15%">服务企业</td>
		         <td class="editTd" align="left" style="width:35%">
		         	 <s:textfield name="useFeedback.serviceEnterpriseName" title="服务企业" maxlength="100" cssClass="noborder"/>
		         </td>
		         <td class="EditHead" align="left" style="width:15%">所属年度</td>
		         <td class="editTd" align="left" style="width:35%">
	        		<select editable="false" id="year1" name="useFeedback.year"  style="width:35%;">
				            	<option value="">&nbsp;</option>

							   <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)">
								 <s:if test="${useFeedback.year==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
								 </s:if>
								 <s:else>
									 <option value="<s:property value="key"/>"><s:property value="value"/></option>
								 </s:else>
							   </s:iterator>
						</select>
						<input type="hidden" id="year" name="useFeedback.year" />
		        </td>
		       </tr>
		      <tr>
		         <td class="EditHead" align="left" style="width:15%">得分</td>
		         <td class="editTd" align="left" colspan="3">
		         	<s:textfield name="useFeedback.pointStart" cssStyle="width:75px;" title="得分" maxlength="10"  onblur="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" onkeydown="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" cssClass="noborder"/>
		            &nbsp;&nbsp;  --&nbsp;&nbsp;
		            <s:textfield name="useFeedback.pointEnd" title="得分"  cssStyle="width:75px;" maxlength="10"  onblur="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" onkeydown="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" cssClass="noborder"/>
		            
		         </td>
		       </tr> 
		     </table>
		  </s:form>
	   </div>
		<div class="serch_foot" style="margin-top : 30px;" align="right">
			<div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetUseFeedback()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div> 
   <div region="center">
      <table id="mytable"></table>
   </div>
   		<div id="tb">
			<a href="javascript:;" class="easyui-linkbutton" id="search" onclick="freshGrid()" data-options="iconCls:'icon-search',plain:true">查询</a>

		</div>
</body>
     <script type="text/javascript">
   //  showWin('dlgSearch');
   	   var activeTabId = aud$getActiveTabId();
     $(function(){
         $('#mytable').datagrid({
			url : "<%=request.getContextPath()%>/agency/useFeedback/getUseFeedbackListPointView.action?querySource=grid&maintainFormId=${maintainFormId}",
			method:'post',
			rownumbers:true, 
		 	pagination:true, 
			striped:true,
			autoRowHeight:true,
			//fit: true,
			fitColumns:false,
			border:false,
			singleSelect:true,
			remoteSort: false,
			toolbar: '#tb',
			showFooter:true,
			pagination:false,
			pageSize:20,
		    onLoadSuccess:heji,
			columns:[[  
						{field:'serviceEnterpriseName',
							title:'服务企业',
							sortable:true,
							halign:'center',
							width:'20%',
							align:'left'
						},
						{field:'year',
							title:'所属年度',
							sortable:true,
							halign:'center',
							width:'10%',
							align:'center'
						},
						{field:'point',
							title:'得分',
							sortable:true,
							halign:'center',
							width:'10%',
							align:'center'
						},						
						   {field:'createTime',
							title:'录入时间',
							sortable:true,
							halign:'center',
							width:'15%',
							align:'center'
						},
						{field:'createAudit_dept_name',
							title:'录入部门',
							sortable:true,
							halign:'center',
							width:'15%',
							align:'center'
						},
						{field:'operater',
							title:'操作',
							sortable:true,
							halign:'center',
							width:'15%',
							align:'center',
							formatter:function(value,row,rowIndex){
								if(row.formId == null || row.formId == ''){
									return "";
								}else{
									var t = "";
			                    	 t = "<a href='javascript:void(0);' onclick='viewUseFeedbackByFormId(\""+row.formId+"\")'>反馈意见查看</a>"
			                    	return t;
								}
		                    	
		                    }	
						}
					]]  
         });
         
         
			$("#agencyType1").multiSelect({ 
				selectAll: false,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
				noneSelected: ''
			}, function(){   //回调函数
				$('#agencyType').attr('name','useFeedback.agencyType').val($("#agencyType1").selectedValuesString());
			}	
		);
			$("#year1").multiSelect({ 
				selectAll: false,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
				noneSelected: ''
			}, function(){   //回调函数
				$('#year').attr('name','useFeedback.year').val($("#year1").selectedValuesString());
			});
			
			$("#quarter1").multiSelect({ 
				selectAll: false,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
				noneSelected: ''
			}, function(){   //回调函数
				$('#quarter').attr('name','useFeedback.quarter').val($("#quarter1").selectedValuesString());
			});

		 //单元格tooltip提示
		 $('#mytable').datagrid('doCellTip', {
			 onlyShowInterrupt:true,
			 position : 'bottom',
			 maxWidth : '200px',
			 tipStyler : {
				 'backgroundColor' : '#EFF5FF',
				 borderColor : '#95B8E7',
				 boxShadow : '1px 1px 3px #292929'
			 }
		 });
     });

     
     /* 修改统计数据	 */
     function heji() {
		 var rows =  $('#mytable').datagrid('getData').rows;
		 var showFooter =  $('#mytable').datagrid('options').showFooter;
		 if (rows.length > 0) {
		 	if(!showFooter) {
				$('#mytable').datagrid({'showFooter':true});
			}
			 var sumPoint = 0, sumCount = 0;
			 $.each(rows, function (i, row) {
				 sumPoint += parseFloat(row.point);
				 sumCount++;
			 });
			 var j = Math.round(sumPoint / sumCount * 100) / 100;
			 $('#mytable').datagrid('reloadFooter', [{serviceEnterpriseName: '平均分', operater: '', createAudit_dept_name: '', point: j}]);
		 } else {
			 if(showFooter) {
				 $('#mytable').datagrid({'showFooter':false});
			 }
		 }
	 }
   
     
     function accDiv(arg1, arg2) {
    	    var t1 = 0, t2 = 0, r1, r2;
    	     try {
    	         t1 = arg1.toString().split(".")[1].length;
    	     }
    	     catch (e) {
    	     }
    	     try {
    	         t2 = arg2.toString().split(".")[1].length;
    	     }
    	     catch (e) {
    	     }
    	     with (Math) {
    	         r1 = Number(arg1.toString().replace(".", ""));
    	         r2 = Number(arg2.toString().replace(".", ""));
    	         return (r1 / r2) * pow(10, t2 - t1);
    	     }
    	 }
     function viewUseFeedbackByFormId(formId){
    	 top.goMenu('反馈意见查看','<%=request.getContextPath()%>/agency/useFeedback/viewUseFeedback.action?formId='+formId,"useFeedback1");
     }
     function viewUseFeedback(){
			var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  != 1 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formId = ids[0].formId
			top.goMenu('中介机构查看','<%=request.getContextPath()%>/agency/useFeedback/viewUseFeedback.action?formId='+formId,"useFeedback1");
     }
     
     function delUseFeedback(){
    	 var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  == 0 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formIds = "";
			for (var i=0;i<ids.length;i++){
				formIds += ids[i].formId+",";
			}
			top.$.messager.confirm('提示信息', '确定要删除中介机构信息吗?', function(isDel){
				if(isDel){
					$.ajax({
						url:'<%=request.getContextPath()%>/agency/useFeedback/delUseFeedback.action?formIds='+formIds,
						type:'post',
						success:function(reV){
							if ( reV == 'suc'){
								$.messager.show({title:'提示信息',msg:'删除成功！'});
								doSearch();
							}else{
								$.messager.show({title:'提示信息',msg:'删除失败！'});
							}
						}
					});
				}
				
				
			});

			
     }
		/*
		* 查询
		*/
		function doSearch(){
     	$("#mytable").datagrid({
				queryParams:form2Json("myForm")
			});
			$('#dlgSearch').dialog('close');
     }
		/*
		* 重置
		*/
		function resetUseFeedback(){
			resetForm('myForm');
			window.location.reload(); // 刷新
		//	
		}
		/*
		* 取消
		*/
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
	    function freshGrid(){
			searchWindShow('dlgSearch',750);
		}
     </script>
</html>