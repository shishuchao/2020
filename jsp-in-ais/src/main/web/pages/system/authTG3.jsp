<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List,ais.auth.model.AuthUserModule,ais.organization.model.UOrganization"%>
<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
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
   //alert("检查通过");alert(document.getElementById("paraIds").value);return false;
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
		if(alltags[i].id.indexOf('kd')==0){
			alltags[i].checked=true;
		}
	}
}
function allNoSelected(){//所有的复选框取消
	var alltags=document.getElementsByTagName('input');
	for(i=0;i<alltags.length;i++){
		if(alltags[i].id.indexOf('kd')==0){
			alltags[i].checked=false;
		}
	}
}
</script>
  </head>
  
  <body >
  <s:if test="${empty(view) or user.floginname=='admin'}">
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
	<div id="oneSelect" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="全选" onclick="allSelected();"></div>
	</td>
	<td>
	<div id="oneSelect2" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="反选" onclick="allNoSelected();"></div>
	</td>
</tr>
</table>
</s:if>
<!-- utopia start -->
<SCRIPT type="text/javascript">
	function getArray(id) {
        var array = [];
     array[0] = getCheckArrays(id);
     array[1] = getCheckArrays_2(id);
     return array;
 }
 function getCheckArrays(id){
	 var str="";//onMouseOver='sh(this)' onMouseOut='hd(this)'
	 str+="<div  onClick='sd(this)'>"
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
 function getCheckArrays_2(id){
	 var str="";
	 <s:iterator  value="baseList2" status="status">
	 str+="<input type='checkbox' pid='"+id+"' id='checkarray2_<s:property value="code"/>' name='checkarray2_<s:property value="code"/>' value='<s:property value="code"/>'>";
	 str+="<s:property value="name"/>";
	 </s:iterator>
	 return str;
 }
 function sh(obj){obj.getElementsByTagName('div')[0].style.display="block";}
 function hd(obj){obj.getElementsByTagName('div')[0].style.display="none";}
 function sd(obj){if(window.event.srcElement.getAttribute('tagName')=='INPUT'){return;}var style=obj.getElementsByTagName('div')[0].style;if(style.display=='block'){style.display='none';}else{style.display='block';}}
</SCRIPT>
<link rel="StyleSheet" href="<%=request.getContextPath()%>/resources/ctreetable/ctreetable.css" type="text/css" />
 <script type="text/javascript" src="<%=request.getContextPath()%>/resources/ctreetable/ctreetable.js"></script>
<div class="ctreetable">
  <table align="center" width="100%" border="1px solid" cellpadding="0" cellspacing="0">
      <tr>
      		<td width="40%" align="center" nowrap>组织机构</td>
      		<td width="30%" align="center" nowrap>项目类别</td>
      		<td width="30%" align="center" nowrap>数据类别</td>
      </tr>
       <script type="text/javascript">
  <!--
  var isinit=true;
  d = new cTreeTable('d',3);
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
		if(marrys[i].id.indexOf("kd")==0){
			mm[mm.length]=marrys[i];
		}
	}
	for(i=0;i<mm.length;i++){
		if(mm[i].checked==true){
			num=mm[i].value;
			var n=ids.length;
			ids[ids.length]=d.aNodes[num].id;
			idsStr+=d.aNodes[num].id+"#";
			var nodeTmp=mm[i].parentNode.nextSibling;
			
			var marr=nodeTmp.getElementsByTagName('input');
			for(j=0;j<marr.length;j++){
				if(marr[j].checked==true){
					idsStr+=marr[j].value+","
				}
			}
			if(idsStr.substring(idsStr.length-1,idsStr.length)==",")
						idsStr=idsStr.substring(0,idsStr.length-1)+"#";
			else
				idsStr+="#";
			marr=nodeTmp.nextSibling.getElementsByTagName('input');
			for(j=0;j<marr.length;j++){
				if(marr[j].checked==true){
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
	idsStrs='<s:property value="paraIds"/>';
	if(idsStrs!=null&&idsStrs!="null"&&idsStrs!=""&&idsStrs.length!=0){
		idsArray=idsStrs.split(";");
		var marr=document.getElementsByTagName('input');
		var arrs=[];
		var arrs2=[];
		for(i=0;i<marr.length;i++){
			if(marr[i].id.indexOf("checkarray_")==0){
				arrs[arrs.length]=marr[i];
				continue;
			}
			if(marr[i].id.indexOf("checkarray2_")==0){
				arrs2[arrs2.length]=marr[i];
			}
		}
		
		for(i=0;i<idsArray.length;i++){
			var a2=idsArray[i].split("#");
			//ids=a2[0].split(",");
			var pid=a2[0];
			d.addCheckedId(pid);
			ids=a2[1].split(",");
			for(j=0;j<ids.length;j++){
				for(m=0;m<arrs.length;m++){
					if(pid==arrs[m].pid){
						//if("checkarray_"+ids[j]==arrs[m].id){
						if(ids[j]==arrs[m].value){
							arrs[m].checked=true;
						}	
					}
				}
			}
			ids=a2[2].split(",");
			for(j=0;j<ids.length;j++){
				for(m=0;m<arrs2.length;m++){
					if(pid==arrs2[m].pid){
						if(ids[j]==arrs2[m].value){
							arrs2[m].checked=true;
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
		s3=ss[i].split("#");
		if(!s3[1]||s3[1].split(",").length==0){
			for(j=0;j<marrysT.length;j++){
				if(d.aNodes[marrysT[j].value].id==s3[0]){
					alert("\""+d.aNodes[marrysT[j].value].name+"\" 的项目类别没有选取.\r\n不能保存.");
					return false;
				}
			}
		}
		if(!s3[2]||s3[2].length==0){
			alert("\""+d.aNodes[marrysT[j].value].name+"\" 的数据类别没有选取.\r\n不能保存.");
			return false;
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
	var mcharrys2=[];
	for(i=0;i<doms.length;i++){
		if(doms[i].id.indexOf("kd")==0){
			marrysT[marrysT.length]=doms[i];
			continue;
		}
		if(doms[i].id.indexOf("checkarray_")==0){
			mcharrys[mcharrys.length]=doms[i];
			continue;
		}
		if(doms[i].id.indexOf("checkarray2_")==0){
			mcharrys2[mcharrys2.length]=doms[i];
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
					for(j=0;j<mcharrys2.length;j++){
						mvar=d.aNodes[this.value].id;
						if(mcharrys2[j].pid==mvar){
							mcharrys2[j].checked=true;
						}
					}
				}else{
					for(j=0;j<mcharrys.length;j++){
						mvar=d.aNodes[this.value].id;
						if(mcharrys[j].pid==mvar){
							mcharrys[j].checked=false;
						}
					}
					for(j=0;j<mcharrys2.length;j++){
						mvar=d.aNodes[this.value].id;
						if(mcharrys2[j].pid==mvar){
							mcharrys2[j].checked=false;
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
  </body>
</html>