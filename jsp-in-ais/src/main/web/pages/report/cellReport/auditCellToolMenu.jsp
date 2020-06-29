<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<script language="VBSCRIPT">
Function GetAreaArray()
	Dim col1,row1,col2,row2,sheet,uri
	uri=""
   	result = CellWeb1.GetAreaVar("selectRegion1", col1, row1, col2, row2, sheet)
	If result Then
		call GetAreaArrayObject(CellWeb1.GetSheetLabel(sheet),col1,row1,col2,row2)
	End If
   	result = CellWeb1.GetAreaVar("selectRegion2", col1, row1, col2, row2, sheet)
	If result Then
		call GetAreaArrayObject(CellWeb1.GetSheetLabel(sheet),col1,row1,col2,row2)
	End If
   	result = CellWeb1.GetAreaVar("selectRegion3", col1, row1, col2, row2, sheet)
	If result Then
		call GetAreaArrayObject(CellWeb1.GetSheetLabel(sheet),col1,row1,col2,row2)
	End If
   	result = CellWeb1.GetAreaVar("selectRegion4", col1, row1, col2, row2, sheet)
	If result Then
		call GetAreaArrayObject(CellWeb1.GetSheetLabel(sheet),col1,row1,col2,row2)
	End If
End Function
Function GetRed()
	GetRed=CellWeb1.FindColorIndex(RGB(203, 232, 207), 1)
End Function
</script>
<script type="text/javascript">
<!--
	function adjustAgain(){
		document.location='adjust.action?condition.id=${condition.id}';
	}
function exportExl(){
	CellWeb1.ExportExcelDlg();
}
//-->
</script>
<TABLE class="cbToolbar" id="idTBDesign" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<TD width="100%">
		<input type="button" onclick="exportExl()" value="整体输出">
		<s:if test="${isUpload=='1'}">
			<a href="boHui.action?conditon.id=${conditon.id}">驳回</a>
			<input type="button" onclick="javascript:document.location='lowerLevelList.action'" value="返回">
		</s:if>
		<s:else>
			<s:if test="${condition.adjustStatus==1 and condition.uploadStatus!=1}">
				<input type="button" onclick="adjustAgain()" value="重新调整">
			</s:if>
			<input type="button" onclick="javascript:document.location='thisLevelList.action'" value="返回">
		</s:else>
	</TD>
	</TR>
</TABLE>