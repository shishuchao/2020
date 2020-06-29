<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>工作方案列表</title>
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
<%--	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>--%>
	<script language="javascript">
		function editWorkProgram(id){
			window.location.href = '${contextPath}/workprogram/editWorkProgram.action?options=edit&wpid='+id;
		}
		function deleteWorkProgram(wpids){
		    $.messager.confirm('确认','确认删除该工作方案模板？', function(flag){
				if (flag) {
			  		$.ajax({
			  			url:"${contextPath}/workprogram/deleteWorkProgram.action",
			  			type:"POST",
			  			async:false,
			  			data:{"wpids":wpids},
			  			success:function(data){
			  				showMessage1('删除成功！');
				  			$('#wpList').datagrid("reload");
			  			}
			  		});
				}
			});
		}
		function copyWorkProgram(wpid){
			window.location="${contextPath}/workprogram/copyWorkProgram.action?wpid="+wpid;
		}
		function triggerSearchTable(){
		    var isDisplay = document.getElementById('planTable').style.display;
		    if(isDisplay==''){
		        document.getElementById('planTable').style.display='none';
		    }else{
		        document.getElementById('planTable').style.display='';
		    }
		}   
		function openUrl(url,height,width){
			window.open(url,"","height="+height+"px, width="+width+"px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		}
		/**
		 * 查询提交
		*/    
		function sub(){
			var  suba=document.getElementById("searchForm");
			suba.action="${contextPath}/workprogram/listWorkProgram.action?view=${view}";
		 	$('#wpList').datagrid({
				queryParams:form2Json('searchForm')
			});
			$('#workSearch').window('close');
		}
		//重置查询条件
		function resetDoubtList(){
			document.getElementsByName("workprogram.projectchildtypeid_name")[0].value = '';
			document.getElementsByName("workprogram.projecttypeid_name")[0].value = '';
			resetForm('searchForm');
		}
	</script>
</head>
<body class="easyui-layout" onload="setWorkProgramId()">
	<div id="workSearch" class="searchWindow">
		<div class="search_head">
        	<s:form id="searchForm"  name="workprogramForm" action="listWorkProgram" namespace="/workprogram" method="post">
	        	<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	                <tr>
	                    <td align="left" class="EditHead" style="width:15%;">模板名称</td>
	                    <td align="left" class="editTd" style="width:35%;">
	                        <s:textfield cssClass="noborder" name="workprogram.workprogramname" cssStyle="width:80%;" />
	                    </td>
	                    <td align="left" class="EditHead" style="width:15%;">项目类别</td>
	                    <td align="left" class="editTd" style="width:35%;">
	                        <!--<s:doubleselect  formName="workprogramForm" id="pro_type" doubleId="pro_type_child"
								doubleList="projectTypeMap[top]" doubleListKey="code" cssStyle="width:160px;"
								doubleListValue="name" listKey="code" listValue="name"
								name="workprogram.projecttypeid" list="projectTypeMap.keySet()"
								doubleName="workprogram.projectchildtypeid" theme="ufaud_simple"
								templateDir="/strutsTemplate"
								emptyOption="true"
								/>-->
							<div style="float: left;">
								<s:textfield cssClass="noborder" name="workprogram.projecttypeid_name" id="pro_type_name" cssStyle="width:160px" readonly="true"/>
								<s:textfield cssClass="noborder" name="workprogram.projectchildtypeid_name"  id="pro_type_child_name" cssStyle="width:160px" readonly="true"/>
								<img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" 
							    	onclick="getItem('/ais/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类别',500,400)"></img>
									<input type="hidden" id="pro_type" name="workprogram.projecttypeid" value="<s:property value='workprogram.projecttypeid'/>">
									<input type="hidden" id="pro_type_child" name="workprogram.projectchildtypeid" value="<s:property value='workprogram.projectchildtypeid'/>">
							</div>
	                        <div id="showWorkProgram" style="float: left;"></div>	
	                    </td>
	                </tr>
	            </table>
            </s:form>
        </div>
        <div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="sub()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetDoubtList()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#workSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div id="subwindow" class="easyui-window" title="项目类别" iconCls="icon-search" style="width:500px;height:450px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-tip" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			    </div>
			</div>
		</div>
	</div>	
    <div region="center" >
		<table id="wpList"></table>
	</div>
	<div id="workName" title="工作方案信息" style="overflow:hidden;padding:0px">
		<iframe id="showWorkName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
    <script type="text/javascript">
  		function setWorkProgramId(){
             var projtype = document.getElementsByName("workprogram.projecttypeid");
             var childprojtype = document.getElementsByName("workprogram.projectchildtypeid")[0];
             var pvalue="";
             var cpvalue="";
             if(projtype){
                 //针对如果projtypedisable，struts就会产生一个hiden的input
                 if(projtype.length==1){
                 	projtype = projtype[0];
                 }else if(projtype.length==2){
                 	projtype = projtype[1];
                 }
                 if(projtype){
                 	pvalue=projtype.value;
                 }
             }
           
             if(childprojtype){
             	if(childprojtype){
             		cpvalue=childprojtype.value;
             	}
             }
             if(cpvalue == ''){
             	document.getElementById('pro_type_child_name').style.display='none';
             }else{
                 document.getElementById('pro_type_child_name').style.display='';
             }
             var retmessage="";
             DWREngine.setAsync(false);
             DWREngine.setAsync(false);DWRActionUtil.execute(
             { namespace:'/workprogram', action:'getWorkProgramByProjType', executeResult:'false' }, 
             {'wp_projtypeid':pvalue,'wp_childprojtypeid':cpvalue},
             xxx);
             function xxx(data){
                 retmessage=data['ret_message'];
             } 
             if(retmessage!=""){
             	if (document.getElementById("workprogramid").value) {
					document.getElementById("workprogramid").value=retmessage;
				}
             }else{
				 if (document.getElementById("workprogramid").value) {
					 document.getElementById("workprogramid").value="";
				 }
             }
         }
		function getItem(url,title,width,height){
			$('#item_ifr').attr('src',url);
			$('#subwindow').window({
				title: title,
				width: width,
				height:height,
				modal: true,
				shadow: true,
				closed: false,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
		}
		function saveF(){
			var ayy = $('#item_ifr')[0].contentWindow.saveF();
			var res = ayy[0].split(',');
			var name = ayy[1].split(',');
			if(res.length != 1){
				document.all('workprogram.projectchildtypeid').value=res[0];
				document.all('workprogram.projecttypeid').value=res[1];
    			document.all('workprogram.projecttypeid_name').value=name[0];
    			document.all('workprogram.projectchildtypeid_name').value=name[1];
    			document.getElementById('pro_type_child_name').style.display='';
			}else{
				document.all('workprogram.projectchildtypeid').value='';
				document.all('workprogram.projecttypeid').value=ayy[0];
				document.all('workprogram.projecttypeid_name').value=name[0];
    			document.all('workprogram.projectchildtypeid_name').value='';
    			document.getElementById('pro_type_child_name').style.display='none';
			}
    		closeWin();
    		projectTypeChangeHandler();
    		setWorkProgramId();
		}
		function cleanF(){
			document.all('workprogram.projecttypeid').value='';
    		document.all('workprogram.projectchildtypeid').value='';
    		document.all('workprogram.projecttypeid_name').value='';
    		document.all('workprogram.projectchildtypeid_name').value='';
    		document.getElementById('pro_type_child_name').style.display='none';
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
		function openMsg(workprogramid){
			var viewUrl = '${contextPath}/workprogram/viewWorkProgram.action?wpid='+workprogramid;
           	showWinIf('workName',viewUrl,'工作方案信息');
            ///$('#showWorkName').attr("src",viewUrl);
            //$('#workName').window('open');
			//window.open("${contextPath}/proledger/problem/viewPro.action?crudId="+projectid,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		}
		
		//导出工作模板
		function exportList(){			
			window.location.href="${contextPath}/workprogram/exportlistWorkProgram.action";
		} 
		
		$('#workName').window({
            width:950, 
            height:400,  
            modal:true,
            collapsible:false,
            maximizable:true,
            minimizable:false,
            closed:true    
        });
		$(function(){
			showWin('workSearch');
			// 初始化生成表格
			$('#wpList').datagrid({
				url : "<%=request.getContextPath()%>/workprogram/listWorkProgram.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns:true,
				idField:'workprogramid',
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('workSearch','','200');
					}
				},'-',
				 <s:if test="${view ne 'view' }">
				 {  id:'add',
					text:'添加工作模板',
					iconCls:'icon-add',
					handler:function(){
						window.location='${pageContext.request.contextPath}/workprogram/editWorkProgram.action?options=add';
					}
				},'-',
					{  id:'copy',
						text:'复制',
						iconCls:'icon-copy',
						handler:function(){
							var ids = new Array();
							var rows = $('#wpList').datagrid('getChecked');
							for(i in rows) {
								if(typeof rows[i].workprogramid != 'undefined') {
									ids.push(rows[i].workprogramid);
								}
							}
							if(ids.length == 1) {
								copyWorkProgram(ids[0]);
							} else {
								showMessage1("请选择1条数据！")
							}
						}
					},'-',
					{  id:'delete',
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							var ids = new Array();
							var rows = $('#wpList').datagrid('getChecked');
							for(i in rows) {
								if(typeof rows[i].workprogramid != 'undefined') {
									ids.push(rows[i].workprogramid);
								}
							}
							if(ids.length > 0) {
								deleteWorkProgram(ids.join(","));
							} else {
								showMessage1("请选择条数据！")
							}
						}
					},'-',
	             </s:if>
				helpBtn
				/*{
					id:'exportObj',
					text:'导出Excel',
					iconCls:'icon-export',
					handler:function(){
						exportList();
					}
				}*/
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				onClickCell:function(rowIndex, field, value) {
					if(field == 'workprogramname') {
						var rows = $('#wpList').datagrid('getRows');
						var row = rows[rowIndex];
						if('${view}' != 'view') {
							editWorkProgram(row.workprogramid);
						} else {
							openMsg(row.workprogramid);
						}
					}
				},
				columns:[[
					<s:if test="${view ne 'view' }">
						{field:'workprogramid',checkbox:true,title:'选择'},
					</s:if>
					{field:'workprogramname',
	       			 title:'工作方案模块名称',
	       			 width:200,
	       			 halign: 'center',
	       			 align:'left',
	       			 sortable:true,
	       			 formatter:function(value,row,index){
						var result = '';
						if('${view}' != 'view') {
							result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
						} else {
							result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
						}
						 return result;
					 }
	       			},
	       			{field:'projecttypename',title:'项目类别',width:150,halign: 'center',align:'left',sortable:true},
					
					{field:'projectchildtypename',
							title:'子项目类别',
							width:150,
							halign: 'center',
							align:'left', 
							sortable:true
					},
					{field:'createman',
						title:'创建人',
						width:80,
						halign: 'center',
						sortable:true, 
						align:'left'
					},
					{field:'createdate',
						 title:'创建时间',
						 halign: 'center',
						 align:'center', 
						 sortable:true
					}
					<%--<s:if test="${view ne 'view' }">
					,{field:'option',
						 title:'操作',
						 halign: 'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
						 	  var param = [row.workprogramid];
							  var btn2 = "修改,editWorkProgram,"+param.join(',')+"-btnrule-删除,deleteWorkProgram,"+param.join(',')
								           +"-btnrule-复制,copyWorkProgram,"+param.join(',');
							  return ganerateBtn(btn2);
						 }
					}
					</s:if>--%>
				]]   
			}); 
		});
	</script>	
</body>
</html>