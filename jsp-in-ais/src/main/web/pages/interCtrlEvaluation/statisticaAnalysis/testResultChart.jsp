<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>测试结果机构统计图</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<script src="/ais/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<script src="/ais/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		FirstPageTables.show('${param.year}','${param.evaluatedUnitId}');
	});
	var FirstPageTables = function(){
	    return {
	    	show:function(year,evaluatedUnitId) {
				var resultCharts = echarts.init(document.getElementById("resultCharts"));
                resultCharts.showLoading({
                    text:'数据加载中，请稍后...'
                });
				var table = $('#mTable', window.parent.document);
				var tHead = $(table).find("thead");
				var tBody = $(table).find("tbody");
				tHead.html('');
				tBody.html('');
				$.ajaxSettings.async = false;
                var series;
                var legend = [];
                $.getJSON('<%=request.getContextPath()%>/intctet/statisticaAnalysis/showChart.action',{'year':year,'evaluatedUnitId':evaluatedUnitId},function(json){
                    legend = json.legend;
                    series = json.series;
                    if(legend.length > 0){
                        var tr = $('<tr>');
                        for(var index in legend){
                            tr.append($('<td>',{'style':'width:'+(100/(legend.length+1))+'%;text-align:center','class':'EditHead'}).append(legend[index]));
						}
                        tr.append($('<td>',{'style':'width:'+(100/(legend.length+1))+'%;text-align:center','class':'EditHead'}).append('合计'));
                        tHead.append(tr);
					}
                    if (series&&series.data.length > 0) {

                        //新建一行
                        var newTr = $('<tr>');
                        var total = 0;
                        for(var idx in series.data){
                            newTr.append($('<td>',{'style':'text-align:center','class':'editTd'}).append(series.data[idx].value));
                            total = total+series.data[idx].value;
                        }
                        newTr.append($('<td>',{'style':'text-align:center','class':'editTd'}).append(total));
                        tBody.append(newTr);
                    }
                });
                var option = {
                    title : {
                        text: '测试结果结构统计图',
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                        data: legend
                    },
                    series : series,
                    color:['#50acc4','#7f66a0', '#9bb95f', '#f5954f', '#5282bb','#be5150',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']
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