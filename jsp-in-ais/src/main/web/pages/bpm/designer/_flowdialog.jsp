<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<HTML>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<TITLE>流程属性</TITLE>
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
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>

<script language="javascript">
function iniWindow(){
   var opener = window.dialogArguments;
   var flowId = "${flowid}";
   try{
     var FlowXML = opener.document.all.FlowXML;
     if(FlowXML.value!=''){
         atEditFlow(FlowXML,flowId);
     }else{
         alert('打开流程属性对话框时出错！');
         window.close();
     }
   }catch(e){
     alert('打开流程属性对话框时出错！');
     window.close();
   }
}

function okOnClick(){
   var opener = window.dialogArguments;
   var flowId = "${flowid}";

   try{
     var FlowXML = opener.document.all.FlowXML;

     xml = getFlowXML(FlowXML,flowId);
     if(xml!='') {
       FlowXML.value = xml;
       window.close();
     }

   }catch(e){
     alert('关闭流程属性对话框时出错！');
     window.close();
   }
}
function cancelOnClick(){
   window.close();
}
function applyOnClick(){
   var opener = window.dialogArguments;
   var flowId = "${flowid}";

   try{
     var FlowXML = opener.document.all.FlowXML;

     xml = getFlowXML(FlowXML,flowId);
     if(xml!='') {
       FlowXML.value = xml;
     }
   }catch(e){
     alert('应用流程属性时出错！');
     window.close();
   }
}

function atEditFlow(FlowXML,flowId){
  var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
  xmlDoc.async = false;
  xmlDoc.loadXML(FlowXML.value);
  var xmlRoot = xmlDoc.documentElement;
  var Flow = xmlRoot.getElementsByTagName("FlowConfig").item(0);

  document.all.FlowId.value = flowId;
  document.all.FlowId.disabled = true;
  document.all.FlowText.value = Flow.getElementsByTagName("BaseProperties").item(0).getAttribute("flowText");
  document.all.FlowText.disabled = true;
  document.all.FlowText.select();
}

function getFlowXML(FlowXML,id){
  flowId = document.all.FlowId.value;
  flowText = document.all.FlowText.value;

  var xml = "";
  xml+= '<WebFlow><FlowConfig>'
  xml+= '<BaseProperties flowId="'+flowId+'" flowText="'+flowText+'" />';
  xml+= "<VMLProperties" +
            " nodeTextColor=\"black\"" +
            " nodeStrokeColor=\"black\"" +
            " nodeShadowColor=\"#b3b3b3\"" +
            " nodeColor1=\"silver\"" +
            " nodeColor2=\"white\"" +
            " nodeFocusedStrokeColor=\"yellow\"" +
            " sNodeTextColor=\"black\"" +
            " sNodeStrokeColor=\"black\"" +
            " isNodeShadow=\"T\"" +
            " isNode3D=\"false\"" +
            " node3DDepth=\"20\"" +
            " tranStrokeColor=\"black\"" +
            " tranTextColor=\"\"" +
            " tranFocusedStrokeColor=\"yellow\"" +
            " />" +
          " <FlowProperties/>" +
        " </FlowConfig>";

  var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
  xmlDoc.async = false;
  xmlDoc.loadXML(FlowXML.value);

  var xmlRoot = xmlDoc.documentElement;

  var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
  var Trans = xmlRoot.getElementsByTagName("Trans").item(0);
  xml+= Nodes.xml + Trans.xml;

  xml+= '</WebFlow>';

  return xml;
}
</script>
</HEAD>

<BODY onload='iniWindow()' onunload=''>
<INPUT TYPE="hidden" name=TempXML>

<table border="0" cellpadding="0" cellspacing="0" height=385px width="380px">
<thead>
  <tr id="WebTab">
    <td class="selectedtab" id="tab1" onmouseover='hoverTab("tab1")' onclick="switchTab('tab1','contents1');" nowrap>基本属性</td>
    <td class="tabspacer" width="90%">&nbsp;</td>
  </tr>
</thead>
<tbody>
  <tr>
    <td id="contentscell" colspan="2">
    
<!-- Tab Page 1 Content Begin -->
<div class="selectedcontents" id="contents1">
<TABLE border=0 width="100%" height="100%">
<TR valign=top>
    <TD></TD>
    <TD width="100%" valign=top>
    <Fieldset style="border: 1px solid #C0C0C0;">
    <LEGEND align=left style="font-size:9pt;">&nbsp;基本属性&nbsp;</LEGEND>
    <TABLE border=0 width="100%" height="100%" style="font-size:9pt;">
    <TR valign=top style="display:none">
        <TD width=5></TD>
        <TD><span id=tabpage1_2>流程编号</span>&nbsp;&nbsp;<INPUT TYPE="text" name="FlowId" value="newflow" class=txtput></TD>
        <TD></TD>
    </TR>
    <TR valign=top>
        <TD></TD>
        <TD><span id=tabpage1_3>流程名称</span>&nbsp;&nbsp;<INPUT TYPE="text" NAME="FlowText" value="" class=txtput></TD>
        <TD></TD>
    </TR>
    </TABLE>
    </Fieldset>
    </TD>
    <TD></TD>
</TR>

</TABLE>
</div>
<!-- Tab Page 1 Content End -->

    </td>
  </tr>
</tbody>
</table>

<table cellspacing="1" cellpadding="0" border="0" style="position: absolute; top: 400px; left: 0px;">
    <tr>
        <td width="100%"></td>
        <td><input type=button id="btnOk" class=btn value="确 定" onclick="jscript: okOnClick();">&nbsp;&nbsp;&nbsp;</td>
        <td><input type=button id="btnCancel" class=btn value="取 消" onclick="jscript: cancelOnClick();">&nbsp;&nbsp;&nbsp;</td>
        <td><input type=button id="btnApply" class=btn value="应 用" onclick="jscript: applyOnClick();">&nbsp;&nbsp;&nbsp;</td>
    </tr>
</table>
</BODY>
</HTML>
