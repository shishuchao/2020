<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<s:head theme="ajax" />
	<title>审计方案库系统方案查看</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	<script language="javascript">
		function searchList(){
			var url = "${contextPath}/operate/template/search.action";
			searchForm.action = url;
			searchForm.submit();
			
		}
		function searchrecal(){
			/*var url = "${contextPath}/operate/template/search.action";
		    window.location = url;*/
			resetForm('searchForm')
		}
		  //查看
	    function viewRecord(s){
	    	var url = "${contextPath}/operate/template/mainView.action?audTemplateId="+s;
	    	showWinIf('winPage',url,'查看审计方案内容');
	        /*win = window.open("${contextPath}/operate/template/mainView.action?audTemplateId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	        var h = window.screen.availHeight;
	        var w = window.screen.width; 
	    	win.moveTo(0,0)   
	        win.resizeTo(w,h) 
	    	if(win && win.open && !win.closed) {
	            win.focus();
	    	}*/
		} 
		  
	    //查看
	    function viewtimesCited(name,id){
	    	var url = "${contextPath}/operate/template/viewtimesCited.action?audTemplateId=" + id;
			aud$openNewTab(name + '被引用情况',url,false);
		} 
    </script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="templateSearch" class="searchWindow">
		<div class="search_head">
			<form id="searchForm" name="searchForm" onsubmit="return true;" 
				action="/ais/operate/template/search.action" method="post" style="">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width:15%;">方案名称</td>
						<!--标题栏-->
						<td class="editTd" tyle="width:35%;">
							<!--一般文本框-->
							<s:textfield cssClass="noborder"  name="audTemplate.templateName" cssStyle="width:80%;" />
						</td>
						<td class="EditHead" tyle="width:15%;">编制人</td>
						<!--标题栏-->
						<%--onclick="showPopWin('/ais/pages/system/search/frameselect4s.jsp?url=../userindex.jsp&paraname=audTemplate.proAuthorName&paraid=audTemplate.proAuthorCode',600,450)" --%>
						<td class="editTd" tyle="width:35%;">
							<s:textfield cssStyle="width:80%;" readonly="true" cssClass="noborder"
								name="audTemplate.proAuthorName"></s:textfield>
							<s:hidden name="audTemplate.proAuthorCode" />
							<img src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										param:{
											'p_item':1,
											'orgtype':1
										},
									      title:'请选择编制人',
									      // 审计人员选择模式
									      type:'treeAndEmployee'
									})"
								border=0 style="cursor: hand">
							<!--
						扩展的时候,需要增加参数如下
						eg.earch/frameselect4s.jsp?url=../userindex.jsp&paraname=users&paraid=usersid&extend=5
					 -->
						</td>
					</tr>
					<tr >
						<td class="EditHead">编制日期</td>
						<td class="editTd" colspan="3">
							<input id="proDate1" name="audTemplate.proDate1" title="单击选择日期"  style="width:45%;" class="easyui-datebox noborder" editable='false'/>
							<input id="proDate2" name="audTemplate.proDate2" title="单击选择日期"  style="width:45%;" class="easyui-datebox noborder" editable='false'/>
						</td>
					</tr>
					<tr>
						<td class="EditHead"   style="width:15%;">类别名称</td>
						<td align="left" class="editTd">
							<select id="select2" class="easyui-combobox" name="audTemplate.typeName" style="width:100%" panelHeight="auto">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
							</select>

						</td>
					</tr>

				</table>
				<s:hidden name="type" />
			</form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="searchrecal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#templateSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center" border='0' >		
		<table id="cunlist"></table>
	</div>
	<div id="winPage"></div>
	<script type="text/javascript">
        function doSearch(){
			var proDate1 = $('#proDate1').datebox('getValue');
			var proDate2 = $('#proDate2').datebox('getValue');
			if (proDate1 && proDate2) {
				if (new Date(proDate1).getTime() > new Date(proDate2).getTime()) {
					alert('编制日期开始日期不能大于结束日期！');
					return;
				}
			}

        	$('#cunlist').datagrid({
    			queryParams:form2Json('searchForm')
    		});
    		$('#templateSearch').dialog('close');
        }
		$(function(){
			showWin('templateSearch');
			showWin('winPage','公用弹框页面');
			var bodyW = $('body').width();
			// 初始化生成表格
			$('#cunlist').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/search.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns: true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'searchObj',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('templateSearch');
						}
					}],
				columns:[[
					{field:'templateName',
			       	 title:'方案名称',
			       	 width:bodyW * 0.15 + 'px',
			       	 halign:'center',
			       	 align:'left',
			       	 sortable:true,
			       	 formatter:function(value,row,index){
							 return '<a href="javascript:void(0);" onclick=\"viewRecord(\''+row.audTemplateId+'\'); return false;\">'+row.templateName+'</a>';
						 }
			       	},
				    {field:'proVer',title:'方案版本',width:bodyW * 0.06 + 'px',sortable:true,halign:'center',align:'left'}, 
					{field:'typeName',
							title:'类别名称',
							width:bodyW * 0.14 + 'px',
							halign:'center',
							align:'left',
							sortable:true
						},
					{field:'typeName2',
						title:'子类别名称',
						sortable:true,
						width:bodyW * 0.14 + 'px',
						halign:'center',
						align:'left'
					},
					{field:'atCompany',
						title:'所属单位',
						width:bodyW * 0.14 + 'px',
						sortable:true,
						halign:'center',
						align:'left'
					},
					{field:'proAuthorName',
						 title:'编制人',
						 width:bodyW * 0.06 + 'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'proDate',
						 title:'编制日期',
						 halign:'center',
						 width:bodyW * 0.1 + 'px',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					},
					{field:'timesCited',
						 title:'被引用次数',
						 halign:'center',
						 width:bodyW * 0.1 + 'px',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
							 return '<a href="javascript:void(0);" onclick=\"viewtimesCited(\''+row.templateName+'\',\''+row.audTemplateId+'\'); return false;\">'+value+'</a>';
						 }
					}
				]]   
			}); 
		});
	</script>	
</body>
</html>

