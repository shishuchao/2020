<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
	<table style="padding: 0;border-spacing: 0;border-collapse: 0;">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				 <div id="message"></div>
			</td>
		</tr>
	</table>
<script type="text/javascript">
		var req=false;
 		//创建一个XMLHttpRequest对象
 		function u_createXMLHttpRequest(){
 				if(window.XMLHttpRequest){ //Mozilla 浏览器
 					req=new XMLHttpRequest();
 					}
 					else if(window.ActiveXObject){ //微软IE 浏览器
 						try{
 							req=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
 							}catch(e){
 								try{
 									req=new ActiveXObject("Microsoft.XMLHTTP");
									//IE 5.0版本
 									}catch(e){}
 									}
 								}
 		}
 		//发送请求函数
 		function u_send(){
 			var url="<%=request.getContextPath()%>/titlePath.action?u_title=<%=request.getParameter("u_title")%>";
 			u_createXMLHttpRequest();
 			req.open("post",url,true);
 			req.onreadystatechange=u_proce;   //指定响应的函数
 			req.send(null);  //发送请求
 			};
 		function u_proce(){
 			if(req.readyState==4){ //对象状态
 				if(req.status==200){//信息已成功返回，开始处理信息
 				var resText = req.responseText;
 				document.getElementById('message').innerHTML=resText;
 				}else{
 					//window.alert("所请求的页面有异常");
 					}
 					}
 		}
 		u_send()
</script>