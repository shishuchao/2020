<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题整改跟踪列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
			
     <link rel="stylesheet" href="${contextPath}/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
	 <link rel="stylesheet" href="${contextPath}/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
     <script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	 <script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery.easyui.min.js"></script>
	 <script type="text/javascript" src="${contextPath}/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>   
     <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
			
	</head>

	<body>
		<table cellpadding=0 cellspacing=0 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead"
					style="text-align: left; width: 100%;">
					<span style="display: inline; width: 80%;float: left;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/proledger/problem/trackProblemList.action')" />
					</span>
					<span style="float: right;"><a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a></span>
				</td>
			</tr>
		</table>
		<s:form name="myform" action="trackProblemList" namespace="/proledger/problem" method="post">
			<table id="searchTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center"
				style="display: none; table-layout: fixed;">
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						是否关闭
					</td>
					<td align="left" class="listtabletr22">
						<s:select name="middleLedgerProblem.is_closed" list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" listKey="key" listValue="value" emptyOption="true" />
					</td>
					<td align="left" class="listtabletr11">
						项目编号
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="middleLedgerProblem.project_code" maxlength="50"/>
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						审计单位
					</td>
					<td align="left" class="listtabletr22">
						<s:buttonText2 name="middleLedgerProblem.audit_dept_name"
							hiddenName="middleLedgerProblem.audit_dept"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'审计单位',
                                  param:{
                                    'p_item':1,
                                    'orgtype':1
                                  }
								})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td align="left" class="listtabletr11">
						被审计单位
					</td>
					<td align="left" class="listtabletr22">
						<s:buttonText2 name="middleLedgerProblem.audit_object_name"
							hiddenName="middleLedgerProblem.audit_object"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,
							  checkbox:true,
                              height:500,
							  title:'被审计单位树'
							})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11" >
						问题点
					</td>
					<td align="left" class="listtabletr22" colspan="3">
						<s:buttonText id="problem_name" hiddenId="problem_code"
							cssStyle="width:180px;" name="middleLedgerProblem.problem_name"
							hiddenName="middleLedgerProblem.problem_code"
							doubleOnclick="showSysTree(this,{
				    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
				    				onlyLeafCheck:true,
				    				title:'请选择问题点'
								})"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">
							<s:submit value="查询" />
							&nbsp;
							<input type="button" value="重置"
								onclick="cleanForm();" />
						</DIV>
					</td>
				</tr>
			</table>

			<div align="center">
				<display:table id="row" name="list" class="its"
					pagesize="${baseHelper.pageSize}" partialList="true"
					size="${baseHelper.totalRows}" sort="external" defaultsort="2"
					defaultorder="descending"
					requestURI="${contextPath}/proledger/problem/decideProblemList.action">

					<display:column title="选择" media="html" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center">
						<input type="checkbox"  name="crudIds" id="crudIds" value="${row.id}" />
					</display:column>

					<display:column title="是否关闭" headerClass="center" property="is_closed"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="is_closed" />
					<display:column title="项目编号" headerClass="center" style="WHITE-SPACE: nowrap" sortName="project_code" sortable="true" >
						<a href="<s:url action="view" namespace="/project" includeParams="none"></s:url>?viewPermission=full&crudId=${row.project_id}" target="_blank">${row.project_code}</a>
					</display:column>
					<display:column title="审计问题编号" headerClass="center" style="WHITE-SPACE: nowrap" sortName="serial_num" sortable="true" >
						<a href="<s:url action="viewMiddle" namespace="/proledger/problem" includeParams="none"></s:url>?id=${row.id}" target="_blank">${row.serial_num}</a>
					</display:column>
					<display:column title="问题所属期间" headerClass="center"
						style="WHITE-SPACE: nowrap" property="project_code" sortName="project_code"
						sortable="true" />
					<display:column title="问题类别" headerClass="center"
						style="WHITE-SPACE: nowrap" property="sort_big_name" sortName="sort_big_name"
						sortable="true" />
					<display:column title="问题点" headerClass="center"
						style="WHITE-SPACE: nowrap" property="problem_name" sortName="problem_name"
						sortable="true" />

					<%--<display:column title="问题摘要" headerClass="center" property="manuscript.describe" style="text-align: left;" sortable="true" sortName="manuscript.describe"
						media="html" />--%>
						
					<display:column title="发生金额(万元)" property="problem_money" headerClass="center" sortable="true" sortName="problem_money"
						media="html"/>
					<display:column title="发生数量(个)" headerClass="center" class="center" property="problemCount" sortable="true" sortName="problemCount"
						style="WHITE-SPACE: nowrap" />

					<display:column title="被审计单位" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center"
						property="audit_object_name" maxLength="10" sortable="true" sortName="audit_object_name"/>

					<display:column title="审计单位" headerClass="center" property="audit_dept_name"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="audit_dept_name" />
					<display:column title="是否整改" headerClass="center" property="isNotMend"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="isNotMend" />
					<display:column title="整改期限" headerClass="center" property="mend_term_date"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="mend_term_date" />
					<display:column title="整改责任部门" property="zeren_dept" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="zeren_dept" />
					<display:column title="责任单位" headerClass="center" property="zeren_company"
							style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="zeren_company" />
					<display:column title="整改负责人" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center"
						property="zeren_person" maxLength="10" sortable="true" sortName="zeren_person"/>
					<display:column title="整改方式" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center"
						property="mend_method" maxLength="10" sortable="true" sortName="mend_method"/>
					<display:column title="检查方式" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center"
						property="examine_method" maxLength="10" sortable="true" sortName="examine_method"/>
					<display:column title="跟踪人" headerClass="center" style="WHITE-SPACE: nowrap" class="center"
						property="tracker_name" maxLength="10" sortable="true" sortName="tracker_name"/>
					<display:column title="跟踪记录" headerClass="center" style="WHITE-SPACE: nowrap" class="center"
						sortable="true" sortName="track_num" >
						<a href="<s:url action="trackList" namespace="/proledger/problem" includeParams="none"></s:url>?crudIdStrings=${row.id}&onlyView=true" target="_blank">${row.track_num}</a>
					</display:column>
					<display:setProperty name="paging.banner.placement" value="bottom" />
				</display:table>

			</div>
			
			<s:if test="list.size!=0">
				<div align="right" style="width: 98%">
					<input type="button" name="Submit" value="全选" onClick="selectAll(listAll)">
					&nbsp;
					<input type="button" name="Submit2" value="反选" onClick="inverse(listAll)">
					&nbsp;
					<input type="button" id="track" name="track" value="跟踪登记" onClick="trackProblem();">
					&nbsp;
					<input type="button" id="close" name="close" value="关闭问题" onClick="closeProblem();">
				</div>
			</s:if>
		</s:form>
		<form name="trackform" action="trackList" namespace="/proledger/problem" method="post" >
			<s:hidden id="crudIdStrings" name="crudIdStrings"/>
		</form>			    	    	    
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
			function trackProblem(){
				if($("input[name='crudIds']:checkbox:checked").length=1){
				      var crudIdStrings = '';
				      $("input[name='crudIds']:checkbox:checked").each(function(){
				      		crudIdStrings = $(this).val();
				      }) 
				      $('#crudIdStrings').val(crudIdStrings);
				}else if($("input[name='crudIds']:checkbox:checked").length>1){
					  alert('只能选择一个审计问题');
				      return false;
				}else{
				      alert('没有选择审计问题');
				      return false;
				}
			}
			
			function closeProblem(){
				if($("input[name='crudIds']:checkbox:checked").length>0){
				      var crudIdStrings = '';
				      $("input[name='crudIds']:checkbox:checked").each(function(){
				      		crudIdStrings += $(this).val()+',';
				      }) 
				      $('#crudIdStrings').val(crudIdStrings);
				}else{
				      alert('没有选择审计问题');
				      return false;
				}
				$.ajax({
						dataType:'json',
						url : "${contextPath}/proledger/problem/closeProblem.action?crudIdStrings="+crudIdStrings,
						type: "POST",
						success: function(data){
							$.messager.alert('提示信息','保存成功！','info');
						},
						error:function(data){
							$.messager.alert('提示信息','请求失败！','error');
						}
				});
			}
			
			function cleanForm(){
				document.getElementsByName("middleLedgerProblem.project_code")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_object")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_object_name")[0].value = "";
				document.getElementsByName("middleLedgerProblem.is_closed")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_dept_name")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_dept")[0].value = "";
				document.getElementsByName("middleLedgerProblem.problem_name")[0].value = "";
				document.getElementsByName("middleLedgerProblem.problem_code")[0].value = "";
			}
		</script>
	</body>
</html>
