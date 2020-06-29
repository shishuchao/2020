<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<title>信息管理</title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
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
	<SCRIPT type="text/javascript">
		function displayAlert(){
			var msg = '${message}';
			if(msg == 'noauthrity'){
				showMessage1("没有权限！");
			}else if(msg == 'pubsuccess'){
				showMessage1("发布成功！")
			}else if(msg == 'puboffsuccess'){
				showMessage1("撤销发布成功！")
			}
		}
		function realDel(id,type){
			 $.messager.confirm('确认','确认删除吗？', function(flag){
			 	if (flag) {
			 		url="${contextPath}/portal/simple/information/deleteByType.action?information.id="+id+"&information.type="+type;
					window.location=url;
			 	}
			 });
		}
		//批量修改优先级
		function chgnums(formid){
			var puts_temp=document.getElementsByName('customSort');
			var puts,j=0,tid,temp,inp;
			$('#div1').html('');
			for(i=0;i<puts_temp.length;i++){
				//if(puts_temp[i].name.indexOf("id_")!=-1){
				    tid = puts_temp[i].id;
					temp=puts_temp[i].value;
					if(/^[0-9]+$/.test( temp )){
						inp = "<input type='hidden' name='customSort_id' value='"+tid+'-'+temp+"'>";
		    	    	$('#div1').append(inp);
						continue;
					}
					else{
						showMessage1("请输入数字！");
						return false;
					}
				//}
			}
			document.getElementById(formid).submit();
		}
		function resetPage(){
			var _title = document.getElementsByName("information.title");
			var _key = document.getElementsByName("information.infkey");
			var _createdate = document.getElementsByName("information.createdate");
			if(_title){
				_title[0].value="";
			}
			if(_key){
				_key[0].value="";
			}
			if(_createdate){
				_createdate[0].value="";
			}
		}
		/*
		*  打开或关闭查询面板
		*/
		function triggerSearchTable(){
			var isDisplay = document.getElementById('searchTable').style.display;
			if(isDisplay==''){
				document.getElementById('searchTable').style.display='none';
			}else{
				document.getElementById('searchTable').style.display='';
			}
		}
		function hidePageLink(){
			displayAlert();
		}
	</SCRIPT>
<%
	int type = ((ais.portal.simple.model.Information) request
			.getAttribute("information")).getType();
	if (type == ais.portal.simple.model.Information.HOTLINK) {
		request.setAttribute("fkey", "网址");
	} else if (type == ais.portal.simple.model.Information.FEEDBACK) {
		request.setAttribute("fkey", "Email");
	} else {
		request.setAttribute("fkey", "关键字");
	}
%>
<body onload="hidePageLink()" class="easyui-layout">
	<table class='listtable' style='display:none;'>
		<tr class="listtablehead">
			<td align="left" class="edithead">
				<div style="display: inline;width:80%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/portal/simple/information/listByType.action?information.type=${information.type}')"/>
				</div>
			</td>
		</tr>
	</table>			
<s:if test="information.type!=@ais.portal.simple.model.Information@DEPTDES&&information.type!=@ais.portal.simple.model.Information@FEEDBACK">
<div id="dlgSearch" class="searchWindow">
	<div class="search_head">
	<s:form id="myform" action="/portal/simple/information/listByType.action" cssStyle="overflow:hidden;">
		<table id="searchTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
			<tr>
				<td class="EditHead" style="width:15%">标题</td>
				<td class="editTd" style="width:35%"><s:textfield cssStyle="width:80%" cssClass="noborder" name="information.title"/></td>
				<td class="EditHead" style="width:15%">${fkey}</td>
				<td class="editTd" style="width:35%">
					<s:textfield cssClass="noborder" cssStyle="width:80%" name="information.infkey"/>
				</td>
			</tr>
			<tr >
			<td class="EditHead" style="width:15%">创建时间</td>
				<td  class="editTd" colspan="3" style="width:15%">
					<input class="noborder easyui-datebox" style="width:32%" name="information.createdate" editable="false"/>
				</td>
			</tr>
		</table>
		<s:hidden name="information.type" value="${information.type}"/>  
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
</s:if>
<s:else>
	<s:if test="${deptrole==1}">
	<div style="display: inline;width:70%;" align="center">
		<div style="display: inline;width:30%;text-align: center;">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="javascript:window.location='<s:url action="editByType"><s:param name="information.id" value="${information.id}"/><s:param name="information.type" value="${information.type}"/></s:url>'">增加</a>
		</div>
	</div>
	</s:if>
</s:else>
<div region="center">
	<table id="list"></table>
	<s:form id="myform2"   action="/portal/simple/information/chgnumsByType.action" method="post">
		<div id="div1"></div>
		<s:hidden name="information.type" value="${information.type}"/>
	</s:form>
</div>	  
<script type="text/javascript">
	$(function(){
		showWin('dlgSearch');
		// 初始化生成表格
		$('#list').datagrid({
			url : "<%=request.getContextPath()%>/portal/simple/information/listByType.action?querySource=grid&information.type=${information.type}",
			method:'post',
			showFooter:true,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize: 20,
			fitColumns:true,
			idField:'id',	
			border:false,
			singleSelect:true,
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
						id:'search',
						text:'批量修改优先级',
						iconCls:'icon-edit',
						handler:function(){
							chgnums('myform2');
						}
					}
			<s:if test="information.type!=5">
				<s:if test="${empty(onlyone)}">
						,{
							id:'newYear',
							text:'新增',
							iconCls:'icon-add',
							handler:function(){
								toAdd();
							}
						}
					
				</s:if>
			</s:if>
			],
			//'<a href="${contextPath}/portal/simple/information/viewByType.action?information.id='+row.id+'&information.type='+row.type+'" target="_blank" >查看</a>';
			frozenColumns:[[
			       			{field:'title',title:'标题',width: 80,halign:'center',align:'left',sortable:true,formatter:function(value,row,rowIndex){
			       					return '<a href="${contextPath}/portal/simple/information/viewByType.action?information.id='+row.id+'&information.type='+row.type+'" target="_blank" >'+row.title+'</a>'
			       			}},
			       			<s:if test="information.type==@ais.portal.simple.model.Information@HOTLINK">
			       				{field:'infkey',title:'网址',width: 80,halign:'center',align:'left',sortable:true}
			       			</s:if>
			       			<s:elseif test="information.type==@ais.portal.simple.model.Information@FEEDBACK">
			       				{field:'infkey',title:'Email',width: 80,halign:'center',align:'left',sortable:true}
			       			</s:elseif>
			       			<s:else>
			       				{field:'infkey',title:'关键字',width: 80,halign:'center',align:'left',sortable:true}
			       			</s:else>
			    		]],
			columns:[[  
				{field:'infstatus',
						title:'状态',
						width: 80,
						halign:'center',
						align:'left', 
						sortable:true
				},
				{field:'fcompanyname',
					title:'创建人',
					width: 80,
					halign:'center',
					sortable:true, 
					align:'left',
					formatter:function(value,row,rowIndex){
						return row.createManName;
					}
				},
				{field:'createdate',
					 title:'创建时间',
					 width: 80,
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 formatter:function(value,row,rowIndex){
					  if(value!= null){
						 return value.substring(0,10);
					 	}
					 }	
				},
				<s:if test="${row.type!='7' and row.type!='11'}">
				{field:'customSort',
					 title:'优先级',
					 width: 80,
					 halign:'center',
					 align:'right', 
					 sortable:true,
					 /*
					 editor:{type:'validatebox',
					 		options:{required:true}
		 		     },
		 		     */
					 formatter:function(value,row,rowIndex){
							return	'<input type="text" class="noborder" name="customSort" id="'+row.id+'" value="'+row.customSort+'" size="15">';
							//return value;
					}	
				},
				</s:if>
				{field:'xxx',
					 title:'操作',
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 formatter:function(value,row,index){
					 	 var param = [row.id,row.type];
						 if(row.is_pub == 'Y'){
					 		var btn2 = "撤销,cencleSend,"+param.join(',');
					 		return ganerateBtn(btn2);
							var bb = '<a href="${contextPath}/portal/simple/information/puboffByType.action?information.id='+row.id+'&information.type='+row.type+'" >撤销发布</a>'+'&nbsp;&nbsp;'+
							 '<a href="${contextPath}/portal/simple/information/viewByType.action?information.id='+row.id+'&information.type='+row.type+'" target="_blank" >查看</a>';
						 }else{
						 	var btn2 = "修改,toUpdate,"+param.join(',')+"-btnrule-删除,realDel,"+param.join(',')
								       +"-btnrule-发布,sendInformation,"+param.join(',');
							return ganerateBtn(btn2);
						 }
					 }
				}
				
			]]   
		}); 
	});
	function toAdd(){
		window.location.href="editByType.action?information.id=${information.id}&information.type=${information.type}";
	}
	/*
	* 查询
	*/
	function doSearch(){
       $('#list').datagrid({
			queryParams:form2Json('myform')
		});
		$('#dlgSearch').dialog('close');
       }
    /*
	* 取消
	*/
	function doCancel(){
		$('#dlgSearch').dialog('close');
	}
	/**
		重置
	*/
	function restal(){
		resetForm('myform');
		//doSearch();
	}
    function toUpdate(id,type){
    	window.location.href="editByType.action?information.id="+id+"&information.type="+type;
    }
    function sendInformation(id,type){
	    $.messager.confirm("确认","确认要发布吗？",function(flag){
	    	if (flag) {
		    	$.ajax({
		    		url:"${contextPath}/portal/simple/information/publishYqlj.action?",
		    		type:"POST",
		    		data:{"information.id":id,"information.type":type},
		    		success:function(){
		    			showMessage1("发布成功！");
		    			$("#list").datagrid('reload');
		    		}
		    	});
		    }
		});
    }
    function cencleSend(id,type){
    	$.messager.confirm("确认","确认要撤销发布吗？",function(flag){
    		if (flag) {
    			$.ajax({
		    		url:"${contextPath}/portal/simple/information/puboffByType.action?",
		    		type:"POST",
		    		data:{"information.id":id,"information.type":type},
		    		success:function(){
		    			showMessage1("撤销发布成功！");
		    			$("#list").datagrid('reload');
		    		}
		    	});
    		}
    	});
    }
</script>
</body>
</html>