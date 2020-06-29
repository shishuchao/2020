<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<%-- <meta http-equiv="refresh"
			content="3;url=<s:url action="pending" namespace="/bpm/taskinstance" includeParams="none"></s:url>"> --%>
		<title>系统提示</title>
		<style type="text/css">

body {
    background:    fff;
    font:        MessageBox;
    font:        Message-Box;
}

marquee {
    border:        1px solid #bac5d1;
    background:    #e7eef6;
    height:        12px;
    font-size:    1px;
    margin:        1px;
    width:        400px;
    -moz-binding:    url("marquee-binding.xml#marquee");
    -moz-box-sizing:    border-box;
    display:        block;
    overflow:        hidden;
}

marquee span {
    height:            18px;
    margin:            1px;
    width:            6px;
    background:        #2e7de4;
    float:            left;
    font-size:        1px;
    font-color:black;
}

.progressBarHandle-0 {
    filter:        alpha(opacity=20);
    -moz-opacity:    0.20;
}

.progressBarHandle-1 {
    filter:        alpha(opacity=40);
    -moz-opacity:    0.40;
}

.progressBarHandle-2 {
    filter:        alpha(opacity=60);
    -moz-opacity:    0.6;
}

.progressBarHandle-3 {
    filter:        alpha(opacity=80);
    -moz-opacity:    0.8;
}

.progressBarHandle-4 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1;    
}


.progressBarHandle-5 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1.2;    
}

.progressBarHandle-6 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1.4;    
}

.progressBarHandle-7 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1.8;    
}
.progressBarHandle-8 {
    filter:        alpha(opacity=100);
    -moz-opacity:    2;    
}
.progressBarHandle-9 {
    filter:        alpha(opacity=100);
    -moz-opacity:    2.2;    
}



</style>
<script type="text/javascript">

function wypagestyle(){
	setTimeout(function(){
		wypage();
		reloadHomeAfterSubmitFlow();
	},3 * 1000);
}


 function wypage(){
	 var wynamespacepage=document.getElementById("wynamespacepageid").value;  
    var wyactionpage="";
	 var crudId=  document.getElementById("crudId").value;
	 var project_id=  document.getElementById("project_id").value;  
	 var nextTaskInstanceId=  document.getElementById("nextTaskInstanceId").value;
	 var projectType= document.getElementById("projectType").value; 
	 var recheck=document.getElementById("recheck").value; 
	 var todoback=document.getElementById("todobackid").value;
	 var rework_closed=document.getElementById("rework_closed").value;   //
	 var fromAdjust=document.getElementById("fromAdjustid").value;//准备 阶段 --实施方案 调整 
	 var parsepage="";//添加 的参数 
	 if(wynamespacepage != null && wynamespacepage !=""){//
		 if(wynamespacepage == "/project/prepare/"  ||wynamespacepage == "/operate/manu" || wynamespacepage == "/project/prepare/audAdvice/" || wynamespacepage == "/project/report/" || wynamespacepage == "/ledger/prjledger/projectLedgerNew/"){
	
			 if(fromAdjust!= null && fromAdjust != "" && fromAdjust.indexOf("yes") != -1 ){//准备阶段 -实施方案 调整 
				 wyactionpage="edit"	
				 parsepage="%26fromAdjust=yes";
			}else{ 
				 wyactionpage="edit"
			}
		 } else if(wynamespacepage == "/project/evidence/"){//

			 wyactionpage="listEvidence"
		 }else if(wynamespacepage == "/operate/audBook/"){//
			
			 wyactionpage="getlistBooks"
		 } else if(wynamespacepage == "/project/rework/"){//整改跟踪 阶段   
			 wyactionpage="edit"
			 if(rework_closed != null && rework_closed != ""&& rework_closed == 1){ //整改跟踪阶段 结束 
				 parsepage="%26view=view";
			 }
		 }
	 } 
	if(todoback != 1 && wynamespacepage != null && wynamespacepage !="" && wyactionpage != ""){
		var vaurl="<%=request.getContextPath()%>"+wynamespacepage+wyactionpage+".action?crudId="+crudId+parsepage+"%26project_id="+project_id+"%26projectType="+projectType+"%26recheck="+recheck+"%26taskInstanceId="+nextTaskInstanceId+"%26todoback="+todoback+"%26firstManu=${firstManu}";
		window.location.replace("<%=request.getContextPath()%>/bpm/taskinstance/pending.action?vail=2&vaurl="+vaurl);

	}
	else{
   	window.location.replace("<%=request.getContextPath()%>/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}");
	 } 
 }
 

function reloadHomeAfterSubmitFlow(){
	try{
    	// 是否来自审计作业页面
   		var isJobPage = false;
     	var bodyId = top.document.body.id;
     	//alert(bodyId)
    	if(bodyId == 'projectLayout'){
        	isJobPage = true;
      	}else if(bodyId == 'mainLayout'){
          	isJobPage = false;
      	}
     	var pageWin = isJobPage ? window.top.opener.parent : window.top; 
     	//alert(pageWin.reloadHomePage)
		if(pageWin && pageWin.reloadHomePage){
       		pageWin.reloadHomePage();
		}
	}catch(e){
		//alert('reloadHomeAfterSubmitFlow:\n'+e.message);
	}
}
</script>
	</head>
	
	<body onload="wypagestyle();">
		<table width="100%" height="100%">
			<tr>
				<td align="center">
					<center>
					正在进行，请稍候...
					<marquee direction="right" scrollamount="8" scrolldelay="100">
					    <span class="progressBarHandle-0"></span>
					    <span class="progressBarHandle-1"></span>
					    <span class="progressBarHandle-2"></span>
					    <span class="progressBarHandle-3"></span>
					    <span class="progressBarHandle-4"></span>
					    <span class="progressBarHandle-5"></span>
					    <span class="progressBarHandle-6"></span>
					    <span class="progressBarHandle-7"></span>
					    <span class="progressBarHandle-8"></span>
					    <span class="progressBarHandle-9"></span>
					</marquee>
					</center>
				</td>
			</tr>
			
			 <s:hidden name="wynamespacepage" id="wynamespacepageid"></s:hidden>
			
			<s:hidden name="crudId" id="crudId"></s:hidden>
			<s:hidden name="project_id" id="project_id"></s:hidden>
			
			<s:hidden name="projectType" id="projectType"></s:hidden>
			<s:hidden name="recheck" id="recheck"></s:hidden> 
			<s:hidden name="todoback" id="todobackid"></s:hidden>
			<s:hidden name="fromAdjust" id="fromAdjustid"></s:hidden>
			<s:hidden name="projectStartObject.rework_closed" id="rework_closed"></s:hidden>
			<s:hidden name="formInfo.nextTaskInstanceId" id="nextTaskInstanceId"></s:hidden>
		</table>
	</body>
</html>
