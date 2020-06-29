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
			  <s:form id="myForm" action="getListMaintain" namespace="/agency/maintain" method="post">
				  <table class="ListTable" align="center">
					  <tr>
						  <td class="EditHead" align="left" width="150px" nowrap>中介机构分类</td>
						  <td class="editTd" align="left">
							  <s:select id="agencyType1" list="basicUtil.agencyTypeList" listKey="code" listValue="name" multiple="true"/>
							  <input type="hidden" id="agencyType" name="maintain.agencyType"/>
						  </td>
						  <td class="EditHead" align="left" width="150px" nowrap>中介机构名称</td>
						  <td class="editTd" align="left">
							  <s:textfield name="maintain.agencyName" title="中介机构名称" maxlength="100" cssClass="noborder"/>
						  </td>
					  </tr>
					  <tr>
						  <td class="EditHead" align="left" nowrap>统一社会信用代码</td>
						  <td class="editTd" align="left">
							  <s:textfield name="maintain.registrationNum" title="统一社会信用代码" maxlength="100" cssClass="noborder"/>
						  </td>
						  <td class="EditHead" align="left" nowrap>注册地址</td>
						  <td class="editTd" align="left">
							  <s:textfield name="maintain.address" title="注册地址" maxlength="100" cssClass="noborder"/>
						  </td>
					  </tr>
					  <tr>
						  <td class="EditHead" align="left" nowrap>联系电话</td>
						  <td class="editTd" align="left">
							  <s:textfield name="maintain.contactsNum" title="联系电话" maxlength="20" cssClass="noborder"/>
						  </td>
						  <s:if test="${status != 'view' }">
							  <td class="EditHead" align="left" nowrap>是否经集团审核</td>
							  <td class="editTd" align="left">
								  <select class="easyui-combobox" editable="false" name="maintain.groupDesignated" style="width:150px;" panelHeight="auto">
									  <option value="">&nbsp;</option>
									  <s:iterator value='#@java.util.LinkedHashMap@{"否":"否","是":"是"}'>
										  <option value="<s:property value="key"/>"><s:property value="value"/></option>
									  </s:iterator>
								  </select>
							  </td>
						  </s:if>
						  <s:if test="${status == 'view' }">
							  <td class="EditHead" align="left" nowrap>等级</td>
							  <td class="editTd" align="left">
								  <s:select id="agencyLevel1" list="agencyLevelMap.keySet()" listKey="agencyLevel" listValue="agencyLevelName" multiple="true"/>
								  <input type="hidden" id="agencyLevel" name="maintain.agencyLevel"/>
							  </td>
						  </s:if>
					  </tr>
					  <tr>
						  <s:if test="${status == 'view' }">
							  <td class="EditHead" align="left" nowrap>平均分</td>
							  <td class="editTd" align="left" colspan="3">
								  <s:textfield name="maintain.averageStart" cssStyle="width:150px;" title="平均分" maxlength="10" onblur="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" onkeydown="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" cssClass="noborder"/>
								  &nbsp;&nbsp; --&nbsp;&nbsp;
								  <s:textfield name="maintain.averageEnd" title="平均分" cssStyle="width:150px;" maxlength="10" onblur="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" onkeydown="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" cssClass="noborder"/>
							  </td>
						  </s:if>
					  </tr>
					  <tr>
						  <s:if test="${status == 'view' }">
							  <td class="EditHead" align="left" nowrap>服务次数</td>
							  <td class="editTd" align="left" colspan="3">
								  <s:textfield name="maintain.serviceStart" cssStyle="width:150px;" title="服务次数" maxlength="10" onblur="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" onkeydown="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" cssClass="noborder"/>
								  &nbsp;&nbsp; --&nbsp;&nbsp;
								  <s:textfield name="maintain.serviceEnd" title="服务次数" cssStyle="width:150px;" maxlength="10" onblur="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" onkeydown="value=value.replace(/[^(:?(:?\d+.\d+)|(:?\d+))$]/g,'')" cssClass="noborder"/>
							  </td>
						  </s:if>
					  </tr>
				  </table>

			  </s:form>
		  </div>
		  <div class="serch_foot" style="margin-top : 60px;" align="right">
			  <div class="search_btn">
				  <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				  <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetBook()">重置</a>&nbsp;
				  <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			  </div>
		  </div>
	  </div>
   <div region="center">
      <table id="mytable"></table>
   </div>
   		<div id="tb">
			<a href="javascript:;" class="easyui-linkbutton" id="search" onclick="freshGrid()" data-options="iconCls:'icon-search',plain:true">查询</a>
			<s:if test="${status != 'view' }">
			<a href="javascript:;" class="easyui-linkbutton"  id="add" onclick="addMaintain()" data-options="iconCls:'icon-add',plain:true">新增</a>
		    <a href="javascript:;" class="easyui-linkbutton"  id="del" onclick="delMaintain()" data-options="iconCls:'icon-delete',plain:true">删除</a>
			<a href="javascript:;" class="easyui-linkbutton"  onclick="importMaintain()" data-options="iconCls:'icon-import',plain:true">导入</a>
			</s:if>
			<a href="javascript:;" class="easyui-linkbutton"  onclick="tipMaintain()" data-options="iconCls:'icon-tip',plain:true" id="tipBtn">提示</a>
		</div>
		  <div id="exportDX" style="padding: 0px;overflow:hidden" title="导入中介机构" >
		    <button id='exportModel' class="easyui-linkbutton" iconCls="icon-export">导出模板</button>&nbsp; 
		   <!--  <button id='exportDXExcel' class="easyui-linkbutton" iconCls="icon-export">导出全部草稿底稿</button>&nbsp;  -->
		    <button id='importmanu' class="easyui-linkbutton" iconCls="icon-import">导入中介机构</button>&nbsp;
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
     showWin('dlgSearch');
       	 var activeTabId = aud$getActiveTabId();
     $(function(){
    	importMsg("${importMsg}");
         $('#mytable').datagrid({
			 url: "<%=request.getContextPath()%>/agency/maintain/getListMaintain.action?querySource=grid&status=${status}",
			 method: 'post',
			 showFooter: false,
			 rownumbers: true,
			 pagination: true,
			 striped: true,
			 autoRowHeight: false,
			 fit: true,
			 fitColumns: false,
			 border: false,
			 remoteSort: true,
			 sortName: 'agencyName',
			 sortOrder: 'asc',
			 singleSelect: true,
			 toolbar: '#tb',
			 pageSize: 20,
			 onLoadSuccess: function () {
				 // heji();
				 initHelpBtn();
			 },
			 columns: [[
				 {
					 field: 'agencyName', title: '中介机构名称', width: '15%', sortable: true, halign: 'center', align: 'left',
					 formatter: function (value, row, rowIndex) {
						 var t = "";
						 <s:if test="${status == 'view'}">
						 t = "<a href='javascript:void(0);' onclick='viewMaintainByFormId(\"" + row.formId + "\")'>" + value + "</a>"
						 </s:if>
						 <s:else>
						 t = "<a href='javascript:void(0);' onclick='editMaintainByFormId(\"" + row.formId + "\")'>" + value + "</a>"
						 </s:else>
						 return t;
					 }
				 },
				 <s:if test="${status == 'view'}">
				 {field: 'agencyTypeName', title: '中介机构分类', width: '10%', sortable: true, halign: 'center', align: 'left'},
				 {field: 'projectNum', title: '服务次数', width: '8%', halign: 'center', align: 'center', sortable:true},
				 {field: 'average', title: '平均分', width: '5%', halign: 'center', align: 'center', sortable: true},
				 {field: 'level', title: '等级', width: '8%', halign: 'center', align: 'center', sortable: true},
				 {
					 field: 'num', title: '打分次数', width: '8%', halign: 'center', align: 'center', sortable:true,
					 formatter: function (value, row, rowIndex) {
						 var t = "";
						 t = "<a href='javascript:void(0);' onclick='viewUseFeedbackByFormId(\"" + row.formId + "\")'>" + value + "</a>"
						 return t;
					 }
				 },
				 </s:if>
				 {
					 field: 'registrationNum',
					 title: '统一社会信用代码',
					 sortable: true,
					 halign: 'center',
					 width: '15%',
					 align: 'left'
				 },
				 {
					 field: 'address',
					 title: '注册地址',
					 sortable: true,
					 halign: 'center',
					 width: '15%',
					 align: 'left'
				 },
				 {
					 field: 'contactsNum',
					 title: '联系电话',
					 sortable: true,
					 halign: 'center',
					 width: '15%',
					 align: 'left'
				 }
				 <s:if test="${status != 'view'}">
				 ,
				 {
					 field: 'groupDesignated',
					 title: '是否经集团审核',
					 sortable: true,
					 halign: 'center',
					 width: '10%',
					 align: 'center'
				 }
				 </s:if>
			 ]]
		 });
			// $("#agencyType1").multiSelect({
			// 	selectAll: false,
			// 	oneOrMoreSelected: '*',
			// 	selectAllText: '全选',
			// 	noneSelected: ''
			// }, function(){   //回调函数
			// 	$('#agencyType').attr('name','maintain.agencyType').val($("#agencyType1").selectedValuesString());
			// }
			// );

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

		 $('#agencyType1').combobox({
			 multiple:true,
			 editable:false,
			 onSelect: function() {
				 $('#agencyType')
						 .attr('name','maintain.agencyType')
						 .val($("#agencyType1").combobox('getValues').join(','));
			 }
		 });
		 $("#agencyLevel1").combobox({
			 multiple: true,
			 editable:false,
			 onSelect: function () {
				 $('#agencyLevel')
						 .attr('name', 'maintain.agencyLevel')
						 .val($("#agencyLevel1").combobox('getValues').join(','));
			 }
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
     function addMaintain(){
  	  top.goMenu('中介机构新增','<%=request.getContextPath()%>/agency/maintain/addMaintain.action?parentTabId='+activeTabId,'editMaintain');

     }
     function editMaintain(){
			
			var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  != 1 ) {
				top.$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formId = ids[0].formId
			top.goMenu('中介机构编辑','<%=request.getContextPath()%>/agency/maintain/editMaintain.action?formId='+formId+'&parentTabId='+activeTabId,'editMaintain');
     }
     function editMaintainByFormId(formId){
    	 top.goMenu('中介机构编辑','<%=request.getContextPath()%>/agency/maintain/editMaintain.action?formId='+formId+'&parentTabId='+activeTabId,'editMaintain');
     }
     function viewMaintainByFormId(formId){
     	var url = '<%=request.getContextPath()%>/agency/maintain/viewMaintainFrame.action?formId='+formId;
     	aud$openNewTab("中介机构查看",url,true);
     }
      //查看中介机构使用情况反馈列表
     function viewUseFeedbackByFormId(formId){
    	 top.goMenu('查看中介机构使用情况反馈列表','<%=request.getContextPath()%>/agency/useFeedback/getUseFeedbackListPointView.action?maintainFormId='+formId+'&parentTabId='+activeTabId,'editPoint');
     }
     function viewMaintain(){
			var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  != 1 ) {
				top.$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formId = ids[0].formId;
			top.goMenu('中介机构查看','${contextPath}/agency/maintain/viewMaintainFrame.action?formId='+formId+'&parentTabId='+activeTabId,null);
     }
     
     function delMaintain(){
    	 var ids = $('#mytable').datagrid('getSelections');
			if (ids.length  == 0 ) {
				top.$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			var formIds = "";
			for (var i=0;i<ids.length;i++){
				formIds += ids[i].formId+",";
			}
			top.$.messager.confirm('提示信息', '确定要删除中介机构信息吗?', function(isDel){
				if(isDel){
					$.ajax({
						url:'<%=request.getContextPath()%>/agency/maintain/delMaintain.action?formIds='+formIds,
						type:'post',
						success:function(data){
							if ( data.res == '1'){
								top.$.messager.show({title:'提示信息',msg:'删除成功！'});
							}else if (data.res == '2'){
								top.$.messager.show({title:'提示信息',msg:data.reV+'已被反馈！'});
							}else{
								top.$.messager.show({title:'提示信息', msg: '删除失败！' + (data.msg ? data.msg : '')});
							}
							doSearch();
						}
					});
				}
				
				
			});

			
     }
		/*
		* 查询
		*/
	   function doSearch() {
		   $("#mytable").datagrid({
			   queryParams: form2Json("myForm")
		   });
		   $('#dlgSearch').dialog('close');
	   }
	   
		/*
		* 重置
		*/
		function resetBook(){
            resetForm('myForm');
		}
		/*
		* 取消
		*/
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
	    function freshGrid(){

			//$('#dlgSearch').dialog('open');
			searchWindShow('dlgSearch',750,300);
		}
	    
	   //   导入/导出模板
	    function importMaintain(){
	    	$('#exportDX').window('open');  
	    }
	   
		$('#exportModel').bind('click',function(){
		     document.location.href="<%=request.getContextPath()%>/agency/maintain/exportMaintainModel.action";

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
		    		export_form.action="<%=request.getContextPath()%>/agency/maintain/importExcelMaintain.action";
			    	export_form.submit();
	   	   }else{
	   		showMessage1('导入文件后缀名错误，请导入 xls或者xlsx 的Excel文件！');
	    	}  
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