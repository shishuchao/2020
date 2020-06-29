<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<script language="VBSCRIPT">
Function GetArea()
	Dim col1,row1,col2,row2,sheet,uri
	uri = ""
   	result1 = CellWeb1.GetAreaVar("selectRegion1", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)
	uri = uri&"&orgRowNum="&GetRowNum(CellWeb1.GetSheetLabel(sheet))

   	result2 = CellWeb1.GetAreaVar("selectRegion2", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)
	uri = uri&"&orgRowNum="&GetRowNum(CellWeb1.GetSheetLabel(sheet))

   	result3 = CellWeb1.GetAreaVar("selectRegion3", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)
	uri = uri&"&orgRowNum="&GetRowNum(CellWeb1.GetSheetLabel(sheet))

   	result4 = CellWeb1.GetAreaVar("selectRegion4", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)
	uri = uri&"&orgRowNum="&GetRowNum(CellWeb1.GetSheetLabel(sheet))
	If result1 And result2 And result3 And result4 Then
		GetArea=uri
	Else
		GetArea = ""
	End If
End Function
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
'删除行
Public Sub cmdDeleteRow_click()
	With CellWeb1
		StartCol = 0: StartRow = 0: EndCol = 0: EndRow = 0
		.GetSelectRange StartCol, StartRow, EndCol, EndRow
		If .GetCellNote(1, StartRow, .GetCurSheet) = "1" Or .GetCellNote(1, EndRow, .GetCurSheet) = "1" Then
			MsgBox "只能删除调整行！"
		Else
			.DeleteRow StartRow, EndRow - StartRow + 1, .GetCurSheet
		End IF
	End With
End Sub
'追加行
Public Sub cmdAppendRow_click()
	With CellWeb1
		StartCol = 0: StartRow = 0: EndCol = 0: EndRow = 0
		.GetSelectRange StartCol, StartRow, EndCol, EndRow
		.InsertRow .GetRows(.GetCurSheet), EndRow - StartRow + 1, .GetCurSheet
		.SetCellBackColor -1, .GetRows(.GetCurSheet)-1, .GetCurSheet, .FindColorIndex(RGB(203, 232, 207), 1)
		.SetCellNote 1, .GetRows(.GetCurSheet)-1, .GetCurSheet, 0
	End With
End Sub
Function GetRed()
	GetRed=GetColor(203,232,207)
End Function
Function GetColor(r,g,b)
	GetColor=CellWeb1.FindColorIndex(RGB(r, g, b), 1)
End Function
Function FillZero()
	With CellWeb1
		StartCol = 0: StartRow = 0: EndCol = 0: EndRow = 0
		.GetSelectRange StartCol, StartRow, EndCol, EndRow
		Do While StartRow <= EndRow
			Col = StartCol
			Do While Col <= EndCol
				If .GetCellDouble(Col,StartRow,.GetCurSheet)=0.0 Then
					.SetCellDouble Col,StartRow,.GetCurSheet,0.0
				End If
				Col = Col + 1
			Loop
			StartRow = StartRow + 1
		Loop
	End With
End Function
</script>
<script type="text/javascript">
<!--
	function CreateDomDoc(){//创建XML文档对象
		var signatures = ["Msxml2.DOMDocument.5.0","Msxml2.DOMDocument.4.0","Msxml2.DOMDocument.3.0","Msxml2.DOMDocument","Microsoft.XmlDom"];
	    for(var i=0;i<signatures.length;i++) {
           try{
              var domDoc = new ActiveXObject(signatures[i]);
              return domDoc;
           }catch(e){
           }
	    }
	    return null;
	}

	function saveXML(isMerge){
		var result = CellWeb1.SaveToXML("");
		var domDoc = CreateDomDoc();
		domDoc.loadXML(result);
	  	var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	  	xmlhttp.onreadystatechange=function(){
	  		if(xmlhttp.readyState == 4){
	            if(xmlhttp.status == 200){          
					info=xmlhttp.responseText;
 					alert('保存成功!');
 					document.location="thisLevelList.action";
				}else if(xmlhttp.status == 3000){
					if(confirm('已生成该期间报表,覆盖请点击"确定"?')){
						saveXML(true);
					}     
	            }else{
		            alert("ajax调用失败！"+xmlhttp.status);
		        }
	         }    
		};
		var season = document.getElementById("season");
		var uri = "<%=request.getContextPath()%>/report/cell/saveAdjustByXML.action?id=${condition.id}";
		uri += "&isMerge="+isMerge;
		uri += encodeURI(encodeURI(GetArea()));
	    xmlhttp.open("post", uri, false);
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
	    xmlhttp.setRequestHeader("Content-Length",result.length);
	    xmlhttp.send(domDoc); 
	    
	}
	function exportExl(){
		CellWeb1.ExportExcelDlg();
	}
//-->
</script>
<TABLE class="cbToolbar" id="idTBDesign" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<TD width="100%">
		<s:if test="${isView=='yes'}">
		</s:if>
		<s:else>
			<s:if test="${condition.adjustStatus==1}">
				<input type="button" onclick="saveXML(true)" value="保 存">
			</s:if>
			<s:else>
				<input type="button" onclick="saveXML(false)" value="保 存">
			</s:else>
			<input type="button" onclick="cmdAppendRow_click()" value="追加调整">
			<input type="button" onclick="cmdDeleteRow_click()" value="删除调整">
			<input type="button" onclick="FillZero()" value="调整补零">
		</s:else>
		<input type="button" onclick="exportExl()" value="整体输出">
		<input type="button" onclick="javascript:document.location='thisLevelList.action'" value="返回">
	</TD>
	</TR>
</TABLE>