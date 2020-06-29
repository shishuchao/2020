<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List,ais.auth.model.AuthUserModule,ais.organization.model.UOrganization"%>
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">

<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="Javascript">
function getSelectedValue()
{
  document.all("paraIds").value=getSelectedValues();//获取数据
  document.all("selectedLoginName").value=window.parent.document.getElementsByName("selectName")[0].value;
  //return false;
  if(mcheck()){
	  document.forms[0].submit();
  }else{
  	return false;
  }
}
function doClose(){
	window.parent.parent.hidePopWin(false);
}

</script>
  </head>
  
  <body >
  <table border=0 cellspacing=1 cellpadding=1 width=95% >
<tr>
<td width=60%>
<td>
<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="保存" onclick="getSelectedValue()"></div>
</td>
<td width=10 nowrap></td>
<td>
<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="doClose()"></div>
</td>
<td width=10 nowrap></td>
<td>						
</td>
</tr>
</table>

<!-- utopia start -->
<SCRIPT type="text/javascript">
	function getArray(id) {
        var array = [];
     array[0] = getCheckArrays(id);
     array[1] = '';
     return array;
 }
 function getCheckArrays(id){
 var str="";
 <s:iterator  value="baseList" status="status">
 str+="<input type='checkbox' pid='"+id+"' id='checkarray_"+<s:property value="id"/>+"' name='checkarray_"+<s:property value="id"/>+"' value='<s:property value="id"/>'>";
 str+="<s:property value="name"/>";
 </s:iterator>
 return str;
 }
</SCRIPT>
<link rel="StyleSheet" href="<%=request.getContextPath()%>/resources/treegrid/ctreetable.css" type="text/css" />
 <script type="text/javascript" src="<%=request.getContextPath()%>/resources/treegrid/ctreetable.js"></script>
<div class="dtreetable">
  <table align="center" width="100%" border="1px solid" cellpadding="0" cellspacing="0">
      <tr class="titlerow">
      		<td width="40%" align="center" nowrap></td>
      		<td width="20%" align="center" nowrap>访 问 范 围</td>
      </tr>
       <script type="text/javascript">
  <!--
  d = new cTreeTable('d',2);
  d.config.rowSelection = true;
  d.config.closeSameLevel = true;
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
			for(j=0;j<marr.length;j++){
				if(marr[j].pid==d.aNodes[num].id&&marr[j].checked==true){
					if(idsStr.substring(idsStr.length-1,idsStr.length)==";"){
						idsStr=idsStr.substring(0,idsStr.length-1);
						idsStr+=",";
						}
					idsStr+=marr[j].value+","
				}
			}
			if(idsStr.substring(idsStr.length-1,idsStr.length)==",")
						idsStr=idsStr.substring(0,idsStr.length-1)+";";
		}
	}
	if(idsStr.substring(idsStr.length-1,idsStr.length)==";")
						idsStr=idsStr.substring(0,idsStr.length-1);
	return 	idsStr;
}
function init(){//用于初始化数据的选中状态
	idsStrs='<%=s.trim()%>';
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
						if("checkarray_"+ids[j]==arrs[m].id){
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
					alert("\""+d.aNodes[marrysT[j].value].name+"\" 没有要保存的数据");
					return false;
				}
			}
		}
	}
	return true;
}

init();//初始化
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
		marrysT[i].onclick=function(){
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
		}
	}
 </script>
   </table>
<!-- utopia end -->
<s:form action="saveTG" namespace="/system">
<!--数据存储位置-->
<input type="hidden" id="paraName" name="paraName" >
<input type="hidden" id="paraIds" name="paraIds" >
<input type="hidden" id="selectedLoginName" name="selectedLoginName">
<s:hidden name="fmoduleId"></s:hidden>
</s:form>
  </body>
</html>