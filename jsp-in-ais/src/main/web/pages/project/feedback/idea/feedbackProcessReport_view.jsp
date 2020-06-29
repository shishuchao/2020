<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<base target="_self">

	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title>反馈意见及处理</title>
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>			
			
				<!--  引入DWR包 -->
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>	
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/util.js'></script>	

	<script type="text/javascript">

	//-----------------------------明细反馈意见--------------------------------------------------
	
	function openDetailIdeaAdd(){ //增加明细反库意见
		var project_id = document.getElementById("project_id").value;
		var view = document.getElementById("view").value;
		var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	 	var url = "<%=request.getContextPath()%>/project/feedback/idea/addFeedbackDetailIdea.action?detail_state=add&&project_id=" 
	 			  +project_id + "&&processType=${processType}&&project_code=${project_code}&&view=" + view + "&&rnm="+rnm;
	 	var popstyle="dialogTop:150px;dialogLeft:250px;help:no;center:yes;dialogHeight:400px;dialogWidth:950px;status:yes;resizable:" 
	 				 +"yes;scroll:yes";
   
        //刷新父页面
        var t=window.showModalDialog(url,window,popstyle); 
        if(t!=null&&t!=""){
       		document.getElementById("detailIdeaListStr").innerHTML = t;
        }
        
	}
	/*
	 *修改 明细反馈意见
	 */
	 function updateDetailIdea(id){
	 	var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	    
	    var project_id = document.getElementById("project_id").value;
		var view = document.getElementById("view").value;
		
	 	var url = "<%=request.getContextPath()%>/project/feedback/idea/addFeedbackDetailIdea.action?detail_state=edit&&detail_id="+id
	 			  + "&&project_id=" + project_id + "&&processType=${processType}&&project_code=${project_code}&&view=" + view + "&&rnm="+rnm;
	 	var popstyle="dialogTop:150px;dialogLeft:250px;help:no;center:yes;dialogHeight:400px;dialogWidth:950px;status:yes;resizable:yes;scroll:yes";
   
        //不再刷新父页面
        var t=window.showModalDialog(url,window,popstyle); 
        if(t!=null&&t!=""){
       		document.getElementById("detailIdeaListStr").innerHTML = t;
        }
	 }
	/*
	 *删除 明细反馈意见
	 */
	 function deleteDetailIdea(id){
	 	var boolFlag=window.confirm("确认删除吗?");
	 	if(boolFlag){
		 	document.getElementsByName('strList')[0].value = id + ":${project_id}:${processType}";
		 	DWREngine.setAsync(false);
		 	DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/feedback/idea', action:'deleteFeedbackDeatilIdea', executeResult:'false' },
				'strList',
				xxx
			);
			function xxx(data){
			   var flag = data['detailIdeaListStr'].split("*");
			   if(flag[0] == "true"){
			   		document.getElementById("detailIdeaListStr").innerHTML = data['detailIdeaListStr'].substr(5,data['detailIdeaListStr'].length);
			   }
			} 
		}
	 }
	 
	 function detailListStr(idea_id){
	 	var strList =  "${project_id}:"+idea_id+":${processType}";
	 	DWREngine.setAsync(false);
	 	DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/project/feedback/idea', action:'updateDeatailPage', executeResult:'false' },
			{'strList':strList},
			xxx
			);
			function xxx(data){
			   	document.getElementById("detailIdeaListStr").innerHTML = data['detailIdeaListStr'];
			} 
	 }
    //--------------------------反馈意见处理结果---------------------------------------------------
	function openResultIdeaAdd(){  //反馈意见处理结果
			var strs= (document.getElementsByName('idea_id')[0].value).split(":");
			document.getElementsByName('idea_ids')[0].value =strs[0];
			DWREngine.setAsync(false);
		 	DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/project/feedback/idea', action:'addIsOrNot', executeResult:'false' },
			'idea_ids',
			xxx
		);
		function xxx(data){
		   if(data['isAddResultIdea']=="YES"){
		   		var num=Math.random();
			    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			   
			    var idea_id = strs[0];
				if(idea_id != null && idea_id != ""){
				 	var url = "<%=request.getContextPath()%>/project/feedback/idea/addResultIdea.action?result_state=add&project_id=${project_id}" 
			 			  	   + "&processType=${processType}&view=${view}&&idea_id=" + idea_id + "&rnm="+rnm;
				 	var popstyle="dialogTop:150px;dialogLeft:250px;help:no;center:yes;dialogHeight:400px;dialogWidth:950px;status:yes;resizable"
				 			   + ":yes;scroll:yes";
			        //不再父页面
			       var t=window.showModalDialog(url,window,popstyle);
			        if(t!=null && t!=""){
			        	detailListStr(strs[0]);
			       		document.getElementById("resultIdeaListStr").innerHTML = t;
			        }
		        }else{
		        	alert("请选择明细反馈意见!");
		        }    
 
		   }else{
		   		alert("您已反馈了意见处理结果!");
		   }
		}	

	}
	
	/*
	 *修改 处理结果意见
	 */
	 function updateResultIdea(id){
	 	var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		var strs= (document.getElementsByName('idea_id')[0].value).split(":");
	 	var url = "<%=request.getContextPath()%>/project/feedback/idea/addResultIdea.action?result_state=edit&result_id="+id
	 			  + "&project_id=${project_id}&processType=${processType}&idea_id="+strs[0]+"&view=${view}&&rnm="+rnm;
	 	var popstyle="dialogTop:150px;dialogLeft:250px;help:no;center:yes;dialogHeight:400px;dialogWidth:950px;status:yes;resizable:yes;scroll:yes";
   
        //不再刷新父页面
        var t=window.showModalDialog(url,window,popstyle); 
        if(t!=null&&t!=""){
        	detailListStr(strs[0]);
       		document.getElementById("resultIdeaListStr").innerHTML = t;
        }
	 }
	/*
	 *删除 处理结果意见
	 */
	 function deleteResultIdea(id){
	 	var strs= (document.getElementsByName('idea_id')[0].value).split(":");
	    var idea_id = strs[0];
	 	var boolFlag=window.confirm("确认删除吗?");
	 	if(boolFlag){
		 	document.getElementsByName('strList')[0].value = id + ":${project_id}:" +idea_id+":${processType}";
		 	DWREngine.setAsync(false);
		 	DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/feedback/idea', action:'deleteFeedbackResultIdea', executeResult:'false' },
				'strList',
				xxx
			);
			function xxx(data){
			   var flag = data['resultIdeaListStr'].split("*");
			   if(flag[0] == "true"){
			   		detailListStr(strs[0]);
			   		document.getElementById("resultIdeaListStr").innerHTML = data['resultIdeaListStr'].substr(5,data['resultIdeaListStr'].length);
			   }
			}
		}
	 }
	 
	/*
	 * 查看 处理结果
	 */
	function openResult(detail_id,result_idea_lookAll){
		if(detail_id!=null && detail_id!=""){
			document.getElementsByName('idea_id')[0].value = detail_id+":${project_id}:${view}:" + result_idea_lookAll;
			DWREngine.setAsync(false);
		 	DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/feedback/idea', action:'findResultByDetail', executeResult:'false' },
				'idea_id',
				xxx
			);
			function xxx(data){
				document.getElementById("resultIdeaListStr").innerHTML = data['resultIdeaListStr'];
			} 
		}
	}	 
	//--------------------------------------------------导出---------------------------------------
	/*
	 * 导出反馈意见
	 */
	function openExport(){    //导出
	
	 	var project_id = "${project_id}";
	    var path ='';	
	 	var url = "<%=request.getContextPath()%>/project/feedback/idea/exportFeedback.action?project_id=" 
	 			  +project_id ;
	 	window.location.href=url;
	 				 
	}

	</script>
	</head>
	
	<body>
		<center>

			<s:form action="saveFeedback" namespace="/project/feedback/idea" name="form1">	
				<s:hidden name="strList" />
				<s:hidden name="project_id" id="project_id"/>
				<s:hidden name="idea_id" id="idea_id"/>
				<s:hidden name="view" id="view"/>
				<s:hidden name="idea_ids" id="idea_ids"/>	
	
				<s:div id="detailIdeaListStr">
						<s:property escape="false" value="detailIdeaListStr" />
				</s:div>
				
				<div id="resultIdeaListStr">
					<s:property escape="false" value="resultIdeaListStr" />
				</div>				
				<div align="right">
				<s:if test="${view == 'process'}">

					<s:if test="${isFeedback==null || isFeedback ==''}">
						<s:if test="${btnRight == 'zhushen' || btnRight == 'zuzhang' || btnRight=='zhushenzuzhang'}">
							<s:button value="增加明细反馈意见" onclick="openDetailIdeaAdd()"></s:button>
						</s:if>
						<s:if test="btnRight != 'no'">
							<s:button value="增加处理意见" onclick="openResultIdeaAdd()"></s:button>
						</s:if>
					</s:if>
					<s:else>
						<s:if test="${btnRight == 'zhushen' || btnRight == 'zuzhang' || btnRight=='zhushenzuzhang'}">
							<s:button value="增加明细反馈意见" onclick="openDetailIdeaAdd()"
							disabled="${!isFeedback}"></s:button>
						</s:if>
						<s:if test="btnRight != 'no'">
							<s:button value="增加处理意见" onclick="openResultIdeaAdd()"
							disabled="${!isFeedback}" ></s:button>
						</s:if>
					</s:else>
				</s:if>
				<s:if test="${btnRight == 'zuzhang'}">
					<s:button value="导 出" onclick="openExport()"/> &nbsp;&nbsp;&nbsp;
				</s:if>
				</div>
			</s:form>
		</center>
	</body>
</html>
