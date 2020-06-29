<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="utf-8"%>

<html>
 <head>
 <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
  <title>exception</title>
 
 </head>
 <body onload="showErr()"> 
<c:set value="${exception}" var="ee"/>
  <jsp:useBean id="ee" type="java.lang.Exception" />
  <div align="center" class="cfblk">
	  <FIELDSET style="width:550"><LEGEND><font color="blue" size="3">系统提示：</font></LEGEND>
	 		<font size="2">
		  <% if(ee instanceof NumberFormatException){out.write("数据类型转换异常 ");}
		  else if(ee instanceof java.sql.SQLException){out.write("数据库异常 ");}
		  else if(ee instanceof NullPointerException){out.write("空值异常 ");} 
		  else{out.write("其它异常 ");}
		  %>
		  
		  <%=ee.getMessage()%><br>
		  </font>
		   <table id="errdiv" align="center" >
		  <tr><td >
		  <textarea cols="60" name="content" rows="20" id="content" >
		  <%ee.printStackTrace( new java.io.PrintWriter(out));%>
		  </textarea>
		  </td></tr></table>
		  <input type="button" id="showbtn" onclick="showErr();"/>
		   <input type="hidden" id="isHidde" value="false"/>
		  <input type="button" id="复制" value="复制" onclick="testcopy()"/>
	</FIELDSET>
</div>
 
  <!-- jsCopy() -->
<script>
 function showErr(){
  var isHidde = document.all.isHidde.value;
  //alert(isHidde);
  if( isHidde == "true" ){
   document.all.errdiv.style.display='';//block
   //document.all.errdiv.style.visibility='visible';
   document.all.isHidde.value= 'false';
   document.all.showbtn.value="隐藏错误信息";
  }else{
   document.all.errdiv.style.display='none';
   //document.all.errdiv.style.visibility='hidden';
   document.all.isHidde.value= 'true';
   document.all.showbtn.value="显示错误信息";
  }
 }
</script>
<script type="text/javascript">
    function jsCopy(){ 
        var e=document.getElementById("content");//对象是content  
        //alert(e);
        e.select(); //选择对象  
        document.execCommand("Copy"); //执行浏览器复制命令  
    }  
    function testcopy(){
    	var isHidde = document.all.isHidde.value;
     	if(isHidde=="true"){
     		isHidde="false";
     		showErr();
     		jsCopy();
     		document.all.isHidde.value="true";
     		 document.all.errdiv.style.display='none';
  			document.all.showbtn.value="显示错误信息";
     	}else{
			 jsCopy();    	
     	}
    }
</script> 
 </body>
</html>

