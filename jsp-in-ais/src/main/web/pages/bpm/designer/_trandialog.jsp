<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<TITLE>编辑路径</TITLE>
		<style>
body {
    font-size: 9pt;
    background-color: buttonface;
    scroll: no;
    margin: 7px, 0px, 0px, 7px;
    border: none;
    overflow: hidden;

}
td {
    font-size: 9pt;
}
</style>
		<script language="javascript">
var BASE_PATH = "${contextPath}/bpm/definition/";
var BASE_RESOURCE_PATH = "${contextPath}/pages/bpm/designer/";
</script>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/pages/bpm/designer/inc/webTab/webtab.css">
		<script language=jscript
			src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
		<script language=jscript
			src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
		<script language="jscript"
			src="${contextPath}/pages/bpm/designer/inc/webflow.js"></script>

		<SCRIPT LANGUAGE="JavaScript">
function iniWindow(){
   var opener = window.dialogArguments;
   var tranId ="${tranid}";
   try{
     var FlowXML = opener.document.all.FlowXML;

     if(FlowXML.value!=''){
         iniTranDialog(FlowXML,tranId);
     }else{
         alert('打开路径属性对话框时出错！');
         window.close();
     }
   }catch(e){
     alert('打开路径属性对话框时出错！');
     window.close();
   }
}
function iniTranDialog(FlowXML,tranId){
   var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
   xmlDoc.async = false;
   xmlDoc.loadXML(FlowXML.value);
   var xmlRoot = xmlDoc.documentElement;
   
   var Trans = xmlRoot.getElementsByTagName("Trans").item(0);
   var fromNode = '',toNode = '';
   
   if (tranId == "") {
      tranId = generateElementId(Trans,"t");    
      document.all.TranId.value = tranId;
      document.all.TranId.disabled = true;
      document.all.TranText.value = "新路径";
      document.all.TranText.select();
   }
   for ( var i = 0;i < Trans.childNodes.length;i++ ){
      Tran = Trans.childNodes.item(i);
      id = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
      if(id==tranId){
        fromNode = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("from");
        toNode = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("to");

        //修改路径时先填充参数
        document.all.TranId.value = tranId;
        document.all.TranId.disabled = true;
        document.all.TranText.value = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
        setRadioGroupValue(document.all.LineType,Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("lineType"));

        document.all.StartArrow.value = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("startArrow");
        document.all.EndArrow.value = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("endArrow");
        document.all.StrokeWeight.value = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("strokeWeight");
        if(document.all.TranText.value.indexOf("(回退)")>-1){
        	document.all.rollback.checked=true;
        	document.all.tranStrokeColor.value = 'red';//回退路径
        }else{
            document.all.tranStrokeColor.value = 'black';
        }

        break;
      }
   }

   //生成from，to nodelist
   var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
   var from = document.all.From;
   var to = document.all.To;
   for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
      Node = Nodes.childNodes.item(i);
      id = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
      text = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("text");

      fromSelected = fromNode==id?true:false;
      toSelected = toNode==id?true:false;
      if(id!='end') addSelectOption(from,text,id,fromSelected);
      if(id!='begin') addSelectOption(to,text,id,toSelected);
   }
}

//校验路径名称是否重复(路径的唯一性)
function checkTranNameIsSame(FlowXML){
var tran_text_current = getSelectText(document.all.From) + " → " + getSelectText(document.all.To);//当前路径
if(document.all.rollback.checked){
//选择回退
tran_text_current = getSelectText(document.all.From) + " → " + getSelectText(document.all.To)+"(回退)";
}

var tran_id_current = document.all.TranId.value;//当前路径id
 if(FlowXML.value!=''){
		var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
		xmlDoc.async = false;
		xmlDoc.loadXML(FlowXML.value);
		var xmlRoot = xmlDoc.documentElement;
        var Trans = xmlRoot.getElementsByTagName("Trans").item(0);
         for ( var i = 0;i < Trans.childNodes.length;i++ ){
                var Tran = Trans.childNodes.item(i);
                var tran_name = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
                var tran_id = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
                if(tran_name==tran_text_current &&　tran_id_current!=tran_id){
                alert("请重新选择流程路径，该流程路径已经存在！");
				return false; 
                }
                //节点路径的互斥性判断
                if(document.all.rollback.checked &&　tran_id_current!=tran_id){
                  var tran_text_var = tran_name+"(回退)";
                  if(tran_text_current==tran_text_var){
                   alert("请重新选择流程路径，该流程路径提交和回退不能同时选择！");
				   return false; 
                  }
                 }else if(tran_id_current!=tran_id){
                  var tran_text_var = tran_text_current+"(回退)";
                  if(tran_name==tran_text_var){
                   alert("请重新选择流程路径，该流程路径提交和回退不能同时选择！");
				   return false; 
                  }
                 
                 }

             }

        }
return true;
}
//校验回退节点（选择回退了，开始不能是开始节点，结束不能是结束节点）
function checkReCallNode(FlowXML){
var tran_start = getSelectText(document.all.From);//起始
var tran_end = getSelectText(document.all.To);//结束
if(document.all.rollback.checked && FlowXML.value!=''){
//选择回退了，添加校验
		var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
		xmlDoc.async = false;
		xmlDoc.loadXML(FlowXML.value);
		var xmlRoot = xmlDoc.documentElement;
        var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);

        for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
            var Node = Nodes.childNodes.item(i);
            var node_name = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
			var node_id = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            if(tran_start==node_name && node_id=='begin') {
				alert("错误！流程回退时，起始节点不能是开始节点");
				return false; 
            }
             if(tran_end==node_name && node_id=='end') {
				alert("错误！流程回退时，目的节点不能是结束节点");
				return false; 
            }
        }

}
return true;
}

function okOnClick(){
   var opener = window.dialogArguments;
   var tranId ="${tranid}";

   try{
     var FlowXML = opener.document.all.FlowXML;
     //校验如果是选择回退了，处理节点选择
     if(!checkReCallNode(FlowXML)){
     return false;
     }
     //校验路径是否重复
     if(!checkTranNameIsSame(FlowXML)){
     return false;
     }
     xml = getTranXML(FlowXML,tranId);
     if(xml!='') {
       FlowXML.value = xml;
       window.close();
     }
   }catch(e){
     alert('关闭路径属性对话框时出错！');
     window.close();
   }
}
function cancelOnClick(){
   window.close();
}
function applyOnClick(){
   var opener = window.dialogArguments;
   var tranId ="${tranid}";

   try{
     var FlowXML = opener.document.all.FlowXML;

     xml = getTranXML(FlowXML,tranId);
     if(xml!='') {
       FlowXML.value = xml;
       btnApply.disabled=true;
     }
   }catch(e){
     alert('应用路径属性时出错！');
     window.close();
   }
}

function getTranXML(FlowXML,tranId){
  id = document.all.TranId.value;
  lineType = getRadioGroupValue(document.all.LineType);
  if(id=='') {alert('请先填写路径编号！');return '';}

  from = getSelectValue(document.all.From);
  to = getSelectValue(document.all.To);
  if(from=='' || to=='') {alert('请先选择起始节点和目的节点！');return '';}

  //text = document.all.TranText.value;
  text = getSelectText(document.all.From) + " → " + getSelectText(document.all.To);
  //if(text=='') {alert('请先填写路径名称！');return '';}
  var strokecolor = "black";
  if(document.all.rollback.checked){
  	text = text+"(回退)";
  	strokecolor = "red"; //回退路径
  }else{
  	strokecolor = "black";
  }

  startArrow = document.all.StartArrow.value;
  endArrow = document.all.EndArrow.value;
  strokeWeight = document.all.StrokeWeight.value;

  fromText = getSelectText(document.all.From);
  toText = getSelectText(document.all.To);

  var xml = "";

  //生成节点xml
  xml+= '<Tran><BaseProperties id="'+id+'" text="'+text+'" lineType="'+lineType+'" from="'+from+'" to="'+to+'" fromText="'+fromText+'" toText="'+toText+'"/>';
  xml+= '<VMLProperties strokecolor="'+strokecolor+'"  startArrow="'+startArrow+'" endArrow="'+endArrow+'" strokeWeight="'+strokeWeight+'" zIndex="" />';
  xml+= '</Tran>';

  var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
  xmlDoc.async = false;
//  alert(FlowXML.value);
  xmlDoc.loadXML(FlowXML.value);
  var xmlRoot = xmlDoc.documentElement;
  var Trans = xmlRoot.getElementsByTagName("Trans").item(0);

  //添加：查找编号冲突的Id
  //修改：查找原来的Id
  for ( var i = 0;i < Trans.childNodes.length;i++ ) {
      Tran = Trans.childNodes.item(i);
      lId = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
      if(lId==id && tranId=='') {
        alert('新路径编号已存在！请重新输入！');return '';
      }
      if(lId==tranId && tranId!='') {
        Trans.removeChild(Tran);
        break;
      }
  }

  var xmlDoc2 = new ActiveXObject('MSXML2.DOMDocument');
  xmlDoc2.async = false;
  xmlDoc2.loadXML(xml);
  Trans.appendChild(xmlDoc2.documentElement);

  return xmlRoot.xml;
}

//根据checkBox判断线条路径的颜色
function checkBack(rollback){
if(rollback.checked==true){
document.getElementsByName("tranStrokeColor")[0].value = "red";
}else{
document.getElementsByName("tranStrokeColor")[0].value = "black";
}
}
</SCRIPT>

	</HEAD>

	<BODY onload='iniWindow()' onunload=''>
		<table border="0" cellpadding="0" cellspacing="0" height="385px"
			width="380px">
			<thead>
				<tr id="WebTab">
					<td class="selectedtab" id="tab1" onmouseover='hoverTab("tab1")'
						onclick="switchTab('tab1','contents1');">
						基本属性
					</td>
					<td class="tab" id="tab2" onmouseover='hoverTab("tab2")'
						onclick="switchTab('tab2','contents2');">
						图表属性
					</td>
					<td class="tabspacer" width="230px">
						&nbsp;
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="contentscell" colspan="5">
						<!-- Tab Page 1 Content Begin -->
						<div class="selectedcontents" id="contents1">
							<TABLE border=0 width="100%" height="100%">
								<TR valign=top>
									<TD></TD>
									<TD width="100%" valign=top>
										<Fieldset style="border: 1px solid #C0C0C0;">
											<LEGEND align=left style="font-size:9pt;">
												&nbsp;基本属性&nbsp;
											</LEGEND>
											<TABLE border=0 width="100%" height="100%"
												style="font-size:9pt;">
												<TR valign=top style="display:none">
													<TD width=5></TD>
													<TD>
														路径编号&nbsp;&nbsp;
														<INPUT TYPE="text" NAME="TranId" value="newtran">
													</TD>
													<TD></TD>
												</TR>
												<TR valign=top style="display:none">
													<TD></TD>
													<TD>
														路径名称&nbsp;&nbsp;
														<INPUT TYPE="text" NAME="TranText" value="">
													</TD>
													<TD></TD>
												</TR>
												<TR valign=top>
													<TD></TD>
													<TD>
<%--														是否是回退&nbsp;&nbsp;  style="display: none"--%>
                                                               是否是回退&nbsp;&nbsp;
														<INPUT TYPE="checkbox" NAME="rollback" value="yes"   onclick="javascript:checkBack(this)">
													</TD>													
													<TD style="display:none">
														线段类型&nbsp;&nbsp;
														<INPUT TYPE="radio" NAME="LineType" value="PolyLine"
															id="lt_1" checked>
														<label for="lt_1">
															折线
														</label>
<%--														&nbsp;--%>
<%--														<INPUT TYPE="radio" NAME="LineType" value="Line" id="lt_2">--%>
<%--														<label for="lt_2">--%>
<%--															直线--%>
<%--														</label>--%>
													</TD>
													<TD></TD>
												</TR>
												<TR valign=top>
													<TD width=5></TD>
													<TD>
														起始节点&nbsp;&nbsp;
														<SELECT NAME="From"></SELECT>
													</TD>
													<TD></TD>
												</TR>
												<TR valign=top>
													<TD></TD>
													<TD>
														目的节点&nbsp;&nbsp;
														<SELECT NAME="To"></SELECT>
													</TD>
													<TD></TD>
												</TR>
												<TR height="3">
													<TD></TD>
													<TD></TD>
													<TD></TD>
												</TR>
											</TABLE>
										</Fieldset>
									</TD>
									<TD>
										&nbsp;
									</TD>
								</TR>

								<TR height="100%">
									<TD></TD>
									<TD></TD>
									<TD></TD>
								</TR>
							</TABLE>
						</div>
						<!-- Tab Page 1 Content End -->

						<!-- Tab Page 2 Content Begin -->
						<div class="contents" id="contents2">
							<TABLE border=0 width="100%" height="100%">
								<TR valign=top>
									<TD></TD>
									<TD width="100%" valign=top>
										<Fieldset style="border: 1px solid #C0C0C0;">
											<LEGEND align=left style="font-size:9pt;">
												&nbsp;路径样式&nbsp;
											</LEGEND>
											<TABLE border=0 width="100%" height="100%"
												style="font-size:9pt;">
												<TR valign=top>
													<TD width=5></TD>
													<TD>
														开始箭头&nbsp;&nbsp;
														<INPUT TYPE="text" NAME="StartArrow" value="">
													</TD>
													<TD></TD>
												</TR>
												<TR valign=top>
													<TD width=5></TD>
													<TD>
														结束箭头&nbsp;&nbsp;
														<INPUT TYPE="text" NAME="EndArrow" value="Classic">
													</TD>
													<TD></TD>
												</TR>
												<TR valign=top>
													<TD></TD>
													<TD>
														线条粗细&nbsp;&nbsp;
														<INPUT TYPE="text" NAME="StrokeWeight" value="">
													</TD>
													<TD></TD>
												</TR>
																								<TR valign=top>
													<TD></TD>
													<TD>
<%--														线条颜色&nbsp;&nbsp;  style="display: none"--%>
														线条颜色&nbsp;&nbsp;
														<INPUT TYPE="text" NAME="tranStrokeColor" value="black"  readonly="readonly">
													</TD>
													<TD></TD>
												</TR>
												<TR height="3">
													<TD></TD>
													<TD></TD>
													<TD></TD>
												</TR>
											</TABLE>
										</Fieldset>
									</TD>
									<TD>
										&nbsp;
									</TD>
								</TR>

								<TR height="100%">
									<TD></TD>
									<TD></TD>
									<TD></TD>
								</TR>
							</TABLE>
						</div>
						<!-- Tab Page 2 Content End -->

					</td>
				</tr>
			</tbody>
		</table>

		<table cellspacing="1" cellpadding="0" border="0"
			style="position: absolute; top: 400px; left: 0px;">
			<tr>
				<td width="100%"></td>
				<td>
					<input type=button id="btnOk" class=btn value="确 定"
						onclick="jscript: okOnClick();">
					&nbsp;&nbsp;&nbsp;
				</td>
				<td>
					<input type=button id="btnCancel" class=btn value="取 消"
						onclick="jscript: cancelOnClick();">
					&nbsp;&nbsp;&nbsp;
				</td>
<%--				<td>--%>
<%--					<input type=button id="btnApply" class=btn value="应 用"--%>
<%--						onclick="jscript: applyOnClick();">--%>
<%--					&nbsp;&nbsp;&nbsp;--%>
<%--				</td>--%>
			</tr>
		</table>
	</BODY>
</HTML>
