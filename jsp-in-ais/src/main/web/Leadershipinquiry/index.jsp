<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>决策支持首页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${contextPath}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Leadershipinquiry/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Leadershipinquiry/css/main.css" media="all">
    <link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css"/>
    <script src="<%=request.getContextPath()%>/Leadershipinquiry/layui/layui.js" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/Leadershipinquiry/js/Q.js" charset="utf-8"></script>
    <script src="<%=request.getContextPath()%>/Leadershipinquiry/js/search.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script src="<%=request.getContextPath()%>/index/assets/global/plugins/echarts/echarts.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon_A6.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
    <style>
        .layui-col-md2{
            width: 16.4%;
        }
        .title-border{
            border:1px solid #e6e6e6;
            margin-bottom:0px!important;
        }
        .portlet-title{
            min-height:30px!important;
        }
        .portlet-title > .tools{
            padding-top:0px!important;
            padding-bottom:0px!important;
            padding-right:10px!important;
            margin-top:4px!important;
            float: right;
        }
        .rowTitleWrap{
            display:inline;
            position:relative;
            float:left;
            width:150px;
            cursor: auto;
        }
        .rowTitle-active{
            opacity:1;
            -moz-opacity:1;
            filter:alpha(opacity=100);
            font-weight:bold;
            color:gray;
        }
        .rowTitle{
            color: #333;
            font-weight:bold;
            font-size:15px;
            padding-left:10px;
            height:27px;
            line-height:27px;
        }
        .rowTitleLogo{
            background: url('${contextPath}/index/assets/global/img/a7/rowTitleLogo.png') no-repeat center;
            float:left;
            margin-left:10px;
            margin-top:11px;
            width:6px;
            height:7px;
        }
        .titleTip{
            color:white;
            background-color:red;
            border-radius:30px!important;
            position:absolute;
            bottom:7px;
            font-size:12px;
            width:20px;
            text-align:center;
            opacity:0.5;
            -moz-opacity:0.5;
            filter:alpha(opacity=70);
        }
        .rowTitle-disabled{
            color:gray;
        }
        .title-border{
            border:1px solid #e6e6e6;
            margin-bottom:0px!important;
        }

        .spliceitem-title-left {
            float: left;
            text-align: left;
            font-weight: bold;
            height: 30px;
            line-height: 30px;
            padding-top: 2px;
            padding-bottom: 2px;
            background:#e3eefd;
        }

        .spliceitem-title {
            float: left;
            text-align: center;
            font-weight: bold;
            height: 30px;
            line-height: 30px;
            padding-top: 2px;
            padding-bottom: 2px;
            background:#e3eefd;
        }
    </style>
    <script>
        function reloadResize() {
            g_indexlayout.resize();
        }
    </script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden; background-color: white;" class="easyui-layout" border='0' onresize="reloadResize();">
<div class="decision">
    <div style="clear: both;">
        <span id="tjfwlabel" style="display: block;float: left;margin-top: 3px;margin-left:10px;">统计范围：</span>
        <span id="" style="display: block;float: left; font-size: 14px;margin-top: 3px"><%=request.getAttribute("ctorgname")%></span>
        <div id="fyycn" style="float: left; width: 205px;">
            <select id="tjfw" class="easyui-combotree" style="width:200px;height: 27px; border-radius: 4px;"
                              data-options="url:'${pageContext.request.contextPath}/Leadershipinquiry/orgListByAsyn.action',multiple:true,cascadeCheck:false">
        </select>
           <%-- <select id="tjfw" class="easyui-combotree" style="width:200px;"></select>--%>
        </div>
        <span style="padding-left: 20px;margin-top: 3px;float:left;">统计年度：</span>
        <select id="tjnd" class="easyui-combobox" style="height: 29px; border-radius: 4px;float:left;">
            <option value="2029">2029</option>
            <option value="2028">2028</option>
            <option value="2027">2027</option>
            <option value="2026">2026</option>
            <option value="2025">2025</option>
            <option value="2024">2024</option>
            <option value="2023">2023</option>
            <option value="2022">2022</option>
            <option value="2021">2021</option>
            <option value="2020" selected="selected">2020</option>
            <option value="2019">2019</option>
            <option value="2018">2018</option>
            <option value="2017">2017</option>
            <option value="2016">2016</option>
            <option value="2015">2015</option>
            <option value="2014">2014</option>
            <option value="2013">2013</option>
            <option value="2012">2012</option>
            <option value="2011">2011</option>
            <option value="2010">2010</option>
        </select>
        <div class="refresh-btn" onclick="doSearch('refresh')">刷新</div>
    </div>
    <div class="mainContainer">
        <div class="topContainer" style="width: 98%">
        	<!--  -->
			<div class="groupBg1 groupPadding " title="计划数量" onclick="goTabWithOption('计划数量')">
				<div class="groupBg1_logo groupLogo"></div>
				<span class="groupText" >计划总数(个)</span>
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
        <div style="background-color: #FFF; /*padding: 4px 4px;*/">
            <div class="secondContainer" id="secondContainer">
                <div class="layui-tab">
                    <ul class="layui-tab-title barBg" style="height:27px!important;border:1px solid #e6e6e6;">
                    	<span class="rowTitleLogo"></span>
                        <li class="layui-this tabitemradius">项目总览</li>
                        <li class="tabitemradius">项目排名</li>
                        <li class="tabitemradius">项目同期比</li>
                        <li class="tabitemradius">问题排名</li>
                        <li class="tabitemradius">问题同期比</li>
                        <li class="tabitemradius">问题整改情况</li>
                    </ul>
                    <div id='secondContainerContent' class="layui-tab-content" style="height:500px;border:1px solid #e6e6e6;border-top-width:0px;">
                        <%--项目总览--%>
                        <div class="layui-tab-item layui-show">
                            <div>
                                <div>
                                    <div id="xmzlDiv" style="float:left; width: 100px;">
                                    </div>
                                    <div class="mainContent" style="float: left; margin-left: 5px;">
                                        <div id="xmfbcanvas" style="float: left;"></div>
                                        <div id="wclcanvas" style="float: left;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--项目排名--%>
                        <div class="layui-tab-item">
                            <div>
                                <div class="topRow">
                                    <input type="radio" name="xmpm" class="radioBox" value="按审计单位" id="asjdw"
                                           checked="checked"
                                           onclick="changeType('xmpm','org')"/><label
                                        class="radioText" for="asjdw" id="wtpmasjdw">按审计单位</label>
                                    <input type="radio" name="xmpm" class="radioBox" id="absjdw" value="按被审计单位"
                                           onclick="changeType('xmpm','obj')"/><label
                                        class="radioText" for="absjdw">按被审计单位</label>
                                    <input type="radio" name="xmpm" id="asjry" class="radioBox" value="按审计人员"
                                           onclick="changeType('xmpm','auditPersion')"/><label
                                        class="radioText" for="asjry">按审计人员</label>
<%--
                                    <a style="cursor: pointer;float: right;margin-right: 3%;font-size: 14px" onclick="goTabWithOption('项目数量排名')">全部</a>
--%>
                                    <img id="ldstxmpmpxxx"  style="cursor: pointer;float: right;margin-right: 1%;" title="倒序" onclick="javascript:ldcxxmpmdxSort();" src="../images/decline.png"/>
                                    <img id="ldstxmpmpxxs"  style="cursor: pointer;float: right;margin-right: 1%;" title="正序" onclick="javascript:ldcxxmpmSort();" src="../images/rise.png"/>
                                </div>
                                <div id="xmpmcanvas">
                                </div>
                            </div>
                        </div>
                        <%--项目同期比--%>
                        <div class="layui-tab-item">
                            <div>
                                <div class="topRow">
                                    <input type="radio" name="xmtqb" class="radioBox" value="按审计单位" checked="checked"
                                           id="asjdw2"
                                           onclick="changeType('xmtqbnd','org')"/><label class="radioText" for="asjdw2">按审计单位</label>
                                    <input type="radio" name="xmtqb" class="radioBox" value="按被审计单位" id="absjdw2"
                                           onclick="changeType('xmtqbnd','obj')"/><label
                                        class="radioText" for="absjdw2">按被审计单位</label>
                                    <input type="radio" name="xmtqb" class="radioBox" value="按项目类型" id="axmlx2"
                                           onclick="changeType('xmtqbnd','type')"/><label
                                        class="radioText" for="axmlx2">按项目类型</label>
<%--
                                    <a style="cursor: pointer;float: right;margin-right: 2%;font-size: 14px" onclick="goTabWithOption('项目同期比')">全部</a>
--%>

                                <%-- <select id="xmtqbnd" style="margin-left: 54%;" onchange="changeYear('xmtqbnd')"></select>--%>
                                </div>
                                <div id="xmtqbcanvas" style="height: 350px;">
                                </div>
                            </div>
                        </div>
                        <%--问题排名--%>
                        <div class="layui-tab-item">
                            <div>
                                <div class="topRow">
                                    <input type="radio" name="wtpm" class="radioBox" value="按审计单位" checked="checked"
                                           id="asjdw3"
                                           onclick="changeType('wtpmnd','org')"/><label class="radioText" for="asjdw3" id="wtpmaskdw">按审计单位</label>
                                    <input type="radio" name="wtpm" class="radioBox" value="按被审计单位" id="absjdw3"
                                           onclick="changeType('wtpmnd','obj')"/><label class="radioText" for="absjdw3">按被审计单位</label>
                                    <%-- <input type="radio" name="wtpm" class="radioBox" value="按问题类别"
                                            onclick="changeType('wtpmnd','wtlb')"/><label class="radioText">按问题类别</label>--%>
                                    <input type="radio" name="wtpm" class="radioBox" value="按重要程度" id="awtxz3"
                                           onclick="changeType('wtpmnd','wtxz')"/><label class="radioText" for="awtxz3">按重要程度</label>
                                    <input type="radio" name="wtpm" class="radioBox" value="按问题点" id="awtd3"
                                           onclick="changeType('wtpmnd','wtd')"/><label class="radioText" for="awtd3">按问题点</label>

                                    <img id="ldstwtpmpxxx"  style="cursor: pointer;float: right;margin-right: 1%;" title="倒序" onclick="javascript:ldcxwtpmdxSort();" src="../images/decline.png"/>
                                    <img id="ldstwtpmpxxs"  style="cursor: pointer;float: right;margin-right: 1%;" title="正序" onclick="javascript:ldcxwtpmSort();" src="../images/rise.png"/>
<%--
                                    <img id="ldstwtjgfx"  style="cursor: pointer;float: right;margin-right: 1%;height: 20px" title="问题结构分析" onclick="javascript:goTabWithOption('问题结构分析');" src="../images/tubiao.png"/>
--%>
                                </div>
                                <div id="wtpmcanvas">
                                </div>
                            </div>
                        </div>
                        <%--问题同期比--%>
                        <div class="layui-tab-item">
                            <div>
                                <div class="topRow">
                                    <input type="radio" name="wttqb" class="radioBox" value="按审计单位" checked="checked"
                                           id="asjdw4"
                                           onclick="changeType('wttqbnd','org')"/><label class="radioText" for="asjdw4">按审计单位</label>
                                    <input type="radio" name="wttqb" class="radioBox" value="按被审计单位"
                                           onclick="changeType('wttqbnd','obj')" id="absjdw4"/><label
                                        class="radioText" for="absjdw4">按被审计单位</label>
                                    <%-- <input type="radio" name="wttqb" class="radioBox" value="按问题类别"
                                            onclick="changeType('wttqbnd','org')"/><label class="radioText">按问题类别</label>--%>
                                    <input type="radio" name="wttqb" class="radioBox" value="按重要程度" id="awtxz4"
                                           onclick="changeType('wttqbnd','wtxz')"/><label class="radioText"
                                                                                          for="awtxz4">按重要程度</label>
                                    <input type="radio" name="wttqb" class="radioBox" value="按问题点" id="awtd4"
                                           onclick="changeType('wttqbnd','wtd')"/><label class="radioText" for="awtd4">按问题点</label>
<%--
                                    <a style="cursor: pointer;float: right;margin-right: 2%;font-size: 14px" onclick="goTabWithOption('问题同期比')">全部</a>
--%>

                                </div>
                                <div id="wttqbcanvas" style="width: 700px; height: 350px;">
                                </div>
                            </div>
                        </div>
                        <%--问题整改情况--%>
                        <div class="layui-tab-item">
                            <div>
                                <div class="topRow">
                                    <input type="radio" name="wtzgqk" class="radioBox" value="按审计单位" checked="checked"
                                           id="asjdw5"
                                           onclick="changeType('wtzgqknd','org')"/><label
                                        class="radioText" for="asjdw5">按审计单位</label>
                                    <input type="radio" name="wtzgqk" class="radioBox" value="按被审计单位" id="absjdw5"
                                           onclick="changeType('wtzgqknd','obj')"/><label
                                        class="radioText" for="absjdw5">按被审计单位</label>
                                    <input type="radio" name="wtzgqk" class="radioBox" value="按重要程度" id="awtxz5"
                                           onclick="changeType('wtzgqknd','wtxz')"/><label
                                        class="radioText" for="awtxz5">按重要程度</label>
                                    <input type="radio" name="wtzgqk" class="radioBox" value="按问题点" id="awtd5"
                                           onclick="changeType('wtzgqknd','wtd')"/><label
                                        class="radioText" for="awtd5">按问题点</label>
                                   <%-- <img id="ldstwtzgqkpxxx"  style="cursor: pointer;float: right;margin-right: 1%;" title="倒序" onclick="javascript:ldcxwtzgqkdxSort();" src="../images/decline.png"/>
                                    <img id="ldstwtzgqkxxs"  style="cursor: pointer;float: right;margin-right: 1%;" title="正序" onclick="javascript:ldcxwtzgqkSort();" src="../images/rise.png"/>--%>
                                </div>
                                <div id="wtzgqkbcanvas" style="width: 700px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="right">
                <div class="block-right">
                    <div class="portlet-title barBg title-border">
                        <div class="rowTitleWrap">
                            <span class="rowTitle" id="zsxm">在审项目</span>
                            <span class="rowTitleLogo"></span>
                        </div>
                        <div class="tools">
                            <a href="javascript:;" id="zsxm_more" title="更多">更多
                                <i class="fa fa-angle-double-right"></i>
                            </a>
                        </div>
                    </div>
                    <div class="rightContainer" style="padding-top:5px;padding-left:5px;overflow: hidden;">
                        <div style="font-weight:bold;color:#838fa1!important;">
                            <div class="spliceitem-title-left" id = "right_zsxmmc">项目名称</div>
                            <div class="spliceitem-title" id = "right_zsxmjd">阶段</div>
                        </div>
                        <div id="zsxmcontent" style="overflow: hidden;"></div>
                    </div>
                </div>
                <div class="block-right">

                    <div class="portlet-title barBg title-border">
                        <div class="rowTitleWrap">
                            <span class="rowTitle" id="ryzt">人员状态</span>
                            <span class="rowTitleLogo"></span>
                        </div>
                        <div class="tools">
                            <a href="javascript:;" id="ryzt_more" title="更多">更多
                                <i class="fa fa-angle-double-right"></i>
                            </a>
                        </div>
                    </div>
                    <div class="rightContainer" style="padding-top:5px;padding-left:5px; overflow: hidden;">
                        <div style="font-weight:bold;color:#838fa1!important;">
                            <div class="spliceitem-title-left"  id="ryztxm">姓名</div>
                            <div class="spliceitem-title"  id="ryztjh">计划</div>
                            <div class="spliceitem-title"  id="ryztzs">在审</div>
                            <div class="spliceitem-title"  id="ryztys">已审</div>
                            <div class="spliceitem-title"  id="ryzthj">合计</div>
                        </div>
                        <div id="ryztcontent" style="overflow: hidden;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; clear: both; position: fixed; bottom: 5px;text-align:center;" id="jcxxDiv">

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
<script type="text/javascript">
    function doSearch(rf) {
        new Q().then(summary).sleep(50).then(overviewChart).sleep(50).then(xmtqb).then(wttqb).sleep(50).then(wtpm).sleep(50).then(xmpm).sleep(50).then(wtzgqk).finish(function () {
            if (window.console) {
                console.log('search finished.');
            }
        }).start((function () {
            var year = '<%=request.getAttribute("ctnd")%>';
            var dept = '<%=request.getAttribute("ctorgid")%>';
            var result = {};
            var tjfw;
            var tjnd;
            if(dept == "" && year == ""){
                 tjfw = $("#tjfw").combotree("getValues");
                 tjnd = $("#tjnd").combobox("getValue");

            }else{
                tjfw = [dept];
                tjnd = year;
            }

            if(tjfw.length == 1){

                $("input[name='xmpm'][value='按被审计单位']").attr("checked",true);
                $("input[name='xmpm'][value='按审计单位']").attr("disabled",true);


                $("input[name='wtpm'][value='按被审计单位']").attr("checked",true);
                $("input[name='wtpm'][value='按审计单位']").attr("disabled",true);

            }else{
                $("input[name='xmpm'][value='按审计单位']").attr("checked",true);
                $("input[name='xmpm'][value='按审计单位']").attr("disabled",false);

                $("input[name='wtpm'][value='按审计单位']").attr("checked",true);
                $("input[name='wtpm'][value='按审计单位']").attr("disabled",false);


            }
            if (tjfw) {
                result['tjfw'] = tjfw;
            }
            if (tjnd) {
                result['tjnd'] = tjnd;
            }
            if (rf == 'refresh') {

            } else {
                if (/tjfw=([^&]+)/g.test(location.href)) {
                    if (tjfw) {
                        result['tjfw'] = tjfw;
                    }
                    $('#fyycn').hide();
                }
                if (/tjnd=([^&]+)/g.test(location.href)) {
                    if (tjnd) {
                        result['tjnd'] = tjnd;
                    }
                }
            }
            return result;
        })());
    }

    layui.use('element', function () {
        var $ = layui.jquery;
        window.$ = $;
        var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
        var w = $(window).width();
        var cw = w - 490;
        $("#secondContainer").width(cw);
        //doSearch();
    });
    window.setTimeout(function () {
        doSearch();
    }, 50)
</script>
</body>
</html>
