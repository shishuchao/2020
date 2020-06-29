<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>缺陷折线统计图</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<script src="/ais/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		FirstPageTables.show('${param.from}','${param.evaluateYear}','${param.evaDeptCode}');
	});
	var FirstPageTables = function(){
	    return {
	    	show:function(from,year,evaDeptCode) {
			  	  var resultCharts = echarts.init(document.getElementById("resultCharts"));
                	resultCharts.showLoading({
						text:'数据加载中，请稍后...'
					});
		            $.ajaxSettings.async = false;
		            var series = [];
		            var legend = [];
		            var category = [];
                	var table;
		            if(from == 'byType'){
		                table = $('#typeTable', window.parent.document);
                    }else{
                        table = $('#levelTable', window.parent.document);
                    }

					var tHead = $(table).find("thead");
					var tBody = $(table).find("tbody");
					tHead.html('');
					tBody.html('');
		           $.getJSON('<%=request.getContextPath()%>/intctet/statisticaAnalysis/showLineChart.action',{'from':from,'evaluateYear':year,'evaDeptCode':evaDeptCode},function(json){
		                legend = json.legend;
		                series = json.series;
                       	category = json.category;

                       if(legend.length > 0){
                           var tr = $('<tr>');
                           tr.append($('<td>',{'style':'width:'+(100/(legend.length+1))+'%;text-align:center','class':'EditHead'}).append('业务流程'));
                           for(var index in legend){
                               tr.append($('<td>',{'style':'width:'+(100/(legend.length+1))+'%;text-align:center','class':'EditHead'}).append(legend[index]));
                           }
                           tHead.append(tr);
                       }
                       if (category&&category.length > 0) {

                           for(var i in category){
                               //新建一行
                               var newTr = $('<tr>');
                               newTr.append($('<td>',{'style':'text-align:center','class':'editTd'}).append(category[i]));
                               for(var m in series){
                                   newTr.append($('<td>',{'style':'text-align:center','class':'editTd'}).append(series[m].data[i]));
							   }
                               tBody.append(newTr);
						   }

                       }
		            });
					var option = {
                        title : {
                            text: from == 'byType'?'缺陷统计（按类型）':'缺陷统计（按等级）',
                            x:'center'
                        },
						tooltip: {
							trigger: 'axis',
							axisPointer: {
								type: 'cross',
								crossStyle: {
									color: '#999'
								}
							}
						},
						toolbox: {
							feature: {
								magicType: {show: true, type: ['line', 'bar']},
								restore: {show: true},
								saveAsImage: {show: true}
							}
						},
						legend: {
                            orient: 'vertical',
                            left: 'left',
							data:legend
						},
						xAxis: [
							{
								type: 'category',
								data: category,
								axisPointer: {
									type: 'shadow'
								}
							}
						],
						yAxis: [
							{
								type: 'value',
								name: '数量'
							}
						],
						series: series
					};

		          resultCharts.setOption(option);
				  resultCharts.hideLoading();
					window.onresize = function () {
						//重置容器高宽
						resultCharts.resize();
					};
		    }
	    }
	}();
	</script>
</head>
	<body>
		<div id="resultCharts" style="height: 400px;width:100%;"></div>		
	</div>
</body>
</html>