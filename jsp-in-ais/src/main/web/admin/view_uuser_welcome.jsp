<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
    

<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

<title>组织机构设置</title>
<script language="javascript" type="text/javascript" src="../css/normal.js"></script>
<link href="../css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">

function RightGo(id,type)
{  //id 表示时哪一个部门或者公司的
	 //alert(url);
	 //if(type=='C')
 		parent.maintest.location.href='viewlistUUser.action?fdepid='+id;
 	
 }
 function getCheck(){
 	//alert(configtree.GetSelected());
	//alert(configtree.GetSelected().length-1);
	 s=configtree.GetSelected();
	//alert(s.substring(0,s.length-1));
//	menuForm.fpid.value=s.substring(0,s.length-1);
 }
 
 function addTypett(s){
 id=document.all("paranamevalue").value;
 //alert(id);
 	menuForm.m_type.value=s;
 	 alert(menuForm.m_type.value);
 	
 	menuForm.target=parent.maintest;
 	menuForm.submit();
 	
 }
 function getSelectedValue(id,name)
{
  document.all("paranamevalue").value=name;
  document.all("paraidvalue").value=id;
}
</script>

</head>
<body>
<s:form id="menuForm" action="" namespace="/admin" >


<div class="TreeView" id="configtree" onclick="getCheck();" Checkbox="0" SelectedColor="#FFFF00">


<s:iterator value="uOrgList">
   <p  title="<s:property value="fname"/>" sid="<s:property value="fid"/>" pid="<s:property value="fpid"/>" click="RightGo('<s:property value="fid"/>','<s:property value="ftype"/>')"></p>
</s:iterator>




</div>
</s:form>
</body>
</html>
