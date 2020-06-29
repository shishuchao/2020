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

<body style='padding:0px;margin:0px;overflow:hidden;' fit='true' border='0' class='easyui-layout'>
	<div region='north'  style='padding:0px;margin:0px;height:150px;overflow:hidden;' >
		<div id="search" style="margin-top:20px;width:100%">
			<s:form id="myform" name="myform" action="controlProjectCountRank" namespace="/project" method="post">
				<table  cellpadding=0 cellspacing=0  border=0 style="width:100%;border-collapse:separate; border-spacing:0px 7px;">
				<tr>
					<td style="width:7%" align="right"><span style=" font-weight:bold;">统计范围</span></td>
				
					<td align="right" style="width:9%"><span style="color:red">*</span>项目年度&nbsp;&nbsp;&nbsp;</td>
					<td  style="width:16%">
						<select multiple="multiple" id="pro_year1" name="pro_year"  style="width:70%"  editable="false">
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
					       		 <option value="<s:property value='key'/>"><s:property value='value'/></option>			       		
					       </s:iterator>
					       <input type="hidden" id="pro_year" name="pso.pro_year"/>
					    </select>
					</td>
					<td class="Head"  align="right" style="width:7%"><span style="color:red">*</span>TOP N&nbsp;&nbsp;&nbsp;</td>
					<td  class="Td" style="width:16%">
					   <input type="text" id="topN" name="topN" value="10"  style="width:72%"/>
					</td>
					<td class="Head" align="right" style="width:7%">项目类别&nbsp;&nbsp;&nbsp;</td>
					<td  class="Td" style="width:16%">
						<select multiple="multiple" id="pro_type_name1" data-options="panelHeight:'auto'" name="pro_type_name"  style="width:70%"  editable="false">
							<option value="">请选择</option>
							<s:iterator value="basicUtil.PlanProjectTypeMap4ZhongjianContainZX.keySet()" id="entry">
								<option value="<s:property value="code"/>"><s:property value="name"/></option>
							</s:iterator>
							<input type="hidden" id="pro_type_name" name="pso.pro_type_name">
						</select>
					</td>
					<td style="width: 30%;"></td>
				</tr>
				<tr>
					<td></td>
					<td class="Head" align="right" style="width:7%">审计单位&nbsp;&nbsp;&nbsp;</td>
					<td  class="Td" style="width:16%">
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
					<td class="Head"  align="right" style="width:9%">被审计单位&nbsp;&nbsp;&nbsp;</td>
					<td class="Td"  style="width:16%" >
						<s:buttonText2 cssClass="noborder" id="audit_object" hiddenId="audit_object_hidden"
							name="audit_object_name"
							cssStyle="width:70%"
							hiddenName="audit_object_name_hidden"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
							  cache:false,
							  checkbox:true,
   							  param:{'departmentId':'${magOrganization.fid}'},

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
					<td >
						<div class="refresh-btn" onclick="doSearch()" >查询</div>
					</td>
				</tr>
				<tr>
					<td style="width:7%" align="right"><span style=" font-weight:bold;">统计维度</span></td>
					<td colspan="5">
						<div style="margin-left:3%; width:60%;float:left;margin-top: 10px">
									<input type="radio" name= "xmslpm" class="radioBox" value="1"  checked="checked"
                                     id="asjdw" onclick="changeSelectType('1')"/> 
                                    <label class="radioText" for="asjdw">审计单位</label>   
                                   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    <input type="radio" name= "xmslpm" class="radioBox" value="2"  
                                     id="absjdw" onclick="changeSelectType('2')"/> 
                                    <label class="radioText" for="absjdw">被审计单位</label> 
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    <input type="radio" name= "xmslpm" class="radioBox" value="3"  
                                     id="axmlb" onclick="changeSelectType('3')"/> 
                                    <label class="radioText" for="axmlb">项目类别</label>
						</div>
							<img id="ldstxmpmpxxs"  style="cursor: pointer;float: left;margin-right: 1%;margin-top: 10px" title="正序" onclick="doOrderSearch('asc')" src="../images/rise.png"/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<img id="ldstxmpmpxxx"  style="cursor: pointer;float: left;margin-right: 1%;margin-top: 10px"  title="倒序" onclick="doOrderSearch('desc')" src="../images/decline.png"/>
                     </td>
                     
				</tr>
			</table>
	       </s:form>
          </div>
   </div>      
  
  
  <!--图表显示-->
        
          
          <!--折线图-->
          <div id="projectCountRankChart" region='center' style="padding:0px;margin:0px;overflow:hidden;" title="项目数量排名">
	         <iframe id="myIframe" width="100%" height="100%" scrolling="auto" src="${contextPath}/pages/project/project_countRank_chart.jsp?proYear=${defaultYear}" frameborder="0"></iframe>		   
          </div>
        
        
</div>
	    
  

 <script type="text/javascript">
 //设置全局变量，并赋初值（默认）
	var from = '';
	var proYear = '';
	var auditDept = '';
	var auditObject = '';
	var proType = '';
	var topN = document.getElementById("topN").value;
	var selectType = $("input[name='xmslpm']:checked").val(); 
	var orderStr = '';

	$(function () {
		var proYear = '${defaultYear}';
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
			listHeight:'80'
		}, function(){   //回调函数
			//$('#pro_year').attr('name','pso.pro_year').val($("#pro_year1").selectedValuesString());
		});
	});


$("#pro_type_name1").multiSelect({ 
		selectAll: true,
		oneOrMoreSelected: '*',
		selectAllText: '全选',
	 	noneSelected: '',
		listWidth:'200',
		listHeight:'80'
	}, function(){   //回调函数
		//$('#pro_type_name').attr('name','pso.pro_type_name').val($("#pro_type_name1").selectedValuesString());
	});


function doSearch(){
	from = 'search';
	proYear = $("#pro_year1").selectedValuesString();
	auditDept = document.getElementById("audit_dept").value;
	auditObject = document.getElementById("audit_object_hidden").value;
	proType = $("#pro_type_name1").selectedValuesString();
	topN = document.getElementById("topN").value;
	selectType = $("input[name='xmslpm']:checked").val();  
	
	//必输项检查

	    if((proYear == "" || proYear == null)){
			showMessage1("请选择项目年度");
	    	return false;
	    }
	    if((topN =="" || topN == null) ){
			showMessage1("请输入TOP N值");
			return false;
	    }
	    
	    var reg = /^[0-9]*[1-9][0-9]*$/;
	    if(topN != "" && topN != null){
		    if(!reg.test(topN)){
				showMessage1("请输入一个正整数");
				return false;
		    }
	  } 
	

     selectType = $("input[name='xmslpm']:checked").val();  
     if((proYear != "" && proYear != null)&&(topN !="" && topN != null)&&(reg.test(topN))){  
     $('#myIframe').attr('src','${contextPath}/pages/project/project_countRank_chart.jsp?selectType='+selectType+'&from='+from+
					'&contextPath=${contextPath}&proYear='+proYear+'&auditDept='+auditDept+'&auditObject='+auditObject+'&proType='+
					proType+'&topN='+topN+'&orderStr='+orderStr);
     }    
}

     
  function changeSelectType(selectType){
	  proYear = $("#pro_year1").selectedValuesString();
	  selectType = $("input[name='xmslpm']:checked").val();  
	   $('#myIframe').attr('src','${contextPath}/pages/project/project_countRank_chart.jsp?selectType='+selectType+'&from='+from+
				'&contextPath=${contextPath}&proYear='+proYear+'&auditDept='+auditDept+'&auditObject='+auditObject+'&proType='+
				proType+'&topN='+topN+'&orderStr='+orderStr);
	   
   }
  
  
  
  function doOrderSearch(orderStrParam){ 
	  proYear = $("#pro_year1").selectedValuesString();
	  selectType = $("input[name='xmslpm']:checked").val();  
	   $('#myIframe').attr('src','${contextPath}/pages/project/project_countRank_chart.jsp?selectType='+selectType+'&from='+from+
				'&contextPath=${contextPath}&proYear='+proYear+'&auditDept='+auditDept+'&auditObject='+auditObject+'&proType='+
				proType+'&topN='+topN+'&orderStr='+orderStrParam);
  }
  </script>
  </body>
</html>
