<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List,ais.auth.model.AuthUserModule,ais.organization.model.UOrganization"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">

	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="Javascript">
function getSelectedValue()
{
  document.all("paraIds").value=getSelectedValues();//获取数据
  document.all("selectedLoginName").value='${param.selectedLoginName}';
  //return false;
  if(mcheck()){
	  document.forms[0].submit();
  }else{
  	return false;
  }
}
function doClose(){
	window.parent.close();
	//window.parent.parent.hidePopWin(false);
}
function allSelected(){// 所有的复选框都被选中
	var alltags=document.getElementsByTagName('input');
	for(i=0;i<alltags.length;i++){
//		if(alltags[i].id.indexOf('kd')!=-1){
			alltags[i].checked=true;
//		}
	}
}
function allNoSelected(){//所有的复选框取消
	var alltags=document.getElementsByTagName('input');
	for(i=0;i<alltags.length;i++){
//		if(alltags[i].id.indexOf('kd')!=-1){
			alltags[i].checked=false;
//		}
	}
}
</script>
  </head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
 <s:if test="${empty(view) or (user.floginname=='admin' and empty(view))}">
	 <div region='north' border='0' style='border-bottom:1px solid #CCCCCC;padding:5px;'>
		  <a id="select" onclick="getSelectedValue()" class="easyui-linkbutton" iconCls="icon-save">保存</a>
		  <a id="oneSelect" onclick="allSelected()" class="easyui-linkbutton" iconCls="icon-ok">全选</a>
		  <a id="oneSelect2" onclick="allNoSelected()" class="easyui-linkbutton" iconCls="icon-cancel">全不选</a>
	  </div>
 </s:if>
 <div region='center' border='0'>	
<!-- utopia start -->
<SCRIPT type="text/javascript">
	function getArray(id) {
        var array = [];
     array[0] = getCheckArrays_1(id);
     array[1] = '';
     return array;
 }
 function getCheckArrays(id){
 var str="";
 <s:iterator  value="baseList" status="status">
 str+="<input type='checkbox' pid='"+id+"' id='checkarray_<s:property value="code"/>' name='checkarray_<s:property value="code"/>' value='<s:property value="code"/>'>";
 str+="<s:property value="name"/>";
 </s:iterator>
 return str;
 }
 function getCheckArrays_1(id){
	 var str="";//onMouseOver='sh(this)' onMouseOut='hd(this)'
	 str+="<div  onClick='sd(this)' style='background-image:url(/ais/images/plusnew.gif);background-position: top right; background-repeat: no-repeat;'>"
	 <s:iterator  value="baseList" status="status">
	 <s:if test="#status.index==1">
	 str+="<div style='display: none;'>";
	 </s:if>
	 str+="<input type='checkbox' pid='"+id+"' id='checkarray_<s:property value="code"/>' name='checkarray_<s:property value="code"/>' value='<s:property value="code"/>'>";
	 str+="<s:property value="name"/><br>";
	 </s:iterator>
	 str+="</div>";
	 str+="</div>";
	 return str;
 }
 function sd(obj){
	 if(window.event.srcElement.nodeName=='INPUT')
	 {
		 return;
	 }
 	var style=obj.getElementsByTagName('div')[0].style;
 	if(style.display=='block'){style.display='none';obj.style.backgroundImage='url(/ais/images/plusnew.gif)';
	} else{
		style.display='block';
		obj.style.backgroundImage='url(/ais/images/minusnew.gif)';
	}
 }
</SCRIPT>
<link rel="StyleSheet" href="<%=request.getContextPath()%>/resources/ctreetable/ctreetable.css" type="text/css" />
 <script type="text/javascript" src="<%=request.getContextPath()%>/resources/ctreetable/ctreetable.js"></script>
<div class="ctreetable">
  <table class='tabletree' align="center" width="100%" style='border-collapse:collapse;'>
      <tr>
      		<td width="40%"  nowrap class='EditHead' style='border:0px solid #cccccc;border-top-width:0px !important;text-align:center;'>组织机构</td>
      		<td width="60%"  nowrap class='EditHead' style='border:0px solid #cccccc;border-top-width:0px !important;text-align:center;'>项目类别</td>
      </tr>
       <script type="text/javascript">
  <!--
  var isinit=true;
  d = new cTreeTable('d',2);
  d.config.useSelection = true;
  d.config.rowSelection = true;
  d.config.closeSameLevel = true;
  d.config.useChecks = true;
  d.config.folderChecks = true;
  d.config.checkSubs = true;
  d.config.validLevel = 0;
  d.config.stepDepth = 0;
  d.config.checkSubs=false;
  d.config.iconPath = '<%=request.getContextPath()%>/resources/ctreetable/tree';
  <%
  	List orgList=(List)request.getAttribute("orgList");
  	//int num=((Integer)request.getAttribute("orgRootId")).intValue();
 	 List aumList=(List)request.getAttribute("aumList");
 	 UOrganization org;
 	 StringBuffer idsStrs=new StringBuffer();
 	 boolean bool=true;
 	 for(int i=0;i<orgList.size();i++){
 	 	org=(UOrganization)orgList.get(i);
 	 	String checked="false";
 	 	for(int j=0;j<aumList.size();j++){
 	 		if(aumList.get(j)!=null){
 	 			String arrayStr=((AuthUserModule)aumList.get(j)).getFvalue();
 	 			if(bool)idsStrs.append(arrayStr).append(";");
 	 			
 	 			String id=arrayStr.split(",")[0];
 	 			if(id.equals(org.getFid().toString())){
 	 				checked="true";
  					break;
 	 			}
 	 		}
 	 	}
 	 	bool=false;
  %>
  d.add('<%=org.getFid()%>','<%=org.getFpid()%>','<%=org.getFname()%>',getArray('<%=org.getFid()%>'),<%=checked%>);
  <%
  		 }
  		String s=idsStrs.toString();
  		if(s!=null&&!s.equals("")) 
  			s=s.substring(0,s.length()-1);
  		else
  			s="null";
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
			idsStr+=d.aNodes[num].id+";";
			var marr=document.getElementsByTagName('input');
			$('input[type=checkbox]').each(function(){
				if($(this).attr('pid')==d.aNodes[num].id&&$(this).attr('checked')=='checked'){
					if(idsStr.substring(idsStr.length-1,idsStr.length)==";"){
						idsStr=idsStr.substring(0,idsStr.length-1);
						idsStr+=",";
					}
					idsStr+=$(this).val()+","
				}
			});
//			for(j=0;j<marr.length;j++){
//				if(marr[j].pid==d.aNodes[num].id&&marr[j].checked==true){
//					if(idsStr.substring(idsStr.length-1,idsStr.length)==";"){
//						idsStr=idsStr.substring(0,idsStr.length-1);
//						idsStr+=",";
//						}
//					idsStr+=marr[j].value+","
//				}
//			}
			if(idsStr.substring(idsStr.length-1,idsStr.length)==",")
						idsStr=idsStr.substring(0,idsStr.length-1)+";";
		}
	}
	if(idsStr.substring(idsStr.length-1,idsStr.length)==";")
						idsStr=idsStr.substring(0,idsStr.length-1);
	return 	idsStr;
}

function init(){//用于初始化数据的选中状态
	idsStrs='<s:property value="paraIds"/>';
	if(idsStrs!=null&&idsStrs!="null"&&idsStrs!=""&&idsStrs.length!=0){
		idsArray=idsStrs.split(";");
		var marr=document.getElementsByTagName('input');
		var arrs=[];
//		for(i=0;i<marr.length;i++){
//			if(marr[i].id.indexOf("checkarray_")!=-1){
//				arrs[arrs.length]=marr[i];
//			}
//		}
		for(i=0;i<idsArray.length;i++){
			ids=idsArray[i].split(",");
			for(j=1;j<ids.length;j++){
				$('input[type=checkbox]').each(function(){
					if(ids[0]==$(this).attr('pid')){
						//if("checkarray_"+ids[j]==arrs[m].id){
						if(ids[j]==$(this).val()){
							$(this).attr('checked','checked');
						}
					}
				});
//				for(m=0;m<arrs.length;m++){
//
//				}
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
					alert("\""+d.aNodes[marrysT[j].value].name+"\" 的项目类别没有选取.\r\n不能保存.");
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
 </script>
 <script>
 //点击一个其它的全部选择
 doms=document.getElementsByTagName('input');
	var marrysT=[];
	var mcharrys=[];
	for(i=0;i<doms.length;i++){
		if(doms[i].id.indexOf("kd")!=-1){
			marrysT[marrysT.length]=doms[i];
		}
		if(doms[i].id.indexOf("checkarray_")!=-1){
			mcharrys[mcharrys.length]=doms[i];
		}
	}
	for(i=0;i<marrysT.length;i++){
		marrysT[i].onpropertychange=function(){
			if(!isinit){//add wp
			
				if(this.checked==true){
					for(j=0;j<mcharrys.length;j++){
						mvar=d.aNodes[this.value].id;
						if(mcharrys[j].pid==mvar){
							mcharrys[j].checked=true;
						}
					}
				}else{
					for(j=0;j<mcharrys.length;j++){
						mvar=d.aNodes[this.value].id;
						if(mcharrys[j].pid==mvar){
							mcharrys[j].checked=false;
						}
					}
				}
			}//add wp
		}
		
	}
isinit=false;
 </script>
   </table>
  </div>
<!-- utopia end -->
<s:form action="saveTG" namespace="/system">
<!--数据存储位置-->
<input type="hidden" id="paraName" name="paraName" >
<%--<input type="hidden" id="paraIds" name="paraIds" >--%>
<s:hidden name="paraIds" id="paraIds"></s:hidden>
<%--<input type="hidden" id="selectedLoginName" name="selectedLoginName">--%>
<s:hidden name="selectedLoginName" id="selectedLoginName"></s:hidden>
<s:hidden name="fmoduleId" id="fmoduleId"></s:hidden>
<s:hidden name="companyId" id="companyId" value="${companyId}"></s:hidden>
<s:hidden name="fscopecode" id="fscopecode" value="${fscopecode}"></s:hidden>
</s:form>
</div>
</body>
</html>