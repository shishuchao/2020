<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List,ais.auth.model.AuthUserModule,ais.organization.model.UOrganization"%>
<!DOCTYPE HTML >
<html>
  <head>
 	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
	 <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
	<script language="Javascript">
function getSelectedValue()
{	
  document.all("paraIds").value=getSelectedValues();//获取数据
  document.all("selectedLoginName").value=window.parent.document.getElementsByName("selectName")[0].value;
	  document.forms[0].submit();
}
function doClose(){
window.parent.close();
	//window.parent.parent.hidePopWin(false);
}
function allSelected(){// 所有的复选框都被选中
	configtree.CheckAllNodes();
}
function allNoSelected(){
	configtree.CancelAllNodes();
};
</script>
</head>
<body style='margin:0px;padding:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
<s:if test="${empty(view) or (user.floginname=='admin' and empty(view))}">
	<div region='north' border='0' style='border-bottom:1px solid #CCCCCC;padding:5px;'>
		<span style="margin-left:5px;">
			<a id="select" onclick="getSelectedValue()" class="easyui-linkbutton" iconCls="icon-save">保存</a>
			<a id="oneSelect" onclick="allSelected()" class="easyui-linkbutton" iconCls="icon-ok">全选</a>
			<a id="oneSelect2" onclick="allNoSelected()" class="easyui-linkbutton" iconCls="icon-cancel">全不选</a>
		</span>	
	</div>
</s:if>
  <!-- ******* -->
<div region='center' border='0'>	
<s:form action="saveToAuthUserModule" namespace="/system">
<!--数据存储位置-->
<input type="hidden" id="paraName" name="paraName">
<input type="hidden" id="paraIds" name="paraIds">
<input type="hidden" id="companyId" name="companyId" value="${companyId}">
<input type="hidden" id="selectedLoginName" name="selectedLoginName">
<s:hidden name="fmoduleId"></s:hidden>
</s:form>
<!-- start -->
<link rel="StyleSheet" href="<%=request.getContextPath()%>/resources/ctreetable/ctreetable.css" type="text/css" />
 <script type="text/javascript" src="<%=request.getContextPath()%>/resources/ctreetable/ctreetable.js"></script>
<div class="ctreetable" style='padding:10px;'>

  <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">

       <script type="text/javascript">
  <!--
  var isinit=true;
  d = new cTreeTable('d',1);
  d.config.useSelection = true;
  d.config.rowSelection = true;
  d.config.useChecks = true;
  d.config.folderChecks = true;
  d.config.checkSubs = true;
  d.config.validLevel = 0;
  d.config.stepDepth = 0;
  d.config.checkSubs=false;
  d.config.iconPath = '<%=request.getContextPath()%>/resources/ctreetable/tree';
  <%
  	 List orgList=(List)request.getAttribute("orgList");
 	 List aumList=(List)request.getAttribute("aumList");
 	 UOrganization org;
 	 for(int i=0;i<orgList.size();i++){
 	 	org=(UOrganization)orgList.get(i);
 	 	String checked="false";
 	 	for(int j=0;j<aumList.size();j++){
 	 		if(aumList.get(j)!=null){
 	 			String id=((AuthUserModule)aumList.get(j)).getFvalue();
 	 			if(id.equals(org.getFid().toString())){
 	 				checked="true";
  					break;
 	 			}
 	 		}
 	 	}
  %>
  d.add('<%=org.getFid()%>','<%=org.getFpid()%>','<%=org.getFname()%>',null,<%=checked%>);
  <%
  		 }
  %>
  document.write(d);
  //-->
  function getSelectedValues(){//获取被选中的id,形式为"a,b,c;a,b;a"
	var marrys=document.getElementsByTagName('input');
	var mm=[];
	var ids=[];
	var idsStr="";
	var num=0;
	for(i=0;i<marrys.length;i++){
		if(marrys[i].id.indexOf("kd")!=-1){
			mm[mm.length]=marrys[i];
		}
	}
	for(i=0;i<mm.length;i++){
		if(mm[i].checked==true){
			num=mm[i].value;
			var n=ids.length;
			ids[ids.length]=d.aNodes[num].id;
			idsStr+=d.aNodes[num].id+",";
		}
	}
	if(idsStr.substring(idsStr.length-1,idsStr.length)==",")
						idsStr=idsStr.substring(0,idsStr.length-1);
	return 	idsStr;
}

function init(){//用于初始化数据的选中状态
	idsStrs='<s:property value="paraIds"/>';
	if(idsStrs!=null&&idsStrs!="null"&&idsStrs!=""&&idsStrs.length!=0){
		idsArray=idsStrs.split(";");
		var marr=document.getElementsByTagName('input');
		var arrs=[];
		for(i=0;i<marr.length;i++){
			if(marr[i].id.indexOf("checkarray_")!=-1){
				arrs[arrs.length]=marr[i];
			}
		}
		for(i=0;i<idsArray.length;i++){
			ids=idsArray[i].split(",");
			for(j=1;j<ids.length;j++){
				for(m=0;m<arrs.length;m++){
					if(ids[0]==arrs[m].pid){
						//if("checkarray_"+ids[j]==arrs[m].id){
						if(ids[j]==arrs[m].value){
							arrs[m].checked=true;
						}	
					}
				}
			}
		}
	}
	
	//return 	idsStr;
}
function findPrefixTags(index){//获取所有tree的checkbox id 形式为" a;a;a"
	var marrys=document.getElementsByTagName('input');
	var idsStr="";
	var mm=[];
	for(i=0;i<marrys.length;i++){
		if(marrys[i].id.indexOf(index)!=-1){
			mm[mm.length]=marrys[i];
			//idsStr+=d.aNodes[marrys[i].value].id+";";
		}
	}
	//idsStr=idsStr.substring(0,idsStr.lastIndexOf(";"));
	return mm;
}
function mcheck(){	//判断子checkbox数组为空时,发出提示
	var sss=document.getElementsByName('paraIds')[0].value;
	if(sss==null||sss=="") return true;
	ss=sss.split(";");
	for(i=0;i<ss.length;i++){
		if(ss[i].split(",").length==1){
			for(j=0;j<marrysT.length;j++){
				if(d.aNodes[marrysT[j].value].id==ss[i]){
					alert("\""+d.aNodes[marrysT[j].value].name+"\" 的数据类别没有选取.\r\n不能保存.");
					return false;
				}
			}
		}
	}
	return true;
}

init();//初始化
<s:if test="${not empty(view) and user.floginname!='admin'}">
function chgAllDisabled(){//设置所有的复选框变灰
	var marrys=document.getElementsByTagName('input');
	for(var i=0;i<marrys.length;i++){
		marrys[i].disabled=true;
	}
}
chgAllDisabled();
</s:if>
function allSelected(){// 所有的复选框都被选中
	var alltags=document.getElementsByTagName('input');
	for(i=0;i<alltags.length;i++){
		if(alltags[i].id.indexOf('kd')!=-1){
			alltags[i].checked=true;
		}
	}
}
function allNoSelected(){//所有的复选框取消
	var alltags=document.getElementsByTagName('input');
	for(i=0;i<alltags.length;i++){
		if(alltags[i].id.indexOf('kd')!=-1){
			alltags[i].checked=false;
		}
	}
}
 </script>
 </table>
 </div>
<!-- end -->
</div>

  </body>
</html>