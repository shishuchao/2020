<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>日志信息</title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell{
			height:10%;
			padding:5px 4px;
		}
	</STYLE>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="viewLogSearch" class="searchWindow">
		<div class="search_head">
			<!-- 列表FORM -->
			<s:form id="searchForm" namespace="/log" action="search.action" name="searchForm" method="post" theme="simple" onsubmit="return chkSearchLog()">
				<input type="hidden" id="exportLog" name="exportLog" value="${exportLog}">
				<input type="hidden" id="onLine" name="onLine" value="${onLine}">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width:15%">操作人员</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="log2.chiname" id="operator" cssStyle="width:80%;"></s:textfield>
						</td>
						<td class="EditHead" style="width:15%">组织机构</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="log2.orgName" cssStyle="width:80%;"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">起始时间</td>
						<td class="editTd">
					   		<input type="text" name="visittime1" id="visittime1" editable="false" value="${visittime1}" 
					   		       Class="easyui-datebox noborder" style="width:80%;" title="单击选择日期"/>
						</td>
						<td class="EditHead">截止时间</td>
						<td class="editTd">
							<input type="text" id="visittime2" name="visittime2" editable="false"  value="${visittime2}" 
							       Class="easyui-datebox noborder" style="width:80%;" title="单击选择日期"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">IP地址</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="ipAddress" cssStyle="width:80%;"></s:textfield>
						</td>
						<td class="EditHead">操作类型</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder"  name="log2.oppType" cssStyle="width:80%;"></s:textfield>
						</td>
					</tr>
					<tr >
						<td class="EditHead">功能模块</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="log2.module" cssStyle="width:80%;"></s:textfield>
						</td>
						<td class="EditHead">描述信息</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" cssStyle="width:80%;" name="log2.description" ></s:textfield>
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetviewLog()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#viewLogSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center" >
		<table id="its"></table>
	</div>
	
	<span id="tips" style="display:block;float:left;margin-left:15px;font-weight:600;color:red;display:none;"></span>		
	<br><br>
	<table border="0" style="border-color: ffffff;display:none;">
		<tr><td style="width: 10%;text-align: center;">IP地址&nbsp;</td><td><input type="text" id="jsip" value=""></td></tr>
		<tr><td style="width: 10%;text-align: center;">描述信息&nbsp;</td><td><textarea id="jsDes" style="width: 75%;height: 80px;" ></textarea></td></tr>
	</table>
	<br>
	<br>
	<script type="text/javascript">
		function doSearch(){
        	$('#its').datagrid({
    			queryParams:form2Json('searchForm')
    		});
    		$('#viewLogSearch').window('close');
        }
		//重置查询条件
		function resetviewLog(){
			$("#visittime1").datebox("setValue","");
			$("#visittime2").datebox("setValue","");
			resetForm('searchForm');
			//doSearch();
		}
		var onlien="${not empty(onLine) && onLine=='N'}";
		var isonlien="${onLine!='N'}";
		showWin('viewLogSearch');
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/log/search.action?querySource=grid&exportLog=0&onLine="+$("#onLine").val(),
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns: false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: true,
				toolbar:[
				{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('viewLogSearch');
					}
				},'-',
				{
					id:'EXEOUT',
					text:'导出日志',
					iconCls:'icon-export',
					handler:function(){
						outexcel();
					}
				},'-',helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				frozenColumns:[[
				       			{field:'chiname',title:'操作人员',width:'100px',halign:'center',align:'left'},
				       			{field:'orgName',title:'组织机构',width:'250px',sortable:true,halign:'center',align:'left'}
				    		]],
				columns:[[  
					{field:'visittime',
							title:'访问时间',
							width:200,
							halign:'center',
							align:'center', 
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								return value.replace("T"," ");
						}
					},
					{field:'ip',
						title:'IP地址',
						halign:'center',
						width:150,
						sortable:true, 
						align:'center'
					},
					{field:'module',
						 title:'功能模块',
						 width:200,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'localName',
						 title:'机器名',
						 width:150,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'description',
						 title:'描述信息',
						 width:200,
						 halign:'center',
						 align:'left', 
						 sortable:false
					}
					,
					{field:'oppType',
						 title:'操作类型',
						 width:100,
						 halign:'center',
						 align:'center', 
						 sortable:false
					}
					,
					{field:'reset',
						 title:'操作结果',
						 width:80,
						 halign:'center',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,rowData,rowIndex){
								return '成功';
						}
					},
					{field:'option',
						 title:'操作',
						 halign:'center',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,rowData,rowIndex){
							return  '<a href=\"javascript:void(0)\" onclick=\"doView(\''+rowData.logId+'\');\">查看详情</a>';
						}
					}
				]]   
			}); 
			
			
					<s:if test="'${onLine}'=='N'">
					$('#its').datagrid({
						toolbar:[
							{
								id:'searchObj',
								text:'查询',
								iconCls:'icon-search',
								handler:function(){
									searchWindShow('viewLogSearch');
								}
							},
							{
								id:'EXEOUT',
								text:'导出日志',
								iconCls:'icon-export',
								handler:function(){
									outexcel();
								}
							},
							{
								id:'btn3_mouseout',
								text:'清空离线日志',
								iconCls:'icon-empty',
								handler:function(){
									location.href='<%=request.getContextPath()%>/log/delBackLog.action?onLine='+$("#onLine").val();
								}
								
							},
							{
								id:'btn3_back',
								text:'返回',
								iconCls:'icon-undo',
								handler:function(){
									location.href='<%=request.getContextPath()%>/log/indexLoadLog.action?onLine=${onLine}';
								}
							}		
						]
					});		
					</s:if>
			//单元格tooltip提示
			$('#its').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
			/*此处通过toolbar重新加载控制
			if(onlien=="false"){
				$("#btn3_mouseout").linkbutton("disable"); 
				$("#btn3_back").linkbutton("disable");
			}
			if(isonlien=="false"){
				$("#EXEOUT").linkbutton("disable"); 			
			}*/
		});
	</script>
	<SCRIPT type="text/javascript">
		$(function(){
			initdata();
		});
		
		function outexcel(){
			initdata();
			var from =document.getElementById("searchForm");
			var path="<%=request.getContextPath()%>/log/search.action?querySource=grid&exportLog=1&onLine="+$("#onLine").val();
					from.action=path;
					from.submit();
		}
		
		function initdata(){
			var num = 10000;
			if('${listSize}'>num){
				$("#tips").html("");
				$("#tips").show();
				$("#tips").html("系统日志已超过"+num+"条，请及时备份并清理!");
			}
		}
		/**
		*  打开或关闭查询面板
		*/
		function triggerSearchTable(){
			var isDisplay = document.getElementById('searchTab').style.display;
			if(isDisplay==''){
				document.getElementById('searchTab').style.display='none';
			}else{
				document.getElementById('searchTab').style.display='';
			}
		}
        function doView(logId){
            new aud$createTopDialog({
                title:'查看详情',
                width:800,
                height:450,
                url:'${contextPath}/log/view.action?logId='+logId+'&onLine='+$("#onLine").val(),
                onClose:function(){},
                onOpen:function(){}
            }).open();
        }
	</SCRIPT>
    <!-- 引入公共文件 -->
    <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
