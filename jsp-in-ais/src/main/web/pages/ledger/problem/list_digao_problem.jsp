<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>统计台账</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
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
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<STYLE type="text/css">
			.datagrid-row {
				height: 30px;
			}
			.datagrid-cell {
				height:20px;
				padding:0px 4px;
			}
			.datagrid-header td,.datagrid-body td {
				padding:0px 4px;
			}
		</STYLE>
	</head>
	<body>
<script type="text/javascript">
// 刷新问题列表

function refreshProLedgerPro(){
	 window.top.$.messager.show({
			title:"提示信息",
			msg:"保存成功！"
		});
}
function validateDel(value){
		  if(window.confirm('确认删除吗?')){
		    window.location.href="${pageContext.request.contextPath}/proledger/problem/delete.action?project_id=${project_id}&id="+value+"&manuscript_id=${manuscript_id}";
		  }
		  else{
		   return false;
		  }
		}

    // pluggable renders
    function renderTopic(value){
    	<s:if test="isView=='true' && manuscriptType!='uc'">
    	 var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/proledger/problem/view.action?id='+value+'&project_id=${project_id}&manuscript_id=${manuscript_id}&&isView=true">查看</a> &nbsp;&nbsp;';
	     return s;
		</s:if>
		<s:if test="isView=='true' && manuscriptType=='uc'">
    	 var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/proledger/problem/getMiddleProblem.action?id='+value+'&project_id=${project_id}&manuscript_id=${manuscript_id}&&isView=true">查看</a> &nbsp;&nbsp;';
	     return s;
		</s:if>
		<s:if test="isView!='true'">
		 var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/proledger/problem/editDigao.action?id='+value+'&project_id=${project_id}&manuscript_id=${manuscript_id}">修改</a> &nbsp;&nbsp;';
	     s+='<a style="cursor:hand" href="javascript:void(0);" onclick="return validateDel(\''+value+'\');">删除</a>';
	     return s;
		</s:if>
			
    }

    //底稿穿透页面   
    function diGaoView(value, cellmeta, record, rowIndex, columnIndex, store){
    	 var manuscript_id=record.get("manuscript_id");
         var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open(\'${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId='+manuscript_id+'\',\''
         + '\',\'width=800px,height=700px,toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no\');return false">'+value+'</a>';
	     return s;
    }

  //查看审计问题
	function viewLedgerOwner(){
	//	${pageContext.request.contextPath}/proledger/problem/view.action?isDigao=y&ids='+ids+'&id='+value+'&project_id=${project_id}&manuscript_id=${manuscript_id}&&isView=true">查看</a>
	  
		var rows = $('#ledgerProblemList').datagrid('getChecked');
		if(rows.length == 1){
			var viewSjwtUrl  = "${contextPath}/proledger/problem/view.action?project_id=<%=request.getParameter("project_id")%>&manuscript_id=${manuscript_id}&&isView=true&id="+rows[0].id +"&interaction=${interaction}";
			/*if(window.parent.$("#myFrameProblem").length > 0){
				window.parent.$("#myFrameProblem").attr("src",viewSjwtUrl);
				window.parent.$('#manuProblemDiv').window('open');
			}else{
				$("#myFrameProblem").attr("src",viewSjwtUrl);
				$('#manuProblemDiv').window('open');
			}*/
			aud$openNewTab('审计问题查看',viewSjwtUrl, true);
		}else{
			$.messager.alert("提示信息","请选择一条数据进行操作！","info");
		}
	}
	
	//增加审计问题
	function addLedgerOwner(){
      /*   getRequest().setAttribute("audDoubtpage", audDoubtpage);
        getRequest().setAttribute("DouProblem_code", DouProblem_code);
        getRequest().setAttribute("DouProblem_name", DouProblem_name);
        getRequest().setAttribute("DouPro_type", DouPro_type);
		 */
		var addSjwtUrl  = '${contextPath}/proledger/problem/editDigao.action?project_id=<%=request.getParameter("project_id")%>&id=0&manuscript_id=${manuscript_id}&manuscriptType=${manuscriptType}&audDoubtpage=${audDoubtpage}&DouProblem_code=${DouProblem_code}&DouProblem_name=${DouProblem_name}&DouPro_type=${DouPro_type}';
		//window.parent.parent.addTab('tabs','增加审计问题','tempframeAddLedger',addSjwtUrl,true);
		if(window.parent.$("#myFrameProblem").length > 0){
			window.parent.$("#myFrameProblem").attr("src",addSjwtUrl);
			window.parent.$('#manuProblemDiv').window('open');
		}else{
			$("#myFrameProblem").attr("src",addLedgerOwner);
			$('#manuProblemDiv').window('open');
		}
	}

	//修改审计问题
	function editLedgerOwner(id){
		//var rows = $('#ledgerProblemList').datagrid('getChecked');
		//if(rows.length == 1){
			var editSjwtUrl = '${contextPath}/proledger/problem/editDigao.action?project_id=<%=request.getParameter("project_id")%>&manuscript_id=${manuscript_id}&manuscriptType=${manuscriptType}&id='+id;
			/* window.open(editSjwtUrl); */
		//	window.parent.parent.addTab('tabs','修改问题','tempframeEditLedger',editSjwtUrl,true);
			if(window.parent.$("#myFrameProblem").length > 0){
				window.parent.$("#myFrameProblem").attr("src",editSjwtUrl);
				window.parent.$('#manuProblemDiv').window('open');
			}else{
				$("#myFrameProblem").attr("src",editSjwtUrl);
				$('#manuProblemDiv').window('open');
			}
		/* }else{
			$.messager.alert("提示信息","请选择一条数据进行操作！","info");
		} */
	}
	
	//删除审计问题
	function delLedgerOwner(){
		var rows = $('#ledgerProblemList').datagrid('getChecked');
	
		var selectIds = "";
		if(rows.length != 0){
			$.messager.confirm("提示信息","确认删除这 "+rows.length+" 条数据吗？",function(r){
				if(r){
					for(var i=0;i<rows.length;i++){
						var id = rows[i].id;
						selectIds = selectIds + id +',';
					}
					var manuscript_id = rows[0].manuscript_id;
					$.ajax({
	                    type: "POST",
	                    dataType:'json',
	                    url : "/ais/proledger/problem/delLedgerProblem.action",
	                    data:{ "ids":selectIds,"manuscriptType": '${manuscriptType}','manuscript_id':manuscript_id},
	                    success: function(data){
	                        if(data.type == 'ok'){
	                        	showMessage2('删除成功','提示信息',5000,'slide');
	                            window.location.reload();
	                        }else{
	                        	showMessage2('删除失败','提示信息',5000,'slide');
	                        }
	                    },
	                    error:function(data){
	                        alert('请求失败！');
	                    }
	                }); 
				}
			});
		}else{
			$.messager.alert("提示信息","请选择一条数据进行操作！","info");
		}
		/* if(rows.length != 0){
			if(confirm("确认删除吗？")){
				for(var i=0;i<rows.length;i++){
					var id = rows[i].id;
					selectIds = selectIds + id +',';
				}
				$.ajax({
                    type: "POST",
                    dataType:'json',
                    url : "/ais/proledger/problem/delLedgerProblem.action",
                    data:{ "ids":selectIds},
                    success: function(data){
                        if(data.type == 'ok'){
                        	alert("删除成功！");
                            window.location.reload();
                        }else{
                            alert('删除失败！');
                        }
                    },
                    error:function(data){
                        alert('请求失败！');
                    }
                });
			}
		}else{
			$.messager.alert("提示信息","请选择一条数据进行操作！","info");
		} */
		
	}
    
	<%String view=request.getParameter("view");%>
	<%String right=request.getParameter("isView");%>

		$(function(){
			$('#ledgerProblemList').datagrid({
				url : "<%=request.getContextPath()%>/proledger/problem/listDigaoEditProblem.action?querySource=grid&project_id=<%=request.getAttribute("project_id")%>&taskId=-1&interaction=${interaction}&manuscript_id=${manuscript_id}&manuscriptType=${manuscriptType}&audDoubtpage=${audDoubtpage}&DouProblem_code=${DouProblem_code}&DouProblem_name=${DouProblem_name}&DouPro_type=${DouPro_type}",
						//opr_ledgerproblem_list.jsp
				method:'post',
				showFooter:false,
				rownumbers:true, 
			 	pagination:true, 
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				pageSize:20,
				remoteSort: false,
				selectOnCheck: false,
				<s:if test="${view == 'view'} || ${isView == 'true'}">
				toolbar:[
					/* {id:'viewLedgerOwner',text:'查看',iconCls:'icon-view',
						handler:function(){
							viewLedgerOwner();
						}} */
				],
				</s:if>
				<s:else>
				toolbar:[		/* {
					id:'viewLedgerOwner',
					text:'查看',
					iconCls:'icon-view',
					handler:function(){
						viewLedgerOwner();
					}
				}, */
				{
					id:'addLedgerOwner',
					text:'增加',
					iconCls:'icon-add',
					handler:function(){
						addLedgerOwner();
					}
				},
				/* {
					id:'editLedgerOwner',
					text:'修改',
					iconCls:'icon-edit',
					handler:function(){
						editLedgerOwner();
					}
				}, */
				{
					id:'delLedgerOwner',
					text:'删除',
					iconCls:'icon-delete',
					handler:function(){
						delLedgerOwner();
					}
				}
			],
				</s:else>
				frozenColumns:[[
				   {field:'serial_num',width:'9%',title:'问题编号',halign:'center',align:'center',sortable:true},
                   {field:'audit_con',width:'18%',title:'问题标题',halign:'center',align:'left',sortable:true,formatter:function(value,rowData,rowIndex){
                   	
						<s:if test="${view == 'view'} || ${isView == 'true'}">
							return '<a title=\"单击查看\" href=\"javascript:void(0)\" onclick=\"toOPenProblemWindow(\''+rowData.manuscript_id+'\',\''+rowData.id+'\');\">'+rowData.audit_con+'</a>';
						</s:if>
						<s:else>
						return '<a title=\"单击编辑\" href=\"javascript:void(0)\" onclick=\"editLedgerOwner(\''+rowData.id+'\');\">'+rowData.audit_con+'</a>';
						</s:else>
                   }},
                   {field:'problem_name',title:'问题点', width:'28%',halign:'center',align:'left',sortable:true}
                 ]], 
				columns:[[
					//{field:'id',width:'5%', checkbox:true,hidden:true, align:'center',title:'fixHidden'},
					//{field:'manuscript_id', hidden:true, align:'center',title:'fixHidden'},
				/* 	{field:'manuscript_name',title:'底稿名称',width:200,halign:'center',align:'left', sortable:true,
							formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" onclick=\"toOPenWindow(\''+rowData.manuscript_id+'\');\">'+value+'</a>';
					}}, */
				//	{field:'serial_num',width:170,title:'问题编号',align:'center', sortable:true},
					
					{field:'problem_money',title:'发生金额(万元)',width:'10%',halign:'center',align:'center',sortable:true,
                        formatter:function(value,rowData,rowIndex){
                            if (value != null) {
                                value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
                                return value;
                            }
                        }
					},
					{field:'problemCount',title:'发生数量',width:'10%',sortable:true,halign:'center',align:'center'},
					{field:'zeren', title:'责任',width:'11.8%',halign:'center',align:'left',sortable:true},
					{field:'lp_owner',title:'问题发现人', width:'13%',halign:'center',align:'center',sortable:true}
	
				]],
				onLoadSuccess:function(data){
					var rows = $('#ledgerProblemList').datagrid('getRows');
				     parent.changProblemHeight(rows.length);
				}
			});
			//单元格tooltip提示
			$('#ledgerProblemList').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
			
	 	    $('#manuProblemDiv').window({
					width: '100%', 
					height:'100%',  
					modal:true,
					collapsible:false,
					maximizable:true,
					minimizable:false,
					closed:true,
					closable:true
			    });  
		});
		// 查看问题
		function toOPenProblemWindow(manuscript_id,problemId){
			var viewSjwtUrl  = "${contextPath}/proledger/problem/view.action?manuscript_id="+manuscript_id+"&&isView=true&id="+problemId +"&interaction=${interaction}&project_id=<%=request.getParameter("project_id")%>";
			aud$openNewTab('查看问题',viewSjwtUrl,true);
		}
	</script> 
		<div id="ledgerProblemList" style="margin-left: 0px"></div>
		<br>
		<div id="manuProblemDiv" title="问题"
	style='overflow: hidden; padding: 0px;'>
	<iframe id="myFrameProblem" name="myFrameProblem" title="问题" src="" width="100%"
		height="100%" frameborder="0">
	</iframe> 
</div>
	</body>
</html>
