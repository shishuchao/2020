<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="org.aspectj.weaver.patterns.TypePatternQuestions.Question"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html";charset="utf-8">
<title>审计问题数量排名</title>

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
	<div region='north'  style='padding:0px;margin:0px;height:180px;overflow:hidden;' >
          <div id="search" style="margin-top:20px;width:100%">
			<s:form id="myform" name="myform" action="rankingQuestionsSearch" namespace="/archives/workprogram/pigeonhole" method="post">
				<table  cellpadding=0 cellspacing=0  border=0 style="width:100%;border-collapse:separate; border-spacing:0px 7px;">
					<tr>
						<td style="width:7%" align="right"><span style=" font-weight:bold;">统计范围</span></td>
						
						<td  align="right" style="width:7%"><span style="color:red">*</span>项目年度&nbsp;&nbsp;&nbsp;</td>
						<td   style="width:16%">
							<select multiple="multiple" id="pro_year1"  name="pro_year1" style="width:70%"  editable="false">
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
						       		 <option checked="checked" value="<s:property value='key'/>"><s:property value='value'/></option>			       		
						       </s:iterator>
						       <input type="hidden" id="pro_year" name="pro_year"/>
						    </select>
						  
						</td>  
						
						<td class="Head"  align="right" style="width:7%"><span style="color:red">*</span>TOP N&nbsp;&nbsp;&nbsp;</td>
						<td class="Td" style="width:16%">
							<input type="number" style="width:72%" min="0"  value="10" id="topN" name="topN">
						</td>
						<td class="Head"  align="right" style="width:7%">整改状态&nbsp;&nbsp;&nbsp;</td>
						<td class="Td" style="width:16%">
						<select multiple="multiple" id="mend_state1"  name="mend_state1" style="width:70%"  editable="false">
					        <s:iterator value="basicUtil.fllowOpinionList" id="entry">				      
					       		 <option value="<s:property value='code'/>"><s:property value='name'/></option>			       		
					       </s:iterator>
					       <input type="hidden" id="mend_state" name="mend_state"/>
					    </select>
						</td>
						
					</tr>
					<tr>
						<td ></td>
						
						<td class="Head"  align="right">项目类别&nbsp;&nbsp;&nbsp;</td>
						<td class="Td" style="width:16%">
								<select multiple="multiple" id="pro_type1"  name="pro_type1" style="width:70%"  editable="false">
							       <option value="">请选择</option>
							       <s:iterator value="basicUtil.PlanProjectTypeMap4ZhongjianContainZX.keySet()" id="entry">
							         <option value="<s:property value="code"/>"><s:property value="name"/></option>
							       </s:iterator>
							        <input type="hidden" id="pro_type" name="pro_type">
							    </select>	
						</td>
						<td class="Head"  align="right" style="width:7%">审计单位&nbsp;&nbsp;&nbsp;</td>
						<td class="Td" style="width:16%">
							<input id="audit_dept_name" style="width:70%" class="noborder" name="audit_dept_name" value="${audit_dept_name}" type="text" readonly/>
							<input id="audit_dept"  name="audit_dept" value="${audit_dept}" type="hidden"/>							
							<img style="cursor: pointer;" onclick="showSysTree(this,{
					    				url:'${pageContext.request.contextPath}/systemnew/orgListByCurrentAndLowerLevel.action',
					    				title:'请选择审计单位',
					    				checkbox:true
									})" src="${contextPath }/easyui/1.4/themes/icons/search.png"></img>
						</td> 
						
						
						
						
	
					 
						<td  align="right" class="Head" style="width:9%" >问题一级分类&nbsp;&nbsp;&nbsp;</td>
						<td  class="Td" style="width:16%">
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
									})" src="${contextPath }/easyui/1.4/themes/icons/search.png"></img>
							
					  			
						</td>
						<td >
							<div class="refresh-btn" onclick="doSearch()" >查询</div>
						</td>
				   </tr>
					<tr>
						<td ></td>						
						<td class="Head"  align="right" style="width: 9%;">被审计单位&nbsp;&nbsp;&nbsp;</td>
						<td class="Td" style="width:16%" >
							<input id="audit_object_name" style="width:70%" class="noborder" name="audit_object_name" value="${audit_object_name}" type="text" readonly/>
							<input id="audit_object"  name="audit_object" value="${audit_object}" type="hidden"/>							
							<img style="cursor: pointer;" onclick="showSysTree(this,{
					    				url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
					    				title:'请选择被审计单位',
									param:{'departmentId':'${magOrganization.fid}'},
									checkbox:true
									})" src="${contextPath }/easyui/1.4/themes/icons/search.png"></img>
						</td>
					</tr>
					
					<tr>
					
						<td style="width:7%" align="right"><span style=" font-weight:bold;">统计维度</span></td>
						<td  colspan="5">
							<div style="margin-left:3%; width:80%;float:left;margin-top: 10px">
								
				                  <input type="radio" name="wtpm"  class="radioBox" value="org" checked="checked"   onclick="changeRadioType('org')"
				                     /><label class="radioText" for="wtpm" id="wtpmaskdw">审计单位</label>
				                   &nbsp;&nbsp;&nbsp;
				                  <input type="radio" name="wtpm" class="radioBox" value="obj"  onclick="changeRadioType('obj')"
				                    /><label class="radioText" for="absjdw3">被审计单位</label>
				                  &nbsp;&nbsp;&nbsp;
				                  <input type="radio" name="wtpm" class="radioBox" value="protype"  onclick="changeRadioType('protype')"
				                         /><label class="radioText" for="absjdw3">项目类别</label>
				                  &nbsp;&nbsp;&nbsp;
				                  <input type="radio" name="wtpm" class="radioBox" value="sortbig"  onclick="changeRadioType('sortbig')"
				                          /><label class="radioText" for="awtxz3">问题一级分类</label>
				                  &nbsp;&nbsp;&nbsp;
				                  <input type="radio" name="wtpm" class="radioBox" value="wtd"  onclick="changeRadioType('wtd')"
				                           /><label class="radioText" for="awtd3">问题点</label>
			                           
			             	</div>
				                <img id="ldstwtzgqkpxxx"  style="cursor: pointer;float: left;margin-right: 1%;margin-top: 10px" title="倒序" onclick="sorting('zx')" src="/ais/images/decline.png"/>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<img id="ldstwtzgqkxxs"  style="cursor: pointer;float: left;margin-right: 1%;margin-top: 10px" title="正序" onclick="sorting('dx')" src="/ais/images/rise.png"/>
						</td>

				</tr>	
				</table>
				
	       </s:form>
          </div>
		  
   </div>
	<div region='center' id="auditPlan" style='padding:0px;margin:0px;overflow:hidden;'title="问题数量排名"  >
	  <iframe id="iframe" width="100%" height="100%" scrolling="auto" src="" frameborder="0"></iframe>	
	    
	</div>
	    
 <script type="text/javascript">
 	var pro_year="${pro_year}";
 	
	var audit_dept="${audit_dept}";
	var audit_dept_name=encodeURI("${audit_dept_name}");
	
	var audit_object="${audit_object}";
	var audit_object_name=encodeURI("${audit_object_name}");
	
	var topN="${topN}";
	
	var sort_big_code="${sort_big_code}";
	var sort_big_name=encodeURI("${sort_big_name}");
	
	var pro_type="${pro_type}";	
	
	var mend_state=encodeURI("${mend_state}");
	
	var type="${type}";
	
	var sort="${sort}";	 	

	 $('#iframe').attr('src','${contextPath}/pages/archives/pigeonhole/workarchives/rankingquestionsecharts.jsp?pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_object='+audit_object+'&topN='+topN+'&pro_type='+pro_type+'&sort_big_code='+sort_big_code+'&mend_state='+mend_state+'&type='+type+'&sort='+sort);

	 
$(function(){
	
	var proYear = '${pro_year}';
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
			//回调函数
			$('#pro_year').attr('name','pro_year').val($("#pro_year1").selectedValuesString());
		
	});  
	
	
	$("#pro_type1").multiSelect({ 
		selectAll: true,
		oneOrMoreSelected: '*',
		selectAllText: '全选',
	 	noneSelected: '',
		listWidth:'200',
		listHeight:'90'
	}, function(){   //回调函数
		$('#pro_type').attr('name','pro_type').val($("#pro_type1").selectedValuesString());
	} );
	
	
		
	$("#mend_state1").multiSelect({ 
		selectAll: true,
		oneOrMoreSelected: '*',
		selectAllText: '全选',
	 	noneSelected: '',
		listWidth:'200',
		listHeight:'90'
	}, function(){   //回调函数
		$('#mend_state').attr('name','mend_state').val($("#mend_state1").selectedValuesString());
	} );
	
	 
});
function doSearch(){  
		
		pro_year=$('#pro_year1').selectedValuesString();
		audit_dept=$('#audit_dept').val();
		audit_object=$('#audit_object').val();
		topN=$('#topN').val();
		sort_big_code=$('#sort_big_code').val();
		pro_type=$('#pro_type1').selectedValuesString();
		mend_state=$('#mend_state1').selectedValuesString();
		type = $("input[name='wtpm']:checked").val();
		if((pro_year == "" || pro_year == null)){
			showMessage1("请选择项目年度");
			return false;
		}
		if((topN =="" || topN == null) ){
			showMessage1("请输入TOP N");
			return false;
		}
		$('#iframe').attr('src','${contextPath}/pages/archives/pigeonhole/workarchives/rankingquestionsecharts.jsp?pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_object='+audit_object+'&topN='+topN+'&pro_type='+pro_type+'&sort_big_code='+sort_big_code+'&mend_state='+mend_state+'&type='+type);
   	
}


function sorting(param) {
		sort=param;	
		  $('#iframe').attr('src','${contextPath}/pages/archives/pigeonhole/workarchives/rankingquestionsecharts.jsp?pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_object='+audit_object+'&topN='+topN+'&pro_type='+pro_type+'&sort_big_code='+sort_big_code+'&mend_state='+mend_state+'&type='+type+'&sort='+sort);
    	
} 
  
//根据维度更换图表  
 function changeRadioType(param){

		  type=param;
		  $('#iframe').attr('src','${contextPath}/pages/archives/pigeonhole/workarchives/rankingquestionsecharts.jsp?pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_object='+audit_object+'&topN='+topN+'&pro_type='+pro_type+'&sort_big_code='+sort_big_code+'&mend_state='+mend_state+'&type='+type+'&sort='+sort);
			
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