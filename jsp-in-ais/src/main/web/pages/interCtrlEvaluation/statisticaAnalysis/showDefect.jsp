<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE HTML >
<html>
<title>测试结果结构统计</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/index/assets/global/plugins/echarts/echarts.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript">

  
  function exportExcel(){
  	  var dept = <%=request.getAttribute("dept")%>;
	  var year = <%=request.getAttribute("year")%>;;
	  window.location.href="/ais/riskManagement/statistics/riskControl/exportExcel.action?dept="+dept+"&year="+year;
   }

   $(function(){

       $('#evaluateYear').combobox('setValue','${evaluateYear}');
       $('#evaluateYear').combobox('setText','${evaluateYear}');
       $('#evaDept').val('${evaDept}');
       $('#evaDeptCode').val('${evaDeptCode}');

       $('#searchBtn').on('click',function(e){
           var year = $('#evaluateYear').combobox('getValue');
           var evaDeptCode = $('#evaDeptCode').val();
           if(year == null||evaDeptCode == null||evaDeptCode===''){
               showMessage1('年度、被评价单位均为必选',null,null,null);
               return;
           }else {
               $('#searchForm').submit();
           }
       });
   });

</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'  border='0' fit='true' class='easyui-layout'>
	<div region='north'  style='padding:0px;margin:0px;height:80px;overflow:hidden;' title='条件查询'>
		<div id="search" style="margin:0px auto; width:80%;">
			<form id="searchForm" name="searchForm" method="post" action="${contextPath}/intctet/statisticaAnalysis/initDefectPage.action">
	         	<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="left" class="ListTable">
					<tr >
						<td class="EditHead">	<span style="color:red">*</span>	年度	</td>
						<td class="editTd" style="width:30%">
							<select class="easyui-combobox" name="evaluateYear" id="evaluateYear" style="width:80%"  editable="false">
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
						       		<s:if test="${riskEvaluateWait.evaluateYear == key}">
						       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       		</s:if>	
						       		<s:else>
						       			<option value="<s:property value="key"/>"><s:property value="value"/></option>
						       		</s:else>				       		
						       </s:iterator>
						    </select>
						</td>	
						<td class="EditHead">	<span style="color:red">*</span>	被评价单位</td>
						<td class="editTd" style="width:30%">
							<input type='text' id='evaDept' name="evaDept" title="被评价单位" 	class="noborder editElement clear required" readonly/>
							<input type='hidden' name="evaDeptCode" id='evaDeptCode' title="被评价单位" class="noborder editElement clear"/>
							<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
                                  title:'被评价单位选择',
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
							})"></img>
						</td>
						<td style="padding-left:15px">
							<%--<button id="exportBtn" class="easyui-linkbutton" data-options="iconCls:'icon-export'">导出</button>--%>
							<button id="searchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</button>
						</td>
					</tr>	
				</table>
	       </form>
	    </div>
	</div>
	
	<div region='center'  style='padding:0px;margin:0px;height:90px;overflow:hidden;' title='内部控制评价缺陷统计汇总表'>
		<table  class="table table-striped"id="mTable" style="width:100%;border-collapse:collapse;" >					
			<thead>					
				    <tr>
				      <th  rowspan="2" class="EditHead" style="width:10%;text-align:center">业务流程</th>
				      <th rowspan="2" class="EditHead" style="width:10%;text-align:center">控制点数量</th>
				      <th colspan="${fn:length(defectTypeColumns)}" class="EditHead" style="width:25%;text-align:center">缺陷类别</th>
				      <th colspan="${fn:length(defineResultColumns)}" class="EditHead" style="width:25%;text-align:center;">缺陷等级</th>
				    </tr>
				    <tr>
						<c:set var="typeCount" value="${fn:length(defectTypeColumns)}"></c:set>
						<c:forEach items="${defectTypeColumns}" var="type">
							<td class="editTd" >${type}</td>
						</c:forEach>
						<c:forEach items="${defineResultColumns}" var="result">
							<td class="editTd" >${result}</td>
						</c:forEach>
				    </tr>
	  			</thead>
	  			<tbody>	  				
	  				<c:forEach items="${results}" var="re" varStatus="num">
	  					<tr>
	  						<td class="editTd" >${re[0]}</td>
	  						<td class="editTd" >${re[1]}</td>
							<c:forEach items="${defectTypeColumns}" var="type" varStatus="st">
								<td class="editTd" >${re[st.index+2]}</td>
							</c:forEach>
							<c:forEach items="${defineResultColumns}" var="result" varStatus="st">
								<td class="editTd" >${re[st.index+2+typeCount]}</td>
							</c:forEach>
	  					</tr>
	  				</c:forEach>
	  			</tbody>		
		</table>
	</div>
</body>
</html>
