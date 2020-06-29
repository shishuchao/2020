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
		<title>项目趋势分析</title>
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
var projectCompareAnalysis = function(){
	return {
		//项目趋势分析--柱状图、折线图
		projectCompareChart:function(){
			
			var pro_year = "<%=request.getParameter("pro_year")%>";          
	        var pro_type_name = "<%=request.getParameter("pro_type_name")%>";   	
			var chart = document.getElementById('projectCompareChart');
			var echart = echarts.init(chart);
			
			echart.showLoading({
				text:'数据加载中，请稍后......'
			});
			$.ajaxSettings.async = false;
			
			var categories = [];
			var series = [];
			var legend = [];
			var data = Math.random();
			var xAxisDataList = [];
			var url = '/ais/project/compareAnalysisSearchChartDefault.action?pro_year=<%=request.getParameter("pro_year")%>&pro_type_name='+encodeURI('<%=request.getParameter("pro_type_name")%>')
    		$.getJSON(url,{},function(json){
	             categories = json.category;
	             legend = json.legend;
	             series = json.series;
	             xAxisDataList = json.xAxisDataList;
            });
           

    
            var options = {
            	/* title:{
            		text:'项目趋势分析',
                    x:'center',
                    y:'top'
            	}, */
            	tooltip:{
            		trigger:'axis',
            		axisPointer:{
            			type:'shadow'
            		}
            	},
            	legend:{
            		/*  orient: 'vertical',
            	        right: 20,
            	        top: 20,
            	        bottom: 20, */
            	    /*     align:'center',  //水平方向位置
            	        verticalAlign:'bottom',  //垂直方向位置
            	        x:0,  //距离x轴的距离
            	        y:0,   //距离Y轴的距离    */
            		selectedMode:false,
            		//y:'40px',
            		orient: 'horizontal',
	                left: 'center',  //图例距离左的距离
	                y: '90%', 
            		data:legend
            	},
            	grid:{
            		containLabel:true //防止坐标轴标签溢出 
            	},
            	calculable:true,   //是否启用拖拽重计算特性，默认关闭(即值为false)
            	xAxis:[
            		{
            			type:'category',
            			data: xAxisDataList  //x轴坐标
            		}
            	],
            	yAxis:[
            		{
            			name:'项目数量（个）',
            			type:'value',
            			boundaryGap:[0,0.1]
            		}
            	],
            	toolbox:{
            		show:true,
            		feature:{
            			savaAsImage:{
            				show:true,
            				excludeComponents:['toolbox'],
            				pixelRatio:2
            			}
            		}
            	},
            	series:series,
				color:['#76c1a1','#f4b860',  '#70acf6', '#81d2b4','#eb8773', '#c869a5', '#6473d7']
            };
            
            echart.setOption(options);
            echart.hideLoading();
            window.onresize = function(){
            	//重置容器高宽
            	echart.resize();
            };
		},
		
		
		//项目趋势分析--表格
		projectCompareAnalysisTable:function(){
			//alert("123123");
			var tBody = $("#projectCompareAnalysisTable").find("tbody");
			tBody.html('');
			var text = $(this).text();

			var url = '/ais/project/compareAnalysisSearchChartDefault.action?pro_year=<%=request.getParameter("pro_year")%>&pro_type_name='+encodeURI('<%=request.getParameter("pro_type_name")%>')
    $.		getJSON(url,{},function(json){
				proYearList = json.proYearList;
			
				proTypeNameList = json.proTypeNameList;
				countByYearAndProType = json.countByYearAndProType;

		
				

				
		     /*    alert("proYearList[0]是："+proYearList[0]);
		        alert("proTypeNameList[0]是："+proTypeNameList[0]); */
				var newTr;
				
		
				
				
				
				
				
				
		
					newTr = $("<tr style=' font-size:15px; text-align:center; font-weight:bold; color:gray' class='datagrid-header datagrid-header-row datagrid-row'></tr>");
					var numberTitle = $("<td style='color:#666;font-weight:bold;'></td>");
					var proTypeNameTitle = $("<td style='color:#666;font-weight:bold;'></td>");
					numberTitle.text("序号");
					proTypeNameTitle.text("项目类别");
					
					newTr.append(numberTitle);
					newTr.append(proTypeNameTitle);
			
					for(var index in proYearList){   //动态创建项目年度列
						//alert("proYearList[index]是："+proYearList[index]);
						var proYearTitle = $("<td style='color:#666;font-weight:bold;'></td>");
						proYearTitle.text(proYearList[index]);
						newTr.append(proYearTitle);
					}
					
					tBody.append(newTr);
					
					for(var index = 0; index < proTypeNameList.length; index++){
						//alert("proTypeNameList[index]是"+proTypeNameList[index]);
						
						var newTr=$("<tr style='font-size:15px; text-align:center; color:gray'></tr>");
	            		newTr.addClass('rowTrover');  /*选中行变色*/
						newTr.addClass('datagrid-row');
	            		
	            		if(index%2==1){
	            			//newTr=$("<tr style='height:18px; font-size:15px; text-align:center; color:gray'></tr>");
	            			newTr.addClass('datagrid-row-alt');     //各行换色
	            		}

						
					/* 	if(index%2 != 0){  //新建一行
							newTr = $("<tr style='background-color:rgba(239, 251, 252, 1); height:18px; font-size:15px; text-align:center; color:gray'></tr>"); //新建一行  $("<td style='background-color:rgba(239, 251, 252, 1);'></td>"); 
     	    			}
						else{
							newTr = $("<tr style='height:18px; font-size:15px; text-align:center; color:gray'></tr>"); 
						} */
						
         	    		var number = $("<td class='task-title-sp'></td>");   //序号列
         	    		var proTypeName = $("<td style='color:#666'></td>"); //项目类型列
         	    		
         	    		
         	    		number.text((parseInt(index)+1).toString());  
         	    		proTypeName.text(proTypeNameList[index]);
         	    		
         	    		newTr.append(number);
         	    		newTr.append(proTypeName);
         	    		
         	    		
         	    		for(var j=0; j<proYearList.length; j++){   //填充数据
         	    			//alert("countByYearAndProType[index][j]是："+countByYearAndProType[index][j]);
         	    			
         	    		    var countByProType = $("<td style='color:#666;'></td>"); 
         	    			
         	    			countByProType.text(countByYearAndProType[index][j].toString());
         	    			newTr.append(countByProType);
         	    		}
         	    		
         	    		tBody.append(newTr);	
					}
					$('#taskRow').show();
		
			});	
		}
	}
}();

$(document).ready(function(){
	projectCompareAnalysis.projectCompareChart();
	projectCompareAnalysis.projectCompareAnalysisTable();
});
</script>







<body style="margin: 0;padding: 0;">
 

	<!-- 显示Echarts折线图 -->
 	 <div>   <!--style="padding-top: 30px!important; margin_bottom:30px"-->
 	     <div id="projectCompareChart" style="height:400px;width:100%;"></div>
     </div>
	
	<!-- 显示表格 -->
	<div id="taskRow" >  <!--height:1800px;margin-top:10px;-->
	  <table id="projectCompareAnalysisTable" class="auditTable" cellpadding="0" cellspacing="0" style=" width:80%; margin: auto;font-size:20px; text-align:center; border-collapse:separate; border-color:rgba(235, 235, 235, 1)">
	     <thead>
			
			 <tbody>
			 <!--动态创建表格-->		
	         </tbody>	
			
			
			
	     </thead>
	   
	    		
	  </table>
    </div>

	</body>
</html>

			   
				
	  