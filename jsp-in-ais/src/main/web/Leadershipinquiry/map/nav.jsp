<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>决策支持系统全景展示</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Leadershipinquiry/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Leadershipinquiry/css/main.css" media="all">
    <script src="<%=request.getContextPath()%>/Leadershipinquiry/layui/layui.all.js" charset="utf-8"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/Leadershipinquiry/map/js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/Leadershipinquiry/map/js/echarts.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/Leadershipinquiry/map/js/map/china.js"></script>
    <script src="<%=request.getContextPath()%>/Leadershipinquiry/js/Q.js" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/resources/js/common.js" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/Leadershipinquiry/js/search.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
    <link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <style>
        #china-map {
            width: 1000px;
            height: 1000px;
            margin: auto;
        }
    </style>
</head>

<body>

<div class="mainContainer" style="margin-left: 8px;">
    <div class="topContainer">
        <div style="display: none;">
            <input id="tjfw" class="easyui-combotree" type="hidden"/>
            <input id="tjnd" class="easyui-combobox" type="hidden"/>
        </div>
        <div class="layui-col-md2" style="background: #DA542E;">
            <span class="firstRowTextWord">计划</span>
            <span class="firstRowTextNum" id="planCount" onclick="goTabWithOption('计划数量')"></span>
        </div>
        <div class="layui-col-md2" style="background: #2D3740;">
            <span class="firstRowTextWord">项目</span>
            <span class="firstRowTextNum" id="projectCount" onclick="goTabWithOption('项目进度')"></span>
        </div>
        <div class="layui-col-md2" style="background: #2AB3DD;">
            <span class="firstRowTextWord">底稿</span>
            <span class="firstRowTextNum" id="manuCount" onclick="goTabWithOption('底稿')"></span>
        </div>
        <div class="layui-col-md2" style="background: #26B679;">
            <span class="firstRowTextWord">问题</span>
            <span class="firstRowTextNum" id="problemCount" onclick="goTabWithOption('问题')"></span>
        </div>
        <div class="layui-col-md2" style="background: #FEB848;">
            <span class="firstRowTextWord">已整改</span>
            <span class="firstRowTextNum" id="correctedProblemCount" onclick="goTabWithOption('已整改')"></span>
        </div>
        <div class="layui-col-md2" style="background: #3F95C4;">
            <span class="firstRowTextWord">报告</span>
            <span class="firstRowTextNum" id="reportCount" onclick="goTabWithOption('报告')">0</span>
        </div>
    </div>
    <!--
    <div style="background-color: #F2F2F2; padding: 4px 4px;">
        <div class="secondContainer" id="secondContainer"
             style="background-color: #FFF; width: 1000px; float: left; padding-bottom: 3px;">
            <div class="mainContent" id="china-map" style="float: left; margin-left: 5px;">
            </div>
        </div>
    </div>
    <div class="rightbottom-block">
        <div style="float:left; width: 100px;">
            <div class="main-block-map" id="jhjd" onclick="goTabWithOption(0)">
                <div class="yw-label">审计机构</div>
                <div class="yw-number-map" id="auditOrganizationCount"></div>
            </div>
            <div class="main-block-map" id="zbjd" onclick="goTabWithOption(0)">
                <div class="yw-label">审计人员</div>
                <div class="yw-number-map" id="memberCount" style="color: red;"></div>
            </div>
            <div class="main-block-map" id="ssjd" onclick="goTabWithOption(0)">
                <div class="yw-label">被审单位</div>
                <div class="yw-number-map" id="auditObjectCount" style="color: blue;"></div>
            </div>
        </div>
    </div>
    <div class="switchtitle" id="switchtitle">全系统审计情况</div>
    <div id="orgsdiv" class="orgsdiv">
        <div class="item4orgsdiv"><a style="color: #8b4513 !important"
                                     href="javascript:clickOrgLeaderinquiry('全系统情况', '0')">全系统情况</a></div>
    </div>
    <div class="mask">
        <img src="<%=request.getContextPath()%>/images/switcher.png" style="cursor: pointer"
             onclick="javascript: switchMapStyle();" title="切换地图显示模式"/>
    </div>
</div>
    -->
    <div style="width: 100%;" class="packContainer">
        <div class="block-Container" style="float: left;">
            <div class="block-info" id="jhzx">
                <div class="block-info-title"><a class="block-info-title" style="text-decoration:underline;" onclick="goTabWithOption('计划执行')">计划执行</a></div>
                <div id="" style="height: 350px;">
                </div>
            </div>
            <div class="block-info">
                <div class="block-info-title">
                    <span>
                        <a class="block-info-title" style="text-decoration:underline;" onclick="goTabWithOption('项目数量排名')">项目数量排名</a>
                        <img id="xmslsort" class="sort-desc" style="cursor: pointer;" title="排序" onclick="javascript:xmslSort();" src="../../images/decline.png"/>
                    </span>
                </div>
                <div id="xmpmsl" style="height: 350px;">
                </div>
            </div>
        </div>
        <div style="background-color: #FFF; padding: 4px 4px; float: left;">
            <div class="secondContainer" id="secondContainer"
                 style="background-color: #FFF; width: 800px; float: left; padding-bottom: 3px; position: relative;">
                <div class="mainContent" id="china-map" style="float: left; margin-left: 5px;">
                </div>
                <div class="switchtitle-new" id="switchtitle-new">全系统审计情况</div>
                <div id="orgsdiv" class="orgsdiv-new">
                    <div class="item4orgsdiv"><a style="color: #8b4513 !important"
                                                 href="javascript:clickOrgLeaderinquiry('全系统情况', '0')">全系统情况</a></div>
                </div>
                <div class="mask-new"><img src="<%=request.getContextPath()%>/images/switch.png"
                                           style="cursor: pointer; float: right"
                                           onclick="javascript:switchMapStyle();" title="切换地图显示模式"/></div>
            </div>
        </div>
        <div class="block-Container" style="float: right;margin-right: 2px;">
            <div class="block-info">
                <div class="block-info-title">
                    <span>
                        <a class="block-info-title" style="text-decoration:underline;" onclick="goTabWithOption('问题数排名')">问题数排名</a>
                        <img id="wtssort" class="sort-desc" style="cursor: pointer;" title="排序" onclick="javascript:wtsSort();" src="../../images/decline.png"/>
                    </span>
                </div>
                <div id="wtsl" style="height: 350px;">
                </div>
            </div>
            <div class="block-info">
                <div class="block-info-title">
                    <span>
                        <a class="block-info-title" style="text-decoration:underline;" onclick="goTabWithOption('整改率排名')">整改率排名</a>
                        <img id="zglsort" class="sort-desc" style="cursor: pointer;" title="排序" onclick="javascript:zglSort();" src="../../images/decline.png"/>
                    </span>
                </div>
                <div id="zglpm" style="height: 350px;">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 100%; height: 40px; clear: both; position: fixed; bottom: 5px;">
        <table style="width: inherit">
            <tr>
                <td>
                    <a onclick="goTabWithOption('审计人才')"><div class="bottom-info" >审计人才&nbsp;<span class="bottom-info-number" id="memberCount"></span></div></a>
                </td>
                <td>
                    <a onclick="goTabWithOption('审计机构')"><div class="bottom-info" >审计机构&nbsp;<span class="bottom-info-number" id="auditOrganizationCount"></span></div></a>
                </td>
                <td>
                    <a onclick="goTabWithOption('被审计单位')"><div class="bottom-info" >被审计单位&nbsp;<span class="bottom-info-number" id="auditObjectCount"></span></div></a>
                </td>
                <td>
                    <a onclick="goTabWithOption('审计事项')"><div class="bottom-info" >审计事项&nbsp;<span class="bottom-info-number" id="taskCount"></span></div></a>
                </td>
                <td>
                    <a onclick="goTabWithOption('审计方案')"><div class="bottom-info" >审计方案&nbsp;<span class="bottom-info-number" id="audTemplateCount"></span></div></a>
                </td>
                <td>
                    <a onclick="goTabWithOption('审计案例')"><div class="bottom-info" >审计案例&nbsp;<span class="bottom-info-number" id="countSjal"></span></div></a>
                </td>
            </tr>
        </table>
    </div>
</div>
</div>
<script>
    var titleFormatter = function (params) {
        return params.name;
    };
    var contentFormatter = function (params) {
        var label = params.name;
        return label + ' ' + ' 审计项目 ' + params.value[2];
    };
    var currentDept = null;

    function doSearch() {
        new Q().then(countStartProjectWithCity).then(function (q) {
            var w = $("#secondContainer").width() - 60;
            var h = $(window).height() - 160; // $(window).height() - 100
            var mapChart = buildCharts('china-map', w, h);
            var mapData = geoData.features.map(function (item) {
                return {
                    name: item.properties.name,
                    value: item.properties.childNum,
                    cp: item.properties.cp,
                }
            });
            var data = q.data;
            q.data.mapSearch = true;
            var max = 100, min = 0, maxSize4Pin = 80, minSize4Pin = 10;
            g_MapMetaData.buildMapData(data);
            var option = {
                tooltip: {
                    trigger: 'item',
                    formatter: contentFormatter
                },
                geo: {
                    show: true,
                    map: 'china',
                    label: {
                        normal: {
                            textStyle: {
                                fontSize: 16,
                                color: "#8b4513"
                            },
                            show: true
                        },
                        emphasis: {
                            textStyle: {
                                fontSize: 16
                            },
                            show: true
                        }
                    },
                    roam: false,
                    itemStyle: {
                        normal: {
                            areaColor: '#e0ffff',
                            borderColor: '#325f82'
                        },
                        emphasis: {
                            areaColor: '#2B91B7'
                        }
                    },
                    zoom: 1.2
                },
                series: [
                    {
                        name: '',
                        type: 'scatter',
                        coordinateSystem: 'geo',
                        symbol: 'pin',
                        symbolSize: function (val) {
                            var a = (maxSize4Pin - minSize4Pin) / (max - min);
                            var b = maxSize4Pin - a * max;
                            return a * val[2] + b + 10;
                        },
                        label: {
                            normal: {
                                show: false,
                                textStyle: {
                                    color: '#00FF00',
                                    fontSize: 9
                                },
                                formatter: titleFormatter
                            },
                            emphasis: {
                                show: false,
                                color: "#00FF00",
                                formatter: titleFormatter,
                                position: 'top'
                            }
                        },
                        itemStyle: {
                            normal: {
                                color: '#F62157' // 标志颜色
                            }
                        },
                        zlevel: 6,
                        data: g_MapMetaData.buildPointMapData(data, mapData)
                    }
                ]
            };
            mapChart.setOption(option);
            mapChart.on('click', function (params) {
                if (params.componentType == "series") {
                    if (currentDept == params.data.dept) {
                        go2OrgLeaderinquiry(params.data.name, params.data.dept);
                    } else {
                        clickOrgLeaderinquiry(params.data.name, params.data.dept);
                        currentDept = params.data.dept;
                    }
                }
            });
            g_indexlayout.newresize();
            if (q) q.next();
        }).then(summary).start();
    }

    layui.use('element', function () {
        var $ = layui.jquery;
        window.layer = layui.layer;
        window.$ = $;
        var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
        // var w = $(window).width();
        // var cw = w - 20;
        var w = $(window).width();
        var cw = w - 520;
        var h = $(window).height();
        $("#secondContainer").width(cw);
        $("#secondContainer").height(h - 210);
        $("#secondContainer").width(cw);
        doSearch();
    });
</script>
</body>
</html>