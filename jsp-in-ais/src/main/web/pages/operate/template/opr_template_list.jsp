<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<s:head theme="ajax" />
	<title>审计方案发布</title>
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
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell-c1-xxx {
			height:10%;
			padding:1px;
		}
	</STYLE>
	<script language="javascript">
 		function addEvent(obj, evType, fn){
			 if (obj.addEventListener){
			    obj.addEventListener(evType, fn, false);
			    return true;
			 } else if (obj.attachEvent){
			    var r = obj.attachEvent("on"+evType, fn);
			    return r;
			 } else {
			    return false;
			 }
		}
		//匹配查询
		function searchList(){
			var url = "${contextPath}/operate/template/list.action";
			searchForm.action = url;
			searchForm.submit();
			
		}
        //导入方案
		function inexcel(s){
		  var title="导入方案";
		  var url = '${contextPath}/operate/template/imExcel.action?interCtrl=${interCtrl}&audTemplateId='+s;
		  showWinIf('editWin',url,title,600,200);
		  //showPopWin('${contextPath}/operate/template/imExcel.action?audTemplateId='+s,600,200,title);
		}

        //重置
		function searchrecal(){
            resetForm('searchForm');
			/*var url = "${contextPath}/operate/template/list.action";
		    window.location = url;*/
		}
		
		function closeGenW(){
	      	window.location.href="${contextPath}/operate/template/list.action?interCtrl=${interCtrl}";
        }
        
        function refereshW(){
	      	window.location.href="${contextPath}/operate/template/list.action?interCtrl=${interCtrl}";
        }
		
		//增加方案
       function add(){
       		var url = '${contextPath}/operate/template/addTemplate.action?interCtrl=${interCtrl}';
       		showWinIf('editWin',url,'新增审计方案','900',500);
             //window.showModalDialog('${contextPath}/operate/template/addTemplate.action', window, 'dialogWidth:720px;dialogHeight:300px;status:yes');
		     //showPopWin('${contextPath}/operate/template/addTemplate.action',700,400,title);
		     //var num=Math.random();
		     //var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	   }
	   //编辑
       function editRecord(s){
        	var url = "${contextPath}/operate/template/main.action?interCtrl=${interCtrl}&audTemplateId="+s;
        	window.parent.parent.addTab('tabs','修改预制方案','editWin',url,true);
        	//allWindShow('editWin',"${contextPath}/operate/template/main.action?audTemplateId="+s,1400,600);
        	return false;
		} 
		//复制方案
        function addOne(s){
		     var title='复制方案';
		     window.paramw = "模态窗口";//
             //window.showModalDialog('${contextPath}/operate/template/addTemplate.action', window, 'dialogWidth:720px;dialogHeight:300px;status:yes');
		     window.location.href='${contextPath}/operate/template/copyTemplate.action?interCtrl=${interCtrl}&ret=false&audTemplateId='+s; 
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		}
		//删除
        function deleteRecord(s){
			//alert(doubt_idArray[i].value); 
			$.messager.confirm('提示信息','确认删除这条记录?',function(flag){
				if(flag){
					searchForm.action = "${contextPath}/operate/template/delete.action?interCtrl=${interCtrl}&audTemplateId="+s;
					searchForm.submit();
				}
			});
		}
		//调用父窗口方法
		function useParentFun(){
			this.opener.stopx();  
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
		var searchTable="222";
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="listSearch" class="searchWindow">
		<div class="search_head">
			<s:form id="searchForm" action="view.action" namespace="/operate/template">
				<table id="searchTable" class="ListTable">
					<tr >
						<td class="EditHead">方案名称
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="audTemplate.templateName" />
							<!--一般文本框-->
						</td>
						<td class="EditHead">编制人</td>
						<!--标题栏-->
						<%-- onclick="showPopWin('/ais/pages/system/search/frameselect4s.jsp?url=../userindex.jsp&paraname=audTemplate.proAuthorName&paraid=audTemplate.proAuthorCode',600,450)" --%>
						<td class="editTd">
							<s:textfield  cssClass="noborder" cssStyle="width:80%" name="audTemplate.proAuthorName"></s:textfield>
							<s:hidden name="audTemplate.proAuthorCode" />&nbsp;
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
						eg.
							search/frameselect4s.jsp?url=../userindex.jsp&paraname=users&paraid=usersid&extend=5
					 -->
						</td>
					</tr>
					<tr >
						<td class="EditHead">编制日期</td>
						<td class="editTd" colspan="3">
							<input name="audTemplate.proDate1" title="单击选择日期"  style="width:28%" class="easyui-datebox" editable='false'/>
							-
							<input name="audTemplate.proDate2" title="单击选择日期"  style="width:28%;" class="easyui-datebox" editable='false'/>
						</td>
					</tr>
				</table>
				<s:hidden name="type" />
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch();">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="searchrecal();">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#listSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center"  border='0'>
		<table id="its"></table>
	</div>
	
	<div id="editWin"></div>
	<script type="text/javascript">
		 function doSearch(){
	       	$('#its').datagrid({
	   			queryParams:form2Json('searchForm')
	   		});
	   		$('#listSearch').dialog('close');
	     }
		 $(function(){
		 	//查询
			showWin('editWin','审计方案修改');
		 	//查询
			showWin('listSearch');
		 	var bodyW = $('body').width();
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/list.action?querySource=grid&interCtrl=${interCtrl}",
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
						searchWindShow('listSearch');
					}
				},
				{
					id:'newYear',
					text:'增加',
					iconCls:'icon-add',
					handler:function(){
						add();
					}
				}],
				frozenColumns:[[
				       			{field:'templateName',title:'方案名称',width:bodyW * 0.15 + 'px',halign:'center',align:'left',sortable:true,
				       				formatter:function(value,row,index){
										 return '<a href="javascript:void(0);" onclick=\"viewRecord(\''+row.audTemplateId+'\'); return false;\">'+row.templateName+'</a>';
									 }	
				       			
				       			},
				       			{field:'proVer',title:'方案版本',width:bodyW * 0.06 + 'px',sortable:true,halign:'center',align:'center'}
				    		]],
				columns:[[  
					{field:'typeName',
							title:'类别名称',
							width:bodyW * 0.14 + 'px',
							halign:'center',
							align:'left', 
							sortable:true
						},
					{field:'typeName2',
						title:'子类别名称',
						width:bodyW * 0.14 + 'px',
						sortable:true,
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
						 width:bodyW * 0.1 + 'px',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					},
					{field:'xxx',
						 title:'操作',
						 width:bodyW * 0.2 + 'px',
						 halign:'center',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
						 	var param = [row.audTemplateId];
							var btn2 = "修改,editRecord,"+param.join(',')+"-btnrule-删除,deleteRecord,"+param.join(',')
							           +"-btnrule-导入,inexcel,"+param.join(',');
							//if('${magOrganization.fid}' == '1') {
								btn2 += "-btnrule-复制,addOne,"+param.join(',');
							//}
							return ganerateBtn(btn2);
						 }
					}
				]]   
			}); 
		});
	</script>	
</body>
</html>

