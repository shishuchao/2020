<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>审计问题案例</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />  
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript">
	$(function(){
		$('#case_content').attr('maxlength',3000);
		$("#lrsjyd_form").find("textarea").each(function(){
				autoTextarea(this);
			});
		showWin('dlgSearch');
	});
	function doCancel(){
		$('#dlgSearch').dialog('close');
	}
	function restal(){
		var problemId2 = $('#problemId2').val();
		resetForm('sjyd_query_form');
		$('#problemId2').attr('value',problemId2);
		doSearch();
	}
	function doSearch(){
      	$('#sjydQueryDataTab').datagrid({
  			queryParams:form2Json('sjyd_query_form')
  		});
      	$('#dlgSearch').dialog('close');
    }
	function freshGrid(){
		searchWindShow('dlgSearch');
	}
	var gParam = '';
	// 初始化
	$(function(){
		$('#lrsjyd_div').window({
			modal:true,
			shadow:true,
			collapsible:false,
			maximizable:true,
			maximized: true,
			minimizable:false,
			closed:true,
			onOpen:function(){
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);
				$('#fj').val(rnm);
				$('#problemFile').fileUpload('property','fileGuid',rnm);
			}
		});
		// 查询按钮事件
	    $('#querySjyd').bind('click', {'type':'query'}, querySjyd);   
		
	    // 查询审计疑点
		function querySjyd(event, node, pageParam){
	        $.ajax({
				dataType:'json',
				url : "<%=request.getContextPath()%>/ledger/problemledger/queryWtal.action",
				data: $('#sjyd_query_form').serialize(),
				type: "POST",
				beforeSend: function(){},
				success: function(data){
					// 加载返回的数据，生成table					
					$('#sjydQueryDataTab').datagrid('loadData',data);
					if(data.type == 'success'){
					}else{
						showMessage1(data.msg);
					}		
				},
				error:function(data){
					showMessage1('请求失败！');
				}
			});
		}
	    // 清空查询表单
		$('#resetSjyd').bind('click',function(){
			var arr = ['case_name','case_key','create_date','creater_name'];
			$.each(arr, function(i, ele){
				$('#problemCase.create_date').datebox('setValue','');
				$('input[name='+'problemCase\\.'+ele+']').val('');
			});
		});
		
		// 编辑问题案例
	    function editSjyd(id){
	        var isView = '<%=request.getParameter("view")%>';
	        $('#fjlFileDiv').fileUpload('property', 'fileGuid', id);
       		$('#fjlFileDiv').fileUpload('reloadFile');
       		$('#editType').val('edit');
	            $.ajax({
	                url:'<%=request.getContextPath()%>/ledger/problemledger/getWtalInfoById.action',
	                data:{'problemCase.id':id},
	                type: "post",
	                dataType:'json',
	                cache:false,
	                success:function(data){
	                    if(data.type === 'success'){
	                    	var width = $('body').width();
	                    	var height = $('body').height();
	                        openWin('lrsjyd_div','问题案例信息', width, height);
	                        var rowData = data.pc;
	                        for(var p in rowData){
	                        	if (isView != '' && isView == 'yes') {
	                        		$("#lrsjyd_div #"+p+"").html(rowData[p]);
	                        	} else {
	                        		if(p=="case_content"){
		                        		$("#"+p+"").html(rowData[p]);
		                        	}else{
			                        	 if(p == 'create_date'){
				                         	$('#create_date').datebox('setValue',rowData[p]);
			                        	 }else{
			                        		$('input[id='+p+']').val(rowData[p]);
			                        	 }
		                        	}
	                        	}
	                        }
	                    }else{
	                    	//data.msg
	                        showMessage1('请求失败！');
	                    }						
	                },
	                error:function(data){
	                    showMessage1('请求失败！');
	                }
	            });
	    }
		
		// 保存问题案例
		$('#saveSjyd').bind('click',function(){
			
			$.ajax({
				dataType:'json',
				url : "<%=request.getContextPath()%>/ledger/problemledger/saveWtal.action",
				data: $('#lrsjyd_form').serialize(),
				type: "POST",
				beforeSend: function(){  
					var cdate = $('#create_date').datebox('getValue');
					if(cdate == ''){
						showMessage1("创建日期不能为空");
						return false;
					}
					var ids   = ['case_name'];
					var names = ['案例名称'];
					return validateBeforeSaveSjyd(ids,names);
	  			},
				success: function(data){
					if(data.type == 'success'){
						$('#lrsjyd_div').window('close');
						showMessage1("保存成功！");
						$('#id').val(data.alid);
						querySjyd();
					}
					if(data.type == 'full'){
						 showMessage1("正文不能超过3000字！");
					}
					if(data.type == 'nosuccess'){
						 showMessage1("该问题点下存在相同名称的案例，请修改名称！");
					}
				},
				error:function(data){
					 showMessage1("请求失败！");
				}
			});
		});
		
		// 删除问题案例
	    function removeWtal(){
		    var rows = $('#sjydQueryDataTab').datagrid('getSelections');
		       if (rows && rows.length > 0){
	    		 $.messager.confirm('确认', '确定删除该问题案例么', function(r){
					if (r){
		                var delIdArr = [];
		                $.each(rows, function(i, row){
		                    delIdArr.push(row.id);
		                })
		                $.ajax({
		                    dataType:'json',
		                    url : "<%=request.getContextPath()%>/ledger/problemledger/deleteWtal.action",
		                    data: {ids:delIdArr.join("','")},
		                    type: "post",
		                    success: function(data){						
		                        showMessage1(data.msg );
		                        var count = data.count;
		                        if(data.type == 'success' && count == rows.length){
		                            $.each(rows, function(i, row){
		                                var index = $('#sjydQueryDataTab').datagrid('getRowIndex', row);
		                                $('#sjydQueryDataTab').datagrid('deleteRow', index);
		                            })
		                        }
		                    },
		                    error:function(data){
		                        showMessage1('请求失败！');
		                    }
		                });
		                            
		            }
	    		 });		
	    	}else{
            	showMessage1('请选择要删除的记录！');
            }
	    }
		// 打开录入窗口时，清空录入框
		function lrsjyd(){
			$.ajax({
				url:"<%=request.getContextPath()%>/adl/getUUid.action",
				type:"POST",
				async:false,
				success:function(data){
					$('#id').val(data);
					$('#fjlFileDiv').fileUpload('property', 'fileGuid', data);
       				$('#fjlFileDiv').fileUpload('reloadFile');
				}
			});
			$('#lrsjyd_div').window('open');
			$('#editType').val('add');
			clearYdlr();
		}
		/* $('#lrsjyd_openWin').bind('click',function(){
			$('#lrsjyd_div').window('open');
			clearYdlr();
		}); */
		
		// 关闭录入窗口
		$('#closeWinSjyd').bind('click',function(){
			$('#lrsjyd_div').window('close');
		})
		
		// 清空表单
		function clearYdlr(){
			var arr = ['case_name','case_key','creater_code','creater_name','case_content'];
			$.each(arr, function(i, ele){
				$('#'+ele).val('');
			});
			$('#create_date').datebox('setValue','');
			$("#fjlFileList").html("");		
		}
		
		
		// 判断是否有选中的记录
		function isSelectedRows(id){
			var rows = $('#'+id).datagrid('getSelections');
			if(rows && rows.length > 1){
				 showMessage1('请选择一条数据进行操作!');
				return false;
			} 
			var row = $('#'+id).datagrid('getSelected');
			if(!row){
				 showMessage1('请选择记录后再进行操作！');
				return false;
			}
			return row;
		}
	    // 初始化问题案例列表
		$('#sjydQueryDataTab').datagrid({ 
			url : "<%=request.getContextPath()%>/ledger/problemledger/queryWtal.action?problemCase.problemId=${problemCase.problemId}",
			//title:'问题案例列表',
			//此参数，点击重置按钮影响列表展示数据
			//queryParams:{'problemCase.problemId':'${problemCase.problemId}'},
			rownumbers:true,
			pagination:true,
			collapsible:false,
			striped:true,
			fit:true,
			fitColumns:true,
			pageSize:20,
			remoteSort:false,
			<%
			String right = request.getParameter("view");
			if(!"yes".equals(right)){
			%>
			toolbar:[
			{
				id:'search',
				text:'查询',
				iconCls:'icon-search',
				handler:function(){
					freshGrid();
				}
			},'-',{
				id:'lrsjyd_openWin',
				text:'新增',
				iconCls:'icon-add',
				handler:function(){
					lrsjyd();
				}
			},'-',{
				text:'删除',
				iconCls:'icon-delete',
	            id:'sjydDelBtn',
				handler:function(){
	                removeWtal();
	            }
			},'-'],
			<%}else{%>
			toolbar:[
			{
				id:'search',
				text:'查询',
				iconCls:'icon-search',
				handler:function(){
					freshGrid();
				}
			}],
			<%}%>
			onClickCell:function(rowIndex, field, value) {
				if(field == 'case_name') {
					var rows = $('#sjydQueryDataTab').datagrid('getRows');
					var row = rows[rowIndex];
					editSjyd(row.id);
				}
			},
			columns:[[
				{field:'id',title:'选择',checkbox:true,align:'center'},
	   			{field:'case_name',title:'案例名称',width:100,halign:'center',align:'left', sortable:true,
					formatter:function(value,rowData,rowIndex){
					var result;
					if('${view}' != 'yes') {
						result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
					} else {
							result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
					}
					return result;
					}
				},
	   			{field:'case_key',title:'关键字',width:50,halign:'center',align:'left', sortable:true},
	   			{field:'creater_name',title:'创建人',width:50,align:'center', sortable:true},
				{field:'create_date',title:'创建时间',width:60,halign:'center',align:'center', sortable:true},
				{field:'fileList',title:'附件信息',width:100,halign:'center',align:'left'}
			]]
		}); 
	});
	//上传附件
	function Upload(filelist){
		var guid = $("#id").val();
		if(guid==null||guid==''||guid=='null'){
			 showMessage1('请先保存案例后再进行上传附件！');
			return false;
		}
		var num = Math.random();
		var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${pageContext.request.contextPath}/commons/file/welcome.action?table_name=mng_auditing_object&table_guid=other_resource_file&guid='+guid+'&param='+rnm+'&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	// 保存审计疑点前校验
	function validateBeforeSaveSjyd(ids,names){
		for(var i=0; i<ids.length; i++){
			var obj = document.getElementById(ids[i]);
			if(!obj.value){
				 showMessage1('【'+names[i]+'】不能为空');
				return false;
			}
		}
		return true;
	}
	
</script>
</head>
<body>
	<div style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true">
		<div region="center" border="0">
			<table id="sjydQueryDataTab"></table>
		</div>
	</div> 
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		    <form id="sjyd_query_form" name="sjyd_query_form" method="post">
		        <table  class="ListTable" >
			       	<tr>
			       		<td class='EditHead' nowrap sytle="width:15%">案例名称</td>
			       		<td class='editTd' sytle="width:35%">
			       			<s:textfield id='problemCase.case_name' name='problemCase.case_name' cssClass="noborder" maxlength="50" ></s:textfield>
			       			<input type='hidden' id='problemId2' name='problemCase.problemId' maxlength="50" value="${problemCase.problemId}"/>
			       		</td>
			       		<td class='EditHead' nowrap sytle="width:15%">关键字</td>
			       		<td class='editTd' sytle="width:35%">
			       			<input type='text' id='problemCase.case_key' name='problemCase.case_key' class="noborder" maxlength="50" />	
			       		</td>
			       	</tr>
					<tr>
						<td class='EditHead'>创建时间</td>
						<td class='editTd' colspan="3">
							<input type='text' editable="false" id='problemCase.create_date' name='problemCase.create_date' class="easyui-datebox"/>&nbsp;-&nbsp;
							<input type='text' editable="false"  name='end_date' class="easyui-datebox"/>
						</td>
					</tr>
					<tr>
			       		<td class='EditHead'>创建人</td>
			       		<!-- <td class='editTd'>
			       			<input type='text' id='problemCase.creater_name' name='problemCase.creater_name' class="noborder" maxlength="50"/>
			       		</td> -->
			       		<td class="editTd" colspan="3">
											<s:buttonText2 id="problemCase.creater_name" cssStyle="width:160px;"
														   name="problemCase.creater_name" cssClass="noborder"
														   hiddenId="pro_teamleader"
														   hiddenName="pro_teamleader"
														   doubleOnclick="showSysTree(this,{
										  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										  title:'&nbsp;&nbsp;&nbsp;请选择创建人',
										  type:'treeAndEmployee'

										})"
														   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
														   doubleCssStyle="cursor:hand;border:0" />
						</td>
						<%--<td class="editTd"  >
							<input type='text'   id='problemCase.creater_name' name='problemCase.creater_name' style='border:0px;' readOnly value='${user.fname }'/>
							<input type='hidden' id='problemCase.creater_name' name='problemCase.creater_name'  value='${user.floginname }'/>
						</td>--%>
					</tr>

		        </table>
	        </form>
		</div>
		<div class="serch_foot">
			<div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div>

     <%if(!"yes".equals(right)){ %>
     <!-- 录入问题案例 -->
	 <div id="lrsjyd_div" title="问题案例信息" style='overflow-y:auto;padding:0;'>
	 		 <div style='text-align:right;padding:1px;' id='exportBtnDiv'>
        		<a  id='saveSjyd' class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;
		    </div>
      		<form id='lrsjyd_form' name='sjsx_form' method="post"  >
		        <table class="ListTable" align="center" >
		        	<tr>
		        		<td class='EditHead' style="width: 100px;">
		        			<font style='color:red'>*</font>&nbsp;案例名称
		        		</td>
		        		<td class="editTd" style="width: 300px;">
		        			<!-- <input type="text"   id="case_name"  name="problemCase.case_name" style="width:110px;" class="noborder"/>-->	
		        			<s:textfield id="case_name"  name="problemCase.case_name" cssClass="noborder" maxlength="50"></s:textfield>
		        			<input type='hidden' id='problemId' name='problemCase.problemId' value="${problemCase.problemId}"/>
		        			<input type='hidden' id='id' name='problemCase.id' value="${problemCase.id}"/>
		        			<input type='hidden' id='editType' name='editType' />
		        		</td>	        		
		        		<td class='EditHead' style="width: 100px;">关键字</td>
		        		<td class='editTd'>
		        			<!-- <input type='text' id='case_key' name='problemCase.case_key'  style='width:110px;' class="noborder"/>-->
		        			<s:textfield id="case_key" name="problemCase.case_key" maxlength="50" cssClass="noborder"></s:textfield>
		        		</td>
		        	</tr>
		        	<tr>
						<td class='EditHead'><font style='color:red'>*</font>&nbsp;创建日期</td>
						<td class='editTd'>
							<input type='text' id='create_date' name='problemCase.create_date' editable="false" class='easyui-datebox'/>
						</td>
						<td class='EditHead'>创建人</td>
						<td class="editTd">
							<input type='text' id='problemCase.creater_name' name='problemCase.creater_name' style='border:0px;' readOnly value='${user.fname }'/>
							<input type='hidden' id='problemCase.creater_code' name='problemCase.creater_code' value='${user.floginname }'/>
						</td>
						<%--<td class='editTd'>
                            <input type='text' id='creater_name' name='problemCase.creater_name'
                                    readonly="readonly" class="noborder" />
                            <input type='hidden' id='creater_code' name='problemCase.creater_code' />
                        </td>--%>
					</tr>
		        	<tr>
		        		<td class='EditHead'>正文<div><font color=DarkGray>(限3000字)</font></div></td>
		        		<td class='editTd' colspan="3">
		        			<s:textarea id="case_content" name="problemCase.case_content" title="正文"
		        				 cssStyle="width:100%;overflow-y:hidden" cssClass="noborder" rows="5"/>
		        			<!-- <input type="hidden" id="problemCase.case_content.maxlength" value="3000"> -->
		        		</td>
		        	</tr>
		        	<tr>
						<td class="EditHead">附件</td>
						<td class="editTd" colspan="3">
							<div id="fjlFileDiv" data-options="fileGuid:'${pc.id}'"  class="easyui-fileUpload"></div>
						</td>
		        	</tr>
		        </table>
      		</form>
       </div>
       <% }else{%>
       	<div id="lrsjyd_div" title="问题案例信息" style='overflow-y:auto;padding:0;'>
      		<form id='lrsjyd_form' name='sjsx_form' method="POST" >
		        <table class="ListTable" align="center" >
		        	<tr>
		        		<td class='EditHead' style="width: 15%;">&nbsp;案例名称</td>
		        		<td class='editTd' style="width: 35%;" id="case_name"></td>	        		
		        		<td class='EditHead' style="width: 15%;">关键字</td>	
		        		<td class='editTd' style="width: 35%;" id='case_key'></td>
		        	</tr>
		        	<tr>
		        		<td class='EditHead' ><font style='color:red'>*</font>&nbsp;创建日期</td>
		        		<td class='editTd' id='create_date'></td>
		        		<td class='EditHead'>创建人</td>
		        		<td class='editTd' id='creater_name'></td>
		        	</tr>
		        	
		        	<tr>
		        		<td class='EditHead'>正文</td>
		        		<td class='editTd' colspan="3">
                            <s:textarea id="case_content" name="problemCase.case_content" title="正文"
                                        cssStyle="width:100%;overflow-y:hidden" cssClass="noborder" rows="5" readonly="true"/>
                        </td>
		        	</tr>
		        	<!-- <tr height='85px;'>
						<td class="EditHead" nowrap>附件列表</td>
						<td class="editTd" colspan='3'>
						    <div id="fjlFileList" align="center" style='padding:5px;' >
								<s:property escape="false" value="fjlFileList" />									
							</div>
						</td>
		        	</tr>-->
		        	<tr>
						<td class="EditHead">
							附件
						</td>
						<td class="editTd" colspan="3">
							<div id="fjlFileDiv" data-options="fileGuid:'${pc.id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</td>
						
		        	</tr>
		        </table>
      		</form>
       </div>
       <% }%>
</body>
</html>