<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center" id="templateInfo">
	<tr class="listtablehead">
	<td colspan="6" align="center" class="edithead">
		&nbsp;导出模板
	</td>
</tr>
<tr>
  <td align="left" class="listtabletr11">模板选择：</td>
  <td align="left" id="tsel" class="listtabletr22">
  </td>
  <td align="left"  class="listtabletr11">
	  <input type="button" value="打印" onclick="printPage()"/>
	  <input type="button" value="直接导出" onclick="exportDirect()"/>
  </td>
</tr>
</table>
<script language="javascript">
var poname="<s:property value="formType"/>";
	var templatesList = "";
	DWREngine.setAsync(false);
	DWRActionUtil.execute(
	{ namespace:'/commons/oaprint', action:'getTemplatesByModuleid', executeResult:'false' }, 
	{'dwrModuleid':poname},
	xxx);
	function xxx(data){
		templatesList = data['templates'];
	} 
	document.getElementById("tsel").innerHTML=templatesList;
	//直接保存到本地
	function exportDirect(){
		var temSel = document.getElementsByName("templatesSel");
		if(temSel){
			if(temSel.length){
				var tid = temSel[0].options[temSel[0].selectedIndex].value;
				if(tid!="notemplate"&&tid!=""){
					var _url = "${contextPath}/commons/oaprint/setTemplateBookMarks.action?tid="+tid+"&dwrModuleid="+poname+"&crudid=<s:property value="crudId"/>";
					window.open(_url);
				}else{
					alert("没有模板可以选择，请定义导出模板！");
				}
			}
		}else{
			alert("没有模板可以选择，请定义导出模板！");
		}
	}
	//直接打开界面，查看后可进行保存至本地，打印等工作
	function printPage(){
		var temSel = document.getElementsByName("templatesSel");
		if(temSel){
			if(temSel.length){
				var tid = temSel[0].options[temSel[0].selectedIndex].value;
				if(tid!="notemplate"&&tid!=""){
					var _url = "${contextPath}/commons/oaprint/setTemplateBookMarks.action?tid="+tid+"&dwrModuleid="+poname+"&crudid=<s:property value="crudId"/>";
					window.open(_url);
				}else{
					alert("没有模板可以选择，请定义导出模板！");
				}
			}
		}else{
			alert("没有模板可以选择，请定义导出模板！");
		}
	}
</script>
