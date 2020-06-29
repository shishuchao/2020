<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<HTML>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=5">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>编辑节点</TITLE>
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
<script language=jscript src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
<script language=jscript src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webflow.js"></script>
<%
String var = request.getParameter("varibles");
if(var==null||"".equals(var)){
	var="";
}
%>
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
         isWriteFun(FlowXML,nodeId); //含有路径的禁止编辑000
         notEditEndNode(FlowXML,nodeId);//如果是结束节点不让编辑节点名称111
         
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

function isWriteFun(FlowXML,nodeId){
//判断节点名称是否能够修改000
    if(FlowXML.value!=''){
	var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
	xmlDoc.async = false;
	xmlDoc.loadXML(FlowXML.value);
	var xmlRoot = xmlDoc.documentElement;
	
	    var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
        var Trans = xmlRoot.getElementsByTagName("Trans").item(0);
         
		var nodeName="";
		for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
            Node = Nodes.childNodes.item(i);
            id = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            if(id==nodeId) {
				nodeName = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
            }
        }
            for ( var i = 0;i < Trans.childNodes.length;i++ ){
                Tran = Trans.childNodes.item(i);
                id = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
                var text = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
                var nodeArray = text.split(" → ");

                if(nodeArray[0]==nodeName||nodeArray[1]==nodeName){
                    //禁用节点名称可编辑的属性
                    //alert("nodeid:"+nodeName);
                    //alert(nodeArray[0]);
                    //alert(nodeArray[1]);
                    //alert(document.getElementsByName("NodeText")[0].getAttribute("readonly"));
                    var NodeText_value = document.getElementsByName("NodeText")[0].value;
                    document.getElementById("aaa").innerHTML='<INPUT TYPE="text" NAME="NodeText" value="'+NodeText_value+'" >';
                    
  
                }
        }

    }
}
function notEditEndNode(FlowXML,nodeId){
if(nodeId == "end"){
var NodeText_value = document.getElementsByName("NodeText")[0].value;
document.getElementById("aaa").innerHTML='<INPUT TYPE="text" NAME="NodeText" value="'+NodeText_value+'" readonly="readonly">';
}
}



//return   if   s1   ends   with   s2   
function   endWith(s1,s2)   
  {   
      if(s1.length<s2.length){   
        return   false;   
        }
      if(s1==s2){   
        return   true;
        }   
      if(s1.substring(s1.length-s2.length)==s2){   
          return   true;   
          }
      return   false;   
  }
//校验路径中是否含有回退二字
function judge_back(){
var tran_text = document.all.NodeText.value;
var CheckStr ="<%=ais.bpm.util.BpmConstants.RETURN_STEP%>";
if(!endWith(tran_text,CheckStr)) {
return true;
}else{
alert("节点命名错误！不应含有’(回退)‘,请重命名。");
return false;
}
return true;
}

//校验节点名称是否重复(节点名称的唯一性)
function checkNodeNameIsSame(FlowXML){
var node_text_current = document.all.NodeText.value;//当前节点的名称
var node_id_current = document.all.NodeId.value;//当前节点的id
 if(FlowXML.value!=''){
		var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
		xmlDoc.async = false;
		xmlDoc.loadXML(FlowXML.value);
		var xmlRoot = xmlDoc.documentElement;
        var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);

        for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
            var Node = Nodes.childNodes.item(i);
            var node_name = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
			var node_id = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            if(node_text_current==node_name && node_id!=node_id_current) {
				alert("请重新命名，节点名称不允许重复！");
				return false; 
            }
        }

        }
return true;
}

function okOnClick(){
   var judgess  = judge_back();
   if(judgess){
   var opener = window.dialogArguments;
   var nodeId = "${nodeid}";

   try{
     var FlowXML = opener.document.all.FlowXML;
     //判断名称是否重复
     if(!checkNodeNameIsSame(FlowXML)){
     return false;
     }
     //增加如果什么都没选的提示信息
	var FieldNameVar = document.getElementsByName("FieldName");
  var FieldReadVar = document.getElementsByName("FieldRead");
  var FieldWriteVar = document.getElementsByName("FieldWrite");
  var FieldRequiredVar = document.getElementsByName("FieldRequired");
  var flag=true;
  for(var i=0;i<FieldNameVar.length;i++){
  	if(FieldReadVar[i].checked || FieldWriteVar[i].checked ||FieldRequiredVar[i].checked){
  		flag=false;
  		break;
  	}
  }   
  if(flag){
  	if(!confirm("您没有设置任何的表单属性，是否确认这样设置？")){
  		return false;
  	}
  }
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
    var vNum=Math.ceil(Math.random()*(100-1)+1); //生成1-100之间的随机数
	document.all.NodeText.value = "新节点"+vNum;
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
if(nodeId == "end" || nodeId == "begin"){
    
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



//读，写，必填三个属性全部选中和取消---zhouting
function CheckAll(chkAll,chkAll_var,cheOrclear){  //三个参数，chkAll是需要选中的checkbox ，chkAll_var是全选和不全选的控制  ，cheOrclear是1 负责选中
var listSize = '<s:property value="bpmTableFieldList.size"/>';//获得列表的长度-listSize
var ische = cheOrclear;
//alert(chkAll_var.checked);
			for (var i=0;i<document.getElementsByName(chkAll).length;i++)  //用来历遍form中所有控件,
			{
				var e = document.getElementsByName(chkAll)[i];
				if (e.Type="checkbox")					//当是checkbox时才执行下面
				{				
			if(ische==1 && chkAll_var.checked)
					{
						if(!e.checked)						//当是checkbox未被选取时才执行下面
						{
							e.checked=true;					
						}
					}else{	
						if(!e.checked)						//当是checkbox未被选取时才执行下面
						{
							e.checked=true;		
						}else{
							e.checked=false;
						}
								
					}
				
		
				}
			}

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
            <TD>
            <%if("set".equals(var)){ %>
            	<INPUT TYPE="text" NAME="NodeId" value="" disabled="disabled">
            <%}else{ %>
            	<INPUT TYPE="text" NAME="NodeId" value="">
            <%} %>
            </TD>
        </TR>
        <TR>
            <TD>节点名称</TD>
            <TD id="aaa">
            <%if("set".equals(var)){ %>
            	<INPUT TYPE="text" NAME="NodeText" value="" disabled="disabled">
            <%}else{ %>
            	 <INPUT TYPE="text" NAME="NodeText" value="" >
            <%} %>
            </TD>
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
            <TD>
            	<%if("set".equals(var)){ %>
            		<INPUT TYPE="text" NAME="Width" value="100" disabled="disabled">
            	<%}else{ %>
            		<INPUT TYPE="text" NAME="Width" value="100">
            	<%} %>
            </TD>
        </TR>
        <TR>
            <TD>图形高度</TD>
            <TD>
            <%if("set".equals(var)){ %>
            	<INPUT TYPE="text" NAME="Height" value="50" disabled="disabled">
            <%}else{ %>
            	<INPUT TYPE="text" NAME="Height" value="50">
            <%} %>
            </TD>
        </TR>
        <TR>
            <TD>图形X坐标</TD>
            <TD>
            <%if("set".equals(var)){ %>
            	<INPUT TYPE="text" NAME="X" value="100" disabled="disabled">
             <%}else{ %>
            	<INPUT TYPE="text" NAME="X" value="100">
            <%} %>
            </TD>
        </TR>
        <TR>
            <TD>图形Y坐标</TD>
            <TD>
            <%if("set".equals(var)){ %>
            	<INPUT TYPE="text" NAME="Y" value="100" disabled="disabled">
             <%}else{ %>
             	<INPUT TYPE="text" NAME="Y" value="100">
             <%} %>
            </TD>
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
            <TD>
            <%if("set".equals(var)){ %>
            <INPUT TYPE="text" NAME="TextWeight" value=""  disabled="disabled">
             <%}else{ %>
             	 <INPUT TYPE="text" NAME="TextWeight" value="">
             <%} %>
            </TD>
        </TR>
        <TR>
            <TD>边框粗细</TD>
            <TD>
            <%if("set".equals(var)){ %>
            	<INPUT TYPE="text" NAME="StrokeWeight" value="" disabled="disabled">
            <%}else{ %>
             	 <INPUT TYPE="text" NAME="StrokeWeight" value="">
             <%} %>
            </TD>
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
            	<%if("set".equals(var)){ %>
                <INPUT TYPE="radio" NAME="TaskType" value="first" disable>一般任务&nbsp;
                <INPUT TYPE="radio" NAME="TaskType" value="last" disable>会签任务&nbsp;
                <%}else{ %>
             	 <INPUT TYPE="radio" NAME="TaskType" value="first">一般任务&nbsp;
                <INPUT TYPE="radio" NAME="TaskType" value="last">会签任务&nbsp;
             <%} %>
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
                查看	<input name="FieldRead1" type="checkbox" id="FieldRead1"
										onclick="CheckAll('FieldRead',this,1)" value="checkbox" title="全部选中|全部取消">
            </TD>
             <TD>
                写入<input name="FieldWrite1" type="checkbox" id="FieldWrite1"
										onclick="CheckAll('FieldWrite',this,1)" value="checkbox" title="全部选中|全部取消">
            </TD>
            <TD>
                必填<input name="FieldReequired1" type="checkbox" id="FieldReequired1"
										onclick="CheckAll('FieldRequired',this,1)" value="checkbox" title="全部选中|全部取消">
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
                <INPUT TYPE="checkbox" NAME="FieldRead" value="">
            </TD>
            <TD>
                <INPUT TYPE="checkbox" NAME="FieldWrite" value="">
            </TD>
             <TD>
                <INPUT TYPE="checkbox" NAME="FieldRequired" value="">
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
        <td><input type=button id="btnOk" value="确 定" onclick="jscript: okOnClick();">&nbsp;&nbsp;&nbsp;</td>
        <td><input type=button id="btnCancel" value="取 消" onclick="jscript: cancelOnClick();">&nbsp;&nbsp;&nbsp;</td>
<%--        <td><input type=button id="btnApply" value="应 用" onclick="jscript: applyOnClick();">&nbsp;&nbsp;&nbsp;</td>--%>
    </tr>
</table>

</BODY>
</HTML>
