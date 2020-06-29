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
<%--    <script type="text/javascript" src="<%=request.getContextPath()%>/Leadershipinquiry/map/js/echarts-all.js"></script>--%>
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
        .layui-col-md2{
            width: 16.4%;
        }

        .block-info-title1 {
            color: #333;
            font-weight: bold;
            font-size:15px;
            padding-left:10px;
            height:27px;
            line-height:27px;
            cursor:pointer;
        }
    </style>

    <script>
        function reloadResize() {
            g_indexlayout.newresize();
        }
    </script>
</head>
<body style="background-color: white; overflow: hidden;"  onresize="reloadResize();">
<div class="decision">
    <div class="mainContainer">
        <div class="topContainer" style="width: 98%">
            <div style="display: none;">
                <input id="tjfw" class="easyui-combotree" type="hidden"/>
                <input id="tjnd" class="easyui-combobox" type="hidden"/>
            </div>

            <div class="groupBg1 groupPadding " title="计划数量" onclick="goTabWithOption('计划数量')">
                <div class="groupBg1_logo groupLogo"></div>
                <span class="groupText"><label title="计划数量">计划总数(个)</label></span>
                <span class="groupData" id="planCount" >0</span>
            </div>
            <div class="groupBg2 groupPadding" title="项目数量" onclick="goTabWithOption('项目数量')">
                <div class="groupBg2_logo groupLogo"></div>
                <span class="groupText">已启动项目数(个)</span>
                <span class="groupData" id="projectCount" >0</span>
            </div>
            <div class="groupBg3 groupPadding" title="底稿数量" onclick="goTabWithOption('底稿')">
                <div class="groupBg3_logo groupLogo"></div>
                <span class="groupText">登记底稿总数(个)</span>
                <span class="groupData" id="manuCount" >0</span>
            </div>
            <div class="groupBg4 groupPadding" title="问题数量" onclick="goTabWithOption('问题')">
                <div class="groupBg4_logo groupLogo"></div>
                <span class="groupText">本年新增问题数(个)</span>
                <span class="groupData" id="problemCount" >0</span>
            </div>
            <div class="groupBg5 groupPadding" title="已整改问题数量" onclick="goTabWithOption('已整改')">
                <div class="groupBg5_logo groupLogo"></div>
                <span class="groupText">本年问题整改数(个)</span>
                <span class="groupData" id="correctedProblemCount" >0</span>
            </div>
            <div class="groupBg6 groupPadding" title="报告数量" onclick="goTabWithOption('报告')">
                <div class="groupBg6_logo groupLogo"></div>
                <span class="groupText">报告定稿数(个)</span>
                <span class="groupData" id="reportCount" >0</span>
            </div>
        </div>
        <div style="width: 100%;" class="packContainer">
            <div class="block-Container" style="float: left;">
                <div class="block-info">
                       <div class="rowTitleWrap barBg">
                           <span class="rowTitle">
                               <a class="block-info-title1" style="text-decoration:underline;" onclick="goTabWithOption('计划数量')">计划执行</a>
                           </span>
                           <span class="rowTitleLogo"></span>
                       </div>
                    <div id="jhzxcanvas" style="margin-top: 26.4px">
                    </div>
                </div>
                <div class="block-info">
                        <div class="rowTitleWrap barBg">
                           <span class="rowTitle">
                               <a class="block-info-title1" style="text-decoration:underline;" onclick="goTabWithOption('项目数量排名')">项目数量排名</a>
                               <img id="xmslsort" class="sort-desc sort-image" style="cursor: pointer;" title="排序" onclick="javascript:xmslSort();" src="../../images/decline.png"/>
                           </span>
                            <span class="rowTitleLogo"></span>
                        </div>
                    <div id="xmpmsl">
                    </div>
                </div>
            </div>
            <div class="secondContainer" id="secondContainer" style="background-color: #FFF; width: 800px; float: left; padding-bottom: 3px; position: relative;">
                <div class="mainContent" id="mapcanvas" style="float: left;">
                </div>
                <div id="orgsdiv" class="orgsdiv-new">
                    <div class="item4orgsdiv">
                        <a style="color: #8b4513 !important"
                                                 href="javascript:clickOrgLeaderinquiry('全系统情况', '0')">全系统情况</a>
                    </div>
                </div>
            </div>
            <div class="block-Container" style="float: right;margin-right: 42px;">
                <div class="block-info">
                        <div class="rowTitleWrap barBg">
                           <span class="rowTitle"><a class="block-info-title1" style="text-decoration:underline;" onclick="goTabWithOption('问题数排名')">问题数排名</a>
                            <img id="wtssort" class="sort-desc sort-image" style="cursor: pointer;" title="排序" onclick="javascript:wtsSort();" src="../../images/decline.png"/>
                           </span>
                            <span class="rowTitleLogo"></span>
                        </div>
                    <div id="wtsl">
                    </div>
                </div>
                <div class="block-info">
                        <div class="rowTitleWrap barBg">
                           <span class="rowTitle"><a class="block-info-title1" style="text-decoration:underline;" onclick="goTabWithOption('整改率排名')">整改率排名</a>
                            <img id="zglsort" class="sort-desc sort-image" style="cursor: pointer;" title="排序" onclick="javascript:zglSort();" src="../../images/decline.png"/>
                           </span>
                            <span class="rowTitleLogo"></span>
                        </div>
                    <div id="zglpm">
                    </div>
                </div>
            </div>
        </div>
        <div style="width:98%; clear: both; position: fixed; bottom: 5px;text-align:center;">

            <a onclick="goTabWithOption('审计人才')">
                <div class="bottom-info" title="审计人才数量">
                    <span class="bottom-info-logo1 bottom-info-logo-cfg"></span>
                    <span class="bottom-info-text">审计人才</span>
                    <span class="bottom-info-number" id="memberCount"></span>
                </div>
            </a>

            <a onclick="goTabWithOption('审计机构')">
                <div class="bottom-info" title="审计机构数量">
                    <span class="bottom-info-logo2 bottom-info-logo-cfg"></span>
                    <span class="bottom-info-text">审计机构</span>
                    <span class="bottom-info-number" id="auditOrganizationCount"></span>
                </div>
            </a>

            <a onclick="goTabWithOption('被审计单位')">
                <div class="bottom-info" title="被审计单位数量">
                    <span class="bottom-info-logo3 bottom-info-logo-cfg"></span>
                    <span class="bottom-info-text">被审计单位</span>
                    <span class="bottom-info-number" id="auditObjectCount"></span>
                </div>
            </a>

            <a onclick="goTabWithOption('审计事项')">
                <div class="bottom-info" title="审计事项数量">
                    <span class="bottom-info-logo4 bottom-info-logo-cfg"></span>
                    <span class="bottom-info-text">审计事项</span>
                    <span class="bottom-info-number" id="taskCount"></span>
                </div>
            </a>

            <a onclick="goTabWithOption('审计方案')">
                <div class="bottom-info" title="审计方案数量">
                    <span class="bottom-info-logo5 bottom-info-logo-cfg"></span>
                    <span class="bottom-info-text">审计方案</span>
                    <span class="bottom-info-number"  id="audTemplateCount"></span>
                </div>
            </a>

            <a onclick="goTabWithOption('审计案例')">
                <div class="bottom-info" title="审计案例数量">
                    <span class="bottom-info-logo6 bottom-info-logo-cfg"></span>
                    <span class="bottom-info-text">审计案例</span>
                    <span class="bottom-info-number" id="countSjal"></span>
                </div>
            </a>

        </div>
    </div>
</div>
<script>
    function doSearch() {
        new Q().then(countStartProjectWithCity).then(buildMap2).then(summary).then(function (q) {
            // 其他补充查询
            g_indexlayout.newresize();
            q.next();
        }).start();
    }

    layui.use('element', function () {
        var $ = layui.jquery;
        window.layer = layui.layer;
        window.$ = $;
        var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
        var w = $(window).width();
        var cw = w - 520;
        var h = $(window).height();
        $("#secondContainer").width(cw);
        $("#secondContainer").height(h - 210);
        doSearch();
    });
</script>
</body>
</html>