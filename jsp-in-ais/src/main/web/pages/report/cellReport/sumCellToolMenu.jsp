<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<script language="VBSCRIPT">
Function GetArea()
	Dim col1,row1,col2,row2,sheet
   	result = CellWeb1.GetAreaVar("selectRegion", col1, row1, col2, row2, sheet)
	If result Then
		GetArea = "&col1="&col1&"&row1="&row1&"&col2="&col2&"&row2="&row2&"&sheet="&CellWeb1.GetSheetLabel(sheet)
	Else
		GetAreaArray = ""
 	End IF
End Function
Function GetAreaArray()
	Dim col1,row1,col2,row2,sheet
   	result = CellWeb1.GetAreaVar("selectRegion", col1, row1, col2, row2, sheet)
	If result Then
		GetAreaArray = col1&","&row1&","&col2&","&row2&","&sheet
	Else
		GetAreaArray = ""
	End IF
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
		var templateId = document.getElementById("ctSelect");
		var uri = "<%=request.getContextPath()%>/report/cell/cell.srlt?action=saveSumXML&id="+templateId.options[templateId.selectedIndex].value;
		uri += "&season="+season.value;
		uri += "&reportType=2";
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
			选择报表：<s:select name="ctSelect" id="ctSelect" list="cellTemplates" listKey="id" listValue="templateName" emptyOption="true" onchange="openSingFile()"></s:select>
			&nbsp;&nbsp;
			选择查询区间：<s:select list="seasonList" listKey="code" listValue="name"
				name="season" id="season" cssStyle="WIDTH: 150px; HEIGHT: 23px"></s:select>
			<input type="button" onclick="handlerFetchData_click()" value="汇 总">
			<input type="button" onclick="saveXML(false)" value="保 存">
		</s:else>
		<input type="button" onclick="exportExl()" value="整体输出">
		<input type="button" onclick="javascript:document.location='thisLevelList.action'" value="返回">
	</TD>
	</TR>
</TABLE>