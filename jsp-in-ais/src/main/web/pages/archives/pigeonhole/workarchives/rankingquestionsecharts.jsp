<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html";charset="utf-8">
<title>问题数量排名</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>	
	<script src="<%=request.getContextPath()%>/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<%-- <script src="/ais/easyui/1.4/jquery-1.7.1.min.js" type="text/javascript"></script> --%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>		
	
<style type="text/css">
 .rowTrover:hover{
	background-color:rgba(170, 227, 250, 1);
}
 .auditwtTable td{
 	border-width:0 1px 1px 0;
 	border-style: dotted;
 	border-color:#ccc;
 }
 .auditwtTable{
 	width:80%;height:100%;margin-left:10%;
 
 }
</style>	
	
	
	<script type="text/javascript">
	var FirstPageTables = function(){
		return {
			auditwtEcharts1:function(){
				var pro_year="<%=request.getParameter("pro_year")%>";
				
				var audit_dept="<%=request.getParameter("audit_dept")%>";
				var audit_dept_name=encodeURI("<%=request.getParameter("audit_dept_name")%>");
				var audit_object="<%=request.getParameter("audit_object")%>";
				var audit_object_name=encodeURI("<%=request.getParameter("audit_object_name")%>");				
				var sort_big_code="<%=request.getParameter("sort_big_code")%>";
				var sort_big_name=encodeURI("<%=request.getParameter("sort_big_name")%>");
				
				var topN="<%=request.getParameter("topN")%>";
				var pro_type="<%=request.getParameter("pro_type")%>";			
				var mend_state=encodeURI("<%=request.getParameter("mend_state")%>");
				var type="<%=request.getParameter("type")%>";
    	       	var sort="<%=request.getParameter("sort")%>";
				
/* 	变换维度
 */            	if(type=='org'){
            		 document.getElementById("title").innerHTML = "审计单位";
            	}else if(type=='obj'){
            		 document.getElementById("title").innerHTML = "被审计单位";
            	}else if(type=='protype'){
            		 document.getElementById("title").innerHTML = "项目类型";
            	}else if(type=='sortbig'){
            		 document.getElementById("title").innerHTML = "问题一级分类";
            	}else if(type=='wtd'){
            		 document.getElementById("title").innerHTML = "问题点";
            	}
				
            	
            	$.ajaxSettings.async = false;                    //同步
                var dataList = [];//series的dataList
                var legend = [];//echarts的legend
               	var tableList;
      			var average;
      			var num = Math.random();
    			$.getJSON('/ais/proledger/problem/rankingAuditQuestions1.action?num='+num+'&pro_year='+pro_year+'&audit_dept='+audit_dept+'&audit_dept_name='+audit_dept_name+'&audit_object='+audit_object+'&audit_object_name='+audit_object_name+'&topN='+topN+'&sort_big_code='+sort_big_code+'&sort_big_name='+sort_big_name+'&pro_type='+pro_type+'&mend_state='+mend_state+'&type='+type+'&sort='+sort,{},function(json){
    			    /*for(var i = 0; i < json.legend.length; i++){
    			        if(json.legend[i].length > 5){
                            json.legend[i] = json.legend[i].substr(0, 5) + '...'
						}
					}*/
					legend = json.legend;
					dataList= json.dataList;
					tableList=json.tableList;
					average=json.average;

				});
	        	var rankingamount = document.getElementById('rankingamount');       	
	        	var echart = echarts.init(rankingamount);
	        	 echart.showLoading({
	                 text:'数据加载中，请稍后...'
	             }); 	        	 	   
	        	//后台sql已经根据sort进行排序了，此处无需再对sort进行处理 --田雅杰
	            var temp = [];
	            if(sort!=""&&sort!="null"){
	            /* 	alert("!!1111111！") */
	            	if(sort=='dx'){
	            		for(var i=dataList.length-1,j=0;i>=j;i--){
	            			temp.push(dataList[i]);
	            		}
	            	}else if(sort=='zx'){
	            		for(var i=0,j=dataList.length-1;j>=i;i++){
	            			temp.push(dataList[i])
	            		}
	            	}
	            }else{
	            	temp=dataList;
	            }
	            
	      	 if(dataList && legend && legend.length>0){   
	        	   var options = {        			   	
	        			  /*  title: {
	   		        			text: '审计问题数量排名',
	   		        			x: 'center',
	   		        			y: 'top',
	   		        			
	   		        		}, */
	                         tooltip : {
	                        	 trigger: 'axis',
	     	                     axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	     	                     type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
	     	                    }
	                         },
                       legend:{
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

                       xAxis:{ //x轴
	                             type : 'value',
	                             boundaryGap: [0, 0.01],
	                             name: '问题数量（个）',
	                            
	                         },
	                         yAxis: { //y轴
	                             type : 'category',
		                         inverse: true,
	                         	 data: legend,
                                 /*axisLabel: {
                                     formatter: function (orgs) {
                                         if (!orgs) return '';
                                         if (orgs.length > 5) {
                                             orgs =  orgs.slice(0,5) + '...';
                                         }
                                         return orgs;
                                     },
                                 }*/
	                         },
	                         
	                        series :[{
	                        	name:'问题数量',
	                        	type: 'bar',
	                        	/*  barWidth: '60%', */
	                        	 barMaxWidth:'20%',
	                        	radius: '100%',
	                        	data:dataList,
	                        	 markLine : {
	                                 data : [
	                                      {type : 'average', 
	                                       name: '平均值',
	                                       xAxis:average,
	                                       lineStyle: {
	                                           normal: {
	                                               type: "solid",
	                                               color: "#FA3934",
	                                               width: 2
	                                           }

	                                       }
	                                      }
	                                  
	                                 ]
	                             },
	                        	/*itemStyle:{
	                        		emphasis: {
	                        			shadowBlur:10,
	                					shadowOffsetX: 0,
	                					shadowColor:'rgba(0, 0, 0, 0.5)'
	                        		}
	                        	},*/
	                        	label:{
	                        		normal: {
	                        			show:false,
										position:'right'
	                        		}
	                        	}
	                        	
	                        }],
                       itemStyle: {
                           normal: {
                               color: function (params) {
                                   var colorList = [
									   '#76c1a1','#f4b860',  '#70acf6', '#81d2b4','#eb8773', '#c869a5', '#6473d7'
                                   ];
                                   return colorList[params.dataIndex]
                               }
                           }
                       },
	                        //color:['#f54545', '#ff8547', '#ffac38', '#64b8f9']
	             	};
	             
	             	echart.setOption(options);
	             	echart.hideLoading();
	             	window.onresize = function () {
		                //重置容器高宽
		                echart.resize();
		            };
	      	 	}else{
	      	 	 $("#rankingamount").empty().append('<h3 style="text-align:center;">暂时没有信息</h3>');
	      	 };
	      	
	      	 var tBody = $("#auditwtTable").find("tbody");
	      	  tBody.html('');
	      	if(tableList&&tableList.length>0){
	      		
	      		var averageSpan=document.getElementById("Average");
	      		averageSpan.innerHTML= '平均数：'+average;
            	var order=1;
            	for(var index=0;index<tableList.length;index++){
            		var newTr=$("<tr  style='font-size:15px; text-align:center; color:gray'></tr>");
            		newTr.addClass('rowTrover');
            		newTr.addClass('datagrid-row');
            		if(index%2==1){
            			//newTr=$("<tr style=' background: #effbfc;	height: 30px;'></tr>");
            			newTr.addClass('datagrid-row-alt');
            		};
            		var ordertd=$("<td class='task-title-sp' ></td>");
            		var dimension=$("<td ></td>");
            		var problemcount=$("<td  ></td>");
            		var problemmoney=$("<td style='text-align:right;' ></td>");
            		var wgwjje=$("<td style='text-align:right;' ></td>");
            		var yjzwjwgje=$("<td style='text-align:right;' ></td>");
            		
            		ordertd.text(order);	            		
            		dimension.text(tableList[index]. dimension );
            		problemcount.text(tableList[index].problemcount );
            		problemmoney.text(tableList[index].problemmoney.toFixed(2).replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,') );//未启动
            		wgwjje.text(tableList[index].wgwjje.toFixed(2).replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,') );
            		yjzwjwgje.text(tableList[index].yjzwjwgje.toFixed(2).replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,') );
            		
            		newTr.append(ordertd);
                    newTr.append(dimension);
                    newTr.append(problemcount);
                    newTr.append(problemmoney);
                    newTr.append(wgwjje);
                    newTr.append(yjzwjwgje);
                    
                    tBody.append(newTr);
                  
                    order=order+1;
            	}
            
            	            
           
            }else{
            	 $("#auditwtTable").html("");
            }
		}		    
		}
	}();
	$(document).ready(function(){
		FirstPageTables.auditwtEcharts1();		
		
	});
	
	</script>
</head>
<body >
	<div id="body">
		<div> 
			
			<div id="rankingamount" style="height: 500px;width:80%;margin-left:10%"></div>
		</div>
	    <span style="color:red;margin-left:10%" id='Average' name='Average'></span> 
		<div >
	    	<table id="auditwtTable" class="auditwtTable"  cellspacing="0" cellpadding="0"   >
		      	<thead >
		           <tr style=' font-size:15px; text-align:center; font-weight:bold; color:gray' class="datagrid-header datagrid-header-row datagrid-row">
		               <td  style="width:5%;text-align:center">序号</td>
		               <td   id='title' style="width:8%;text-align:center">审计单位</td>
		               <td style="width:5%;text-align:center;">问题数量</td>
		               <td  style="width:8%;text-align:center;">涉及金额(万元)</td>
		               <td  style="width:10%;text-align:center">查出违规违纪金额(万元)</td>
		               <td  style="width:10%;text-align:center">已纠正违规违纪金额(万元)</td>
		               
		           </tr>
		      	</thead>
	      		<tbody>
	       		</tbody>
	    	</table>	                                                
		</div>	
</div>
</body>
</html>