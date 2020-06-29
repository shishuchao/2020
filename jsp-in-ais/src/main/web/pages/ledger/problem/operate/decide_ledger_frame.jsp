<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>定稿问题</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	</head>
	<body >
	 	 <div id="importProjects" style="padding: 0px;overflow:hidden" title="导入问题" >

		<!-- </div>
		<div id="importProjects" class="easyui-window" closed="true"> -->
					<s:form id="importForm" action="importDecideLedgerProblem" namespace="/proledger/problem" method="post" enctype="multipart/form-data" onsubmit="wait();">
						<s:hidden name="project_id"  value="${project_id}"/>
						<s:hidden name="view" value="${view }"/>
						<s:hidden name="projectType" value="${projectType }"/>
						<s:hidden name="sourceSite" value="${sourceSite}"/>
						<input type='hidden' name='beanName' value="LedgerTemplateNew"/>
				        <input type='hidden' name='treeId' value="id"/>
				        <input type='hidden' name='treeText' value="code"/>
				        <input type='hidden' name='treeParentId' value="fid"/>
						<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
							<tr>
								<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
								<td class="editTd" align="left"><s:file name="template" size="66%" cssStyle="font-size:15px" accept="application/vnd.ms-excel"/></td>
								<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-import'" id="importButton" onclick="submit_dr();">导入</a></td>
								<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-download'" id="download" onclick="load()">下载模板</a></td>
							</tr>
						</table>
						<s:hidden name="listStatus" />
					</s:form>
					
					
			<div region="center" border='0'>
			<div id="layer" style="display: none" align="center">
				<img src="${contextPath}/images/uploading.gif"> <br> 正在读取，请稍候......
			</div>
			<div align="left" id="errorInfo1">
				<s:if test="%{#tipList.size != 0}">
					<s:iterator value="%{#tipList}">
						&nbsp;&nbsp;&nbsp;●<s:property value="%{position}" />：<s:property value="%{errorInfo}" />
						<br>
					</s:iterator>
				</s:if>
			</div>
			<div align="left" id="errorInfo2">
				<s:if test="%{#tipMessage != null}">
					&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}" />
				</s:if>
			</div>
		 </div>	
	</div>
		<div id="operate-opr_ledger_list_mid">
		</div>
		<div id="shareLedgerWin" title="问题共享设置" style='overflow:hidden;padding:0px;'>
			<s:form id="sendBackForm" action="" namespace="" method="post" >
				<table class="ListTable" align="center" >
					<tr class="listtablehead">
						<td valign="middle" nowrap="nowrap" class="EditHead" style="width: 50%">
							<font color="red">*</font>是否共享
						</td>
						<td class="editTd" style="width: 50%">
							<label><input name="option" type="radio" value="1" />是 </label> 
							<label><input name="option" type="radio" value="0" />否 </label> 
						</td>
					</tr>
				</table>
			</s:form>
			<input  type="hidden" name="share_id" id="share_id"/>
			</br>
			<div style='text-align:center;' id='shareBtnDiv' style='padding:10px;'>
        		<a  id='saveId'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
        		<a  id='closeShare' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>							        
		    </div>
		</div>
		<div id="inReport" title="是否采纳审计意见" style='overflow:hidden;padding:0px;'>
			<s:form id="sendBackForm" action="" namespace="" method="post" >
					<table class="ListTable" align="center" >
						<tr class="listtablehead">
							<td valign="middle" nowrap="nowrap" class="EditHead" style="width: 10%">
								是否采纳审计意见：
							</td>
							<td class="editTd" style="width: 90%">
								<select id="sfcnsjyj" class="easyui-combobox" name="sfcnsjyj" style="width:160px;" editable="false" data-options="panelHeight:'auto'">
							       <s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
							       </s:iterator>
							    </select>	
							</td>
						</tr>
					</table>
				</s:form>
				<input  type="hidden" name="inReport_id" id="inReport_id"/>
				<br>
				<div style='text-align:center;' id='InReportBtnDiv' style='padding:10px;'>
	        		<a  id='saveId1'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        		<a  id='closeInReport' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>							        
			    </div>
		</div>
		<div id="examineId">
		  <s:form method="post" id="examineForm">
		     <table class="ListTable" align="center">
		       <tr  class="listtablehead">
		        <td class="EditHead" style="width: 15%">整改期限开始</td>
		        <td class="editTd" style="width:35%">
		          <input type="text" class="easyui-datebox" name="mend_term"  id="mend_term" editable="false"/>
		        </td>
		        <td class="EditHead" style="width: 15%">整改期限结束</td>
		        <td class="editTd" tyle="width:35%">
		         <input type="text" name="mend_term_enddate" class="easyui-datebox" id ="mend_term_enddate" editable="false"/>
		        </td>
		       </tr>
		         <tr  class="listtablehead">
		        <td class="EditHead">监督检查人</td>
		        <td class="editTd">
		           <select class="easyui-combobox" name="examine_creater_code" id="examine_creater_code" data-options="editable:false,panalHeight:'auto'" >
		             <s:iterator value="examineCreaterMap">
		             <option value="<s:property value="key"/>"><s:property value="value"/></option>
		             </s:iterator>
		           </select>
		        </td>
		        <td class="EditHead"></td>
		        <td class="editTd"></td>
		       </tr>
		     </table>
		  </s:form>
		
		</div>
		<script type="text/javascript">
		var g1;
			$(function(){
				$('#inReport').window({
					width:500,
					height:200,
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				var bodyW = $('body').width();    
			    var bodyH = $('body').height(); 
				g1 = $('#operate-opr_ledger_list_mid').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/decideLedgerProblemMain.action?querySource=grid&project_id=<%=request.getAttribute("project_id")%>",
							//project_problem_decide_list.jsp
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
					selectOnCheck:false,
					onLoadSuccess:function(){
						initHelpBtn();
					},
					onClickCell:function(rowIndex, field, value) {
						if(field == 'audit_con') {
							var rows = $('#operate-opr_ledger_list_mid').datagrid('getRows');
							var row = rows[rowIndex];
							if (${isLeader == '1' && view != 'view'}){
								editLedgerOwner(row.id);
							}else{
								toOPenProblemWindow(row.manuscript_id,row.id);
							}
						}
					},
					frozenColumns:[[
						<s:if test="${view != 'view'}">
							{field:'id',width:'50', checkbox:true, align:'center'},
						</s:if>
						{field:'audit_con',title:'问题标题',width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true,
							formatter:function(value,rowData,rowIndex){
								var result;
								if (${isLeader == '1' && view != 'view'}){
									result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
								} else {
									result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
								}
								return result;
			                   //	return '<a href=\"javascript:void(0)\" onclick=\"toOPenProblemWindow(\''+rowData.manuscript_id+'\',\''+rowData.id+'\');\">'+rowData.audit_con+'</a>';
			                }
						},
						{field:'serial_num',title:'问题编号',width:bodyW*0.14 + 'px',align:'center', sortable:true}
					         ]],
					columns:[[
						{field:'problem_all_name',title:'问题类别',width:bodyW*0.13 + 'px',sortable:true, align:'center',hidden:true},
						{field:'problem_name',title:'问题点',width:bodyW*0.14 + 'px',halign:'center',align:'left',sortable:true},
						{field:'audit_object_name',title:'被审计单位',width:bodyW*0.14 + 'px',halign:'center',align:'left',sortable:true},
						
						{field:'problem_money',title:'涉及金额(万元)',width:bodyW*0.14 + 'px',halign:'center',align:'right',sortable:true,hidden:true,
							formatter:function(value,rowData,rowIndex){
								if (value != null) {
									value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
									//return value +"/万元";
									return value;
								}
							}
						},
						{field:'problemCount',title:'发生数量(个)',width:bodyW*0.14 + 'px',sortable:true,halign:'center',align:'center',hidden:true},
						{field:'ofsDetail',title:'重要程度', width:100,halign:'center',align:'center',sortable:true},
						{field:'problem_grade_name',title:'审计发现类型',width:bodyW*0.14 + 'px',align:'center',sortable:true},
						{field:'wgwjlxName',title:'违规违纪类型',width:bodyW*0.1 + 'px',halign:'center',align:'left',sortable:true},
						{field:'wgwjje',title:'违规违纪金额(万元)',width:bodyW*0.1 + 'px',halign:'center',align:'right',sortable:true,
							formatter:function(value,rowData,rowIndex){
								if (value != null) {
									value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
									return value;
								}
							}
						},
						{field:'sfcnsjyj',title:'是否采纳审计意见',width:bodyW*0.09 + 'px',halign:'center',align:'center',sortable:true}
/*						,{field:'inspection',title:'标记状态',width:bodyW*0.14 + 'px',align:'center',sortable:true,
							formatter:function(value,rowData,rowIndex){
						    	if(value == '1'){
						    	    return '外部门可见';
								}
								return "外部门不可见";
							}
						}*/
					]]  
				});

                if (${isLeader == '1' && view != 'view'}){
					$('#operate-opr_ledger_list_mid').datagrid({
						toolbar:[
							{
									id:'addLedgerOwner',
									text:'增加',
									iconCls:'icon-add',
									handler:function(){
										addLedgerOwner();
									}
								},'-',
						/* 		{
									id:'editLedgerOwner',
									text:'修改',
									iconCls:'icon-edit',
									handler:function(){
										editLedgerOwner();
									}
								},'-', */
								{
									id:'delLedgerOwner',
									text:'删除',
									iconCls:'icon-delete',
									handler:function(){
										delLedgerOwner();
									}
								},'-',
								// {
								// 	id:'shareLedger',
								// 	text:'共享设置',
								// 	iconCls:'icon-edit',
								// 	handler:function(){
								// 		shareLedgerOwner();
								// 	}
								// },
								{
									id:'export',
									text:'导入',
									iconCls:'icon-export',
									handler:function(){
										$('#download').linkbutton('enable');
										$('#importProjects').window('open');
									}
								},'-',
								{
									id:'export',
									text:'导出',
									iconCls:'icon-export',
									handler:function(){
										expLedgerOwner();
									}
								},'-',
								{
									id:'export',
									text:'是否采纳审计意见',
									iconCls:'icon-edit',
									handler:function(){
										inLedgerOwner();
									}
								},
							<s:if test="${sourceSite == 'historyedit' || sourceSite == 'syEdit' }">
							'-',{
								id:'examine',
								text:'整改设定',
								iconCls:'icon-edit',
								handler:function(){
									examineFun();
								}
							},
							</s:if>	
								
							  '-',helpBtn
						]
					});	
					
				}else{
					$('#operate-opr_ledger_list_mid').datagrid({
						toolbar:[
					/* 	{
							id:'viewLedgerOwner',
							text:'查看',
							iconCls:'icon-view',
							handler:function(){
								viewLedgerOwner();
							}
						}, */'-',helpBtn
						]
					});	
				}
				
				if(${isLeader == '1' && view != 'view'}){
					$('#manuList').datagrid({
						toolbar:[
					/* 	{
							id:'viewLedgerOwner',
							text:'查看',
							iconCls:'icon-view',
							handler:function(){
								viewLedgerOwner();
							}
						}, */'-',helpBtn
						]
					});					
				}
				//单元格tooltip提示
				$('#operate-opr_ledger_list_mid').datagrid('doCellTip', {
					onlyShowInterrupt : 'true',
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
				
				$('#shareLedgerWin').window({   
					width:500,   
					height:200,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				
				$('#importProjects').window({
					title:'问题导入',
					modal:true,
					width:900,
					height:450,
					minimizable: false,
					maximizable: false,
					collapsible: false,
					closed:true
				});
				
				<s:if test="${operate1 == 'imp'}">
			 	  $('#importProjects').window('open');
				</s:if> 
				
				//保存事件
				$('#saveId').bind('click',function(){
					var checkVal =$("input[type='radio']:checked").val();
					var share_id =$('#share_id').val();
					$.ajax({
						type: "POST",
						dataType:'json',
						url : "/ais/proledger/problem/shareInspectionSetting.action",
						data:{
							'id':share_id,
							'checkVal':checkVal
						},
						success: function(data){
							if(data.type == 'ok'){
								$('#shareLedgerWin').window('close');
								showMessage2("保存成功！");	
								window.location.reload();
							}else{
								showMessage2("保存失败！");	
							}		
						},
						error:function(data){
							showMessage2("请求失败！");	
						}
					});	
				});
				
				//关闭按钮
				$('#closeShare').bind('click',function(){
					$('#shareLedgerWin').window('close');
				});
				
				$("#examineId").dialog({
					title:'整改要求设定',
					width:900,
					height:300,
					closed:true,
					resizable:true,
					cache:  false, 
					shadow: false, 
					minimizable:true,
					maximizable:true,
					modal:true,
					//iconCls:'icon-edit',
					onOpen:function(){
						clearExamine();
					},
					buttons:[{
						text:'保存',
						iconCls:'icon-save',
						handler:function(){
							saveExamine();
						}
					},{
						text:'清空',
						iconCls:'icon-empty',
						handler:function(){
							clearExamine();
						}
					},{
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							clearExamine();
							$("#examineId").dialog("close");
						}
					}
					
					]
					
				})
			});

			function examineFun(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if ( rows.length < 1){
					showMessage1("请选择一条记录!");
					return false;
				}else{
					$("#examineId").window("open");
					//clearExamine();
					var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
					var mend_term = rows[0].mend_term;
					var s = mend_term&& mend_term.length > 10 ? mend_term.substring(0,10) :mend_term;
					
					var mend_term_enddate = rows[0].mend_term_enddate;
					var e = mend_term_enddate&& mend_term_enddate.length > 10 ? mend_term_enddate.substring(0,10) :mend_term_enddate;
					
					var examine_creater_code = rows[0].examine_creater_code;
					if ( rows.length == 1 ){
						if ( rows[0].mend_term != null ){
							$("#mend_term").datebox('setValue',s);
						}else{
							$("#mend_term").datebox('setValue','');
						}
						if ( rows[0].mend_term_enddate != null ){
							$("#mend_term_enddate").datebox('setValue',e);
						}else{
							$("#mend_term_enddate").datebox('setValue','');
						}
						if ( rows[0].examine_creater_code != null ){
							$("#examine_creater_code").combobox("setValue",rows[0].examine_creater_code);
							$("#examine_creater_code").combobox("setText",rows[0].examine_creater_name)
						}
						
					}else {
						var startFlag = true;
						var endFlag = true;
						var examineflag = true;
						for ( var i=1;i< rows.length;i++){
							if (rows[i].mend_term != mend_term ){
								startFlag = false;
							}
							if (rows[i].mend_term_enddate != mend_term_enddate ){
								endFlag = false;
							}
							if (rows[i].examine_creater_code != examine_creater_code ){
								examineflag = false;
							}
						}
						
						if (startFlag && s){
							$("#mend_term").datebox('setValue',s);
						}else{
							$("#mend_term").datebox('setValue','');
						}
						if (endFlag && e){
							$("#mend_term_enddate").datebox('setValue',e);
						}else{
							$("#mend_term_enddate").datebox('setValue','');
						}
						if (examineflag && rows[0].examine_creater_code){
							$("#examine_creater_code").combobox("setValue",rows[0].examine_creater_code);
							$("#examine_creater_code").combobox("setText",rows[0].examine_creater_name)
						}
						
						
					}
					
					
				}
			}
			
			
			function saveExamine(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if ( rows.length < 1){
					showMessage1("请选择一条记录!");
					return false;
				}
				var ids = "";
				for(var i=0;i<rows.length;i++){
					ids+=rows[i].id+",";
				}
				var mend_term = $('#mend_term').datebox('getValue');
				if ( mend_term == null || mend_term == ""){
					//showMessage1("整改期限开始不能为空!");
					//return false;
				}
				var mend_term_enddate = $('#mend_term_enddate').datebox('getValue');
                if ( mend_term_enddate == null || mend_term_enddate == ""){
                	//showMessage1("整改期限结束不能为空!");
                	//return false;
				}
                if (!validateDate("mend_term","mend_term_enddate")){
                	return false;
                }
                if (!validateDateYear(mend_term,mend_term_enddate,'${psObject.pro_year}')){
                	 return false;
                }
                
                var examine_creater_code = $('#examine_creater_code').combobox('getValue');
                if ( examine_creater_code == null || examine_creater_code == ""){
                	//showMessage1("监督检查人 不能为空!");
                	//return false;
                }
                var examine_creater_name = $('#examine_creater_code').combobox('getText');
				$.ajax({
					url:'${contextPath}/proledger/problem/saveRectificConfigInfoDecide.action',
					type:'post',
					async:false,
					data:{'ids':ids,'mend_term':mend_term,'mend_term_enddate':mend_term_enddate,'examine_creater_code':examine_creater_code,'examine_creater_name':examine_creater_name},
					success:function(data){
						if( data == "1"){
							showMessage1("保存成功!");
							//clearExamine();
							$("#examineId").dialog("close");
							$("#operate-opr_ledger_list_mid").datagrid("reload");
						}
					}
					
				})
			}
			
			/* 清空 */
			function clearExamine(){
				//resetForm("examineForm");
				$("#mend_term").datebox('setValue','');
                $("#mend_term_enddate").datebox('setValue','');
                $("#examine_creater_code").combobox("setValue",'');
				$("#examine_creater_code").combobox("setText",'')
			}
			/*
				校验两个日期大小顺序
			*/
			function validateDate(beginDateId,endDateId){
				var s1 = $('#'+beginDateId);
				var e1 = $('#'+endDateId);
				if(s1 && e1){
					var s = s1.datebox('getValue');
					var e = e1.datebox('getValue');
					if(s!='' && e!=''){
						var s_date=new Date(s.replace("-","/"));
						var e_date=new Date(e.replace("-","/"));
						if(s_date.getTime()>e_date.getTime()){
							$.messager.alert("错误","整改期限开始必须小于等于结束!");
							return false;
						}
					}
				}
				return true;
			}
			
			/*
			    校验两个日期和项目年度比较
		       */
			function validateDateYear(startDate,endDate,year){
				var start= new Array(); 
				start=startDate.split("-");
				var end= new Array(); 
            	end=endDate.split("-");
            	if(start[0] !=null && start[0]!=''){
            		if(start[0] < year){ 
            			showMessage1("整改期限开始必须大于项目所属年度["+year+"]！"); 
            			return false;
            		}
            		
            	}
            	if ( end[0] !=null && end[0]!='' ){
            		if(end[0] < year){
            			showMessage1("整改期限结束必须大于项目所属年度["+year+"]！");
            			return false;
            		}
            	}
            	return true;
			}
			//查看审计问题
			function viewLedgerOwner(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if(rows.length == 1){
					$.ajax({
						   type: "POST",
						   url: "/ais/proledger/problem/checkInspection.action",
						   data: {"id":rows[0].id},
						   success: function(data){
							   if(data.type == 'ok'){
								   var viewSjwtUrl  = "${contextPath}/proledger/problem/viewDecideLedgerProblem.action?id="+rows[0].id +"&interaction=${interaction}";
								   aud$openNewTab('定稿问题-查看',viewSjwtUrl,true);
							   }else{
								   showMessage1("没有设置共享权限!");
							   }
						   }
	            	});	
				}else{
					$.messager.alert("提示信息","请选择一条数据进行操作！","info");
				}
			}
			
		 	function load() {
				$('#download').linkbutton('disable');
				var project_id = "${project_id}"
				if ("${sourceSite}" == "historyedit"){
					window.location.href = "${contextPath}/templatedownload?file=decide_ledger_template_history.xls&&type=decideLedgerHistory&&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid&&project_id="+project_id;
				}else if ("${sourceSite}" == "syEdit"){
					window.location.href = "${contextPath}/templatedownload?file=decide_ledger_template_sy.xls&&type=decideLedgerSy&&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid&&project_id="+project_id;
				}else{
					if ("${isGroupEnabled}" == "true"){
						window.location.href = "${contextPath}/templatedownload?file=decide_ledger_template_group.xls&&type=decideLedger&&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid&&project_id="+project_id;
					}else{
						window.location.href = "${contextPath}/templatedownload?file=decide_ledger_template.xls&&type=decideLedger&&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid&&project_id="+project_id;

					}
				}
			}
			
			//增加审计问题
			function addLedgerOwner(){
				var addSjwtUrl  = '${contextPath}/proledger/problem/editDigao.action?sourceSite=${sourceSite}&project_id=<%=request.getParameter("project_id")%>&id=0&tableType=1';

				new aud$createTopDialog({
					title:' ',
					width:1200,
					height:700,
					zIndex:9,
					url:addSjwtUrl,
					onClose:function(){
						window.location.reload();
					}
				}).open();
				
		    	/* window.open(addSjwtUrl); */
		    	//aud$openNewTab('定稿问题-增加',addSjwtUrl,true);
			//	window.parent.addTab('tabs','增加入决定问题','tempframe',addSjwtUrl,true);
		    	
			}
			
			//共享设置
			function shareLedgerOwner(){
				var project_id='<%=request.getParameter("project_id")%>';
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if(rows.length == 1){
					$.ajax({
						   type: "POST",
						   url: "/ais/proledger/problem/shareLedgerProblem.action",
						   data: {"id":rows[0].id,"project_id":project_id},
						   success: function(data){
							   if(data.flag == '1'){
								   $('#shareLedgerWin').window('open');
					            	if (rows[0].inspection == "0"){
					            		$("input[name='option']").get(1).checked=true;
					            	}else{
					            		$("input[name='option']").get(0).checked=true;
					            	}
					            	$('#share_id').val(rows[0].id);
							   }else{
								   showMessage1("只有主审有权限操作!");
							   }
						   }
	            	});	
				}else{
					$.messager.alert("提示信息","请选择一条数据进行操作！","info");
				}
			}
			
			//修改审计问题
			function editLedgerOwner(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if(rows.length == 1){
					var editSjwtUrl = '${contextPath}/proledger/problem/editDigao.action?sourceSite=${sourceSite}&project_id=<%=request.getParameter("project_id")%>&tableType=1&id='+rows[0].id;
					/* window.open(editSjwtUrl); */
					aud$openNewTab('定稿问题-修改',editSjwtUrl,true);
					//window.parent.addTab('tabs','修改入决定问题','tempframe',editSjwtUrl,true);
				}else{
					$.messager.alert("提示信息","请选择一条数据进行操作！","info");
				}
			}
			
			function editLedgerOwner(id){
					var editSjwtUrl = '${contextPath}/proledger/problem/editDigao.action?sourceSite=${sourceSite}&project_id=<%=request.getParameter("project_id")%>&tableType=1&id='+id;
					/* window.open(editSjwtUrl); */
					//aud$openNewTab('定稿问题-修改',editSjwtUrl,true);
					//window.parent.addTab('tabs','修改入决定问题','tempframe',editSjwtUrl,true);
					
					new aud$createTopDialog({
						title:' ',
						width:1200,
						height:700,
						zIndex:9,
						url:editSjwtUrl,
						onClose:function(){
							window.location.reload();
						}
					}).open();
				
			}

			//删除审计问题
			function delLedgerOwner(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				var selectIds = "";
				if(rows.length != 0){
					$.messager.confirm("提示信息","确认删除这 "+rows.length+" 条数据吗？",function(r){
						if(r){
							for(var i=0;i<rows.length;i++){
								var id = rows[i].proLedgerProblem_id;
								selectIds = selectIds + id +',';
							}
							$.ajax({
			                    type: "POST",
			                    dataType:'json',
			                    url : "/ais/proledger/problem/delLedgerProblem.action",
			                    data:{ "ids":selectIds},
			                    success: function(data){
			                        if(data.type == 'ok'){
			                        	showMessage2('删除成功','提示信息',5000,'slide');
			                        	g1.datagrid('reload');
			                        	g1.datagrid('uncheckAll');
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
			
			function submit_dr(){
				var template = document.all('template').value;
				if(template == ''){
					$.messager.alert('系统提示',"请先选择要导入的文件",'warning');			
					return;
				}
				jQuery("#importForm").submit();		
			}
			
			function wait() {
			//	$('#importProjects').window('close');		
				document.getElementById("importButton").disabled = true;
				document.getElementById("layer").style.display = "";
				document.getElementById("errorInfo1").style.display = "none";
				document.getElementById("errorInfo2").style.display = "none";		
		 	}  
			
			function inLedgerOwner(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if(rows.length != 0){
					var selectIds = [];
					var name = "";
					for(var i=0;i<rows.length;i++){
			        	selectIds.push(rows[i].id);
			        	name = rows[i].sfcnsjyj;
					}
					$('#inReport').window('open');
					if ( name != null && name != ""){
						 $('#sfcnsjyj').combobox('setValue',name);
						 $('#sfcnsjyj').combobox('setText',name);
					}

					$('#inReport_id').val(selectIds.join(','));
				}else{
					top.$.messager.show({
	            		title:"提示信息",
	            		msg:"请选择一条数据进行操作！",
	            		timeout:5000,
	            		showType:'slide'
	            	});
				}
			}
			$('#saveId1').bind('click',function(){
				var sfcnsjyj = $('#sfcnsjyj').combobox('getValue');
				var inReport_id = $('#inReport_id').val(); 

				$.ajax({
					type: "POST",
					dataType:'json',
					url : "${contextPath}/proledger/problem/saveSfcnsjyj.action",
					data:{
						'middleLedgerProblem.sfcnsjyj':sfcnsjyj,
						'str':inReport_id
					},
					success: function(data){
						if(data.type == 'ok'){
							$('#inReport').window('close');
							showMessage2("保存成功！");
							window.location.reload();
						}else{
							showMessage2("保存失败！");
						}
					},
					error:function(data){
						showMessage2("请求失败！");
					}
				});
			});
			$('#closeInReport').bind('click',function(){
				$('#inReport').window('close');
			});
			function expLedgerOwner(){
				window.open("${contextPath}/proledger/problem/expDecideLedgerProblemList.action?project_id=${project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			}
			// 查看问题
			function toOPenProblemWindow(manuscript_id,problemId){
		      //var viewSjwtUrl  = "${contextPath}/proledger/problem/viewDecideLedgerProblem.action?sourceSite=${sourceSite}&id="+problemId +"&interaction=${interaction}";
                var viewSjwtUrl  = "${contextPath}/proledger/problem/viewMiddle.action?id=" + problemId;
                aud$openNewTab('定稿问题查看',viewSjwtUrl,true);
			}
			
			/* 历史整改问题新增 */
			function addLedgerOwnerHistory(){
				var addSjwtUrl  = '${contextPath}/proledger/problem/editDigao.action?sourceSite=${sourceSite}&project_id=<%=request.getParameter("project_id")%>&id=0&tableType=1';
				new aud$createTopDialog({
					title:'定稿问题-增加',
					width:1200,
					height:800,
					zIndex:9,
					url:addSjwtUrl,
					onClose:function(){
						window.location.reload();
					}
				}).open();
			}
			
			/* 历史整改问题修改 */
			function editLedgerOwnerHistory(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if(rows.length == 1){
					var editSjwtUrl = '${contextPath}/proledger/problem/editDigao.action?sourceSite=${sourceSite}&project_id=<%=request.getParameter("project_id")%>&tableType=1&id='+rows[0].id;
					aud$openNewTab('定稿问题-修改',editSjwtUrl,true);
				}else{
					$.messager.alert("提示信息","请选择一条数据进行操作！","info");
				}
			}
			

		</script>
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp"></jsp:include>
	</body>
</html>