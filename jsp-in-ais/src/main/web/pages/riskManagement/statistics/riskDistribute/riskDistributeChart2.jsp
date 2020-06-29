<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>风险分布图</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<link href="/ais/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="/ais/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="/ais/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
	<link href="/ais/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.css" rel="stylesheet" type="text/css" />
	<link href="/ais/index/assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
	<link href="/ais/index/assets/global/plugins/jqtip/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
	<link href="/ais/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="/ais/index/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
	<style>
		.longTD{
			overflow:hidden;
			white-space:nowrap;
			text-overflow:ellipsis;
		}
	</style>
		<script src="/ais/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/moment.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/fullcalendar/lang/zh-cn.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/jqtip/jquery.qtip.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/scripts/app.min.js" type="text/javascript"></script>
	<script type="text/javascript">
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
	            $.getJSON('/ais/riskManagement/statistics/riskDistribute/distributeChartSearch.action?year=<%=request.getParameter("year")%>&dept=<%=request.getParameter("dept")%>',{},function(json){
	                categories = json.category;
	                legend = json.legend;
	                series = json.series;
	            });

	            var options = {
		        	title: {
		        		text: '风险分布图(按风险大类)',
		        		x: 'center',
		        		y: 'top'
		        		},
	                tooltip : {
	                    trigger: 'axis',
	                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	                        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	                    }
	                },
	                legend: {
	                    selectedMode:false,
	                    y: '35px',
	                    data: legend
	                },
	                calculable : true,
	                xAxis : [
	                    {
	                        type : 'category',
	                        data: categories  
	                    }
	                ],
	                yAxis : [
	                    {
	                        type : 'value',
	                        boundaryGap: [0, 0.1]
	                    }
	                ],
	  	            toolbox: {
	  	        	　　	  show: true,
	  	        	　        　feature: {
	  	        	　　　　saveAsImage: {
	  	        	　　　　show:true,
	  	        	　　　　excludeComponents :['toolbox'],
	  	        	　　　　pixelRatio: 2
	  	        	　　　　}
	  	        	　　}
	  	        	 },
	                series : series,
	                color:['red','yellow', 'green', 'grey']
	            };

	            echart.setOption(options);
	            echart.hideLoading();
	            window.onresize = function () {
	                //重置容器高宽
	                echart.resize();
	            };
	        }
		}
	}();
	
	$(document).ready(function(){
		FirstPageTables.show();
	});
	</script>
</head>
<body>
<div>
	<div id="riskDistributionEcharts" style="height: 400px;width:100%;"></div>
</div>
</body>
</html>