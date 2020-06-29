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
<script language="VBSCRIPT">
Public Sub CellWeb1_MouseDClick(col,row)
	'CellWeb1.StartEdit col,row
End Sub
Public Sub CellWeb1_AllowInputFormula(col,row,approve)
    If CellWeb1.IsFormulaCell(col, row, CellWeb1.GetCurSheet) Then
	  approve=0
    End If
End Sub
Public Sub CellWeb1_OnPaste(col,row,approve)
	With CellWeb1
		.SetCellNote 1, row, .GetCurSheet, 0
		approve=0
	End With
End Sub
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
function onBodyLoaded() {
    document.body.scroll = "no";
    if (typeof(document.all("CellWeb1")) == "undefined") {
        alert("打开操作失败");
        return;
    }
    window_onload();
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

	var lHeight = document.body.offsetHeight - parseInt(CellWeb1.style.top);
	if( lHeight <= 0 ) lHeight = 1;
	CellWeb1.style.height = lHeight;
}

function window_onload() {

	CellWeb1.EnableUndo(true);
	CellWeb1.Mergecell = true;
	CellWeb1.border = 0;
	CellWeb1.style.left = 0;	

	setCellPosition();
	var lWidth = document.body.offsetWidth;
	if( lWidth <= 0) lWidth = 1;
	CellWeb1.style.width = lWidth;

	
	var lHeight = document.body.offsetHeight - parseInt(CellWeb1.style.top);
	if( lHeight <= 0 ) lHeight = 1;
	CellWeb1.style.height = lHeight;
	CellWeb1.style.display="";
	CellWeb1.CalcManaually=true;
	CellWeb1.InputFormulaInCell=true;
	CellWeb1.HideFormulaErrorInfo=true;//公式错误时,不显示#ERROR字样
	CellWeb1.SetShowFormula(0);

	<s:if test="${isView=='yes'}">
	 	CellWeb1.WorkbookReadonly=true;
	</s:if>
}
function setCellPosition(){
	CellWeb1.style.top = idTBDesign.offsetTop + idTBDesign.offsetHeight;
}
</script>