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
	<body onload="end();" >
</s:if>
<s:else>
	<body class="easyui-layout" >
</s:else>
	<s:form id="projectReworkForm" action="save" namespace="/project/rework">
	<s:if test="${param.supervisorcode != 'view' }">
		<div region="north" height="30px" style="border:0px">
			<div align="left" style="width: 99%"  height="30px" >
				<span style='float:right;text-align:left; margin-top: 2px;'>
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
				</span>
			</div>
		</div>
		</s:if>
		<div  region="center">
			
		<div id="proInfoDiv" style="display: none;">
			<jsp:include page="/pages/project/start/edit_start_include.jsp" />
		</div>
		<div id='auditWorkProgramRework'  style="width:100%; height: 100%; overflow: hidden;"  border="false" >
			<iframe id="reworkWorkProgram" style="height: 100%;"
				src="${contextPath}/workprogram/editWorkProgramProjectDetail.action?projectid=${crudObject.project_id}&wpd_stagecode=rework&supervisorcode=${param.supervisorcode}"
				frameborder="0" width="100%"  ></iframe>
		</div>
		<s:if test="${taskview != 'view' && taskInstanceId != '-1' }">
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			</div>
		</s:if>
		<div align="center">
			<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
		</div>
	
	</s:form>
	</div>
	<script type="text/javascript">
 	$(function(){
 		setIframeHeight("reworkWorkProgram");
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
		
			/**
			*	整改台账编辑
			*/
			function zgtz(){
				window.open("${pageContext.request.contextPath}/proledger/problem/listEditProblem.action?project_id=${crudObject.project_id}&isrework=true","","resizable=yes,menubar=no,directories=no,status=no,location=no,scrollbars=yes,width=700,height=575,left=0,top=0");
			}
			
			/*
			*   删除整改跟踪阶段文档
			*/
			function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true){
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
					function xxx(data){
					  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
					} 
				}
			}
		
			/*
				上传整改跟踪阶段文档
			*/
			function Upload(){
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
				window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=<s:property value="crudObject.fileRework"/>&&param='+rnm+'&&deletePermission=<s:property value="%{varMap.deleteuploadfileReworkRead}"/>&&isEdit=<s:property value="%{varMap.edituploadfileReworkRead}"/>&&title='+encodeURI(encodeURI("整改文件信息")),accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
			//判断补充审计文书有没有
			function isGoOn(){
		    	var flag = false;
		    	$.ajax({
					url:'${contextPath}/workprogram/isGoOn.action',
					type:'POST',
					data:{"projectid":'${crudObject.project_id}',"wpd_stagecode":'rework'},
					dataType:'json',
				    async:false,
					success:function(data){
						if(data == 2) {
				      		window.parent.$.messager.show({
				      			title:'提示信息',
								msg:'缺少补充审计文书！',
								timeout:5000,
								showType:'slide'
							});
							flag = true;
						}else if(data == 3){
							window.parent.$.messager.show({
				      			title:'提示信息',
								msg:'存在整改评价状态为空的整改问题！',
								timeout:5000,
								showType:'slide'
							});
							flag = true;
						}else if(data == 4){
							window.parent.$.messager.show({
				      			title:'提示信息',
								msg:'台账尚未录入完毕',
								timeout:5000,
								showType:'slide'
							});
							flag = true;
						} else {
							flag = false;
						}
					},
					error:function(){
						$.messager.alert("系统错误，请联系系统管理员！",'info');
						flag = true;
					}
				});
		    	return flag;
	    	}

			/*
				提交表单
			*/
			function toSubmit(option){
				//判断补充审计文书有没有
				if(isGoOn()){
	    			  return false;
	    		 }else{
	    				var tableId = 'projectStartTable';
						var formId = 'projectReworkForm';

						if(!validateDate('audit_start_time','audit_end_time')){
							return false;
						}
						var flowForm = document.getElementById(formId);
						if(frmCheck(flowForm,tableId)==false){
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
									document.getElementById('submitButton').disabled=true;
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
			}
			/*
				保存表单
			*/
			function toSave(formId,tableId){
				if(!validateDate('audit_start_time','audit_end_time')){
					return false;
				}
				var flowForm = document.getElementById(formId);
				document.getElementById('saveButton').disabled=true;
				if(frmCheck(flowForm,tableId)==false){
					document.getElementById('saveButton').disabled=false;
					return false;
				}else{	
					flowForm.action="${contextPath}/project/rework/save.action";
					flowForm.submit();
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