<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script language="javascript">

		//单击一行，选择checkbox
		function selchkbox(){
			init();
			var trObj = event.srcElement.parentNode.parentNode;
			if(trObj.tagName=="tr"||trObj.tagName=="Tr"||trObj.tagName=="TR"){
				trObj.style.color="red";
			}
		}

		function init(){
			var obj = document.getElementById("row");
			for(var i=0;i<obj.rows.length;i++){
				obj.rows[i].style.color="#000000";
			}
		}

		function compareDate(DateOne,DateTwo){
			if(DateTwo.length<1||DateOne.length<1) return false;
			var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ("-"));
			var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ("-")+1);
			var OneYear = DateOne.substring(0,DateOne.indexOf ("-"));

			var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ("-"));
			var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ("-")+1);
			var TwoYear = DateTwo.substring(0,DateTwo.indexOf ("-"));

			if (Date.parse(OneMonth+"/"+OneDay+"/"+OneYear) >
			Date.parse(TwoMonth+"/"+TwoDay+"/"+TwoYear)){
				return true;
			}
			else{
				return false;
			}
		}

		</script>
	 	<script type="text/javascript">
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

		/*
		* 查询
		*/
		function doSearch(){
			var fullStartDate1 = $("#fullStartDate1").datebox('getValue');
			var fullEndDate1 = $("#fullEndDate1").datebox('getValue');
			var runningStartDate = $("#runningStartDate1").datebox('getValue');
			var runningEndDate = $("#runningEndDate1").datebox('getValue');
			var freeStartDate1 = $("#freeStartDate1").datebox('getValue');
			var freeEndDate1 = $("#freeEndDate1").datebox('getValue');
			if(compareDate(fullStartDate1 , fullEndDate1)){
					showMessage1('排程开始时间应在结束时间之前！')
					return false;
			}
			if(compareDate(runningStartDate , runningEndDate)){
				showMessage1('在审开始时间应在结束时间之前！')
				return false;
			}
			if(compareDate(freeStartDate1 , freeEndDate1)){
					showMessage1('人员空闲开始时间应在结束时间之前！')
					return false;
			}
	      	$('#list').datagrid({
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
		function searchrecal(){
			resetForm('searchForm');
		}
		function openTool(tl,url){
			var w = $('body').width()*0.8;
			var h = $('body').height()*0.8;
			if(w < 600){
				w = 600;
			}
			if(h<500){
				h = 500;
			}
			$('#toolUrl').window({
			   onOpen:function(){
			   	//common-data-dataframe-main-owner
			   	//window.setTimeout(function(){ alert($(taskIframeId).find('#common-data-dataframe-main-owner').length)},500);
			   },
		       title:tl,
		       modal:true,
		       minimizable:false,
		       maximizable:true,
		       collapsible:false,
		       closable:true,
		       width:w,
		       height:h,
		       content : '<iframe id=taskIframeId name=taskIframeId src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
		    });

		}

		function viewDesc(project_id_value,loginname_value){
				$("#tId").empty();
				$.post("/ais/operate/taskExt/getTaskList.action",{project_id:project_id_value,userId:loginname_value},function(returnValue2) {
						var jsonstr = eval( "(" + returnValue2 + ")" )
						var buffer = "<tr class='listtablehead' class='flag'><td class='ListTableTr11' style='text-align:center'>审计事项</td><td class='ListTableTr11' style='text-align:center'>审计小组</td></tr>";
						if(null!=jsonstr && jsonstr.length>0){
							for(var i=0;i<jsonstr.length;i++){
								buffer = buffer +"<tr class='listtablehead' class='flag'><td class='ListTableTr22' style='text-align:center'>"+jsonstr[i].taskName+"</td><td class='ListTableTr22' style='text-align:center'>"+jsonstr[i].taskGroupAssignName+"</td></tr>";
							}
						}
						$("#tId").append(buffer);
						$('#sjsx').window('open');
					});
		}

		function lookAtDetail(employee_id) {
			var fullStartDate1 = $("#fullStartDate1").datebox('getValue');
			var fullEndDate1 = $("#fullEndDate1").datebox('getValue');
			var runningStartDate1 = $("#runningStartDate1").datebox('getValue');
			var runningEndDate1 = $("#runningEndDate1").datebox('getValue');
			var freeStartDate1 = $("#freeStartDate1").datebox('getValue');
			var freeEndDate1 = $("#freeEndDate1").datebox('getValue');

			var url = '<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/lookAtDetail.action?' +
					'employeeInfo.id=' + employee_id +
					'&helper.freeStartDate=' + freeStartDate1 +
					'&helper.freeEndDate=' + freeEndDate1 +
					'&helper.fullStartDate=' + fullStartDate1 +
					'&helper.fullEndDate=' + fullEndDate1 +
					'&helper.runningStartDate=' + runningStartDate1 +
					'&helper.runningEndDate=' + runningEndDate1;
			aud$openNewTab('审计人员状态详情', url, true);
		}
		$(function(){
		    $('#sjsx').window({
				width:600,
				height:300,
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
		    });
		});
 	</script>
</head>
<%String isbiz=request.getParameter("isbiz");
	if("".equals(isbiz)||isbiz==null){
		isbiz="";
	}
 %>
<body  class="easyui-layout" style="margin: 0;padding: 0;overflow:hidden;" >
	<div id="dlgSearch" class="searchWindow" title="查询条件">
		<div>
			<!-- 查询FORM -->
			<s:form action="toEmployeeManageMain" id="searchForm" name="searchForm" namespace="/mng/examproject/members/audProjectMembersInfo">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					
					<TR>
						<td  class="EditHead" style="width:15%">
							姓名
						</td>
						<td  class="editTd" style="width:35%"  >
							<s:textfield cssClass="noborder" cssStyle="width:172px;" id="name" name="employeeInfo.name" />
						</td>
						<td nowrap class="EditHead" style="width:15%">
							职务级别
						</td>
						<td nowrap class="editTd" style="width:35%">
							<!--<s:select cssClass="easyui-combobox" cssStyle="width:172px;" name="employeeInfo.dutyCode" headerKey=""
								headerValue="" list="basicUtil.dutyList4Search" listKey="code"
								listValue="name" />-->
							<select editable="false" class="easyui-combobox" name="employeeInfo.dutyCode" style="width:150px;" >
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.dutyList4Search" id="entry">
						         <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       </s:iterator>
					    </select> 	
						</td>
					</TR>
					<tr>	
						<td nowrap class="EditHead">
							所属单位
						</td>
						<td nowrap  class="editTd" style="width:85%">
							<s:buttonText cssClass="noborder"  name="employeeInfo.company"
								hiddenName="employeeInfo.companyCode"
								cssStyle="width:41%"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								   // json格式，url使用的参数
								   param:{
										'p_item':3,

								},
								  title:'请选择所属单位',
								  // 单击确定按钮后执行清空被审计单位（根据实际业务逻辑编写相关代码）
								  onAfterSure:function(){
								    $('#companyCode').val('');
								    $('#company').val('');
								  }
								})"
								doubleSrc="/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false"  />
	
						</td>
						<td class="EditHead">
							主审次数
						</td>
						<td class="editTd">
							<input style="width:55px" class="noborder" name="helper.startTime"> - <input style="width:55px" class="noborder" name="helper.endTime">
						</td>
					</tr>
					<TR>
						<td nowrap class="EditHead" style="width:15%">
							人才类型
						</td>
						<td class="editTd" style="width:35%;">
							<select multiple="multiple" id="typeCode1" editable="false">
								<c:forEach items="${basicUtil.typeList}" var="s">
									<option value='${s.code }'>${s.name }</option>
								</c:forEach>
				  			</select>
							<input type="hidden" id="typeCode" name="employeeInfo.typeCode" />
						</td>
						<td nowrap class="EditHead" style="width:15%">
							专业领域
						</td>
						<TD class="editTd" style="width:35%;">
							<select multiple="multiple" id="strongPointCode1" editable="false">
								<c:forEach items="${basicUtil.specialityList}" var="s">
									<option value='${s.code }'>${s.name }</option>
								</c:forEach>
				  			</select>
							<input type="hidden" id="strongPointCode" name="employeeInfo.strongPointCode" />
						</TD>
					</TR>
					<tr>	
						<td nowrap class="EditHead" style="width:15%">
							排程区间
						</td>
						<td nowrap class="editTd" colspan="3" style="width:85%">
						<input type="text"  editable="false" class="easyui-datebox noborder" name="helper.fullStartDate" id="fullStartDate1" title="单击选择日期" />
						-
						<input type="text" editable="false"  class="easyui-datebox noborder" name="helper.fullEndDate" id="fullEndDate1" title="单击选择日期" /><span style="color:darkgray;">&nbsp;&nbsp;(起止时间)</span>
						
						</td>
						<td>
							<s:hidden name="advSearchValue" />
							<s:hidden name="status" />
						</td>
					</tr>
					<tr>	
						<td nowrap class="EditHead" style="width:15%">
							在审区间
						</td>
						<td nowrap class="editTd" colspan="3" style="width:85%">
							
							<input type="text"  editable="false" class="easyui-datebox noborder" name="helper.runningStartDate"   id="runningStartDate1" title="单击选择日期"/>
							-
							<input type="text" editable="false"  class="easyui-datebox noborder" name="helper.runningEndDate" id="runningEndDate1" title="单击选择日期" /><span style="color:darkgray;">&nbsp;&nbsp;(起止时间)</span>
						</td>
					</tr>
					<tr>	
						<td nowrap class="EditHead" style="width:15%">
							人员空闲区间
						</td>
						<td nowrap class="editTd" colspan="3" style="width:85%">
							
							<input type="text"  editable="false" class="easyui-datebox noborder" name="helper.freeStartDate"   id="freeStartDate1" title="单击选择日期"/>
							-
							<input type="text" editable="false"  class="easyui-datebox noborder" name="helper.freeEndDate" id="freeEndDate1" title="单击选择日期" /><span style="color:darkgray;">&nbsp;&nbsp;(起止时间)</span>
						</td>
					</tr>
				</TABLE>
			
			</s:form>
		</div>
		<br>
		<div style="float: right">
	         <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="javascript:searchrecal();">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>&nbsp;
			 </div>
		 </div>	
	</div>
		<div region="center"  >
			<table id="list"></table>
			<!-- <iframe name="f_tops" id="f_tops" width="100%" height="400px" frameborder="0" src="<%//=request.getContextPath()%>/pages/mng/examproject/members/main.jsp"></iframe> -->
<%--			<iframe name="f_bottom" width="100%" height="49%" frameborder="0" src="<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/lookAtDetail.action" ></iframe>--%>
		</div>
		<s:hidden name="userCode"/> 
		<s:hidden name="project_id"/> 
		<s:hidden name="formId"/> 
	
		<script language="javascript">
		$(function(){
			var bodyW = $('body').width();
			var enableKpi = <%=request.getAttribute("enableKpi")%>;
			showWin('dlgSearch');
			$('#list').datagrid({
				url : '<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/toEmployeeManageMain.action?querySource=grid&ldst=${param.ldst}&tjfw=${param.tjfw}',
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				border:false,
				singleSelect: true,
				remoteSort:true,
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						$('#dlgSearch').show();
						$('#dlgSearch').dialog('open');
					}
				},'-',helpBtn],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				columns:[[
					{field:'name',title:'姓名',width:bodyW*0.06 + 'px',halign:'center',align:'left',sortable:true,
						 formatter:function(value,row,index){
							 if(row.plan_finished > 0) {
								 return '<span style=color:blue; >'+row.employeeInfo.name+'</span>';
							 } else {
								 return '<span>'+row.employeeInfo.name+'</span>'
							 }
						 }
					},
	       			{field:'company',title:'所属单位',width:bodyW*0.15 + 'px',halign:'center',sortable:true,align:'left',
	       				 formatter:function(value,row,index){
							 return row.employeeInfo.company;
						 }
					}, 
					{field:'department',title:'所属部门',width:bodyW*0.15 + 'px',halign:'center',sortable:true,align:'left',
	       				 formatter:function(value,row,index){
							 return row.employeeInfo.department;
						 }
					},
					{field:'duty',
							title:'职务',
							width:bodyW*0.08 + 'px',
							halign:'center',
							align:'left', 
							sortable:true,
							formatter:function(value,row,index){
								return row.employeeInfo.duty;
							}
					},
					{field:'psLevel',
						title:'专业序列等级',
						width:bodyW*0.1 + 'px',
						align:'center', 
						sortable:true,
						formatter:function(value,row,index){
							return row.employeeInfo.psLevelName;
						}
					},
					{field:'row.zhushenNum',
						title:'主审项目数',
						width:bodyW*0.08 + 'px',
						halign:'center',
						sortable:false, 
						align:'center',
						formatter:function(value,row,index){
							return row.zhushenNum;
						}
					},
					{field:'row.plan_wait_running',
						title:'排程计划',
						width:bodyW*0.08 + 'px',
						sortable:false, 
						align:'center',
						formatter:function(value,row,index){
							return row.plan_wait_running;
						}
					},
					{field:'row.plan_finished',
						 title:'已审项目',
						 width:bodyW*0.08 + 'px',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
							 return row.plan_finished;
						 }
					},
					<s:if test="${enableKpi == true}">
					{field:'row.average_score',
						 title:'平均分值',
						 width:bodyW*0.08 + 'px',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
							 return row.average_score;
						 }
					},
					</s:if>
					{field:'paging.banner.placement',
						 title:'操作',
						 width:bodyW*0.06 + 'px',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
							 return '<a href="javascript:" onclick="lookAtDetail(\'' + row.employeeInfo.id + '\')">详情</a>';
						 }
					}
				]]   
			}); 
			
			$("#typeCode1").multiSelect({ 
				selectAll: false,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
				noneSelected: '',
				listWidth:'200'
			}, function(){   //回调函数
				$('#typeCode').attr('name','employeeInfo.typeCode').val($("#typeCode1").selectedValuesString());
			});
			
			
			$("#strongPointCode1").multiSelect({ 
				selectAll: false,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
				noneSelected: '',
				listWidth:'200'
			}, function(){   //回调函数
				$('#strongPointCode').attr('name','employeeInfo.strongPointCode').val($("#strongPointCode1").selectedValuesString());
			});
		});
		</script>
</body>
</html>