<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
	<title><s:property value="processName" /></title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	<STYLE type="text/css">
	.datagrid-row {
	  	height: 30px;
	}
	.datagrid-cell {
		height:10%;
		padding:1px;
	}
	</STYLE>
	<script type="text/javascript">
	 	function restal(){
			var url = "${contextPath}/archives/borrow/borrowLog.action?project_id=${project_id}&project_name=${project_name}";
			window.location = url;
		}
	 	
	 	//设置多选框的选择按钮
	 	function allcheOrcl(crudId,cheOrclear){		
			var ische = cheOrclear;

			for (var i=0;i<document.getElementsByName(crudId).length;i++)  //用来历遍form中所有控件,
			{
				var e = document.getElementsByName(crudId)[i];
				if (e.Type="checkbox")					//当是checkbox时才执行下面
				{
					if(ische==1)
					{
						if(!e.checked)						//当是checkbox未被选取时才执行下面
						{
							e.checked=true;					
						}
					}
					else if(ische==8)
					{	
						e.checked=false;
					}
					else
					{
						if(!e.checked)						//当是checkbox未被选取时才执行下面
						{
							e.checked=true;		
						}
						else
						{
							e.checked=false;
						}
								
					}
				}
			}
		}	
		/*
		 *借阅详细
		 */ 
		function viewLog(borrowFormId){  
			var url = "${contextPath}/archives/borrow/viewLog.action?crudId="+borrowFormId;
			window.location = url;
		}
		/*
		 *授权文件列表
		 */	
		function borrowDetail(project_id,borrowFormId,archive_name){
			var num=Math.random();
		    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			var url = "${contextPath}/archives/borrow/viewLog.action?project_id=" + project_id
								+"&borrowFormId="+borrowFormId
								+"&rnm="+rnm;
			/* var popstyle="dialogTop:150px;dialogLeft:250px;help:no;center:yes;dialogHeight:600px;dialogWidth:1000px;status:yes;resizable:yes;scroll:yes";
			window.showModalDialog(url,window,popstyle);  */
			
			 $('#showPlanName').attr("src",url);
	         showWinIf('planName',url,'项目信息');
			
		}
		function back(){
			var url = "${contextPath}/archives/pigeonhole/borrowLogListIC.action";
	 		window.location = url;
		}
		/*
	     * 关闭和隐藏查询条件
	     */
		
		function triggerSearchTable(){
			var isDisplay = document.getElementById('searchTable').style.display;
			if(isDisplay==''){
				document.getElementById('searchTable').style.display='none';
			}else{
				document.getElementById('searchTable').style.display='';
			}
		}
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="allArchivesSearch" class="searchWindow">
		<div class="search_head">
			<s:form action="borrowLogIC" namespace="/archives/borrow" id="form" name="form">
				<table cellpadding=0 cellspacing=0 border=0 style="overflow:hidden;" align="center" class="ListTable" id="searchTable" >
					<tr >
						<td class="EditHead" style="width:20%;">
							档案内部借阅人

						</td>
						<td class="editTd" style="text-align:left;width:30%;">
							<s:buttonText2 cssStyle="width:160px;" name="borrowObject.in_borrow_man_name" cssClass="noborder"
								hiddenName="borrowObject.in_borrow_man" 
								doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								param:{
								'p_item':1,
								'orgtype':1
								},
								      title:'档案内部借阅人',
								      // 审计人员选择模式
								      type:'treeAndEmployee'
									})"
									
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								display="true" doubleDisabled="false" />
						</td>
						<td class="EditHead" style="width:20%;">
							档案内部借阅单位
						</td>
						<td class="editTd" style="text-align:left;width:30%;">
							<s:buttonText2 name="borrowObject.in_borrow_unit_name" cssClass="noborder"
							cssStyle="width:160px;" hiddenName="borrowObject.in_borrow_unit"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								   // json格式，url使用的参数
								   param:{
										'p_item':1,
									    'orgtype':1
								},
								  title:'档案内部借阅单位',
								  // 单击确定按钮后执行清空被审计单位（根据实际业务逻辑编写相关代码）
								  onAfterSure:function(){
								    $('#audit_object').val('');
								    $('#audit_object_name').val('');
								  }
								})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							display="true" doubleDisabled="false" />
						</td>


					</tr>
					<tr >

						<td class="EditHead" style="width:20%;">
							档案借阅发起人
						</td>
						<td style="text-align:left;" class="editTd">
							<s:buttonText2 name="borrowObject.start_borrow_man_name" cssClass="noborder"
								hiddenName="borrowObject.start_borrow_man" cssStyle="width:160px;"
								doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								param:{
								'p_item':1,
								'orgtype':1
								},
								      title:'档案内部借阅人',
								      // 审计人员选择模式
								      type:'treeAndEmployee'
									})"
									
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								display="true" doubleDisabled="false" />
						</td>
						<td class="EditHead">
							档案借阅发起部门
						</td>
						<td style="text-align:left;" class="editTd">
							<s:buttonText2 name="borrowObject.start_borrow_unit_name" cssClass="noborder"
							cssStyle="width:160px;" hiddenName="borrowObject.start_borrow_unit"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								   // json格式，url使用的参数
								   param:{
										'p_item':1,
									    'orgtype':1
								},
								  title:'档案借阅发起部门',
								  // 单击确定按钮后执行清空被审计单位（根据实际业务逻辑编写相关代码）
								  onAfterSure:function(){
								    $('#audit_object').val('');
								    $('#audit_object_name').val('');
								  }
								})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							display="true" doubleDisabled="false" />
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#allArchivesSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center" >
		<table id="allArchivesList"></table>
	</div>
	<div id="planName" title="项目信息" style="overflow:hidden;padding:0px"></div>
	<script type="text/javascript">
	    function doSearch(){
	    	$('#allArchivesList').datagrid({
				queryParams:form2Json('form')
			});
			$('#allArchivesSearch').window('close');
	    }
		function restal(){
			resetForm('form');
			//doSearch();
		}
		$(function(){
			showWin('allArchivesSearch');
			// 初始化生成表格
			$('#allArchivesList').datagrid({
				url : '<%=request.getContextPath()%>/archives/borrow/borrowLogIC.action?querySource=grid&project_id=${project_id}&project_name=${project_name}',
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns: true,
				idField:'row',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('allArchivesSearch','900');
					}},
					{
						id:'back',
						text:'返回',
						iconCls:'icon-undo',
						handler:function(){
							back();
						}
					}
				],
				frozenColumns:[[
				       			{field:'archive_name',title:'档案名称',width:250,halign:'center',sortable:true,align:'left'}
				    		]],
				columns:[[  
					{field:'project_name',
							title:'项目名称',
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'start_borrow_man_name',
						title:'档案借阅发起人',
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'start_borrow_unit_name',
						 title:'档案借阅发起人单位',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'in_borrow_man_name',
						 title:'内部借阅人',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'start_borrow_time',
						 title:'档案借阅起始时间',
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							return rowData.start_borrow_time.substr(0,10);
						}
					},
					{field:'end_borrow_time',
						 title:'档案借阅终止时间',
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							return rowData.end_borrow_time.substr(0,10);
						}
					},
					{field:'optaion',
						 title:'操作',
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							return '<a href=\"javascript:void(0)\" onclick=\"borrowDetail(\''+rowData.project_id+'\',\''+rowData.formId+'\',\''+rowData.archive_name+'\');\">授权文件</a>';
		   				}
					}
				]]   
			}); 
		});
		showWin('planName','xxxx');
	</script>
</body>
</html>
