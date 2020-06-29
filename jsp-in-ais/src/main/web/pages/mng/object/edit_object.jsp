<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<s:if test="theObject.id==0">
	<s:text id="title" name="'添加对象'"></s:text>
</s:if>
<s:else>
    <s:text id="title" name="'修改对象'"></s:text>
</s:else>
<html>
<head><title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<center>
<STYLE>
.tb_on {
	BACKGROUND-POSITION: center left; BACKGROUND-IMAGE: url(${contextPath}/images/on.gif); CURSOR: hand; COLOR: #993400; LINE-HEIGHT: 14px; BACKGROUND-REPEAT: no-repeat
}
.tb_off {
	BACKGROUND-POSITION: center left; BACKGROUND-IMAGE: url(${contextPath}/images/off.gif); CURSOR: hand; COLOR: #666666; LINE-HEIGHT: 14px; BACKGROUND-REPEAT: no-repeat
}
</STYLE>
</STYLE>

<TABLE height=19 cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR vAlign=bottom>
    <TD class=tb_on id=20060000000000001 align=middle width=100><B><a target="_parent" href="javascript:void(0);">稽查准备</a></B></TD>
    <TD width=1></TD>
    <TD class=tb_off id=20060000000000002 align=middle width=110><B><a target="_parent" href="javascript:void(0);">稽查实施</a></B></TD>
    <TD width=1></TD>
    <TD class=tb_off id=20060000000000003 align=middle width=100><B><a target="_parent" href="javascript:void(0);">稽查终结</a></B></TD>
    </TR>
    </TBODY>
</TABLE>
<SCRIPT>
	//document.getElementById("20060000000000001").className = "tb_off";
	//document.getElementById("20060000000000002").className = "tb_off";
	//document.getElementById("20060000000000003").className = "tb_off";
</SCRIPT>
<h1><s:property value="#title"/></h1>
<s:form action="save">
<!--s:select label="城市" name="theObject.objectName"
       list="@ais.basic.BasicUtil@getCity()"
       listKey="code"
       listValue="name"
-->>
<s:textfield label="%{theObject.objectName}%{'地址'}" name="theObject.objectName"/>
<s:textfield label="%{theObject.objectAddress}%{'地址'}" name="theObject.objectAddress"/>

<s:datetimepicker label="注册日期" name="theObject.registerDate"/>

<s:hidden name="theObject.id"/>  
<s:submit value="保存"/>
 </s:form>
<input type="button" name="back" value="返回" onclick="javascript:window.location='<s:url action="list"></s:url>'">
</center>
</body>
</html>