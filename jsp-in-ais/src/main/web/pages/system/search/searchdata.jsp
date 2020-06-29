<%@ page contentType="text/html; charset=utf-8" %>
<HTML>
<HEAD>
  <meta http-equiv="X-UA-Compatible" content="IE=5">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>search</TITLE>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
	<Script language=Javascript>
		function RefreshWin(){
			var url="";
			var ay = getParameter(window.location.href);
			var dmethod="list";
			var pItem = "";
			var orgType = "";
			var extend = "";
			var returnCurrent = "";
			for (var i=0;i<ay.length;i++) {
			   if (ay[i].name.toLowerCase()=="url") {
				 url=ay[i].value;
			   }
			   if (ay[i].name.toLowerCase()=="method") {
			     dmethod=ay[i].value;
			   }
			   if (ay[i].name.toLowerCase()=="paraname") {
			     document.all.paraName.value=ay[i].value;
			   }
			   if (ay[i].name.toLowerCase()=="paraid") {
			     document.all.paraID.value=ay[i].value;
			   }
			   if (ay[i].name.toLowerCase()=="funname") {
			     document.all.funname.value=ay[i].value;
			   }
			   if (ay[i].name=="returnCurrent") {
			    	returnCurrent=ay[i].value;
			   }
			   if (ay[i].name.toLowerCase()=="p_item") {
				   pItem = "&p_item="+ay[i].value+"";
			   }
			   if (ay[i].name.toLowerCase()=="orgtype") {
				   orgType = "&orgtype="+ay[i].value+"";
			   }
			   if (ay[i].name.toLowerCase()=="project_id") {
				   orgType = "&project_id="+ay[i].value+"";
			   }
			   if (ay[i].name.toLowerCase()=="urlpara") {
				   var fun = ay[i].value;
				   try{
				   	extend = eval("window.parent."+fun+"()");
				   }catch(e){}
			   }
			}
			document.all.selectspace.src=url+"?method="+dmethod+pItem+orgType+extend + "&returnCurrent=" + returnCurrent;
		}
		
		function submitResult(){
			var node = selectspace.window.getTreeNode();
			if (node) {
				parent.setValue(node);
			}
		}
		function doClear(){
			var paraname=document.all.paraName.value;
			var paraid=document.all.paraID.value;
			var win=window.parent;
			if (win.document.all(paraname)==null) {
				     alert("数据项名称未找到或不正确，请检查程序！");
			} else {
				win.document.all(paraid).value="";
				win.document.all(paraname).value="";
				window.parent.hidePopWin(false);
			}
		}
		function doAutoHeight() {
			var height = document.body.clientHeight;
		    document.all.selectspace.style.height = height-60;
		}
	</Script>
</HEAD>

<BODY class="easyui-layout" border="0" fit="true" onload="RefreshWin();" style="margin:5">
	<div region="center" border="0" style="overflow:hidden;text-align: right;">
		<iframe id="selectspace" name="selectspace" src="" frameborder=0 style="width:100%;height:100%;overflow:hidden;"></iframe>
	</div>
	<div region="south" border="0" style="overflow:hidden;text-align: right;heigth: 50px;margin-bottom:10px;margin-top:5px">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="submitResult()">确定</a>&nbsp;&nbsp;
		<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="parent.closeWin('commonPage')">关闭</a>&nbsp;&nbsp;
		<!--数据存储位置-->
		<input type="hidden" id="paraName">
		<input type="hidden" id="paraID">
		<input type="hidden" id="funname">
	</div>
</BODY>
</HTML>