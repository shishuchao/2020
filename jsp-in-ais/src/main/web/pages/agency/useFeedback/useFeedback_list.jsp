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
		         <td class="EditHead" align="left" style="width:15%">
		                                   中介机构分类
		         </td>
		          <td class="editTd" align="left" style="width:35%">
		         <select editable="false" id="agencyType1" name="useFeedback.agencyType"  style="width:35%;">
						<option value="">&nbsp;</option>
						<s:iterator value="basicUtil.agencyTypeList" id="entry">
									<s:if test="${useFeedback.agencyType==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name" /></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name" /></option>
									</s:else>
								</s:iterator>
							</select>
							<input type="hidden" id="agencyType" name="useFeedback.agencyType" />
		          </td>
		         <td class="EditHead" align="left" style="width:15%">中介机构名称</td>
		          <td class="editTd" align="left" style="width:35%">
		           <s:textfield name="useFeedback.agencyName" title="中介机构名称" maxlength="100" cssClass="noborder"/>
		          </td>
		       </tr>
		       <tr>

		          <td class="EditHead" align="left" style="width:15%">服务企业</td>
		         <td class="editTd" align="left" style="width:35%">
		         	 <s:textfield name="useFeedback.serviceEnterpriseName" title="服务企业" maxlength="100" cssClass="noborder"/>
		         </td>
		         <td class="EditHead" align="left" style="width:15%">所属年度</td>
		         <td class="editTd" align="left" style="width:35%">
		         
		        		<select editable="false" id="year1" name="useFeedback.year"  style="width:35%;">
					            	<option value="">&nbsp;</option>

								   <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)">
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
<!-- 			<a href="javascript:;" class="easyui-linkbutton"  onclick="viewUseFeedback()" data-options="iconCls:'icon-view',plain:true">查看</a> -->
		<s:if test="${status != 'view' }">
			<a href="javascript:;" class="easyui-linkbutton"  id="add" onclick="addUseFeedback()" data-options="iconCls:'icon-add',plain:true">新增</a>
<!-- 	        <a href="javascript:;" class="easyui-linkbutton"  id="edit"  onclick="editUseFeedback()" data-options="iconCls:'icon-edit',plain:true">修改</a> -->
		    <a href="javascript:;" class="easyui-linkbutton"  id="del" onclick="delUseFeedback()" data-options="iconCls:'icon-delete',plain:true">删除</a>
			<!-- <a href="javascript:;" class="easyui-linkbutton"  onclick="importUseFeedback()" data-options="iconCls:'icon-import',plain:true">导入</a> -->
		</s:if>
			<a href="javascript:;" class="easyui-linkbutton"  onclick="tipMaintain()" data-options="iconCls:'icon-tip',plain:true" id="tipBtn">提示</a>
		</div>
		
		  <div id="exportDX" style="padding: 0px;overflow:hidden" title="导入反馈" >
		    <button id='exportModel' class="easyui-linkbutton" iconCls="icon-export">导出模板</button>&nbsp; 
		   <!--  <button id='exportDXExcel' class="easyui-linkbutton" iconCls="icon-export">导出全部草稿底稿</button>&nbsp;  -->
		    <button id='importmanu' class="easyui-linkbutton" iconCls="icon-import">导入反馈</button>&nbsp; 
		    <button id='closeImportmanu' class="easyui-linkbutton" iconCls="icon-cancel">关闭提示</button>&nbsp; 
		 	<form id='export_form' name='export_form' action='/ais/operate/manu/importExcelManu.action' method="POST"  
				enctype="multipart/form-data">
				<input type='hidden' id='excelType' name='excelType' />
				<input type='hidden' id="manufile" name='manufile'/>
				<input type='hidden' name='operate1' value="imoprtManu"/>
				<input type='hidden' name='beanName' value="LedgerTemplateNew"/>
				<input type='hidden' name='treeId' value="id"/>
				<input type='hidden' name='treeText' value="code"/>
				<input type='hidden' name='treeParentId' value="fid"/>

				<table class="ListTable" align="center">
					<tr>
						<td class="EditHead">
							导入的Excel文件
						</td>
						<!--实际后台也支持2007 -->
						<td class="editTd">
							<s:file name="manu_file" id='manu_file' />
						</td>
					</tr>
				</table>
			</form>
				<div id="layer" style="display: none" align="center">
						<img src="<%=request.getContextPath()%>/images/uploading.gif">
						<br>
						正在读取，请稍候......
					</div>
					<div align="left" id="errorInfo1">
						<s:if test="%{#tipList.size != 0}">
							<s:iterator value="%{#tipList}">
								<font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{position}"/>：<s:property value="%{errorInfo}"/></font><br>
							</s:iterator>
						</s:if>
					</div>
					<div align="left" id="errorInfo2">
					<s:if test="%{#tipMessage != null}">
							<font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}"/></font>
						</s:if> 
					</div>
		</div>	      	
</body>
     <script type="text/javascript">
   //  showWin('dlgSearch');
       importMsg("${importMsg}");
   	   var activeTabId = aud$getActiveTabId();
     $(function(){
         $('#mytable').datagrid({
			 url: "<%=request.getContextPath()%>/agency/useFeedback/getUseFeedbackList.action?querySource=grid&status=${status}",
			 method: 'post',
			 showFooter: false,
			 rownumbers: true,
			 pagination: true,
			 striped: true,
			 autoRowHeight: false,
			 fit: true,
			 fitColumns: false,
			 border: false,
			 singleSelect: false,
			 toolbar: '#tb',
			 pageSize: 20,
			 onLoadSuccess: function () {
				 initHelpBtn();
			 },
			 columns: [[
				 {field: 'formId', width: '50', checkbox: true, align: 'center'},
				 {field: 'agencyTypeName', title: '中介机构分类', width: '20%', sortable: true, halign: 'center', align: 'left', sortable: true},
				 {
					 field: 'agencyName', title: '中介机构名称', width: '20%', sortable: true, halign: 'center', align: 'left', sortable: true,
					 formatter: function (value, row, rowIndex) {
						 var t = "";
						 <s:if test="${status == 'view'}">
						 t = "<label title='单击查看' style='cursor:pointer;color:blue;' onclick='viewUseFeedbackByFormId(\"" + row.formId + "\")'>" + value + "</label>";
						 </s:if>
						 <s:else>
						 if (row.submitMsg == "1") {
							 t = "<label title='单击查看' style='cursor:pointer;color:blue;' onclick='viewUseFeedbackByFormId(\"" + row.formId + "\")'>" + value + "</label>";
						 } else {
							 t = "<label title='单击编辑' style='cursor:pointer;color:blue;' onclick='editUseFeedbackByFormId(\"" + row.formId + "\")'>" + value + "</label>";
						 }
						 </s:else>
						 return t;
					 }
				 },
// 	                    {field:'projectName',
// 							title:'项目名称',
// 							sortable:true,
// 							halign:'center',
// 							width:'10%',
// 							align:'left'
// 						},
				 {
					 field: 'serviceEnterpriseName',
					 title: '服务企业',
					 sortable: true,
					 halign: 'center',
					 width: '20%',
					 align: 'left'
				 },
				 {
					 field: 'projectName',
					 title: '项目名称',
					 sortable: true,
					 halign: 'center',
					 width: '30%',
					 align: 'left'
				 },
// 						{field:'audit_dept_name',
// 							title:'使用部门',
// 							sortable:true,
// 							halign:'center',
// 							width:'12%',
// 							align:'left'
// 						},
				 {
					 field: 'year',
					 title: '所属年度',
					 sortable: true,
					 halign: 'center',
					 width: '15%',
					 align: 'center'
				 },
// 						{field:'quarter',
// 							title:'所属季度',
// 							sortable:true,
// 							halign:'center',
// 							width:'10%',
// 							align:'center',
// 							formatter:function(value,row,rowIndex){
// 								var s = value+'季度';
// 								return s;
// 							}
// 						},
				 {
					 field: 'point',
					 title: '得分',
					 sortable: true,
					 halign: 'center',
					 width: '10%',
					 align: 'center'
				 },
				 {
					 field: 'createrName',
					 title: '录入人',
					 sortable: true,
					 halign: 'center',
					 width: '15%',
					 align: 'center'
				 },
				 {
					 field: 'createAudit_dept_name',
					 title: '录入人所在单位',
					 sortable: true,
					 halign: 'center',
					 width: '15%',
					 align: 'center'
				 },
				 {
					 field: 'createTime',
					 title: '录入时间',
					 sortable: true,
					 halign: 'center',
					 width: '15%',
					 align: 'center'
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
			
		    $('#exportDX').window({   
		    	width:750, 
				height:450,
				modal:true,
				border:0,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
          	
		    <s:if test="${operate1 == 'imoprtManu'}">
		 	  $('#exportDX').window('open');
			</s:if> 
     });

     // 新增
   function addUseFeedback(){
	  top.goMenu('中介机构使用反馈新增','<%=request.getContextPath()%>/agency/useFeedback/addUseFeedback.action?parentTabId='+activeTabId,"useFeedback2");
   }
     function editUseFeedback(){
			
			var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  != 1 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formId = ids[0].formId ;
			var submitMsg = ids[0].submitMsg ;
			if ( submitMsg == '1'){
				$.messager.show({title:'提示信息',msg:'项目已提交不可以修改！'});
			}else{
				top.goMenu('中介机构使用反馈编辑','<%=request.getContextPath()%>/agency/useFeedback/editUseFeedback.action?formId='+formId,"useFeedback2");

			}
     }
     function editUseFeedbackByFormId(formId){
    	 top.goMenu('中介机构使用反馈编辑','<%=request.getContextPath()%>/agency/useFeedback/editUseFeedback.action?formId='+formId,"useFeedback2");
     }
     function viewUseFeedbackByFormId(formId){
    	 top.goMenu('中介机构使用反馈查看','<%=request.getContextPath()%>/agency/useFeedback/viewUseFeedback.action?formId='+formId,"useFeedback1");
     }
     function viewUseFeedback(){
			var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  != 1 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formId = ids[0].formId
			top.goMenu('中介机构使用反馈查看','<%=request.getContextPath()%>/agency/useFeedback/viewUseFeedback.action?formId='+formId,"useFeedback1");
     }
     
     function delUseFeedback(){
    	 var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  == 0 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formIds = "";
			var submitMsg = "";
			for (var i=0;i<ids.length;i++){
				if ( ids[i].submitMsg == '1'){
					if ( submitMsg != null && submitMsg != ''){
						submitMsg += ","+ids[i].projectName;
					}else{
						submitMsg = ids[i].projectName;
					}
				}else{
					formIds += ids[i].formId+",";	
				}
			}
			top.$.messager.confirm('提示信息', '确定要删除中介机构信息吗?', function(isDel){
				if(isDel){
					$.ajax({
						url:'<%=request.getContextPath()%>/agency/useFeedback/delUseFeedback.action?formIds='+formIds,
						type:'post',
						success:function(reV){
							if ( reV == 'suc'){
								if ( submitMsg != null && submitMsg != ''){
									top.$.messager.show({title:'提示信息',msg:submitMsg+'项目已被提交不可以被删除删除成功！'});
								}else{
									$.messager.show({title:'提示信息',msg:'删除成功！'});
								}
								doSearch();
							}else{
								$.messager.show({title:'提示信息',msg:'删除失败,已被提交项目不可以被删除！'});
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
			//复选框重置
            var div = $(".multiSelectOptions")[0];
            var labels = div.children;
            for (var index = 0; index < labels.length; index++) {
                var label = labels[index];
                var input = label.children[0];
                input.checked = false;
            }
            $(".checked").removeClass("checked");
            $('#agencyType').attr('name','maintain.agencyLevel').val("");
            var span = $("#agencyType1")[0].children[0];
            span.innerHTML = "";
            //年度重置
            $("#year1>span").text("");
            $('input[type=checkbox]').attr('checked',false);
			//window.location.reload(); // 刷新
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
	    
	    //   导入/导出模板
	    function importUseFeedback(){
	    	$('#exportDX').window('open');  
	    }
	   
		$('#exportModel').bind('click',function(){
		     document.location.href="<%=request.getContextPath()%>/agency/useFeedback/exportUseFeedbackModel.action";

	       });
	   
	    // 导入/导出 excel审计事项
	    $('#importmanu').bind('click',function(){
	    	 var path = $('#manu_file').val();
	         var arr = path.split('.');
	         var suffix = arr[arr.length - 1];
	    	if( suffix.indexOf("xls") != -1 || suffix.indexOf("xlsx") != -1){
	    	    
	     			var excelType = suffix.toLowerCase() == 'xls' ? '2003' : (suffix.toLowerCase() == 'xlsx' ? '2007' : '2003');
		    		$('#excelType').val(excelType);
		    
		    		$('#importmanu').css('display','false');
		    		document.getElementById("layer").style.display = "";
					document.getElementById("errorInfo1").style.display = "none";
					document.getElementById("errorInfo2").style.display = "none";
		    		export_form.action="<%=request.getContextPath()%>/agency/useFeedback/importExcelUseFeedback.action";
			    	export_form.submit();
	   	   }else{
	   		showMessage1('导入文件后缀名错误，请导入 xls或者xlsx 的Excel文件！');
	    	}  
	    });
	    
	//   关闭提示
		$('#closeImportmanu').bind('click',function(){
	     	document.location.href="<%=request.getContextPath()%>/agency/useFeedback/getUseFeedbackList.action";
           });
	   //导入保存成功提示
   		function importMsg(obj){
   			if(obj!= null && obj !="" &&  obj == '1'){
   			  top.$.messager.show({
   	    		  title:'提示信息',
   	    		  msg:"导入成功",
   	    		  timeout:5000,
   	    		  showType:'slide',
   	    		  height:'auto',	
   	    	  }) 
   			}
   	
   		}
     </script>
</html>