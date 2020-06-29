<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<base target="_self">

	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>征求意见</title>
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<!--  引入DWR包 -->
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>			

	<script type="text/javascript">
	/*
	 * 添加征求意见稿
	 */
	function add_issue_file(){
		var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	 	var url = "<%=request.getContextPath()%>/project/feedback/online/issueFileAdd.action?state=add&&project_id="
	 				+"${project_id}&&processType=${processType}&&rnm=" + rnm;
	 	var popstyle="dialogTop:150px;dialogLeft:250px;help:no;center:yes;dialogHeight:400px;dialogWidth:950px;status:"
	 				 + "yes;resizable:yes;scroll:yes";
	 	//刷新父页面
        var t=window.showModalDialog(url,window,popstyle); 
        if(t=="OK"){
        	window.location.reload();
        }
	}
	/*
	 * 删除征求意见稿
	 */
	 function deleteFiel(file_id,issue_file){
	 	if(confirm("确定删除征求意见稿吗？")){
	 		
			DWREngine.setAsync(true);
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/project/feedback/online', action:'deleteIssueFile', executeResult:'false' },
			{'file_id':file_id},
			xxx1
			);
	        function xxx1(data){
				if(data['flag'] == "true"){
					alert("征求意见稿删除成功!");
					window.location.reload();
					return false;
				}
			}
		}
	 }
	/*
	 *删除征求人
	 */ 
	 function deleteBackUser(issue_id,issue_file){
	 	if(confirm("确定删除此反馈人吗？")){
	 		DWREngine.setAsync(true);
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/project/feedback/online', action:'deleteBackUser', executeResult:'false' },
			{'issue_id':issue_id,'issue_file':issue_file},
			xxx1
			);
	        function xxx1(data){
				if(data['flag'] == "true"){
					alert("反馈人删除成功!");
					window.location.reload();
					return false;
				}
			}
	 	}
	 }
	/*
	 * 添加被征求人
	 */
	function add_feedbackUser(){
		//判断页面是否输入了时间信息
		var issue_start_time = document.getElementsByName("issuesObject.issue_start_time")[0].value;
		
		var issue_end_time = document.getElementsByName("issuesObject.issue_end_time")[0].value;
		
		var issue_delay_time = document.getElementsByName("issuesObject.issue_delay_time")[0].value;

		if(issue_start_time==null || issue_start_time==''||
			((issue_end_time==null || issue_end_time=='')&&(issue_delay_time==null || issue_delay_time==''))){
			alert("请确认征求期间或延期时间是否填写!");
			return;
		}
		
		//征求期间
		if(issue_delay_time!='' && issue_delay_time!=null){
			if(!judgeTimeS_E(issue_end_time,issue_delay_time,"结束时间","延迟结束时间")){
				return false;
			}
		}else{
			if(!judgeTimeS_E(issue_start_time,issue_end_time,"开始时间","结束时间")){
				return false;
			}
		}
		
		//征求意见稿是添加
		DWREngine.setAsync(true);
		DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/project/feedback/online', action:'checkIssuesFileList', executeResult:'false' },
		{'project_id':'${project_id}', 'processType':'${processType}'},
		xxx1
		);
        function xxx1(data){
			if(data['flag'] == "false"){
				alert("请添加征求意见稿!");
				return false;
			}else{
				//打开添加被征求人页面
				var num=Math.random();
			    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			 	var url = "<%=request.getContextPath()%>/project/feedback/online/feedbackUserAdd.action?state=add&project_id="
			 				+"${project_id}&&processType=${processType}&issue_start_time=" 
			 				+ issue_start_time + "&issue_end_time=" 
			 				+ issue_end_time + "&issue_delay_time=" 
			 				+ issue_delay_time + "&rnm=" + rnm;
			 	var popstyle="dialogTop:150px;dialogLeft:250px;help:no;center:yes;dialogHeight:600px;dialogWidth:950px;status:"
			 				 + "yes;resizable:yes;scroll:yes";
			 	//刷新父页面
		        var t=window.showModalDialog(url,window,popstyle); 
		        if(t=="OK"){
		        	window.location.reload();
		        }
			}
 		}
        
	}

		
/*
 *开始征求
 */
function start_Issue(){

	//结束时间必须大于开始时间的校验
	var issue_start_time = document.getElementsByName("issuesObject.issue_start_time")[0].value;
	var issue_end_time = document.getElementsByName("issuesObject.issue_end_time")[0].value;
	
	if(!judgeTimeS_E(issue_start_time,issue_end_time,"开始时间","结束时间")){
		return false;
	}
    document.getElementById("startIssue").disabled=true;
    if(confirm("请确认征求意见稿及被征求人的准确性，开始征求后，将不能修改征求意见稿和被征求人!")){
		//判断是否选择了被审计单位和反馈人
		DWREngine.setAsync(true);
		DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/project/feedback/online', action:'issueStatus', executeResult:'false' }, 
		{'now_status':'${issuesObject.issue_status}','project_id':'${project_id}','processType':'${processType}','issue_start_time':issue_start_time,'issue_end_time':issue_end_time},
		xxx2);
		
		function xxx2(data){
			if(data['flag']=='false'){
				alert("请添加被征求人!");
				document.getElementById("startIssue").disabled=false;
				return;
			}else if(data['flag']=='true'){
				alert("开始征求成功！");
				window.location.reload();
			}
		}
	}else{
		document.getElementById("startIssue").disabled=false;
	}
}  

/*
 *延期征求
 */
function delay_feedback(){
		document.getElementById("delayIssue").disabled=true;
		var issue_delay_time = document.getElementsByName("issuesObject.issue_delay_time")[0].value;//延迟时间
		var issue_end_time = document.getElementsByName("issuesObject.issue_end_time")[0].value;//结束时间
		var issue_start_time = document.getElementsByName("issuesObject.issue_start_time")[0].value;//开始时间
	
		//校验延期结束日期必须大于结束时间
		if(issue_delay_time == null || issue_delay_time==""){
			alert("请选择反馈延期结束时间!");
			document.getElementById("delayIssue").disabled=false;
			return false;
		}
       if(!judgeTimeS_E(issue_end_time,issue_delay_time,"结束时间","延迟结束时间")){
       		return false;
       }
       if(confirm("请确认征求意见稿及被征求人的准确性，延期征求后，将不能修改征求意见稿和被征求人!")){
	       	//判断是否选择了被审计单位和反馈人
			DWREngine.setAsync(true);
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/project/feedback/online', action:'issueStatus', executeResult:'false' }, 
			{'project_id':'${project_id}','processType':'${processType}','issue_start_time':issue_start_time,
				'issue_end_time':issue_end_time,'issue_delay_time':issue_delay_time},
			xxx2);
			
			function xxx2(data){
				if(data['flag']=='false'){
					alert("请添加被征求人!");
					document.getElementById("delayIssue").disabled=false;
					return;
				}else if(data['flag']=='true'){
					alert("开始延期征求征求成功！");
					window.location.reload();
				}
			}
		}else{
			document.getElementById("delayIssue").disabled=false;
		}
}	

 	/*
	 *校验结束时间必须大于开始时间 或 结束时间必须大于延期时间
	 */
	function judgeTimeS_E(issue_start_time,issue_end_time,beforeTime,afterTime){
		//结束时间必须大于开始时间的校验
		if(issue_start_time!=null && issue_start_time!=""
		   && issue_end_time!=null && issue_end_time!=""){
		   
		   	    var reg=new RegExp("-","g"); //创建正则RegExp对象
		        var tempBeginTime=(issue_start_time).replace(reg,"\/");
		        var tempEndTime=(issue_end_time).replace(reg,"\/");
		        var today   =   new   Date();    //获得当前时间
		         
		        var date=today.getDate();//格式化拼接获得正确的当前时间
		        month=today.getMonth();
		        month=month+1;
		        if(month<=9)
		        month="0"+month;
		        year=today.getYear();
		        var nowDate=year+'-'+month+'-'+date;
		        var tempDate=(nowDate).replace(reg,"\/");
		        
		         if(Date.parse(new Date(tempBeginTime))>Date.parse(new Date(tempEndTime))){
		             alert("征求意见的" + afterTime + "必须大于或等于" + beforeTime + "!");
		             return false;
		        }
		        if(Date.parse(new Date(tempDate))>Date.parse(new Date(tempEndTime))){
		             alert("征求意见的" + afterTime + "不能小于当前时间!");
		             return false;
		         }
		             return true;
		}
	             return true;
	}	
	/*
	 *填写整体反馈意见
	 */
	function addFeedback(){
		var num=Math.random();
      	var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
	
	    
	    var url ='${contextPath}/project/feedback/online/viewAllidea.action?rnm='+rnm + '&project_id=${project_id}&processType=${processType}';
 		var url1 = encodeURI(url);
 		var urls = encodeURI(url1);
        window.showModalDialog(urls,window,'dialogWidth:700px;dialogHeight:550px;status:yes');

     }
      /*
       *删除整体反馈意见
       */
      function deleteFeedbackIdea(feedback_id){
      
       	if(confirm("确定删除反馈意见吗？")){
       		DWREngine.setAsync(true);
    		DWREngine.setAsync(false);DWRActionUtil.execute(
    				{ namespace:'/project/feedback/online', action:'deleteFeedbackIdea', executeResult:'false' }, 
    				{'feedback_ids':feedback_id},
    				xxx1);
   			function xxx1(data){
   				if(data['flag'] == 'true'){
        			alert("删除成功!");
        			ref();
       			}else{
       				alert("删除失败!");
       			}
       			
   			}
       	}
      }
    /*
     *更新反馈意见
     */
    function updateFeedbackIdea(feedback_id){
		var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
	
	   	var url ='${contextPath}/project/feedback/online/viewAllidea.action?rnm='+rnm + '&project_id=${project_id}&processType=${processType}&feedback_ids='+feedback_id  ;
		var url1 = encodeURI(url);
		var urls = encodeURI(url1);
	    window.showModalDialog(urls,window,'dialogWidth:700px;dialogHeight:550px;status:yes');
    }  
    /*
	 * 子窗体刷新本窗口
	 */	
	function ref(){
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		var url = "${contextPath}/project/feedback/online/issueList.action?project_id=${project_id}&processType=${processType}"
					+"&isFeedback=${isFeedback}&project_code=${project_code}";
		document.all.form1.action=url;
		document.all.form1.submit();
	}
</script>

	</head>



	<body>
		<center>

			<s:form action="saveFeedback" namespace="/mng/feedback/idea"
				name="form1">
				<s:if test="${issuesObject.processType=='report'}">
					<!-- 选择的附件信息 -->
					<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="its">
						<tr class="listtablehead">
							<td colspan="5" style="text-align: left;" class="edithead">
							   &nbsp;征求意见列表
							</td>
						</tr>
						<tr>
							<td align="left"  class="ListTableTr11" nowrap="nowrap">
								<center>被审单位</center>
							</td>
							<td align="left"  class="ListTableTr11" nowrap="nowrap">
								<center>文件名称</center>
							</td>
							<td align="left"  class="ListTableTr11" nowrap="nowrap">
								<center>上传时间</center>
							</td>
							<td align="left"  class="ListTableTr11" nowrap="nowrap">
								<center>上传人</center>
							</td>
							<td align="left"  class="ListTableTr11" nowrap="nowrap">
								<center>操作</center>
							</td>
						</tr> 
						<s:iterator value="issueFileList">
							<tr class="listtablehead">
		
										<td align="center" class="listtabletr2" >
											<center>
											<s:property value="feedback_unit_name" />
											</center>
										</td>
										<td align="center" class="listtabletr2">
											
											<s:property value="file_name" escape="false"/>
										</td>
										<td align="center" class="listtabletr2">
											<center>
											<s:property value="file_date" />
											</center>
										</td>
										<td align="center" class="listtabletr2" >
											<center>
											<s:property value="uploader_name" />
											<center>
										</td>
										<td align="center" class="listtabletr2">
										
											<center>
												<s:if test="${view!='view' && isIssue!='1'}">
													<s:a href="javascript:;" onclick="deleteFiel('${file_id}')">删除</s:a>
												</s:if>
											</center>
										</td>
							</tr>									
						</s:iterator>
					</table>
				</s:if>
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="its">
					<tr >
						<td colspan="6" style="text-align: left;" class="edithead">
							&nbsp;征求期间
						</td>
					</tr>
					<tr>
						<td align="right" width="11%"  class="ListTableTr11">
							开始日期:
						</td>
						<td  class="ListTableTr22" width="17%" align="left">
							<s:if test="${view!='view' && (issuesObject.issue_status=='1' || issuesObject.issue_status =='2')}">
								<s:textfield id="issue_start_time"
									name="issuesObject.issue_start_time" readonly="true"
									cssStyle="width:100%" maxlength="20">
								</s:textfield>
							</s:if>
							<s:else>
								<s:textfield id="issue_start_time"
									name="issuesObject.issue_start_time" readonly="true"
									cssStyle="width:100%" maxlength="20" title="单击选择日期"
									onclick="calendar()" theme="ufaud_simple"
									templateDir="/strutsTemplate" ></s:textfield>
							</s:else>
						</td>
						<td align="right" width="11%"  class="ListTableTr11">
							结束日期:
						</td>
						<td  class="ListTableTr22" width="18%" align="left">
								<s:if
									test="${view!='view' && (issuesObject.issue_status=='1' || issuesObject.issue_status =='2')}">
									<s:textfield id="issue_end_time"
										name="issuesObject.issue_end_time" readonly="true"
										cssStyle="width:100%" maxlength="20"></s:textfield>
								</s:if>
								<s:else>
									<s:textfield id="issue_end_time"
										name="issuesObject.issue_end_time" readonly="true"
										cssStyle="width:100%" maxlength="20" title="单击选择日期"
										onclick="calendar()" theme="ufaud_simple"
										templateDir="/strutsTemplate"></s:textfield>
								</s:else>
						</td>
						<td align="right" width="11%"  class="ListTableTr11">
							延期结束日期:
						</td>
						<td  class="ListTableTr22" width="20%" align="left">
								<s:if test="${view!='view' && (issuesObject.issue_status=='1' || issuesObject.issue_status =='2')}">
									<s:textfield id="issue_delay_time"
										name="issuesObject.issue_delay_time" 
										cssStyle="width:100%" maxlength="20" title="单击选择日期"
										onclick="calendar()" theme="ufaud_simple"
										templateDir="/strutsTemplate"></s:textfield>
								</s:if>
								<s:else>
									<s:textfield id="issue_delay_time"
										name="issuesObject.issue_delay_time" readonly="true"
										cssStyle="width:100%" maxlength="20">
									</s:textfield>
								</s:else>
						</td>
					</tr>
				</table>
				<!-- 添加反馈人员信息 -->
				<table  class="its">
					<tr >
						<td colspan="4" style="text-align: left;" class="edithead">&nbsp;征求单位/人员信息</td></tr>
					<tr align="center" >
						<td align="center"  class="ListTableTr11" nowrap="true"><center>被审计单位</center></td>
						<td  class="ListTableTr11" nowrap="true" ><center>反馈登陆账号</center></td>
						<td  class="ListTableTr11" nowrap="true" ><center>反馈姓名</center></td>
						<td  class="ListTableTr11" nowrap="true" ><center>征求状态</center></td>
						<td  class="ListTableTr11" nowrap="true"><center>操作</center></td>
					</tr>
					<s:iterator value="issueList" id="row">
						<tr>
							<td align="center" class="listtabletr2" >
								<center>
								<s:property value="feedback_unit_name" />
								</center>
							</td>
							<td align="center" class="listtabletr2" >
								<center>
								<s:property value="feedback_user" />
								</center>
							</td>								
							<td align="center" class="listtabletr2" >
								<center>
								<s:property value="feedback_user_name" />
								</center>
							</td>
							<td align="center" class="listtabletr2">
								<center>
									<font color="red">
										<s:if test="${issue_status=='0'}">
											未征求
										</s:if>
										<s:if test="${issue_status=='1'}">
											开始征求
										</s:if>
										<s:if test="${issue_status=='2'}">
											延期征求
										</s:if>
									</font>
								</center>
							</td>
							<td  align="center" class="listtabletr2">
								<center>
										<s:if test="${view!='view' && issue_status=='0'}">
											<a href="javascript:;" onclick="deleteBackUser('${issue_id}','${issue_file }')">删除</a>
										</s:if>
								</center>
							</td>
						</tr>
					</s:iterator>
				</table>

				<table class="its">
					<tr>
						<td colspan="10" style="text-align: left;" class="edithead">
							被审计反馈意见
						</td>
					</tr>
					<tr>
					<td align="left"  class="ListTableTr11">
							<center>
								征求意见稿列
							</center>
						</td>
						<td align="left"  class="ListTableTr11">
							<center>
								被审计单位
							</center>
						</td>
						<td align="left" class="ListTableTr11" >
							<center>
								反馈意见内容
							</center>
						</td>
						<td align="left"  class="ListTableTr11">
							<center>
								反馈文件
							</center>
						</td>												
						<td align="left"  class="ListTableTr11">
							<center>
								反馈人
							</center>
						</td>
						
						<td align="left"  class="ListTableTr11">
							<center>
								是否有纸质反馈意见
							</center>
						</td>
						<td align="left"  class="ListTableTr11">
							<center>
								电子反馈意见与纸质反馈意见是否相符
							</center>
						</td>
						<td align="left"  class="ListTableTr11">
							<center>
								纸质反馈意见是否盖章签字
							</center>
						</td>
						<td align="left"  class="ListTableTr11">
							<center>
								反馈时间
							</center>
						</td>
						<td align="left"  class="ListTableTr11">
							<center>是否在线</center>
						</td>
						<td align="left"  class="ListTableTr11">
							<center>操作</center>
						</td>
					</tr>

					<s:iterator value="feedbackList" status="index" id="feedback">
						<tr class="listtablehead">
						<td align="left" class="listtabletr2" >
								<center>
									${file_name}
								</center>
							</td>
							<td align="left" class="listtabletr2" >
								<center>
									${feedback_unit_name}
								</center>
							</td>
							<td align="left" class="listtabletr2"  style='word-break:break-all;word-wrap:break-word;width:300px'>
								<center>
									${feedback_content}
								</center>
							</td>
							<td align="left" class="listtabletr2" >
								<center>
									${feedback_file}
								</center>
							</td>												
							<td align="left" class="listtabletr2">
								<center>
									${feedback_user_name}
								</center>
							</td>
							
							<td align="left" class="listtabletr2">
								<center>
									<s:if test="${is_paper==null||is_paper=='false'}">
										否
									</s:if>
									<s:else>
										是
									</s:else>
								</center>
							</td>
							<td align="left" class="listtabletr2" >
								<center>
									<s:if test="${paper_elec_match==null||paper_elec_match=='false'}">
										否
									</s:if>
									<s:else>
										是
									</s:else>
								</center>
							</td>
							<td align="left" class="listtabletr2" >
								<center>
									<s:if test="${paper_seal==null||paper_seal=='false'}">
										否
									</s:if>
									<s:else>
										是
									</s:else>
								</center>
							</td>
							
							<td align="left" class="listtabletr2" >
								<center>
									${feedback_time_page}
								</center>
							</td>
							<td align="left" class="listtabletr2">
								<center>
									<s:if test="${is_online=='0'}">
										否
									</s:if>
									<s:else>
										是
									</s:else>
								</center>
							</td>
							<td align="left" class="listtabletr2" style='word-break:break-all;word-wrap:break-word;width:40px'>
								<center>
									<s:if test="${is_online=='0' && view!='view'}">
										<s:if test="isFeedback!=null && isFeedback!='' && isFeedback=='true'">
											<s:if test="${issuesObject.processType=='report'}">
												<s:if test="${btnRight == 'zhushen'|| btnRight == 'zuzhang' || btnRight=='zhushenzuzhang'}">
												<a href="javascript:;" onclick="updateFeedbackIdea('${feedback_id}')" style="cursor: hand">修改</a>
												<br>
												<a href="javascript:;" onclick="deleteFeedbackIdea('${feedback_id}')" style="cursor: hand">删除</a>
												</s:if>
											</s:if>
										</s:if>
									</s:if>
								</center>
							</td>
						</tr>
					</s:iterator>
				</table>
				<s:if test="${view!='view'}">
					<div align="right">
						
						<s:if test="isFeedback!=null && isFeedback!='' && isFeedback=='true'">
							<s:if test="${issuesObject.processType=='report'}">
								<s:button id="addIssueFile" value="增加征求意见" onclick="add_issue_file()"/>
								<s:if test="${btnRight == 'zhushen'|| btnRight == 'zuzhang' || btnRight=='zhushenzuzhang'}">
									<s:button value="增加反馈意见" onclick="addFeedback()" ></s:button>
								</s:if>									
								
								
							</s:if>
							<s:button id="addFeedbackUser" value="增加被征求人" onclick="return add_feedbackUser()" />
							<s:if test="${startBtn=='YES'}">
								<s:button id="startIssue" value="开始征求" onclick="return start_Issue();" />
							</s:if>
							<s:else>
								<s:button id="startIssue" value="开始征求" disabled="true"
									onclick="return start_Issue();" />
							</s:else>
	
	
							<!--  延期征求：1 征求时间已经过了 2 延期时间在当前时间之前 3 已经征求 -->
							<s:if
								test="issuesObject.issue_status ==1 || issuesObject.issue_status ==2">
								<s:button id="delayIssue" value="延期征求" onclick="return delay_feedback()" />
							</s:if>
							<s:else>
								<s:button value="延期征求" disabled="true"
									onclick="return delay_feedback()" />
							</s:else>
						</s:if>
					</div>
				</s:if>
			</s:form>

		</center>
	</body>
</html>
