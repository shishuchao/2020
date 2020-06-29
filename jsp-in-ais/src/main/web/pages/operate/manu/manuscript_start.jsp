<%@ page contentType="text/html; charset=UTF-8"%>
<SCRIPT type="text/javascript"
	src="/ais/scripts/ais_functions.js"></SCRIPT>
<a href="/ais/bpm/taskinstance/pending.action" target="_blank">待办</a>
<input type=button value="启动流程"
	onclick="pop_bpm_start_window('/ais/pages/bpm/darado/start.jsp?form_type=1031&form_id=p3',__bpm_started)">
<input type=button value="提交流程"
	onclick="pop_bpm_submit_window('/ais/pages/bpm/darado/submit.jsp?crudId=p1&taskInstanceId=4',__bpm_submited)">	
<script language="javascript">
	function __bpm_started(){
		alert("__bpm_started");
	}
	function __bpm_submited(){
		alert("__bpm_started");
	}
</script>
