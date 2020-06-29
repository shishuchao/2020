<!DOCTYPE HTML>
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

<s:if test="type == 'YD'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'增加疑点'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'修改疑点'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'FX'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加发现'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'修改发现'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'DS'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加重大事项'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'修改重大事项'"></s:text>
	</s:else>
</s:if>



<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><s:property value="#title" /></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script language="javascript">
		$(document).ready(function(){
			$("#audit_law").attr("maxlength",3000);
			$("#doubt_content").attr("maxlength",3000);
			$('#audDoubt_file').fileUpload({
				fileGuid:'${audDoubt.file_id}'
			});
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
	
		
		$(function(){
			$('#atTreeWrap').window({
				width:700,   
				height:460,   
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:true,
				closed:true
			});
			
			$('#win').window({
				width:700,   
				height:230,   
				modal:true,
				title:"录入处理无问题原因",
				collapsible:false,
				maximizable:true,
				minimizable:true,
				closed:true
			});
			
			// 打开问题类别树窗口
	    	$('#wtlbTreeSelectWrap').window({   
				width:700,   
				height:460,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
			
			// 打开政策法规树窗口
		    $('#zcfgOnlyTreeSelectWrap').window({   
				width:760,   
				height:460,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
			
			//=============== 回显select框==============
			if ('${audDoubt.doubt_id}' != '') {
				$('#audit_dept').combobox('setValue','${audDoubt.audit_dept}');
				$('#auditGroup').combobox('setValue','${audDoubt.groupId}');
			}
			//设置select框高度
			loadSelectH()
			// 加载问题类别树
	    	$('#wtlbTreeSelect').tree({
				url:"<%=request.getContextPath()%>/adl/getWtlbTree.action",
				lines:true,
		        onClick:function(node){},
				onDblClick:function(node){
					$('#sureSelectWtlbTreeNode').trigger('click');
				}
			});
			
			// 加载政策法规树
		    $('#zcfgOnlyTreeSelect').tree({   
				url:"<%=request.getContextPath()%>/adl/getZcfgTree.action",
				lines:true,
		        onClick:function(node){},
				onDblClick:function(node){
					$('#sureSelectzcfgOnlyTreeNode').trigger('click');
				}
			});
			//添加问题点/
			$('#sureSelectWtlbTreeNode').bind('click',function(){
				var node = $('#wtlbTreeSelect').tree('getSelected');
				if((node.children == null || node.children == '') && node.state != 'closed'){
					$('#wtlbDm').val(node.id);
					$('#wtlbMc').val(node.text);
					var attrs = node.attributes.replace(/\n/g,'\\n').replace(/\r/g,'\\r').replace(/\t/g,'\\t');
					var json = eval('('+ attrs +')');
					$('#zcfgMc').val(json.desc);
					$('#wtlbTreeSelectWrap').window('close');
				}else{
					$.messager.alert('提示信息','只能选择【问题点】！', 'error', function(){  });
					return false;
				}
			
			});
			//添加政策依据
			$('#sureSelectzcfgOnlyTreeNode').bind('click',function(){
				var node = $('#zcfgOnlyTreeSelect').tree('getSelected');
				if((node.children == null || node.children == '') && node.state != 'closed'){
					$('#zcfgDm').val(node.id);
					$('#zcfgMc').val(node.text);
					$('#zcfgOnlyTreeSelectWrap').window('close');
				}else{
					$.messager.alert('提示信息','只能选择叶子节点！', 'error', function(){  });
					return false;
				}
			});
			
			$('#clearSelectWtlbTreeNode').bind('click',function(){
				$('#wtlbMc,#wtlbDm').val('');
				$('#wtlbTreeSelectWrap').window('close');
			});
		
			$('#clearSelectzcfgOnlyTreeNode').bind('click',function(){
				$('#zcfgMc,#zcfgDm').val('');
				$('#zcfgOnlyTreeSelectWrap').window('close');
			});
			
			//问题类别click事件
			$('#lr_openWtlbTree').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('open');
			});
			//政策法规click事件
			$('#lr_openzcfgOnlyTree').bind('click',function(){
				$('#zcfgOnlyTreeSelectWrap').window('open');
			});
			//添加审计事项
			$('#sureAtTree').bind('click',function(){
	            var node =  $('#atTree').tree('getSelected');
	            if(node && $('#atTree').tree('isLeaf',node.target)){
	                var arr = node.text.split("<font style=\"color:red;\">");
	             	var wtlbMc = node.text;
	             	for(var i=0; i<arr.length; i++){
	             		wtlbMc = wtlbMc.replace("<font style=\"color:red;\">","").replace("</font>","");
	             	}
	                $('#task_id').val(node.id);
	                // $('#task_name').val(wtlbMc);
	                doTaskName();
	                $('#atTreeWrap').window('close');
	             }else{
	                $.messager.alert('提示信息','只能选择末级节点','error');
	             }					
			});
			$('#clearAtTree').bind('click',function(){
				$('#task_id,#task_name').val('');
	            $('#atTreeWrap').window('close');
			});
			$('#exitAtTree').bind('click',function(){
				$('#atTreeWrap').window('close');
			});
			$('#searchAtTree').bind('click',loadSjsxTree);
			loadSjsxTree();
			
		});
		//====================== js加载方法end ================================
		//加载审计事项树
		function loadSjsxTree(){
	    	var contion_taskName=$("#contion_taskName").val();
            $.ajax({
                url : "<%=request.getContextPath()%>/adl/getAuditTaskTree.action",
                dataType:'json',
                cache:false,
                type:"POST",
                data:{'showmanusum':'1','projectId':'${project_id}','contion_taskName':contion_taskName,'isdigao':'Y'},
                success:function(data){
                    if(data.type == 'success'){
                        var treeData = data.atTreeJson;
                        $('#atTree').tree({
                            lines:true,
                            data:treeData,
                            onlyLeafCheck:true,
                            onDblClick:function(node){
                                $('#sureAtTree').trigger('click');
                            }
                        }); 
                    }else{
                        $.messager.alert('提示信息',data.msg, 'error');
                    }
                }
            });
	    }
		//添加审计事项
		function doTaskName(){
       		var task_id = $("#task_id").val();
       		var projectid = "${project_id}";
       		if(task_id != ""){
       			$.ajax({
       			   type: "POST",
       			   url: "${contextPath}/proledger/problem/save!resetTaskName.action",
       			   data: {"getMethod":"1","task_id":task_id,"projectid":projectid},
        			   success: function(msg){
        				  var arr = msg.split("||");
        				  var ms_name =document.getElementsByName("audDoubt.doubt_name")[0].value;
        				  if(ms_name == "" ){
        					  $("#doubt_name").val(arr[0]);
        				  }
        				  
        			      $("#task_name").val(arr[0]);
        			      var content = $('#crudaudit_record');
        			      //先去掉审计记录自动添加的一句话
        			      var s2 = '';
        			      //var s2 = "\n\n结论意见（按审计人员的岗位分工或查证要点，逐条提出评价意见）:";
        			      var s = (arr[1]==null||arr[1]=='null')?'':arr[1];
        			      s += s2;
        			      var t = content.val();
        			      content.focus().val(t ? t+'\n'+s : s);
        			      //content.focus().val(s);
        			      //content.autoResizeTexareaHeight();        			      
        			   }
       			});
       		}
        }
	    //查看疑点
	    function go(s){
	      window.open("${contextPath}/operate/doubt/view.action?doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    
	     //选择小组
	     function getGroup(){
            var name=document.getElementsByName("audDoubt.groupName")[0].value; 
        	var code=document.getElementsByName("audDoubt.groupId")[0].value; 
        	var num=Math.random();
			var rnm=Math.round(num*9333333333+1000000000);
			//alert(rnm);
        	var url='/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/task/selectDept.action&a=a&x='+rnm+'&group_id='+code+'&paraname=audDoubt.audit_dept_name&paraid=audDoubt.audit_dept';
            //alert(url);
            //alert(code);
        	if(name==null||name==""){
            	alert("请先选择所属小组!");
                return false;
        	}
        	showPopWin(url,500,330,'被审计单位选择');
        } 
        //选择小组
         function  getOwerGroup(){

            var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
        	var code=document.getElementsByName("project_id")[0].value; 
        	 
        	showPopWin('/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectGroup.action&a=a&x='+rnm+'&project_id='+code+'&paraname=audDoubt.groupName&paraid=audDoubt.groupId',500,330,'所属小组选择');
        } 
	    //选择事项
	     function  getOwerTask(){

            var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
        	var code=document.getElementsByName("audDoubt.project_id")[0].value; 
        	 
        	showPopWin('/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/diary/selectTask.action&a=a&x='+rnm+'&project_id='+code+'&paraname=audDoubt.task_name&paraid=audDoubt.task_id',500,330,'所属审计事项选择');
         } 
         //查看底稿
	    function go1(s){
	    
	     	window.open("${contextPath}/operate/manu/view.action?crudId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    
	    //显示关联的底稿为链接
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
	        var strName4='关联重大事项';
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
	          tt4='<a href=# onclick=go1(\"'+codeArray5[0]+'\")>'+strName5+'</a>';
	          tt4=tt4+"<br />";
	        }
	 		p.innerHTML=tt1+tt2+tt3+tt4+tt5;
		}
	
	
		 //生成
       function generateMS(s)
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
		       title = "生成重大事项";
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
	            myform.submit();
	      }
	                    
		} 
		//处理
		function exe(){
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
			if (confirm("是否设置为已处理状态?")) {
				document.getElementsByName("audDoubt.doubt_status")[0].value="050"
				//audDoubt.doubt_status
		      	var url = "${contextPath}/operate/doubt/save.action";
				myform.action = url;
				myform.submit();
	         }else{
		 
	         } 
		}
		
		//法规制度
		function regu(){
		   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		}
		//法规制度
		function law(){
		   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
		}
		//返回
		function backList(){
			myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&taskId=${taskId}&taskPid=${taskPid}&project_id=${project_id}";
			myform.submit();
		}
		//关闭
		function closeGenW(s){
			window.location.reload();
			//alert(s);
			window.parent.document.frames[s].location.reload(); 
			
			 //window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type=<s:property value="type" />&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>";
		}
		//不能为空检查
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

		//输入检验
		function check(){

            var doubt_name =  $("#doubt_name").val(); 
            if ( doubt_name == null || doubt_name == ""){
          	  showMessage1("疑点名称不能为空！")
          	  return false;
            } 
            if ( doubt_name.replace(/\s+$|^\s+/g,"")==""){
          	  showMessage1("疑点名称不能为空！")
          	  return false;
            }
            if ( doubt_name.length>50){
            	 showMessage1("疑点名称的长度不能大于50字空！")
             	 return false;
            }
            
            
            var task_name =  $("#task_name").val(); 
            if ( task_name == null || task_name == ""){
          	  showMessage1("审计事项不能为空！")
          	  return false;
            } 
            if ( task_name.replace(/\s+$|^\s+/g,"")==""){
          	  showMessage1("审计事项不能为空！")
          	  return false;
            }


            return true;
		/* 	var v_3 = "audDoubt.audit_regulation";  // field
			var title_3 = '规章制度';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>2000){
				alert("规章制度的长度不能大于2000字！");
				document.getElementById(v_3).focus();
				return false;
			}
			return true; */
		}

 
                  
 


		//-------保存表单
		function saveForm(){
			try{
       

                 v_3 = "audDoubt.groupId";  // field
                 title_3 = '所属小组';// field name
                 var notNull = 'true'; // notnull
                 	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 	        	  parent.parent.$.messager.show({
                  		        	 title:"提示信息",
                  		         	 msg:title_3+"不能为空!",
                  		         	 timeout:5000
                  		         });
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                	  parent.parent.$.messager.show({
                      		        	 title:"提示信息",
                      		         	 msg:title_3+"不能为空!",
                      		         	 timeout:5000
                      		         });
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                        }
                        
                  v_3 = "audDoubt.audit_dept";  // field
                 title_3 = '被审计单位';// field name
                 var notNull = 'true'; // notnull
                 	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
                 		           {
                 	        	  parent.parent.$.messager.show({
                   		        	 title:"提示信息",
                   		         	 msg:title_3+"不能为空!",
                   		         	 timeout:5000
                   		         });
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                 		           }
                                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                                	  parent.parent.$.messager.show({
                       		        	 title:"提示信息",
                       		         	 msg:title_3+"不能为空!",
                       		         	 timeout:5000
                       		         });
                 				         bool = false;
                 				         document.getElementById(v_3).focus();
                 				         return false;
                                    }   
                                  

                  	  if( !check()){
                         return false;
               	      }                 
                   var auth=''; 
       			   var taskTemplateId =document.getElementsByName('audDoubt.task_id')[0].value;
			       DWREngine.setAsync(false);
				   DWREngine.setAsync(false);DWRActionUtil.execute(
				   { namespace:'/operate/task', action:'checkSubTask', executeResult:'false' }, 
				   {'project_id':'<%=request.getParameter("project_id")%>','taskTemplateId':taskTemplateId},xxx);
				    function xxx(data){
					  auth =data['auth'];
					}
				 
				  if(auth=='2'||auth=='3'){
				 
				 }else{
					 alert("请刷新页面,该审计事项不是末级节点,不能增加审计疑点!");
					 return false;
				 }
		                           
				 var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
				 var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		         if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                	  parent.parent.$.messager.show({
		     		        	 title:"提示信息",
		     		         	 msg:"没有权限操作！",
		     		         	 timeout:5000
		     		         });
		                    return false;
		           }
		           
		            if(p=='050'){
		            	parent.$.messager.show({
				        	 title:"提示信息",
				         	 msg:"已处理状态，不能执行操作！",
				         	 timeout:5000
				         });
		                    return false;
		                  }else{
		            }
		              
		             if(editer_table_cell_tag == false)
						{
							

						}else{
							alert("请先点'确定'按钮,确定修改的内容!");
							return false;
						}
					var t = document.getElementById('subModelHTML');
					$('#audDoubt.subModelHTML').val($("#subModelHTML").html());
					var url = "${contextPath}/operate/doubt/saveFap.action";
					document.getElementById("saveFormFX").disabled=true;
					myform.action = url;
					myform.submit();
				}catch(e){
					alert("出错啦！");
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
		<script language="JavaScript">
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
 
			 }	 
			 
			 	
			function fff()
			 { 
			 	var t=document.getElementById('subModelHTML');
			 	run_edit_all = t.innerHTML;
			 	
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

		       	if(flag){
 					if(confirm("确认清空本表格的数据吗?")){
			         	var ulListChild = tpObject.childNodes;
			   			for (var i=0; i<ulListChild.length; i+=1) {
			   		     	var tpObject = (ulListChild[i]);	
			   		     	var dd = tpObject.firstChild;
			   				if(dd!=null){
			   					 	tpObject.removeChild(dd); 
			   				}   
			   		   	}
		            			 	
		            }else{
		            }
	               document.getElementById('audDoubt.subModelHTML').value="";
  				}
			}		 
 		</script>
	</head>



	<body onload=Test();>
	<div class="easyui-layout" fit="true">
		<div region="center">
				<div style="width: 100%;position:absolute;top:0px;"  >
				<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
				<tr class="EditHead" >
					<td  style="text-align:left;">
						<s:property value="#title" />
					</td>
					<td style="text-align: left;" >
						<span style='float: right; text-align: right;'>
						<a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>
						
						</span>
						</td>
				</tr>
			</table>
			</div>
			<s:form id="myform" method="post" cssStyle="width: 100%">
				<table class="ListTable" align="center" style="margin-top: 40px"> 
					<tr>
						<td style="width: 15%" class="EditHead">
							<font color="red">*</font> 疑点名称
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<s:textfield id="doubt_name" name="audDoubt.doubt_name"  cssStyle='width:90%' cssClass="noborder" maxlength="500"/>
						</td>
						<td style="width: 15%" class="EditHead">状态</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<s:if test="audDoubt.doubt_status == '010'">未处理</s:if>
							<s:if test="audDoubt.doubt_status == '020'">等待批示</s:if>
							<s:if test="audDoubt.doubt_status == '030'">正在审批</s:if>
							<s:if test="audDoubt.doubt_status == '040'">审批完毕</s:if>
							<s:if test="audDoubt.doubt_status == '050'">已处理无问题</s:if>
							<s:if test="audDoubt.doubt_status == '055'">已处理有问题</s:if>
							<!--  s:property value="audDoubt.doubt_status" /-->
							<s:hidden name="audDoubt.doubt_status" />
						</td>
					</tr>
					<tr>
			<%-- 			<td class="EditHead" style="width: 15%">
							<font color="red">*</font> 审计小组 
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
	 						<select id="auditGroup" class="easyui-combobox" name="audDoubt.groupId" editable="false" panelHeight="auto">
								<s:iterator id="list" value="groupList" >
								    <option value="<s:property value='#list.groupId'/>"><s:property value='#list.groupName'/></option>
								</s:iterator>
							</select>
	 						<s:hidden name="audDoubt.groupName"/>
						</td> --%>

						<td  class="EditHead">
							<font color="red">*</font> 被审计单位 
						</td>
						<td class="editTd">
						<select id="audit_dept" class="easyui-combobox" panelHeight="auto" name="audDoubt.audit_dept"   editable="false" >
					       <s:iterator value="auditObjectMap" id="entry">
						         <s:if test="${audDoubt.audit_dept==key}">
					       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
					       		 </s:if>
					       		 <s:else>
							        <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       		 </s:else>
					       </s:iterator>
					    </select>
 						</td>
 						<td class="EditHead" style="width: 15%">
						
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
	 				
							<s:hidden name="audDoubt.groupId"/>
	 						<s:hidden name="audDoubt.groupName"/>
						</td>
					</tr>

					<tr>
						<td  class="EditHead">
							疑点编码<br/><font color="red" size="2">(自动生成,请谨慎修改)</font>
						</td>
						<!--标题栏-->
						<td class="editTd" >
								<s:property value="audDoubt.doubt_code" />
								<s:hidden name="audDoubt.doubt_code" />
						</td>
						<td class="EditHead">
							<font color="red"></font>撰写人
						</td>
						<td class="editTd">
							<s:property value="audDoubt.doubt_author" />
							<s:hidden name="audDoubt.doubt_author_code" />
							<s:hidden name="audDoubt.doubt_author" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font> 审计事项
						</td>
						<td class="editTd">
							<input type="text" name="audDoubt.task_name" value="${audDoubt.task_name}" id="task_name" style='width:90%' readonly="readonly" class="noborder">
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="$('#atTreeWrap').window('open')"></a>
							<s:hidden name="audDoubt.task_id" id="task_id" />
							<s:hidden name="audDoubt.task_code" />
						</td>
						<td class="EditHead">
							<font color="red"></font>提交日期
						</td>
						<!--标题栏-->
						<td class="editTd">
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
					<s:hidden name="audDoubt.interact" />
					<s:hidden name="audDoubt.do_code_sort" />
					<s:hidden name="audDoubt.task_code_sort" />
					<tr>
						<td class="EditHead">关联索引</td>
						<td class="editTd" colspan="3">
							<span id="p"></span>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<s:if test="type == 'BW'">
		 备忘内容 
</s:if>


							<s:if test="type == 'YD'">
		 疑点内容:
</s:if>

							<s:if test="type == 'FX'">
		 发现内容
	 
</s:if>

							<s:if test="type == 'DS'">
	 重大事项内容 
</s:if>

						</td>
						<td class="editTd" colspan="4" style="padding: 5px 5px 5px 5px">
								<s:textarea id="doubt_content" title="疑点内容"  cssClass='noborder' name="audDoubt.doubt_content"
							                rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						</td>
					</tr>
					<!-- 在线发给来的疑点交互内容只保存成附件excel多表头形式，不提供table html的编辑-->
					<tr style='display:none'>

						<td class="ListTableTr22" colspan="4">
							<div id="subModelHTML" runat="server"
								style="border-style: none; left: 0px; overflow: scroll; width: 100%; position: relative; top: 0px; height: 200px;">

								<s:property escape="false" value="audDoubt.subModelHTML" />
							</div>
							<s:hidden name="audDoubt.subModelHTML" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							法规制度
							<div style='margin-top:3px;'>
							<a id="lr_openZcfgTree" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
							   mc='audit_law' >引用法规制度</a>
							   </div>
							   <div><font color=DarkGray>(限3000字)</font></div>
						</td>
						<td class="editTd" colspan="4" style="padding:5px 5px 5px 5px">
							<s:textarea id="audit_law" cssClass="noborder" title="法规制度" name="audDoubt.audit_law"
							               rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
						</td>
					</tr>
					<s:hidden name="audDoubt.audit_regulation" />
				</table>
				<table class="ListTable" style="width:98%" align="center">
					<tr>
					<!-- fileUpload 组件文件上传 -->
					<td class="EditHead" style="width:14%">附件
					<div id="manu_file"></div>
						<s:hidden id="w_file" name="audDoubt.file_id" />
					</td>
					<td class="editTd" colspan="3" style="width:86%">
						<div id="audDoubt_file"></div>
					</td>
				</tr>
				</table>
				<s:hidden name="newDoubt_type" />
				<s:hidden name="audDoubt.doubt_id" />
				<s:hidden name="audDoubt.project_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				
			</s:form>

		</center>
		<!-- 审计事项树(单选,双击选择） -->
	<div id='atTreeWrap' title='审计事项' style='text-align:center;overflow:hidden;padding:5px; border:1px solid #cccccc;'>
		<div style="text-align:left;padding:0 0 2px 5px;">搜索:
		    <s:textfield id="contion_taskName"  maxLength="100" cssStyle="width:180px;height:24px;padding-top:5px;" ></s:textfield>
		    <button id='searchAtTree'  class="easyui-linkbutton" iconCls="icon-search">搜索</button>
		    <button id='sureAtTree'  class="easyui-linkbutton" iconCls="icon-ok">确定</button>
			<button id='clearAtTree'  class="easyui-linkbutton" iconCls="icon-empty">清空</button>
			<button id='exitAtTree' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button>
		</div>
		<ul id='atTree' style='height:350px; width:99%;text-align:left;border:1px solid #cccccc; border-bottom:0px;padding:5px;overflow:auto;'></ul>
	</div>
	<jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" />	
		
	</body>
</html>
