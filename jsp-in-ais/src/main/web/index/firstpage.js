  
var FirstPageTables = function(){
  
    return {
    	homeStatistics:function(){
    		 $.getJSON(contextPath+'/portal/simple/homeStatistics.action', {'random':Math.random()},  function (json) {
				 if(json){
					 var d1 = json.d1;
					 var d2 = json.d2;
					 var d3 = json.d3;
					 var d4 = json.d4;
					 var d5 = json.d5;
					 $('#jhwcl').text(d1+"%");
					 $('#fxwts').text(d2);
					 $('#zgwcl').text(d3+"%");
					 $('#wjwgje').text(d4);
					 $('#yccwjwgzj').text(d5);
				 } 				 
    		});
    		
    	},
    	newsTable: function () {
        	var maxRows = 6;
            var newscarousel = $("#newsbody");
            var newsInfoList = $('#newsInfoList');
            newscarousel.empty();
            $.getJSON(contextPath+'/portal/simple/information/firstPageNews.action', {'random':Math.random(),'rows':maxRows,'grid':'grid','from':'firstpage','information.infstatus':'Y',
                'information.acceptorString.users':floginname,'information.acceptorString.orgs':fdepid}, function (json) {
                if (json.rows.length > 0) {
                    var carousel = '<div id="carousel-news" class="carousel image-carousel '+(json.rows.length > 1?'slide':'')+'" data-ride="carousel">';
                    var listbox = '<div class="carousel-inner" role="listbox">';
                    var indicators = '<ol class="carousel-indicators">';
                    for (var index in json.rows) {
                        var obj = json.rows[index];

                        var item ='<div class="item '+(index == 0?'active':'')+'"  style="cursor: pointer;min-height:170px;" onclick="parent.goMenu(\'图片新闻信息\',\''+contextPath+'/portal/simple/information/viewInfo.action?information.id='+obj.id+'\',\'news'+index+'\')">' +
                                    '<img src="'+contextPath+obj.imgPath+'" style="width:100%;height:170px;">' +
                                        '<div class="carousel-caption">' +
                                            obj.title +
                                        '</div>' +
                                   '</div>';
                        listbox += item;
                        var indicator = '<li data-target="#carousel-news" data-slide-to="'+index+'" class="'+(index == 0?'active':'')+'"></li>';
                        indicators += indicator;
                        
                        

                        
                        var li = '<li style="list-style-type:none;margin-left:-30px;">' +
                        '<div class="task-title" style="cursor: pointer;" onclick="parent.goMenu(\'图片新闻信息\',\''+contextPath+'/portal/simple/information/viewInfo.action?information.id='+obj.id+'\',\'news'+index+'\')">' +

                        '<span class="task-title-sp" title="'+obj.title+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:70%;display: inline-block;">' +                     
                        obj.title +  '</span>' +
                        '<span style="position:absolute;right:0px;">['+obj.createdate.substr(0,10)+']</span>' +
                        '</div>' +
                        '</li>';
                        newsInfoList.append(li);
                        
                        
                    }
                    listbox += '</div>';
                    indicators += '</ol>';
                    carousel += listbox;
                    if(json.rows.length > 1) {
                        var arrow = '<a class="carousel-control left" href="#carousel-news" data-slide="prev">' +
                            '<i class="m-icon-big-swapleft m-icon-white"></i>' +
                            '</a>' +
                            '<a class="carousel-control right" href="#carousel-news" data-slide="next">' +
                            '<i class="m-icon-big-swapright m-icon-white"></i>' +
                            '</a>';
                        carousel += arrow;
                    }
                    carousel += indicators;
                    carousel += '</div>';
                    carousel += '<script type="text/javascript">$(\'#carousel-news\').carousel(); </script>';
                    newscarousel.append(carousel);
                }else{
                    newscarousel.append('<h3 style="text-align:center;">暂时没有发表的审计新闻</h3>');
                }
            });
        },
    	todoTaskTable: function () {
            var taskList = $("#todoTaskTable").find("tbody");
            taskList.html('');
            var maxRows = 5;
            taskList.empty();
            $.getJSON(contextPath+'/portal/simple/getPendingTask.action', {'random':Math.random(),'type':'auditSystem'}, function (json) {
                $('#taskTitleTip').text(json.rows.length);
                if (json.rows.length > 0) {
                    for (var index in json.rows) {
                        if(index > maxRows) break;
                        var obj = json.rows[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        if(index % 2 == 1){
                            newTr.addClass('datagrid-row-alt');
                        }
                        newTr.css('border-bottom','1px solid #e6e6e6');
                        //新建节点
                        var nameTd = $("<td class='longTD' title='"+obj.formNameDetail+"'></td>");
                        var userTd = $("<td style='color:#666'></td>");
                        var timeTd = $("<td style='color:#666'></td>");
                        //新建超链接
                        var nameA = $("<a href='javascript:;' onclick=\"parent.goMenu('待办事项处理','"+contextPath+ obj.editUrl+"&flag=yes&todoback=1&project_id="+obj.project_id+"&code="+obj.plan_code+"','1')\"></a>");

                        userTd.text(obj.fromActorName);
                        timeTd.text(obj.create);
                        nameA.text(obj.formNameDetail);
                        nameTd.append(nameA);

                        newTr.append(nameTd);
                        newTr.append(userTd);
                        newTr.append(timeTd);
                        taskList.append(newTr);
                    }
                }else{
                	$('#taskTitleTip').text("0");
                    taskList.append('<h3 style="text-align:center;">您没有未处理的待办事项</h3>');
                }
            });
        },
        msgReminderTable: function () {
            var msgReminder = $("#msgReminder");
            var maxRows = 5;
            msgReminder.empty();
            $.getJSON(contextPath+'/msg/innerMsg_list.action?readFlag=2', {'random':Math.random(),'querySource':'grid'}, function (json) {
                if (json.rows.length > 0) {
                	$('#msgTitleTip').text(json.rows.length);
                    var titleRow = '<li style="background:#e3eefd;font-weight:bold;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-2" style="text-align: center;width: 62%"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '消息标题</span></div>' +
                        '<div class="col-xs-2" style="text-align: center; width: 10%"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '发送人</span></div>' +
                        '<div class="col-xs-2" style="text-align: center;width: 28%"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '发送时间</span></div>' +
                        '</div></li>';
                    msgReminder.append(titleRow);
                    for (var index in json.rows) {
                    	if(index > maxRows) break;
                        var obj = json.rows[index];
            			var f = index % 2 == 1 ;
            			var t = obj.createTime;
            			if(t){
            				t = t.replace('T',' ');
            			}
                        var li = (f ? "<li class='datagrid-row-alt'>" : '<li>') +
                            '<div class="task-title" style="cursor: pointer;color:#0088cc" onclick="refreshMsg(\'消息提醒\',\''+contextPath+'/msg/innerMsg_view.action?innerMsg.msgId='+obj.msgId+'\',\'1\')">' +
                            '<span class="task-title-sp" title="'+obj.subject+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:60%;display: inline-block;">' +
                            obj.subject +
                            '</span>' +
                            '<span class="task-title-sp" style="display: inline-block;overflow:hidden;">'+obj.fromUserName+'</span>' +
                            '<span class="task-title-sp" style="display: inline-block;overflow:hidden;float:right;width:150px;text-align:center">'+t+'</span>' +
                            '</div>' +
                            '</li>';
                        msgReminder.append(li);
                    }
                }else{
                	$('#msgTitleTip').text("0");
                    var titleRow = '<li style="background:#e3eefd;font-weight:bold;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-2" style="text-align: center;width: 62%"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '消息标题</span></div>' +
                        '<div class="col-xs-2" style="text-align: center; width: 10%"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '发送人</span></div>' +
                        '<div class="col-xs-2" style="text-align: center;width: 28%"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '发送时间</span></div>' +
                        '</div></li>';
                    msgReminder.append(titleRow);
                	msgReminder.append('<h3 style="text-align:center;">您没有消息</h3>');
                }
            });
        },
        studyGardenTable: function () {
        	var maxRows = 6;
            var gardenList = $("#studyGarden");
            gardenList.empty();
            $.getJSON(contextPath+'/portal/simple/information/searchStudyGarden.action', {'random':Math.random(),'rows':maxRows,'grid':'grid',
                'studyGardenPlot.acceptorString.users':floginname,'studyGardenPlot.acceptorString.orgs':fdepid}, function (json) {
                if (json.rows.length > 0) {

                    for (var index in json.rows) {
                    	if(index > maxRows) break;
                        var obj = json.rows[index];
            			var f = index % 2 == 1 ;
                        var li = (f ? "<li class='datagrid-row-alt'>" : '<li>') +
                            '<div class="task-title" style="cursor: pointer;" onclick="parent.goMenu(\'学习园地信息\',\''+contextPath+'/portal/simple/information/viewStudyGarden.action?studyGardenPlot.id='+obj.id+'\',\'garden'+index+'\')">' +
                            '<span class="task-title-sp" title="'+obj.title+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:90%;display: inline-block;">' +
                            obj.title +
                            '</span>' +
                            //'<span style="position:absolute;left: 45%;">'+obj.creator_name+'</span>' +
                            //(obj.new ? '<span class="label label-sm label-warning pull-right">new</span>':('<span class="label label-sm label-default pull-right">'+obj.tempDate+'</span>'))
                            '</div>' +
                            '</li>';
                        gardenList.append(li);
                    }
                }else{
                    gardenList.append('<h3 style="text-align:center;">暂时没有发表的学习内容</h3>');
                }
            });
        },
        informationTable: function () {
        	var maxRows = 6;
            var infoList = $("#infoTable");
            infoList.empty();
            $.getJSON(contextPath+'/portal/simple/information/searchInfo.action', {'random':Math.random(),'rows':maxRows,'grid':'grid','from':'firstpage','information.infstatus':'Y',
                'information.acceptorString.users':floginname,'information.acceptorString.orgs':fdepid}, function (json) {
                if (json.rows.length > 0) {

                    for (var index in json.rows) {
                        var obj = json.rows[index];
                        var li = '<li style="padding:5px;">' +
                            '<div class="task-title" style="cursor: pointer;" onclick="parent.goMenu(\'通知公告信息\',\''+contextPath+'/portal/simple/information/viewInfo.action?information.id='+obj.id+'\',\'info'+index+'\')">' +
                            '<span class="task-title-sp" title="'+obj.title+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:90%;display: inline-block;">' +
                            obj.title +
                            '</span>' +
                            //'<span style="position:absolute;left: 45%;">'+obj.publisher_name+'</span>' +
                            //(obj.new ? '<span class="label label-sm label-warning pull-right">new</span>':('<span class="label label-sm label-default pull-right">'+(obj.createdate != null?obj.createdate.substring(0,10):'')+'</span>')) +
                            '</div>' +
                            '</li>';
                        infoList.append(li);
                    }
                }else{
                    infoList.append('<h3 style="text-align:center;">暂时没有发布的通知公告</h3>');
                }
            });
        },
        projectProcessTable: function () {
        	var maxRows = 6;
            var projectProcess = $("#projectProcess");
            projectProcess.empty();
            $.getJSON(contextPath+'/project/listAll.action', {'random':Math.random(),'rows':maxRows,'querySource':'grid'}, function (json) {
                if (json.rows.length > 0) {
                    var titleRow = '<li style="padding:5px;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-4">' +
                        '<span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '项目名称' +
                        '</span>' +
                        '</div>' +
                        '<div class="col-xs-3">' +
                        '<span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '项目类别' +
                        '</span>' +
                        '</div>' +
                        '<div class="col-xs-1">' +
                        '<span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '准备' +
                        '</span>' +
                        '</div>' +
                        '<div class="col-xs-1">' +
                        '<span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '实施' +
                        '</span>' +
                        '</div>' +
                        '<div class="col-xs-1">' +
                        '<span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '终结' +
                        '</span>' +
                        '</div>' +
                        '<div class="col-xs-1">' +
                        '<span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '档案' +
                        '</span>' +
                        '</div>' +
                        '<div class="col-xs-1">' +
                        '<span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                        '整改' +
                        '</span>' +
                        '</div>' +
                        '</div>' +
                        '</li>';
                    projectProcess.append(titleRow);
                    var prepare,actualize,report,archives,rework;
                    for (var index in json.rows) {
                        var obj = json.rows[index];
                        var stage = '';
                        if(obj.planProcess == 'simplified'){
                            stage = 'simplified';
                        }else {
                            if (obj.prepare_closed && obj.prepare_closed == '0') {
                                stage = "prepare";
                            } else if (obj.actualize_closed && obj.actualize_closed == '0') {
                                stage = "actualize";
                            } else if (obj.report_closed && obj.report_closed == '0') {
                                stage = "report";
                            } else if (obj.archives_closed && obj.archives_closed == '0') {
                                stage = "archives";
                            }else{
                                stage = "prepare";
                            }
                        }
                        if(obj.prepare_closed == '1'){
                            prepare = '已完成';
                        }else if(obj.prepare_closed == '0'){
                            prepare = '进行中';
                        }else{
                            prepare = '未执行';
                        }
                        if(obj.report_closed == '1'){
                            actualize = '已完成';
                            report = '已完成';
                        }else if(obj.report_closed == '0'){
                            actualize = '进行中';
                            report = '进行中';
                        }else{
                            actualize = '未执行';
                            report = '未执行';
                        }

                        if(obj.archives_closed == '1'){
                            archives = '已完成';
                        }else if(obj.archives_closed == '0'){
                            archives = '进行中';
                        }else{
                            archives = '未执行';
                        }

                        if(obj.rework_closed == '1'){
                            rework = '已完成';
                        }else if(obj.rework_closed == '0'){
                            rework = '进行中';
                        }else{
                            rework = '未执行';
                        }
                        var li = '<li>' +
                                    '<div class="task-title row" style="cursor: pointer;" onclick="goProjectMenu(\''+obj.formId+'\',\''+stage+'\')">' +
                                        '<div class="col-xs-4">'+
                                            '<span class="task-title-sp" title="'+obj.project_name+'" style="overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                            obj.project_name +
                                            '</span>' +
                                        '</div>'+
                                        '<div class="col-xs-3">'+
                                            '<span class="task-title-sp" title="'+obj.pro_type_name+'" style="overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                            obj.pro_type_name +
                                            '</span>' +
                                        '</div>'+
                                        '<div class="col-xs-1">'+
                                            '<span class="task-title-sp" title="'+prepare+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                                            prepare +
                                            '</span>' +
                                        '</div>'+
                                        '<div class="col-xs-1">'+
                                            '<span class="task-title-sp" title="'+actualize+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                                            actualize +
                                            '</span>' +
                                        '</div>'+
                                        '<div class="col-xs-1">'+
                                            '<span class="task-title-sp" title="'+report+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                                        report +
                                            '</span>' +
                                        '</div>'+
                                        '<div class="col-xs-1">'+
                                            '<span class="task-title-sp" title="'+archives+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                                            archives +
                                            '</span>' +
                                        '</div>'+
                                        '<div class="col-xs-1">'+
                                            '<span class="task-title-sp" title="'+rework+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                                            rework +
                                            '</span>' +
                                    '</div></div>' +
                                '</li>';
                        projectProcess.append(li);
                    }
                }else{
                    projectProcess.append('<h3 style="text-align:center;">当年没有项目</h3>');
                }
            });
        },
        initCalendar: function() {
            if (!jQuery().fullCalendar) {
                return;
            }

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            var h = {};

            if ($('#calendar').width() <= 400) {
                $('#calendar').addClass("mobile");
                h = {
                    left: 'title, prev, next',
                    center: '',
                    right: 'today,month,agendaWeek,agendaDay'
                };
            } else {
                $('#calendar').removeClass("mobile");
                h = {
                    left: 'title',
                    center: '',
                    right: 'prev,next,today,month,agendaWeek,agendaDay'
                };
            }

            $('#calendar').fullCalendar('destroy'); // destroy the calendar
            $('#calendar').fullCalendar({ //re-initialize the calendar
                disableDragging: true,
                header: h,
                height:400,
                contentHeight:400,
                editable: false,
                events:function(start,end,timezone, callback) {
                    var date = this.getDate().format('YYYY-MM');
                    $.ajax({
                        url: contextPath+'/plan/detail/findWorkPlanCalendar.action',
                        dataType: 'json',
                        data: {
                            date: date,
                        },
                        success: function(json) { // 获取当前月的数据
                            var events = [];
                            if (json.events.length > 0) {
                                $.each(json.events,function(i,c) {
                                    var labelColor = App.getBrandColor(c.color);
                                    events.push({
                                        title: c.name,
                                        start: c.start , // will be parsed
                                        color: labelColor
                                    });

                                });
                            }
                            callback(events);
                        }
                    });
                },
                eventRender:function(event,element,view){
                    element.qtip({
                       content:{
                           text:event.title
                       },
                        style:{
                           classes:'qtip-blue qtip-rounded'
                        }
                    });
                },
                views: {
                    agenda: {
                        eventLimit: 5
                    },
                    month: {
                        eventLimit: 2
                    }
                }
            });
        },
        myProjectTable: function () {

            var chart = document.getElementById('projectEcharts');
            var echart = echarts.init(chart);

            echart.showLoading({
                text:'数据加载中，请稍后...'
            });
            $.ajaxSettings.async = false;

            var series = [];
            var legend = [];
            $.getJSON(contextPath+'/project/projectProgress.action',{'random':Math.random()},function(json){
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
                height:300,
                width:300,
                series : series,
                color:['#50acc4','#7f66a0', '#9bb95f', '#f5954f', '#5282bb','#be5150',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']
            };

            echart.setOption(options);
            echart.hideLoading();
            $(window).resize(function () {
                //重置容器高宽
                echart.resize();
            });
        },
        planPieChart:function(){
            var chart = document.getElementById('planEcharts');

            $.ajaxSettings.async = false;

            var series = [];
            var legend = [];
           
            $.getJSON(contextPath+'/project/projectStatistics.action',{'random':Math.random()},function(json){
                legend = json.legend;
                series = json.series;
            });
            if(series && legend && legend.length>0){ 
          
                var echart = echarts.init(chart);

                echart.showLoading({
                    text:'数据加载中，请稍后...'
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
            	$(window).resize(function () {
            		//重置容器高宽
            		echart.resize();
            	});
            	echart.on('click', function(param){
            		//for(var p in param.data) alert(p+"="+param.data[p])
            		//alert(param.name+","+param.value+","+param.dataIndex+","+param.data)
            		if(param && param.data){
            			var data = param.data;
            			var status = data.status;
            			var name = data.name;
            			var winUrl = contextPath + "/portal/simple/inspectPageInfo.action?model=planInfo&planStatus="+status;
            			openInpectModelWindow("计划信息查看(" + name + ")", winUrl);
            		}
            	})
            }else{            	
            	$(chart).empty().append('<h3 style="text-align:center;">暂时没有信息</h3>');
            }

        },
        planWeatherChart:function(){
            var chart = document.getElementById('planEcharts');

            $.ajaxSettings.async = false;

            var unImpList = [];
            var totalList = [];
            var nameList = [];
           
            $.getJSON(contextPath+'/project/projectStatisticsBar.action',{'random':Math.random()},function(json){
            	totalList = json.totalList;
            	unImpList = json.unImpList;
            	nameList = json.nameList;
            });
            if(totalList){ 
          
                var echart = echarts.init(chart);

               /* echart.showLoading({
                    text:'数据加载中，请稍后...'
                });*/
                var options = {
                		   tooltip : {
                		        trigger: 'axis',
                		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                		        },
                		        formatter: function (params){
                		            return params[0].name + '<br/>'
                		                   + '已完成' + ' : ' + params[0].value + '<br/>'
                		                   + '全部计划' + ' : ' + (params[1].value + params[0].value);
                		        }
                		    },
                	    legend: {
                	        selectedMode:false,
                	        data:['全部计划', '未完成']
                	    },
                	    calculable : true,
                	    xAxis : [
                	        {
                	            type : 'category',
                	            data : nameList
                	        }
                	    ],
                	    yAxis : [
                	        {
                	            type : 'value',
                	            boundaryGap: [0, 0.1]
                	        }
                	    ],
                	    series : [
                	        {
                	            name:'全部计划',
                	            type:'bar',
                	            stack: 'sum',
                	            barCategoryGap: '50%',
                	            itemStyle: {
                	                normal: {
                	                    color: '#337ab7',
                	                    barBorderColor: '#337ab7',
                	                    barBorderWidth: 4,
                	                    barBorderRadius:0,
                	                    label : {
                	                        show: true, position: 'insideTop'
                	                    }
                	                }
                	            },
                	            data:totalList
                	        },
                	        {
                	            name:'未完成',
                	            type:'bar',
                	            stack: 'sum',
                	            itemStyle: {
                	                normal: {
                	                    color: '#fff',
                	                    barBorderColor: '#337ab7',
                	                    barBorderWidth: 4,
                	                    barBorderRadius:0,
                	                    label : {
                	                        show: true, 
                	                        position: 'top',
                	                        formatter: function (params) {
                	                            for (var i = 0, l = options.xAxis[0].data.length; i < l; i++) {
                	                                if (options.xAxis[0].data[i] == params.name) {
                	                                    return options.series[0].data[i] + params.value;
                	                                }
                	                            }
                	                        },
                	                        textStyle: {
                	                            color: '#337ab7'
                	                        }
                	                    }
                	                }
                	            },
                	            data:unImpList
                	        }
                	    ]
                	};
                	                    
            	
            	echart.setOption(options);
            	echart.hideLoading();
            	/*$(window).resize(function () {
            		//重置容器高宽
            		echart.resize();
            	});*/
            	echart.on('click', function(param){
            		if(param && param.name){
            			var name = param.name;
            			var winUrl = contextPath + "/portal/simple/inspectPageInfo.action?model=planInfo&name="+name;
            			openInpectModelWindow("计划信息查看(" + name + ")", winUrl);
            		}
            	})
            }else{            	
            	$(chart).empty().append('<h3 style="text-align:center;">暂时没有信息</h3>');
            }

        },
        workStandardList:function(){
/*        	var maxRows = 6;
            var workStandardList = $("#workStandardList");
            workStandardList.empty();
            $.getJSON(contextPath+'/operate/template/list.action', 
            	{'random':Math.random(), 'rows':maxRows, 'querySource':'grid'
                }, function (json) {
                //alert(json.rows)	
                if (json.rows.length > 0) {
                    for (var index in json.rows) {
                    	if(index > 7) break;
                        var obj = json.rows[index];
                        var li = '<li style="padding:5px;">' +
                            '<div class="task-title" style="cursor: pointer;" onclick="parent.goMenu(\'审计工作标准信息\',\''+contextPath+'/operate/template/mainView.action?audTemplateId='+obj.audTemplateId+'\',\'workStandard'+index+'\')">' +
                            '<span class="task-title-sp" title="'+obj.templateName+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:100%;display: inline-block;">' +
                            obj.templateName +
                            '</span></div>' +
                            '</li>';
                        workStandardList.append(li);
                    }
                }else{
                	workStandardList.append('<h3 style="text-align:center;">暂时没有信息</h3>');
                }
            });*/
        	var maxRows = 6;
            var workStandardList = $("#workStandardList");
            workStandardList.empty();
            var viewUrl = contextPath+"/pages/assist/suport/lawsLib/edit.action?m_view=true&nodeid=${nodeid}&m_str=${m_str}&marked=0&assistSuportLawslib.id=";
            $.getJSON(contextPath+'/pages/assist/suport/lawsLib/search.action?mCodeType=flfg&nodeid=-1&m_view=view&fristType=3', 
            	{'random':Math.random(), 'rows':maxRows, 'querySource':'grid'
                }, function (json) {
                if (json.rows.length > 0) {
                    for (var index in json.rows) {
                    	if(index > maxRows) break;
                        var obj = json.rows[index];
                        var li = '<li style="padding:5px;">' +
                            '<div class="task-title" style="cursor: pointer;" onclick="parent.goMenu(\'审计工作标准信息\',\''+viewUrl+obj.id+'\',\'workStandard'+index+'\')">' +
                            '<span class="task-title-sp" title="'+obj.title+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:100%;display: inline-block;">' +
                            obj.title +
                            '</span></div>' +
                            '</li>';
                        workStandardList.append(li);
                    }
                }else{
                	workStandardList.append('<h3 style="text-align:center;">暂时没有信息</h3>');
                }
            });
        },
        flfgList:function(){
        	var maxRows = 6;
            var flfgList = $("#flfgList");
            flfgList.empty();
            var viewUrl = contextPath+"/pages/assist/suport/lawsLib/edit.action?m_view=true&nodeid=${nodeid}&m_str=${m_str}&marked=0&assistSuportLawslib.id=";
            
            $.getJSON(contextPath+'/pages/assist/suport/lawsLib/search.action?mCodeType=flfg&nodeid=-1&m_view=view&fristType=2', 
            	{'random':Math.random(), 'rows':maxRows, 'querySource':'grid'
                }, function (json) {
                //alert(json.rows)	
                if (json.rows.length > 0) {
                    for (var index in json.rows) {
                    	if(index > maxRows) break;
                        var obj = json.rows[index];
                        var li = '<li style="padding:5px;">' +
                            '<div class="task-title" style="cursor: pointer;" onclick="parent.goMenu(\'法律法规信息\',\''+viewUrl+obj.id+'\',\'flfgList'+index+'\')">' +
                            '<span class="task-title-sp" title="'+obj.title+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:100%;display: inline-block;">' +
                            obj.title +
                            '</span></div>' +
                            '</li>';
                        flfgList.append(li);
                    }
                }else{
                	flfgList.append('<h3 style="text-align:center;">暂时没有信息</h3>');
                }
            });
        },
        // 计划信息
        planInfoList: function(){
        	var maxRows = 6;
            var infoList = $("#planInfoList");
            infoList.empty();
            $.getJSON(contextPath + '/commonPlug/getCustomDatagrid.action', {
                'serviceInstance':'firstPageService',
                'serviceMethod':'inspectPageInfoCusGrid',
                'boName':'workPlanYear',
                'cus_model':'planInfoList',
                'random':Math.random()
            },function(data){
            	if(data && data.rows && data.rows.length){
            		var rows = data.rows;
            		var rowsLen = rows.length;
            		if(rowsLen > maxRows){
            			rowsLen = maxRows;
            		}
            		var baseUrl = contextPath + "/portal/simple/inspectPageInfo.action?model=planInfo&busOrgFcode=";
                    var titleRow = '<li style="padding:5px;">' +
                    '<div class="task-title row" >' +
                    '<div class="col-xs-6"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '所属机构</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '即定计划</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '正在执行</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '执行完毕</span></div></div></li>';
                    infoList.append(titleRow);
            		for(var i = 0; i < rowsLen; i++){
            			var row = rows[i];
            			var suffixParam = row.title == "集团本部" ? "&busJtbb=1" : "";
            			var viewUrl = baseUrl;
            			var short = '';
            			if(row.title.length > 4) {
            				short = row.title.substring(0,2);
            			} else {
            				short = row.title;
            			}
                        var li = '<li style="padding:5px;">' +
                       // '<div class="task-title row" style="cursor: pointer;" onclick=openInpectModelWindow(\'计划信息查看\',\''+viewUrl+row.id+'\')>' +
                        '<div class="task-title row" style="" >' +
                        	'<div onclick=openInpectModelWindow(\''+short+'计划信息\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busStatus=1113,1114,8000,9000&busId='+row.id+'\') class="col-xs-6"><span class="task-title-sp" title="'+row.title+'" style="cursor:pointer;color:#0088cc;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.title + '</span></div>'+
                            '<div onclick=openInpectModelWindow(\''+short+'即定计划\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busStatus=1113,1114&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s1+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s1 + '</span></div>'+
                            '<div onclick=openInpectModelWindow(\''+short+'正在执行\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busStatus=8000&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s2+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s2 + '</span></div>'+      
                            '<div onclick=openInpectModelWindow(\''+short+'执行完毕\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busStatus=9000&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s3+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s3 + '</span></div>'+  
                        '</div></li>';
                        infoList.append(li);
            		}
            	}else{
            		infoList.append('<div style="text-align:center;"><h3>暂时没有信息</h3></div>');
            	} 
            });
        },
        // 人员信息
        userInfoList:function(){
        	var maxRows = 7;
            var infoList = $("#userInfoList");
            infoList.empty();
            $.getJSON(contextPath + '/commonPlug/getCustomDatagrid.action', {
                'serviceInstance':'firstPageService',
                'serviceMethod':'inspectPageInfoCusGrid',
                'boName':'EmployeeInfo',
                'cus_model':'userInfoList',
                'random':Math.random()
            },function(data){
            	if(data && data.rows && data.rows.length){
            		var rows = data.rows;
            		var rowsLen = rows.length;
            		if(rowsLen > maxRows){
            			rowsLen = maxRows;
            		}
            		var baseUrl = contextPath + "/portal/simple/inspectPageInfo.action?model=userInfo&busOrgFcode=";
                    var titleRow = '<li style="padding:5px;">' +
                    '<div class="task-title row" >' +
                    '<div class="col-xs-6"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '所属机构</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '审计人员</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '未排程人员</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    'T3及以上</span></div></li>';
                    infoList.append(titleRow);
            		for(var i = 0; i < rowsLen; i++){
            			var row = rows[i];
            			var suffixParam = row.title == "集团本部" ? "&busJtbb=1" : "";
            			var viewUrl = baseUrl;
            			var short = '';
            			if(row.title.length > 4) {
            				short = row.title.substring(0,2);
            			} else {
            				short = row.title;
            			}
                        var li = '<li style="padding:5px;">' +
                        //'<div class="task-title row" style="cursor: pointer;" onclick=openInpectModelWindow(\'人员列表查看\',\''+viewUrl+row.id+'\')>' +
                        '<div class="task-title row" >' +
                            '<div onclick=openInpectModelWindow(\''+short+'人员信息\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busId='+row.id+'\') class="col-xs-6"><span class="task-title-sp" title="'+row.title+'" style="cursor:pointer;color:#0088cc;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.title + '</span></div>'+
                            '<div onclick=openInpectModelWindow(\''+short+'审计人员\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s1+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s1 + '</span></div>'+
                            '<div onclick=openInpectModelWindow(\''+short+'未排程人员\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busUserWpc=1&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s2+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s2 + '</span></div>'+      
                            '<div onclick=openInpectModelWindow(\''+short+'T3及以上\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busPsLevelM3=1&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s3+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s3 + '</span></div>'+  	
                        '</div></li>';
                        infoList.append(li);
            		}
            	}else{
            		infoList.append('<div style="text-align:center;"><h3>暂时没有信息</h3></div>');
            	} 
            });
        },
        // 项目信息
        projectInfoList: function(){
        	var maxRows = 5;
            var infoList = $("#projectInfoList");
            infoList.empty();
            $.getJSON(contextPath + '/commonPlug/getCustomDatagrid.action', {
                'serviceInstance':'firstPageService',
                'serviceMethod':'inspectPageInfoCusGrid',
                'boName':'projectStartObject',
                'cus_model':'projectInfoList',
                'random':Math.random()
            },function(data){
            	if(data && data.rows && data.rows.length){
            		var rows = data.rows;
            		var rowsLen = rows.length;
            		if(rowsLen > maxRows){
            			rowsLen = maxRows;
            		}
            		var baseUrl = contextPath + "/Leadershipinquiry/projectCountByFwAndNd.action?type=1&ssxmjdtj=";
                    var titleRow = '<li style="padding:5px;background:#e3eefd;font-weight:bold;">' +
                    '<div class="task-title row" >' +
                    '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '所属机构</span></div>' +
                    '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '准备</span></div>' +
                    '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '实施|终结</span></div>' +
                    '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '归档</span></div>' +
					'<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '整改</span></div>' +
                    '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '完结</span></div>' +
					'</div></li>';
                    infoList.append(titleRow);
            		for(var i = 0; i < rowsLen; i++){
            			var row = rows[i];
            			var suffixParam = row.title == "集团本部" ? "&busJtbb=1" : "";
            			var viewUrl = baseUrl;
            			var short = '';
            			if(row.title.length > 4) {
            				short = row.title.substring(0,2);
            			} else {
            				short = row.title;
            			}
            			var f = i % 2 == 1 ;
                        var li = (f ? "<li class='datagrid-row-alt'>" : '<li >') +
                        '<div class="task-title row" >' +
                            '<div class="col-xs-2"><span class="task-title-sp" title="'+row.title+'" style="cursor:pointer;color:#0088cc;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.shortTitle + '</span></div>'+
                            '<div class="col-xs-2" onclick=openInpectModelWindow(\''+short+'准备阶段\',\''+viewUrl+row.id+suffixParam+'&step=zb\')><span class="task-title-sp" title="'+row.s1+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s1 + '</span></div>'+
                            '<div class="col-xs-2" onclick=openInpectModelWindow(\''+short+'实施|终结\',\''+viewUrl+row.id+suffixParam+'&step=ss\')><span class="task-title-sp" title="'+row.s2+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s2 + '</span></div>'+      
                            '<div class="col-xs-2" onclick=openInpectModelWindow(\''+short+'项目归档\',\''+viewUrl+row.id+suffixParam+'&step=da\')><span class="task-title-sp" title="'+row.s3+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s3 + '</span></div>'+  
							'<div class="col-xs-2" onclick=openInpectModelWindow(\''+short+'整改阶段\',\''+viewUrl+row.id+suffixParam+'&step=zg\')><span class="task-title-sp" title="'+row.s4+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s4 + '</span></div>'+ 	
                            '<div class="col-xs-2" onclick=openInpectModelWindow(\''+short+'已完结\',\''+viewUrl+row.id+suffixParam+'&step=wc\')><span class="task-title-sp" title="'+row.s5+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s5 + '</span></div>'+ 
                        '</div></li>';
                        infoList.append(li);
            		}
            	}else{
            		infoList.append('<div style="text-align:center;"><h3>暂时没有信息</h3></div>');
            	} 
            });
        },
        // 成果信息
        resultInfoList:function(){
        	var maxRows = 7;
            var infoList = $("#resultInfoList");
            infoList.empty();
            $.getJSON(contextPath + '/commonPlug/getCustomDatagrid.action', {
                'serviceInstance':'firstPageService',
                'serviceMethod':'inspectPageInfoCusGrid',
                'boName':'MiddleLedgerProblem',
                'cus_model':'resultInfoList',
                'random':Math.random()
            },function(data){
            	if(data && data.rows && data.rows.length){
            		var rows = data.rows;
            		var rowsLen = rows.length;
            		if(rowsLen > maxRows){
            			rowsLen = maxRows;
            		}
            		var baseUrl = contextPath + "/portal/simple/inspectPageInfo.action?model=resultStatistics&busOrgFcode=";
					var baseUrl2= contextPath + "/portal/simple/inspectPageInfo.action?model=findPbList&busOrgFcode=";
					var baseUrl3= contextPath + "/portal/simple/inspectPageInfo.action?model=reformPbList&busOrgFcode=";
                    var titleRow = '<li style="padding:5px;">' +
                    '<div class="task-title row" >' +
                    '<div class="col-xs-6"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '审计单位</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '审计项目</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '发现问题</span></div>' +
                    '<div class="col-xs-2"><span class="task-title-sp" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display: inline-block;">' +
                    '已整改问题</span></div>' +
					'</div></li>';
                    infoList.append(titleRow);
            		for(var i = 0; i < rowsLen; i++){
            			var row = rows[i];
            			var suffixParam = row.title == "集团本部" ? "&busJtbb=1" : "";
            			var viewUrl = baseUrl;
            			var short = '';
            			if(row.title.length > 4) {
            				short = row.title.substring(0,2);
            			} else {
            				short = row.title;
            			}
                        var li = '<li style="padding:5px;">' +
                       // '<div class="task-title row" style="cursor: pointer;" onclick=openInpectModelWindow(\'项目成果详情\',\''+viewUrl+row.busOrgFcode+'\')>' +
                        '<div class="task-title row" ">' +
                            '<div onclick=openInpectModelWindow(\''+short+'成果信息\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busRstAuditPro=1&busId='+row.id+'\') class="col-xs-6"><span class="task-title-sp" title="'+row.title+'" style="cursor:pointer;color:#0088cc;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.title + '</span></div>'+
                            '<div onclick=openInpectModelWindow(\''+short+'审计项目\',\''+viewUrl+row.busOrgFcode+suffixParam+'&busRstAuditPro=1&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s1+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s1 + '</span></div>'+
                            '<div onclick=openInpectModelWindow(\''+short+'发现问题\',\''+baseUrl2+row.busOrgFcode+suffixParam+'&busRstAuditFindPb=1&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s2+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s2 + '</span></div>'+      
                            '<div onclick=openInpectModelWindow(\''+short+'已整改问题\',\''+baseUrl3+row.busOrgFcode+suffixParam+'&busRstAuditReformPb=1&busId='+row.id+'\') class="col-xs-2"><span class="task-title-sp" title="'+row.s3+'" style="cursor:pointer;color:#0088cc;text-align:center;overflow:hidden;white-space:nowrap;width:100%;text-overflow:ellipsis;display: inline-block;">' +
                                row.s3 + '</span></div>'+  
                        '</div></li>';
                        infoList.append(li);
            		}
            	}else{
            		infoList.append('<div style="text-align:center;"><h3>暂时没有信息</h3></div>');
            	} 
            });
        }
    }
}();

function openInpectModelWindow(winTitle, winUrl){
	//alert(winUrl);
	/**/
	winTitle = winTitle ? winTitle : "查看";
    //openInpectModelWindow(title, winUrl);

    new aud$createTopDialog({
        title:winTitle,
        url  :winUrl
    }).open();

}
function goProjectMenu(projectid,stage){
    var isMyProject = null;
    jQuery.ajax({
        url:contextPath+'/project/prepare/isMyProject.action',
        type:'POST',
        data:{"crudId":projectid},
        dataType:'json',
        async:'false',
        success:function(data){
            // fixed by sunny 2019-04-12
            var udswin = window.open(
                contextPath+'/project/prepare/projectIndex.action?crudId='
                + projectid + '&stage=' + stage + '&source=view&projectview=view&isView=2&view=view', '',
                'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
            udswin.moveTo(0, 0);
            udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
            // fixed end.
        },
        error:function(){
        }
    });
}

function refreshMsg(title,url,id){

    parent.goMenu(title,url,id);

    setTimeout(function () {
        window.location.reload();
    },2000)

}


$(document).ready(function(){
	try{		
		audRecomputeHomeStBar('homeStBar', 5, 240);
	}catch(e){}
	
	FirstPageTables.projectInfoList();
	$('#projectInfo_reload').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		FirstPageTables.projectInfoList();
	});
	$('#projectInfo_more').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		var url = contextPath + "/portal/simple/inspectPageInfo.action?model=projectInfoList";
		//openInpectModelWindow("实施项目阶段统计", url);
		parent.addTab('tabs','实施项目阶段统计','projectInfo',url,true);
	});
	
	FirstPageTables.studyGardenTable();
	$('#garden_reload').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		FirstPageTables.studyGardenTable();
	});
	$('#garden_more').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		var url = contextPath+'/portal/simple/information/searchStudyGarden.action?view=view&studyGardenPlot.acceptorString.users='+floginname+'&studyGardenPlot.acceptorString.orgs='+fdepid;
		parent.addTab('tabs','学习园地','garden',url,true);
		//openInpectModelWindow("学习园地", url);
	});
	
	FirstPageTables.msgReminderTable();
	
	FirstPageTables.todoTaskTable();
	$('#todo_reload').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		FirstPageTables.todoTaskTable();
	});
	$('#todo_more').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		var activeTabBar = $('body').data('activeTabBar');
		if(activeTabBar == 'todoTask'){
			parent.addTab('tabs','审批待办事项','pending',contextPath+'/bpm/taskinstance/pending4V6.action?type=auditSystem',true);
		}else{
			//parent.addTab('tabs','消息提醒','pending',contextPath+'/msg/innerMsg_list.action?readFlag=-1',true);
			parent.addTab('tabs','消息提醒','pending',contextPath+'/msg/innerMsg_listAll.action',true);
		}
	});

	FirstPageTables.homeStatistics();
    	
	return;
	FirstPageTables.projectProcessTable();
	//FirstPageTables.myProjectTable();
	FirstPageTables.informationTable();
	
	FirstPageTables.planPieChart();
	

	


	$('#plan_reload').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		FirstPageTables.planPieChart();
	});
	$('#project_reload').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		FirstPageTables.projectProcessTable();
	});
	$('#project_more').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		parent.addTab('tabs','项目进度','projectprocess',contextPath+'/project/listAll.action',true);
	});
});

function onGroupClick() {
	FirstPageTables.planPieChart();
}

function onPartClick() {
	FirstPageTables.planWeatherChart();
}
