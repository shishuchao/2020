<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="ais.framework.util.MyProperty" %>
<%-- 

//-----------功能描述----------------//
此页面实现"心跳"机制,页面定时向服务器发送心跳信息,服务器
接收到心跳信息后根据sessionId(主键)去更新用户在线情况表
1.如果指定时间内服务器接收不到心跳信息的话表示用户已经下线,清除在线情况表的对应用户记录
此操作服务器后台定时扫描表进行操作
2.如果发送心跳的客户端超出服务器license.lib中授权的用户数,
不允许最后登录系统的用户操作系统,系统直接自动注销该用户
--%>
<script type="text/javascript">
	
	
	$(function(){
		sendHeartBeat();
	});
	
	var heartBeatTimer = setInterval("sendHeartBeat()",120000);//每2分钟发送心跳信息
	
	function sendHeartBeat(){
		jQuery.ajax({
			url:"${contextPath}/heartbeat/heartBeat.action",
			type:"get",
			async:false,
			cache:false,
			dataType:"text",
			success:function(message){
				if(message != null && message != ''){
					if(message=='logout_by_other_machine'){
						//top.$.messager.alert('提示','您的账户已经在其它机器登录,您被迫下线!');
						//window.location='${pageContext.request.contextPath}/system/uSystemAction!loginOut.action';
					}else if(message=='logout_by_license'){
						// alert('您登录系统后系统超出了授权的最大登录用户数,您被迫下线!');
						<%--window.location='${pageContext.request.contextPath}/system/uSystemAction!loginOut.action'; --%>
					}
				}
			}
		});
	}
	
</script>
