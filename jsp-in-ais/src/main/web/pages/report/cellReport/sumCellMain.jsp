<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>
		${condition.reportCode }-汇总
	</title>
	<s:include value="sumCellScript.jsp"></s:include>
	
	<script type="text/javascript">
		function openSingFile(){
			var templateId = document.getElementById("ctSelect");
			var url = 'http://<%=request.getServerName()+":"+request.getServerPort()%>${contextPath}/report/ct/readSign.action?id='+templateId.options[templateId.selectedIndex].value;
			var result = CellWeb1.OpenFile(url,"");
			if(result=="1"){
				CellWeb1.SetShowFormula(0);
				CellWeb1.CalcManaually=false;
				CellWeb1.InputFormulaInCell=false;
				CellWeb1.ProtectFormula=true;
			 	//CellWeb1.ShowSideLabel(0,0);//隐藏行标
			 	CellWeb1.ShowTopLabel(0,0);//隐藏列标
			 	CellWeb1.ShowSheetLabel(0,0);//隐藏页签
			 	return result;
			}
		}
		function handlerFetchData_click(){
			var result = openSingFile()
			if(result=="1"){
				fetchXMLData(false);
			}
		}
		function fetchXMLData(isMerge){
			var season = document.getElementById("season");
			var templateId = document.getElementById("ctSelect");
			var xx = "season="+season.value+"&id="+templateId.options[templateId.selectedIndex].value;
			xx += "&reportType=2&isMerge="+isMerge;
		    var result=0;
		    var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		    xmlhttp.open("post", "<%=request.getContextPath()%>/report/cell/cell.srlt?action=sum", false);
		    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
		    xmlhttp.setRequestHeader("Content-Length",xx.length);
		    xmlhttp.onreadystatechange=function(){
		  		if(xmlhttp.readyState == 4){
		            if(xmlhttp.status == 4000){          
						if(confirm("已汇总过该季度报表，是否重新汇总？")){
							fetchXMLData(true);
						}
		            }else{
			        }
		  		}
		    };

			var areas = GetAreaArray();
			var area = areas.split(",");
		    var col = parseInt(area[0]);
		    var row = parseInt(area[1]);
		    var sheet = parseInt(area[4]);
		    try {
	        	xmlhttp.send(xx);
		        xmlDoc = xmlhttp.responseXML;
		        var rows = xmlDoc.selectNodes("data/row");
				if((row+rows.length)>=CellWeb1.GetRows(sheet)){
					CellWeb1.InsertRow(row+1,row+rows.length-CellWeb1.GetRows(sheet),sheet)
				}
		        for(var i=0;i<rows.length;i++){
					var cols = rows[i].selectNodes("col");
					for(var j=0;j<cols.length;j++){
						if(cols[j].getAttribute("type")=="String"){
							CellWeb1.S(col+j,row+i,sheet,cols[j].text);
						}else{
							CellWeb1.D(col+j,row+i,sheet,cols[j].text);
						}
					}
			    }
		    } catch (e) {
			    alert(e.message)
		        alert("读取数据失败！");
		        return;
		    }
		}
	</script>
</head>
<body id="mainbody" class="mainBody"  onload="onBodyLoaded();handlerFetchData_click()"  LANGUAGE=javascript onresize="return window_onresize()">
<s:include value="sumCellToolMenu.jsp"></s:include>
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