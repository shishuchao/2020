/*
    功能用途：实现 drag source
    使用方法：
        1. 在页面的 body 中包含本程序：<script language="JavaScript" src="DragSource.js"></script>
        2. setDrag(dragDiv);//dragDiv 是被拖拽的区域，本区域内的表格数据可以被拖拽
*/

var vDebug=false;//是否调试

var vDragObject=null;//被拖拽的区
var vDragText=null;//被拖拽的文本
var curTable=null;//当前表
var curTD=null;//当前格

var vOldBorderStyle="0.05mm RIDGE gainsboro"; //老的边框类型
var vNewBorderStyle="0.5mm RIDGE BLACK";  //新的边框类型

function _dnd_handleMouseDown() {
    try{
    
         curTable=getTtable();//当前表 
         if (curTable==null) return;
         
         curTD=getTD();//当前格
         if (curTD==null) return;
         if (vOldBorderStyle==null){
            //vOldBorderStyle=curTD.style.border;     
            //alert(vOldBorderStyle);    
         }
    
        // 对于 A、INPUT、TEXTAREA 和 IMG，不用替它启动 drag，它自己会处理 drag source
        if (event.srcElement.tagName == "A") return;
        if (event.srcElement.tagName == 'INPUT') return;
        if (event.srcElement.tagName == 'TEXTAREA') return;
        if (event.srcElement.tagName == 'IMG') return;
    
    
        // 清空当前的 selection，然后启动 drag
        
        document.selection.empty();
		//alert(vDragText)
        event.srcElement.dragDrop();
    }catch(E){
        if (vDebug) alert(E);
    }
}

function _dnd_handleDragStart() {
   try{
        if (vDragObject!=null){
            vDragText=getcurTableText();
        }
                     
        if (vDragText==null) return;
        
        // 设置 dragtext
        vDragText = unescape(vDragText);
        //event.dataTransfer.setData("Text", "");
        event.dataTransfer.clearData();
		window.clipboardData.setData("Text", vDragText);
        event.dataTransfer.effectAllowed = "copy";
    }catch(E){
       if (vDebug) alert(E);             
    }    
}
//------------------------------------------------------------------------------


//分析表格，得到托拽字符串
function getcurTableText(){
    var value="";
    
    var rows=curTable.rows.length;//表的行数
    var cells=curTable.cells.length;
    var cols=curTable.rows(0).cells.length;//表的列数
    if (rows==0 || cells==0) return "";

	for (var i=0;i<rows;i++){
        for (var j=0;j<cols;j++){
            var oTD=curTable.rows(i).cells(j);
            oTD.style.border=vOldBorderStyle;
        }
    }
                   
    //首行首列，托拽整张表
    if (curTable.cells(0,0)==curTD){
        //alert("托拽整张表");
        value="";
        for (var i=0;i<rows;i++){
            for (var j=0;j<cols;j++){
                var oTD=curTable.rows(i).cells(j);
				oTD.style.border=vNewBorderStyle;
				if(i==0&&j==0){
					value+="";
				}else{
				 	value+=getcurTableTdText(oTD);
				}           
                if(j!=cols-1){
                	value+="c_sep";
                }				
            }
            if(i!=rows-1){
                value+="r_sep";
             }   
        }
        if (vDebug) alert(value);
        return value;
    }
    
    //首行，托拽一列
    for (var j=0;j<cols;j++){
        if (curTable.rows(0).cells(j)==curTD){
            //alert("托拽第"+(j+1)+"列");
            for (var i=0;i<rows;i++){
                value+="";
                var oTD=curTable.rows(i).cells(j);
				 oTD.style.border=vNewBorderStyle;
                value+=getcurTableTdText(oTD);
                if(i!=rows-1){
                	value+="r_sep";
             	}
            }
 
            
            if (vDebug) alert(value);         
            return value;
        }
    }
        
    //首列，托拽一行
    for (var i=0;i<rows;i++){
        if (curTable.rows(i).cells(0)==curTD){
            //alert("托拽第"+(i+1)+"行");
            value+="";
            for (var j=0;j<cols;j++){
                var oTD=curTable.rows(i).cells(j);
				oTD.style.border=vNewBorderStyle;  
                value+=getcurTableTdText(oTD);
				if(j!=cols-1){
                	value+="c_sep";
                }				
            }        
            //value+="r_sep";
            if (vDebug) alert(value);
            return value;
        }
    }
    
    //其它，托拽该单元格
	curTD.style.border=vNewBorderStyle;
    value=getcurTableTdText(curTD);
    //value+="c_sep";
	//value+="r_sep";
    if (vDebug) alert(value);
    
    return value;
}  

//取出某个单元格的值，优先从dragtext属性上取值
function getcurTableTdText(oTD){
    if (oTD==null) return "";
    var value="";
    var vAlign="";

    if (oTD.dragtext!=null && oTD.dragtext!=""){
      value=oTD.dragtext; 
    }else{
      value=oTD.innerText;
	  if (oTD.align!=null && oTD.align!="") vAlign=" align='"+oTD.align+"' ";
    }
    return value;
}

//------------------------------------------------------------------------------

//找到当前对象所在的TD
function getTD() {
    var obj=event.srcElement;
    while (obj!=null && obj.tagName != "TD" && obj.id!=vDragObject.id) {
        obj = obj.parentElement;
    }
    if (obj.tagName != "TD") obj=null;
    return obj;
}

function getTtable() {
    var obj=event.srcElement;
    while (obj!=null && obj.tagName != "TABLE" && obj.id!=vDragObject.id) {
        obj = obj.parentElement;
    }
    if (obj.tagName!="TABLE") obj=null;    
    return obj;
}

//------------------------------------------------------------------------------

//设定托拽文本,默认为托拽监听对象的内部HTML文本
function setDragText(textValue){
    vDragText=textValue;
}

//设定托拽表格对象
function setDragObject(dragObject){
    setDrag(dragObject);
}

//设定托拽表格对象
function setDragTable(dragObject){
     setDrag(dragObject);
}

//设定托拽表格对象
function setDrag(dragObject){
   if (dragObject!=null){
     vDragObject=dragObject;
     dragObject.attachEvent("onmousedown", _dnd_handleMouseDown);
     dragObject.attachEvent("ondragstart", _dnd_handleDragStart);
   }
}





