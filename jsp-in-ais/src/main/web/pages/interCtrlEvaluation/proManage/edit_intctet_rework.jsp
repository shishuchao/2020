<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>整改跟踪阶段</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();" style="padding:0px;margin:0px;">
</s:if>
<s:else>
	<body  style="padding:0px;margin:0px;" >
</s:else>
<!-- -->
<s:if test="${param.supervisorcode != 'view' }">
	<div  style='padding:0px;overflow:hidden;position:absolute;top:0px;right:2px;z-index:9011;display:none;' id="flowBtns">	
		<s:form id="flowForm" cssStyle="padding:0px;margin:0px;">			
			<div style='text-align:right;border:0px;width:100%;' >
				<span style='float:right;text-align:right;'>
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
				</span>
			</div>			
			<s:hidden name="crudObject.formId"/>
			<s:hidden name="crudObject.epId"/>
			<s:hidden name="crudObject.proName"/>
			<s:hidden name="crudObject.proCode"/>
			<s:hidden name="crudObject.fileRework"/>
		</s:form> 
	</div>
</s:if>

<iframe id="reworkWorkProgram"
	src="${contextPath}/intctet/defectRectification/initDefectRectPage.action?formId=${crudObject.epId}&taskInstanceId=${taskInstanceId}"
	frameborder="0" width="100%" height="100%"  
	marginheight='0'  marginwidth='0'  scrolling='no'></iframe>

<s:if test="taskInstanceId!=null&&taskInstanceId!='-1'">
		<s:if test="${taskview != 'view' && taskInstanceId != '-1' }">
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			</div>
		</s:if>
		<div align="center">
			<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
		</div>
</s:if>
<script type="text/javascript">
 	$(function(){
		var offset = 5; 		
 		$('#reworkWorkProgram').css('height', $(window).height() - offset);
 		//setIframeHeight("reworkWorkProgram");
 	})
	/* 获取子 页面的 高度 */
	function setIframeHeight(id){
	    try{
	        var iframe = document.getElementById(id);
	        var fla = false ;
	        if(iframe.attachEvent){
	            iframe.attachEvent("onload", function(){
	            	fla = true;
	                iframe.height =  iframe.contentWindow.document.documentElement.scrollHeight +  300;
	            });
	            //IE8
	            if(!fla && iframe ){
	               var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow; 
	                 if (iframeWin.document.body) {
	                    iframe.height = (iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight) + 300 ;
	                   }
	            }
	            return;
	        }else{
	            iframe.onload = function(){
	               iframe.height = iframe.contentDocument.body.scrollHeight +  300;
	            };
	            return;                 
	        }     
	    }catch(e){
	        throw new Error('setIframeHeight Error');
	    }
	} 
	
			function doStart(){
				document.getElementById('projectReworkForm').action = "start.action";
				document.getElementById('projectReworkForm').submit(); 
			}
	
			function beforStartProcess(){
				//判断补充审计文书有没有
				if(isGoOn()){
				 }	
				return true;
			}
			
			function isGoOn() {
				var flag = true;
				$.ajax({
					url:'${contextPath}/intctet/rework/isGoOn.action',
					data:{'epId':'${crudObject.epId}'},
					type:'POST',
					async:false,
					success:function(data) {
						if(data == '1') {
							flag = false;
							showMessage1('存在未完成的整改进度评价！');
						}
					}
				});
				return flag;
			}
		
			/*
				提交表单
			*/
			function toSubmit(option){
				//判断补充审计文书有没有
				if(!isGoOn()){
	    			  return false;
	    		 }else{
	    			 <s:if test="isUseBpm=='true'">
						if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
							var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
							if(actor_name==null||actor_name==''){
								showMessage1('下一步处理人不能为空！');
								return false;
							}
						}
						</s:if>
						top.$.messager.confirm('确认','确定要提交流程吗?',function(r1){
							if(r1){
								<s:if test="isUseBpm=='true'">
								flowForm.action="<s:url action="submit" includeParams="none"/>";
								</s:if>
								<s:else>
								flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
								</s:else>
								flowForm.submit();
							}
						});
	    		 }
			}

			/*
				校验两个日期大小顺序
			*/
			function validateDate(beginDateId,endDateId){
				var s1 = document.getElementById(beginDateId);
				var e1 = document.getElementById(endDateId);
				if(s1 && e1){
					var s = s1.value;
					var e = e1.value;
					if(s!='' && e!=''){
						var s_date=new Date(s.replace("-","/"));
						var e_date=new Date(e.replace("-","/"));
						if(s_date.getTime()>e_date.getTime()){
							showMessage1("日期区间开始必须小于结束!");
							return false;
						}
					}
				}
				return true;
			}
		
		</script>
</body>
</html>