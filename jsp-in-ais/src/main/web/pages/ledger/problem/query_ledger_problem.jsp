<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题统计分析</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" /> 
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
		function exportExcel(columns){
		  document.getElementById('export').value='true';
		  document.getElementById('itemselector').value=columns;
		  queryform.action="${pageContext.request.contextPath}/proledger/problem/queryProblem.action";
	      queryform.submit();
		}

		function queryForm(){
	    	 document.getElementById('export').value='false';
	    	 queryform.action="${pageContext.request.contextPath}/proledger/problem/queryProblem.action";
		     queryform.submit();
		}
		
		//统计分析
		function analyse(){
		  var project_code= document.getElementsByName("ledgerProblem.project_code")[0].value;
		  if(project_code==''){
		     project_code="null";
		  }
		  var project_name= document.getElementsByName("ledgerProblem.project_name")[0].value;
		   if(project_name==''){
		     project_name="null";
		  }
		  var pro_year= document.getElementsByName("ledgerProblem.pro_year")[0].value;
		   if(pro_year==''){
			   pro_year="null";
		  }
		  var pro_type= document.getElementsByName("ledgerProblem.pro_type")[0].value;
		   if(pro_type==''){
			   pro_type="null";
		  }
		  var pro_type_child= document.getElementsByName("ledgerProblem.pro_type_child")[0].value;
		   if(pro_type_child==''){
			   pro_type_child="null";
		  }
		  var audit_object_name= document.getElementsByName("ledgerProblem.audit_object_name")[0].value;
		   if(audit_object_name==''){
			   audit_object_name="null";
		  }
		  var problem_name= document.getElementsByName("ledgerProblem.problem_name")[0].value;
		   if(problem_name==''){
			   problem_name="null";
		  }
		  var start_time= document.getElementsByName("ledgerProblem.real_start_time")[0].value;
		  var closed_time= document.getElementsByName("ledgerProblem.real_closed_time")[0].value;
		  var real_closed_time='null';
		  if(start_time!=''||closed_time!=''){
			   real_closed_time=start_time+'&'+closed_time;
		  }
		  var problem_grade_code= document.getElementsByName("ledgerProblem.problem_grade_code")[0].value;
		   if(problem_grade_code==''){
			   problem_grade_code="null";
		  }
		  
		  var names=project_code+","+project_name+","+audit_object_name+","+problem_name+","+pro_year+","+pro_type+","+pro_type_child+","+real_closed_time+","+problem_grade_code;
          var codes="l.project_code,l.project_name,l.audit_object_name,l.problem_name,l.pro_year,l.pro_type,l.pro_type_child,pso.real_closed_time,l.problem_grade_code";
		  document.getElementsByName("codes")[0].value=codes;
          document.getElementsByName("names")[0].value=names;
		  window.open("${pageContext.request.contextPath}/ledger/ledgerAnalyse/createTableList.action?poName=LedgerProblem&className=1&isAuth=audit_view","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		}
		
		/*
		* 	选择问题点 
		*/
		function selectProblem(){
	
			showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/ledger/problemledger/problemTreeView.action&paraname=ledgerProblem.problem_name&paraid=ledgerProblem.problem_code',600,450,'审计问题点选择');
	
		}

		 function resetbutton(){
		    	document.getElementsByName("ledgerProblem.project_code")[0].value="";
		        document.getElementsByName("ledgerProblem.project_name")[0].value="";   
		        document.getElementsByName("ledgerProblem.audit_object_name")[0].value="";   
		        document.getElementsByName("ledgerProblem.problem_name")[0].value=""; 
		        document.getElementsByName("ledgerProblem.pro_year")[0].value=""; 
		        document.getElementsByName("ledgerProblem.pro_type")[0].value="";
		        document.getElementsByName("ledgerProblem.pro_type_child")[0].value="";
		        document.getElementsByName("ledgerProblem.real_start_time")[0].value="";
		        document.getElementsByName("ledgerProblem.real_closed_time")[0].value="";
		        document.getElementsByName("ledgerProblem.problem_grade_code")[0].value="";
		        window.location.href='${contextPath}/proledger/problem/queryProblem.action';
			}
		</script>
	</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="proSituation" class="searchWindow">
		<div class="search_head">
		<s:form id="queryform" action="searchProblemLedger" namespace="/project" method="post">
			<table id="searchTable" cellpadding=0 border=0 class="ListTable" align="center">
				<tr >
					<td align="left" class="EditHead" style="width:15%">
						项目编号
					</td>
					<td align="left" class="editTd" style="width:35%">
						<s:textfield name="ledgerProblem.project_code" cssClass="noborder"
							cssStyle="width:80%"  maxlength="50"/>
					</td>
					<td align="left" class="EditHead" style="width:15%">
						项目名称
					</td>
					<td align="left" class="editTd" style="width:35%">
						<s:textfield name="ledgerProblem.project_name" cssClass="noborder"
							cssStyle="width:80%" />
					</td>
				</tr>
				<tr >
					<td align="left" class="EditHead">
						项目年度
					</td>
					<td align="left" class="editTd">
						<s:textfield cssClass="noborder" name="ledgerProblem.pro_year" cssStyle="width:80%" />
					</td>
					<td align="left" class="EditHead">
						项目类型
					</td>
					<td align="left" class="editTd">
						<div style="float: left;">
							<s:textfield cssClass="noborder" name="ledgerProblem.pro_type_name"  id="pro_type_name" cssStyle="width:80%" readonly="true"/>
							<img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" 
						    	onclick="getItem('/ais/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类型',500,400)"></img>
								<input type="hidden" id="pro_type" name="ledgerProblem.pro_type" value="<s:property value='ledgerProblem.pro_type'/>">
								<input type="hidden" id="pro_type_child" name="ledgerProblem.pro_type_child" value="<s:property value='ledgerProblem.pro_type_child'/>">
						</div>
                        <div id="showWorkProgram" style="float: left;"></div>	
					</td>
				</tr>
				<tr >
					<td align="left" class="EditHead">
						被审计单位
					</td>
					<td align="left" class="editTd">
						<!--<s:textfield name="ledgerProblem.audit_object_name"  />-->
						<s:buttonText2 cssStyle="width:80%" hiddenId="audit_object" cssClass="noborder"
							id="audit_object_name" name="ledgerProblem.audit_object_name"
							hiddenName="ledgerProblem.audit_object"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								  cache:false,
								  checkbox:true,
								  title:'请选择被审计单位'
								})"
							doubleSrc="${pageContext.request.contextPath}//easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							title="被审计单位" maxlength="1500" />
					</td>
					<td align="left" class="EditHead">
						问题点
					</td>
					<td align="left" class="editTd">
						<%--<s:buttonText2 id="problems" hiddenId="ledgerProblem.problem_code"
								name="ledgerProblem.problem_name" 
								hiddenName="ledgerProblem.problem_code"
								doubleOnclick="selectProblem()"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />--%>
						<s:buttonText id="problems" cssStyle="width:80%" hiddenId="ledgerProblem.problem_code" cssClass="noborder"
							 name="ledgerProblem.problem_name"
							hiddenName="ledgerProblem.problem_code"
							doubleOnclick="showSysTree(this,{
				    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
				    				onlyLeafCheck:true,
				    				title:'请选择问题点'
								})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr >
					<td align="left" class="EditHead" >
						审计单位
					</td>
					<td align="left" class="editTd">
						<!-- 
					showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp
					?url=${pageContext.request.contextPath}/systemnew/orgList.action
					&p_item=1&orgtype=1
					&paraname=crudObject.audit_dept_name
					&paraid=crudObject.audit_dept',600,350,'组织机构选择')
					 -->
						<s:buttonText2 id="ledgerProblem.audit_dept_name" cssClass="noborder"
							cssStyle="width:80%;" readonly="true"
							name="ledgerProblem.audit_dept_name"
							hiddenName="ledgerProblem.audit_dept"
							hiddenId="ledgerProblem.audit_dept"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
								  title:'请选择审计单位'
								})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" maxlength="50" />
					</td>
					<td align="left" class="EditHead">
						问题定性
					</td>
					<td align="left" class="editTd">
						<!--<s:select list="basicUtil.problemMethodList" listKey="code" cssClass="easyui-combobox"
							cssStyle="width:180px;" listValue="name" emptyOption="true"
							name="ledgerProblem.problem_grade_code"></s:select>-->
					    <select class="easyui-combobox" name="ledgerProblem.problem_grade_code" style="width:80%"  editable="false">
					       <option value="">&nbsp;</option>
					       <s:iterator value="basicUtil.problemMethodList" id="entry">
					         <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       </s:iterator>
					    </select>
					</td>
				</tr>
				<tr >
					<td align="left" class="EditHead" cssStyle="width:15%;">
						查询期间
					</td>
					<td align="left" class="editTd"   colspan="3" cssStyle="width:85%;" >
						<input type="text" class="easyui-datebox"   name="ledgerProblem.real_start_time" style="width:27%;" title="单击选择日期"   editable="false" />	
						至
						<input type="text" Class="easyui-datebox"   name="ledgerProblem.real_closed_time" style="width:26.9%;" title="单击选择日期"   editable="false" />
					</td>
					
					
				</tr>
			</table>
			<s:hidden id="export" name="export"></s:hidden>
			<s:hidden id="itemselector" name="itemselector"></s:hidden>
			<input type="hidden" name="codes">
			<input type="hidden" name="names">
		</s:form>
		</div>
		<div class="serch_foot">
		    <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#proSituation').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div id="subwindow" class="easyui-window" title="项目类型" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-delete" href="javascript:void(0)" onclick="closeWin()">退出</a>
			    </div>
			</div>
		</div>
	</div>
	<div region="center" >
		<table id="list"></table>
	</div>	
	<div id="planName" ></div>
	<script type="text/javascript">
		function setWorkProgramId(){
             var projtype = document.getElementsByName("ledgerProblem.pro_type");
             var childprojtype = document.getElementsByName("ledgerProblem.pro_type_child")[0];
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
             	document.getElementById("workprogramid").value=retmessage;
             }else{
             	document.getElementById("workprogramid").value="";
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
				document.all('ledgerProblem.pro_type_child').value=res[0];
				document.all('ledgerProblem.pro_type').value=res[1];
    			document.all('ledgerProblem.pro_type_name').value=name[0];
    			document.all('ledgerProblem.pro_type_child_name').value=name[1];
    			document.getElementById('pro_type_child_name').style.display='';
			}else{
				document.all('ledgerProblem.pro_type_child').value='';
				document.all('ledgerProblem.pro_type').value=ayy[0];
				document.all('ledgerProblem.pro_type_name').value=name[0];
    			document.all('ledgerProblem.pro_type_child_name').value='';
    			document.getElementById('pro_type_child_name').style.display='none';
			}
    		closeWin();
    		projectTypeChangeHandler();
    		setWorkProgramId();
		}
		function cleanF(){
			document.all('ledgerProblem.pro_type').value='';
    		document.all('ledgerProblem.pro_type_child').value='';
    		document.all('ledgerProblem.pro_type_name').value='';
    		document.all('ledgerProblem.pro_type_child_name').value='';
    		document.getElementById('pro_type_child_name').style.display='none';
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
		/*
		* 查询
		*/
		function doSearch(){
        	$('#list').datagrid({
				queryParams:form2Json('queryform')
			});
			$('#proSituation').dialog('close');
        }
		/**
			重置
		*/	
		function restal(){
			resetForm('queryform');
			//doSearch();
		}
		function execExport(columns){
			var real_start_time = $("#real_start_time").val();
			var real_closed_time = $("#real_closed_time").val();
							
		  document.getElementById('export').value='true';
		  document.getElementById('itemselector').value=columns;
		  queryform.action="${pageContext.request.contextPath}/proledger/problem/queryProblem.action?querySource=grid";
	      queryform.submit();
		}
		$(function(){
			showWin('planName','公用弹框页面');
			showWin('proSituation');
			// 初始化生成表格
			$('#list').datagrid({
				url : '<%=request.getContextPath()%>/proledger/problem/queryProblem.action?querySource=grid',
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('proSituation',900);
						}
					},
					{
						id:'toExcel',
						text:'导出',
						iconCls:'icon-export',
						handler:function(){
							showPopWin('${contextPath}/pages/ledger/problem/columnSelector.jsp',500,350);
						}
					}/* ,
					{
						id:'toTongJi',
						text:'统计分析',
						iconCls:'icon-save',
						handler:function(){
							analyse();
						}
					} */
				],
				frozenColumns:[[
				       			{field:'project_code',title:'项目编号',halign:'center',width:'288px',align:'left',sortable:true},
				       			{field:'project_name',title:'项目名称',halign:'center',width:'295px',sortable:true,align:'left'}
				    		]],
				columns:[[  
					{field:'serial_num',
							title:'问题编号',
							halign:'center',
							align:'right', 
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" onclick="planName(\'${contextPath}/proledger/problem/viewDecideLedgerProblem.action?id='+rowData.id+'\')" >'+rowData.serial_num+'</a>';
					}},		
					{field:'audit_con',
						title:'问题标题',
						width:200,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'problem_all_name',
						title:'问题类别',
						width:200,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'problem_name',
						 title:'问题点',
						 width:150, 
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'problem_grade_name',
						 title:'审计发现类型',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'problem_money',
						 title:'发生金额(万元)',
						 halign:'center',
						 align:'right', 
						 sortable:true
					},
					{field:'problemCount',
						 title:'发生数量(个)',
						 halign:'center',
						 align:'right', 
						 sortable:true
					},					
					{field:'audit_dept_name',
						title:'审计单位',
						width:200,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'audit_object_name',
						title:'被审计单位',
						width:200,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'creater_name',
						title:'发现人',
						width:100,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'problem_date',
						title:'发现时间',
						width:200,
						halign:'center',
						sortable:true, 
						align:'left',
						 formatter:function(value,row,rowIndex) {
							 var date = row.problem_date;
							// String str = date.toString();
							var time = new Date(date);
							var y = time.getFullYear();
							var m = time.getMonth()+1;
							var d = time.getDate();

							 return y+"-"+m+"-"+d;
							 }
					},
				]]   
			}); 
		});
		//弹出窗口方法
		function planName(url){
			showWinIf('planName',url,'审计问题',1000);
		}
	</script>
</body>
</html>
