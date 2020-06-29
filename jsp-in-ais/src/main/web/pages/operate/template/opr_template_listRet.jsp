<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<s:head theme="ajax" />
	<title>回传方案</title>
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
	<script language="javascript">
		function searchList(){
		//匹配查询
			var url = "${contextPath}/operate/template/listRet.action?interCtrl=${interCtrl}";
			searchForm.action = url;
			searchForm.submit();
			
		}
		function searchrecal(){
            resetForm('searchForm');
			/*var url = "${contextPath}/operate/template/listRet.action";
		    window.location = url;*/
		}
		function closeGenW(){
	      window.location.href="${contextPath}/operate/template/list.action?interCtrl=${interCtrl}";
        }
        
        function refereshW(){
	      window.location.href="${contextPath}/operate/template/list.action?interCtrl=${interCtrl}";
        }
		//编辑
         function add() {
		     window.paramw = "模态窗口";//
	         window.showModalDialog('${contextPath}/operate/template/addTemplate.action?interCtrl=${interCtrl}', window, 'dialogWidth:720px;dialogHeight:300px;status:yes');
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	   	 }
		//编辑
         function addOne(s){
		     var title='复制方案';
		     window.paramw = "模态窗口";//
             //window.showModalDialog('${contextPath}/operate/template/addTemplate.action', window, 'dialogWidth:720px;dialogHeight:300px;status:yes');
		     window.location.href='${contextPath}/operate/template/copyTemplate.action?interCtrl=${interCtrl}&ret=true&audTemplateId='+s; 
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		 }
         function editRecord(s){
         	var url = "${contextPath}/operate/template/main.action?interCtrl=${interCtrl}&audTemplateId="+s;
         	window.parent.parent.addTab('tabs','修改回传方案','editWin',url,true);
         	//showWinIf('editWin',url,"修改回传方案",1300,600);
		 }
		 //删除
         function deleteRecord(s) {
         	$.messager.confirm('确认','确认删除这条记录?', function(flag){
         		if(flag){
					//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
					//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
					searchForm.action = "${contextPath}/operate/template/delete.action?interCtrl=${interCtrl}&ret=true&publishAuth=${publishAuth}&audTemplateId="+s;
					//searchForm.submit();
					$.ajax({
						url:"${contextPath}/operate/template/delete.action?interCtrl=${interCtrl}&ret=true&publishAuth=${publishAuth}&audTemplateId="+s,
						type:'POST',
						async:false,
						success:function(){
							showMessage2('删除成功！');
							$('#itsss').datagrid('reload');
						}
					})
          		}
         	});
		 }
		  function publish(id){
			 $.messager.confirm('确认','确认发布这条记录?', function(flag){
				 if(flag){
					 $.ajax({
							type: "POST",
		   					url: "<%=request.getContextPath()%>/operate/template/publishById.action?interCtrl=${interCtrl}",
		   					data: "audTemplate.audTemplateId="+id,
		   					success: function(msg){
		     					showMessage2('发布成功!');
		     					$('#itsss').datagrid('reload');
							}
					});
				 }
			 });
		}
		  
		//查看
			function viewRecord(s){
		    	var url = "${contextPath}/operate/template/mainView.action?interCtrl=${interCtrl}&audTemplateId="+s;
		    	showWinIf('editWin',url,'查看审计方案内容');
		        /*win = window.open("${contextPath}/operate/template/mainView.action?audTemplateId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		        var h = window.screen.availHeight;
		        var w = window.screen.width; 
		    	win.moveTo(0,0)   
		        win.resizeTo(w,h) 
		    	if(win && win.open && !win.closed) {
		            win.focus();
		    	}*/
			} 
		//调用父窗口方法
		function useParentFun(){
			this.opener.stopx();  
		}
		
		function viewInfo(id,link){
			var url;
			if(link!=null && link!=''){
				url = "${contextPath}/"+link;
				window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
			}else{
				url = "${contextPath}/bpm/systemprompt/viewDetailSystemPrompt.action?id="+id;
				window.location = url;
			}
		}
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="listRetSearch" class="searchWindow">
		<div class="search_head">
			<s:form id="searchForm"  name="searchForm" action="view.action" namespace="/operate/template">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead">方案名称</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield cssClass="noborder" cssStyle="width:80%" name="audTemplate.templateName" />
							<!--一般文本框-->
						</td>
						<td class="EditHead">编制人</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield cssClass="noborder" cssStyle="width:80%"  name="audTemplate.proAuthorName"></s:textfield>
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
						</td>
					</tr>
					<tr>
						<td class="EditHead">编制日期</td>
						<td class="editTd" colspan="3">
							<input name="audTemplate.proDate1" title="单击选择日期"  style="width:28%;" class="easyui-datebox" editable="false"/>
							-
							<input name="audTemplate.proDate2" title="单击选择日期"  style="width:28%;" class="easyui-datebox" editable="false"/>
						</td>
					</tr>
				</table>
				<s:hidden name="type" />
				<s:hidden name="publishAuth" value="publishAuth" />
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch();">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="searchrecal();">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#listRetSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center" border='0'>
		<table id="itsss"></table>
	</div>
	<div id="editWin"></div>
	<script type="text/javascript">
	 	function doSearch(){
        	$('#itsss').datagrid({
    			queryParams:form2Json('searchForm')
    		});
    		$('#listRetSearch').dialog('close');
        }
        var publishAuth=document.getElementsByName("publishAuth")[0];
		$(function(){
	        showWin('editWin','审计方案修改');
			//查询
			showWin('listRetSearch')
			// 初始化生成表格
			$('#itsss').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/listRet.action?interCtrl=${interCtrl}&querySource=grid&publishAuth="+publishAuth.value,
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				fit: true,
				pageSize:20,
				fitColumns:true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('listRetSearch');
					}
				}],
				frozenColumns:[[
	       			{field:'templateName',title:'方案名称',width:220,halign:'center',align:'left',sortable:true,
	       				formatter:function(value,row,index){
							 return '<a href="javascript:void(0);" onclick=\"viewRecord(\''+row.audTemplateId+'\'); return false;\">'+row.templateName+'</a>';
						 }
	       			},
	       			{field:'proVer',title:'方案版本',width:100,sortable:true,halign:'center',align:'left'}
	    		]],
				columns:[[  
					{field:'typeName',
							title:'类别名称',
							width:200,
							halign:'center',
							align:'left', 
							sortable:true
						},
					{field:'typeName2',
						title:'子类别名称',
						width:200,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'proAuthorName',
						 title:'编制人',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'proDate',
						 title:'编制日期',
						 align:'center',
						 halign:'center',
						 sortable:true ,
						 formatter:function(value,row,index){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					},
					{field:'operate',
						 title:'操作',
						 halign:'center',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
						 	var param = [row.audTemplateId];
						 	var btn2 = "修改,editRecord,"+param.join(',')+"-btnrule-删除,deleteRecord,"+param.join(',');
						 	//if('${magOrganization.fid}' == '1') {
						 		btn2 += "-btnrule-复制,addOne,"+param.join(',');
						 //	}
						 	var  sd="";
						 	if(row.publish != "1"){
						 	  	btn2 += "-btnrule-发布,publish,"+param.join(',');
							}
							return ganerateBtn(btn2);
							  var a =  '<a href="javascript:void(0);" onclick=\"editRecord(\''+row.audTemplateId+'\'); return false;\">内容编辑</a>&nbsp;&nbsp <a href="javascript:void(0);" onclick=\"deleteRecord(\''+row.audTemplateId+'\'); return false;\">删除</a>&nbsp;&nbsp<a href="javascript:void(0);"onclick=\"addOne(\''+row.audTemplateId+'\'); return false;\">复制</a>&nbsp;&nbsp '+sd;
						 }
					}
				]]   
			}); 
		});
	</script>
</body>
</html>

