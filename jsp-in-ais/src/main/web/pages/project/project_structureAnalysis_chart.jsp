<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>项目结构分析</title>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>	
	<script src="<%=request.getContextPath()%>/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<%-- <script src="/ais/easyui/1.4/jquery-1.7.1.min.js" type="text/javascript"></script> --%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>		


<style type="text/css">
.rowTrover:hover{   /*选中行变色*/
	background-color:rgba(170, 227, 250, 1);
}

.auditTable td,th{
	border-width:0 1px 1px 0;
	border-style:dotted;
	border-color:#ccc;    
}

</style>

<script type="text/javascript">
var projectStructureAnalysis = function(){
	return {
		//项目结构分析
		projectStructureAnalysisChart:function(){
				
			//获取父页面参数
			var from = "<%=request.getParameter("from")%>";
			var pro_year = "<%=request.getParameter("proYear")%>";    		
			var audit_dept = "<%=request.getParameter("auditDept")%>";
			var audit_object = "<%=request.getParameter("auditObject")%>";
			var pro_type = "<%=request.getParameter("proType")%>";
			var plan_type = "<%=request.getParameter("planType")%>";
			var selectType = "<%=request.getParameter("selectType")%>";
		
			
			var chart = document.getElementById('projectStructureAnalysisChart');
			var echart = echarts.init(chart);
			
			echart.showLoading({
				text:'数据加载中，请稍后......'
			});
			$.ajaxSettings.async = false;
			
			var categories = [];
			var legend = [];
			var data = Math.random();
			var seriesDataList = [];
			var options;
    $.getJSON('/ais/project/projectStructureAnalysisChart.action?from=<%=request.getParameter("from")%>&pro_year=<%=request.getParameter("proYear")%>&audit_dept=<%=request.getParameter("auditDept")%>&audit_object=<%=request.getParameter("auditObject")%>&pro_type=<%=request.getParameter("proType")%>&plan_type=<%=request.getParameter("planType")%>&selectType=<%=request.getParameter("selectType")%>',{},function(json){
	             categories = json.category;
	             legend = json.legend;
	            
	             seriesDataList = json.seriesDataList;
	            
	              options = {
	                 	backgroundColor:'#fff',
	                 	tooltip: {
	                         trigger: 'item',
	                         formatter: '{a} <br/>{b}: {c} ({d}%)'
	                     },
	                    
	                  /*    title:{
	                     	text:'项目结构分析',
	                     	x:'center',
	                        y:'top'
	                     }, */
	                     
	                 	legend:{   
	                 		orient: 'horizontal',
	                        left: 'center',  //图例距离左的距离
	                        y: '90%',  
	                 		data:legend
	                 	},
	                 	
	                 	series:[{
	                 		name:'项目结构分析',
	                 		type:'pie',
	                 		radius: ['50%', '70%'],
	                 		avoidLabelOverlap:false,
	                 		
	                 		label:{
	                 			normal: {
	                                 show: true,
	                                 formatter: "{d}% ",
	                             textStyle: {
	                                 fontSize: this.standSize / 150,
	                                 color: "black"
	                             },
	                         }
	                 		},
	                 	   labelLine: {    //指示线状态
	                              show: true,
	                              smooth: 0.2,
	                              length: 10,
	                              length2: 20
	                          },
	                        itemStyle:{
	                        	normal:{
	                        		borderWidth:5, //设置border的宽度有多大
		                            borderColor:'#fff'
	                        	}
	                        },
	                        data:seriesDataList 
	                 	
	                 	}],
	                     color:['#76c1a1','#f4b860',  '#70acf6', '#81d2b4','#eb8773', '#c869a5', '#6473d7']
	                 };
            });
           
           
            if(legend.length>0){
            	 echart.setOption(options);
                 echart.hideLoading();
                 window.onresize = function(){
                 	//重置容器高宽
                 	echart.resize();
                 };
                 $('#echarts-projectStructureAnalysisChart').show();
            }
             else{
            	 $('#echarts-projectStructureAnalysisChart').html('');
                 $('#echarts-projectStructureAnalysisChart').show();
            }     
		},
		
		
		//项目结构分析--表格
		projectStructureAnalysisTable:function(){
			var tBody = $("#projectStructureAnalysisTable").find("tbody");
			tBody.html('');
			var text = $(this).text();

		    $.getJSON('/ais/project/projectStructureAnalysisChart.action?from=<%=request.getParameter("from")%>&pro_year=<%=request.getParameter("proYear")%>&audit_dept=<%=request.getParameter("auditDept")%>&audit_object=<%=request.getParameter("auditObject")%>&pro_type=<%=request.getParameter("proType")%>&plan_type=<%=request.getParameter("planType")%>&selectType=<%=request.getParameter("selectType")%>',{},function(json){
				list = json.list;
				firstTitle = json.firstTitle;
				//proDoingList = json.proDoingList;
			   
				var newTr;
				
				//alert(firstTitle);
				document.getElementById("firstTitle").innerText = firstTitle;  //动态的给id为firstTitle的<td>赋值
				
         	    if(list.length > 0){
         	       for(var index in list){
         	    	  var resultList = list[index];
       	    		  newTr = $("<tr style='font-size:15px; text-align:center; color:gray'></tr>"); //新建一行
       	    		  newTr.addClass('rowTrover');  /*选中行变色*/
					   newTr.addClass('datagrid-row');
            		  if(index%2==1){
            			newTr.addClass('datagrid-row-alt');  //隔行换色
            		  }
       	    		  
       	    		
       	    		  var number = $("<td class='task-title-sp'></td>"); //序号列
       	    		  var firstTitle = $("<td style='color:#666'></td>"); //除序号列外的第一列
       	    		  var countAll = $("<td style='color:#666'></td>");  //项目计划数合计
       	    		  var notStart = $("<td style='color:#666'></td>"); //未启动
       	    		  var proDoing = $("<td style='color:#666'></td>"); //进行中
       	    		  var finished = $("<td style='color:#666'></td>");  //已完成
       	    		
         	       
                      number.text((parseInt(index)+1).toString());  
                      firstTitle.text(resultList[0].toString());
                      countAll.text(resultList[1].toString());
                      notStart.text(resultList[2].toString());
                      
                      proDoing.text(resultList[3].toString());
                      
                      finished.text(resultList[4].toString());
                     
                  
               		  newTr.append(number);
               		  newTr.append(firstTitle);
               		  newTr.append(countAll);
               		  newTr.append(notStart);
               		  newTr.append(proDoing);
               		  newTr.append(finished);

               		  tBody.append(newTr);

	                  $('#table-projectStructureAnalysis').show();

         	       
         	       }
         	    }else{
                    $('#table-projectStructureAnalysis').html('<h3>还没有项目信息</h3>');
                    $('#table-projectStructureAnalysis').show();
                }
         		
			});	
		}
	}
}();

$(document).ready(function(){
	projectStructureAnalysis.projectStructureAnalysisChart();
	projectStructureAnalysis.projectStructureAnalysisTable();
});
</script>
</head>



<body style="margin: 0;padding: 0;overflow:scroll;"> <!-- class="easyui-layout" -->
	<!-- 显示Echarts折线图 -->
 	 <div id="echarts-projectStructureAnalysisChart" >   <!--style="padding-top: 30px!important; margin_bottom:30px"-->
 	     <div id="projectStructureAnalysisChart" style="height:400px;width:100%;"></div>
		 <!-- <div id="projectOverviewEcharts" style="height:300px;width:450px; margin-left:350px; float: left;"></div>
		 <div id="projectOverviewEcharts2" style="height:300px;width:450px; margin-left:150px; float: left;"></div> -->
     </div> 
	
	<!-- 显示表格 -->
  <div id="taskRow" style="height:200px;width:100%; ">  
	<div id="table-projectStructureAnalysis" style="clear:left;">  <!--height:1800px;margin-top:10px;-->
	  <table id="projectStructureAnalysisTable" class="auditTable"  cellpadding="0" cellspacing="0"  style=" width:80%; margin: auto;font-size:20px; text-align:center;">
	     <thead>
		 	<tr style=' font-size:15px; text-align:center; font-weight:bold; color:gray' class="datagrid-header datagrid-header-row datagrid-row">
			 <th style="text-align:center;" >序号</th>
			 <th id="firstTitle" style="text-align:center;"></th>
			 <th style="text-align:center;">项目计划数量合计</th>
			 <th style="text-align:center;">未启动项目计划数</th>
			 <th style="text-align:center;">进行中项目</th>
			 <th style="text-align:center;">已完成项目</th>
			</tr>	
			
	     </thead>
	   
	      <tbody>
	       <!--动态创建表格-->		
	      </tbody>	
	    		
	  </table>
    </div>
 </div> 
 		
					
	</body>
</html>

			   
				
	  