/*
* 决策支持首页展示各种ajax和echarts的调用及简单封装
 */

var base_url = "/ais/Leadershipinquiry";
var persionListUrl = "/ais/mng/examproject/members/audProjectMembersInfo/toEmployeeManageMain.action?querySource=grid&page=1&rows=500";
var persionListDatas;
var curYear = '2020';
var overViewMapUrl = "/ais/Leadershipinquiry/overviewChart.action?tjnd=" + curYear ;
var xmpmUrl = "/ais/Leadershipinquiry/projectChart.action?tjnd=" + curYear + "&type=org";
var wtsUrl = "/ais/Leadershipinquiry/problemChart.action?tjnd=" + curYear + "&type=wtd";
var zglUrl = "/ais/Leadershipinquiry/problemChangeChart.action?tjnd=" + curYear + "&type=obj";

var flag = false;


var orgIds = "";
var auditIds = "";

var isOldVersion = false; // 是否启用旧风格

var isSmallScreen = false; //判断屏幕大小，适配表格显示10行

var byId = function (id) {
    return document.getElementById(id);
};

var getCurrentYear = function () {
    return new Date().getFullYear();
};

// Index Layout 相关
function IndexLayout() {
}

IndexLayout.prototype.resize = function (fn) {
    var w = $(window).width();
    var h = $(window).height();
    /**
     * v-layout: 30 + 80 + other
     * h-layout: other + 420
     * 请注意，这里有好多 magic-number 都是依靠F12调试出来的~_~
     */
    this.containerHeight = (h - 200); // 下部的高度，除去上面的数组栏目
    this.containerWidth = (w - 20); // 内容宽度
    $('#secondContainer').width(w * 0.67);
    $('.right').width(w * 0.30); // 右侧的滚动内容的宽度固定 415
    $('.right').height($('#secondContainer').height());


    $('.block-right').height((this.containerHeight - 40) / 2)

    //设置在审项目的自适应
    $('#right_zsxmmc').width($('.right').width() * 0.68);
    $('#right_zsxmjd').width($('.right').width() * 0.29);
    $('#zsxmcontent').width($('.right').width());
    $("#ryztcontent").width($('.right').width());

    $('#ryztxm').width($('#ryztcontent').width() * 0.37);
    $('#ryztjh').width($('#ryztcontent').width() * 0.15);
    $('#ryztzs').width($('#ryztcontent').width() * 0.15);
    $('#ryztys').width($('#ryztcontent').width() * 0.15);
    $('#ryzthj').width($('#ryztcontent').width() * 0.15);


    this.scollHeight = (this.containerHeight - 84) / 2;
    this.canvasWidth = w - 400; // 画布最大宽度
    this.canvasHeight = this.containerHeight - 80;
    $('#secondContainer').height(this.containerHeight);
    $('#secondContainerContent').height(this.containerHeight - 80);

    $('#switchtitle').css('left', this.containerWidth / 2 - 160);
    $('#switchtitle').show();

    $('#secondContainerContent .mainContent').width(w * 0.67 - 150);
    $('#secondContainerContent .mainContent').height($('#secondContainerContent').height());

    var m = ($('#secondContainerContent .mainContent').width() - 5) / 2;
    if (echarts.getInstanceByDom($('#wclcanvas')[0]) != undefined) {
        $('#wclcanvas').width(m);
        $('#wclcanvas').height($('#secondContainerContent .mainContent').height());
        echarts.getInstanceByDom($('#wclcanvas')[0]).resize();
    }

    if (echarts.getInstanceByDom($('#xmfbcanvas')[0]) != undefined) {
        $('#xmfbcanvas').width(m);
        $('#xmfbcanvas').height($('#secondContainerContent .mainContent').height());
        echarts.getInstanceByDom($('#xmfbcanvas')[0]).resize();
    }


    if (echarts.getInstanceByDom($('#wtzgqkbcanvas')[0]) != undefined) {
        $('#wtzgqkbcanvas').width($('#secondContainerContent').width());
        $('#wtzgqkbcanvas').height($('#secondContainerContent').height() - 20);
        echarts.getInstanceByDom($('#wtzgqkbcanvas')[0]).resize();
    }

    if (echarts.getInstanceByDom($('#xmpmcanvas')[0]) != undefined) {
        $('#xmpmcanvas').width($('#secondContainerContent').width());
        $('#xmpmcanvas').height($('#secondContainerContent').height());
        echarts.getInstanceByDom($('#xmpmcanvas')[0]).resize();
    }

    if (echarts.getInstanceByDom($('#xmtqbcanvas')[0]) != undefined) {
        $('#xmtqbcanvas').width($('#secondContainerContent').width());
        $('#xmtqbcanvas').height($('#secondContainerContent').height() - 20);
        echarts.getInstanceByDom($('#xmtqbcanvas')[0]).resize();
    }

    if (echarts.getInstanceByDom($('#wtpmcanvas')[0]) != undefined) {
        $('#wtpmcanvas').width($('#secondContainerContent').width());
        $('#wtpmcanvas').height($('#secondContainerContent').height());
        echarts.getInstanceByDom($('#wtpmcanvas')[0]).resize();
    }


    if (echarts.getInstanceByDom($('#wttqbcanvas')[0]) != undefined) {
        $('#wttqbcanvas').width($('#secondContainerContent').width());
        $('#wttqbcanvas').height($('#secondContainerContent').height() - 20);
        echarts.getInstanceByDom($('#wttqbcanvas')[0]).resize();
    }

    //基础信息的宽度
    $("#jcxxDiv").width(w);
    //调整大小时在审项目和人员状态的自适应
    $(".ryztspliceitem").width($('#ryztxm').width());
    $(".ryztspliceitem-center").width($('#ryztjh').width());
    $(".zsxmmc").width($('#right_zsxmmc').width());
    $(".zsxmmc-center").width($('#right_zsxmjd').width());


    $(".main-block").height(($("#secondContainerContent").height() - 25) / 6)


};

IndexLayout.prototype.newresize = function () {
    var w = $(window).width();
    var h = $(window).height() - 160;
    var biwidth = $(window).width() / 7;
    $(".bottom-info").width(biwidth);
    $(".packContainer").height(h);
    $(".block-info").height(h / 2 - 23);

    $("#wtsl").height($(".block-info").height() - 30);
    $("#zglpm").height($(".block-info").height() - 30);
    $("#xmpmsl").height($(".block-info").height() - 30);
    $("#jhzxcanvas").height($(".block-info").height() - 30);


    var blockWidth = $(".layui-col-md2").width();
    $(".block-Container").width(blockWidth);
    $("#secondContainer").width($(window).width() - blockWidth * 2 - 1025);

    isSmallScreen = $(".block-info").height() < 250;

    if (echarts.getInstanceByDom($('#mapcanvas')[0]) != undefined) {
        $('#mapcanvas').width(w - $('.block-Container').width() * 2 - 20);
        $('#mapcanvas').height($('.packContainer').height() - 20);
        echarts.getInstanceByDom($('#mapcanvas')[0]).resize();
    }
};

var g_indexlayout = new IndexLayout();
// Layout End

// 初始化echarts
var buildCharts = function (eleId, width, height) {
    $("#" + eleId).width(width);
    $("#" + eleId).height(height);
    return echarts.init(byId(eleId));
};

var ScrollItemHeight = 20;

// --- 滚动相关 ---
function AutoScroll(eleId, mills) {
    this.element = $('#' + eleId);
    this.mills = mills || 3000;
    this.timehandle = null;
}

AutoScroll.prototype.autoScroll = function () {
    var self = this.element;
    self.animate({
        marginTop: "-" + ScrollItemHeight + "px"
    }, 1000, function () {
        self.css({marginTop: "0px"}).find(".loopitem:first").appendTo(self);
    });
};

AutoScroll.prototype.start = function () {
    var self = this;
    self.clear();
    self.timehandle = setInterval(function () {
        self.autoScroll();
    }, self.mills);
};

AutoScroll.prototype.clear = function () {
    if (this.timehandle) {
        clearTimeout(this.timehandle);
        this.timehandle = null;
    }
};

// --- 滚动相关 End ---

// 根据条件json创建url
function buildConditions(cond) {
    if (!cond) return "";
    var results = []
    for (var k in cond) {
        var v = cond[k];
        if (v && v != 'null') {
            results.push(k + '=' + encodeURIComponent(cond[k]));
        }
    }
    return results.join('&');
}

// 创建项目阶段的html片段
function buildSippetsHtml(caption, value, color) {
    var val = value || 0;
    if (color)
        return '<div class="yw-label">' + caption + '</div><div class="yw-number" style="color: ' + color + '">' + val + '</div>';
    return '<div class="yw-label">' + caption + '</div><div class="yw-number">' + val + '</div>';
}

// 前端计算计划阶段数量(前端计算方式简单一点)
function calcPlanStage(projectCount, countProjectStage) {
    if (projectCount == 0) return 0;
    return projectCount - ((countProjectStage["准备"] || 0) + (countProjectStage["整改"] || 0) + (countProjectStage["归档"] || 0) + (countProjectStage["实施"] || 0) + (countProjectStage["完成"] || 0));
}

// 项目总览
function overviewChart(q) {
    var selectedOrg;
    var selectedYear;
    var cond = q.data || condition;
    if ($("#tjnd").val() == undefined) {
        selectedYear = curYear;
    } else {
        selectedYear = $("#tjnd").combobox("getValue");
    }
    if (cond.tjfw != undefined && cond.tjfw != "") {
        selectedOrg = cond.tjfw;
    } else {
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
    }
    //var w = (g_indexlayout.canvasWidth - 160) / 2;
    var w = ($('#secondContainerContent .mainContent').width() - 5) / 2;
    var xmfbChart = buildCharts('xmfbcanvas', w, g_indexlayout.canvasHeight);
    var wclChart = buildCharts('wclcanvas', w, g_indexlayout.canvasHeight);
    var url = base_url + '/overviewChart.action?tjfw=' + selectedOrg + '&tjnd=' + selectedYear;
    $.get(url, function (data) {
        data = JSON.parse(data);
        var countProjectStage = data.countProjectStage;
        var findProjectTypeOverview = data.findProjectTypeOverview || [];
        var projectCount = q.data.projectCount;
        var planCount = q.data.planCount;

        if (!projectCount) projectCount = 0;

        if (countProjectStage["完"] == undefined) {
            countProjectStage["完"] = 0
        }
        if (countProjectStage["准"] == undefined) {
            countProjectStage["准"] = 0
        }
        if (countProjectStage["实"] == undefined) {
            countProjectStage["实"] = 0
        }
        if (countProjectStage["整"] == undefined) {
            countProjectStage["整"] = 0
        }
        if (countProjectStage["档"] == undefined) {
            countProjectStage["档"] = 0
        }

        $("#zbjd").remove();
        $("#ssjd").remove();
        $("#gdjd").remove();
        $("#wcjd").remove();
        $("#zgjd").remove();



        var html1 = '<div class="main-block" style="border-color:#fe8065;" id="zbjd" onclick="goTabWithOption(\'准备\')"></div>';
        $('#xmzlDiv').append($(html1));
        var html2 = '<div class="main-block" style="border-color:#5ba3ed;" id="ssjd" onclick="goTabWithOption(\'实施\')"></div>';
        $('#xmzlDiv').append($(html2));
        var html3 = '<div class="main-block" style="border-color:#fbc478;" id="gdjd" onclick="goTabWithOption(\'归档\')"></div>';
        $('#xmzlDiv').append($(html3));
        var html5 = '<div class="main-block" style="border-color:#dc90fb;" id="zgjd" onclick="goTabWithOption(\'整改\')"></div>';
        $('#xmzlDiv').append($(html5));
        var html4 = '<div class="main-block" style="border-color:#67c6b0;" id="wcjd" onclick="goTabWithOption(\'完结\')"></div>';
        $('#xmzlDiv').append($(html4));


        $("#zbjd").html(buildSippetsHtml("准备", countProjectStage["准"], '#fe8065'));
        $("#ssjd").html(buildSippetsHtml("实施", countProjectStage["实"], '#5ba3ed'));
        $("#gdjd").html(buildSippetsHtml("归档", countProjectStage["档"], '#fbc478'));
        $("#wcjd").html(buildSippetsHtml("完结", countProjectStage["完"], '#67c6b0'));
        $("#zgjd").html(buildSippetsHtml("整改", countProjectStage["整"], '#dc90fb'));

        $(".main-block").height(($("#secondContainerContent").height() - 25) / 6)

        var ywc = countProjectStage["完"] + countProjectStage["整"];
        var wqd = planCount - countProjectStage["准"] - countProjectStage["实"] - countProjectStage["档"] - countProjectStage["完"] - countProjectStage["整"];
        var zxz = countProjectStage["准"] + countProjectStage["实"] + countProjectStage["档"];

        var zb = countProjectStage["准"];
        var ssbg = countProjectStage["实"];
        var gd = countProjectStage["档"];

        var xmlx = [], xmlxdatas = [], ywcsl = 0, wwcsl = 0;
        for (var i = 0; i < findProjectTypeOverview.length; i++) {
            var item = findProjectTypeOverview[i];
            xmlx.push(item.NAME);
            xmlxdatas.push({value: item.TOTAL, name: item.NAME});
            ywcsl = ywcsl + item.CLOSED;
            wwcsl = wwcsl + (item.TOTAL - item.CLOSED);
        }

        var xmfbChartOption = {
            title: {
                text: '在审项目分布',
                x: 'center',
                y: '10'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                y: 'bottom',
                data: ['准备', '实施', '归档']
            },
            toolbox: {
                show: false
            },
            calculable: true,
            series: [
                {
                    name: '项目类型',
                    type: 'pie',
                    radius: ['0', '70%'],
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: false,
                            textStyle: {
                                fontSize: '20',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data: [
                        {name: '准备', value: zb},
                        {name: '实施', value: ssbg},
                        {name: '归档', value: gd}
                    ]
                }
            ]

        };

        xmfbChart.setOption(xmfbChartOption, true);

        var wclChartOption = {
            title: {
                text: '计划完成率',
                x: 'center',
                y: '10'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                y: 'bottom',
                data: ['已完成', '未启动', '执行中']
            },
            toolbox: {
                show: false
            },
            calculable: true,
            color: ['#f54545', '#ffac38', '#64b8f9'],
            series: [
                {
                    name: '完成情况',
                    type: 'pie',
                    radius: ['0', '70%'],
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: false,
                            textStyle: {
                                fontSize: '20',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data: [
                        {name: '已完成', value: ywc},
                        {name: '未启动', value: wqd},
                        {name: '执行中', value: zxz}
                    ]
                }
            ]
        };
        wclChart.setOption(wclChartOption, true);

        if (q) q.next();
    });
}


// 统计信息相关
// 全局统计信息
function summary(q, condition) {
    var selectedOrg;
    var selectedYear;
    var cond = q.data || condition;
    if ($("#tjnd").val() == undefined) {
        selectedYear = curYear;
    } else {
        selectedYear = $("#tjnd").combobox("getValue");
    }
    if (cond.tjfw != undefined && cond.tjfw != "") {
        selectedOrg = cond.tjfw;
    } else {
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
    }
    $.get(base_url + "/summary.action?tjfw=" + selectedOrg + "&tjnd=" + selectedYear, function (_data) {
        var data = JSON.parse(_data);

        // 构建机构选择列表
        var orgs = [];
        for (var i = 0, j = data.organizationScopes.length; i < j; i++) {
            var o = data.organizationScopes[i];
            var id = o.id;
            var name = o.name;
            var orgStr = "<option value=\"" + id + "\">" + name + "</option>";
            if (id == data.organizationId) {
                orgStr = "<option selected=\"selected\" value=\"" + id + "\">" + name + "</option>";
                $('#orgname').text(name);
            }
            orgs.push(orgStr);
        }
        $("#tjfw").html(orgs.join("\n"));

        // 构建年度选项
        var years = [];
        for (var i = 0, j = data.years.length; i < j; i++) {
            var y = data.years[i];
            var yearStr = "<option value=\"" + y + "\">" + y + "</option>";
            if (y === data.year) {
                yearStr = "<option selected=\"selected\" value=\"" + y + "\">" + y + "</option>";
            }
            years.push(yearStr);
        }
        $("#tjnd").html(years.join("\n"));

        // 人员滚动内容
        $.get(persionListUrl + "&ldst=1&tjfw=" + selectedOrg , function (persionListData) {
            persionListDatas = JSON.parse(persionListData);
            var members = [];
            var count = persionListDatas.total;
            $('#ryzt_more').click(function () {
                goTabWithOption('人员状态');
            });
            for (var i = 0, j = count; i < j; i++) {
                //var item = data.memberStatus[i];
                var item = persionListDatas.rows[i];
                var hj = parseInt(item.plan_running) + parseInt(item.plan_wait_running) + parseInt(item.plan_finished);

                var f = i % 2 == 1 ;
                var s = f ? '<div class="loopitem  datagrid-row-alt">' : '<div class="loopitem">';

                members.push(s + '\n' +
                    '<div class="ryztspliceitem" >' + item.employeeInfo.name + '</div>\n' +
                    '<div class="ryztspliceitem-center" >' + item.plan_wait_running + '</div>\n' +
                    '<div class="ryztspliceitem-center" >' + item.plan_running + '</div>\n' +
                    '<div class="ryztspliceitem-center" >' + item.plan_finished + '</div>\n' +
                    '<div class="ryztspliceitem-center" >' + hj + '</div>\n' +
                    '</div>');
            }
            $("#ryztcontent").html(members.join("\n"));

            var memScroll = $("#ryztcontent").data('scrollObject');
            if (!memScroll) {
                memScroll = new AutoScroll('ryztcontent');
                $("#ryztcontent").data('scrollObject', memScroll);
            }

            if (!q.data.mapSearch) {
                g_indexlayout.resize();
                var item_count = g_indexlayout.scollHeight / ScrollItemHeight;
                if (count > (item_count - 4))
                    memScroll.start();
                else
                    memScroll.clear();

                $('#zsxmcontent').height(($('#secondContainerContent').height() - 95) / 2);
                $('#ryztcontent').height(($('#secondContainerContent').height() - 95) / 2);


                // 项目滚动相关
                var projects = [];
                count = data.runningProjects.length;
                $('#zsxm_more').click(function () {
                    goTabWithOption('在审项目');
                });
                for (var i = 0, j = count; i < j; i++) {
                    var item = data.runningProjects[i];
                    var proName = item.projectName;
                    if (item.projectName.length > 15) {
                        item.projectName = item.projectName.substr(0, 15) + "..."
                    }

                    if(item.stageName == '准'){
                        item.stageName = '准备';
                    }
                    if(item.stageName == '实'){
                        item.stageName = '实施';
                    }
                    if(item.stageName == '整'){
                        item.stageName = '整改';
                    }
                    if(item.stageName == '完'){
                        item.stageName = '已完成';
                    }
                    if(item.stageName == '档'){
                        item.stageName = '归档';
                    }

                    var f = i % 2 == 1 ;
                    var s = f ? '<div class="loopitem  datagrid-row-alt">' : '<div class="loopitem">';

                    if(item.stageName != "已完成" && item.stageName != "整改" ){
                        projects.push(s +
                            '<div class="zsxmmc" id="zsxmmccss">' + item.projectName + '<span class="tooltiptext">' + proName + '</span></div>' +
                            '<div class="zsxmmc-center">' + item.stageName + '</div>' +
                            '</div>');
                    }
                }

                $("#zsxmcontent").html(projects.join("\n"));

                var projScroll = $("#zsxmcontent").data('scrollObject');
                if (!projScroll) {
                    projScroll = new AutoScroll('zsxmcontent');
                    $("#zsxmcontent").data('scrollObject', projScroll);
                }
                $(".ryztspliceitem").width($('#ryztxm').width());
                $(".ryztspliceitem-center").width($('#ryztjh').width());
                $(".zsxmmc").width($('#right_zsxmmc').width());
                $(".zsxmmc-center").width($('#right_zsxmjd').width());
                if (count > (item_count - 3))
                    projScroll.start();
                else
                    projScroll.clear();
            } else {
                $('#switchtitle-new').css('left', ($("#secondContainer").width()) - 280);
                $('#switchtitle-new').show();
            }

            // 把项目数量传递给下一步使用
            q.data.projectCount = data.projectCount;
            q.data.planCount = data.planCount;
            orgIds = data.orgIds;
            auditIds = data.auditIds;

            // UI值绑定
            $("#manuCount").text(data.manuCount);
            $("#planCount").text(data.planCount);
            $('#reportCount').text(data.reportCount);
            $("#audTemplateCount").text(data.audTemplateCount);
            $("#countSjal").text(data.countSjal);
            $("#auditOrganizationCount").text(data.auditOrganizationCount);
            $("#memberCount").text(data.memberCount);
            $("#avgProjectMemberCount").text(data.avgProjectMemberCount);
            $("#problemCount").text(data.problemCount);
            $("#problemTypeCount").text(data.problemTypeCount);
            $("#projectCount").text(data.projectCount);
            $("#lawsAndRegularCount").text(data.lawsAndRegularCount);
            $("#caseCount").text(data.caseCount);
            $("#auditObjectCount").text(data.auditObjectCount);
            $("#correctedProblemCount").text(data.correctedProblemCount);
            $("#uncorrectedProblemCount").text(data.uncorrectedProblemCount);
            $("#taskCount").text(data.taskCount);


            //计划执行

            $.get(overViewMapUrl + "&tjfw=" + selectedOrg, function (overViewMapData) {
                var w = $(".block-info").width() - 5;
                var h = $(".block-info").height() - 50;
                var jhzxChart = buildCharts('jhzxcanvas', w, h);

                overViewMapData = JSON.parse(overViewMapData);
                var countProjectStage = overViewMapData.countProjectStage;

                if(countProjectStage["档"] == undefined ){
                    countProjectStage["档"] = 0;
                }
                if(countProjectStage["实"] == undefined ){
                    countProjectStage["实"] = 0;
                }
                if(countProjectStage["准"] == undefined ){
                    countProjectStage["准"] = 0;
                }
                if(countProjectStage["完"] == undefined ){
                    countProjectStage["完"] = 0;
                }
                if(countProjectStage["整"] == undefined ){
                    countProjectStage["整"] = 0;
                }

                var zzx = countProjectStage["档"]  + countProjectStage["实"] + countProjectStage["准"];
                var ywc = countProjectStage["完"] + countProjectStage["整"];
                var wzx = data.planCount - zzx - ywc;

                var jhzxOption = {
                    tooltip: {
                        trigger: 'item',
                        formatter: "{a} <br/>{b}: {c} ({d}%)"
                    },
                    legend: {
                        y: 'bottom',
                        data: ['执行中', '未启动', '已完成'],
                    },
                    series: [
                        {
                            name: '计划执行',
                            type: 'pie',
                            center: ['50%', '40%'],
                            radius: ['50%', '70%'],
                            avoidLabelOverlap: false,
                            itemStyle: {
                                normal: {
                                    label: {
                                        position: 'inner',
                                        formatter: function (params) {
                                            return (params.percent - 0).toFixed(0) + '%'
                                        }
                                    },
                                    labelLine: {
                                        show: false
                                    }
                                },
                                emphasis: {
                                    label: {
                                        show: true,
                                        formatter: "{b}\n{d}%"
                                    }
                                }
                            },
                            data: [
                                {name: '执行中', value: zzx},
                                {name: '未启动', value: wzx},
                                {name: '已完成', value: ywc}
                            ]
                        }
                    ]
                };

                jhzxChart.setOption(jhzxOption, true);

            });

            //项目排名数量
            xmslSort(true);
            //问题数排名
            wtsSort(true);
            //整改排名
            zglSort(true);

            if (q)
                q.next();
        });

    });
}


//进去领导视图时首先系统加载sql.xml文件
function loadSqlXml(q){

    $.get(base_url + "/loadSqlXml.action",function () {
        console.log('sql配置文件加载完成')
    })

    if (q)
        q.next();
}


/**
 * 地图导航：
 * 计划执行，项目数量排名，问题数量，整改排名
 */
function dtdh(q) {
    q.nextTick();
}


var g_type2CaptionMaps = {
    'type': '按项目类型',
    'org': '按审计单位',
    'obj': '按被审计单位',
    'wtxz': '按问题性质',
    'wtd': '按问题点',
    'auditPersion': '按审计人员'
};

/**
 * 项目同期比
 * @param q 队列
 * @param year  页签内的时间下拉框选择
 * @param param 统计维度
 */
function xmtqb(q, year, param) {
    var w = g_indexlayout.canvasWidth;
    var selectedOrg;
    var selectedYear;
    if(q.data == undefined){
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    }else if (q.data.tjfw.length == 0) {
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    } else {
        selectedOrg = q.data.tjfw;
        selectedYear = $("#tjnd").combobox("getValue");
    }
    var beginYear = parseInt(selectedYear) - 4;
    var url = base_url + "/projectCountChart.action?tjnd_begin=" + beginYear;
    url = url + "&tjnd=" + selectedYear + "&tjfw=" + selectedOrg;
    if (param) {
        url = url + "&type=" + param;
    } else if (selectedOrg.length == 1) {
        $("input[name='xmtqb'][value='按审计单位']").attr("checked", true);
        url = url + "&type=org";
    } else {
        url = url + "&type=org";
    }

    $.get(url, function (data) {
        var data = JSON.parse(data);
        var legends = [], orgs = [], orgmaps = {}, _series = [];
        var legenName = '';
        var xmtqbChart = buildCharts('xmtqbcanvas', w * 0.85, g_indexlayout.canvasHeight - 20);
        var xmtqbOption;
        var selectOrg;

        var params = $("input[name='xmtqb']:checked").val();

        if(params == '按审计单位'){
            selectOrg = '审计单位';
        }else if(params == '按被审计单位'){
            selectOrg = '被审计单位';
        }else if(params == '按项目类型'){
            selectOrg = '项目类型';
        }

        if (selectedOrg.length == 1 && params == '按审计单位') {
            for(var o = 0; o < data[selectedYear].length; o++){
                if(selectedOrg.indexOf(data[selectedYear][o].id) != -1){
                    legenName = data[selectedYear][o].name;
                }
            }
            legends.push(legenName);
            for (var k in data) {
                if (k.length > 4) {
                    k = k.substr(0, 4)
                }
                orgs.push(k);
                if (data[k][0].count == "") {
                    data[k][0].count = 0;
                }
                _series.push(data[k][0].count);
            }

            xmtqbOption = {
                title: {},
                tooltip: {
                    trigger: 'axis'
                },
                xAxis: {
                    type: 'category',
                    name: '年度',
                    data: orgs
                },
                yAxis: {
                    type: 'value',
                    name: '数量(/个)',
                    position: 'left'
                },
                legend: {
                    data: legends,
                    y: 'bottom'
                },
                series: [{
                    data: _series,
                    type: 'line',
                    name: legenName
                }]
            };

        } else {
            for (var k in data) {
                legends.push(k);
                var items = data[k];
                for (var i = 0, j = items.length; i < j; i++) {
                    var obj = items[i];
                    if (!orgmaps[obj.name]) {
                        orgmaps[obj.name] = orgs.length + 1;

                        orgs.push(obj.name);
                    }
                }
            }

            for (var k in data) {
                var itm = {name: k, type: 'line'};
                var _d = [];
                for (var i = 0, j = orgs.length; i < j; i++) {
                    _d.push(0);
                }
                var items = data[k];
                for (var i = 0, j = items.length; i < j; i++) {
                    var obj = items[i];
                    var idx = orgmaps[obj.name];
                    var count = obj.count;
                    _d[idx - 1] = count;
                }
                itm.data = _d;
                _series.push(itm);
            }

            if (!param || '' === param) {
                param = 'org';
            }

            xmtqbOption = {
                title: {},
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: legends,
                    y: 'bottom'
                },
                toolbox: {
                    show: false
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        boundaryGap: false,
                        name: selectOrg,
                        data: orgs,
                        axisLabel: {
                            formatter: function (orgs) {
                                if (!orgs) return '';
                                if (orgs.length > 4) {
                                    orgs =  orgs.slice(0,4) + '...';
                                }
                                return orgs;
                            },
                        },
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        name: '数量(/个)',
                        position: 'left'
                    }
                ],
                series: _series
            };
        }

        xmtqbChart.setOption(xmtqbOption, true);

        if (q) {
            try {
                q.next();
            } catch (e) {
                console.log("(*￣︶￣)");
            }
        }
    });
}

/**
 *  问题同期比
 * @param q 队列
 * @param year 问题同期比选择的年度
 * @param param 问题同期比分析维度
 */
function wttqb(q, year, param) {
    var selectedOrg;
    var selectedYear;
    if(q.data == undefined){
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    }else if (q.data.tjfw.length == 0) {
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    } else {
        selectedOrg = q.data.tjfw;
        selectedYear = $("#tjnd").combobox("getValue");
    }
    var beginYear = parseInt(selectedYear) - 4;
    var url = base_url + "/problemChart2.action?tjnd_begin=" + beginYear;
    url = url + "&tjnd=" + selectedYear + "&tjfw=" + selectedOrg;
    if (param) {
        url = url + "&type=" + param;
    } else if (selectedOrg.length == 1) {
        $("input[name='wttqb'][value='按审计单位']").attr("checked", true);
        url = url + "&type=org";
    } else {
        url = url + "&type=org";
    }
    var w = g_indexlayout.canvasWidth;
    var xmtqbChart = buildCharts('wttqbcanvas', w * 0.85, g_indexlayout.canvasHeight - 20);
    var xmtqbOption;

    $.get(url, function (data) {
        var data = JSON.parse(data);
        var legends = [], orgs = [], orgmaps = {}, _series = [];
        var legenName = '';
        var params = $("input[name='wttqb']:checked").val();
        if (selectedOrg.length == 1 && params == '按审计单位') {
            for (var k in data) {
                for(var o = 0; o < data[selectedYear].length; o++){
                    if(selectedOrg.indexOf(data[selectedYear][o].id) != -1){
                        legenName = data[selectedYear][o].name;
                    }
                }
                legends.push(legenName);

                    orgs.push(k);
                if (data[k][0].count == "") {
                    data[k][0].count = 0;
                }
                _series.push(data[k][0].count);
            }

            xmtqbOption = {
                title: {},
                tooltip: {
                    trigger: 'axis'
                },
                xAxis: {
                    type: 'category',
                    name: '年度',
                    data: orgs,
                    axisLabel: {
                        formatter: function (orgs) {
                            if (!orgs) return '';
                            if (orgs.length > 4) {
                                orgs =  orgs.slice(0,4) + '...';
                            }
                            return orgs;
                        },
                    },
                },
                yAxis: {
                    type: 'value',
                    name: '数量(/个)',
                    position: 'left'
                },
                legend: {
                    data: legends,
                    y: 'bottom'
                },
                series: [{
                    data: _series,
                    type: 'line',
                    name: legenName
                }]
            };


        } else {
            for (var k in data) {
                legends.push(k);
                var items = data[k];
                for (var i = 0, j = items.length; i < j; i++) {
                    var obj = items[i];
                    if (!orgmaps[obj.name]) {
                        orgmaps[obj.name] = orgs.length + 1;
                        orgs.push(obj.name);
                    }
                }
            }

            for (var k in data) {
                var itm = {name: k, type: 'line'};
                var _d = [];
                for (var i = 0, j = orgs.length; i < j; i++) {
                    _d.push(0);
                }
                var items = data[k];
                for (var i = 0, j = items.length; i < j; i++) {
                    var obj = items[i];
                    var idx = orgmaps[obj.name];
                    var count = obj.count;
                    _d[idx - 1] = count;
                }
                itm.data = _d;
                _series.push(itm);
            }

            if (!param || '' === param) {
                param = 'org';
            }

            xmtqbOption = {
                title: {},
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: legends,
                    y: 'bottom'
                },
                toolbox: {
                    show: false
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        boundaryGap: false,
                        data: orgs,
                        axisLabel: {
                            formatter: function (orgs) {
                                if (!orgs) return '';
                                if (orgs.length > 4) {
                                    orgs =  orgs.slice(0,4) + '...';
                                }
                                return orgs;
                            },
                        },
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        name: '数量(/个)',
                        position: 'left'

                    }
                ],
                series: _series
            };
        }

        xmtqbChart.setOption(xmtqbOption, true);

        if (q) {
            try {
                q.next();
            } catch (e) {
                console.log("(*￣︶￣)");
            }
        }
    });
}

// 问题整改情况
function wtzgqk(q, year, param) {
    var selectedOrg;
    var selectedYear;
    if(q.data == undefined){
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    }else if (q.data.tjfw.length == 0) {
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    } else {
        selectedOrg = q.data.tjfw;
        selectedYear = $("#tjnd").combobox("getValue");
    }

    var beginYear = parseInt(selectedYear) - 4;
    var url = base_url + "/problemChangeChart.action?tjnd_begin=" + beginYear;
    url = url + "&tjnd=" + selectedYear + "&tjfw=" + selectedOrg;
    if (param) {
        url = url + "&type=" + param;
    } else {
        url = url + "&type=org";
    }
    $.get(url, function (data) {
        var data = JSON.parse(data);
        var temp = [], temp1 = [], temp2 = [], name = [];
        var w = g_indexlayout.canvasWidth;
        var wtzgqkcanvasbChartb = buildCharts("wtzgqkbcanvas", w * 0.85, g_indexlayout.canvasHeight - 20);
        var wtzgqkOptionb;
        var wzg = 0;
        var zgz = 0;
        var yzg = 0;
        var sum = [];

        if (data.length > 10) {
            length = 10;
        } else {
            length = data.length;
        }
        if (flag == true) {
            if (selectedOrg.length == 0) {
                for (var i = data.length - 1, j = (data.length - 11) > 0 ? (data.length - 11) : 0; (data.length - 11) > 0 ? i > j : i >= j; i--) {
                    var zgl;
                    var item = data[i];
                    temp2.push(item.yzg);
                    temp1.push(item.yzg + item.wzg + item.zgz);
                    if ((item.yzg + item.wzg + item.zgz) == 0 || item.yzg == 0) {
                        zgl = 0;
                    } else {
                        zgl = item.yzg / (item.yzg + item.wzg + item.zgz) * 100;
                    }
                    temp.push(zgl);
                    if (item.fname.length > 4) {
                        item.fname = item.fname.substr(0, 4)
                    }
                    name.push(item.fname);

                }

                wtzgqkOptionb = {
                    title: {
                        /*text: '问题整改情况',
                        subtext: g_type2CaptionMaps[param]*/
                    },
                    tooltip: {
                        trigger: 'axis',
                        formatter: function (params, ticket, callback){
                            var showHtm="";
                            for(var i=0;i<params.length;i++){
                                if(params[0].seriesName == "整改完成率"){
                                    showHtm = params[0].seriesName + ':' + params[0].data.toFixed(2)  + '%' + '<br/>'
                                        + params[1].seriesName + ':' + params[1].data + '<br/>' + params[2].seriesName + ':' + params[2].data;
                                }
                            }
                            return showHtm;
                        }
                    },
                    legend: {
                        y: 'bottom',
                        data: ['整改完成率', '已整改', '问题个数']
                    },
                    yAxis: [
                        {
                            type: 'value',
                            name: '数量(/个)',
                            position: 'left'

                        },
                        {
                            type: 'value',
                            name: '整改完成率',
                            min: 0,
                            max: 100,
                            interval: 20,
                            axisLabel: {
                                formatter: '{value} %'
                            }
                        }
                    ],
                    xAxis: [
                        {
                            type: 'category',
                            axisLabel: {
                                interval: 0
                            },
                            data: name

                        }
                    ],
                    series: [
                        {
                            name: '整改完成率',
                            type: 'line',
                            label: {
                                normal:
                                    {
                                        show: true,
                                        color: 'grey',
                                        position: 'top',
                                        formatter: function (v) {
                                            if(v.data == 0){
                                                return "";
                                            }else{
                                                var val = v.data;
                                                return val.toFixed(2) + '%';
                                            }

                                        },
                                    },
                                borderWidth: 0,
                                barBorderRadius: 0,
                            },
                            yAxisIndex: 1,
                            data: temp
                        }, {
                            name: '已整改',
                            type: 'bar',
                            barWidth : 10,//柱图宽度
                            label: {
                                normal:
                                    {
                                        show: false,
                                        position: 'top',
                                        color: 'grey',
                                        formatter: function (v) {
                                            if(v.data == 0){
                                                return "";
                                            }else{
                                                var val = v.data;
                                                return val;
                                            }

                                        },
                                    },
                            }, data: temp2,

                        }, {
                            name: '问题个数',
                            type: 'bar',
                            barWidth : 10,//柱图宽度
                            label: {
                                normal:
                                    {
                                        show: true,
                                        position: 'top',
                                        color: 'grey',
                                        formatter: function (v) {
                                            if(v.data == 0){
                                                return "";
                                            }else{
                                                var val = v.data;
                                                return val;
                                            }

                                        },
                                    },
                            },
                            data: temp1,

                        }

                    ]
                };


            } else {
                var xmlength;
                var params = $("input[name='wtzgqk']:checked").val();
                if (param == 'org' || params == '按审计单位') {
                    xmlength = selectedOrg.length;
                } else {
                    xmlength = data.length;
                }

                if (xmlength == 1) {
                    for (var i = data.length - 1, j = (data.length - 11) > 0 ? (data.length - 11) : 0; (data.length - 11) > 0 ? i > j : i >= j; i--) {
                        var item = data[i];
                        temp2.push(item.yzg);
                        temp1.push(item.zgz);
                        temp.push(item.wzg);
                        name.push(item.fname);

                        var zgjl = data[i];
                        wzg += zgjl.wzg;
                        zgz += zgjl.zgz;
                        yzg += zgjl.yzg;

                        sum.push(temp[i] + temp1[i] + temp2[i]);
                    }
                    wtzgqkOptionb = {
                        title: {
                            text: '问题整改完成率',
                            x: 'center',
                            y: '20'

                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b}: {c} ({d}%)"
                        },
                        legend: {
                            y: 'bottom',
                            data: ['未整改', '整改中', '已整改'],
                        },
                        series: [
                            {
                                name: '问题整改情况',
                                type: 'pie',
                                radius: ['50%', '70%'],
                                avoidLabelOverlap: false,
                                label: {
                                    normal: {
                                        show: false,
                                        position: 'center'
                                    },
                                    emphasis: {
                                        show: true,
                                        textStyle: {
                                            fontSize: '30',
                                            fontWeight: 'bold'
                                        }
                                    }
                                },
                                labelLine: {
                                    normal: {
                                        show: false
                                    }
                                },
                                data: [
                                    {name: '未整改', value: wzg},
                                    {name: '整改中', value: zgz},
                                    {name: '已整改', value: yzg}
                                ]
                            }
                        ]
                    };
                } else {
                    for (var i = xmlength - 1, j = (xmlength - 11) > 0 ? (xmlength - 11) : 0; (xmlength - 11) > 0 ? i > j : i >= j; i--) {
                        var zgl;
                        var item = data[i];
                        if(item.yzg == undefined){
                            item.yzg = 0
                        }
                        temp2.push(item.yzg);
                        temp1.push(item.yzg + item.wzg + item.zgz);
                        if ((item.yzg + item.wzg + item.zgz) == 0 || item.yzg == 0) {
                            zgl = 0;
                        } else {
                            zgl = item.yzg / (item.yzg + item.wzg + item.zgz) * 100;
                        }
                        temp.push(zgl);

                        if (item.fname.length > 4) {
                            item.fname = item.fname.substr(0, 4)
                        }
                        name.push(item.fname);


                    }

                    wtzgqkOptionb = {
                        title: {
                            /*text: '问题整改情况',
                            subtext: g_type2CaptionMaps[param]*/
                        },
                        tooltip: {
                            trigger: 'axis',
                            formatter: function (params, ticket, callback){
                                var showHtm="";
                                for(var i=0;i<params.length;i++){
                                    if(params[0].seriesName == "整改完成率"){
                                        showHtm = params[0].seriesName + ':' + params[0].data.toFixed(2)  + '%' + '<br/>'
                                            + params[1].seriesName + ':' + params[1].data + '<br/>' + params[2].seriesName + ':' + params[2].data;
                                    }
                                }
                                return showHtm;
                            }
                        },
                        legend: {
                            y: 'bottom',
                            data: ['整改完成率', '已整改', '问题个数']
                        },
                        yAxis: [
                            {
                                type: 'value',
                                name: '数量(/个)',
                                position: 'left'

                            },
                            {
                                type: 'value',
                                name: '整改完成率',
                                min: 0,
                                max: 100,
                                interval: 20,
                                axisLabel: {
                                    formatter: '{value} %'
                                }
                            }
                        ],
                        xAxis: [
                            {
                                type: 'category',
                                axisLabel: {
                                    interval: 0
                                },
                                data: name

                            }
                        ],
                        series: [
                            {
                                name: '整改完成率',
                                type: 'line',
                                label: {
                                    normal:
                                        {
                                            show: true,
                                            color: 'grey',
                                            position: 'top',
                                            formatter: function (v) {
                                                if(v.data == 0){
                                                    return "";
                                                }else{
                                                    var val = v.data;
                                                    return val.toFixed(2)  + '%';
                                                }

                                            },
                                        },
                                    borderWidth: 0,
                                    barBorderRadius: 0,
                                },
                                yAxisIndex: 1,
                                data: temp
                            }, {
                                name: '已整改',
                                type: 'bar',
                                barWidth : 10,//柱图宽度
                                label: {
                                    normal:
                                        {
                                            show: false,
                                            position: 'top',
                                            color: 'grey',
                                            formatter: function (v) {
                                                if(v.data == 0){
                                                    return "";
                                                }else{
                                                    var val = v.data;
                                                    return val;
                                                }

                                            },
                                        },
                                }, data: temp2,
                            }, {
                                name: '问题个数',
                                type: 'bar',
                                barWidth : 10,//柱图宽度
                                label: {
                                    normal:
                                        {
                                            show: false,
                                            position: 'top',
                                            color: 'grey',
                                            formatter: function (v) {
                                                if(v.data == 0){
                                                    return "";
                                                }else{
                                                    var val = v.data;
                                                    return val;
                                                }

                                            },
                                        },
                                },
                                data: temp1
                            }

                        ]
                    };

                }


            }
        } else {
            if (selectedOrg.length == 0) {
                for (var i = 0, j = length; i < j; i++) {
                    var zgl;
                    var item = data[i];
                    temp2.push(item.yzg);
                    temp1.push(item.yzg + item.wzg + item.zgz);
                    if ((item.yzg + item.wzg + item.zgz) == 0 || item.yzg == 0) {
                        zgl = 0;
                    } else {
                        zgl = item.yzg / (item.yzg + item.wzg + item.zgz) * 100;
                    }
                    temp.push(zgl);

                    if (item.fname != null && item.fname.length > 4) {
                        item.fname = item.fname.substr(0, 4)
                    }
                    name.push(item.fname);


                }

                wtzgqkOptionb = {
                    title: {
                        /* text: '问题整改情况',
                         subtext: g_type2CaptionMaps[param]*/
                    },
                    tooltip: {
                        trigger: 'axis',
                        formatter: function (params, ticket, callback){
                            var showHtm="";
                            for(var i=0;i<params.length;i++){
                                if(params[0].seriesName == "整改完成率"){
                                    showHtm = params[0].seriesName + ':' + params[0].data.toFixed(2)  + '%' + '<br/>'
                                        + params[1].seriesName + ':' + params[1].data + '<br/>' + params[2].seriesName + ':' + params[2].data;
                                }
                            }
                            return showHtm;
                        }
                    },
                    legend: {
                        y: 'bottom',
                        data: ['整改完成率', '已整改', '问题个数']
                    },
                    yAxis: [
                        {
                            type: 'value',
                            name: '数量(/个)',
                            position: 'left'

                        },
                        {
                            type: 'value',
                            name: '整改完成率',
                            min: 0,
                            max: 100,
                            interval: 20,
                            axisLabel: {
                                formatter: '{value} %'
                            }
                        }
                    ],
                    xAxis: [
                        {
                            type: 'category',
                            axisLabel: {
                                interval: 0
                            },
                            data: name

                        }
                    ],
                    series: [
                        {
                            name: '整改完成率',
                            type: 'line',
                            label: {
                                normal:
                                    {
                                        show: true,
                                        color: 'grey',
                                        position: 'top',
                                        formatter: function (v) {
                                            if(v.data == 0){
                                                return "";
                                            }else{
                                                var val = v.data;
                                                return val.toFixed(2)  + '%';
                                            }

                                        },
                                    },
                                borderWidth: 0,
                                barBorderRadius: 0,
                            },
                            yAxisIndex: 1,
                            data: temp
                        }, {
                            name: '已整改',
                            type: 'bar',
                            barWidth : 10,//柱图宽度

                            label: {
                                normal:
                                    {
                                        show: false,
                                        position: 'top',
                                        color: 'grey',
                                        formatter: function (v) {
                                            if(v.data == 0){
                                                return "";
                                            }else{
                                                var val = v.data;
                                                return val;
                                            }

                                        },
                                    },
                            }, data: temp2,
                        }, {
                            name: '问题个数',
                            type: 'bar',
                            barWidth : 10,//柱图宽度

                            label: {
                                normal:
                                    {
                                        show: false,
                                        position: 'top',
                                        color: 'grey',
                                        formatter: function (v) {
                                            if(v.data == 0){
                                                return "";
                                            }else{
                                                var val = v.data;
                                                return val;
                                            }

                                        },
                                    },
                            },
                            data: temp1
                        }

                    ]
                };
            } else {
                var xmlength;
                var params = $("input[name='wtzgqk']:checked").val();
                if (param == 'org' || params == '按审计单位') {
                    xmlength = selectedOrg.length;
                } else {
                    if (data.length > 10) {
                        xmlength = 10;
                    } else {
                        xmlength = data.length;
                    }
                }

                if (xmlength == 1) {

                    for (var i = 0, j = data.length; i < j; i++) {
                        var item = data[i];
                        if($("#tjfw").combotree("getValues") == item.fid){
                            temp2.push(item.yzg);
                            temp1.push(item.zgz);
                            temp.push(item.wzg);
                            name.push(item.fname);

                            var zgjl = data[i];
                            wzg += zgjl.wzg;
                            zgz += zgjl.zgz;
                            yzg += zgjl.yzg;

                            sum.push(temp[i] + temp1[i] + temp2[i]);
                        }
                    }

                    wtzgqkOptionb = {
                        title: {
                            text: '问题整改完成率',
                            x: 'center',
                            y: '20'

                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b}: {c} ({d}%)"
                        },

                        legend: {
                            y: 'bottom',
                            data: ['未整改', '整改中', '已整改'],
                        },
                        series: [
                            {
                                name: '问题整改情况',
                                type: 'pie',
                                radius: ['50%', '70%'],
                                avoidLabelOverlap: false,
                                label: {
                                    normal: {
                                        show: false,
                                        position: 'center'
                                    },
                                    emphasis: {
                                        show: true,
                                        textStyle: {
                                            fontSize: '30',
                                            fontWeight: 'bold'
                                        }
                                    }
                                },
                                labelLine: {
                                    normal: {
                                        show: false
                                    }
                                },
                                data: [
                                    {name: '未整改', value: wzg},
                                    {name: '整改中', value: zgz},
                                    {name: '已整改', value: yzg}
                                ]
                            }
                        ]
                    };
                } else {
                    for (var i = 0, j = xmlength; i < j; i++) {
                        var zgl;
                        var item = data[i];
                        if(item.yzg == undefined){
                            item.yzg = 0
                        }
                        temp2.push(item.yzg);
                        temp1.push(item.yzg + item.wzg + item.zgz);
                        if ((item.yzg + item.wzg + item.zgz) == 0 || item.yzg == 0) {
                            zgl = 0;
                        } else {
                            zgl = item.yzg / (item.yzg + item.wzg + item.zgz) * 100;
                        }
                        temp.push(zgl);

                        if (item.fname != null && item.fname.length > 4) {
                            item.fname = item.fname.substr(0, 4)
                        }
                        name.push(item.fname);


                    }

                    wtzgqkOptionb = {
                        title: {
                        },
                        tooltip: {
                            trigger: 'axis',
                            formatter: function (params, ticket, callback){
                                var showHtm="";
                                for(var i=0;i<params.length;i++){
                                    if(params[0].seriesName == "整改完成率"){
                                        showHtm = params[0].seriesName + ':' + params[0].data.toFixed(2)  + '%' + '<br/>'
                                            + params[1].seriesName + ':' + params[1].data + '<br/>' + params[2].seriesName + ':' + params[2].data;
                                    }
                                }
                                return showHtm;
                            }
                        },
                        legend: {
                            y: 'bottom',
                            data: ['整改完成率', '已整改', '问题个数']
                        },
                        yAxis: [
                            {
                                type: 'value',
                                name: '数量(/个)',
                                position: 'left'

                            },
                            {
                                type: 'value',
                                name: '整改完成率',
                                min: 0,
                                max: 100,
                                interval: 20,
                                axisLabel: {
                                    formatter: '{value} %'
                                }
                            }
                        ],
                        xAxis: [
                            {
                                type: 'category',
                                axisLabel: {
                                    interval: 0
                                },
                                data: name

                            }
                        ],
                        series: [
                            {
                                name: '整改完成率',
                                type: 'line',
                                label: {
                                    normal:
                                        {
                                            show: true,
                                            color: 'grey',
                                            position: 'top',
                                            formatter: function (v) {
                                                if(v.data == 0){
                                                    return "";
                                                }else{
                                                    var val = v.data;
                                                    return val.toFixed(2)  + '%';
                                                }

                                            },
                                        },
                                    borderWidth: 0,
                                    barBorderRadius: 0,
                                },
                                yAxisIndex: 1,
                                data: temp
                            }, {
                                name: '已整改',
                                type: 'bar',
                                barWidth : 10,//柱图宽度

                                label: {
                                    normal:
                                        {
                                            show: false,
                                            position: 'top',
                                            color: 'grey',
                                            formatter: function (v) {
                                                if(v.data == 0){
                                                    return "";
                                                }else{
                                                    var val = v.data;
                                                    return val;
                                                }

                                            },
                                        },
                                }, data: temp2,
                            }, {
                                name: '问题个数',
                                type: 'bar',
                                barWidth : 10,//柱图宽度

                                label: {
                                    normal:
                                        {
                                            show: false,
                                            position: 'top',
                                            color: 'grey',
                                            formatter: function (v) {
                                                if(v.data == 0){
                                                    return "";
                                                }else{
                                                    var val = v.data;
                                                    return val;
                                                }

                                            },
                                        },
                                },
                                data: temp1
                            }

                        ]
                    };

                }

            }
        }

        if (!param || '' === param) {
            param = 'org';
        }

        wtzgqkcanvasbChartb.setOption(wtzgqkOptionb, true);
        if (q) {
            try {
                q.nextTick(100);
            } catch (e) {
                console.log("(*￣︶￣)");
            }
        }
    });
}

/**
 *  问题排名
 * @param q 队列
 * @param year 问题同期比选择的年度
 * @param param 问题同期比分析维度
 */
function wtpm(q, year, param) {
    var selectedYear;
    var selectedOrg;
    if(q.data == undefined){
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    }else if (q.data.tjfw.length == 0) {
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    } else {
        selectedOrg = q.data.tjfw;
        selectedYear = $("#tjnd").combobox("getValue");
    }
    var beginYear = parseInt(selectedYear) - 4;
    var url = base_url + "/problemChart.action?tjnd_begin=" + beginYear;
    url = url + "&tjnd=" + selectedYear + "&tjfw=" + selectedOrg;
    if (param) {
        url = url + "&type=" + param;
    } else if (selectedOrg.length == 1) {
        url = url + "&type=obj";
    } else {
        url = url + "&type=org";
    }

    var w = g_indexlayout.canvasWidth;
    $.get(url, function (data) {
        var data = JSON.parse(data);
        var legends = [], title = [], orgmaps = {}, _series = [];
        var temp = [];
        if (data.length > 10) {
            length = 10;
        } else {
            length = data.length;
        }
        if (flag == true) {
            if (selectedOrg.length == 0) {
                for (var i = data.length - 1, j = (data.length - 11) > 0 ? (data.length - 11) : 0; (data.length - 11) > 0 ? i > j : i >= j; i--) {
                    var item = data[i];
                    if (item.count == null) {
                        item.count = 0;
                    }
                    legends.push(item.title);
                    title.push(item.title);
                    temp.push(item.count);
                }
            } else {
                var xmlength;
                var params = $("input[name='wtpm']:checked").val();
                if (param == 'org' || params == '按审计单位') {
                    xmlength = selectedOrg.length;
                } else {
                    xmlength = data.length;
                }
                for (var i = xmlength - 1, j = (xmlength - 11) > 0 ? (xmlength - 11) : 0; (xmlength - 11) > 0 ? i > j : i >= j; i--) {
                    var item = data[i];
                    if (item.count == null) {
                        item.count = 0;
                    }
                    legends.push(item.title);
                    title.push(item.title);
                    temp.push(item.count);
                }
            }
        } else {
            if (selectedOrg.length == 0) {
                for (var i = 0, j = length; i < j; i++) {
                    var item = data[i];
                    if (item.count == null) {
                        item.count = 0;
                    }
                    legends.push(item.title);
                    title.push(item.title);
                    temp.push(item.count);
                }
            } else {
                var xmlength;
                var params = $("input[name='wtpm']:checked").val();
                if (param == 'org' || params == '按审计单位') {
                    xmlength = selectedOrg.length;
                } else {
                    if (data.length > 10) {
                        xmlength = 10;
                    } else {
                        xmlength = data.length;
                    }
                }
                for (var i = 0, j = xmlength; i < j; i++) {
                    var item = data[i];
                    if (item.count == null) {
                        item.count = 0;
                    }
                    legends.push(item.title);
                    title.push(item.title);
                    temp.push(item.count);
                }
            }
        }

        var serie = {};
        if (!param || '' === param) {
            param = 'org';
        }
        serie.type = 'bar';
        serie.data = temp;
        serie.name = '';
        serie.barWidth = 10;//柱图宽度
        serie.markLine = {
            data: [
                {
                    type: 'average', name: '平均问题数',
                    lineStyle: {
                        normal: {
                            type: "solid",
                            color: "#FA3934",
                        }

                    }
                }
            ]
        }
        _series.push(serie);
        var xmtqbChart = buildCharts('wtpmcanvas', w * 0.85, g_indexlayout.canvasHeight);
        var xmtqbOption = {
            title: {
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: legends
            },
            toolbox: {
                show: false
            },
            calculable: true,
            xAxis: [
                {
                    type: "value",
                    boundaryGap: [0, 0.01],
                    name: '数量(/个)',
                    position: 'right'
                }
            ],
            yAxis: [
                {
                    type: 'category',
                    inverse: true,
                    data: title,
                    axisLabel: {
                        interval: 0,
                        formatter: function (orgs) {
                            if (!orgs) return '';
                            if (orgs.length > 4) {
                                orgs =  orgs.slice(0,4) + '...';
                            }
                            return orgs;
                        },
                    },
                }
            ],
            itemStyle: {
                normal: {
                    color: function (params) {
                        var colorList = [
                            '#f54545', '#ff8547', '#ffac38', '#64b8f9'
                        ];
                        return colorList[params.dataIndex]
                    }
                }
            },
            series: _series
        };
        xmtqbChart.setOption(xmtqbOption, true);

        if (q) {
            try {
                q.next();
            } catch (e) {
                console.log("(*￣︶￣)");
            }
        }
    });
}

function ldcxxmpmSort() {
    var param;
    var params = $("input[name='xmpm']:checked").val();

    if (params == '按被审计单位') {
        param = 'obj';
    } else if (params == '按审计单位') {
        param = 'org';
    } else {
        param = 'auditPersion';
    }
    flag = true;
    xmpm(Q, '', param);
}

function ldcxxmpmdxSort() {
    var param;
    var params = $("input[name='xmpm']:checked").val();
    if (params == '按被审计单位') {
        param = 'obj';
    } else if (params == '按审计单位') {
        param = 'org';
    } else {
        param = 'auditPersion';
    }
    flag = false;
    xmpm(Q, '', param);
}


function ldcxwtzgqkdxSort() {
    var param;
    var params = $("input[name='wtzgqk']:checked").val();
    if (params == '按被审计单位') {
        param = 'obj';
    } else if (params == '按审计单位') {
        param = 'org';
    } else if (params == '按问题性质') {
        param = 'wtxz';
    } else {
        param = 'wtd';
    }
    flag = false;
    wtzgqk(Q, '', param);
}

function ldcxwtzgqkSort() {
    var param;
    var params = $("input[name='wtzgqk']:checked").val();
    if (params == '按被审计单位') {
        param = 'obj';
    } else if (params == '按审计单位') {
        param = 'org';
    } else if (params == '按问题性质') {
        param = 'wtxz';
    } else {
        param = 'wtd';
    }
    flag = true;
    wtzgqk(Q, '', param);
}


function ldcxwtpmdxSort() {

    var param;
    var params = $("input[name='wtpm']:checked").val();
    if (params == '按被审计单位') {
        param = 'obj';
    } else if (params == '按审计单位') {
        param = 'org';
    } else if (params == '按问题性质') {
        param = 'wtxz';
    } else {
        param = 'wtd';
    }
    flag = false;
    wtpm(Q, '', param);

}


function ldcxwtpmSort() {

    var param;
    var params = $("input[name='wtpm']:checked").val();
    if (params == '按被审计单位') {
        param = 'obj';
    } else if (params == '按审计单位') {
        param = 'org';
    } else if (params == '按问题性质') {
        param = 'wtxz';
    } else {
        param = 'wtd';
    }
    flag = true;
    wtpm(Q, '', param);

}


/**
 *   项目排名
 * @param q 队列
 * @param year 年度
 * @param param 页签
 */


function xmpm(q, year, param) {
    var selectedYear;
    var selectedOrg;
    if(q.data == undefined){
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    }else if (q.data.tjfw.length == 0) {
        selectedOrg = $("#tjfw").combotree("getValues") == undefined ? "" : $("#tjfw").combotree("getValues");
        selectedYear = $("#tjnd").combobox("getValue");
    } else {
        selectedOrg = q.data.tjfw;
        selectedYear = $("#tjnd").combobox("getValue");
    }
    var beginYear = parseInt(selectedYear) - 4;
    var url = base_url + "/projectChart.action?tjnd_begin=" + beginYear;
    url = url + "&tjnd=" + selectedYear + "&tjfw=" + selectedOrg;
    if (param) {
        url = url + "&type=" + param;
    } else if (selectedOrg.length == 1) {
        url = url + "&type=obj";
    } else {
        url = url + "&type=org";
    }
    var w = g_indexlayout.canvasWidth;
    var xmtqbChart = buildCharts('xmpmcanvas', w * 0.85, g_indexlayout.canvasHeight);
    $.get(url, function (data) {
        var data = JSON.parse(data);
        var w = g_indexlayout.canvasWidth;
        var legends = [];
        var title = [];
        var temp = [];
        var length = data.length;
        if (data.length > 10) {
            length = 10;
        } else {
            length = data.length;
        }
        if (flag == true) {
            if (selectedOrg.length == 0) {
                for (var i = data.length - 1, j = (data.length - 11) > 0 ? (data.length - 11) : 0; (data.length - 11) > 0 ? i > j : i >= j; i--) {
                    var item = data[i];
                    legends.push(item.fname);
                    title.push(item.fname);
                    temp.push(item.count);
                }
            } else {
                var xmlength;
                var params = $("input[name='xmpm']:checked").val();
                if (param == 'org' || params == '按审计单位') {
                    xmlength = selectedOrg.length;
                } else {
                    xmlength = data.length;
                }
                for (var i = xmlength - 1, j = (xmlength - 11) > 0 ? (xmlength - 11) : 0; (xmlength - 11) > 0 ? i > j : i >= j; i--) {
                    var item = data[i];
                    legends.push(item.fname);
                    title.push(item.fname);
                    temp.push(item.count);
                }
            }
        } else {
            if (selectedOrg.length == 0) {
                for (var i = 0, j = length; i < j; i++) {
                    var item = data[i];
                    legends.push(item.fname);
                    title.push(item.fname);
                    temp.push(item.count);
                }
            } else {
                var xmlength;
                var params = $("input[name='xmpm']:checked").val();
                if (param == 'org' || params == '按审计单位') {
                    xmlength = selectedOrg.length;
                } else {
                    xmlength = data.length;
                }
                for (var i = 0, j = (xmlength - 10) > 0 ? 10 : xmlength; i < j; i++) {
                    var item = data[i];
                    legends.push(item.fname);
                    title.push(item.fname);
                    temp.push(item.count);
                }
            }
        }
        var _series = {
            name: '', type: 'bar',  barWidth : 10,data: temp,
            markLine: {
                data: [
                    {
                        type: 'average', name: '平均项目数',
                        lineStyle: {
                            normal: {
                                type: "solid",
                                color: "#FA3934"
                            }

                        }
                    }
                ]
            }
        };
        if (!param || '' === param) {
            param = 'org';
        }
        var xmtqbOption = {
            title: {},
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: legends
            },
            toolbox: {
                show: false
            },
            calculable: true,
            xAxis: [
                {
                    type: "value",
                    boundaryGap: [0, 0.01],
                    name: '数量(/个)',
                    position: 'right'
                }
            ],
            yAxis: [
                {
                    type: 'category',
                    data: title,
                    inverse: true,
                    axisLabel: {
                        interval: 0,
                        formatter: function (title) {
                            if (!title) return '';
                            if (title.length > 4) {
                                title =  title.slice(0,4) + '...';
                            }
                            return title;
                        },
                       /* tooltip: {
                            show: true,
                            formatter: function (title) {
                                return title;
                            },
                        }*/
                    },

                }
            ],
            itemStyle: {
                normal: {
                    color: function (params) {
                        var colorList = [
                            '#f54545', '#ff8547', '#ffac38', '#64b8f9'
                        ];
                        return colorList[params.dataIndex]
                    }
                }
            },
            series: _series
        };
        xmtqbChart.setOption(xmtqbOption, true);

        if (q) {
            try {
                q.next();
            } catch (e) {
                console.log("(*￣︶￣)");
            }
        }
    });
}

// 地图元数据（负责post-code信息转换）
function MapMetaData() {
    this.provIndex = {};
}

MapMetaData.prototype.provCodes = {
    '01': '内蒙古', '02': '内蒙古',
    '03': '山西', '04': '山西',
    '05': '河北', '06': '河北', '07': '河北',
    '10': '北京',
    '11': '辽宁', '12': '辽宁',
    '13': '吉林',
    '15': '黑龙江', '16': '黑龙江',
    '20': '上海',
    '21': '江苏', '22': '江苏',
    '23': '安徽', '24': '安徽',
    '25': '山东', '26': '山东', '27': '山东',
    '30': '天津',
    '31': '浙江', '32': '浙江',
    '33': '江西', '34': '江西',
    '35': '福建', '36': '福建',
    '41': '湖南', '42': '湖南',
    '43': '湖北', '44': '湖北',
    '45': '河南', '46': '河南', '47': '河南',
    '51': '广东', '52': '广东',
    '53': '广西', '54': '广西',
    '55': '贵州', '56': '贵州',
    '57': '海南',
    '61': '四川', '62': '四川', '64': '四川',
    '63': '重庆',
    '65': '云南', '66': '云南', '67': '云南',
    '71': '陕西', '72': '陕西',
    '73': '甘肃', '74': '甘肃',
    '75': '宁夏',
    '81': '青海',
    '83': '新疆', '84': '新疆',
    '85': '西藏', '86': '西藏'
};
MapMetaData.prototype.provNames = ['北京', '天津', '上海', '重庆', '河北', '河南', '云南', '辽宁', '黑龙江', '湖南', '安徽', '山东', '新疆', '江苏', '浙江', '江西', '湖北', '广西', '甘肃', '山西', '内蒙古', '陕西', '吉林', '福建', '贵州', '广东', '青海', '西藏', '四川', '宁夏', '海南', '台湾', '香港', '澳门'];

MapMetaData.prototype.buildMapData = function (_data) {
    // -data = [{citycode:xxx, cityname:xxx}, {}]
    var datas = [];
    // 初始化所有省份数据为 0，每次调用该对象方法，等于初始化置零
    for (var i = 0, j = this.provNames.length; i < j; i++) {
        var item = {name: this.provNames[i], value: 0};
        this.provIndex[this.provNames[i]] = {'index': i, 'orgs': [], 'total': 0};
        datas.push(item);
    }

    for (var i = 0, j = _data.length; i < j; i++) {
        var item = _data[i];
        var citycode = item.citycode.substring(0, 2);
        var provName = this.provCodes[citycode];
        if (provName) {
            var p = this.provIndex[provName];
            if (p) {
                p.total = p.total + item.count;
                p.orgs.push(item);
                datas[p.index].value = p.total;
            }
        }
    }
    return datas;
};

MapMetaData.prototype.buildPointMapData = function (_data, mapData) { // _data => q.data

    var sumData = [];
    for (var i = 0; i < _data.length; i++) {
        var item = _data[i];
        var citycode = item.citycode.substring(0, 2);
        var curData = {"citycode": citycode, "count": item.count};

        var tempData = {};
        $.each(sumData, function (name, dataArr) {
            if (citycode === dataArr['citycode']) {
                tempData = dataArr;
            }
        });

        if (tempData.citycode) {
            tempData.count = tempData.count + curData.count;
        } else {
            sumData.push(curData);
        }
    }

    var res = [];
    for (var i = 0; i < sumData.length; i++) {
        var item = sumData[i];
        var citycode = item.citycode.substring(0, 2);
        var provName = this.provCodes[citycode];
        for (var m = 0, n = mapData.length; m < n; m++) {
            var v = mapData[m];
            if (v.name == provName) {
                var pointer = {
                    name: provName,
                    value: v.cp.concat(item.count)
                };
                res.push(pointer);
            }
        }
    }
    return res;
};

// 获取所有审计机构的信息，以便在地图上显示概要信息
function countStartProjectWithCity(q) {
    var year = getCurrentYear();
    $.get(base_url + "/countStartProjectWithCity.action?tjnd=" + year, function (data) {
        $('#switchtitle').text('全系统' + year + '审计情况');
        var json = JSON.parse(data);
        if (q) q.next(json);
    });
}

// 穿透到领导查询页面
function go2OrgLeaderinquiry(orgName, orgId) {
    var winTitle = '领导查询 - ' + orgName;
    var winUrl = base_url + "/index.action?orgname=" + encodeURI(orgName) + "&tjnd=" + (getCurrentYear()) + "&tjfw=" + encodeURI(orgId);
    if (top && top.aud$openNewTab)
        top.aud$openNewTab(winTitle, winUrl, false, false);
}

// 当前选定的区域
var g_currentProv;

// 全局地图数据转换对象
var g_MapMetaData = new MapMetaData();

// 地图区域点击事件
function clickOrgLeaderinquiry(orgName, orgId) {
    if (!orgId || orgId == '0') {
        location.reload();
        return;
    }
    var currentYear = getCurrentYear();
    if (g_currentProv && g_currentProv == orgName) { // 如果是第二次点击同一区域，就穿透
        go2OrgLeaderinquiry(orgName, orgId);
        return;
    }
    new Q().then(summary).then(dtdh).then(function (q) {
        var currentYear = getCurrentYear();
        var title = (orgName + currentYear + '审计情况');//.substring(0, 12);
        $('#switchtitle').text(title);
        $('#switchtitle-new').text(title);
        g_currentProv = orgName;
    }).start({
        'tjnd': currentYear,
        'tjfw': orgId,
        'mapSearch': true
    });
}

// 地图
function buildMap(q) {
    var h = $(window).height() - 100;
    if (!isOldVersion) {
        g_indexlayout.newresize();
        h = $(window).height() - 160;
        q.data.mapSearch = true;
    } else {
        g_indexlayout.resize();
    }
    var w = $("#secondContainer").width() - 10;//60;
    var mapChart = buildCharts('mapcanvas', w, h);
    var mapOption = {
        title: {},
        tooltip: {
            trigger: 'item',
            formatter: function (params, ticket, callback) {
                var orgs = [];
                var label = params.name;
                var p = g_MapMetaData.provIndex[label];
                if (p) {
                    for (var i = 0, j = p.orgs.length; i < j; i++) {
                        var org = p.orgs[i].fname + ' 审计项目 ' + p.orgs[i].count;
                        orgs.push(org);
                    }
                }
                return label + ' ' + ' 审计项目总数 ' + params.value + '<br/>' + orgs.join('<br/>');
            }
        },
        dataRange: {
            min: 0,
            max: 100,
            text: ['', '']
        },
        heatmap: {
            gradientColors: ['blue', 'cyan', 'lime', 'yellow', 'red']
        },
        series: [{
            type: 'map',
            mapType: 'china',
            layoutCenter: ['50%', '50%'],
            layoutSize: 600,
            roam: false,
            roamController: {
                show: false,
                x: 'right',
                mapTypeControl: {
                    'china': true
                }
            },
            itemStyle: {
                normal: {
                    borderWidth: 1,//区域边框宽度
                    borderColor: '#12446d',//区域边框颜色
                    backColor: '#EEE',
                    label: {
                        show: true,
                        color: '#000',
                        textStyle: {
                            fontSize: 12
                        }
                    },
                    areaColor: ['#FFF'] //e2d9de
                },
                emphasis: {
                    label: {
                        show: true,
                        color: '#000',
                        textStyle: {
                            fontSize: 12
                        }
                    },
                    areaColor: '#FFF'//32fdff
                }
            },
            data: g_MapMetaData.buildMapData(q.data)
        }]
    };
    mapChart.setOption(mapOption);

    mapChart.on('click', function (params) {
        $('#orgsdiv').html('');
        var provName = params.name;
        var p = g_MapMetaData.provIndex[provName];
        var ostrs = ['<div class="item4orgsdiv" onclick="clickOrgLeaderinquiry(\'全系统情况\', \'0\')"><a style="color: #8b4513 !important" href="javascript:void(0);">全系统情况</a></div>'];
        var itemCount = 1;
        if (p && p.orgs && p.orgs.length > 0) {
            if (p.orgs.length == 1) {
                var org = p.orgs[0];
                ostrs.push('<div class="item4orgsdiv" onclick="clickOrgLeaderinquiry(\'' + org.fname + '\', \'' + org.audit_dept + '\')"><a style="color: #8b4513 !important" href="javascript:void(0);">' + org.fname + '</a></div>');
                clickOrgLeaderinquiry(org.fname, org.audit_dept);
            } else {
                for (var i = 0, j = p.orgs.length; i < j; i++) {
                    var o = p.orgs[i];
                    ostrs.push('<div class="item4orgsdiv" onclick="clickOrgLeaderinquiry(\'' + o.fname + '\', \'' + o.audit_dept + '\')"><a style="color: #8b4513 !important" href="javascript:void(0);">' + o.fname + '</a></div>');
                }
            }
            itemCount = p.orgs.length + 1;
        } else {
            showMessage1("当前地区没有审计项目信息");
        }
        $('#orgsdiv').html(ostrs.join(''));
        $('#orgsdiv').height(itemCount * 40);
    });
    q.nextTick();
}

//使用nav.jsp中的方法构建地图
function buildMap2(q) {
    var titleFormatter = function (params) {
        return params.name;
    };
    var contentFormatter = function (params) {
        // var label = params.name;
        // return label + ' ' + ' 审计项目 ' + params.value[2];

        var orgs = [];
        var label = params.name;
        var p = g_MapMetaData.provIndex[label];
        if (p) {
            for (var i = 0, j = p.orgs.length; i < j; i++) {
                var org = p.orgs[i].fname + ' 审计项目 ' + p.orgs[i].count;
                orgs.push(org);
            }
        }
        return label + ' ' + ' 审计项目总数 ' + params.value[2] + '<br/>' + orgs.join('<br/>');
    };

    var w = $("#secondContainer").width() - 10;//60;
    var h = $(window).height() - 160; // $(window).height() - 100
    var mapChart = buildCharts('mapcanvas', w, h);
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
                        fontSize: 12,
                        color: "#8b4513"
                    },
                    show: true
                },
                emphasis: {
                    textStyle: {
                        fontSize: 12
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
            $('#orgsdiv').html('');
            var provName = params.name;
            var p = g_MapMetaData.provIndex[provName];
            var ostrs = ['<div class="item4orgsdiv" onclick="clickOrgLeaderinquiry(\'全系统情况\', \'0\')"><a style="color: #8b4513 !important" href="javascript:void(0);">全系统情况</a></div>'];
            var itemCount = 1;
            if (p && p.orgs && p.orgs.length > 0) {
                if (p.orgs.length == 1) {
                    var org = p.orgs[0];
                    var proName = org.fname;
                    if (org.fname.length > 5) {
                        org.fname = org.fname.substr(0, 5) + "..."
                    }
                    ostrs.push('<div class="item4orgsdiv" style="width: 82px" onclick="clickOrgLeaderinquiry(\'' + proName + '\', \'' + org.audit_dept + '\')"><a style="color: #8b4513 !important" href="javascript:void(0);">' + org.fname + '<span class="tooltiptext">' + proName + '</span></a></div>');
                    clickOrgLeaderinquiry(proName, org.audit_dept);
                } else {
                    for (var i = 0, j = p.orgs.length; i < j; i++) {
                        var o = p.orgs[i];
                        var proName = o.fname;
                        if (o.fname.length > 5) {
                            o.fname = o.fname.substr(0, 5) + "..."
                        }
                        ostrs.push('<div class="item4orgsdiv"  style="width: 82px" onclick="clickOrgLeaderinquiry(\'' + proName + '\', \'' + o.audit_dept + '\')"><a style="color: #8b4513 !important" href="javascript:void(0);">' + o.fname + '<span class="tooltiptext">' + proName + '</span></a></div>');
                    }
                }
                itemCount = p.orgs.length + 1;
            } else {
                showMessage1("当前地区没有审计项目信息");
            }
            $('#orgsdiv').html(ostrs.join(''));
            $('#orgsdiv').height(itemCount * 40);
        }
    });
    g_indexlayout.newresize();
    if (q) q.next();
}

/**
 * 项目同期比年度切换事件
 * @param type 不同的页签显示
 */
function changeYear(type) {
    var selected = $("#" + type).val();
    if ('xmtqbnd' === type) {
        xmtqb(Q, selected);
    } else if ('wtpmnd' === type) {
        wtpm(Q, selected);
    } else if ('wttqbnd' === type) {
        wttqb(Q, selected);
    } else if ('wtzgqknd' === type) {
        wtzgqk(Q, selected);
    }
}

/**
 * 按照不同的统计维度切换事件
 * @param type 页签类型
 * @param param 统计维度
 */
function changeType(type, param) {
    var selected = $("#" + type).val();
    if ('xmtqbnd' === type) {
        xmtqb(Q, selected, param);
    } else if ('wtpmnd' === type) {
        wtpm(Q, selected, param);
    } else if ('wttqbnd' === type) {
        wttqb(Q, selected, param);
    } else if ('wtzgqknd' === type) {
        wtzgqk(Q, selected, param);
    } else if ('xmpm' === type) {
        xmpm(Q, selected, param);
    }
}



// 每个热点穿透的汇集事件，判断并打开不同页签
function goTabWithOption(opts) {


    var selectedOrgByCz = orgIds;
    var selectAuditIds = auditIds;

    var selectedOrg = $("#tjfw").combotree("getValues") == "" ? "" : $("#tjfw").combotree("getValues")
    var selectedYear = $("#tjnd").combotree("getValue") == "" ? "2020" : $("#tjnd").combotree("getValue")

    var orgSelect;
    var auditSelect;
    var arr = new Array();
    var arrAudit = new Array();

    for (var t = 0; t < selectAuditIds.length; t++) {
        arrAudit.push(selectAuditIds[t]);
    }
    auditSelect = arrAudit.toString();
    auditSelect = auditSelect.replace(/,/g, ";");


    if (selectedOrg.length == 0) {

        for (var i = 0; i < selectedOrgByCz.length; i++) {
            arr.push(selectedOrgByCz[i])
        }
        orgSelect = arr.toString();
        orgSelect = orgSelect.replace(/,/g, ";");
    } else if (selectedOrg.length == 1) {
        orgSelect = selectedOrg[0];
    } else {
        orgSelect = selectedOrg.toString();
        orgSelect = orgSelect.replace(/,/g, ";");
    }

    if (opts == 0) return;
    var winTitle = opts;
    var winUrl = "about:blank";
    var sjdwData = '';
    if (opts == "法规制度") {
        winUrl = "/ais/pages/assist/suport/lawsLib/index.action?mCodeType=flfg&m_view=view";
    } else if (opts == '项目数量') {
        winUrl = "/ais/Leadershipinquiry/projectCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "计划数量") {
        winUrl = "/ais/Leadershipinquiry/planCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "底稿") {
        winUrl = "/ais/Leadershipinquiry/dgCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "问题") {
        winUrl = "/ais/Leadershipinquiry/problemCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "已整改") {
        winUrl = "/ais/Leadershipinquiry/problemRectifyCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "报告") {
        winUrl = "/ais/Leadershipinquiry/reportCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "人员状态") {
        winUrl = "/ais/mng/examproject/members/audProjectMembersInfo/toList.action?ldst=1";
        sjdwData = orgSelect;
    } else if (opts == "在审项目") {
        winUrl = "/ais/Leadershipinquiry/projectCountByFwAndNd.action?zsxm=1&proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "准备") {
        winUrl = "/ais/Leadershipinquiry/projectCountByFwAndNd.action?step=zb&proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "实施") {
        winUrl = "/ais/Leadershipinquiry/projectCountByFwAndNd.action?step=ss&proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "整改") {
        winUrl = "/ais/Leadershipinquiry/projectCountByFwAndNd.action?step=zg&proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "归档") {
        winUrl = "/ais/Leadershipinquiry/projectCountByFwAndNd.action?step=da&proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "完结") {
        winUrl = "/ais/Leadershipinquiry/projectCountByFwAndNd.action?step=wc&proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "项目数量排名") {
        winUrl = "/ais/project/projectCountRank.action";
    } else if (opts == "审计人才") {
        winUrl = "/ais/Leadershipinquiry/sjrcCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "审计机构") {
        winUrl = "/ais/Leadershipinquiry/sjjgCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "被审计单位") {
        winUrl = "/ais/Leadershipinquiry/bsjdwCountByFwAndNd.action?proyear=" + selectedYear;
        sjdwData = orgSelect;
    } else if (opts == "审计事项") {
        winUrl = "/ais/aml/index.action?flag=1";
    } else if (opts == "审计方案") {
        winUrl = "/ais/operate/template/searchMain.action";
    } else if (opts == "审计案例") {
        winUrl = "/ais/pages/assist/suport/lawsLib/index.action?m_view=view&mCodeType=sjal&querySource=grid";
        sjdwData = orgSelect;
    }  else if (opts == "问题数排名") {
        winUrl = "/ais/proledger/problem/rankingAuditQuestions.action?dtylWts=1";
    } else if (opts == "整改率排名") {
        winUrl = "/ais/proledger/problem/queryMendAnalyse.action?dtyl=1";
        sjdwData = orgSelect;
    }

    window.parent.addTab('tabs',winTitle,winTitle,winUrl, true, sjdwData);
}

function switchMapStyle() {
    var url = location.href;
    if (/index\.jsp/g.test(url)) {
        location.href = "./nav.jsp";
    } else {
        location.href = "./index.jsp";
    }
}

function xmslSort(init) {
    var sortUrl = xmpmUrl;
    if (!init) {
        if ($("#xmslsort").attr("class").indexOf("sort-desc") > -1) {
            sortUrl = sortUrl + "&sort=1"
        }
    }
    $.get(sortUrl, function (xmpmData) {
        var xmpmData = JSON.parse(xmpmData);
        var members = [];
        var count = getItemOfHeight(xmpmData.length);

        if(isSmallScreen){
            for (var i = 0, j = count > 6 ? 6 : count; i < j; i++) {
                var item = xmpmData[i];
                var num = parseInt(i + 1);
                members.push(buildSortItem(num, item.fname, item.count + ''));
            }
        }else{
            for (var i = 0, j = count; i < j; i++) {
                var item = xmpmData[i];
                var num = parseInt(i + 1);
                members.push(buildSortItem(num, item.fname, item.count + ''));
            }
        }


        $("#xmpmsl").html(members.join("\n"));

        if (!init) {
            setSortClass("xmslsort");
        }
    });
}

function wtsSort(init) {
    var sortUrl = wtsUrl;
    if (!init) {
        if ($("#wtssort").attr("class").indexOf("sort-desc") > -1) {
            sortUrl = sortUrl + "&sort=1"
        }
    }
    $.get(sortUrl, function (wtsData) {
        var wtsData = JSON.parse(wtsData);
        var members = [];
        var count = getItemOfHeight(wtsData.length);
        if(isSmallScreen){
            for (var i = 0, j = count > 6 ? 6 : count; i < j; i++) {
                var item = wtsData[i];
                var num = parseInt(i + 1);
                members.push(buildSortItem(num, item.title, item.count + ''));
            }
        }else{
            for (var i = 0, j = count; i < j; i++) {
                var item = wtsData[i];
                var num = parseInt(i + 1);
                members.push(buildSortItem(num, item.title, item.count + ''));
            }
        }

        $("#wtsl").html(members.join("\n"));

        if (!init) {
            setSortClass("wtssort");
        }
    });
}

function zglSort(init) {
    var sortUrl = zglUrl;
    if (!init) {
        if ($("#zglsort").attr("class").indexOf("sort-desc") > -1) {
            sortUrl = sortUrl + "&sort=1"
        }
    }
    $.get(sortUrl, function (zglData) {
        var zglData = JSON.parse(zglData);
        var members = [];
        var count = getItemOfHeight(zglData.length);
        if(isSmallScreen){
            for (var i = 0, j = count > 6 ? 6 : count; i < j; i++) {
                var item = zglData[i];
                var zgTotal = item.zgz + item.yzg + item.wzg;
                var zgs = (item.yzg / zgTotal) * 100;
                zgs = zgs.toFixed(2) ;
                var num = parseInt(i + 1);
                if (window.isNaN(zgs) || zgs === 0) {
                    zgs = 0.00;
                }
                members.push(buildSortItem1(num, item.fname, zgs + '%'));
            }
        }else{
            for (var i = 0, j = count; i < j; i++) {
                var item = zglData[i];
                var zgTotal = item.zgz + item.yzg + item.wzg;
                var zgs = (item.yzg / zgTotal) * 100;
                zgs = zgs.toFixed(2) ;
                var num = parseInt(i + 1);
                if (window.isNaN(zgs) || zgs === 0) {
                    zgs = 0.00;
                }
                members.push(buildSortItem1(num, item.fname, zgs + '%'));
            }
        }

        $("#zglpm").html(members.join("\n"));

        if (!init) {
            setSortClass("zglsort");
        }
    });
}


var buildSortItem = function (num, cell1, cell2) {


    var subCell = cell1;

    if (cell1.length > 10) {
        cell1 = cell1.substr(0, 10) + "..."
    }


    var itemWidth = $(".block-Container").width() - 6;
    var numWidth = 16;
    var cell1PaddingLeft = 5;
    var cell1Width = (itemWidth - numWidth - cell1PaddingLeft) * 0.7 / 1;
    var cell2Width = itemWidth - numWidth - cell1Width - cell1PaddingLeft;

    var hotClass = "";

    //设置排序图标位置，在数值的上方(排序图标宽12)
    if (num == 1) {
        $(".sort-image").css("margin-right", cell2Width / 2 - 12 / 2);
    }
    if (num <= 3) {
        hotClass = "sort-hot" + num;
    }

    var loopitemclass = "loopitem";
    var cell1Heiget = 20;
    if (isSmallScreen) {
        loopitemclass = "loopitem2";
        cell1Heiget = 18;
    }

    var itemStr = '<div class="' + loopitemclass + '">\n' +
        '<div class="sort-num ' + hotClass + '"  style="width: ' + numWidth + 'px; font-size: 13px;">' + num + '</div>\n' +
        '<div class="spliceitem"  id="cell"  style="width: ' + cell1Width + 'px; height: ' + cell1Heiget + 'px; font-size: 14px; padding-left: ' + cell1PaddingLeft + 'px; ">&nbsp;' + cell1 + ' <span class="tooltiptext">' + subCell + '</span></div>\n' +
        '<div class="spliceitem-center" style="width: ' + cell2Width + 'px; font-size: 14px;">' + cell2 + '</div>\n' +
        '</div>';
    return itemStr;
}

var buildSortItem1 = function (num, cell1, cell2) {


    var subCell = cell1;

    if (cell1.length > 10) {
        cell1 = cell1.substr(0, 10) + "..."
    }

    if(cell2 == "0%"){
        cell2 = "0.00%";
    }

    var itemWidth = $(".block-Container").width() - 6;
    var numWidth = 16;
    var cell1PaddingLeft = 5;
    var cell1Width = (itemWidth - numWidth - cell1PaddingLeft) * 0.7 / 1;
    var cell2Width = itemWidth - numWidth - cell1Width - cell1PaddingLeft;

    var hotClass = "";

    //设置排序图标位置，在数值的上方(排序图标宽12)
    if (num == 1) {
        $(".sort-image").css("margin-right", cell2Width / 2 - 12 / 2);
    }
    if (num <= 3) {
        hotClass = "sort-hot" + num;
    }

    var loopitemclass = "loopitem";
    var cell1Heiget = 20;
    if (isSmallScreen) {
        loopitemclass = "loopitem2";
        cell1Heiget = 18;
    }

    var itemStr = '<div class="' + loopitemclass + '">\n' +
        '<div class="sort-num ' + hotClass + '"  style="width: ' + numWidth + 'px; font-size: 13px;">' + num + '</div>\n' +
        '<div class="spliceitem"  id="cell"  style="width: ' + cell1Width + 'px; height: ' + cell1Heiget + 'px; font-size: 14px; padding-left: ' + cell1PaddingLeft + 'px; ">&nbsp;' + cell1 + ' <span class="tooltiptext">' + subCell + '</span></div>\n' +
        '<div class="spliceitem-center" style="width: ' + cell2Width + 'px; font-size: 14px;text-align: right">' + cell2 + '</div>\n' +
        '</div>';
    return itemStr;
}



var setSortClass = function (id) {
    var sortClass = $("#" + id).attr("class");
    if (sortClass.indexOf("sort-desc") > -1) {
        $("#" + id).removeClass("sort-desc");
        $("#" + id).addClass("sort-asc");
        document.getElementById(id).src = "../../images/rise.png";
    } else {
        $("#" + id).removeClass("sort-asc");
        $("#" + id).addClass("sort-desc");
        document.getElementById(id).src = "../../images/decline.png";
    }
}

var getItemOfHeight = function (count) {
    var result = count;
    //var itemsOfHeight = Math.floor(($(".block-info").height() - 35) / 32);
    if (count > 10) {
        result = 10;
    }
    // if (result > itemsOfHeight) {
    //     result = itemsOfHeight;
    // }
    return result;
}


