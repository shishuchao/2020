<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>

		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>

		<script type="text/javascript">
			function mysubmit(){
				if(frmCheck(document.forms[0],'chgTab')){
					var newId=document.getElementsByName('newId')[0].value;
					var selectedId=document.getElementsByName('selectedId')[0].value;
					var ffunid=document.getElementsByName('abf.ffunid')[0].value;
					url="<%=request.getContextPath()%>/system/omChgNode.action?newId="+newId+"&selectedId="+selectedId+"&abf.ffunid="+ffunid;
					window.location=url;
					//send(url,proce);
				}
				//return false;
			}
		</script>
		<script type="text/javascript">
			var XMLHttpReq=false;
			//创建一个XMLHttpRequest对象
			function createXMLHttpRequest(){
					if(window.XMLHttpRequest){ //Mozilla 浏览器
						XMLHttpReq=new XMLHttpRequest();
						}
						else if(window.ActiveXObject){ //微软IE 浏览器
							try{
								XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
								}catch(e){
									try{
										XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
									//IE 5.0版本
										}catch(e){}
										}
									}
			}
			//发送请求函数
			function send(url,functionName){
				createXMLHttpRequest();
				XMLHttpReq.open("GET",url,true);
				XMLHttpReq.onreadystatechange=functionName;//指定响应的函数
				XMLHttpReq.send(null);  //发送请求
			};
			function proce(){
				if(XMLHttpReq.readyState==4){
					if(XMLHttpReq.status==200){ //对象状态,信息已成功返回，开始处理信息
						var resText = XMLHttpReq.responseText;
						if(resText==1){
							meth1();
						}else if(resText==2){
							meth2();
						}
					}
				}
				
			}
			function meth1(){
				alert('调整成功!');
				parent.parent.location.reload();
			}
			function meth2(){
				alert('调整失败!原因可能是输入的主键已经存在或者该主键与关联节点不在同一个级别层次上面!');
			}
		</script>
	</head>
	<body style="overflow: hidden;">
		<center>
			<s:form action="omChgNode" namespace="/system">
				<table id='chgTab' cellpadding=0 cellspacing=1 border=0
					 class="ListTable">
					<tr>
						<td class="EditHead">
							<font color=red>*</font>&nbsp;关联节点

						</td>
						<td class="editTd">
							<s:buttonText2 id="selectedName" name="selectedName" 
					         hiddenId="selectedId" hiddenName="selectedId"
					         cssClass="noborder"
							 doubleOnclick="queryData('/ais/pages/system/menu/menu.jsp','节点参照',440,410,'selectedId','selectedName')"
							 doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							 doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td class="EditHead">
							<font color=red>*</font>&nbsp;新功能序号

						</td>
						<td class="editTd">
							<s:textfield name="newId" cssClass="noborder"></s:textfield>
						</td>
					</tr>
				</table>
				<input type="hidden" name="abf.ffunid" id="abf.ffunid" value="<%=request.getParameter("abf.ffunid")%>">
				<div style="text-align:right;margin-top:8px;padding-right:8px;">
				    <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="mysubmit()">调整</a>
				</div>
			</s:form>
			<div id="subwindow" class="easyui-window" title="" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
				<div class="easyui-layout" fit="true">
					<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
						<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" title=""></iframe>
					</div>
					<div region="south" border="false" style="text-align:right;padding:5px 0;">
					    <div style="display: inline;" align="right">
					        <input type="hidden" id="para1" value="">
					        <input type="hidden" id="para2" value="">
							<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveF()">确定</a>
							<a class="easyui-linkbutton" iconCls="icon-remove" href="javascript:void(0)" onclick="cleanF()">清空</a>
							<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
					    </div>
					</div>
				</div>
			</div>
		</center>
		<script type="text/javascript">
			function queryData(url,title,width,height,para1,para2){
				if($('#item_ifr').attr('title') == title){
					if($('#item_ifr').attr('src') == ''){
						$('#item_ifr').attr('src',url);
					}
				}else{
					$('#item_ifr').attr('title',title);
					$('#item_ifr').attr('src',url);
				}
				$('#para1').attr('value',para1);
				$('#para2').attr('value',para2);
				$('#subwindow').window({
					title: title,
					width: width,
					height:height,
					modal: true,
					shadow: true,
					closed: false,
					collapsible:false,
					maximizable:false,
					minimizable:false
				});
			}
			function saveF(){
				var ayy = $('#item_ifr')[0].contentWindow.saveF();
				var p1 = $('#para1').attr('value');
				var p2 = $('#para2').attr('value');
				document.all(p1).value=ayy[0];
	    		document.all(p2).value=ayy[1];
	    		closeWin();
			}
			function cleanF(){
				var p1 = $('#para1').attr('value');
				var p2 = $('#para2').attr('value');
				document.all(p1).value='';
	    		document.all(p2).value='';
	    		closeWin();
			}
			function closeWin(){
				$('#subwindow').window('close');
			}
		</script>
	</body>
</html>