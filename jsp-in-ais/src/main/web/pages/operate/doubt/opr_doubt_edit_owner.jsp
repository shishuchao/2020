<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<s:if test="type == 'BW'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加备忘'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'修改备忘'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'FX'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'增加疑点'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'修改疑点'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'YD'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加发现'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'修改发现'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'DS'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加重大程序'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'修改重大程序'"></s:text>
	</s:else>
</s:if>

<%String owner=request.getParameter("owner");
if("true".equals(owner)){
	owner="-owner";
}else{
	owner="";
}
%>
 

<html>
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script language="javascript">
	 function String.prototype.Trim() {return this.replace(/(^\s*)|(\s*$)/g,"");}   //去掉前后空格
	  function noblank(txtObject){

	          
                 
                   if(txtObject.value.replace(/\s+$|^\s+/g,"")=="null"){
                        window.alert("不能输入'null'!");
				         return false;
                   }
                   
                   if(txtObject.value.replace(/\s+$|^\s+/g,"")=="NULL"){
                        window.alert("不能输入'NULL'!");
				         return false;
                   }
                  
                   return true;


      }
      
      function conCode(){
       document.onkeydown = function(){
           document.getElementsByName("audDoubt.change_code")[0].value = "1";
        }
       
      
      }
      
	   function go(s){
	    
	      window.open("${contextPath}/operate/doubt/view.action?doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    
	       function getGroup(){

            var name=document.getElementsByName("audDoubt.groupName")[0].value; 
        	var code=document.getElementsByName("audDoubt.groupId")[0].value; 
        	var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
        	var url='/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/task/selectDept.action&a=a&x='+rnm+'&group_id='+code+'&paraname=audDoubt.audit_dept_name&paraid=audDoubt.audit_dept';
            //alert(url);
        	if(name==null||name==""){
            	alert("请先选择审计小组!");
                return false;
        	}
        	showPopWin(url,500,330,'被审计单位选择');
        } 
        
        function  getOwerGroup(){

            var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
        	var code=document.getElementsByName("project_id")[0].value; 
        	 
        	showPopWin('/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectGroup.action&a=a&x='+rnm+'&project_id='+code+'&paraname=audDoubt.groupName&paraid=audDoubt.groupId',500,330,'审计小组选择');
        } 
        
        
        
          function  getOwerTask(){

            var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
        	var code=document.getElementsByName("audDoubt.project_id")[0].value; 
        	 
        	showPopWin('/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectTask.action&a=a&x='+rnm+'&project_id='+code+'&paraname=audDoubt.task_name&paraid=audDoubt.task_id',500,330,'审计事项选择');
         }
	    
	     function go1(s){
	    
	     window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    
	    
		function Test(){
        var code1=document.getElementsByName("audDoubt.doubt_memorandum")[0].value;
        
        var code2=document.getElementsByName("audDoubt.doubt_doubt")[0].value; 
        
        
        var code3=document.getElementsByName("audDoubt.doubt_found")[0].value; 
        
        
        var code4=document.getElementsByName("audDoubt.doubt_matters")[0].value; 
       
       
        var code5=document.getElementsByName("audDoubt.doubt_manu")[0].value; 
       
        var codeArray1=code1.split(',');
        var codeArray2=code2.split(',');
        var codeArray3=code3.split(',');
        var codeArray4=code4.split(',');
        var codeArray5=code5.split(',');
         //alert(codeArray1[0]);
        var tt1='';
         var tt2='';
          var tt3='';
           var tt4='';
            var tt5='';
        var strName1='关联备忘';
         var strName2='关联疑点';
          var strName4='关联重大程序';
           var strName3='关联发现';
           var strName5='关联底稿';
        if(codeArray1[0]!=null&&codeArray1[0]!=''){
          tt1='<a href=# onclick=go(\"'+codeArray1[0]+'\")>'+strName1+'</a>';
          tt1=tt1+"<br />";
        }
        if(codeArray2[0]!=null&&codeArray2[0]!=''){
          tt2='<a href=# onclick=go(\"'+codeArray2[0]+'\")>'+strName2+'</a>';
          tt2=tt2+"<br />";
        }
        if(codeArray3[0]!=null&&codeArray3[0]!=''){
          tt3='<a href=# onclick=go(\"'+codeArray3[0]+'\")>'+strName3+'</a>';
          tt3=tt3+"<br />";
        }
        if(codeArray4[0]!=null&&codeArray4[0]!=''){
          tt4='<a href=# onclick=go(\"'+codeArray4[0]+'\")>'+strName4+'</a>';
          tt4=tt4+"<br />";
        }
          if(codeArray5[0]!=null&&codeArray5[0]!=''){
          tt4='<a href=# onclick=go1(\"'+codeArray5[0]+'\")>'+codeArray5[1]+'</a>';
          tt4=tt4+"<br />";
        }
 p.innerHTML=tt1+tt2+tt3+tt4+tt5;
}
	
	
		 //生成
      function generateMS(s)
		  {

    	  var v_3 = "audDoubt.doubt_name";  // field
		  var title_3 = '疑点名称';// field name 
		  var notNull = 'true'; // notnull
		  	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		  		           {
		  				         window.alert(title_3+"不能为空!");
		  				         bool = false;
		  				         document.getElementById(v_3).focus();
		  				         return false;
		  		           }
		                   if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                          window.alert(title_3+"不能为空!");
		  				         bool = false;
		  				         document.getElementById(v_3).focus();
		  				         return false;
		                     }
		                   v_3 = "audDoubt.groupName";  // field
		                   title_3 = '审计小组';// field name
		                   var notNull = 'true'; // notnull
		                   	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		                   		           {
		                   				         window.alert(title_3+"不能为空!");
		                   				         bool = false;
		                   				         document.getElementById(v_3).focus();
		                   				         return false;
		                   		           }
		                                    if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                                           window.alert(title_3+"不能为空!");
		                   				         bool = false;
		                   				         document.getElementById(v_3).focus();
		                   				         return false;
		                                      }

		   
		
		if( !check()){
            return false;
         } 
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限操作！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能执行操作！");
		                    return false;
		                  }else{
		              }
		     d_id=document.getElementsByName("doubt_id")[0].value;
		     document.getElementsByName("generateFX")[0].disabled=true;
		     document.getElementsByName("deleteRecordFX")[0].disabled=true;
		     document.getElementsByName("exeFX")[0].disabled=true;
		     document.getElementsByName("saveFormFX")[0].disabled=true;
		     n_type='MS';
		     var title = "生成审计底稿";
		     //d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/doubt/genManu.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+s+'&&project_id=${project_id}',700,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
	} 
	
	 //生成
      function generate(s)
		  {
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限操作！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能执行操作！");
		                    return false;
		                  }else{
		              }
		     d_id=document.getElementsByName("doubt_id")[0].value;
		     n_type=s;
		     var title = "";
		     if(s=="YD"){
		       title = "生成审计疑点";
		     }else if(s=="FX"){
		       title = "生成审计发现";
		     }else if(s=="DS"){
		       title = "生成重大程序";
		     } 
		     d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}',700,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
	} 
	 //删除
      function deleteRecord()
		  {
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能删除！");
		                    return false;
		                  }else{
		              }
		           
		  	if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/doubt/delete.action";
				document.getElementsByName("generateFX")[0].disabled=true;
			     document.getElementsByName("deleteRecordFX")[0].disabled=true;
			     document.getElementsByName("exeFX")[0].disabled=true;
			     document.getElementsByName("saveFormFX")[0].disabled=true;
	            myform.submit();
	      }
	                    
	} 
	function exe(){

		  var v_3 = "audDoubt.doubt_name";  // field
		  var title_3 = '疑点名称';// field name 
		  var notNull = 'true'; // notnull
		  	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		  		           {
		  				         window.alert(title_3+"不能为空!");
		  				         bool = false;
		  				         document.getElementById(v_3).focus();
		  				         return false;
		  		           }
		                   if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                          window.alert(title_3+"不能为空!");
		  				         bool = false;
		  				         document.getElementById(v_3).focus();
		  				         return false;
		                     }
		                     
		      if('${audDoubt.doubt_id}'!=null&&'${audDoubt.doubt_id}'!='null'&&'${audDoubt.doubt_id}'!=''){  
                 var v_3 = "audDoubt.doubt_code";  // field
	             var title_3 = '疑点编码';// field name
	             var notNull = 'true'; // notnull
	             if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }
                 }  
                   
                 document.getElementsByName(v_3)[0].value=document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,""); 
		                     
		                     
		                   v_3 = "audDoubt.groupName";  // field
		                   title_3 = '审计小组';// field name
		                   var notNull = 'true'; // notnull
		                   	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		                   		           {
		                   				         window.alert(title_3+"不能为空!");
		                   				         bool = false;
		                   				         document.getElementById(v_3).focus();
		                   				         return false;
		                   		           }
		                                    if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                                           window.alert(title_3+"不能为空!");
		                   				         bool = false;
		                   				         document.getElementById(v_3).focus();
		                   				         return false;
		                                      }
		                                        v_3 = "audDoubt.audit_dept_name";  // field
                 title_3 = '被审计单位';// field name
                 var notNull = 'true'; // notnull
                 	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    }   
 

		   
		
		if( !check()){
            return false;
         } 
	        var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限处理！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能重复处理！");
		                    return false;
		                  }else{
		              }
		               if(editer_table_cell_tag == false)
						{
							

						}else{
							alert("请先点'确定'按钮,确定修改的内容!");
							return false;
						}
						
						
					
		
		   if(confirm("是否录入处理无问题原因?\n点‘确定’按钮录入处理无问题原因，点‘取消’按钮直接处理疑点。")){
           
           var title = "录入处理无问题原因";
           showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?chuli=2&doubt_id=${audDoubt.doubt_id}',600,400,title);
             }else{
                 if (confirm("是否设置为已处理状态?")) {
		           document.getElementsByName("audDoubt.doubt_status")[0].value="050"
		           var t=document.getElementById('subModelHTML');
			       document.getElementById('audDoubt.subModelHTML').value=t.innerHTML;
		     
	               var url = "${contextPath}/operate/doubt/save.action";
	               document.getElementsByName("generateFX")[0].disabled=true;
		           document.getElementsByName("deleteRecordFX")[0].disabled=true;
		           document.getElementsByName("exeFX")[0].disabled=true;
		           document.getElementsByName("saveFormFX")[0].disabled=true;
                  myform.action = url;
	              myform.submit();
               }else{
	 
                } 
           }
     
						
		
	}
	function regu(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	
	function law(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
 
	//返回上级list页面
  function backList(){
	var type='1';
	if('${type}'=='YD'){
	type='2';
	}else{
	type='3'
	}
       var u='${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action?owner=${owner}&groupCode=<%=request.getParameter("groupCode")%>&type=FX&project_id=${project_id}&taskId=${taskId}&taskPid=${taskId}'
       window.parent.Usp.doTabLoad({
               tabId:'common-data-dataframe-tab<%=owner%>',
               pid:'common-data-dataframe-tab4<%=owner%>',
               url:u
               });       
                
                  
}
 

   function closeGenW(s){
	  window.location.reload();
	  //alert(s);
	  window.parent.document.frames[s].location.reload(); 
	
	 //window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type=<s:property value="type" />&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>";
   }

     function check(){

	     var v_3 = "audDoubt.doubt_name";  // field
	     var title_3 = '疑点名称';// field name
	     var notNull = 'true'; // notnull
	     var t=document.getElementsByName(v_3)[0].value;
	     if(t.length>50){
	       alert("疑点名称的长度不能大于50字！");
	       document.getElementById(v_3).focus();
	     return false;
	    } 
         var doubt_code = document.getElementById("audDoubt.doubt_code").value.Trim();
         var auth='';
         DWREngine.setAsync(false);
	     DWREngine.setAsync(false);DWRActionUtil.execute(
	      { namespace:'/operate/doubt', action:'checkCode', executeResult:'false' }, 
	      {'project_id':'${audDoubt.project_id}','doubt_code':doubt_code,'doubt_id':'${audDoubt.doubt_id}'},xxx);
	          function xxx(data){
		        auth =data['checkCode'];
		     }
		   if(auth=='1'){
		    }else{
			  alert("疑点编码重复,请重新输入!");
			  document.getElementById("audDoubt.doubt_code").focus();
			  return false;
		    }
	
        var v_3 = "audDoubt.doubt_content";  // field
        var title_3 = '疑点内容';// field name
        var notNull = 'true'; // notnull
        var t=document.getElementsByName(v_3)[0].value;
        if(t.length>2000){
         alert("疑点内容的长度不能大于2000字！");
         document.getElementById(v_3).focus();
         return false;
        }                     
        if('${audDoubt.interact}'=='1'||'${audDoubt.interact}'=='2'){
         	var v_3 = "audDoubt.describe";  // field
		 	var title_3 = '疑点描述';// field name
		 	var notNull = 'true'; // notnull
		 	var t=document.getElementsByName(v_3)[0].value;
		 	if(t.length>500){
				alert("疑点描述的长度不能大于500字！");
				document.getElementById(v_3).focus();
				return false;
			} 
        }
                    
                   
                
                   
		var v_3 = "audDoubt.audit_law";  // field
		var title_3 = '法规制度';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		   alert("法规制度的长度不能大于2000字！");
		   document.getElementById(v_3).focus();
		   return false;
      }

		var v_3 = "audDoubt.audit_regulation";  // field
		var title_3 = '规章制度';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
			alert("规章制度的长度不能大于2000字！");
			document.getElementById(v_3).focus();
			return false;
		}
		return true;
	}

     //模板生成----------保存表单
	function saveForm(){
        var auth='';
       var doubt_taskId = document.getElementsByName('audDoubt.task_id')[0].value;
       if(doubt_taskId!=""){
       DWREngine.setAsync(false);
	   DWREngine.setAsync(false);DWRActionUtil.execute(
	   { namespace:'/operate/task', action:'checkSubTask', executeResult:'false' }, 
	   {'project_id':'<%=request.getParameter("project_id")%>','taskTemplateId':doubt_taskId},xxx);
	    function xxx(data){
		  auth =data['auth'];
		}
				 
		  if(auth=='2'||auth=='3'){
		 
		 }else{
			 alert("请刷新页面,该审计事项不是末级节点,不能增加审计疑点!");
			 return false;
		 }
        }
		var v_3 = "audDoubt.doubt_name";  // field
		var title_3 = '疑点名称';// field name 
		var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }
                   
                 if('${audDoubt.doubt_id}'!=null&&'${audDoubt.doubt_id}'!='null'&&'${audDoubt.doubt_id}'!=''){  
                 var v_3 = "audDoubt.doubt_code";  // field
	             var title_3 = '疑点编码';// field name
	             var notNull = 'true'; // notnull
	             if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }
                 }  
                 
                 document.getElementsByName(v_3)[0].value=document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"");  
                  if('${taskId}'=='-1'){
                 var v_3 = "audDoubt.task_name";  // field
	             var title_3 = '审计事项';// field name
	             var notNull = 'true'; // notnull
	             if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }
                 }  
              
                 
                 
                   
                 
                 v_3 = "audDoubt.groupName";  // field
                 title_3 = '审计小组';// field name
                 var notNull = 'true'; // notnull
                 	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                        }
                        
                  v_3 = "audDoubt.audit_dept_name";  // field
                 title_3 = '被审计单位';// field name
                 var notNull = 'true'; // notnull
                 	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 				         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                         window.alert(title_3+"不能为空!");
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    }   
                        

if( !check()){
                 return false;
              }  
 var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
 var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		        if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限操作！");
		                    return false;
		           }
		           
		            if(p=='050'){
		                    alert("已处理状态，不能执行操作！");
		                    return false;
		                  }else{
		              }
		              
		              if(editer_table_cell_tag == false)
						{
							

						}else{
							alert("请先点'确定'按钮,确定修改的内容!");
							return false;
						}
	var flag=window.confirm('确认保存吗?');//isSubmit
	if(flag==true){
		              var t=document.getElementById('subModelHTML');
			document.getElementById('audDoubt.subModelHTML').value=t.innerHTML;
var url = "${contextPath}/operate/doubt/save.action";
document.getElementById("saveFormFX").disabled=true;
myform.action = url;
	myform.submit();
	 
}

}
function saveForm1(){
var bool = true;//提交表单判断参数
//非空校验
 

	
 
	
 
	
var v_3 = "doubt.course_title";  // field
var title_3 = '课程名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }


var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

var v_3 = "doubt.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

	
	//保存表单
	if(bool){
	var flag=window.confirm('确认操作吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/mng/doubt/save.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}




			
				
				
   //上传附件
	function Upload(id,filelist,delete_flag,edit_flag)
		{
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_doubt_operate&table_guid=file_id&guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
     function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true)
		{
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
		{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
		xxx);
		function xxx(data){
		  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
		} 
		}
	}
</script>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/styles/main/manu.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/js/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<s:head />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
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
	 var tdObject = event.srcElement;
 

	//alert(22);
	
	 // for (var i=0; i<ulListChild.length; i+=1) {
   //   alert( i+" "+ulListChild[i].);//tdObject.firstChild
  // }

	
	var tObject = ((tdObject.parentNode).parentNode).parentNode;
	if(tObject.id == tableId &&tdObject.id != noEdiId&&editer_table_cell_tag == false && run_edit_flag == true)
	{

		 var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;		
		 //var nodes = ((tpObject.parentNode.lastChild.lastChild.lastChild.lastChild.childNodes));
		  
		
		tdObject.innerHTML = "<input type='text' id='edit_table_txt' name='edit_table_txt' value='"+tdObject.innerText+"' size='15' onKeyDown='enterToTab()'>  <input type=button value=' 确定 ' onclick='certainEdit()'>";
		//edit_table_txt.focus();
		//edit_table_txt.select();
		editer_table_cell_tag = true;
		//修改按钮提示信息
		//editTip.innerText = "请先点确定按钮确认修改!";		
	}
	else
	{
		return false;
	}
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
			document.getElementById('audDoubt.subModelHTML').value=t.innerHTML;
			

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
</SCRIPT>

		<script type="text/javascript">
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
					 	
			 	 		if(confirm("确认重置疑点内容的数据吗?")){
					 		//var tdObject = event.srcElement;
					 	 	//var tpObject = ((((tdObject.parentNode).parentNode).parentNode).parentNode).parentNode;	
					  
					 	 	//tpObject.innerHTML = run_edit_all;
					 	 	var t=document.getElementById('subModelHTML');
					 	 	
			               t.innerHTML=document.getElementById('audDoubt.subModelHTML').value;
					 	
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
				 	 	//var nodes = ((tpObject.parentNode.lastChild.lastChild.lastChild.childNodes));

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
	</head>



	<body onload=Test();>
		<center>

			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>

			<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/doubt" method="post">

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">








					<tr class="titletable1">
						<td style="width: 20%">

							<font color="red">*</font> 疑点名称:
						</td>
						<!--标题栏-->
						<td style="width: 30%">
							<s:textfield name="audDoubt.doubt_name" cssStyle="width:80%" />
							<!--一般文本框-->

						</td>

						<td style="width: 20%">
							&nbsp;&nbsp;&nbsp;状态:
						</td>
						<!--标题栏-->



						<td style="width: 30%">
							<s:if test="audDoubt.doubt_status == '010'">
	未处理
</s:if>
							<s:if test="audDoubt.doubt_status == '020'">
	等待批示
</s:if>
							<s:if test="audDoubt.doubt_status == '030'">
	正在审批
</s:if>
							<s:if test="audDoubt.doubt_status == '040'">
	审批完毕
</s:if>
							<s:if test="audDoubt.doubt_status == '050'">

								<s:if
									test="audDoubt.doubt_manu == ''||audDoubt.doubt_manu == null||audDoubt.doubt_manu == 'null'">

	已处理无问题
   </s:if>
								<s:else>
     已处理有问题
   </s:else>
							</s:if>

							<!--  s:property value="audDoubt.doubt_status" /-->
							<s:hidden name="audDoubt.doubt_status" />
						</td>
					</tr>



					<tr class="titletable1">
						<td>

							<font color="red">*</font> 审计小组:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield name="audDoubt.groupName" cssStyle="width:80%"
								readonly="true" />
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="getOwerGroup()" border=0 style="cursor: hand">

							<s:hidden name="audDoubt.groupId" />
						</td>

						<td class="titletable1">
							<font color="red">*</font> 被审计单位:
						</td>
						<td class="titletable1">
							<s:textfield name="audDoubt.audit_dept_name" cssStyle="width:80%"
								readonly="true" />
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="getGroup();" border=0 style="cursor: hand">
						</td>

						<s:hidden name="audDoubt.audit_dept" />

					</tr>
 
					<tr class="titletable1">
						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;疑点编码:
						</td>
						<!--标题栏-->
						<td>
							<s:if test="doubt_id == null">
								<s:property value="audDoubt.doubt_code" />
								<s:hidden name="audDoubt.doubt_code" />
							</s:if>
							<s:else>
								<s:textfield name="audDoubt.doubt_code" cssStyle="width:50%"
									maxLength="80" onfocus="conCode()" />
								<font color="red">自动生成,请谨慎修改</font>
							</s:else>

						</td>

						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;撰写人:
						</td>
						<td>
							<s:property value="audDoubt.doubt_author" />
							<s:hidden name="audDoubt.doubt_author_code" />
							<s:hidden name="audDoubt.doubt_author" />
						</td>
					</tr>



					<tr class="titletable1">

						<s:if test="${taskId}=='-1'">

							<td>

								<font color="red">*</font> 审计事项:
							</td>
							<td>
								<s:textfield name="audDoubt.task_name" cssStyle="width:80%"
									readonly="true" />
								<img
									src="<%=request.getContextPath()%>/resources/images/s_search.gif"
									onclick="getOwerTask()" border=0 style="cursor: hand">
								<s:hidden name="audDoubt.task_code" />
								<s:hidden name="audDoubt.task_id" />
							</td>
						</s:if>
						<s:else>
						<td>

								<font color="red"></font>&nbsp;&nbsp;&nbsp;审计事项:
							</td>
							<td>
								<s:property value="audDoubt.task_name" />
								<s:hidden name="audDoubt.task_name" />

							</td>
							 
								<s:hidden name="audDoubt.task_id" />
								<s:hidden name="audDoubt.task_code" />
							 
						</s:else>


						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;提交日期:
						</td>
						<!--标题栏-->
						<td>
							<s:property value="audDoubt.doubt_date" />
							<s:hidden name="audDoubt.doubt_date" />
							<!--一般文本框-->

						</td>

					</tr>
					 

					<s:hidden name="audDoubt.t_id" />
					<s:hidden name="audDoubt.doubt_type" />
					<s:hidden name="audDoubt.doubt_memorandum" />
					<s:hidden name="audDoubt.doubt_found" />
					<s:hidden name="audDoubt.doubt_matters" />
					<s:hidden name="audDoubt.doubt_doubt" />
					<s:hidden name="audDoubt.doubt_manu" />
					<s:hidden name="audDoubt.do_code_sort" />
					<s:hidden name="audDoubt.task_code_sort" />
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;关联索引:
						</td>
						<td class="titletable1" colspan="3">
							<span id="p"></span>
						</td>

					</tr>

					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;
							<s:if test="type == 'BW'">
		 备忘内容 
</s:if>
							<s:if test="type == 'FX'">
疑点内容:
</s:if>

							<s:if test="type == 'YD'">
		 发现内容
	 
</s:if>

							<s:if test="type == 'DS'">
	 重大程序内容 
</s:if>

						</td>
						<td class="titletable1" colspan="3">
						</td>

					</tr>
					<tr>


						<td class="ListTableTr22" colspan="4">
							<s:hidden name="audDoubt.interact" />
							<s:if test="audDoubt.interact==1||audDoubt.interact==2">
								<div id="subModelHTML" runat="server"
									style="border-style: none; left: 0px; overflow: scroll; width: 100%; position: relative; top: 0px; height: 260px;">

									<s:property escape="false" value="audDoubt.subModelHTML" />
								</div>
								<s:hidden name="audDoubt.subModelHTML" />
								<s:hidden name="audDoubt.doubt_content" />

							</s:if>
							<s:else>
								<s:hidden name="audDoubt.subModelHTML" />
								<s:hidden name="subModelHTML" />

								<s:textarea name="audDoubt.doubt_content"
									cssStyle="width:100%;height:70;" />
							</s:else>




						</td>

					</tr>

                  
					<s:if test="audDoubt.interact==2||audDoubt.interact==1">
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;疑点描述:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<s:textarea name="audDoubt.describe"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
                    </s:if>
                    <s:else>
                    <s:hidden name="audDoubt.describe" />
                    </s:else>
                   



					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;法规制度:
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

							<s:textarea name="audDoubt.audit_law"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
					<s:if test="audDoubt.doubt_reason_flag == 1">
						<tr>
							<td class="titletable1" colspan="4">
								&nbsp;&nbsp;&nbsp;无问题原因:
							</td>


						</tr>
						<tr>

							<td class="ListTableTr22" colspan="4">

								<s:textarea name="audDoubt.doubt_reason"
									cssStyle="width:100%;height:70;" />

							</td>
						</tr>
					</s:if>
					<s:hidden name="audDoubt.audit_regulation" />


					<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
					<tr>
						<td class="ListTableTr11">
							<s:if test="audDoubt.doubt_status == '050'">
								<s:button disabled="true"
									onclick="Upload('audDoubt.file_id',file_idList,'true','true')"
									value="上传附件"></s:button>
							</s:if>
							<s:else>
								<s:button
									onclick="Upload('audDoubt.file_id',file_idList,'true','true')"
									value="上传附件"></s:button>
							</s:else>
							<s:hidden name="audDoubt.file_id" />
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="file_idList" align="center">
								<s:property escape="false" value="file_idList" />
							</div>

						</td>
					</tr>






				</table>
				<s:hidden name="audDoubt.doubt_reason_flag" />
				<s:hidden name="newDoubt_type" />
				<s:hidden name="audDoubt.doubt_id" />
				<s:hidden name="audDoubt.project_id" />
				<s:hidden name="audDoubt.change_code" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<s:hidden name="owner" />
				<s:hidden name="groupCode" />
				<div align="right">
					<s:if test="audDoubt.doubt_status == '050'">
						<s:button value="保存" id="saveFormFX" disabled="true"
							onclick="saveForm();" />
					</s:if>
					<s:else>
						<s:button value="保存" id="saveFormFX" onclick="saveForm();" />
					</s:else>
					<s:if test="type == 'BW'">
						<s:if test="doubt_id == null">

						</s:if>
						<s:else>
					
					&nbsp;&nbsp;<s:button value="处理" onclick="exe()" />
		 &nbsp;&nbsp;<s:button value="删除" onclick="deleteRecord()" />&nbsp;&nbsp;
				<s:button value="生成审计疑点" onclick="generate('YD')" />
						</s:else>
					</s:if>

					<s:if test="type == 'YD'">
						<s:if test="doubt_id == null">

						</s:if>
						<s:else>
					&nbsp;&nbsp;<s:button value="处理" onclick="exe()" />
		 &nbsp;&nbsp;<s:button value="删除" onclick="deleteRecord()" />&nbsp;&nbsp;
				<s:button value="生成审计发现" onclick="generate('FX')" />&nbsp;&nbsp;
				<!--<s:button value="生成重大程序" onclick="generate('DS')"/>-->
						</s:else>
					</s:if>

					<s:if test="type == 'FX'">
						<s:if test="doubt_id == null">

						</s:if>
						<s:else>
							<s:if test="audDoubt.doubt_status == '050'">
					&nbsp;&nbsp;<s:button value="处理" disabled="true" id="exeFX"
									onclick="exe()" />
					&nbsp;&nbsp;<s:button value="删除" disabled="true"
									id="deleteRecordFX" onclick="deleteRecord()" />&nbsp;&nbsp;
					<s:button value="生成工作底稿" disabled="true" id="generateFX"
									onclick="generateMS('FX')" />
							</s:if>
							<s:else>
					&nbsp;&nbsp;<s:button value="处理" id="exeFX" onclick="exe()" />
					&nbsp;&nbsp;<s:button value="删除" id="deleteRecordFX"
									onclick="deleteRecord()" />&nbsp;&nbsp;
					<s:button value="生成工作底稿" id="generateFX" onclick="generateMS('FX')" />
							</s:else>


						</s:else>
					</s:if>
					<s:if test="type == 'DS'">
						<s:if test="doubt_id == null">

						</s:if>
						<s:else>
					 &nbsp;&nbsp;<s:button value="处理" onclick="exe()" />
		 &nbsp;&nbsp;<s:button value="删除" onclick="deleteRecord()" />&nbsp;&nbsp;
				<s:button value="生成工作底稿" onclick="generateMS('DS')" />&nbsp;&nbsp;  
					</s:else>
					</s:if>
					&nbsp;&nbsp;
					<s:button value="返回" onclick="backList();" />
					&nbsp;&nbsp;&nbsp;
				</div>
			</s:form>

		</center>
	</body>
</html>
