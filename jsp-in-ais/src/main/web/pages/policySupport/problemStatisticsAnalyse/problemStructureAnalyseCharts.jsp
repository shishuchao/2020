<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html"; charset="utf-8">
	<title>审计问题结构分析图</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>	
	<script src="<%=request.getContextPath()%>/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/policySupport/css/statistics.css" media="all"> 		

	<script type="text/javascript">
		var problemStructureTables = function(){
			return {
				problemStructureChart:function(){
					var pro_year="<%=request.getParameter("pro_year")%>";
					var audit_dept="<%=request.getParameter("audit_dept")%>";
	
					var audit_object="<%=request.getParameter("audit_object")%>";
	
					var sort_big_code="<%=request.getParameter("sort_big_code")%>";
	
					var pro_type="<%=request.getParameter("pro_type")%>";			
					var mend_state=encodeURI("<%=request.getParameter("mend_state")%>");
					var type="<%=request.getParameter("type")%>";
					
				 	if(type=='zgzt'){
	           		   document.getElementById("title").innerHTML = "整改状态";
		           	}else if(type=='protype'){
		           	   document.getElementById("title").innerHTML = "项目类别";
		           	}else if(type=='sortbig'){
		           	   document.getElementById("title").innerHTML = "问题一级分类";
		           	}else if(type=='wtd'){
		           	   document.getElementById("title").innerHTML = "问题点";
		           	}
	
	            	$.ajaxSettings.async = false;                    //同步
	                var dataList1 = [];//echarts1的series的data
	                var dataList2 = [];
	                var tableList;
	               
	    			$.getJSON('<%=request.getContextPath()%>/proledger/problem/analysAuditQuestions1.action',
	    					{'pro_year':pro_year,'audit_dept':audit_dept,'audit_object':audit_object,'sort_big_code':sort_big_code,
	    				     'pro_type':pro_type,'mend_state':mend_state,'type':type},
	    					function(json){
	    				dataList1 = json.dataList1;
	    				dataList2= json.dataList2;
	    				 tableList=json.tableList;
	             		});   	
	    			
		        	var echart = echarts.init(document.getElementById('problemstrucure'));
		        	 echart.showLoading({
		                 text:'数据加载中，请稍后...'
		             }); 
		        	 
		      	 if(dataList1.length>0 && dataList2.length>0 ){   
		        	   var options = {        			   	
		        			    title: [/* {
		   		        			text: '问题结构分析',
		   		        			x: 'center',
		   		        			y: 'top'
		   		        			
		        			   }, */ {
		        				   subtext: '问题数量',
		        			        left: '35%',
		        			        top: '75%',
		        			        textAlign: 'center',
		        			        subtextStyle:{
		  	        				   color: 'black',
		  	        				   fontSize: 15 
		  	        			   }
		        			   },{
		        				   subtext: '涉及金额(万元)',
		        			        left: '65%',
		        			        top: '75%',
		        			        textAlign: 'center',
		        			        subtextStyle:{
		  	        				   color: 'black',
		  	        				   fontSize: 15 
		  	        			   }
		        			   }],
		        			   tooltip: {
		        			        trigger: 'item',
		        			        formatter: '{a} <br/>{b} : {c} ({d}%)'
		        			    },                   
	                        series: [{
	                        		name:'问题数量',
								     type: 'pie',
								     radius: '35%',
								     center: ['35%', '50%'],
								     data: dataList1,
								     animation: false,
								     label: {
								         position: 'outer',
								         alignTo: 'none',
								         bleedMargin: 5
								     },
								color:['#76c1a1','#f4b860',  '#70acf6', '#81d2b4','#eb8773', '#c869a5', '#6473d7',
									   '#c23531','#2f4554', '#c4ccd3', '#d48265', '#91c7ae','#749f83',  '#ca8622']
	                        
								 }, {
									 name:'涉及金额(万元)',
								     type: 'pie',
								     radius: '35%',
								     center: ['65%', '50%'],
								     data: dataList2,
								     animation: false,
								     label: {
								         position: 'outer',
								         alignTo: 'labelLine',
								         bleedMargin: 5
								     } ,
								color:['#76c1a1','#f4b860',  '#70acf6', '#81d2b4','#eb8773', '#c869a5', '#6473d7',
									   '#c23531','#2f4554', '#c4ccd3', '#d48265', '#91c7ae','#749f83',  '#ca8622']
								 }]
		        			   
		             	};
		             
		             	echart.setOption(options);
		             	echart.hideLoading();
		             	window.onresize = function () {
			                //重置容器高宽
			                echart.resize();
			            };
		      	 	}else{
		      	 	 $("#problemstrucure").empty().append('<h3 style="text-align:center;">暂时没有信息</h3>');
		      	 	}
			      	var tBody = $("#auditwtTable").find("tbody");
			    	  tBody.html('');
			    	if(tableList&&tableList.length>0){
			      	var order=1;
			      	for(var index=0;index<tableList.length;index++){
			      		var newTr=$("<tr  style='font-size:15px; text-align:center; color:gray'></tr>");
			      		newTr.addClass('rowTrover');
						newTr.addClass('datagrid-row');
			      		if(index%2==1){
			      			newTr.addClass('datagrid-row-alt');
			      		};
			      		var ordertd=$("<td class='task-title-sp' style='text-align:center;color:#666'></td>");
			      		var dimension=$("<td style='color:#666'></td>");
			      		var problemcount=$("<td  style='text-align:center;'></td>");
			      		var problemmoney=$("<td  style='text-align:right;'></td>");
			      		ordertd.text(order);	            		
			      		dimension.text(tableList[index]. dimension );
			      		problemcount.text(tableList[index].problemcount );
			      		problemmoney.text(tableList[index].problemmoney.toFixed(2).replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,') );	
				
			      		newTr.append(ordertd);
			            newTr.append(dimension);
			            newTr.append(problemcount);
			            newTr.append(problemmoney);
			              
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
			problemStructureTables.problemStructureChart();
		});
	</script>
</head>
<body>
	<div id="body">
		<div>
			<div id="problemstrucure" class="chartcss"></div>
		</div>
		<div>
	    	<table id="auditwtTable" class="auditwtTable" cellspacing="0" cellpadding="0">
		      	<thead>
				   <tr class="datagrid-header datagrid-header-row datagrid-row">
		               <td  class="tbTitle2">序号</td>
		               <td  id='title' class="tbTitle">项目类别</td>
		               <td  class="tbTitle">问题数量</td>
		               <td  class="tbTitle">涉及金额(万元)</td>
		           </tr>
		    	</thead>
		      	<tbody>
		       	</tbody>
		   	</table>	                                                
		</div>	
	</div>
</body>
</html>