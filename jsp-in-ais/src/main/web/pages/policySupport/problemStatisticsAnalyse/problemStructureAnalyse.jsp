<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.aspectj.weaver.patterns.TypePatternQuestions.Question"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html"; charset="utf-8">
	<title>审计问题结构分析</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta name="renderer" content="webkit">
	<meta name="force-rendering" content="webkit"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${contextPath}/Leadershipinquiry/css/main.css" media="all">
	<link rel="stylesheet" href="${contextPath}/pages/policySupport/css/statistics.css" media="all">
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>	
	<script type="text/javascript" src="${contextPath}/pages/policySupport/js/problemStructureAnalyse.js"></script>
	
	<script type="text/javascript">
	 	var pro_year="${pro_year}";
		var audit_dept="${audit_dept}";
		var audit_dept_name=encodeURI("${audit_dept_name}");
		var audit_object="${audit_object}";
		var audit_object_name=encodeURI("${audit_object_name}");
		var sort_big_code="${sort_big_code}";
		var sort_big_name=encodeURI("${sort_big_name}");
		var pro_type="${pro_type}";		
		var mend_state=encodeURI("${mend_state}");	
		var type="${type}";	
		                 
	   var defaultUrl = '${contextPath}/pages/policySupport/problemStatisticsAnalyse/problemStructureAnalyseCharts.jsp?';
	   
		$(function(){
			var proYear = '${pro_year}';
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
    <div region='north' class="container-flu2id">
        <div id="search" class="searchquerstion">
            <s:form action="rankingQuestionsSearch" namespace="/archives/workprogram/pigeonhole" method="post">
                <table cellpadding=0 cellspacing=0  border=0 class="searchquestionstable" >
                   <tr>
                      <td align="right" class="editqhead1" ><span style=" font-weight:bold;">统计范围</span></td>
						<td  align="right" class="editqhead1"><span style="color:red">*</span>项目年度&nbsp;&nbsp;&nbsp;</td>
						<td  class="Td">
							<select multiple="multiple" id="project_year" name="project_year" style="width:70%" editable="false">
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
						<select multiple="multiple" id="rectify_state"  name="rectify_state" style="width:70%" editable="false">
					        <s:iterator value="basicUtil.fllowOpinionList" id="entry">				      
					       		 <option value="<s:property value='code'/>"><s:property value='name'/></option>			       		
					       </s:iterator>
					       <input type="hidden" id="mend_state" name="mend_state"/>
					    </select>
						</td>
                   </tr>
                   <tr>
                       <td ></td>
						<td align="right" class="editqhead1">审计单位&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">
							<input id="audit_dept_name" style="width:70%" class="noborder" name="audit_dept_name" value="${audit_dept_name}" type="text" readonly/>
							<input id="audit_dept"  name="audit_dept" value="${audit_dept}" type="hidden"/>							
							<img style="cursor: pointer;" onclick="showSysTree(this,{
					    				url:'${pageContext.request.contextPath}/systemnew/orgListByCurrentAndLowerLevel.action',
					    				title:'请选择审计单位',
					    				checkbox:true
									})" src="${contextPath }/easyui/1.4/themes/icons/search.png"></img>
						</td> 	
						<td align="right" class="editqhead2">被审计单位&nbsp;&nbsp;&nbsp;</td>
						<td class="Td">
							<input id="audit_object_name" style="width:70%" class="noborder" name="audit_object_name" value="${audit_object_name}" type="text" readonly/>
							<input id="audit_object"  name="audit_object" value="${audit_object}" type="hidden"/>							
							<img style="cursor: pointer;" onclick="showSysTree(this,{
					    				url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
					    				title:'请选择被审计单位',
					    				checkbox:true
									})" src="${contextPath}/easyui/1.4/themes/icons/search.png"></img>
						</td>
						<td  align="right" class="editqhead2">问题一级分类&nbsp;&nbsp;&nbsp;</td>
						<td  class="Td">
							<input id="sort_big_name" style="width:70%" class="noborder" name="sort_big_name" value="${sort_big_name}" type="text" readonly/>
							<input id="sort_big_code"  name="sort_big_code" value="${sort_big_code}" type="hidden"/>
							<img style="cursor: pointer;" onclick="showSysTree(this,{
					    				url:'/ais/plan/detail/problemTreeViewByAsyn.action',
					    				title:'请选择问题一级分类',
					    				param:{
					    					'oneLevel':1
					    				},
					    				 checkbox:true,
					    				 onBeforeSure:function(curContext, dms, mcs){
					    					 return checkIsSortBigCode(dms);
					    				 }
									})" src="${contextPath}/easyui/1.4/themes/icons/search.png"></img>
						</td>
						<td >
							<div class="refresh-btn" onclick="doSearch()" >查询</div>
						</td>
                   </tr>
                   <tr>
						<td align="right" class="editqhead1"><span style="font-weight:bold;">统计维度</span></td>
						<td colspan="5">
							<div class="searchdimension">	
				               <input type="radio" name="totleDimension" class="radioBox" value="protype" id="protype" checked="checked" onclick="changeRadioType('xmlb')"/>
			                   <label >项目类别</label>
							   &nbsp;&nbsp;&nbsp;
							   <input type="radio" name="totleDimension" class="radioBox" value="sortbig" id="wtyjfl" onclick="changeRadioType('sortbig')"/>
			                   <label >问题一级分类</label>
							   &nbsp;&nbsp;&nbsp;
							   <input type="radio" name="totleDimension" class="radioBox" value="wtd" id="wtd" onclick="changeRadioType('wtd')"/>
			                   <label >问题点</label>
			                   &nbsp;&nbsp;&nbsp;
			                   <input type="radio" name="totleDimension" class="radioBox" value="zgzt" id="zgzt" onclick="changeRadioType('zgzt')"/>
			                   <label >整改状态</label>
			             	</div> 
						</td>
				    </tr>	
                </table> 
            </s:form>
        </div>
    </div>
    <div region='center' title="问题结构分析">
        <iframe id="iframe" width="100%" height=100% scrolling="auto" src="" frameborder="0"></iframe>	
    </div>
    <script>
       $('#iframe').attr('src',defaultUrl+'pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_object='+audit_object+'&pro_type='+pro_type+'&sort_big_code='+sort_big_code+'&mend_state='+mend_state+'&type='+type);  
   </script>
</body>
</html>