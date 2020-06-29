<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>
		${condition.reportCode }-调整
	</title>
	<s:include value="adjustCellScript.jsp"></s:include>
	
	<script type="text/javascript">
		function openSingFile(){
			var url = 'http://<%=request.getServerName()+":"+request.getServerPort()%>${contextPath}/report/ct/readSign.action?id=${condition.templateCode}'
			var result = CellWeb1.OpenFile(url,"");
			if(result=="1"){
				CellWeb1.SetShowFormula(0);
				CellWeb1.CalcManaually=false;
				CellWeb1.InputFormulaInCell=false;
				CellWeb1.ProtectFormula=true;
				CellWeb1.SetCurSheet(0);
				fetchXMLData();
				CellWeb1.RdOnlyCellColor=16777215;
			}
		}
		var sheetRegion = new Object();
		function GetAreaArrayObject(sheetName,startCol,startRow,endCol,endRow){
			sheetRegion[sheetName] = new Array(startCol,startRow,endCol,endRow);
		}
		var rowNumMap = new Object();
		function GetRowNum(name){
			return rowNumMap[name];
		}
		function fetchXMLData(){
			<s:if test="${empty(condition.adjustReport)}">
				var xx = "id=${condition.id}";
			</s:if>
			<s:else>
				var xx = "id=${condition.adjustReport}";
			</s:else>
		    var result=0;
		    var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		    xmlhttp.open("post", "<%=request.getContextPath()%>/report/cell/fetchDataByXML.action", false);
		    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
		    xmlhttp.setRequestHeader("Content-Length",xx.length);
		    GetAreaArray();
		    try {
	        	xmlhttp.send(xx);
		        xmlDoc = xmlhttp.responseXML;
		        var sheets = xmlDoc.selectNodes("data/sheet");
		        for(var s=0;s<sheets.length;s++){
		        	var name = sheets[s].getAttribute("Name");
		        	var area = sheetRegion[name];
			        var sheet = CellWeb1.GetSheetIndex(name);
			        
			        var rows = sheets[s].selectNodes("row");
			        var col = parseInt(area[0]);
			        var row = parseInt(area[1]);
					if((row+rows.length)>=CellWeb1.GetRows(sheet)){
						CellWeb1.InsertRow(CellWeb1.GetRows(sheet),row+rows.length-CellWeb1.GetRows(sheet),sheet)
					}
					var orgRowNum = 0;
			        for(var i=0;i<rows.length;i++){
				        CellWeb1.SetCellNote(1,row+i,sheet,rows[i].getAttribute("Original"));
				        if(rows[i].getAttribute("Original")=="0"){
				        	CellWeb1.SetCellBackColor(-1,row+i,sheet,GetRed());
					    }else{
							CellWeb1.SetCellInput(-1,row+i,sheet,5);
							orgRowNum++;
					    }
						var cols = rows[i].selectNodes("col");
						for(var j=0;j<cols.length;j++){
							var vle = cols[j].text;
							if(vle=="")continue;
							if(cols[j].getAttribute("type")=="String"){
								CellWeb1.S(col+j,row+i,sheet,vle);
							}else{
								CellWeb1.D(col+j,row+i,sheet,vle);
							}
						}
						if(col>1){
							 CellWeb1.S(col-1,row+i,sheet,i+1);
						}
				    }
			        rowNumMap[name]=orgRowNum;
		        }
		    } catch (e) {
			    alert(e.message)
		        alert("读取数据失败！");
		        return;
		    }
		}
	</script>
</head>
<body id="mainbody" class="mainBody"  onload="onBodyLoaded();openSingFile();"  LANGUAGE=javascript onresize="return window_onresize()">
<s:include value="adjustCellToolMenu.jsp"></s:include>
<div style="LEFT: 0px; POSITION: relative">正在装载华表插件模块......</div>
<p>
<OBJECT id=CommonDialog1 style="DISPLAY: none; POSITION: relative" height=32 
width=32 classid=clsid:F9043C85-F6F2-101A-A3C9-08002B2F49FB><PARAM NAME="_ExtentX" VALUE="688"><PARAM NAME="_ExtentY" VALUE="688"><PARAM NAME="_Version" VALUE="393216"><PARAM NAME="CancelError" VALUE="1"><PARAM NAME="Color" VALUE="0"><PARAM NAME="Copies" VALUE="1"><PARAM NAME="DefaultExt" VALUE=""><PARAM NAME="DialogTitle" VALUE=""><PARAM NAME="FileName" VALUE=""><PARAM NAME="Filter" VALUE=""><PARAM NAME="FilterIndex" VALUE="0"><PARAM NAME="Flags" VALUE="0"><PARAM NAME="FontBold" VALUE="0"><PARAM NAME="FontItalic" VALUE="0"><PARAM NAME="FontName" VALUE=""><PARAM NAME="FontSize" VALUE="8"><PARAM NAME="FontStrikeThru" VALUE="0"><PARAM NAME="FontUnderLine" VALUE="0"><PARAM NAME="FromPage" VALUE="0"><PARAM NAME="HelpCommand" VALUE="0"><PARAM NAME="HelpContext" VALUE="0"><PARAM NAME="HelpFile" VALUE=""><PARAM NAME="HelpKey" VALUE=""><PARAM NAME="InitDir" VALUE=""><PARAM NAME="Max" VALUE="0"><PARAM NAME="Min" VALUE="0"><PARAM NAME="MaxFileSize" VALUE="260"><PARAM NAME="PrinterDefault" VALUE="1"><PARAM NAME="ToPage" VALUE="0"><PARAM NAME="Orientation" VALUE="1"></OBJECT>

<object classid="clsid:3F166327-8030-4881-8BD2-EA25350E574A" id=CellWeb1  
style="DISPLAY: block LEFT: 184px; POSITION: absolute; TOP: 190px"
 CODEBASE="<%=request.getContextPath()%>/resources/cell/cellweb.cab#Version=5,3,8,0429" height=183 
width=367>
 <param name="_Version" value="65536">
  <param name="_ExtentX" value="2646">
  <param name="_ExtentY" value="1323">
  <param name="_StockProps" value="0">
</object>
</p>
</body>
</html>