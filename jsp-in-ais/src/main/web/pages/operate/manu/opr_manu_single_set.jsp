
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="ais.framework.util.MyProperty"%>
<s:text id="title" name="'审计底稿反馈意见设置'"></s:text>
<html>
	<head>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/main/manu.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>

		<SCRIPT language="JavaScript">
<!--全局变量
//标志位,值为false代表未打开一个编辑框,值为true为已经打开一个编辑框开始编辑
var editer_table_cell_tag = false;
//开启编辑功能标志,值为true时为允许编辑
var run_edit_flag = true;
var run_edit_all = "";
//-->
</SCRIPT>

		<SCRIPT language="JavaScript">
/**
 * 编辑表格函数
 * 单击某个单元格可以对里面的内容进行自由编辑
 * @para tableID 为要编辑的table的id
 * @para noEdiID 为不要编辑的td的ID,比如说table的标题
 * 可以写为<TD id="no_editer">自由编辑表格</TD>
 * 此时该td不可编辑
 */
function editerTableCell(tableId,noEdiId)
{
 
}

/**
 * 确定修改
 */
function certainEdit()
{
	var bObject = event.srcElement;
	
	var tdObject = bObject.parentNode;	
	var txtObject = tdObject.firstChild;
	if(noblank(txtObject)){
	}else{
	return false;
	}
	tdObject.innerHTML = txtObject.value;
 
	//代表编辑框已经关闭
	editer_table_cell_tag = false;
	//修改按钮提示信息
	//editTip.innerText = "请单击某个单元格进行编辑!";
}

function enterToTab()
{
    if(event.srcElement.type != 'button' && event.srcElement.type != 'textarea'
       && event.keyCode == 13)
    {
        event.keyCode = 9;
    }
}

/**
 * 控制是否编辑
 */
function editStart()
{
	if(editer_table_cell_tag == false){
	 
		
	}else{
		alert("请先点'确定'按钮,确定修改的内容!");
		return false;
	}
	 
	 
	if(event.srcElement.value == "开始编辑")
	{
		 if(run_edit_flag==true){
			  alert("一次只能编辑一个表格!请先点'编辑完成'按钮");
				return false;
		  }else{
			  
		  }
		
		event.srcElement.value = "编辑完成";
		run_edit_flag = true;
		// fff();
	}
	else
	{
		//如果当前没有编辑框,则编辑成功,否则,无法提交
		//必须按确定按钮后才能正常提交
		if(editer_table_cell_tag == false)
		{
			alert("编辑成功结束!请点页面下方的保存按钮保存数据!");
			event.srcElement.value = "开始编辑"; 
			run_edit_flag = false;

			var t=document.getElementById('subModelHTML');
			document.getElementById('audManuscript.subModelHTML').value=t.innerHTML;
			

		}else{
			alert("请先点'确定'按钮,确定修改的内容!");
			return false;
		}
	}
}

/**
 * 根据不同的按钮提供不同的提示信息
 */
function showTip()
{
	if(event.srcElement.value == "编辑完成")
	{
		editTip.style.top = event.y + 15;
		editTip.style.left = event.x + 12;
		editTip.style.visibility = "visible";		
	}
	else
	{
		editTip.style.visibility = "hidden";			
	}	
}

  function taizhangView(){
 
    var ms_code= '${crudObject.formId}';
    var pro_code= '${crudObject.pro_id}';
    window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id="+pro_code+"&manuscript_id="+ms_code+"&isView=true","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
    }
</SCRIPT>

		<script type="text/javascript">
		function noblank(txtObject){

	           if(txtObject.value=="")
		           {
				         window.alert("不能为空值!");
				         return false;
		           }
                 
                   if(txtObject.value.replace(/\s+$|^\s+/g,"")=="null"){
                        window.alert("不能输入'null'!");
				         return false;
                   }
                   
                   if(txtObject.value.replace(/\s+$|^\s+/g,"")=="NULL"){
                        window.alert("不能输入'NULL'!");
				         return false;
                   }
                   if(txtObject.value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert("不能为空值!");
				         return false;
                   }
                   return true;

}	
			 function deleteCell()
			 { 
			 	var flag=true;
			 	if(editer_table_cell_tag == false)
						{
							

						}else{
							alert("请先点'确定'按钮,确定修改的内容!");
							return false;
						}
				// if(run_edit_flag == true){
					 
			 	   var tdObject = event.srcElement;
			 	 	var tpObject = ((tdObject.parentNode).parentNode).parentNode;	
			 	 	//var nodes = ((tpObject.parentNode.lastChild.lastChild.childNodes));
			 	 	


			 	 	// for (var i=0; i<nodes.length; i+=1) {
		             //      var tpObject1 = (nodes[i]);	
		            //        var abc=tpObject1.innerHTML ;
		            //        if(abc.indexOf("编辑完成")!=-1){
			        //            flag=true;
			        //            break;

		            //        }
					  
					 	   
		            //      }
	                  if(flag){

	                		 if(confirm("确认删除本行的数据吗?")){
	                		// fff();
	            			  var tpObject2 = ((tdObject.parentNode).parentNode);
	            			 	  	tpObject.removeChild(tpObject2);
	            			 	
	            			 	  }else{
	            			 	  	
	            			 	  }
		                  
	                  }else{ 
		                  alert("一次只能编辑一个表格!请先点本表格'开始编辑'按钮");
		                  return false;
	                  }
 
			 	//}else{
			 	//	alert("请先点本表格的'开始编辑'按钮!");
			 	//}
			 }	 	
			 	  function fff()
			 { 
			 	 //alert("");
			 	 //alert("您可以开始编辑数据了!");
			 	// var tdObject = event.srcElement;
			 	 	//var tpObject = ((((tdObject.parentNode).parentNode).parentNode).parentNode).parentNode;	
			 	 	//var ss = tpObject.innerHTML;
			 	 	
			 	 	var t=document.getElementById('subModelHTML');
			 
			 	 	 run_edit_all = t.innerHTML;
	 //document.getElementById("mydiv1").location.reload();
			 	
			 	  }
			 	  
			 function editReset()
			 { 
			 	 

			 

					 if(editer_table_cell_tag == false)
						{
							

						}else{
							alert("请先点'确定'按钮,确定修改的内容!");
							return false;
						}
					 	
			 	 		if(confirm("确认重置审计记录的数据吗?")){
					 		//var tdObject = event.srcElement;
					 	 	//var tpObject = ((((tdObject.parentNode).parentNode).parentNode).parentNode).parentNode;	
					  
					 	 	//tpObject.innerHTML = run_edit_all;
					 	 	var t=document.getElementById('subModelHTML');
					 	 	
			               t.innerHTML=document.getElementById('crudObject.subModelHTML').value;
					 	
					 	  }else{
					 	  	
					 	  }
					  
			 	
			 	  }
			 	  
			 	  function deleteCellAll()
			 { 
			 



			 		var flag=true;
			 		if(editer_table_cell_tag == false)
						{
							

						}else{
							alert("请先点'确定'按钮,确定修改的内容!");
							return false;
						}
					 //if(run_edit_flag == true){
						 
					 	 var tdObject = event.srcElement;
					 	 var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;		
				 	 	var nodes = ((tpObject.parentNode.lastChild.lastChild.lastChild.childNodes));

				 	 	// for (var i=0; i<nodes.length; i+=1) {
			             //      var tpObject1 = (nodes[i]);	
			                  // alert(tpObject1.id);
			              //      if(abc.indexOf("编辑完成")!=-1){
				           //         flag=true;
				         //          break;

			               //     }
						  
						 	   
			               //   }
		                  if(flag){

		                		 if(confirm("确认清空本表格的数据吗?")){
		                			 var ulListChild = tpObject.childNodes;
		   		                  for (var i=0; i<ulListChild.length; i+=1) {
		   		                   var tpObject = (ulListChild[i]);	
		   		                     var dd = tpObject.firstChild;
		   					// alert(tpObject.value );
		   					if(dd!=null){
		   					
		   					 	tpObject.removeChild(dd); 
		   					 	}   
		   		                  }
		            			 	
		            			 	  }else{
		            			 	  	
		            			 	  }
			                  
		                 // }else{ 
			              //    alert("一次只能编辑一个表格!请先点本表格'开始编辑'按钮");
			              //    return false;
		                  //}
	 
				 	//}else{
				 	//	alert("请先点本表格的'开始编辑'按钮!");
				 	//}
	

   }
  
	}		 
 </script>
		<script lang="javascript">
	   function go2(s){
	    
	      window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    
	     function go1(s){
	    
	    window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${crudObject.project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    
	    
		function Test(){
      
        
        
        var code3=document.getElementsByName("crudObject.audit_found")[0].value; 
        
        
        var code4=document.getElementsByName("crudObject.audit_matter")[0].value; 
       
      
        var codeArray3=code3.split(',');
        var codeArray4=code4.split(',');
         //alert(codeArray1[0]);
        var tt1='';
         var tt2='';
          var tt3='';
           var tt4='';
            var tt5='';
        var strName1='关联备忘';
         var strName2='关联疑点';
          var strName4='关联重大事项';
           var strName3='关联疑点';
           var strName5='关联底稿';
       
        if(codeArray3[0]!=null&&codeArray3[0]!=''){
          tt3='<a href=# onclick=go2(\"'+codeArray3[0]+'\")>'+codeArray3[1]+'</a>';
          tt3=tt3+"<br />";
        }
        if(codeArray4[0]!=null&&codeArray4[0]!=''){
          tt4='<a href=# onclick=go2(\"'+codeArray4[0]+'\")>'+strName4+'</a>';
          tt4=tt4+"<br />";
        }
    
 p1.innerHTML= tt3+tt4 ;
}

		function manu(){
      
        
        
        var code3=document.getElementsByName("crudObject.linkManuName")[0].value; 
        
        
        var code4=document.getElementsByName("crudObject.linkManuId")[0].value; 
       
      
        var codeArray3=code3.split(',');
        var codeArray4=code4.split(',');
         //alert(codeArray3[0]);
        var tt1='';
         var tt2='';
          var tt3='';
           var tt4='';
            var tt5='';
        var strName1='关联备忘';
         var strName2='关联疑点';
          var strName4='关联重大事项';
           var strName3='关联发现';
           var strName5='关联底稿';
       if(codeArray3!=null){
       for(var a=0;a<codeArray4.length;a++){
        if(codeArray4[a]!=null&&codeArray4[a]!=''){
        if(tt3==''){
          tt3='<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
        }else{
         tt3=tt3+'&nbsp;&nbsp;<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
        }
          
         
        }}
         p2.innerHTML= tt3 ;
    }

}


   function go(s){
	//var q=s;
	//alert(q);
	window.open('http://<%=MyProperty.getProperties("fap.host")%>:<%=MyProperty.getProperties("fap.port")%>/<%=MyProperty.getProperties("fap.context")%>/instanceAction.do?action=enter&taskPid=${taskPid}&taskId=${taskId}&commonProId=${pro_id}&id='+s,s,'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	function test1(){
        var name=document.getElementsByName("crudObject.customName")[0].value;
        var code=document.getElementsByName("crudObject.customId")[0].value;
        //alert(name);
        //alert(code);
        var nameArray=name.split(',');
        var codeArray=code.split(',');
        var strName='';
        var strCode='';
        var tt='';
        for(var a=0;a<nameArray.length;a++){
          strName=nameArray[a];
          strCode=codeArray[a];
          if(tt!=''){
            tt=tt+'    '+'<a href=# onclick=go(\"';
            tt+=strCode+'\")>'+strName+'</a>';
          }else{
            tt='<a href=# onclick=go(\"'+strCode+'\")>'+strName+'</a>';
          }
         
        }
       
        p.innerHTML=tt+"<br />";
        //setTimeout('Test();',1000);
}

var xmlreq = false; //创建一个XMLHttpRequest对象    
            
function newXMLHttpRequest() {    
      if (window.XMLHttpRequest) {    
            xmlreq = new XMLHttpRequest();  // 在非Microsoft浏览器中创建XMLHttpRequest对象    
      } else if (window.ActiveXObject) {    
        try {   //通过MS ActiveX创建XMLHttpRequest    
            xmlreq = new ActiveXObject("Msxml2.XMLHTTP");   // 尝试按新版InternetExplorer方法创建    
        } catch (e1) {    
            try {   // 创建请求的ActiveX对象失败    
                xmlreq = new ActiveXObject("Microsoft.XMLHTTP");    // 尝试按老版InternetExplorer方法创建    
            } catch (e2) {    
                 // 不能通过ActiveX创建XMLHttpRequest    
            }    
        }    
      }    
}     
            
   
//发送请求函数-->业务流程    
function sendXml(url, param){  
    
    if(url.length == 0){    
        return;    
    }else{    
        if( param == null || param == "undefined" ){    
            param = "";    
        }    
   
        newXMLHttpRequest();    
        try{  
            xmlreq.onreadystatechange=proce;    //指定响应的函数 proce()    
            xmlreq.open("GET", url, true);      //以GET方式传输数据，打开url，以异步方式    
            xmlreq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");    
            xmlreq.send(param); //发送请求    
        }catch(exception){    
            alert("您要访问的资源不存在!");    
        }    
    }    
}    
   
//回调函数    
function proce(){    
    if(xmlreq.readyState == 4){     //对象状态    
        if(xmlreq.status == 200 || xmlreq.status == 0){ //信息已成功返回，开始处理信息;    
            //alert(xmlreq.responseText);   
            parseXml(xmlreq.responseXML);    
        }else{    
            window.alert("所请求的页面有异常");    
            alert(xmlreq.statusText);    
        }    
    }    
}    
            
//解析xml文档    
function parseXml(xmlDom){    
    var rootNode = xmlDom.documentElement;    
    if(rootNode == null){    
    alert(" 345 ");
        return false;    
    }else{    
        for(var node = rootNode.firstChild; node != null;  node=node.nextSibling){    
            var objName = node.nodeName;    
            var erjishisu = node.getAttribute("erjishisu");    
            var sanjishisu = node.getAttribute("sanjishisu");   
            var buzhu = node.getAttribute("buzhu");  
            var wangfan = node.getAttribute("wangfan");  
            var jiaotong = node.getAttribute("jiaotong");  
            var other = node.getAttribute("other");  
            alert(" 123 "+erjishisu);
            document.getElementsByName("crudObject.ejfy")[0].value=erjishisu;   
            document.getElementsByName("crudObject.sjfy")[0].value=sanjishisu;  
            document.getElementsByName("crudObject.bz")[0].value=buzhu;  
            document.getElementsByName("crudObject.wfjtf")[0].value=wangfan;  
            document.getElementsByName("crudObject.snjtf")[0].value=jiaotong;  
            document.getElementsByName("crudObject.qt")[0].value=other;  
        }    
    }    
                
}    
   
//往下拉列表框中写数据    
function addSelectOption(objName, optValue, optName){    
    var elmtObj = document.getElementById(objName);    
    elmtObj.options[elmtObj.length] = new Option(optName, optValue);    
}    
   
//清空下拉列表框    
function clearSelectOption(objName){    
    var elmtObj = document.getElementById(objName);    
   
    while(elmtObj.options.length > 0){    
        elmtObj.remove(0);    
    }    
        
    //elmtObj.options.length = 0;    
}    
   
function sendText(url, param){    
    if(url.length == 0){    
        return;    
    }else{    
        if( param == null || param == "undefined" ){    
            param = "";    
        }    
   
        newXMLHttpRequest();    
        try{    
            xmlreq.onreadystatechange=getText;  //指定响应的函数 getText()    
            xmlreq.open("GET", url, true);      //以GET方式传输数据，打开url，以异步方式    
            xmlreq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");    
            xmlreq.send(param); //发送请求    
        }catch(exception){    
            alert("您要访问的资源不存在!");    
        }    
    }    
}    
   
function getText(){    
    if(xmlreq.readyState == 4){     //对象状态    
        if(xmlreq.status == 200 || xmlreq.status == 0){ //信息已成功返回，开始处理信息;    
            alert(xmlreq.responseText);    
        }else{    
            window.alert("所请求的页面有异常");    
            alert(xmlreq.statusText);    
        }    
    }    
}   


</script>
		<script>    


     function areaChange(areaCode){
       if(onlyNumbers1(document.getElementById('crudObject.ejrs').value)){
	document.getElementById('crudObject.ejrs').focus();
	
	return false;
	}	
	
	if(onlyNumbers1(document.getElementById('crudObject.ejts').value)){
	document.getElementById('crudObject.ejts').focus();
	
	return false;
	}
	if(onlyNumbers1(document.getElementById('crudObject.sjrs').value)){
	document.getElementById('crudObject.sjrs').focus();
	
	return false;
	}
	
	if(onlyNumbers1(document.getElementById('crudObject.sjts').value)){
	document.getElementById('crudObject.sjts').focus();
	
	return false;
	}
	    var day1;
        var day2;
        var ren1;
        var ren2;
        
        day1 = document.getElementsByName("crudObject.ejts")[0].value;
        day2 = document.getElementsByName("crudObject.sjts")[0].value;
        ren1 = document.getElementsByName("crudObject.ejrs")[0].value;
        ren2 = document.getElementsByName("crudObject.sjrs")[0].value;
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/mng/budget2/budget2Plan', action:'select', executeResult:'false' }, 
		{'day1':day1,'day2':day2,'ren1':ren1,'ren2':ren2,'areaCode':areaCode},xxx);
	     function xxx(data){
	     document.getElementsByName("crudObject.ejfy")[0].value= data['erjishisu'];
         document.getElementsByName("crudObject.sjfy")[0].value= data['sanjishisu'];
         document.getElementsByName("crudObject.bz")[0].value= data['buzhu'];
         document.getElementsByName("crudObject.wfjtf")[0].value= data['wangfan'];
         document.getElementsByName("crudObject.snjtf")[0].value= data['jiaotong'];
         document.getElementsByName("crudObject.qt")[0].value= data['other'];
         document.getElementsByName("crudObject.sum")[0].value= data['sum'];
         
          document.getElementById("ej").style.display="";
	      Ob=document.all("ej");
          Ob.innerHTML=document.getElementsByName("crudObject.ejfy")[0].value+' 元';
                         
                         
          document.getElementById("sj").style.display="";
	      Ob=document.all("sj");
          Ob.innerHTML=document.getElementsByName("crudObject.sjfy")[0].value+' 元';
          
          document.getElementById("bz").style.display="";
	      Ob=document.all("bz");
          Ob.innerHTML=document.getElementsByName("crudObject.bz")[0].value+' 元';
          
          document.getElementById("wf").style.display="";
	      Ob=document.all("wf");
          Ob.innerHTML=document.getElementsByName("crudObject.wfjtf")[0].value+' 元';
          
          document.getElementById("sn").style.display="";
	      Ob=document.all("sn");
          Ob.innerHTML=document.getElementsByName("crudObject.snjtf")[0].value+' 元';
          
          document.getElementById("qt").style.display="";
	      Ob=document.all("qt");
          Ob.innerHTML=document.getElementsByName("crudObject.qt")[0].value+' 元';
          
          document.getElementById("sum").style.display="";
	      Ob=document.all("sum");
          Ob.innerHTML=document.getElementsByName("crudObject.sum")[0].value+' 元';
		} 
	}
       
       
     
    
 function dayChange(){
        if(onlyNumbers1(document.getElementById('crudObject.ejrs').value)){
	document.getElementById('crudObject.ejrs').focus();
	
	return false;
	}	
	
	if(onlyNumbers1(document.getElementById('crudObject.ejts').value)){
	document.getElementById('crudObject.ejts').focus();
	
	return false;
	}
	if(onlyNumbers1(document.getElementById('crudObject.sjrs').value)){
	document.getElementById('crudObject.sjrs').focus();
	
	return false;
	}
	
	if(onlyNumbers1(document.getElementById('crudObject.sjts').value)){
	document.getElementById('crudObject.sjts').focus();
	
	return false;
	}
 
 
 
	    var day1;
        var day2;
        var ren1;
        var ren2;
        var areaCode;
        day1 = document.getElementsByName("crudObject.ejts")[0].value;
        day2 = document.getElementsByName("crudObject.sjts")[0].value;
        ren1 = document.getElementsByName("crudObject.ejrs")[0].value;
        ren2 = document.getElementsByName("crudObject.sjrs")[0].value;
        areaCode = document.getElementsByName("crudObject.location_code")[0].value;
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/mng/budget2/budget2Plan', action:'select', executeResult:'false' }, 
		{'day1':day1,'day2':day2,'ren1':ren1,'ren2':ren2,'areaCode':areaCode},xxx);
	     function xxx(data){
	     document.getElementsByName("crudObject.ejfy")[0].value= data['erjishisu'];
         document.getElementsByName("crudObject.sjfy")[0].value= data['sanjishisu'];
         document.getElementsByName("crudObject.bz")[0].value= data['buzhu'];
         document.getElementsByName("crudObject.wfjtf")[0].value= data['wangfan'];
         document.getElementsByName("crudObject.snjtf")[0].value= data['jiaotong'];
         document.getElementsByName("crudObject.qt")[0].value= data['other'];
         document.getElementsByName("crudObject.sum")[0].value= data['sum'];
         
          document.getElementById("ej").style.display="";
	      Ob=document.all("ej");
          Ob.innerHTML=document.getElementsByName("crudObject.ejfy")[0].value+' 元';
                         
                         
          document.getElementById("sj").style.display="";
	      Ob=document.all("sj");
          Ob.innerHTML=document.getElementsByName("crudObject.sjfy")[0].value+' 元';
          
          document.getElementById("bz").style.display="";
	      Ob=document.all("bz");
          Ob.innerHTML=document.getElementsByName("crudObject.bz")[0].value+' 元';
          
          document.getElementById("wf").style.display="";
	      Ob=document.all("wf");
          Ob.innerHTML=document.getElementsByName("crudObject.wfjtf")[0].value+' 元';
          
          document.getElementById("sn").style.display="";
	      Ob=document.all("sn");
          Ob.innerHTML=document.getElementsByName("crudObject.snjtf")[0].value+' 元';
          
          document.getElementById("qt").style.display="";
	      Ob=document.all("qt");
          Ob.innerHTML=document.getElementsByName("crudObject.qt")[0].value+' 元';
          
          document.getElementById("sum").style.display="";
	      Ob=document.all("sum");
          Ob.innerHTML=document.getElementsByName("crudObject.sum")[0].value+' 元';
		} 
	}
</script>
		<script language="javascript">
function onlyNumbers1(s)
{
 
 re = /^\d+\d*$/
 var str=s.replace(/\s+$|^\s+/g,"");
 if(str==""){
 return false;
 }
 if(!re.test(str))
 {
  alert("只能输入正整数,请重新输入");
  return true ;   
 }
}

//返回上级list页面
function backList(){
	location.href = "${contextPath}/operate/manu/listTobeStarted.action?taskId=${taskId}&taskPid=${taskPid}&pro_id=${pro_id}";
 
}

//返回上级list页面
function backListPlan(){
	location.href = "${contextPath}/operate/manu/listTobeStarted.action?taskId=${taskId}&taskPid=${taskPid}&pro_id=${pro_id}";
}

//保存表单0
function saveForm0(){
document.getElementsByName('crudObject.status')[0].value='0';
saveForm()
}

//保存表单1
function saveForm1(){
document.getElementsByName('crudObject.status')[0].value='1';
saveForm()
}

//报审表单
function saveFormB(){
//document.all.myform.action="saveSimple";
//alert(document.all.myform.action);
document.getElementsByName('crudObject.status')[0].value='1';

var bool = true;//提交表单判断参数
//非空校验
   var mobj=document.getElementsByName('crudObject.location_code')[0];
	var mindex=mobj.selectedIndex;
	if(mindex==0){
	  alert("请选择项目所在地区");
	  document.getElementsByName('crudObject.location_code')[0].focus();
	  return true;
	}
	
	//非空校验
 var v_3 = "crudObject.ejrs";  // field
var title_3 = '二级经理人数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.ejrs').value)){
	document.getElementById('crudObject.ejrs').focus();
	
	return false;
	}	
		//非空校验
 var v_3 = "crudObject.ejts";  // field
var title_3 = '二级经理天数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.ejts').value)){
	document.getElementById('crudObject.ejts').focus();
	
	return false;
	}
			//非空校验
 var v_3 = "crudObject.sjrs";  // field
var title_3 = '三级及以下经理人数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.sjrs').value)){
	document.getElementById('crudObject.sjrs').focus();
	
	return false;
	}
				//非空校验
 var v_3 = "crudObject.sjts";  // field
var title_3 = '三级及以下经理天数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.sjts').value)){
	document.getElementById('crudObject.sjts').focus();
	
	return false;
	}
	//完成保存表单操作
	if(bool){
	var flag=window.confirm('确认提交吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/mng/budget2/budget2Plan/saveSimple.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}
 

//审批表单
function saveFormP(){
document.getElementsByName('crudObject.status')[0].value='3';

var bool = true;//提交表单判断参数
//非空校验
   var mobj=document.getElementsByName('crudObject.location_code')[0];
	var mindex=mobj.selectedIndex;
	if(mindex==0){
	  alert("请选择项目所在地区");
	  document.getElementsByName('crudObject.location_code')[0].focus();
	  return true;
	}
	
	//非空校验
 var v_3 = "crudObject.ejrs";  // field
var title_3 = '二级经理人数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.ejrs').value)){
	document.getElementById('crudObject.ejrs').focus();
	
	return false;
	}	
		//非空校验
 var v_3 = "crudObject.ejts";  // field
var title_3 = '二级经理天数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.ejts').value)){
	document.getElementById('crudObject.ejts').focus();
	
	return false;
	}
			//非空校验
 var v_3 = "crudObject.sjrs";  // field
var title_3 = '三级及以下经理人数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.sjrs').value)){
	document.getElementById('crudObject.sjrs').focus();
	
	return false;
	}
				//非空校验
 var v_3 = "crudObject.sjts";  // field
var title_3 = '三级及以下经理天数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.sjts').value)){
	document.getElementById('crudObject.sjts').focus();
	
	return false;
	}
	//完成保存表单操作
	if(bool){
	var flag=window.confirm('确认提交吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/mng/budget2/budget2Plan/saveCheck.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}

//驳回表单
function saveFormPP(){
document.getElementsByName('crudObject.status')[0].value='0';

var bool = true;//提交表单判断参数
//非空校验
   var mobj=document.getElementsByName('crudObject.location_code')[0];
	var mindex=mobj.selectedIndex;
	if(mindex==0){
	  alert("请选择项目所在地区");
	  document.getElementsByName('crudObject.location_code')[0].focus();
	  return true;
	}
	
	//非空校验
 var v_3 = "crudObject.ejrs";  // field
var title_3 = '二级经理人数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.ejrs').value)){
	document.getElementById('crudObject.ejrs').focus();
	
	return false;
	}	
		//非空校验
 var v_3 = "crudObject.ejts";  // field
var title_3 = '二级经理天数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.ejts').value)){
	document.getElementById('crudObject.ejts').focus();
	
	return false;
	}
			//非空校验
 var v_3 = "crudObject.sjrs";  // field
var title_3 = '三级及以下经理人数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.sjrs').value)){
	document.getElementById('crudObject.sjrs').focus();
	
	return false;
	}
				//非空校验
 var v_3 = "crudObject.sjts";  // field
var title_3 = '三级及以下经理天数';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         document.getElementsByName(v_3)[0].focus();
				         bool = false;
				         return false;
		           }
	if(onlyNumbers1(document.getElementById('crudObject.sjts').value)){
	document.getElementById('crudObject.sjts').focus();
	
	return false;
	}
	//完成保存表单操作
	if(bool){
	var flag=window.confirm('确认提交吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/mng/budget2/budget2Plan/saveBack.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}

//保存表单
function saveForm(){

var bool = true;//提交表单判断参数
 	
	//完成保存表单操作
	if(bool){
	var flag=window.confirm('确认提交吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/operate/manu/save.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}


	function toSubmit(act)
	{

		 
		 
		{
			<s:if test="isUseBpm=='true'">
			if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
			{
				var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
				if(actor_name=='')
				{
					window.alert('下一步处理人不能为空！');
					return false;
				}
			}
			</s:if>
			var flag=window.confirm("您确认提交吗?");
			if(flag==true)
			{
				document.getElementById('submitButton').disabled=true;
				 
					myform.action="<s:url action="submit" includeParams="none"/>";
				  
				myform.submit();
			}
			else
			{
				return false;
			}
		}
	}























//提交表单
function submitForm(){
	var flag=window.confirm('确认提交吗?');
	if(flag==true){myform.submit();
	}else{
	return false;
	}
    }
    	function regu(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	
	function law(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
//上传附件
	function Upload(id,filelist,delete_flag,edit_flag){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
</script>



		<script>
var XMLHttpReq=false;
 		//创建一个XMLHttpRequest对象
 		function createXMLHttpRequest(){
 				if(window.XMLHttpRequest){ //Mozilla 浏览器
 					XMLHttpReq=new XMLHttpRequest();
 					}
 					else if(window.ActiveXObject){ //微软IE 浏览器
 						try{
 							XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
 							}catch(e){
 								try{
 									XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
									//IE 5.0版本
 									}catch(e){}
 									}
 								}
 		}
 		var layerName="";//指定删除之后回显的DIV标签对的id属性
 		//发送请求函数
 		function send(url,guid){
 			createXMLHttpRequest();
 			XMLHttpReq.open("GET",url,true);
 			
 			this.layerName=document.getElementById(guid).parentElement.id;
 			
 			XMLHttpReq.onreadystatechange=proce;//指定响应的函数
 			XMLHttpReq.send(null);  //发送请求
 			};
 		function proce(layerName){
 			if(XMLHttpReq.readyState==4){ //对象状态
 				if(XMLHttpReq.status==200){//信息已成功返回，开始处理信息
 				var resText = XMLHttpReq.responseText;
 				document.getElementById(this.layerName).innerHTML=resText;
 				window.alert("删除成功");
 				}else{
 					window.alert("所请求的页面有异常");
 					}
 					}
 		}
 		
 		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
         function deleteFile(fileId,guid,isDelete,isEdit,appType){		
 			var boolFlag=window.confirm("确认删除吗?");
 			if(boolFlag==true)
 			{
 				//alert(guid);	
 				send('${contextPath}/commons/file/delFile.action?fileId='+fileId+'&&deletePermission='+isDelete+'&&isEdit='+isEdit+'&&guid='+guid+'&&appType=0',guid);
 			}
 		}
 		
 		function test(){
 		  document.getElementsByName('crudObject.ms_status')[0].value='040';
 		  var d=document.getElementsByName('crudObject.ms_status')[0].value;
 		  //alert(d);
 		}

</script>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>




	<body onload="Test();manu();">

		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" action="submit" namespace="/operate/manu"
				onsubmit="test()">

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">





					<tr class="titletable1">
						<td style="width: 20%">

							<font color="red"></font>&nbsp;&nbsp;&nbsp;底稿状态:
						</td>
						<!--标题栏-->
						<td style="width: 30%">
							<s:if test="crudObject.ms_status == '010'">
	底稿草稿
</s:if>
							<s:if test="crudObject.ms_status == '020'">
	正在征求
</s:if>
							<s:if test="crudObject.ms_status == '030'">
	等待复核
</s:if>
							<s:if test="crudObject.ms_status == '040'">
	正在复核
</s:if>
							<s:if test="crudObject.ms_status == '050'">
	复核完毕
</s:if>
							<s:if test="crudObject.ms_status == '060'">
	已经注销
</s:if>

							<!--  s:property value="audDoubt.doubt_status" /-->
							<s:hidden name="crudObject.ms_status" />
						</td>

						<td style="width: 20%">
							&nbsp;&nbsp;&nbsp;底稿编码:
						</td>
						<!--标题栏-->
						<td style="width: 30%">
							<s:property value="crudObject.ms_code" />
							<s:hidden name="crudObject.ms_code" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>

							&nbsp;&nbsp;&nbsp;底稿名称:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.ms_name" />
							<!--一般文本框-->

						</td>
						<s:hidden name="crudObject.customId" />
						<s:hidden name="crudObject.customName" />
						<td>

							&nbsp;&nbsp;&nbsp;审计事项编码:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.task_code" />
							<!--一般文本框-->
							<s:hidden name="crudObject.task_code" />

						</td>
					</tr>
					<tr class="titletable1">
						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;所属小组:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.groupName" />
						</td>

						<td>
						</td>
						<!--标题栏-->
						<td>
						</td>

					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;被审计单位:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="crudObject.audit_dept_name" readonly="true"
								cssStyle="width:100%;height:25;" />

						</td>
					</tr>
					<tr class="titletable1">
						<td>

							&nbsp;&nbsp;&nbsp;审计事项名称:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.task_name" />
							<!--一般文本框-->
							<s:hidden name="crudObject.task_name" />
						</td>
						<td>

							&nbsp;&nbsp;&nbsp;项目名称:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.project_name" />
							<!--一般文本框-->
							<s:hidden name="crudObject.project_name" />

						</td>
					</tr>

					<tr class="titletable1">
						<td>

							&nbsp;&nbsp;&nbsp;审计期间开始:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.manu_start" />
							<!--一般文本框-->
							<s:hidden name="crudObject.manu_start" />
							<s:hidden name="crudObject.audit_found" />
							<s:hidden name="crudObject.audit_matter" />
						</td>
						<td>

							&nbsp;&nbsp;&nbsp;审计期间结束:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.manu_end" />
							<!--一般文本框-->
							<s:hidden name="crudObject.manu_end" />

						</td>
					</tr>
					<tr class="titletable1">
						<td>

							&nbsp;&nbsp;&nbsp;提交人:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.ms_author_name" />
							<!--一般文本框-->
							<s:hidden name="crudObject.task_id" />
							<s:hidden name="crudObject.pro_id" />
							<s:hidden name="crudObject.ms_author_name" />
							<s:hidden name="crudObject.ms_author" />
						</td>
						<td>

							&nbsp;&nbsp;&nbsp;提交日期:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="crudObject.ms_date" />
							<!--一般文本框-->
							<s:hidden name="crudObject.ms_date" />

						</td>
					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;关联索引:
						</td>
						<td class="titletable1" colspan="3">
							<span id="p1"></span>
						</td>

					</tr>


					<s:hidden name="crudObject.linkManuName" />
					<s:hidden name="crudObject.linkManuId" />

					<tr>
						<td class="titletable1">
							<font color="red"></font>&nbsp;&nbsp;&nbsp;引用底稿:
						</td>
						<td class="titletable1" colspan="3">
							<span id="p2"></span>
						</td>


					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计记录:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>


					<tr>

						<td class="ListTableTr22" colspan="4">
							<s:hidden name="crudObject.interact" />
							<s:if test="crudObject.interact==1">
								<div id="subModelHTML" runat="server"
									style="border-style: none; left: 0px; overflow: scroll; width: 100%; position: relative; top: 0px; height: 260px;">

									<s:property escape="false" value="crudObject.subModelHTML" />
								</div>
								<s:hidden name="crudObject.subModelHTML" />
							</s:if>
								<s:if test="crudObject.interact==2">
								<div id="subModelHTML" runat="server"
									style="border-style: none; left: 0px; overflow: scroll; width: 100%; position: relative; top: 0px; height: 260px;">

									<s:property escape="false" value="crudObject.subModelHTML" />
								</div>
								<s:hidden name="crudObject.subModelHTML" />
							</s:if>
							<s:else>
								<s:textarea name="crudObject.ms_description" readonly="true"
									cssStyle="width:100%;height:70;" />
							</s:else>




						</td>
					</tr>

					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计结论:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="crudObject.audit_con" readonly="true"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>


					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;查阅资料:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="crudObject.audit_file" readonly="true"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>

					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计程序:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="crudObject.audit_method_name" readonly="true"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;法律法规:
						</td>
						<td class="titletable1" colspan="3">
							<input type="button" value="查看法规制度" onclick="law()" />
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="crudObject.audit_law" readonly="true"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>

				  

				   <s:hidden name="crudObject.audit_regulation"/>

					 
					<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
					<tr>
						<td class="ListTableTr11">
							<div align="center">
								附件
							</div>
							<s:hidden name="crudObject.file_id" />
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="file_idList" align="center">
								<s:property escape="false" value="file_idList" />
							</div>

						</td>
					</tr>
					<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
					<s:hidden name="pro_id" />
					<s:hidden name="taskPid" />
					<s:hidden name="taskId" />
					<s:hidden name="crudObject.id" />
                    <s:hidden name="crudObject.prom" />
					<s:hidden name="crudObject.feedback" />
				</table>
				<div align="right">
					<s:button value="查看审计问题" onclick="taizhangView();" />
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</s:form>
		</center>
	</body>
</html>
