<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<div style="margin: 0 auto;">
	<s:button value="实施方案" cssStyle="margin: auto 5px;" onclick="sszy();"/>
	<s:if test="@ais.project.ProjectSysParamUtil@isZXSJEnabled()">
		<s:button value="在线审计" cssStyle="margin: auto 5px;" onclick="zxsj();" />
	</s:if>
</div>
<script type="text/javascript">

	/**
	 * 实施作业
	 */
	function sszy(){
		var actualizeFormIds = document.getElementsByName("actualizeFormIds");
		var h = window.screen.height;
		var w = window.screen.width;
		var isChecked = false;
		for(var i=0;i<actualizeFormIds.length;i++){
			if(actualizeFormIds[i].checked){
				isChecked = true;
				var projectId = document.getElementById(actualizeFormIds[i].value+"_project_id").value;
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);
				win = window.open('<%=request.getContextPath()%>/pages/operate/index.jsp?project_id='+projectId,'cw11','height=768,width=1024,status=no,toolbar=no,menubar=no,location=no,resizable=yes');
				win.moveTo(0,0)   
				win.resizeTo(w,h) 
				if(win && win.open && !win.closed){
                  win.focus();
				}
				break;
			}
		}
		if(!isChecked){
			alert('请选择一个项目!');
		}
	}
	
	/**
	 * 在线审计
	 */
	function zxsj(){
		var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
		var actualizeFormIds = document.getElementsByName("actualizeFormIds");
		var isChecked = false;
		for(var i=0;i<actualizeFormIds.length;i++){
			if(actualizeFormIds[i].checked){
				var isChecked = true;
				var projectCode = document.getElementById(actualizeFormIds[i].value+"_project_code").value;
				var auditStartTime = document.getElementById(actualizeFormIds[i].value+"_audit_start_time").value;
				if(auditStartTime==''){
					alert('审计期间没有定义,无法在线作业!');
					return false;
				}
				var start_1=auditStartTime.split("-")[0];
				var start_2=auditStartTime.split("-")[1];
				var start_3=auditStartTime.split("-")[2];
				
				if(start_2.length==1){
					start_2 = '0' + start_2;
				}
				if(start_3.length==1){
					start_3 = '0' + start_3;
				}
				
				var start=start_1+start_2+start_3;
				
				var auditEndTime = document.getElementById(actualizeFormIds[i].value+"_audit_end_time").value;
				if(auditEndTime==''){
					alert('审计期间没有定义,无法在线作业!');
					return false;
				}
				var end_1=auditEndTime.split("-")[0];
				var end_2=auditEndTime.split("-")[1];
				var end_3=auditEndTime.split("-")[2];
				
				if(end_2.length==1){
					end_2 = '0' + end_2;
				}
				if(end_3.length==1){
					end_3 = '0' + end_3;
				}
				
				var end=end_1+end_2+end_3;	

				//var queryString = encode64(encodeURI(""+projectCode+","+start+","+end));
                var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
                var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
                var url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
				
				window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
				break;
			}
		}
		if(!isChecked){
			alert('请选择一个项目!');
		}
	}
	
</script>
