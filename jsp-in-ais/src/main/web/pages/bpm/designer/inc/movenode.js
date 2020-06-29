self.onError=null;
var CURRENTX =  CURRENTY    = 0;
var COORDX = COORDY = 2000;
var XRATE = YRATE   = 0;
var MOVEOBJ = null;
var CANVASOBJ = null;
var MOVEFLAG =  false;

function    dragIt(obj,canvasIt)    {
    document.onmousemove    = moveIt;
    document.onmouseup =    dropIt;

     MOVEOBJ    = obj;
     CURRENTX = (event.clientX  + document.body.scrollLeft);
     CURRENTY = (event.clientY  + document.body.scrollTop);

     CANVASOBJ = document.getElementById(canvasIt);
    var canvasSize  = CANVASOBJ.coordsize+'';
    COORDX =    parseInt(canvasSize.slice(0,canvasSize.indexOf(',')));
    COORDY =    parseInt(canvasSize.slice(canvasSize.indexOf(',')+1,canvasSize.length));
    XRATE   = COORDX/parseInt(CANVASOBJ.style.width);
    YRATE   = COORDY/parseInt(CANVASOBJ.style.height);

     return true;
}

function    moveIt()    {
     if (MOVEOBJ == null) { return false; }
    MOVEFLAG    = true;

    newX = (event.clientX + document.body.scrollLeft);
    newY   = (event.clientY + document.body.scrollTop);
    distanceX = parseInt(XRATE*(newX - CURRENTX));//X坐标换算
    distanceY = parseInt(YRATE*(newY - CURRENTY));//Y坐标换算
    newLeft = parseInt(MOVEOBJ.style.left)  + distanceX;
    newTop =    parseInt(MOVEOBJ.style.top) +   distanceY;

    if(newLeft >= 0 && newLeft  <=  (COORDX-parseInt(MOVEOBJ.style.width))  &&  newTop >= 0 &&  newTop <= (COORDY-parseInt(MOVEOBJ.style.height))){
        MOVEOBJ.style.left = newLeft;
        MOVEOBJ.style.top  = newTop;
        MOVEOBJ.style.zIndez = CONST_LAY_TOPPEST;
        CURRENTX = newX;
        CURRENTY = newY;

        var FlowXML = document.all.FlowXML;
        if (FlowXML.value!=''){
            var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
            xmlDoc.async =  false;
            xmlDoc.loadXML(FlowXML.value);

            var xmlRoot = xmlDoc.documentElement;
            var Trans = xmlRoot.getElementsByTagName("Trans").item(0);
            for (   var i   = 0;i   < Trans.childNodes.length;i++ ) {
                Tran =    Trans.childNodes.item(i);
                aId =   Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
                fromNode    = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("from");
                toNode =    Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("to");
                if(fromNode ==  MOVEOBJ.id || toNode    ==  MOVEOBJ.id){
                    document.getElementById(aId).style.zIndex   = CONST_LAY_TOPPEST;
                    Tran.getElementsByTagName("VMLProperties").item(0).setAttribute("zIndex",CONST_LAY_TOPPEST);
                    var lineType   = Tran.getElementsByTagName("BaseProperties").item(0).getAttribute("lineType");
                    if(lineType == 'Line'){
                        // FIXME:
                    }else{
                        document.getElementById(aId).points.value = getTranPoints(lineType,document.getElementById(fromNode),document.getElementById(toNode));
                    }
                }

            }

            AUTODRAW    = false;FlowXML.value = xmlRoot.xml;
        }
    }

     event.returnValue =    false;
     return false;
}

function    dropIt()    {
    if(MOVEFLAG) {
        MOVEFLAG    = false;

        var FlowXML = document.all.FlowXML;
        if(FlowXML.value!=''    &&  MOVEOBJ!=null){
                var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
                xmlDoc.async =  false;
                xmlDoc.loadXML(FlowXML.value);

                var xmlRoot = xmlDoc.documentElement;
                var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
                for (   var i   = 0;i   < Nodes.childNodes.length;i++   ) {
                    Node = Nodes.childNodes.item(i);
                    if(MOVEOBJ.id == Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id")){
                      Node.getElementsByTagName("VMLProperties").item(0).setAttribute("x",MOVEOBJ.style.left);
                      Node.getElementsByTagName("VMLProperties").item(0).setAttribute("y",MOVEOBJ.style.top);
                      Node.getElementsByTagName("VMLProperties").item(0).setAttribute("zIndex",CONST_LAY_TOPPEST);
                    }
                }

                AUTODRAW    = false;FlowXML.value = xmlRoot.xml;AUTODRAW    = true;
        }
    }

    MOVEOBJ = null;
     return true;
}


