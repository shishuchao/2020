function newNode(defId){
    if(document.all.FlowXML.value=='') {
        alert('请先创建新流程！');
        return;
    }
    workFlowDialog(null,'NormalNode',defId);
}

function newTran(defId){
    if(document.all.FlowXML.value=='') {
        alert('请先创建新流程！');
        return;
    }
    workFlowDialog(null,'Tran',defId);
}

function editFlow(defId){
    if(document.all.FlowXML.value=='') {
        alert('请先创建新流程！');
        return;
    }
    var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
    xmlDoc.async = false;
    xmlDoc.loadXML(document.all.FlowXML.value);
    var xmlRoot = xmlDoc.documentElement;
    var Flow = xmlRoot.getElementsByTagName("FlowConfig").item(0);

    workFlowDialog(Flow.getElementsByTagName("BaseProperties").item(0).getAttribute("flowId"),'Flow',defId);
}

function editNode(nodeId,nodeType,defId){
    workFlowDialog(nodeId,nodeType,defId);
}

function editNodeBySetVaribles(nodeId,nodeType,defId){
    workFlowDialogSetVaribles(nodeId,nodeType,defId);
}
function viewNode(nodeId,nodeType,defId){
    workFlowDialogView(nodeId,nodeType,defId);
}

function editTran(tranId,defId){
	workFlowDialog(tranId,'Tran',defId);
}

function delFlow(){
	if(confirm("是否删除流程？")){
	    clearVML();
	    clearXML();
    }
}

function delNode(nodeId){
	if(confirm("是否删除该节点？若删除该节点则与该节点所关联的路径都会删除。")){
	    var FlowXML = document.all.FlowXML;
	    if(FlowXML.value!=''){
	        
			var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
			xmlDoc.async = false;
			xmlDoc.loadXML(FlowXML.value);
			var xmlRoot = xmlDoc.documentElement;
	        
	        var Trans = xmlRoot.getElementsByTagName("Trans").item(0);
	        var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
	        
	        
	         //以下操作是删除当前节点相关联的路径
	         var xmlContent = FlowXML.value; //获得xml的内容
	         var nodeName_current="";
	        for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
	            Node = Nodes.childNodes.item(i);
	            id = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
	            if(id==nodeId) {
					nodeName_current = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("text");//获得当前节点名称
	            }
	        }
	         for ( var i = 0;i < Trans.childNodes.length;i++ ){
	                Tran = Trans.childNodes.item(i);
	                tran_id = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");//获得当前节点关联的路径id
	                var text = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
	                var nodeArray = text.split(" → ");
	                if(nodeArray[0]==nodeName_current){
	                	delTran1(tran_id);//删除关联的路径
	                }
	               if(nodeArray[1]==nodeName_current){
	                	delTran1(tran_id);//删除关联的路径
	                }
	                
	        }
	
	    }    	
	    removeXMLNode(nodeId);
	
	    FOCUSEDOBJID = '';
	    FOCUSEDOBJTYPE = '';
    }
}
function delTran1(tranId){
    removeXMLNode(tranId);
    FOCUSEDOBJID = '';
    FOCUSEDOBJTYPE = '';
}
function delTran(tranId){
	if(confirm("是否删除该路径？")){
    removeXMLNode(tranId);
    FOCUSEDOBJID = '';
    FOCUSEDOBJTYPE = '';
    }
}

var CONST_LAY_LOWEST = '0';
var CONST_LAY_LOWER = '10';
var CONST_LAY_MIDDLE = '20';
var CONST_LAY_TOPPER = '30';
var CONST_LAY_TOPPEST = '40';

var AUTODRAW = true;
var FOCUSEDOBJID = '';
var FOCUSEDOBJTYPE = '';

function Node(){
	//base properties
	this.id="begin";
	this.text="开始";
	this.nodeType="BeginNode";
	
	//vml properties
	this.width="80";
	this.height="50";
	this.x="10";
	this.y="10";
	this.textWeight="";
	this.strokeWeight="";
	this.isFocused="";
	this.zIndex="40";
	
	this.varibles = new Array();
	
	
	//method
	this.loadNode = loadNode;
	this.getNodeXml = getNodeXml;
}

function Variable(){
	this.name="";
	this.read=false;
	this.write=false;
	this.required=false;
}

function loadNode(el){
	this.id = el.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
	this.text = el.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
	this.nodeType = el.getElementsByTagName("BaseProperties").item(0).getAttribute("nodeType");
	
	this.width = el.getElementsByTagName("VMLProperties").item(0).getAttribute("width");
	this.height = el.getElementsByTagName("VMLProperties").item(0).getAttribute("height");
	this.x = el.getElementsByTagName("VMLProperties").item(0).getAttribute("x");
	this.y = el.getElementsByTagName("VMLProperties").item(0).getAttribute("y");
	this.textWeight = el.getElementsByTagName("VMLProperties").item(0).getAttribute("textWeight");
	this.strokeWeight = el.getElementsByTagName("VMLProperties").item(0).getAttribute("strokeWeight");
	
	var controller = el.getElementsByTagName("controller").item(0);
	
	if(controller!=null){
	  	for ( var i = 0;i < controller.childNodes.length;i++ ) {
			elVariable = controller.childNodes.item(i);
			var va = new Variable();
			va.name = elVariable.getAttribute("name");
			var access = elVariable.getAttribute("access");
			if(access.indexOf("read")>-1)
				va.read = true;
			if(access.indexOf("write")>-1)
				va.write = true;
			if(access.indexOf("required")>-1)
				va.required = true;						
			this.varibles[i] = va;
		}
    }
}

function getNodeXml(){
	var xml = "";
	//生成节点xml
	xml+= '<Node><BaseProperties id="'+this.id+'" text="'+this.text+'" nodeType="'+this.nodeType+'" />';
	xml+= '<VMLProperties width="'+this.width+'" height="'+this.height+'" x="'+this.x+'" y="'+this.y+'" textWeight="'+this.textWeight+'" strokeWeight="'+this.strokeWeight+'" zIndex="" />';
	xml+= '</Node>';
	return xml;
}

function Tran(){
	this.id="t1";
	this.text="开始 → 新节点";
	this.lineType="PolyLine";
	this.from="begin";
	this.to="n1";
	
	this.startArrow="";
	this.endArrow="Classic";
	this.strokeWeight="";
	this.zIndex="39";
	
	//method
	this.loadTran = loadTran;
	this.getTranXml = getTranXml;
}

function loadTran(el){
	this.id = el.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
	this.text = el.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
	this.lineType = el.getElementsByTagName("BaseProperties").item(0).getAttribute("lineType");
	this.from = el.getElementsByTagName("BaseProperties").item(0).getAttribute("from");
	this.to = el.getElementsByTagName("BaseProperties").item(0).getAttribute("to");
	
	this.startArrow = el.getElementsByTagName("VMLProperties").item(0).getAttribute("startArrow");
	this.endArrow = el.getElementsByTagName("VMLProperties").item(0).getAttribute("endArrow");
	this.strokeWeight = el.getElementsByTagName("VMLProperties").item(0).getAttribute("strokeWeight");
	this.zIndex = el.getElementsByTagName("VMLProperties").item(0).getAttribute("zIndex");
}

function getTranXml(){
	var xml = "";
	//生成节点xml
	xml+= '<Tran><BaseProperties id="'+this.id+'" text="'+this.text+'" lineType="'+this.lineType+'" from="'+this.from+'" to="'+this.to+'" />';
	xml+= '<VMLProperties startArrow="'+this.startArrow+'" endArrow="'+this.endArrow+'" strokeWeight="'+this.strokeWeight+'" zIndex="" />';
	xml+= '</Tran>';
	return xml;
}

function WebFlow(){
	
	this.xmlRoot;
	
	
	this.nodes = new Array();
	this.trans = new Array();
	//
	this.getNodeById = getNodeById;
	this.initialize = initializeWebFlow;
}

function initializeWebFlow(xmlStr){
	
	var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
	xmlDoc.async = false;
	xmlDoc.loadXML(xmlStr);
	this.xmlRoot = xmlDoc.documentElement;
	
  	var elNodes = this.xmlRoot.getElementsByTagName("Nodes").item(0);
  	for ( var i = 0;i < elNodes.childNodes.length;i++ ) {
		elNode = elNodes.childNodes.item(i);
		var nd = new Node();
		nd.loadNode(elNode);
		this.nodes[i] = nd;
	}
  	var elTrans = this.xmlRoot.getElementsByTagName("Trans").item(0);
  	for ( var i = 0;i < elTrans.childNodes.length;i++ ) {
		elTran = elTrans.childNodes.item(i);
		var tr = new Tran();
		tr.loadTran(elTran);
		this.trans[i] = tr;
	}	

}

function getNodeById(nodeId){
	var resNode;
  	for ( var i = 0;i < this.nodes.length;i++ ) {
  		var theNode = this.nodes[i];
  		if(theNode.id==nodeId){
  			resNode = theNode;
  			break;
  		}
  	}
  	return resNode;
}

function FlowConfig(){
	//base properties	
	this.flowId="myflow";
	this.flowText="新流程";

	//vml properties
	this.nodeTextColor="black";
	this.nodeStrokeColor="black";
	this.nodeShadowColor="#b3b3b3";
	this.nodeColor1="silver";
	this.nodeColor2="white";
	this.nodeFocusedStrokeColor="yellow";
	this.sNodeTextColor="black";
	this.sNodeStrokeColor="black";
	this.isNodeShadow="T";
	this.isNode3D="false";
	this.node3DDepth="20";
	this.tranStrokeColor="black";
	this.tranTextColor="";
	this.tranFocusedStrokeColor="yellow";
	//this.;

}


function setFocusedObjLay(xmlRoot,oldObjId,newObjId,objType,newLay){
    var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
    var Trans = xmlRoot.getElementsByTagName("Trans").item(0);

    if (objType=='Tran') {
        for ( var i = 0;i < Trans.childNodes.length;i++ ) {
            Tran = Trans.childNodes.item(i);
            aId = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            if(aId == newObjId){
                document.getElementById(newObjId).style.zIndex = newLay;
                Tran.getElementsByTagName("VMLProperties").item(0).setAttribute("zIndex",newLay);
            }
        }
    } else {
        if(oldObjId!='' && newObjId!='' && newObjId!=oldObjId){
            var fromNode = document.getElementById(oldObjId);
            var toNode = document.getElementById(newObjId);

            var fromNodeWidth = parseInt(fromNode.style.width);
            var fromNodeHeight = parseInt(fromNode.style.height);
            var fromNodeX = parseInt(fromNode.style.left);
            var fromNodeY = parseInt(fromNode.style.top);

            var toNodeWidth = parseInt(toNode.style.width);
            var toNodeHeight = parseInt(toNode.style.height);
            var toNodeX = parseInt(toNode.style.left);
            var toNodeY = parseInt(toNode.style.top);

             var flag = ifRepeatNode(fromNodeX,fromNodeY,fromNodeWidth,fromNodeHeight,toNodeX,toNodeY,toNodeWidth,toNodeHeight);
        } else {
            var flag = false;
        }

        for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
            Node = Nodes.childNodes.item(i);
            sId = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            if(newObjId == sId){
                document.getElementById(sId).style.zIndex = newLay;
                Node.getElementsByTagName("VMLProperties").item(0).setAttribute("zIndex",newLay);
            }

            if(oldObjId == sId && flag){ //如果与原来的焦点节点叠盖则将原来的节点放在下面
                document.getElementById(oldObjId).style.zIndex = parseInt(newLay)-10;
                Node.getElementsByTagName("VMLProperties").item(0).setAttribute("zIndex",parseInt(newLay)-1);
            }
        }

        for ( var i = 0;i < Trans.childNodes.length;i++ ) {
            Tran = Trans.childNodes.item(i);
            aId = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            fromNode = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("from");
            toNode = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("to");
            if(fromNode == newObjId || toNode == newObjId){
                document.getElementById(aId).style.zIndex = newLay;
                Tran.getElementsByTagName("VMLProperties").item(0).setAttribute("zIndex",newLay);
            }else{
                document.getElementById(aId).style.zIndex = CONST_LAY_MIDDLE;
                Tran.getElementsByTagName("VMLProperties").item(0).setAttribute("zIndex",parseInt(newLay)-1);
            }
        }
    }

    return xmlRoot;
}

function objFocusedOn(objId,type){
    var FlowXML = document.all.FlowXML;
    if(FlowXML.value!=''){
        var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
        xmlDoc.async = false;
        xmlDoc.loadXML(FlowXML.value);

        var xmlRoot = xmlDoc.documentElement;
        var Flow = xmlRoot.getElementsByTagName("FlowConfig").item(0);

        if(type=='Tran'){
            focusedOnColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("tranFocusedStrokeColor");
        }else{
            focusedOnColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("nodeFocusedStrokeColor");
        }
        xmlRoot = setFocusedObjLay(xmlRoot,FOCUSEDOBJID,objId,type,CONST_LAY_TOPPEST);

        AUTODRAW = false; FlowXML.value = xmlRoot.xml; AUTODRAW = true;

        document.getElementById(objId).style.zIndex = CONST_LAY_TOPPEST;
        document.getElementById(objId).StrokeColor = focusedOnColor;

        if(FOCUSEDOBJID == objId && MOVEFLAG) return;
        objFocusedOff();
        FOCUSEDOBJID = objId;
        FOCUSEDOBJTYPE = type;
    }
}

function objFocusedOff(){
    if(FOCUSEDOBJID=='') return;

    var FlowXML = document.all.FlowXML;
    if(FlowXML.value!=''){
        var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
        xmlDoc.async = false;
        xmlDoc.loadXML(FlowXML.value);

        var xmlRoot = xmlDoc.documentElement;
        var Flow = xmlRoot.getElementsByTagName("FlowConfig").item(0);
        var Trans = xmlRoot.getElementsByTagName("Trans").item(0);//获得路径的xml
        
        if(FOCUSEDOBJTYPE == 'Tran'){
            focusedOffColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("tranStrokeColor");
        }else{
            if(FOCUSEDOBJTYPE == 'BeginNode' || FOCUSEDOBJTYPE == 'EndNode'){
                focusedOffColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("sNodeStrokeColor");
            }else{
                focusedOffColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("nodeStrokeColor");
            }
        }

        eval('document.all.'+FOCUSEDOBJID+'.StrokeColor="'+focusedOffColor+'"');
        backTran(Trans);//回退路径的设置和判断
        FOCUSEDOBJID = '';
        FOCUSEDOBJTYPE = '';
    }
}
//设置回退路径--zhouting
function backTran(Trans){
 for ( var i = 0;i < Trans.childNodes.length;i++ ) {
            var Tran = Trans.childNodes.item(i);
            var IText = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
            var ITranId = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            //判断如果是回退节点 那么返回
           if(IText.indexOf("(回退)")>-1){
              var focusedOffColor = "red";
              eval('document.all.'+ITranId+'.StrokeColor="'+focusedOffColor+'"');
              }
            }
}
function moveNode(moveId){
    if(!WORKFLOW_READONLY){
    	dragIt(moveId,"FlowVML");
    }
}

function redrawVML(){
  var FlowXML = document.all.FlowXML;
    var FlowVML = document.all.FlowVML;
    if(FlowXML.value!=''){
		var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
		xmlDoc.async = false;
		xmlDoc.loadXML(FlowXML.value);
		var xmlRoot = xmlDoc.documentElement;
        
        var Flow = xmlRoot.getElementsByTagName("FlowConfig").item(0);
        var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
        var Trans = xmlRoot.getElementsByTagName("Trans").item(0);

        var NodeColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("nodeStrokeColor");
        var NodeTextColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("nodeTextColor");
        var TranColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("tranStrokeColor");
        var sNodeColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("sNodeStrokeColor");
        var sNodeTextColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("sNodeTextColor");
        var NodeShadowColor = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("nodeShadowColor");
        var IsNodeShadow = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("isNodeShadow");
        var NodeColor1 = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("nodeColor1");
        var NodeColor2 = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("nodeColor2");
        var IsNode3D = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("isNode3D");
        var Node3DDepth = Flow.getElementsByTagName("VMLProperties").item(0).getAttribute("node3DDepth");

        var vmlHTML = '';
        //draw nodes
        var nIndex,nId,nText,nodeType,nIsFocused,nTextColor,nStrokeColor,nShadowColor,nIsShadow,nWidth,nHeight,nX,nY,nStrokeWeight,nTextWeight,nColor1,nColor2,nIs3D,n3DDepth;
        for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
            Node = Nodes.childNodes.item(i);
            nId = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            nText = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
            nodeType = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("nodeType");
            nIndex = Node.getElementsByTagName("VMLProperties").item(0).getAttribute("zIndex");if(nIndex=='') nIndex = CONST_LAY_LOWEST;
            if(nodeType=='BeginNode' || nodeType=='EndNode'){
                nTextColor = sNodeTextColor;
                nStrokeColor = sNodeColor;
            }else{
                nTextColor = NodeTextColor;
                nStrokeColor = NodeColor;
            }
            nShadowColor = NodeShadowColor;
            nIsShadow = IsNodeShadow;
            nWidth = Node.getElementsByTagName("VMLProperties").item(0).getAttribute("width");
            nHeight = Node.getElementsByTagName("VMLProperties").item(0).getAttribute("height");
            nX = Node.getElementsByTagName("VMLProperties").item(0).getAttribute("x");
            nY = Node.getElementsByTagName("VMLProperties").item(0).getAttribute("y");
            nStrokeWeight = Node.getElementsByTagName("VMLProperties").item(0).getAttribute("strokeWeight");
            nTextWeight = Node.getElementsByTagName("VMLProperties").item(0).getAttribute("textWeight");
            nColor1 = NodeColor1;
            nColor2 = NodeColor2;
            nIs3D = IsNode3D;
            n3DDepth = Node3DDepth;
            try{
				if(nText==CURR_NODE_NAME){
	            	vmlHTML += getNodeHTML(nodeType,nIndex,nId,nText,nTextColor,nStrokeColor,nShadowColor,nIsShadow,nWidth,nHeight,nX,nY,nStrokeWeight,nTextWeight,"#85F1A0",nColor2,nIs3D,n3DDepth);            
	            }else{
	            	vmlHTML += getNodeHTML(nodeType,nIndex,nId,nText,nTextColor,nStrokeColor,nShadowColor,nIsShadow,nWidth,nHeight,nX,nY,nStrokeWeight,nTextWeight,nColor1,nColor2,nIs3D,n3DDepth);
	            }
	         }catch(e){
	         	vmlHTML += getNodeHTML(nodeType,nIndex,nId,nText,nTextColor,nStrokeColor,nShadowColor,nIsShadow,nWidth,nHeight,nX,nY,nStrokeWeight,nTextWeight,nColor1,nColor2,nIs3D,n3DDepth);
	         }
            //vmlHTML += getNodeHTML(nodeType,nIndex,nId,nText,nTextColor,nStrokeColor,nShadowColor,nIsShadow,nWidth,nHeight,nX,nY,nStrokeWeight,nTextWeight,nColor1,nColor2,nIs3D,n3DDepth);
        }
        clearVML();
        drawObject(vmlHTML);
        vmlHTML = '';

        //draw trans
        var removeFlag = false;
        var lIndex,lId,lText,lType,lIsFocused,lFromNode,lToNode,lStrokeColor,lStrokeWeight,lStartArrow,lEndArrow;
        for ( var i = 0;i < Trans.childNodes.length;i++ ) {
            Tran = Trans.childNodes.item(i);
            lId = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            lText = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
            lType = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("lineType");
            lIndex = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("zIndex");if(lIndex=='') lIndex = CONST_LAY_LOWER;
            lFromNode = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("from");
            lToNode = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("to");
            lStartArrow = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("startArrow");
            lEndArrow = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("endArrow");
            lStrokeWeight = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("strokeWeight");
            //lStrokeColor = TranColor;
            lStrokeColor = Tran.getElementsByTagName("VMLProperties").item(0).getAttribute("strokecolor");//按数据库中所存的strokecolor设置vml中路线颜色（zhouting）

            result = getTranHTML(lType,lIndex,lId,lText,document.getElementById(lFromNode),document.getElementById(lToNode),lStrokeColor,lStrokeWeight,lStartArrow,lEndArrow);
            if(result!='') {
                vmlHTML+= result;
            }else{
                Trans.removeChild(Tran);
                removeFlag = true;
            }
        }

        drawObject(vmlHTML);
        if(removeFlag) FlowXML.value = xmlRoot.xml;
    }
}

function clearXML(){
    var FlowXML = document.all.FlowXML;
    AUTODRAW = false;
    FlowXML.value = '';
}

function clearVML(){
    var FlowVML = document.all.FlowVML;
    FlowVML.innerHTML = '';

    FOCUSEDOBJID = '';
    FOCUSEDOBJTYPE = '';
}

function drawObject(ObjHTML){
    var FlowVML = document.all.FlowVML;
    FlowVML.innerHTML+= ObjHTML;
}

function removeXMLNode(objId){
    var FlowXML = document.all.FlowXML;
    if(FlowXML.value!=''){
        
		var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
		xmlDoc.async = false;
		xmlDoc.loadXML(FlowXML.value);
		var xmlRoot = xmlDoc.documentElement;
        
        var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
        var Trans = xmlRoot.getElementsByTagName("Trans").item(0);

        var findFlag = false;
        for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
            Node = Nodes.childNodes.item(i);
            id = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
            if(id==objId) {
                Nodes.removeChild(Node);
                findFlag = true;break;
            }
        }
        if (!findFlag) {
            for ( var i = 0;i < Trans.childNodes.length;i++ ){
                Tran = Trans.childNodes.item(i);
                id = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
                if(id==objId) {
                    Trans.removeChild(Tran);
                    findFlag = true;break;
                }
            }
        }

        if (findFlag) {AUTODRAW = true; FlowXML.value = xmlRoot.xml;}
    }
}
function showcontent(text,nodename){
	try{
		var obj = document.getElementById("me");
		obj.style.posLeft=document.body.scrollLeft+event.clientX;
	    obj.style.posTop=document.body.scrollTop+event.clientY;
	    if(text!=""){
	    	obj.style.display="block";
	    	obj.innerHTML="<table class='ListTable' cellpadding=1 cellspacing=1 border=0 style='background-color:#409cce;' height='100%' width='100%'><tr class='titletable1'><td>处理人</td><td>处理人所在单位</td><td>处理意见</td><td>处理时间</td></tr>"+text+"</table>";
	    }
    }catch(e){}
}

function hidecontent(){
	try{
		var obj = document.getElementById("me");
	    obj.style.display="none";
    }catch(e){}
}
function getNodeHTML(nodeType,z_index,id,text,textColor,strokeColor,shadowColor,isShadow,width,height,X,Y,strokeWeight,textWeight,color1,color2,is3D,node3DDepth){
    var nodeHTML = '';
    var styleHTML = 'id='+id+' title="'+text+'" style="z-index:'+z_index+';position:absolute;width:'+width+';height:'+height+';left:'+X+';top:'+Y+';" strokecolor="'+strokeColor+'" strokeweight="'+strokeWeight+'" onmouseover=\'this.style.cursor="hand";\' onmousedown=\'cleancontextMenu();objFocusedOn(this.id,"'+nodeType+'");moveNode(this);\' oncontextmenu=\'objFocusedOn(this.id,"'+nodeType+'");nodeContextMenu("'+id+'","'+nodeType+'","'+text+'");return false;\'';
    var textStyleHTML = 'style="text-align:center; color:'+textColor+'; font-size:'+textWeight+';"';
    var shadowHTML = '<v:shadow on="'+isShadow+'" type="single" color="'+shadowColor+'" offset="3px,3px"/>';
    var gradientHTML = '<v:fill type="gradient" color="'+color1+'" color2="'+color2+'" />';
    var node3DHTML = '<v:extrusion on="'+is3D+'" backdepth="'+node3DDepth+'" />';

    if(nodeType=='BeginNode' || nodeType=='EndNode'){
        nodeHTML = '<v:Oval '+styleHTML+'>'+gradientHTML+'<v:TextBox inset="6pt,10pt,6pt,10pt" '+textStyleHTML+'>'+text+'</v:TextBox></v:Oval>';
    }else{
    	var _obj = document.getElementsByName(text);
    	var title = "";
    	try{
	    	if(_obj){
	    		for(var i=0;i<_obj.length;i++){
	    			title +=_obj[i].value;
	    		}
	    	}else{
	    		title = text;
	    	}
    	}catch(e){
    		title=text;
    	}
        nodeHTML  = '<v:group id="'+id+'" onmouseover=\'this.style.cursor="hand";\' coordsize="' +width+ ',' +height+ '" style="z-index:'+z_index+';position:absolute;left:' +X+ ';top:' +Y+ ';width:' +width+ '; height:' +height+ ';"  onmousedown=\'cleancontextMenu();objFocusedOn(this.id,"'+nodeType+'");moveNode(this);\' oncontextmenu=\'objFocusedOn(this.id,"'+nodeType+'");nodeContextMenu("'+id+'","'+nodeType+'","'+text+'");return false;\'">';
        nodeHTML += '<v:RoundRect onmouseover=\'showcontent("'+title+'","'+text+'")\' onmouseout=\'hidecontent()\' style="width:' +width+ ';height:' +height+'" strokecolor="'+strokeColor+'" strokeweight="'+strokeWeight+'">';
        nodeHTML += '<v:fill type="gradient" color="'+color1+'" color2="'+color2+'" />';
        nodeHTML += '<v:TextBox inset=",25px,," style="overflow:visible; text-align:center; color:'+textColor+'; font-size:'+textWeight+';">'+text+'</v:TextBox>';
        nodeHTML += '</v:RoundRect>';
        nodeHTML += '</v:group>';
    }

    return nodeHTML;
}

function getTranHTML(lineType,z_index,id,tranText,fromNode,toNode,strokeColor,strokeWeight,startArrow,endArrow){
    var tranHTML = '';
    if(lineType == 'Line'){
        tranHTML = '<v:line id='+id+' title="'+id+'" style="z-index:'+z_index+';position:absolute;" '+getTranPoints(lineType,fromNode,toNode)+' strokecolor="'+strokeColor+'" strokeweight="'+strokeWeight+'" onmousedown=\'cleancontextMenu();objFocusedOn(this.id,"Tran");\' oncontextmenu=\'objFocusedOn(this.id,"Tran");tranContextMenu("'+id+'","'+tranText+'");return false;\'><v:stroke StartArrow="'+startArrow+'" EndArrow="'+endArrow+'"/></v:line>';
    }else{
        tranHTML = '<v:PolyLine id='+id+' title="'+id+'" filled="false" Points="'+getTranPoints(lineType,fromNode,toNode)+'" style="z-index:'+z_index+';position:absolute;" strokecolor="'+strokeColor+'" strokeweight="'+strokeWeight+'" onmousedown=\'cleancontextMenu();objFocusedOn(this.id,"Tran");\' oncontextmenu=\'objFocusedOn(this.id,"Tran");tranContextMenu("'+id+'","'+tranText+'");return false;\'><v:stroke StartArrow="'+startArrow+'" EndArrow="'+endArrow+'"/></v:PolyLine>';
    }

    return tranHTML;
}

function ifRepeatNode(fromNodeX,fromNodeY,fromNodeWidth,fromNodeHeight,toNodeX,toNodeY,toNodeWidth,toNodeHeight){
    return (fromNodeX + fromNodeWidth >= toNodeX) && (fromNodeY + fromNodeHeight >= toNodeY) && (toNodeX + toNodeWidth >= fromNodeX) && (toNodeY + toNodeHeight >= fromNodeY);
}

function getTranPoints(lineType,fromNode,toNode){
    if (fromNode==null || toNode==null) return '';

    var pointsHTML = '';

    var fromNodeWidth = parseInt(fromNode.style.width);
    var fromNodeHeight = parseInt(fromNode.style.height);
    var toNodeWidth = parseInt(toNode.style.width);
    var toNodeHeight = parseInt(toNode.style.height);
    var fromNodeX = parseInt(fromNode.style.left);
    var fromNodeY = parseInt(fromNode.style.top);
    var toNodeX = parseInt(toNode.style.left);
    var toNodeY = parseInt(toNode.style.top);
    var fromX, fromY, toX, toY;

    //FromNode Center X,Y
    fromCenterX = fromNodeX + parseInt(fromNodeWidth/2);
    fromCenterY = fromNodeY + parseInt(fromNodeHeight/2);
    //ToNode Center X,Y
    toCenterX = toNodeX + parseInt(toNodeWidth/2);
    toCenterY = toNodeY + parseInt(toNodeHeight/2);

    fromX = fromY = toX = toY;

    if(lineType=='Line' && fromNode!=toNode){//以下是Line的画线算法
        //ToNode：左上顶点
        toNodeX1 = toNodeX;
        toNodeY1 = toNodeY;
        //ToNode：右上顶点
        toNodeX2 = toNodeX + toNodeWidth;
        toNodeY2 = toNodeY;
        //ToNode：左下顶点
        toNodeX3 = toNodeX;
        toNodeY3 = toNodeY + toNodeHeight;
        //ToNode：右下顶点
        toNodeX4 = toNodeX + toNodeWidth;
        toNodeY4 = toNodeY + toNodeHeight;

        //如果ToNode在FromNode的右下方，则取ToNode的左上顶点
        if (toNodeX>fromNodeX && toNodeY>fromNodeY) {fromX = fromNodeX+fromNodeWidth; fromY = fromNodeY+fromNodeHeight; toX = toNodeX1; toY = toNodeY1;}
        //如果ToNode在FromNode的左下方，则取ToNode的右上顶点
        if (toNodeX<fromNodeX && toNodeY>fromNodeY) {fromX = fromNodeX; fromY = fromNodeY+fromNodeHeight; toX = toNodeX2; toY = toNodeY2;}
        //如果ToNode在FromNode的右上方，则取ToNode的左下顶点
        if (toNodeX>fromNodeX && toNodeY<fromNodeY) {fromX = fromNodeX+fromNodeWidth; fromY = fromNodeY; toX = toNodeX3; toY = toNodeY3;}
        //如果ToNode在FromNode的左上方，则取ToNode的右下顶点
        if (toNodeX<fromNodeX && toNodeY<fromNodeY) {fromX = fromNodeX; fromY = fromNodeY; toX = toNodeX4; toY = toNodeY4;}

        pointsHTML = 'from="'+fromX+','+fromY+'" to="'+toX+','+toY+'"';
    }else{//以下是PolyLine的画线算法

        if(fromNode!=toNode){
            //节点是否叠盖: 叠盖就不画连线
            if (ifRepeatNode(fromNodeX,fromNodeY,fromNodeWidth,fromNodeHeight,toNodeX,toNodeY,toNodeWidth,toNodeHeight)) {
                return "";
            }

            point2X = fromCenterX;
            point2Y = toCenterY;

            if (toCenterX > fromCenterX) {
                absY = toCenterY>=fromCenterY?toCenterY-fromCenterY:fromCenterY-toCenterY;
                if (parseInt(fromNodeHeight/2)>=absY) {
                    point1X = fromNodeX + fromNodeWidth;
                    point1Y = toCenterY;
                    point2X = point1X;
                    point2Y = point1Y;
                }else{
                    point1X = fromCenterX;
                    point1Y = fromCenterY<toCenterY?fromNodeY+fromNodeHeight:fromNodeY;
                }
                absX = toCenterX-fromCenterX;
                if (parseInt(fromNodeWidth/2)>=absX) {
                    point3X = fromCenterX;
                    point3Y = fromCenterY<toCenterY?toNodeY:toNodeY+toNodeHeight;
                    point2X = point3X;
                    point2Y = point3Y;
                }else{
                    point3X = toNodeX;
                    point3Y = toCenterY;
                }
            }
            if (toCenterX < fromCenterX) {
                absY = toCenterY>=fromCenterY?toCenterY-fromCenterY:fromCenterY-toCenterY;
                if (parseInt(fromNodeHeight/2)>=absY) {
                    point1X = fromNodeX;
                    point1Y = toCenterY;
                    point2X = point1X;
                    point2Y = point1Y;
                }else{
                    point1X = fromCenterX;
                    point1Y = fromCenterY<toCenterY?fromNodeY+fromNodeHeight:fromNodeY;
                }
                absX = fromCenterX-toCenterX;
                if (parseInt(fromNodeWidth/2)>=absX) {
                    point3X = fromCenterX;
                    point3Y = fromCenterY<toCenterY?toNodeY:toNodeY+toNodeHeight;
                    point2X = point3X;
                    point2Y = point3Y;
                }else{
                    point3X = toNodeX + toNodeWidth;
                    point3Y = toCenterY;
                }
            }
            if (toCenterX == fromCenterX) {
                point1X = fromCenterX;
                point1Y = fromCenterY>toCenterY?fromNodeY:fromNodeY+fromNodeHeight;
                point3X = fromCenterX;
                point3Y = fromCenterY>toCenterY?toNodeY+toNodeHeight:toNodeY;
                point2X = point3X;point2Y = point3Y;
            }
            if (toCenterY == fromCenterY) {
                point1X = fromCenterX>toCenterX?fromNodeX:fromNodeX+fromNodeWidth;
                point1Y = fromCenterY;
                point3Y = fromCenterY;
                point3X = fromCenterX>toCenterX?toNodeX+toNodeWidth:toNodeX;
                point2X = point3X;point2Y = point3Y;
            }

            pointsHTML = point1X+','+point1Y+' '+point2X+','+point2Y+' '+point3X+','+point3Y;

        }else{
            var constLength = 30;
            point0X = fromNodeX+fromNodeWidth-constLength;
            point0Y = fromNodeY+fromNodeHeight;
            point1X = point0X;
            point1Y = point0Y+constLength;
            point2X = fromNodeX+fromNodeWidth+constLength;
            point2Y = point1Y;
            point3X = point2X;
            point3Y = point0Y-constLength;
            point4X = fromNodeX+fromNodeWidth;
            point4Y = point3Y;

            pointsHTML = point0X+','+point0Y+' '+point1X+','+point1Y+' '+point2X+','+point2Y+' '+point3X+','+point3Y+' '+point4X+','+point4Y;
        }

    }
    return pointsHTML;
}



function showContextMenu(menuSrc){
    //生成右键菜单
	var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
	xmlDoc.async = false;
	xmlDoc.loadXML(menuSrc);
	var xmlRoot = xmlDoc.documentElement;
    var menuText=''+xmlRoot.xml+''
    loadContextMenu(menuText,BASE_RESOURCE_PATH +'inc/contextMenu/contextmenu.xsl')
}

var dialogURL = "";
function workFlowDialog(id,type,defId){
    switch (type){
    case 'NormalNode': dialogURL = id==null?'editnode.action?bpmDefinition.id='+defId:'editnode.action?nodeid='+id+'&bpmDefinition.id='+defId;break;
    case 'BeginNode': dialogURL = id==null?'editnode.action?bpmDefinition.id='+defId:'editnode.action?nodeid='+id+'&bpmDefinition.id='+defId;break;
    case 'EndNode': dialogURL = id==null?'editnode.action?bpmDefinition.id='+defId:'editnode.action?nodeid='+id+'&bpmDefinition.id='+defId;break;
    case 'Tran': dialogURL = id==null?'edittran.action?bpmDefinition.id='+defId:'edittran.action?tranid='+id+'&bpmDefinition.id='+defId;break;
    case 'Flow': dialogURL = id==null?'editflow.action?bpmDefinition.id='+defId:'editflow.action?flowid='+id+'&bpmDefinition.id='+defId;break;
    }

	//var oBaseColl = document.all.tags('BASE');
    //if (oBaseColl && oBaseColl.length) {
    //    dialogURL = oBaseColl[0].href + dialogURL;
    //}
    dialogURL = BASE_PATH+dialogURL;
    //alert(dialogURL);
    var dialog = window.showModalDialog(dialogURL, window, "dialogWidth:400px; dialogHeight:480px; center:yes; help:no; resizable:no; status:no;") ;//设置弹出的模态窗口的宽，高
}
//add by lihao
function workFlowDialogSetVaribles(id,type,defId){
    switch (type){
    case 'NormalNode': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'editnode.action?nodeid='+id+'&bpmDefinition.id='+defId+"&varibles=set";break;
    case 'BeginNode': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?nodeid='+id+'&bpmDefinition.id='+defId+"&varibles=set";break;
    case 'EndNode': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?nodeid='+id+'&bpmDefinition.id='+defId+"&varibles=set";break;
    case 'Tran': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?tranid='+id+'&bpmDefinition.id='+defId;break;
    case 'Flow': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?flowid='+id+'&bpmDefinition.id='+defId;break;
    }

	//var oBaseColl = document.all.tags('BASE');
    //if (oBaseColl && oBaseColl.length) {
    //    dialogURL = oBaseColl[0].href + dialogURL;
    //}
    dialogURL = BASE_PATH+dialogURL;
    //alert(dialogURL);
    var dialog = window.showModalDialog(dialogURL, window, "dialogWidth:400px; dialogHeight:480px; center:yes; help:no; resizable:no; status:no;") ;//设置弹出的模态窗口的宽，高
}

//查看节点属性
function workFlowDialogView(id,type,defId){
    switch (type){
    case 'NormalNode': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?nodeid='+id+'&bpmDefinition.id='+defId;break;
    case 'BeginNode': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?nodeid='+id+'&bpmDefinition.id='+defId;break;
    case 'EndNode': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?nodeid='+id+'&bpmDefinition.id='+defId;break;
    case 'Tran': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?tranid='+id+'&bpmDefinition.id='+defId;break;
    case 'Flow': dialogURL = id==null?'viewnode.action?bpmDefinition.id='+defId:'viewnode.action?flowid='+id+'&bpmDefinition.id='+defId;break;
    }

	//var oBaseColl = document.all.tags('BASE');
    //if (oBaseColl && oBaseColl.length) {
    //    dialogURL = oBaseColl[0].href + dialogURL;
    //}
    dialogURL = BASE_PATH+dialogURL;
    //alert(dialogURL);
    var dialog = window.showModalDialog(dialogURL, window, "dialogWidth:400px; dialogHeight:480px; center:yes; help:no; resizable:no; status:no;") ;//设置弹出的模态窗口的宽，高
}
function generateElementId(els,prefix){
  var id = "";
  findId:
  for (var n=1; n<200; n++) {
      for (var i=0; i < els.childNodes.length; i++) {
          var Node = els.childNodes.item(i);
          var nId = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
          if (nId == prefix + n)
              continue findId;
      }
      id = prefix + n;
      break;
  }
  if (id == "")
      id = prefix +"t" + (new Date().getTime());
  return id;
}