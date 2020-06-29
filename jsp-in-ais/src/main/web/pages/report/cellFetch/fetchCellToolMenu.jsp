<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script language="VBSCRIPT">
Function GetArea()
	Dim col1,row1,col2,row2,sheet,uri
	uri = ""
   	result1 = CellWeb1.GetAreaVar("selectRegion1", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)

   	result2 = CellWeb1.GetAreaVar("selectRegion2", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)

   	result3 = CellWeb1.GetAreaVar("selectRegion3", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)

   	result4 = CellWeb1.GetAreaVar("selectRegion4", col1, row1, col2, row2, sheet)
	uri = uri&"&startCol="&col1&"&startRow="&row1&"&endCol="&col2&"&endRow="&row2&"&sheetNames="&CellWeb1.GetSheetLabel(sheet)
	If result1 And result2 And result3 And result4 Then
		GetArea=uri
	Else
		GetArea = ""
	End If
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
					<s:if test="${templateType==2}">
						document.location="${contextPath}/report/cell/thisLevelList.action";
					</s:if>
				}else if(xmlhttp.status == 3000){
					if(confirm('已生成该期间报表,覆盖请点击"确定"?')){
						saveXML(true);
					}
	            }else if(xmlhttp.status == 3001){
					if(confirm('已生成该期间报表，点击"确定"，将覆盖该报表并且删除已调整报表?')){
						saveXML(true);
					}     
	            }else if(xmlhttp.status == 3002){
					alert('已存在该期间报表，且已上报！');
			    }else{
		            alert("ajax调用失败！"+xmlhttp.status);
		        }
	         }    
		};
		var season = document.getElementById("season");
		var uri = "<%=request.getContextPath()%>/report/cell/saveDataByXML.action?store.templateCode=8abcd0902a3b2c9e012a3bb731170001";//+templateCode.options[templateCode.selectedIndex].value;
		uri += "&season="+season.value;
		uri += "&store.isAdjust=0&store.reportType=1";
		uri += "&isMerge="+isMerge;
		uri += encodeURI(encodeURI(GetArea()));
	    xmlhttp.open("post", uri, false);
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
	    xmlhttp.setRequestHeader("Content-Length",result.length);
	    xmlhttp.send(domDoc); 
	    
	}
//-->
</script>
<TABLE class="cbToolbar" id="idTBDesign" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<s:if test="${templateType!=2}">
		<TD NOWRAP id="cmdDateType" Title="报表模板">
			选择报表：<s:select name="ctSelect" id="ctSelect" list="cellTemplates" listKey="id" listValue="templateName" emptyOption="true" onchange="openSingFile()"></s:select>
		</TD>
	</s:if>
	<TD class="tbDivider" NOWRAP Title="查询区间">
		选择查询区间：<s:select list="seasonList" listKey="code" listValue="name"
				name="season" id="season" cssStyle="WIDTH: 150px; HEIGHT: 23px"></s:select>
	</TD>
	<TD width="100%">
		<input type="button" onclick="handlerFetchData_click()" value="取  数">
		<s:if test="${templateType!=2}">
			<input type="button" onclick="exportExl()" value="导 出">
		</s:if>
		<s:if test="${templateType==2}">
			<input type="button" onclick="saveXML(false)" value="保 存">
			<input type="button" onclick="javascript:document.location='thisLevelList.action'" value="返回">
		</s:if>
	</TD>
	</TR>
</TABLE>