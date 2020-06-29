<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<LINK rel=stylesheet type=text/css HREF="<%=request.getContextPath()%>/resources/cell/control/olstyle.css">
<style>
	body { font-family:宋体; font-size:9pt; color:black; cursor:default; margin:0; }
	td { font-family:宋体; font-size:9pt; color:black; cursor:default; }
	.icon { font-family:Wingdings; font-size:12pt; cursor:default; display:none; }
	.fakehlink {cursor: hand; text-decoration: underline; color: #0066CC; font-weight:normal;}
	input { font-family:宋体; font-size:9pt; padding-top:2px; border:1pt solid #99cccc; text-indent:1px; }
</style>
<SCRIPT LANGUAGE=VBSCRIPT src="<%=request.getContextPath()%>/ccrFormula/userDefFun.action"></SCRIPT>
<SCRIPT ID=clientEventHandlersVBS LANGUAGE=vbscript src="<%=request.getContextPath()%>/pages/ccr/menuItemClick.vbs"></SCRIPT>
<SCRIPT LANGUAGE=VBSCRIPT src="<%=request.getContextPath()%>/resources/cell/control/function.vbs"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT src="<%=request.getContextPath()%>/resources/cell/control/buttons.js"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT src="<%=request.getContextPath()%>/resources/cell/CellDragSource.js"></SCRIPT>

<script type="text/vbscript" language="VBSCript">
Public Sub CellWeb1_CalcFuncEx(col,row,sheet,name,rettype,paranum)
	Dim params,x,fpname,pvalue
	Dim isDefault   'wangly 取得参数
	Dim i,tmpParam
	For i=0 To paranum 
    	tmpParam=CellWeb1.GetFuncStringPara(i,isDefault)
    	If tmpParam<>"" Then
      		params=params & tmpParam & ","
    	End If
	Next
	If params<>"" Then
 	  params=Mid(params,1,Len(params)-1)
 	End If
	call submitDate(params,name,rettype,col,row,sheet)
End Sub

Public Sub CellWeb1_MouseDClick(col,row)
	CellWeb1.StartEdit col,row
End Sub

Public Sub CellWeb1_AllowInputFormula(col,row,approve)
    If CellWeb1.IsFormulaCell(col, row, CellWeb1.GetCurSheet) Then
	  approve=0
    End If
End Sub

Public Sub CellWeb1_InputCellFormula(col,row,sheet,formula)
	CellWeb1.SetCellNote col,row,sheet,formula
End Sub

Function GetAreaArray()
	Dim col1,row1,col2,row2,sheet
   	result1 = CellWeb1.GetAreaVar("selectRegion1", col1, row1, col2, row2, sheet)
   	result2 = CellWeb1.GetAreaVar("selectRegion2", col1, row1, col2, row2, sheet)
   	result3 = CellWeb1.GetAreaVar("selectRegion3", col1, row1, col2, row2, sheet)
   	result4 = CellWeb1.GetAreaVar("selectRegion4", col1, row1, col2, row2, sheet)

	If result1 And result2 And result3 And result4 Then
		GetAreaArray = "true"
	Else
		GetAreaArray = "false"
	End IF
End Function


</script>

<SCRIPT FOR="cbButton" EVENT="onmousedown()"	LANGUAGE="JavaScript" >
	return onCbMouseDown(this);
</SCRIPT>
<SCRIPT FOR="cbButton" EVENT="onclick()"		LANGUAGE="JavaScript" >
	return onCbClickEvent(this);
</SCRIPT>
<SCRIPT FOR="cbButton" EVENT="oncontextmenu()"	LANGUAGE="JavaScript" >
	return(event.ctrlKey);
</SCRIPT>

<script type="text/javascript">
function InitFontname(){
	strFontnames = CellWeb1.GetDisplayFontnames();
	var arrFontname = strFontnames.split('|');
	arrFontname.sort();
	var i;
	var sysFont;
	if( CellWeb1.GetSysLangID () == 2052)
		sysFont = "宋体";
	else sysFont = "Arial";
		

	for( i =0; i < arrFontname.length;i++ ){
		var oOption = document.createElement("OPTION");
		FontNameSelect.options.add(oOption);
		oOption.innerText = arrFontname[i];
		oOption.value = arrFontname[i];
		if( arrFontname[i] == sysFont ) oOption.selected = true;
	}
}
function onBodyLoaded() {
    document.body.scroll = "no";
    if (typeof(document.all("CellWeb1")) == "undefined") {
        alert("打开操作失败");
        return;
    }
    window_onload();
    openSingFile();
    CellWeb1_SaveFile();//wangly
    protectSheet();//保护页签
}
function onBodyUnload() {
    if (typeof(document.all("CellWeb1")) == "undefined" || typeof(document.all("CellWeb1").Open) == "undefined") {
        return;
    }
    CellWeb1.close();
}
function window_onresize() {
	var lWidth = document.body.offsetWidth;
	if( lWidth <= 0) lWidth = 1;
	CellWeb1.style.width = lWidth;
	Menu1.style.width = lWidth;

	var lHeight = document.body.offsetHeight - parseInt(CellWeb1.style.top);
	if( lHeight <= 0 ) lHeight = 1;
	CellWeb1.style.height = lHeight;
}

function window_onload() {
	Menu1.style.left = 0;
	Menu1.style.top = 0;

	CellWeb1.EnableUndo(true);
	CellWeb1.Mergecell = true;
	CellWeb1.border = 0;
	CellWeb1.style.left = 0;	

	idTBGeneral.style.display='';
	idTBFormat.style.display='';
	idTBDesign.style.display='';
	setCellPosition();
	var lWidth = document.body.offsetWidth;
	if( lWidth <= 0) lWidth = 1;
	CellWeb1.style.width = lWidth;
	Menu1.style.width = lWidth;

	
	var lHeight = document.body.offsetHeight - parseInt(CellWeb1.style.top);
	if( lHeight <= 0 ) lHeight = 1;
	CellWeb1.style.height = lHeight-1;
	<%
		String _ServerName2 = request.getServerName();
		int _ServerPort2 = request.getServerPort();
		String _CtxPath2 = request.getContextPath();
		String menuServerPath2="http://" + _ServerName2 + ":" + _ServerPort2 + _CtxPath2;
	 %>
	Menu1.ReadMenuFromRemoteFile("<%=menuServerPath2%>/pages/statisticalReport_HN/emenu.clm");
	CellWeb1.style.display="";
	CellWeb1.CalcManaually=true;
	CellWeb1.InputFormulaInCell=false;
	CellWeb1.HideFormulaErrorInfo=true;//公式错误时,不显示#ERROR字样
	InitFontname();
	exeUserDefFun();
	CellWeb1.SetShowFormula(0);
	
}
function setCellPosition(){
	CellWeb1.style.top = idTBDesign.offsetTop + idTBDesign.offsetHeight;
}
		function submitDate(params,name,rettype,col,row,sheet){
			var xx = "formulaName="+name+"&params="+params+"&col="+col+"&row="+row;
		    var result=0;
		    var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		    xmlhttp.open("post", "<%=request.getContextPath()%>/ccReport/loadDataByFormula.action?year=${year}&startMon=${startMon}&endMon=${endMon}&id=${reportId}", false);
		    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
		    xmlhttp.setRequestHeader("Content-Length",xx.length);
		    try {
		        xmlhttp.send(xx);
			    result=xmlhttp.responseText;
			    var numRst = 0;
			    if(rettype==0){
			    	if(result=="")result="0";
			    	numRst = new Number(result);
			    }
			   	CellWeb1.SetFuncResult(numRst,result,rettype);
		    } catch (e) {
			    alert(e.message)
		        return;
		    }
		}

</script>