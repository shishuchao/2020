<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="org.aspectj.weaver.patterns.TypePatternQuestions.Question"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<title>问题趋势分析</title>
	<meta http-equiv="content-type" content="text/html";charset="utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
   	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="renderer" content="webkit">
   	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
   	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${contextPath}/Leadershipinquiry/css/main.css" media="all">
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
</head>
<body style='margin:0;padding: 0;overflow:hidden;'  border='0' fit='true' class="easyui-layout">
	<div region='north'  style='padding:0px;margin:0px;height:150px;overflow:hidden;' >
		<div id="search" style="margin-top:20px;width:100%">
			<s:form id="myform" name="myform" action="problemTrendAnalyseCharts" namespace="/proledger/problem" method="post">
				<input type="hidden" id="from" name="from" value="search" />
				<table  cellpadding=0 cellspacing=0  border=0 style="width:100%;border-collapse:separate; border-spacing:0px 7px;">
					<tr>
						<td style="width:7.5%" align="right"><span style=" font-weight:bold;">统计范围</span></td>
						<td align="right" style="width:7.5%"><span style="color:red">*</span>项目年度&nbsp;&nbsp;</td>
						<td style="width:16%">
							<select multiple="multiple" id="pro_year1"  name="pro_year1" style="width:70%" >
								<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
									<option checked="checked" value="<s:property value='key'/>"><s:property value='value'/></option>			       		
								</s:iterator>
								<input type="hidden" id="pro_year" name="pro_year"/>
						    </select>
						</td>
						<td align="right" style="width:7.5%">项目类别&nbsp;&nbsp;</td>
						<td style="width:16%">
							<select multiple="multiple" id="pro_type1" class="easyui-combobox" name="pro_type1" style="width:70%"  editable="false">
								<option value="">请选择</option>
								<s:iterator value="basicUtil.PlanProjectTypeMap4ZhongjianContainZX.keySet()" id="entry">
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
								<input type="hidden" id="pro_type" name="pro_type">
						    </select>
						</td>
						<td align="right" style="width:7.5%">整改状态&nbsp;&nbsp;</td>
						<td style="width:16%">
							<select multiple="multiple" id="mend_state1" class="easyui-combobox" name="mend_state1" style="width:70%"  editable="false">
						        <s:iterator value="basicUtil.fllowOpinionList" id="entry">				      
						       		<option value="<s:property value='code'/>"><s:property value='name'/></option>			       		
						       </s:iterator>
						       <input type="hidden" id="mend_state" name="mend_state"/>
						    </select>
						</td>
						<td align="right" style="width:30%"></td>
					</tr>
					<tr>
						<td align="right"></td>
						<td align="right" style="width:7.5%"><span style="color:red">*</span>审计单位&nbsp;&nbsp;</td>
						<td style="width:16%">
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
						<td align="right" style="width:7.5%">被审计单位&nbsp;&nbsp;</td>
						<td style="width:16%">					
							<s:buttonText2 cssClass="noborder" id="audit_object_name" hiddenId="audit_object"
								name="audit_object_name" 
								cssStyle="width:70%"
								hiddenName="audit_object"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								  param:{'departmentId':'${magOrganization.fid}'},
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
						<td align="right" style="width:7.5%">问题一级分类&nbsp;&nbsp;</td>
						<td style="width:16%">
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

							<div class="refresh-btn" onclick="doSearch()" >查询</div>
						</td>
					</tr>
					<tr>
						<td style="width:7.5%" align="right"><span style=" font-weight:bold;">统计维度</span></td>
						<td  colspan="5">
							<div style="margin-left:3%; width:70%;float:left;">
							<input onclick="changeRadioType('1')" type="radio" name="ayalyseType" class="radioBox" checked="checked" value="1" id="absjdw3"/>
							<label class="radioText" for="absjdw3">项目类别</label>
							<input onclick="changeRadioType('2')" type="radio" name="ayalyseType" class="radioBox" value="2" id="awtxz3"/>
							<label class="radioText" for="awtxz3">问题类别</label>
						</td>
					</tr>
				</table>
			</s:form>
		</div>
	</div>
    
    <div region='center' id="problemTrendChart"  style='padding:0px;margin:0px;overflow:hidden;' title='问题趋势分析'>
			<iframe id="myIframe" width="100%" height="100%" scrolling="auto" src="${contextPath}/pages/ledger/problem/problemTrendAnalyseCharts.jsp" frameborder="0"></iframe>
    </div>
    
	<script type="text/javascript">
		var from='';
		var projectYear='';
		var auditDept='';
		var auditObject='';
		var projectType='';
		var problemType='';
		var reformStatus='';
		var ayalyseType='';
		
		$(function(){
			var proYear = '${projectYear}';
			if(proYear!=''){
				var defaultValues = proYear.split(',');
				$('#pro_year1 option').each(function(i,v){
					if($.inArray(v.value,defaultValues) >= 0){
						this.selected=true;
					}
				});

			}
			$("#pro_year1").multiSelect({
				selectAll: true,
				oneOrMoreSelected: '*',
				selectAllText: '全选',
				noneSelected: '',
				listWidth:'200',
				listHeight:'90'
			}, function(){
				/* if($('#pro_year').val() == $("#pro_year1").selectedValuesString()){
                    $("#pro_year1").attr("value","");
                }
                //回调函数
                $('#pro_year').attr('name','pro_year').val($("#pro_year1").selectedValuesString()); */
			});

		});

		$("#pro_type1").multiSelect({
			selectAll: true,
			oneOrMoreSelected: '*',
			selectAllText: '全选',
			noneSelected: '',
			listWidth:'200',
			listHeight:'90'
		}, function(){   //回调函数
			//$('#pro_type').attr('name','pro_type').val($("#pro_type1").selectedValuesString());
		});

		$("#mend_state1").multiSelect({
			selectAll: true,
			oneOrMoreSelected: '*',
			selectAllText: '全选',
			noneSelected: '',
			listWidth:'200',
			listHeight:'90'
		}, function(){   //回调函数
			//$('#mend_state').attr('name','mend_state').val($("#mend_state1").selectedValuesString());
		});

		function doSearch(){
			from = 'serach';
			projectYear = $('#pro_year1').selectedValuesString();
			auditDept = $('#audit_dept').val();
			auditObject = $('#audit_object').val();
			projectType = $('#pro_type1').selectedValuesString();
			problemType = $('#sort_big_code').val();
			reformStatus = $('#mend_state1').selectedValuesString();
			if($('#absjdw3')[0].checked){
				ayalyseType = '1';
			}else if($('#awtxz3')[0].checked){
				ayalyseType = '2';
			}
			
			//必输检查
			if(projectYear==''){
				showMessage1('请选择项目年度');
				return false;
			}
			if(auditDept==''){
				showMessage1('请选择审计单位');
				return false;
			}
			
			$('#myIframe').attr('src','${contextPath}/pages/ledger/problem/problemTrendAnalyseCharts.jsp?ayalyseType='+ayalyseType+'&from='+from+
					'&contextPath=${contextPath}&projectYear='+projectYear+'&auditDept='+auditDept+'&auditObject='+auditObject+'&projectType='+
					projectType+'&problemType='+problemType+'&reformStatus='+reformStatus);
		}
		function changeRadioType(aType){
			$('#myIframe').attr('src','${contextPath}/pages/ledger/problem/problemTrendAnalyseCharts.jsp?ayalyseType='+aType+'&from='+from+
					'&contextPath=${contextPath}&projectYear='+projectYear+'&auditDept='+auditDept+'&auditObject='+auditObject+'&projectType='+
					projectType+'&problemType='+problemType+'&reformStatus='+reformStatus);
		}
		function checkIsSortBigCode(code){
			var flag = true;
	        $.ajax({
	            url: '${contextPath}/proledger/problem/checkIsSortBigCode.action?problemcode='+code,
	            dataType: 'json',
	            method: 'post',
	            async: false,
	            success: function (data) {
					if(data.flag == 'one'){
					}else{
						flag = false;
						alert("请选择一级分类！");
					}
	            }
	        });
	        return flag;
		} 
	</script>
</body>
</html>