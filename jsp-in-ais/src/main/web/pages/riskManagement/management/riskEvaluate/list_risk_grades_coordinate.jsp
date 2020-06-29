<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>风险坐标图-风险等级矩阵</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">
var colorArray = [{"value":"#00FF00","text":"绿色"},{"value":"#FFFF00","text":"黄色"},{"value":"#FF0000","text":"红色"},{"value":"#FFFFFF","text":"白色"}];
</script>

<style type="text/css">
			#MatrixTable {
				border-collapse:collapse;
				border:solid black; 
				border-width:0 0 0 1px;
				width: 700px;
			}
			#MatrixTable td {border:solid black;border-width:0 1px 1px 0;padding:2px;text-align: center;}
			#MatrixTable .xType{
				background-color: #F2DDDC;
				font-weight: bold;
				border-width:1px 1px 1px 0;
				height: 50;
				cursor: pointer;
			}
			#MatrixTable .yType{
				background-color: #FEFE9A;
				font-weight: bold;
				border-width:1px 1px 1px 0;
				height: 50;
				cursor: pointer;
			}
			#MatrixTable .autoValue{
				cursor: pointer;
				border-width:1px 1px 1px 1px;
			}
		</style>
		
	<script type="text/javascript">
		$(function(){
			var totalIds = "${totalIds}";
			init(totalIds)
		});
		
		function init(totalIds) {
			var bodyW = $('body').width();    
			frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#sortTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'RiskEvaluateWait',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
				whereSql: ' id in ' + totalIds,
				winWidth:800,
				winHeight:250,
				sort:'sumScore',
				order:'desc',
				gridJson:{    
					checkOnSelect:true,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					frozenColumns:[[{field:'id', title:'选择', hidden:true, align:'center', show:'false'}, 
									{field:'evaluateSerialNum', title:'编号', align:'center', show:'true'}, 
									{field:'evaluateYear', title:'年度', align:'center', show:'true'},
									{field:'riskDescription', title:'风险描述', width:bodyW*0.25 + 'px', align:'left',halign:'center', sortable:true, show:'true' ,oper:'eq'},
									{field:'responsibilityDepName', title:'责任部门', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true, show:'true', oper:'eq'},
									{field:'riskFatherSortName', title:'风险大类', hidden:true, width:bodyW*0.06 + 'px', align:'center', show:'true'},
									{field:'riskSonSortName', title:'风险子类', hidden:true, width:bodyW*0.06 + 'px', align:'center', show:'true'},
									{field:'riskItemName', title:'风险事项', width:bodyW*0.1 + 'px', align:'left', halign:'center',sortable:true, show:'true', oper:'eq',
				            	    	formatter: function(value, rowData, rowIndex) {
				            		    	url = '${contextPath}/riskManagement/management/riskSort/viewRiskEvaluateSort.action?id=' + rowData.id + '&riskEvaluateTaskId='+rowData.riskEvaluateTaskId;
			            			    	return '<a style=\'cursor:pointer;color:blue;\' href=\'#\' onclick="viewBasicInfo(\'' + url + '\')">'+rowData.riskItemName+'</a>';
			            		   
				            	    	}
									}]],
					columns:[[
						{field:'evaluatePersonName', title:'评估人', width:bodyW*0.08 + 'px', align:'center', sortable:true, hidden:true},
						{field:'riskLevel', title:'风险等级', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq',
							formatter:function(value,rowData,rowIndex){
								if(rowData.riskLevel == '0') {
									return "无风险";
								} else if(rowData.riskLevel == '1'){
									return "低风险";
								} else if(rowData.riskLevel == '2'){
									return "中风险";
								} else if(rowData.riskLevel == '3'){
									return "高风险";
								}
							}  
						},
						{field:'possibleScore', title:'可能性得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'affectScore', title:'影响程度得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'sumScore', title:'综合得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'}
					]],
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':false},  
				{'index':2, 'display':false}, 
				{'index':3, 'display':false}, //导出到excel
				{'index':4, 'display':false}, //查询
				{'index':5, 'display':false},
				{'index':6, 'display':false}, 
				{'index':7, 'display':false},
				{'index':8, 'display':false}  //刷新
			]);
			
			//单元格tooltip提示
			$('#sortTable').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
		}
		
		function doSearch() {
			myform.submit();
		}
		
		function filterRisk(ids) {
			var idArr = ids.split(',');
			var idTmp = '(\'';
			for(i in idArr) {
				idTmp = idTmp + idArr[i] +'\',\'';
			}
			idTmp = idTmp + '\')';
			init(idTmp);
		}
		
		function viewBasicInfo(url) {
			aud$openNewTab('风险基本信息',url,true);
		}

	</script>
</head>
<body>
    <div class='easyui-layout' fit='true'>
    	<div region="center" id="createtable" align="center">
    	<div id="Search" style="margin:0px auto; width:80%;" >
			<s:form id="myform" name="myform" action="listRiskGradesCoordinate" namespace="/riskManagement/management/riskImplement" method="post">
	         	<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	         	<tr>
	         		<td class="EditHead">风险分类体系</td>
	         		<td class="editTd" colspan="3">
	         			<select class="easyui-combobox" name="rrs_id" style="width:38%">
	         				<s:iterator value="riskTemplateList">
	         					<s:if test="${rrs_id == id}">
	         						<option selected="selected" value="<s:property value="id"/>"><s:property value="sdName"/></option>
	         					</s:if>
	         					<s:else>
	         						<option value="<s:property value="id"/>"><s:property value="sdName"/></option>
	         					</s:else>
	         				</s:iterator>
	         			</select>
	         		</td>
	         		
	         		
	         	</tr>
				<tr>
					<td class="EditHead">
						所属单位
					</td>
						<td class="editTd" style="width:40%" >
							<s:buttonText2 cssClass="noborder" id="affiliatedDeptName"
										   name="riskEvaluateWait.affiliatedDeptName"
										   cssStyle="width:80%"
										   hiddenName="riskEvaluateWait.affiliatedDeptId"
										   hiddenId="affiliatedDeptId"
										   doubleOnclick="showSysTree(this,{
								  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
								  title:'组织机构选择',
								  checkbox:true
								})"
										   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
										   doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
						</td>
					<td class="EditHead">
						评估年度
					</td>
					<td class="editTd" style="width:40%">
						<select class="easyui-combobox" name="riskEvaluateWait.evaluateYear" id="evaluateYear" style="width:80%"  editable="false">
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
				</tr>	
			</table>

	       </s:form> 
	    </div>
	    <div id="toolbar" style="float:right;">
	    		<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </div>
    	
    	<br>
   		<table id="matrixTable">
			<tr>
				<td style="border-width:1 1 1 0;text-align: center;font-size: 16px;font: bolder;">风险等级矩阵</td>
				<s:iterator value="idList">
					<td class="xType"><s:property value="name"></s:property></td>
				</s:iterator>
			</tr>
			<s:iterator value="psList" status="knxStatus">
				<tr>
					<td class="yType" title="${psList[knxStatus.index].code}"><s:property value="name" /></td>
					<s:iterator value="idList" status="yxdjStatus">
						<s:iterator value="riskGrades" status="fxdjStatus">
							<s:if
								test="psList[#knxStatus.index].code*idList[#yxdjStatus.index].code>riskGrades[#fxdjStatus.index].startValue&&psList[#knxStatus.index].code*idList[#yxdjStatus.index].code<=riskGrades[#fxdjStatus.index].endValue">
								<td class="autoValue"
									bgcolor="${riskGrades[fxdjStatus.index].color}" onclick="filterRisk('${strList[knxStatus.index][yxdjStatus.index]}')">${riskGrades[fxdjStatus.index].rlName} (${numList[knxStatus.index][yxdjStatus.index] })</td>
							</s:if>
						</s:iterator>
					</s:iterator>
				</tr>
			</s:iterator>
		</table>
		
		<%-- <div class="easyui-panel" style="height:570px;width:100%;padding:0px;" title="风险明细表">
		<iframe width=100% height=560 frameborder=0 scrolling="no" id="gridRisk"
		 	src="${contextPath}/riskManagement/management/riskImplement/listRiskWait.action">
		</iframe>
		</div>  --%>
    	<br>
			<div style="height: 400px">
				<table id='sortTable'></table>
			</div>
		</div>
    </div>
    <!-- 风险明细表 -->
	 <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</body>
</html>
