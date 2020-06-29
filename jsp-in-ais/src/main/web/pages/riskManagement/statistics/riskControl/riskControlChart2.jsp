<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>风险管控图</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css" />
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
	<script src="/ais/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/moment.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/fullcalendar/lang/zh-cn.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/jqtip/jquery.qtip.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/scripts/app.min.js" type="text/javascript"></script> 

	<script type="text/javascript">
	var FirstPageTables = function(){
	    return {
	    	show:function() {
			  	  var myCharts1 = echarts.init(document.getElementById("riskControlEcharts"));
		            $.ajaxSettings.async = false;

		            var series = [];
		            var legend = [];
		            $.getJSON('/ais/riskManagement/statistics/riskControl/controlChartSearch.action?dept=<%=request.getParameter("dept")%>&year=<%=request.getParameter("year")%>',{},function(json){
		            	if(json!=null) {
		                legend = json.legend;
		                series = json.series;
		            	}
		            });
		          var option1 = {
		        		  title: {
		        			  text: '风险管控统计图',
		        			  x: 'center',
		        			  y: 'top'
		        		  },
		        		  tooltip : {
		  	                  trigger: 'item',
		  	                  formatter: "{a} <br/>{b} : {c} ({d}%)"
		  	                },
			  	          legend: {
			  	               orient: 'horizontal',
			  	               data: legend,
			  	               y:'45px'
			  	             },	
		  	             color:['#50acc4','#7f66a0', '#9bb95f'],
		  	             toolbox: {
		  	        	　　	 show: true,
		  	        	　          feature: {
		  	        	　　　　saveAsImage: {
		  	        	　　　　show:true,
		  	        	 	  name:'风险管控统计图',
		  	        	　　　　excludeComponents :['toolbox'],
		  	        	　　　　pixelRatio: 2
		  	        	　　　　}
		  	        	　　}
		  	        	 },
			  	         series : series
		  	     };
		  	     myCharts1.setOption(option1);
		    }
	    }
	}();
	$(document).ready(function(){
		FirstPageTables.show();
	});
	</script>
</head>
	<body>
		<div id="riskControlEcharts" style="height: 400px;width:100%;"></div>		
	</div>
</body>
</html>