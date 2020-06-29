<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		
		<%-- <script type="text/javascript" src="/ais/easyui/boot.js"></script>   
		<script type="text/javascript" src="/ais/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="/ais/resources/js/common.js"></script>
		
		<link href="/ais/resources/css/common.css" rel="stylesheet" type="text/css" />  --%>
		
		<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="/ais/resources/js/common.js"></script>  
		<link href="/ais/resources/css/common.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="/ais/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="/ais/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>	 --%>
		
		
		
		
				
		
		
	<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>
			
		
  </head>

<body style='padding:0px;margin:0px;overflow:hidden;'  border='0' fit='true' class='easyui-layout'>
<div region='north'  style='padding:0px;margin:0px;height:800px;overflow:hidden;' title='条件查询'  class='easyui-layout'>
          <div id="search" style="margin:0px auto;">    
			<s:form id="myform" name="myform" action="controlCompareAnalysisSearch" namespace="/project" method="post">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="left" class="ListTable">
				<tr>
					<td class="EditHead"><span style="color:red">*</span>计划年度</td>
					<td class="editTd" style="width:20%">
						<select multiple="multiple" id="pro_year1" class="easyui-combobox" name="pro_year" style="width:80%"  editable="false">
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
					       		 <option value="<s:property value='key'/>"><s:property value='value'/></option>			       		
					       </s:iterator>
					       <input type="hidden" id="pro_year" name="pso.pro_year"/>
					    </select>
					</td>
					<td class="EditHead"><span style="color:red">*</span>审计单位</td>
					<td class="editTd" style="width:10%">
						<s:buttonText2 cssClass="noborder" id="audit_dept_name"
									   name="audit_dept_name"
									   cssStyle="width:80%"
									   hiddenName="audit_dept"
									   hiddenId="audit_dept"
									   doubleOnclick="showSysTree(this,{
							  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
							  title:'组织机构选择',
							  checkbox:true
							})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
					</td>	
								
					<td class="EditHead">被审计单位</td>
					<td class="editTd" style="width:15%" >
					
						<s:buttonText2 cssClass="noborder" id="audit_object" hiddenId="audit_object_hidden"
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
					
				 <td class="EditHead">项目类别</td>
					<td class="editTd" style="width:10%">
							   <select multiple="multiple" id="pro_type_name1" class="easyui-combobox" data-options="panelHeight:'auto'" name="pro_type_name"  style="width:80%"  editable="false">
						       <option value="">请选择</option>
						       <s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
						         <option value="<s:property value="name"/>"><s:property value="name"/></option>
						       </s:iterator>
						   <input type="hidden" id="pro_type_name" name="pso.pro_type_name""> 
						    </select>
						</td> 
								
												
										
					<td style="padding-left:10px">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					</td>
				</tr>	
			</table>
	       </s:form>
          </div>
          <div style="height:500px"></div>
     
          
	      </div>
	    
  

 <script type="text/javascript">
 
 $("#pro_year1").multiSelect({ 
		selectAll: true,
		oneOrMoreSelected: '*',
		selectAllText: '全选',
     //uncheckAllText: '全不选',
		noneSelected: '',
		listWidth:'200'
	}, function(){   //回调函数
		$('#pro_year').attr('name','pso.pro_year').val($("#pro_year1").selectedValuesString());
	});


$("#pro_type_name1").multiSelect({ 
		selectAll: true,
		oneOrMoreSelected: '*',
		selectAllText: '全选',
	 	noneSelected: '',
		listWidth:'200'
	}, function(){   //回调函数
		$('#pro_type_name').attr('name','pso.pro_type_name').val($("#pro_type_name1").selectedValuesString());
	});

 
  function doSearch(){   
	    var planYear = document.getElementById("pro_year").value;
	   // var planYear = $('#pro_type_name').attr('name','pso.pro_type_name').val($("#pro_type_name1").selectedValuesString());
	    var auditDeptName = document.getElementById("audit_dept_name").value;
	    var auditObjectName = document.getElementById("audit_object").value;
	    var proTypeName = document.getElementById("pro_type_name").value;

	    alert(planYear);
	    alert(proTypeName);
	    
	    //alert(auditDeptName);
	    //alert(auditObjectName);
	    if(planYear == "" || planYear == null){
	    	alert("请选择计划年度！");
	    }
	    else if((planYear != null)&&(auditDeptName == null || auditDeptName == "")&&(auditObjectName == null || auditObjectName == "")&&(proTypeName == null ||proTypeName == "")){
	    	alert("除计划年度外，请至少再选择一个查询条件！");
	    }
	  
	    
	    else{
	    	document.forms[0].action="/ais/project/controlCompareAnalysisSearch.action";
	    	document.forms[0].submit();
	    }	
   }
  

  </script> 
  </body>
</html>
