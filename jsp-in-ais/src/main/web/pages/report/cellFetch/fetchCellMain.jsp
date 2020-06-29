<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>
		<s:if test="${templateType==1}">
			自定义报表生成
		</s:if>
		<s:if test="${templateType==2}">
			审计报表生成
		</s:if>
	</title>
	<s:include value="fetchCellScript.jsp"></s:include>
	
	<script type="text/javascript">
		function openSingFile(){
			<s:if test="${templateType!=2}">
			var templateId = document.getElementById("ctSelect");
			var url = 'http://<%=request.getServerName()+":"+request.getServerPort()%>${contextPath}/report/ct/readSign.action?id='+templateId.options[templateId.selectedIndex].value;
			</s:if>
			<s:else>
			var url = 'http://<%=request.getServerName()+":"+request.getServerPort()%>${contextPath}/report/ct/readSign.action?id=8abcd0902a3b2c9e012a3bb731170001';
			</s:else>
			var result = CellWeb1.OpenFile(url,"");
			if(result=="1"){
				CellWeb1.SetShowFormula(0);
				CellWeb1.InputFormulaInCell=false;
				CellWeb1.ProtectFormula=true;
				CellWeb1.SetCurSheet(0);
			}
		}
		function exportExl(){
			CellWeb1.ExportExcelDlg();
		}
		function handlerFetchData_click(){
			openSingFile();
			<s:if test="${templateType!=2}">
			var templateId = document.getElementById("ctSelect");
			if(templateId.selectedIndex==0){
				alert("请选择报表模板！");
				return false;
			}
			</s:if>
			CellWeb1.CalcManaually=false;
			CellWeb1.CalculateAll();
			CellWeb1.CalcManaually=true;
		}
		function submitDate(params,funName,rettype,col,row,sheet){
			var season = document.getElementById("season");
			var xx = "funName="+funName+"&season="+season.value;
			if(params!=null)xx+=encodeURI(encodeURI(params));
		    var result=0;
		    var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		    xmlhttp.open("post", "<%=request.getContextPath()%>/report/cell/fetchDataByFormula.action", false);
		    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
		    xmlhttp.setRequestHeader("Content-Length",xx.length);
		    try {
	        	if(getFormulaAttri(funName)==2){
		        	xmlhttp.send(xx);
			        xmlDoc = xmlhttp.responseXML;
			        var rows = xmlDoc.selectNodes("data/row");
			        for(var i=0;i<rows.length;i++){
						var cols = rows[i].selectNodes("col");
						for(var j=0;j<cols.length;j++){
							if(i==0&&j==0)CellWeb1.setFuncResult(0.0,cols[j].text,1);
							CellWeb1.S(col+j,row+i,sheet,cols[j].text);
						}
				    }
		        }else{
		        	xmlhttp.send(xx);
			        result=xmlhttp.responseText;
					if(rettype==1){
						CellWeb1.SetFuncResult(0.0,result,1);
					}else{
						CellWeb1.SetFuncResult(result,"",0);
					}
		        }
		    } catch (e) {
			    alert(e.message)
		        alert("网络失败");
		        return;
		    }
		}
	</script>
</head>
<body id="mainbody" class="mainBody"  onload="onBodyLoaded()"  LANGUAGE=javascript onresize="return window_onresize()">
<s:include value="fetchCellToolMenu.jsp"></s:include>
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