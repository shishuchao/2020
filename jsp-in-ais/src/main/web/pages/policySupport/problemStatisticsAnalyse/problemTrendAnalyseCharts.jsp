<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>问题趋势分析图</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/policySupport/css/statistics.css" media="all"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script src="<%=request.getContextPath()%>/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		
	<script type="text/javascript">
		var problemTrendTables = function(){
			return {
				problemTrendChart:function() {
					var sortName = "";
					if('${param.ayalyseType}' == '1'){
						sortName = "项目类别";
					}else if('${param.ayalyseType}' == '2'){
						sortName = "问题类别";
					}
					
		            var echart = echarts.init(document.getElementById('problemtrend'));
		            echart.showLoading({
		                text:'数据加载中，请稍后...'
		            });
		            
		            $.ajaxSettings.async = false;
	
		            var categories = [];
		            var series = [];
		            var legend = [];
		            $.getJSON('/ais/proledger/problem/problemTrendAnalyseCharts.action?from=${param.from}&ayalyseType=${param.ayalyseType}&projectYear='+
		            		'${param.projectYear}&auditDept=${param.auditDept}&auditObject=${param.auditObject}&projectType=${param.projectType}&'+
		            		'problemType=${param.problemType}&reformStatus=${param.reformStatus}',
		            		{},
		            		function(json){
		                categories = json.category;
		                legend = json.legend;
		                series = json.series;
		            });
		            
		            options = {
		            	    tooltip: {
		            	        trigger: 'axis',
		            	        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
		            	            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		            	        }
		            	    },
		            	    legend: {
		            	        y: 'bottom',
		            	        data: legend
		            	    },
		            	    grid: {
		            	        left: '3%',
		            	        right: '3%',
		            	        top: '6%',
		            	        bottom: '6%',
		            	        containLabel: true
		            	    },
		            	    yAxis: {
								name:'问题数量（个）',
		            	        type: 'value'
		            	    },
		            	    xAxis: {
		            	        type: 'category',
		            	        data: categories
		            	    },
		            	    series: series,
						color:['#76c1a1','#f4b860', '#70acf6', '#c23531', '#eb8773', '#c869a5', '#6473d7',
							   '#749f83','#2f4554', '#c4ccd3', '#d48265', '#91c7ae', '#81d2b4','#ca8622']
		            	};
		            
			            echart.setOption(options);
			            echart.hideLoading();
			            window.onresize = function () {
			            //重置容器高宽
			            echart.resize();
		            };
	
					 //编辑父页面table
					 var items = [];
					 var percent = 85/categories.length;
					 if(percent<4){
						 percent = 4;
					 }
					 items.push("<thead><tr class='datagrid-header datagrid-header-row datagrid-row'>");
					 //添加列标题
					 items.push("<td style='width:80px;text-align:center' nowrap>序号</td>");
					 items.push("<td style='width:15%;text-align:center'>"+sortName+"</td>");
					 for(var i=0;i<categories.length;i++){
						 items.push("<td style='width:"+percent+"%;text-align:center;'>"+categories[i]+"</td>");
					 }
					 items.push("</tr><thead><tbody>");
					 for (var i=0;i<series.length-1;i++) {
						 var f = i % 2 == 1 ;
						 var s = f ? '<tr nowrap class="rowTrover datagrid-row-alt datagrid-row">' : '<tr class="rowTrover datagrid-row">';
						 //添加列
						 items.push(s+"<td nowrap class='task-title-sp' style='width:3%;text-align:center;color:#666'>"+(i+1)+"</td>");
						 items.push("<td nowrap style='width:10%;text-align:center;color:#666'>"+series[i].name+"</td>");
						 for(var j=0;j<series[i].data.length;j++){
							 items.push("<td nowrap style='width:"+percent+"%;text-align:right;color:#666'>"+series[i].data[j]+"</td>");
						 }
						 items.push("</tr>");
					 }
					 items.push("</tbody>");
					 $("#problemTrendTable").html(items.join("\n"));
		        }
			}
		}();
		$(document).ready(function(){
			problemTrendTables.problemTrendChart();
		});
	</script>
</head>

<body>
	<div>
		<div>
			<div id="problemtrend" class="chartcss"></div>
		</div>
		<div>
			<table id="problemTrendTable" class="auditwtTable"  cellspacing="0" cellpadding="0">
			</table>
		</div>
	</div>
</body>
</html>