<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="org.aspectj.weaver.patterns.TypePatternQuestions.Question"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html";charset="utf-8">
	<title>问题趋势分析</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
   	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="renderer" content="webkit">
   	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
   	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${contextPath}/Leadershipinquiry/css/main.css" media="all">
    <link rel="stylesheet" href="${contextPath}/pages/policySupport/css/statistics.css" media="all">
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	<script type="text/javascript" src="${contextPath}/pages/policySupport/js/problemTrendAnalyse.js"></script>
	
	<script type="text/javascript">
		var from='';
		var projectYear="${pro_year}";
		var auditDept="${audit_dept}";
		var auditObject="${audit_object}";
		var projectType="${pro_type}";
		var problemType='';
		var reformStatus=encodeURI("${mend_state}");
		var ayalyseType='';
		
		var defaultUrl= '${contextPath}/pages/policySupport/problemStatisticsAnalyse/problemTrendAnalyseCharts.jsp?';
		
		$(function(){
			var proYear = '${projectYear}';
			if(proYear!=''){
				var defaultValues = proYear.split(',');
				$('#project_year option').each(function(i,v){
					if($.inArray(v.value,defaultValues) >= 0){
						this.selected=true;
					}
				});

			}
			$("#project_year").multiSelect({
				selectAll: true,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
				noneSelected: '',
				listHeight:'90'
			}, function(){
                //回调函数
                $('#pro_year').attr('name','pro_year').val($("#project_year").selectedValuesString()); 
			});
			
			$("#project_type").multiSelect({ 
				selectAll: true,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
			 	noneSelected: '',
			 	listHeight:'90'
			}, function(){   //回调函数
				$('#pro_type').attr('name','pro_type').val($("#project_type").selectedValuesString());
			} );
			
			$("#rectify_state").multiSelect({ 
				selectAll: true,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
			 	noneSelected: ''
			}, function(){   //回调函数
				$('#mend_state').attr('name','mend_state').val($("#rectify_state").selectedValuesString());
			} );
		});
	</script>
</head>

<body fit='true' class="easyui-layout">
	<div region='north'  class="container-flu2id">
		<div id="search" class="searchquerstion">
			<s:form action="problemTrendAnalyseCharts" namespace="/proledger/problem" method="post">
				<input type="hidden" id="from" name="from" value="search" />
				<table cellpadding=0 cellspacing=0  class="searchquestionstable">
					<tr>
						<td align="right" class="editqhead1"><span style=" font-weight:bold;">统计范围</span></td>
						<td align="right" class="editqhead1"><span style="color:red">*</span>项目年度&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">
							<select multiple="multiple" id="project_year" name="project_year" style="width:70%">
								<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
									<option checked="checked" value="<s:property value='key'/>"><s:property value='value'/></option>			       		
								</s:iterator>
								<input type="hidden" id="pro_year" name="pro_year"/>
						    </select>
						</td>
						<td align="right" class="editqhead1">项目类别&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">
							<select multiple="multiple" id="project_type" name="project_type" style="width:70%" editable="false">
								<s:iterator value="basicUtil.PlanProjectTypeMap4ZhongjianContainZX.keySet()" id="entry">
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
								<input type="hidden" id="pro_type" name="pro_type">
						    </select>						    
						</td>
						<td align="right" class="editqhead1">整改状态&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">
							<select multiple="multiple" id="rectify_state" name="rectify_state" style="width:70%"  editable="false">
						        <s:iterator value="basicUtil.fllowOpinionList" id="entry">				      
						       		<option value="<s:property value='code'/>"><s:property value='name'/></option>			       		
						       </s:iterator>
						       <input type="hidden" id="mend_state" name="mend_state"/>
						    </select>
						</td>
						<td align="right" class="Td2"></td>
					</tr>
					<tr>
						<td align="right"></td>
						<td align="right" class="editqhead1"><span style="color:red">*</span>审计单位&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">
							<s:buttonText2 cssClass="noborder" id="audit_dept_name"
								name="audit_dept_name"
								value="${audit_dept_name}"
								cssStyle="width:70%"
								hiddenName="audit_dept"
								hiddenId="audit_dept"
								hiddenValue="${audit_dept}"
								doubleOnclick="showSysTree(this,{
								url:'${pageContext.request.contextPath}/systemnew/orgListByCurrentAndLowerLevel.action',
								title:'请选择审计单位',
								checkbox:true
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
						</td>
						<td align="right" class="editqhead1">被审计单位&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">					
							<s:buttonText2 cssClass="noborder" id="audit_object_name" hiddenId="audit_object"
								name="audit_object_name" 
								cssStyle="width:70%"
								hiddenName="audit_object"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								  param:{
								    'departmentId':$('#pigeonholeObject.archives_unit').val()
								  },
								  cache:false,
								  checkbox:true,
								  title:'请选择被审计单位'
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								display="${varMap['audit_objectRead']}"
								doubleDisabled="!(varMap['audit_object_buttonWrite']==null?true:varMap['audit_object_buttonWrite'])" />
						</td>
						<td align="right" class="editqhead1">问题一级分类&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">
							<s:buttonText id="sort_big_name" cssStyle="width:70%" hiddenId="sort_big_code" cssClass="noborder" name="sort_big_name"
								hiddenName="sort_big_code" doubleOnclick="showSysTree(this,{
					 				url:'/ais/plan/detail/problemTreeViewByAsyn.action',
					 				title:'请选择问题一级分类',
					 				param:{
					    					'oneLevel':1
					    				},
					 				checkbox:true,
				    				onBeforeSure:function(curContext, dms, mcs){
				    					 return checkIsSortBigCode(dms);
				    				}
								})"
								doubleSrc="/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td >
							<div class="refresh-btn" onclick="doSearch()">查询</div>
						</td>
					</tr>
					<tr>
						<td align="right" class="editqhead1"><span style="font-weight:bold;">统计维度</span></td>
						<td colspan="5">
							<div class="searchdimension">
								<input id="proType" type="radio" name="totleDimension" value="1" checked="checked" onclick="changeRadioType('1')"/>
								<label class="radioText" for="proType">项目类别</label>
								&nbsp;&nbsp;&nbsp;
								<input id="quetype" type="radio" name="totleDimension" value="2" onclick="changeRadioType('2')"/>
								<label class="radioText" for="quetype">问题类别</label>
							</div>	
						</td>
					</tr>
				</table>
			</s:form>
		</div>
	</div>
    
    <div region='center' title='问题趋势分析'>
		<iframe id="myIframe" width="100%" height="100%" scrolling="auto" src="${contextPath}/pages/policySupport/problemStatisticsAnalyse/problemTrendAnalyseCharts.jsp" frameborder="0"></iframe>
    </div>	
</body>
</html>