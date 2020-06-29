<jsp:directive.page import="ais.framework.acegi.SecurityContextUtil"/>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	</head>
	<script type="text/javascript">
		function userOwnCheck(fuserid,fdepid,name,livestate){
			var loginName='<%=new SecurityContextUtil().getLoginName()%>';
			if(loginName.length!=0&&name.length!=0){
				if(loginName==name){
					showMessage1("不能删除本人!")
					return false;
				}
			}
			if(livestate!='zx'){
				showMessage1("只有注销的人员才可以被删除!")
				return false;
			} 
			$.messager.confirm('提示信息','请确认该用户没有参与到业务流程中!',function(result){
				if(!result){return false;}
				else if(livestate=='zx'){
					$.messager.confirm('确认','确认要删除吗？',function(r){
						if(r){
							window.location.href="delUUser.action?uUser.fuserid="+fuserid+"&fdepid="+fdepid+""
						}
					});
				}
			});
		}
		function editUser(fuserid,fdepid){
			window.location.href="${contextPath}/admin/editUUser.action?uUser.fuserid="+fuserid+"&fdepid="+fdepid;
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
	<body class="easyui-layout">
	  <div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form id="searchForm" action="listUUser" namespace="/admin" name="searchForm">
					<table  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="searchTable" >
						<tr>
							<td align="left" class="EditHead">
								用户名称
							</td>
							<td align="left" class="editTd">
								<s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="uUser.fname"  />
							</td>
							<td align="left" class="EditHead">
								系统账号
							</td>
							<td align="left" class="editTd">
								<s:textfield cssClass="noborder" cssStyle="width:160px;" id="floginname" name="uUser.floginname"  />
							</td>						
						</tr>
					</table>	
					<s:hidden name="fdepid" id="fdepid"></s:hidden>
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
			<table id="objectList"></table>
		</div>
		<div id="fdepWin">
		
		  <form id="fdepForm"  method="post">
			<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
				<tr >
					<td align="left" class="EditHead" style="vertical-align: middle;width: 15%">组织机构</td>
					<td class="editTd" style="width: 35%">
                                <s:buttonText name="departmentName" cssClass="noborder" id="departmentName" cssStyle="width:90%"
                                              hiddenName="departmentId" hiddenId="departmentId"
                                              doubleOnclick="showSysTree(this,
												{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
												   // json格式，url使用的参数
												   param:{
														'p_item':1,
													    'orgtype':1
												},
												  title:'请选择审计单位'
												})"
                                              doubleSrc="/easyui/1.4/themes/icons/search.png"
                                              doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
					</td>
				</tr>
			</table>
		 </form>
	</div>
		<script type="text/javascript">
		var fdepid=document.getElementById("fdepid").value;
		
        /*
		* 查询
		*/
		function doSearch(){
        	$('#objectList').datagrid({
    			queryParams:form2Json('searchForm')
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
			resetForm('searchForm');
			//doSearch();
		}
        $(function(){
        	showWin('dlgSearch');
        	var bodyW = $('body').width();
	        $('#objectList').datagrid({
				url : "<%=request.getContextPath()%>/admin/listUUser.action?querySource=grid&fdepid="+fdepid,
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				//width:'100%',
				//height:'78%',
				fit: true,
				pageSize: 20,
				fitColumns: true,
				idField:'fuserid',
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
					}
					<s:if test="${ empty view || view == null || view == ''}">
					,'-',
					{
						id:'toAdd',
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							toAdd(fdepid);
						}
					},'-',
					{
						id:'toEdit',
						text:'更新组织机构',
						iconCls:'icon-edit',
						handler:function(){
							toEditFdep();
						}
					},'-',
					{
						id:'toDelete',
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							var rows =  $('#objectList').datagrid('getChecked');
							var fdepid=$('#fdepid').val();
							var fuserids = new Array();
							if(rows) {
								for(var i=0;i<rows.length;i++) {
									var row = rows[i];
									if(typeof row.fuserid != 'undefined' && row.flivestate == 'zx' && row.floginname != '${user.floginname}') {
										fuserids.push(row.fuserid);
									}
								}
							}

							if(fuserids.length == rows.length) {
								$.messager.confirm('提示信息','请确认该用户没有参与到业务流程中!',function(result){
									if(!result){
										return false;
									} else {
										$.messager.confirm('确认','确认要删除吗？',function(r){
											if(r){
												window.location.href="delUUser.action?uUser.fuserid="+fuserids.join(",")+"&fdepid="+fdepid+""
											}
										});
									}
								});
							} else {
								showMessage1("请选择非本人状态为注销的数据操作！")
							}
						}
					}/*,
					{
						id:'addLdap',
						text:'选择',
						iconCls:'icon-add',
						handler:function(){
							addLdap(fdepid);
						}
					}*/
					</s:if>
				],
				onClickCell:function(rowIndex, field, value) {
					if(field == 'fname') {
						var rows = $('#objectList').datagrid('getRows');
						var row = rows[rowIndex];
						editUser(row.fuserid,fdepid,row.floginname,row.flivestate);
					}
				},
				columns:[[
					{field:'fuserid', title:'选择',checkbox:'true'},
	       			{field:'fcode',title:'用户编码',width:bodyW*0.1+'px',halign:'center',halign:'center',sortable:true},
	       			{field:'fname',title:'用户名称',width:bodyW*0.1+'px',sortable:true,halign:'center',align:'left',
		       			formatter:function(value,row,rowIndex){
							var result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
							return result;
						}
	       			},
					{field:'floginname',
							title:'系统账号',
						width:bodyW*0.1+'px',
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'fsex',
						title:'性别',
						width:bodyW*0.05+'px',
						halign:'center',
						sortable:true, 
						align:'center'
					},
					{field:'fdepname',
						 title:'所属部门或公司',
						 width:bodyW*0.1+'px',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'flevel',
						 title:'角色类型',
						 width:bodyW*0.08+'px',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
							 if(row.flevel=='admin'){
								return '系统管理';			
							 }
							 if(row.flevel=='general'){
								 return '业务操作';
							}
						 }
					},
					{field:'fstateName',
						title:'在职状态',
						width:bodyW*0.08+'px',
						halign:'center',
						align:'center',
						sortable:true,
					},
					{field:'flivestate',
						title:'启用状态',
						width:bodyW*0.08+'px',
						halign:'center',
						align:'center',
						sortable:true,
						formatter:function(value,row,rowIndex){
							if (row.flivestate=='qy'){return "启用";}
							if(row.flivestate=='zx'){return "注销";}
							if(row.flivestate=='dj'){return "冻结";}
						}
					}
					/*
					<s:if test="${ empty view || view == null || view == ''}">
					,
					{field:'operate',
						 title:'操作',
						 halign:'center', 
						 align:'center', 
						 sortable:false,
						formatter:function(value,row,index){
							var param = [row.fuserid,fdepid,row.floginname,row.flivestate];
							var btn2 = "修改,editUser,"+param.join(',')+"-btnrule-删除,userOwnCheck,"+param.join(',');
							return ganerateBtn(btn2);
					 	}
					}
					</s:if>*/
				]]   
			});
	        
	        
			$('#fdepWin').dialog({
			    title: "修改组织机构",    
			    width:  "700px",    
			    height: "150px",    
			    closed: true,    
			    cache:  false, 
			    shadow: false, 
			    modal: true,
			    resizable:true,
			    minimizable:false,
			    maximizable:true,
			    buttons:[{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						saveFdep();
					}
				}, {
					text:'关闭',
					iconCls:'icon-cancel',
					handler:function(){
						clearFdep();
						$('#fdepWin').dialog('close');
					}
				}]
			});
	        
			
	      });
		</script>
		<script type="text/javascript">
	 	function toAdd(id){
			src="/ais/admin/editUUser.action?uUser.fuserid=0&fdepid="+id;
			window.location.href=src;
		} 
		function addLdap(id){
			src="/ais/admin/listLdapUUser.action?fdepid="+id;
			window.location.href=src;
		}
		
		function saveFdep(){
			var rows =  $('#objectList').datagrid('getChecked');
			var fuserids = "";
			for(var i=0;i<rows.length;i++) {
				fuserids += rows[i].fuserid+",";
			}
			var departmentId = $("#departmentId").val();
			if ( departmentId == null || departmentId == ''){
				showMessage1('单位不能为空！');
				return false;
			}
			$.messager.confirm('提示信息','确定保存吗？保存后请修改用户角色和用户授权！',function(result){
				if(result){
					$.ajax({
						url:'<%=request.getContextPath()%>/admin/editFdep.action?departmentId='+departmentId+"&fuserids="+fuserids,
						type:'post',
						async:false,
						success:function(data){
							if ( data == '1'){
								showMessage1("修改单位成功！");
								$("#objectList").datagrid("reload");
							}
						}
					})
				}
			})
		}
		
		function clearFdep(){
			 $("#departmentId").val('');
			 $("#departmentName").val('');
		}
		
		function toEditFdep(){
			var rows =  $('#objectList').datagrid('getChecked');
			if ( rows.length <1 ){
				showMessage1('请先勾选人员！');
				return false;
			}
			var fdepid=$('#fdepid').val();
			var fuserids = new Array();
			if(rows) {
				for(var i=0;i<rows.length;i++) {
					var row = rows[i];
					if(row.floginname != '${user.floginname}') {
						fuserids.push(row.fuserid);
					}
				}
			}
			if(fuserids.length == rows.length) {
				$.messager.confirm('提示信息','请确认该用户没有参与到业务流程中!',function(s){
					if(s){
						$('#fdepWin').window('open');
					}
				})
			
			}else{
				showMessage1('请选择非本人数据操作！');
				return false;
			}

		 }
		</script>
	</body>
</html>
