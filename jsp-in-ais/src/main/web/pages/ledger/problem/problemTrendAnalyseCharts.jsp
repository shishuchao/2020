<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>风险趋势图</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script src="<%=request.getContextPath()%>/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<%-- <script src="/ais/easyui/1.4/jquery-1.7.1.min.js" type="text/javascript"></script> --%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript">
	var sortName = "项目类别";
	if('${param.ayalyseType}' == '1'){
		sortName = "项目类别";
	}else if('${param.ayalyseType}' == '2'){
		sortName = "问题类别";
	}
	var FirstPageTables = function(){
		return {
			show:function() {
	            var chart = document.getElementById('riskDistributionEcharts');
	            var echart = echarts.init(chart);

	            echart.showLoading({
	                text:'数据加载中，请稍后...'
	            });
	            $.ajaxSettings.async = false;

	            var categories = [];
	            var series = [];
	            var legend = [];
	            $.getJSON('/ais/proledger/problem/problemTrendAnalyseCharts.action?from=${param.from}&ayalyseType=${param.ayalyseType}&projectYear='+
	            		'${param.projectYear}&auditDept=${param.auditDept}&auditObject=${param.auditObject}&projectType=${param.projectType}&'+
	            		'problemType=${param.problemType}&reformStatus=${param.reformStatus}',{},function(json){
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
					color:['#76c1a1','#f4b860',  '#70acf6', '#81d2b4','#eb8773', '#c869a5', '#6473d7']

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
				 items.push("<thead><tr style='font-size:15px; text-align:center; font-weight:bold; color:gray'  class='datagrid-header datagrid-header-row datagrid-row'>");
				 //添加列标题
				 items.push("<td style='width:80px;text-align:center' nowrap>序号</td>");
				 items.push("<td style='width:15%;text-align:center'>"+sortName+"</td>");
				 for(var i=0;i<categories.length;i++){
					 items.push("<td style='width:"+percent+"%;text-align:center;'>"+categories[i]+"</td>");
				 }
				 items.push("</tr><thead><tbody>");
				 for (var i=0;i<series.length-1;i++) {
					 var f = i % 2 == 1 ;
					 var s = f ? '<tr nowrap class="rowTrover  datagrid-row-alt datagrid-row">' : '<tr class="rowTrover datagrid-row">';
					 //添加列
					 items.push(s+"<td nowrap class='task-title-sp' style='width: 3%;text-align:center;color:#666'>"+(i+1)+"</td>");
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
		FirstPageTables.show();
	});
	</script>
</head>
<style>
	.auditwtTable td{
		border-width:0 1px 1px 0;
		border-style: dotted;
		border-color:#ccc;
	}
	.auditwtTable{
		width:80%;height:100%;margin-left:10%;

	}
	.rowTrover:hover{
		background-color:rgba(170, 227, 250, 1);
	}
</style>
<body>
<div>
	<div>
		<div id="riskDistributionEcharts" style="height: 500px;width:80%;margin-left:10%"></div>
	</div>
	<div>
		<table id="problemTrendTable" class="auditwtTable"  cellspacing="0" cellpadding="0"   >

		</table>
	</div>
</div>
</body>
</html>