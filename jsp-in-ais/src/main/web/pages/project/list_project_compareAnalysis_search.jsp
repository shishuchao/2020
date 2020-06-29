<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
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

<body style='padding:0px;margin:0px;overflow:hidden;'  border='0' fit='true' class='easyui-layout'>

	<div region='north'  style='padding:0px;margin:0px;height:150px;overflow:hidden;' >
		<div id="search" style="margin-top:20px;width:100%">
			<s:form id="myform" name="myform" action="controlCompareAnalysisSearch" namespace="/project" method="post">
			  <div style="width:100%; margin-top:20px">
				<table  cellpadding=0 cellspacing=0  border=0 style="width:100%;border-collapse:separate; border-spacing:0px 7px;">
				<tr>
				  <td style="width:7%" align="right"><span style=" font-weight:bold;">统计范围</span></td>
					<td style="width:9%" align="right"><span style="color:red">*</span>项目年度 &nbsp;&nbsp;&nbsp;</td>
					<td  style="width:16%">
						<select multiple="multiple" id="pro_year1" class="easyui-combobox" name="pro_year" style="width:70%"  editable="false">
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
					       		 <option value="<s:property value='key'/>"><s:property value='value'/></option>			       		
					       </s:iterator>
					       <input type="hidden" id="pro_year" name="pso.pro_year"/>
					    </select>
					</td>
					
					<td style="width:7%" align="right">项目类别 &nbsp;&nbsp;&nbsp;</td>
					<td style="width:16%">
							   <select multiple="multiple" id="pro_type_name1" class="easyui-combobox" data-options="panelHeight:'auto'" name="pro_type_name"  style="width:70%"  editable="false">
						       <option value="">请选择</option>
						       <s:iterator value="basicUtil.PlanProjectTypeMap4ZhongjianContainZX.keySet()" id="entry">
						         <option value="<s:property value="name"/>"><s:property value="name"/></option>
						       </s:iterator>
						   <input type="hidden" id="pro_type_name" name="pso.pro_type_name""> 
						    </select>
						</td> 																														
				
					
					<td style="width:7%" align="right">审计单位 &nbsp;&nbsp;&nbsp;</td>
					<td style="width:16%">
						<s:buttonText2 cssClass="noborder" id="audit_dept_name"
									   name="audit_dept_name"
									   cssStyle="width:70%"
									   hiddenName="audit_dept"
									   hiddenId="audit_dept"
									   doubleOnclick="showSysTree(this,{
							  url:'${pageContext.request.contextPath}/systemnew/orgListByCurrentAndLowerLevel.action',
							  title:'组织机构选择',
							  checkbox:true
							})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
					</td>
					<td style="width: 30%;"></td>
				</tr>
				<tr>
					<td></td>
					<td style="width:7%" align="right">被审计单位 &nbsp;</td>
					<td style="width:16%">

						<s:buttonText2 cssClass="noborder" id="audit_object" hiddenId="audit_object_hidden"
									   cssStyle="width:70%"
									   name="audit_object_name"
									   hiddenName="audit_object_name_hidden"
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
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td>
						<div class="refresh-btn" onclick="doSearch()" >查询</div>
					</td>
				</tr>
				
				 <tr>
					 <td style="width:7%" align="right"><span style=" font-weight:bold;">统计维度</span></td>
					 <td colspan="5">
						 <div style="margin-left:3%; width:50%;float:left;">
                                    <input type="radio" name= "xmqsfx" class="radioBox" value="按项目类别"  checked="checked"
                                     id="axmlb" onclick="changeSelectType()"/> 
                                    <label class="radioText" for="axmlb">按项目类别</label>   
                                   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    <input type="radio" name= "xmqsfx" class="radioBox" value="按计划类别"  
                                     id="ajhlb" onclick="changeSelectType()"/> 
                                    <label class="radioText" for="ajhlb">按计划类别</label>
						 </div>
                       </td>
                 </tr>

			</table>
		   </div>
			
	       </s:form>
          </div>
  </div>
  
  <!--图表显示-->
       <!--  <div style="float:left; height:80%; width:100%" title="审计项目对比分析折线图"> -->
          
          <!--折线图-->
          <div id="projectCompareChart" region='center' style="padding:0px;margin:0px;overflow:hidden;" title="项目趋势分析" >

			  <iframe  width="100%" height="100%" scrolling="auto" src="" id="iframe2" frameborder="0"></iframe>

          </div>
        
       <!--  </div>  -->      
<!-- </div> -->
	    
  

 <script type="text/javascript">
	 $(function(){
	 	var search = '${search}';
	 	if(search !=null && search != '') {
			var searchUrl = "${contextPath}/pages/project/project_compareAnalysis_chart.jsp?selectType="+encodeURI("${selectType}")+"&pro_year=${pro_year}&audit_dept_name="+encodeURI("${audit_dept_name}")+"&audit_object_name="+encodeURI("${audit_object_name}")+"&pro_type_name="+encodeURI("${pro_type_name}");
			$('#iframe2').attr('src', searchUrl);
	 	} else {
			var defaultUrl = "${contextPath}/pages/project/project_compareAnalysis_chart_default.jsp?pro_year=${pro_year}&pro_type_name="+encodeURI("${pro_type_name_default}");
			$('#iframe2').attr('src', defaultUrl);
		}

	 });
	 var proYear = '${pro_year}';
	 if(proYear!=''){
		 var defaultValues = proYear.split(',');
		 $('#pro_year1 option').each(function(i,v){
			 if($.inArray(v.value,defaultValues) >= 0){
				 this.selected=true;
			 }
		 });
		 $('#pro_year').attr('name','pso.pro_year').val(proYear);
	 }
	 $("#pro_year1").multiSelect({
		 selectAll: true,
		 oneOrMoreSelected: '*',
		 selectAllText: '全选',
		 noneSelected: '',
		 listWidth:'200',
		 listHeight:'80'
	 }, function(){   //回调函数
		 $('#pro_year').attr('name','pso.pro_year').val($("#pro_year1").selectedValuesString());
	 });

   $("#pro_type_name1").multiSelect({ 
		selectAll: true,
		oneOrMoreSelected: '*',
		selectAllText: '全选',
	 	noneSelected: '',
		listWidth:'200',
	   listHeight:'80'
	}, function(){   //回调函数
		$('#pro_type_name').attr('name','pso.pro_type_name').val($("#pro_type_name1").selectedValuesString());
	});

 
  function doSearch(){   
	    var planYear = document.getElementById("pro_year").value;
	    var auditDeptName = document.getElementById("audit_dept_name").value;
	    var auditObjectName = document.getElementById("audit_object").value;
	    var proTypeName = document.getElementById("pro_type_name").value;

	    if(planYear == "" || planYear == null){
	    	//alert("请选择计划年度！");
			showMessage1("请选择项目年度");
            return false;
	    }
	  
	    else{
	    	var selectType = $("input[name='xmqsfx']:checked").val();
	    	var searchUrl = "${contextPath}/pages/project/project_compareAnalysis_chart.jsp?selectType="+encodeURI(selectType)+"&pro_year="+planYear+"&audit_dept_name="+encodeURI(auditDeptName)+"&audit_object_name="+encodeURI(auditObjectName)+"&pro_type_name="+encodeURI(proTypeName);
			$('#iframe2').attr('src', searchUrl);
// 	    	document.forms[0].action="/ais/project/controlCompareAnalysisSearch.action?selectType="+encodeURI(selectType);
// 	    	document.forms[0].submit();
	    }	
   }
  
  function changeSelectType(){
	  	var planYear = document.getElementById("pro_year").value;
	    var auditDeptName = document.getElementById("audit_dept_name").value;
	    var auditObjectName = document.getElementById("audit_object").value;
	    var proTypeName = document.getElementById("pro_type_name").value;
	  
	    var selectType = $("input[name='xmqsfx']:checked").val();  //获取选中的单选按钮的value值
	    var planYear = document.getElementById("pro_year").value;
	    if(planYear == "" || planYear == null){
	    	//alert("请选择计划年度！");
	    	showMessage1("请选择项目年度");
	    } else{
	    	var searchUrl = "${contextPath}/pages/project/project_compareAnalysis_chart.jsp?selectType="+encodeURI(selectType)+"&pro_year="+planYear+"&audit_dept_name="+encodeURI(auditDeptName)+"&audit_object_name="+encodeURI(auditObjectName)+"&pro_type_name="+encodeURI(proTypeName);
			$('#iframe2').attr('src', searchUrl);
// 	    	document.forms[0].action="/ais/project/controlCompareAnalysisSearch.action?selectType="+selectType;
// 	    	document.forms[0].submit();
	    }
  }  
  </script>


  </body>
</html>
