/**
 * Created by xujun on 2017/2/15.
 */
var DecisionFirstPage = function(){

    return {

        problemChart:function(){
            var chart = document.getElementById('problemChart');
            var echart = echarts.init(chart);

            echart.showLoading({
                text:'数据加载中，请稍后...'
            });
            $.ajaxSettings.async = false;

            var series = [];
            var legend = [];
            $.getJSON(contextPath+'/proledger/problem/problemStatistics.action',{},function(json){
                legend = json.legend;
                series = json.series;
            });

            var options = {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'horizontal',
                    data: legend
                },
                series : series,
                color:['#50acc4','#7f66a0', '#9bb95f', '#f5954f', '#5282bb','#be5150',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']
            };

            echart.setOption(options);
            echart.hideLoading();
            window.onresize = function () {
                //重置容器高宽
                echart.resize();
            };
        },
        problemTypeChart:function(){
            var chart = document.getElementById('problemTypeChart');
            var echart = echarts.init(chart);
            echart.showLoading({
                text:'数据加载中，请稍后...'
            });
            $.ajaxSettings.async = false;

            var series = [];
            var legend = [];
            $.getJSON(contextPath+'/proledger/problem/problemTypeStatistics.action',{},function(json){
                legend = json.legend;
                series = json.series;
            });

            var options = {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'horizontal',
                    data: legend
                },
                series : series,
                color:['#50acc4','#7f66a0', '#9bb95f', '#f5954f', '#5282bb','#be5150',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']
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

function openTarget2online(formId, stage){
    if(stage == 'archives'){
        window.parent.goOther(formId,stage);
        return false;
    }
    var udswin = window.open(
        contextPath+'/project/prepare/projectIndex.action?crudId='
        + formId + '&stage=' + stage, '',
        'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
    udswin.moveTo(0, 0);
    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
}

$(document).ready(function(){
    DecisionFirstPage.problemTypeChart();
    DecisionFirstPage.problemChart();

    $('#problem_type .portlet-title a[id="problem_type_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        DecisionFirstPage.problemTypeChart();
    });
    $('#problem_protype .portlet-title a[id="problem_protype_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        DecisionFirstPage.problemChart();
    });
});