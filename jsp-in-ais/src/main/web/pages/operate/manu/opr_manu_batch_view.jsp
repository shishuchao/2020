<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<s:if test="crudObject.formId!=null">
	<s:text id="title" name="'修改审计底稿'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'增加审计底稿'"></s:text>
</s:else>

<html>
	<head>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		
		<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>  
		<script lang="javascript">
     
        <%String pb = (String) request.getParameter("back");%>

         <%String owner = (String) request.getParameter("owner");%>
        <%
        String strOwner="";
        if("true".equals(owner)){
        	strOwner="-owner";
        }else{
        	strOwner="";
        }
        %>
        //台帐
       function taizhangView(){
         var ms_code= '${crudObject.formId}';
         var pro_code= '${crudObject.project_id}';
         window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id="+pro_code+"&manuscript_id="+ms_code+"&isView=true","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
       }
       
        //返回上级list页面
        function backList()
          {
               if('<%=strOwner%>'=='-owner'){//我的任务
                  var u='${pageContext.request.contextPath}/operate/manuExt/manuUiOwner.action?project_id=${crudObject.project_id}&taskId=${taskId}&taskPid=${crudObject.task_id}'
				  window.location.href=u;
               }else{//实施方案
                  var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?project_id=${crudObject.project_id}&taskId=${taskId}&taskPid=${crudObject.task_id}'
				  window.location.href=u;
               }
               window.parent.hidePopWin(false);
        }
        
        function close_bat(){
        	parent.close_bat();
        	parent.reload_bat();
        }
       //台帐编辑
       function taizhangEdit(){
          var ms_code= '${crudObject.formId}';
          var pro_code= '${crudObjec4t.project_id}';
          if(ms_code==""||ms_code=="null"){
           alert("请先保存审计底稿!");
           return false;
          }
          window.open("/ais/proledger/problem/listDigaoEditProblem.action?project_id="+pro_code+"&manuscript_id="+ms_code+"&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
        }
         //小组选择
        function getGroup(){
          var code=document.getElementsByName("crudObject.groupId")[0].value; 
          var num=Math.random();
		  var rnm=Math.round(num*9000000000+1000000000);
          var url='/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/task/selectDept.action&a=a&x='+rnm+'&group_id='+code+'&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept';
           //alert(url);
          if(code=null||code==""){
             alert("请先选择所属小组!");
             return false;
          }
          showPopWin(url,500,330,'被审计单位选择');
        }   
         //小组选择
        function  getOwerGroup(){
            var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
        	var code=document.getElementsByName("crudObject.project_id")[0].value; 
        	 
        	showPopWin('/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectGroup.action&a=a&x='+rnm+'&project_id='+code+'&paraname=crudObject.groupName&paraid=crudObject.groupId',500,330,'所属小组选择');
        }  
        //引用底稿选择
        function  getOwerManu(){
           var code=document.getElementsByName("crudObject.project_id")[0].value; 
           showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/manu/selectManu.action&a=a&manuId=${crudId}&manu=all&taskPid=-1&taskId=${taskId}&project_id='+code+'&paraname=crudObject.linkManuName&paraid=crudObject.linkManuId',600,450,'底稿选择')
        } 
       
        //查看疑点
	    function go2(s){
	      window.open("${contextPath}/operate/doubt/view.action?doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    //查看底稿
	    function go1(s){
	      window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${crudObject.project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    
	    //把关联的底稿或者疑点渲染为链接，关联索引: 点击疑点编码
	    function change2link(){
          var code3=document.getElementsByName("crudObject.audit_found")[0].value; 
        
          var code4=document.getElementsByName("crudObject.audit_matter")[0].value; 
      
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

        function closeGenM(){
         window.parent.closeGenW('MS');
         window.close()
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
          if(codeArray3!=null)
          {
            for(var a=0;a<codeArray4.length;a++)
            {
             if(codeArray4[a]!=null&&codeArray4[a]!='')
             {
               if(tt3=='')
               {
                 tt3='<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
               }else{
                tt3=tt3+'&nbsp;&nbsp;<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
               }
              }
             }
           p2.innerHTML= tt3 ;
         }
        }

     
	    
	    
	   function test1()
	   {
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
	    </script>


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
	       var tObject = ((tdObject.parentNode).parentNode).parentNode;
	       if(tObject.id == tableId &&tdObject.id != noEdiId&&editer_table_cell_tag == false && run_edit_flag == true)
	       {
	         var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;
	         tdObject.innerHTML = "<input type='text' id='edit_table_txt' name='edit_table_txt' value='"+tdObject.innerText+"' size='15' onKeyDown='enterToTab()'>  <input type=button value=' 确定 ' onclick='certainEdit()'>";
		     editer_table_cell_tag = true;
		   
	       }else{
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
            if(event.srcElement.type != 'button' && event.srcElement.type != 'textarea'&& event.keyCode == 13)
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
		    
	          }else{
		         //如果当前没有编辑框,则编辑成功,否则,无法提交
		         //必须按确定按钮后才能正常提交
		        if(editer_table_cell_tag == false)
		        {
			       alert("编辑成功结束!请点页面下方的保存按钮保存数据!");
			       event.srcElement.value = "开始编辑"; 
			       run_edit_flag = false;
			       //var t=document.getElementById('subModelHTML');
			       //document.getElementById('audManuscript.subModelHTML').value=t.innerHTML;

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
	           }else{
		          editTip.style.visibility = "hidden";			
	           }	
             }
          </SCRIPT>

		  <script type="text/javascript">
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
		   function deleteCell()
			 { 
			 	var flag=true;
			 	if(editer_table_cell_tag == false)
					 {
							
                     }else{
						 alert("请先点'确定'按钮,确定修改的内容!");
						 return false;
					 }
				 
			 	 var tdObject = event.srcElement;
			 	 var tpObject = ((tdObject.parentNode).parentNode).parentNode;	
			 	    if(flag){

	                	 if(confirm("确认删除本行的数据吗?")){
	                		 
	            			  var tpObject2 = ((tdObject.parentNode).parentNode);
	            			 	  	tpObject.removeChild(tpObject2);
	            			 	
	            			   }else{
	            			 	  	
	            			  }
		                  
	                  }else{ 
		                  alert("一次只能编辑一个表格!请先点本表格'开始编辑'按钮");
		                  return false;
	                  }
  
			 }	 	
		   function fff()
			{ 
			    //var t=document.getElementById('subModelHTML');
			    //run_edit_all = t.innerHTML;
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
					    //var t=document.getElementById('subModelHTML');
					 	 //t.innerHTML=document.getElementById('crudObject.subModelHTML').value;
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
					 var tdObject = event.srcElement;
					 var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;		
				 	 var nodes = ((tpObject.parentNode.lastChild.lastChild.lastChild.childNodes));
				 	 if(flag){
                         if(confirm("确认清空本表格的数据吗?")){
		                    var ulListChild = tpObject.childNodes;
		   		            for(var i=0; i<ulListChild.length; i+=1) {
		   		               var tpObject = (ulListChild[i]);	
		   		               var dd = tpObject.firstChild;
		   					   // alert(tpObject.value );
		   					   if(dd!=null){
		   					      tpObject.removeChild(dd); 
		   					 	}   
		   		              }
		            		 }else{ }
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

         
 
             
             //输入的校验
             function check(){
	           var v_3 = "crudObject.ms_name";  // field
	           var title_3 = '底稿名称';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>100){
	             alert("底稿名称的长度不能大于100字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }  	


	           var v_3 = "crudObject.audit_dept_name";  // field
	           var title_3 = '被审计单位';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>2000){
	             alert("被审计单位的长度不能大于2000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            var v_3 = "crudObject.audit_dept";  // field
	            var title_3 = '被审计单位';// field name
	            var notNull = 'true'; // notnull
	            var t=document.getElementsByName(v_3)[0].value;
	            if(t.length>2000){
	              alert("被审计单位的长度不能大于2000字！");
	              document.getElementById("crudObject.audit_dept_name").focus();
	              return false;
	            }
	            var v_3 = "crudObject.linkManuName";  // field
	            var title_3 = '引用底稿';// field name
	            var notNull = 'true'; // notnull
	            var t=document.getElementsByName(v_3)[0].value;
	       	    if(t.length>2000){
	              alert("引用底稿的长度不能大于2000字！");
	              document.getElementById(v_3).focus();
	              return false;
	            } 
	            var v_3 = "crudObject.linkManuId";  // field
	            var title_3 = '引用底稿';// field name
	            var notNull = 'true'; // notnull
	            var t=document.getElementsByName(v_3)[0].value;
	            if(t.length>2000){
	              alert("引用底稿的长度不能大于2000字！");
	              document.getElementById("crudObject.linkManuName").focus();
	              return false;
	             }
	             var v_3 = "crudObject.ms_description";  // field
	             var title_3 = '审计记录';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
		             alert("审计记录的长度不能大于2000字！");
		             document.getElementById(v_3).focus();
		             return false;
	             } 
                    
	             var v_3 = "crudObject.audit_con";  // field
	             var title_3 = '审计结论';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
		             alert("审计结论的长度不能大于2000字！");
		             document.getElementById(v_3).focus();
		             return false;
	             }    
                   
	             var v_3 = "crudObject.audit_file";  // field
	             var title_3 = '查阅资料';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
		             alert("查阅资料的长度不能大于2000字！");
		             document.getElementById(v_3).focus();
		             return false;
	             }                   
                   
	             var v_3 = "crudObject.audit_method_name";  // field
	             var title_3 = '审计程序';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
		             alert("审计程序的长度不能大于2000字！");
		             document.getElementById(v_3).focus();
		             return false;
	             }                   
                   
	             var v_3 = "crudObject.audit_law";  // field
	             var title_3 = '法律法规';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
		             alert("法律法规的长度不能大于2000字！");
		             document.getElementById(v_3).focus();
		             return false;
	             }

	             var v_3 = "crudObject.audit_regulation";  // field
	             var title_3 = '规章制度';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
		             alert("规章制度的长度不能大于2000字！");
		             document.getElementById(v_3).focus();
		             return false;
	             }

	             var v_3 = "crudObject.audit_dept_feedback";  // field
	             var title_3 = '底稿反馈意见';// field name
	             var notNull = 'true'; // notnull
	             var t=document.getElementsByName(v_3)[0].value;
	             if(t.length>2000){
		             alert("底稿反馈意见的长度不能大于2000字！");
		             document.getElementById(v_3).focus();
		             return false;
	             }
	             return true;
	             }

	             //保存表单
	             function saveForm(){

	             var bool = true;//提交表单判断参数

   	             var v_3 = "crudObject.ms_name";  // field
	             var title_3 = '底稿名称';// field name
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

                 v_3 = "crudObject.groupName";  // field
                 title_3 = '所属小组';// field name
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
                                    
                  v_3 = "crudObject.audit_dept_name";  // field
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

 	
			   //完成保存表单操作
			   if(bool){
			     if(editer_table_cell_tag == false)
						 {
						
						 }else{
							 alert("请先点'确定'按钮,确定修改的内容!");
							 return false;
						 }
			    var flag=window.confirm('确认保存吗?');//isSubmit
			     if(flag==true){
			    	//var t=document.getElementById('subModelHTML');
					//document.getElementById('crudObject.subModelHTML').value=t.innerHTML;
			    	var url = '${contextPath}/operate/manu/save.action?back=<%=pb%>';
			    	 myform.action = url;
			     	document.getElementsByName("root")[0].disabled=true;
			    	 myform.submit();
			     }else{
				 	 return false;
				  }
			    }
			}

            //提交
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
			
			
			    var bool = true;//提交表单判断参数

	            var v_3 = "crudObject.ms_name";  // field
	            var title_3 = '底稿名称';// field name
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

                 v_3 = "crudObject.groupName";  // field
                 title_3 = '所属小组';// field name
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
                                    
                  v_3 = "crudObject.audit_dept_name";  // field
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

 	
		       //完成保存表单操作
		       if(bool){
				 if(editer_table_cell_tag == false)
							{
								
	
							}else{
								alert("请先点'确定'按钮,确定修改的内容!");
								return false;
							}
				 var flag=window.confirm("您确认提交吗?");
				 if(flag==true)
				 {
					//var t=document.getElementById('subModelHTML');
				    //document.getElementById('crudObject.subModelHTML').value=t.innerHTML;
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
	}



			//提交表单
			function submitForm(){
			       var v_3 = "crudObject.ms_name";  // field
			var title_3 = '底稿名称';// field name
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

                 v_3 = "crudObject.groupName";  // field
                 title_3 = '所属小组';// field name
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
    
    			if(document.getElementsByName("formInfo.toActorId_name")[0]!=null&&document.getElementsByName("formInfo.toActorId_name")[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert("请选择下一步处理人！");
				         bool = false;
				         document.getElementById("formInfo.toActorId_name").focus();
				         return false;
		           }
				var flag=window.confirm('确认提交吗?');
				if(flag==true){
				 
				 document.getElementById("submitButton").disabled=true;
				 myform.submit();
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
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_manuscript_operate&table_guid=file_id&guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
</script>



		<script>
  
 		
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
 		
 		function testStatus(){
 		  document.getElementsByName('crudObject.ms_status')[0].value='040';
 		  var d=document.getElementsByName('crudObject.ms_status')[0].value;
 		  //alert(d);
 		}

	</script>
		 
		 
		 
		 
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>



	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body  scroll="yes"  class="easyui-layout"
			 oncontextmenu=self.event.returnValue=false>
	</s:if>
	<s:else>
		<body   scroll="yes" class="easyui-layout"
			 oncontextmenu=self.event.returnValue=false>
	</s:else>
	<div  region="center"  style="overflow:auto;">
	<s:form id="myform" action="submit" namespace="/operate/manu"
			onsubmit="testStatus()">
	
	  <div style="display: none;">
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
						<font color="red">*</font> 底稿名称:
					</td>
					<!--标题栏-->
					<td>
						<s:textfield name="crudObject.ms_name" />
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

						<font color="red">*</font> 所属小组:
					</td>
					<!--标题栏-->
					<td>
						<s:textfield name="crudObject.groupName" cssStyle="width:80%"
							readonly="true" />
						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getOwerGroup()" border=0 style="cursor: hand">
						<s:hidden name="crudObject.groupId" />
					</td>

					<td>
					</td>
					<!--标题栏-->
					<td>
					</td>

				</tr>

				<tr>
					<td class="titletable1">
						<font color="red">*</font> 被审计单位:
					</td>
					<td class="titletable1" colspan="3">

						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getGroup();" border=0 style="cursor: hand">
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
					<s:hidden name="crudObject.audit_dept" />
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
						<s:hidden name="crudObject.project_id" />
						<s:hidden name="crudObject.ms_author_name" />
						<s:hidden name="crudObject.ms_author" />
					</td>
					<td>

						&nbsp;&nbsp;&nbsp;创建日期:
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

				<tr>
					<td class="titletable1">

						<font color="red"></font>&nbsp;&nbsp;&nbsp;引用底稿:
					</td>
					<td class="titletable1">
						<s:textfield name="crudObject.linkManuName" cssStyle="width:80%"
							readonly="true" />
						<!--一般文本框-->
						<s:hidden name="crudObject.linkManuId" />
						<img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="getOwerManu()" border=0 style="cursor: hand">
					</td>
					<td class="titletable1" colspan="2">


					</td>

				</tr>
				<tr>
					<td class="titletable1">

						&nbsp;
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
							<s:hidden name="crudObject.ms_description" />

						</s:if>
						<s:if test="crudObject.interact==2">
							<div id="subModelHTML" runat="server"
								style="border-style: none; left: 0px; overflow: scroll; width: 100%; position: relative; top: 0px; height: 260px;">

								<s:property escape="false" value="crudObject.subModelHTML" />
							</div>
							<s:hidden name="crudObject.subModelHTML" />
							<s:hidden name="crudObject.ms_description" />

						</s:if>
						<s:else>
							<s:hidden name="crudObject.subModelHTML" />
							<s:hidden name="subModelHTML" />
							<s:textarea name="crudObject.ms_description"
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

						<s:textarea name="crudObject.audit_con"
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

						<s:textarea name="crudObject.audit_file"
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

						<s:textarea name="crudObject.audit_method_name"
							cssStyle="width:100%;height:70;" />

					</td>
				</tr>
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

						<s:textarea name="crudObject.audit_law"
							cssStyle="width:100%;height:70;" />

					</td>
				</tr>

			   <s:hidden name="crudObject.audit_regulation"/>

					 

				<!--是否启用附件列表和按钮,这里提供的是一般附件上传,如果有特殊的附件上传,单独添加-->
				<tr>
					<td class="ListTableTr11">
						<s:button
							onclick="Upload('crudObject.file_id',file_idList,'true','true')"
							value="上传附件"></s:button>
						<s:hidden name="crudObject.file_id" />
					</td>
					<td class="ListTableTr22" colspan="3">
						<div id="file_idList" align="center">
							<s:property escape="false" value="file_idList" />
						</div>

					</td>
				</tr>

				<s:if test="digaofankui=='enabled'">
					<tr class="listtablehead">

						<td colspan="5" align="left" class="edithead">
							&nbsp;底稿反馈信息
						</td>



					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;反馈意见:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>

					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="crudObject.audit_dept_feedback"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>
				</s:if>
				<s:else>
					<s:hidden name="crudObject.audit_dept_feedback" />
				</s:else>
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<s:hidden name="back" value="<%=pb%>" />
				<s:hidden name="crudObject.id" />
				<s:hidden name="crudObject.task_code_sort" />
				<s:hidden name="crudObject.ms_code_sort" />
				<s:hidden name="taskInstanceId" />
				<s:hidden name="crudObject.prom" />
                <s:hidden name="crudObject.feedback" /> 
                <s:hidden name="crudObject.batch"/>
                <s:hidden name="owner" />
			</table>
           </div>
           <table  cellpadding=0 cellspacing=0 border=0  class="ListTable" align="center">
		<tr>
			 
			<td width=34% class="EditHead">
				<center>
					底稿名称
				</center>
			</td>
			<td width=33% class="EditHead">
				<center>
					底稿作者
				</center>
			</td>
			<td width=33% class="EditHead">
				<center>
					创建日期
				</center>
				
			</td>
			 
		</tr>
		<s:iterator value="manuInfoList">
			<tr>
				<td class="editTd">
				<center>
					<s:property value="ms_name" />
				</center>
				</td>
				<td class="editTd">
					<center>
						<s:property value="ms_author_name" />
					</center>
				</td>
				<td class="editTd" >
				<center>
					<s:property value="ms_date" />
					</center>
				</td>
				 
			</tr>
		</s:iterator>
	</table>
			 
			<s:hidden name="crudObject.formId" />
			<div align="right">
				<%if("true".equals(pb)){%>
				<% }else{%>
				<% if(!"true".equals(owner)){ %>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="close_bat();">返回</a>
				&nbsp;&nbsp;
				<% } %>
				<% }%>
			</div>
		 
			
		</s:form>
		</div>
	</body>
</html>
