<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<HTML>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<TITLE>查看节点</TITLE>
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
		
		<link rel="stylesheet" type="text/css" href="${contextPath}/pages/bpm/designer/inc/webTab/webtab.css">
		<%-- <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" /> --%>
		<%-- <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script> --%>
		<script language=jscript src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
		<script language=jscript src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webflow.js"></script>

		<SCRIPT LANGUAGE="JavaScript">
			function iniWindow(){
				var opener = window.dialogArguments;
				var nodeId = "${nodeid}";
				//alert(nodeId);
				var rumX =  Math.random()*(200-50);//生成0-150之间的随机数
				var rumY = Math.random()*(200-50)+50;//生成一个50-200之间的随机数
				document.getElementsByName("X")[0].value = rumX;
				document.getElementsByName("Y")[0].value = rumY;
				try{
			    	var FlowXML = opener.document.all.FlowXML;
			    	if(nodeId==''){
			    		atNewNode(FlowXML);
			    	}else{
				      	if(FlowXML.value!=''){
				        	atEditNode(FlowXML,nodeId);
				      	}else{
				        	alert('打开流程属性对话框时出错！');
				        	window.close();
				      	}
			    	}
			  	}catch(e){
			    	alert('打开节点属性对话框时出错！');
			   		window.close();
			  	}
			}
			
			function okOnClick(){
				var opener = window.dialogArguments;
			  	var nodeId = "${nodeid}";
			  	try{
			    	var FlowXML = opener.document.all.FlowXML;
			    	xml = getNodeXML(FlowXML,nodeId);
			    	if(xml!='') {
			      		FlowXML.value = xml;
			      		window.close();
			    	}			
			  	}catch(e){
			    	alert('关闭节点属性对话框时出错！');
			    	window.close();
			  	}
			}
			function cancelOnClick(){
			  	window.close();
			}
			function applyOnClick(){		
			  	var opener = window.dialogArguments;
			  	var nodeId = "${nodeid}";
			  	try{
			   		var FlowXML = opener.document.all.FlowXML;			
			    	xml = getNodeXML(FlowXML,nodeId);
			    	if(xml!='') {
			      		FlowXML.value = xml;
			      		btnApply.disabled=true;
			    	}
			  	}catch(e){
			    	alert('应用节点属性时出错！');
			    	window.close();
			  	}
			}
			
			function atNewNode(FlowXML){
				var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
				xmlDoc.async = false;
				xmlDoc.loadXML(FlowXML.value);
				var xmlRoot = xmlDoc.documentElement;
				
				var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
				var nodeid = generateElementId(Nodes,"n");
				document.all.NodeId.value = nodeid;
				document.all.NodeId.disabled = true;
				document.all.NodeText.value = "新节点";
				document.all.NodeText.select();
			}
			
			function atEditNode(FlowXML,nodeId){
				var wf = new WebFlow();
				wf.initialize(FlowXML.value);
				var theNode = wf.getNodeById(nodeId);
			
			    document.all.NodeId.value = theNode.id;
			    document.all.NodeText.value = theNode.text;
			    setRadioGroupValue(document.all.NodeType,theNode.nodeType);
			    document.all.NodeId.disabled=true;
			    
			    
			    //根据结束节点判断读写属性可否选中
			if(nodeId == "end"){
				document.all.FieldWrite1.disabled = true;//不能选择读写属性
				document.all.FieldReequired1.disabled = true;//不能选择读写属性
				document.all.FieldRead1.disabled = true;//不能选择读写属性			   
			 	<s:if test="bpmTableFieldList.size!=0">
					var listSize = '<s:property value="bpmTableFieldList.size"/>';//获得列表的长度-listSize
				 	for (var i=0;i<listSize;i++)  //用来历遍form中所有控件,
					{
						document.all.FieldRead[i].disabled = true;//不能选择读写属性
						document.all.FieldWrite[i].disabled = true;//不能选择读写属性
						document.all.FieldRequired[i].disabled = true;//不能选择读写属性		
					} 
				</s:if>    
			}		        
			    document.all.Width.value = theNode.width;
			    document.all.Height.value = theNode.height;
			    document.all.X.value = theNode.x;
			    document.all.Y.value = theNode.y;
			    document.all.TextWeight.value = theNode.textWeight;
			    document.all.StrokeWeight.value = theNode.strokeWeight;			    
			    var variables = theNode.varibles;
			    for(var i=0;i<variables.length;i++){
			    	var va = variables[i];
			    		for(var j=0;j<FieldName.length;j++){
			    	  		if(FieldName[j].value==va.name){
			    	  			if(va.read)
			    	  				FieldRead[j].checked = true;
			    	  			if(va.write)
			    	  				FieldWrite[j].checked = true;
			    	  			if(va.required)
			    	  				FieldRequired[j].checked = true;    	  			    	  			
			    	  		}
			  			}
			    	}			    
				}	
			function getNodeXML(FlowXML,nodeId){
				id = document.all.NodeId.value;
			  	text = document.all.NodeText.value;
			  	nodeType = getRadioGroupValue(document.all.NodeType);
			  	if(id=='') {alert('请先填写节点编号！');return '';}
			  	if(text=='') {alert('请先填写节点名称！');return '';}
			
			  	width = document.all.Width.value;
			 	height = document.all.Height.value;
			 	x = document.all.X.value;
			  	y = document.all.Y.value;
			  	textWeight = document.all.TextWeight.value;
			  	strokeWeight = document.all.StrokeWeight.value;			  		  		
			  	var xml = "";
			 	 //生成节点xml
			 	xml+= '<Node><BaseProperties id="'+id+'" text="'+text+'" nodeType="'+nodeType+'" />';
			 	xml+= '<VMLProperties width="'+width+'" height="'+height+'" x="'+x+'" y="'+y+'" textWeight="'+textWeight+'" strokeWeight="'+strokeWeight+'" zIndex="" />';
			 	xml+= '<controller>';
			 	<s:if test="bpmTableFieldList.size!=0">
			 		var FieldNameVar = document.getElementsByName("FieldName");
			  		var FieldReadVar = document.getElementsByName("FieldRead");
			  		var FieldWriteVar = document.getElementsByName("FieldWrite");
			  		var FieldRequiredVar = document.getElementsByName("FieldRequired");  
			  
			  		for(var i=0;i<FieldNameVar.length;i++){
			  			var access = "";
			  			if(FieldReadVar[i].checked)
			  				access += ",read";
			   			if(FieldWriteVar[i].checked)
			  				access += ",write"; 	
			  			if(FieldRequiredVar[i].checked)
			  				access += ",required";
			  			if(access.length>1)access=access.substring(1,access.length);
			  				xml+= '<variable name="'+FieldNameVar[i].value+'" access="'+access+'"/>';
			  		}
			  	</s:if>
			  	xml+= '</controller>';
			  	xml+= '</Node>';		
			  	var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
			  	xmlDoc.async = false;
			 	xmlDoc.loadXML(FlowXML.value);
			  	var xmlRoot = xmlDoc.documentElement;
			  	var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
			
			  	//添加：查找编号冲突的Id
			  	//修改：查找原来的Id
			  	for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
			      	Node = Nodes.childNodes.item(i);
			      	nId = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
			      	if(nId==id && nodeId=='') {
			        	alert('新节点编号已存在！请重新输入！');return '';
			      	}
			      	if(nId==nodeId && nodeId!='') {
			       		Nodes.removeChild(Node);break;
			      	}
			  	}
			  	var xmlDoc2 = new ActiveXObject('MSXML2.DOMDocument');
			  	xmlDoc2.async = false;
			  	xmlDoc2.loadXML(xml);
			  	var xmlRoot2 = xmlDoc2.documentElement;
			  	Nodes.appendChild(xmlRoot2);
			  	return xmlRoot.xml;
			}

		</SCRIPT>

	</HEAD>

	<BODY onload='iniWindow()' onunload=''>
		<table border="0" cellpadding="0" cellspacing="0" height=385px width="380px">
			<thead>
			  <tr id="WebTab">
			    <td class="selectedtab" id="tab1" onmouseover='hoverTab("tab1")' onclick="switchTab('tab1','contents1');">基本属性</td>
			    <td class="tab" id="tab2" onmouseover='hoverTab("tab2")' onclick="switchTab('tab2','contents2');">图表属性</td>
			    <td style="display: none;"  class="tab" id="tab3" onmouseover='hoverTab("tab3")' onclick="switchTab('tab3','contents3');">任务属性</td>
			    <td class="tab" id="tab4" onmouseover='hoverTab("tab4")' onclick="switchTab('tab4','contents4');">表单属性</td>
			    <td class="tabspacer" width="230px">&nbsp;</td>
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
									    <Fieldset style="border:1px solid #C0C0C0; padding:0 0 0 10">
									        <LEGEND align=left style="font-size:9pt;">&nbsp;基本属性&nbsp;</LEGEND>
									        <TABLE border=0 width="100%" height="100%" style="font-size:9pt;">
									        <COL width="50px" align="right">
									        <TR style="display:none">
									            <TD>节点名称</TD>
									            <TD><INPUT TYPE="text" NAME="NodeId" value="" disabled="disabled"></TD>
									        </TR>
									        <TR>
									            <TD>节点名称</TD>
									            <TD><INPUT TYPE="text" NAME="NodeText" value="" disabled="disabled"></TD>
									        </TR>
									        <TR>
									            <TD>节点类型</TD>
									            <TD>
									                <INPUT TYPE="radio" NAME="NodeType" value="BeginNode" disabled>开始节点&nbsp;
									                <INPUT TYPE="radio" NAME="NodeType" value="EndNode" disabled>结束节点&nbsp;
									                <INPUT TYPE="radio" NAME="NodeType" value="NormalNode" checked disabled>中间节点
									            </TD>
									        </TR>
									        </TABLE>
									    </Fieldset>
			    					</TD>
			    					<TD>&nbsp;</TD>
								</TR>
		
								<TR height="100%">
								    <TD colspan="3"></TD>
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
								    <Fieldset style="border:1px solid #C0C0C0; padding:0 0 0 10">
								        <LEGEND align=left style="font-size:9pt;">&nbsp;坐标与大小&nbsp;</LEGEND>
								        <TABLE border=0 width="100%" height="100%" style="font-size:9pt;">
								        <COL width="60px" align="right">
								        <TR>
								            <TD>图形宽度</TD>
								            <TD><INPUT TYPE="text" NAME="Width" value="100" disabled="disabled"></TD>
								        </TR>
								        <TR>
								            <TD>图形高度</TD>
								            <TD><INPUT TYPE="text" NAME="Height" value="50" disabled="disabled"></TD>
								        </TR>
								        <TR>
								            <TD>图形X坐标</TD>
								            <TD><INPUT TYPE="text" NAME="X" value="100" disabled="disabled"></TD>
								        </TR>
								        <TR>
								            <TD>图形Y坐标</TD>
								            <TD><INPUT TYPE="text" NAME="Y" value="100" disabled="disabled"></TD>
								        </TR>
								        </TABLE>
								    </Fieldset>
								    </TD>
								    <TD>&nbsp;</TD>
								</TR>
		
								<TR valign=top>
								    <TD></TD>
								    <TD width="100%" valign=top>
								    <Fieldset style="border:1px solid #C0C0C0; padding:0 0 0 10">
								        <LEGEND align=left style="font-size:9pt;">&nbsp;节点样式&nbsp;</LEGEND>
								        <TABLE border=0 width="100%" height="100%" style="font-size:9pt;">
								        <COL width="60px" align="right">
								        <TR>
								            <TD>文本大小</TD>
								            <TD><INPUT TYPE="text" NAME="TextWeight" value="" disabled="disabled"></TD>
								        </TR>
								        <TR>
								            <TD>边框粗细</TD>
								            <TD><INPUT TYPE="text" NAME="StrokeWeight" value="" disabled="disabled"></TD>
								        </TR>
								        </TABLE>
								    </Fieldset>
								    </TD>
								    <TD>&nbsp;</TD>
								</TR>
		
								<TR height="100%">
								    <TD></TD><TD></TD><TD></TD>
								</TR>
							</TABLE>
						</div>
		<!-- Tab Page 2 Content End -->
		
		<!-- Tab Page 3 Content Begin -->
						<div class="selectedcontents" id="contents3" style="display: none;">
							<TABLE border=0 width="100%" height="100%">
								<TR valign=top>
								    <TD></TD>
								    <TD width="100%" valign=top>
								    <Fieldset style="border:1px solid #C0C0C0; padding:0 0 0 10">
								        <LEGEND align=left style="font-size:9pt;">&nbsp;任务类别&nbsp;</LEGEND>
								        <TABLE border=0 width="100%" height="100%" style="font-size:9pt;">
								        <TR>
								            <TD>
								                <INPUT TYPE="radio" NAME="TaskType" value="first" disabled>一般任务&nbsp;
								                <INPUT TYPE="radio" NAME="TaskType" value="last" disabled>会签任务&nbsp;
								            </TD>
								        </TR>
								        </TABLE>
								    </Fieldset>
								    </TD>
								    <TD>&nbsp;</TD>
								</TR>
								
								<TR height="100%">
								    <TD colspan="3"></TD>
								</TR>
							</TABLE>
						</div>
		<!-- Tab Page 3 Content End -->
		
		<!-- Tab Page 4 Content Begin -->
						<div class="selectedcontents" id="contents4"  style="PADDING-RIGHT: 10px; 
						              OVERFLOW-Y: auto; PADDING-LEFT: 10px;
						              SCROLLBAR-FACE-COLOR: #ffffff; FONT-SIZE: 11pt; PADDING-BOTTOM: 0px; 
						              SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; OVERFLOW: auto; WIDTH: 383px;  
						              SCROLLBAR-SHADOW-COLOR: #919192; COLOR: blue; 
						              SCROLLBAR-3DLIGHT-COLOR:#ffffff; LINE-HEIGHT: 100%; 
						              SCROLLBAR-ARROW-COLOR: #919192; PADDING-TOP: 0px; 
						              SCROLLBAR-TRACK-COLOR: #ffffff; FONT-FAMILY: 宋体; 
						              SCROLLBAR-DARKSHADOW-COLOR: #ffffff; LETTER-SPACING: 1pt; HEIGHT: 310px;   TEXT-ALIGN: left; background-repeat: no-repeat;">
							<TABLE border=0 width="100%" height="100%">
								<TR valign=top>
								    <TD></TD>
								    <TD width="100%" valign=top>
								    <Fieldset style="border:1px solid #C0C0C0; padding:0 0 0 10">
								        <LEGEND align=left style="font-size:9pt;">&nbsp;表单字段控制&nbsp;</LEGEND>
								        <TABLE border=0 width="100%" height="100%" style="font-size:9pt;">
								        <TR>
								            <TD>
								                名称
								            </TD>
								            <TD>
								              编码  
								            </TD>
								            <TD>
								                查看	<input name="FieldRead1" type="checkbox" id="FieldRead1" disabled="disabled"
																		 value="checkbox" title="全部选中|全部取消">
								            </TD>
								             <TD>
								                写入<input name="FieldWrite1" type="checkbox" id="FieldWrite1" disabled="disabled"
																		 value="checkbox" title="全部选中|全部取消">
								            </TD>
								            <TD>
								                必填<input name="FieldReequired1" type="checkbox" id="FieldReequired1" disabled="disabled"
																		 value="checkbox" title="全部选中|全部取消">
								            </TD> 
								        </TR>
										<s:iterator value="bpmTableFieldList">
								        <TR>
								            <TD>
								                <s:property value="name"/>
								            </TD>
								            <TD>
								                <s:property value="code"/>
								                <INPUT TYPE="hidden" NAME="FieldName" value="<s:property value="code"/>">
								            </TD>
								            <TD>
								                <INPUT TYPE="checkbox" NAME="FieldRead" value="" disabled="disabled">
								            </TD>
								            <TD>
								                <INPUT TYPE="checkbox" NAME="FieldWrite" value="" disabled="disabled">
								            </TD>
								             <TD>
								                <INPUT TYPE="checkbox" NAME="FieldRequired" value="" disabled="disabled">
								            </TD>           
								        </TR>					
										</s:iterator>
								        </TABLE>
								    </Fieldset>
								    </TD>
								    <TD>&nbsp;</TD>
								</TR>
								
								<TR height="100%">
								    <TD colspan="3"></TD>
								</TR>
							</TABLE>
						</div>
		<!-- Tab Page 4 Content End -->
					</td>
		  		</tr>
			</tbody>
		</table>
		
		
		<table cellspacing="1" cellpadding="0" border="0" style="position: absolute; top: 400px; left: 0px;">
		    <tr>
		        <td width="100%"></td>
		        <td><input type=button id="btnCancel" value="关  闭" onclick="jscript: window.close();">&nbsp;&nbsp;&nbsp;</td>
		    </tr>
		</table>
	</BODY>
</HTML>
