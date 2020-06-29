<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>按缺陷等级统计</title>
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

    function doSearch(){
        var year = $('#evaluateYear').combobox('getValue');
        var evaDeptCode = $('#evaDeptCode').val();
        if(year == null||evaDeptCode == null||evaDeptCode===''){
            showMessage1('年度、被评价单位均为必选',null,null,null);
            return;
        }else{
            $('#chartFrame').attr('src',"${contextPath}/pages/interCtrlEvaluation/statisticaAnalysis/lineChart.jsp?from=byLevel&evaluateYear="+year+"&evaDeptCode="+evaDeptCode);
        }
    }

    function exportExcel(){
        var dept = <%=request.getAttribute("dept")%>;
        var year = <%=request.getAttribute("year")%>;;
        window.location.href="/ais/riskManagement/statistics/riskControl/exportExcel.action?dept="+dept+"&year="+year;
    }

    $(function(){
        $('#evaluateYear').combobox('setValue','${evaluateYear}');
        $('#evaluateYear').combobox('setText','${evaluateYear}');
        $('#evaDept').val('${user.fdepname}');
        $('#evaDeptCode').val('${user.fdepid}');
        $('#searchBtn').on('click',function(e){
            doSearch();
        });
    });
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'  border='0' fit='true' class='easyui-layout'>
	<div region='north'  style='padding:0px;margin:0px;height:80px;overflow:hidden;' title='条件查询'>
		<div id="search" style="margin:0px auto; width:80%;">
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="left" class="ListTable">
				<tr >
					<td class="EditHead">	<span style="color:red">*</span>	年度	</td>
					<td class="editTd" style="width:30%">
						<select class="easyui-combobox" name="evaluateYear" id="evaluateYear" style="width:80%"  editable="false">
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead">	<span style="color:red">*</span>	被评价单位</td>
					<td class="editTd" style="width:30%">
						<input type='text' id='evaDept'  title="被评价单位" 	class="noborder editElement clear required" readonly/>
						<input type='hidden' id='evaDeptCode' title="被评价单位" class="noborder editElement clear"/>
						<img  style="cursor:pointer;border:0" src="${contextPath}/easyui/1.4/themes/icons/search.png" class=" editElement "
							  onclick="showSysTree(this,{
									  title:'被评价单位选择',
									  param:{
									  'rootParentId':'0',
									  'beanName':'UOrganizationTree',
									  'treeId'  :'fid',
									  'treeText':'fname',
									  'treeParentId':'fpid',
									  'treeOrder':'fcode',
									  'defaultDeptId':'${user.fdepid}'
									  }
									  })"></img>
					</td>
					<td style="padding-left:15px">
						<%--<button id="exportBtn" class="easyui-linkbutton" data-options="iconCls:'icon-export'">导出</button>--%>
						<button id="searchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div region='center'  style='padding:0px;height:500px;margin:0px;overflow:auto;' title='统计图'>
		<iframe id="chartFrame" width="100%" height="500px" src="/ais/pages/interCtrlEvaluation/statisticaAnalysis/lineChart.jsp?from=byLevel" frameborder="0"></iframe>
	</div>
	<div region='south'  style='padding:0px;margin:0px;height:200px;overflow:auto;' title='内部控制评价缺陷统计汇总表'>
		<table  class="table table-striped" id="levelTable" style="width:100%;border-collapse:collapse;" >
			<thead>					
				    <tr>
				      <th  class="EditHead" style="width:20%;text-align:center">业务流程</th>
				      <th  class="EditHead" style="width:20%;text-align:center">重大缺陷</th>
				      <th  class="EditHead" style="width:20%;text-align:center">重要缺陷</th>
				      <th  class="EditHead" style="width:20%;text-align:center;">一般缺陷</th>
				      <th  class="EditHead" style="width:10%;text-align:center;">合计</th>					     
				    </tr>				   
	  			</thead>
	  			<tbody>	  				
	  				<c:forEach items="${resultList}" var="adList" varStatus="num">
	  					<tr>
	  						<td class="editTd" ></td>
	  						<td class="editTd" ></td>
	  						<td class="editTd"></td>
		  					<td class="editTd"></td>
	  						<td class="editTd"></td>
	  					</tr>	
	  				</c:forEach>
	  			</tbody>		
		</table>
	</div>
</body>
</html>
