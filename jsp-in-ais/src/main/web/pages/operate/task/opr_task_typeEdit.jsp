<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String s = (String) request.getParameter("edit");
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title><s:property value="#title" />增加审计事项</title>
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   

<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<style type="text/css">
	.textbox .textbox-text {
   		padding-top: 1px !important;
   		padding-bottom: 1px !important;
	}
</style>

<script language="javascript">

			 function test(s){
		 		if(s==true){
		    		window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
		 		}else{
		 		}
		  
			 }
		
		    
		      function checkItem(){
                try{
                    var resullt=''; 
                    $.ajax({
                        dataType:'json',
                        async:false,
                        url : "<%=request.getContextPath()%>/operate/task/checkItem.action",
                        data: {
                            'taskTemplateId':'${taskTemplateId}',
                            'project_id':'${project_id}'
                        },
                        type: "POST",
                        success: function(data){
                            result = data;           
                        },
                        error:function(data){
                            $.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                        }
                    });
			  		if(result=='1'){
			  			return true;
			  		}else{
			  			return false;
			 		}  
                }catch(e){
                    alert('checkItem:\n'+e.message);
                }
            }
			
			
		      function checkDetail(){
                    var resullt=''; 
                    var s='<%=request.getParameter("taskTemplateId")%>';
                    var q='<%=request.getParameter("project_id")%>';
                 
                    $.ajax({
                        dataType:'json',
                        async:false,
                        url : "<%=request.getContextPath()%>/operate/task/checkDetail.action",
                        data: {
                            'taskTemplateId':s,
                            'project_id':q
                        },
                        type: "POST",
                        success: function(data){
                        	result = data;           
                        },
                        error:function(data){
                            $.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                        }
                    });
                 
                 
                  if(result=='1'){
                    return true;
                  }else{
                    return false;
                  }
                  //Usp.openTabPanelByFrame('yyyyy','修改方案','${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}')
                   
			}
			function check(){
		
				var v_3 = "audTask.taskName";  // field
				var title_3 = '事项类别名称';// field name
				var notNull = 'true'; // notnull
				var t=document.getElementsByName(v_3)[0].value;
				if(t.length>1200){
					$.messager.show({
						title:"提示信息",
						msg:"事项类别名称的长度不能大于1200字！",
						timeout:5000,
						
					});
				document.getElementById(v_3).focus();
				return false;
				} 
		        if('enabled' == '${shenjichengxu}'){
				var v_3 = "audTask.taskTarget";  // field
				var title_3 = '审计目的';// field name
				var notNull = 'true'; // notnull
				var t=document.getElementsByName(v_3)[0].value;
				if(t.length>2000){
					$.messager.show({
						title:"提示信息",
						msg:"审计目的的长度不能大于1200字！",
						timeout:5000,
						
					});
				document.getElementById(v_3).focus();
				return false;
				} 
		
				var v_3 = "audTask.taskFile";  // field
				var title_3 = '备注';// field name
				var notNull = 'true'; // notnull
				var t=document.getElementsByName(v_3)[0].value;
				if(t.length>2000){
					$.messager.show({
						title:"提示信息",
						msg:"备注的长度不能大于1200字！",
						timeout:5000,
						
					});
				document.getElementById(v_3).focus();
				return false;taskTemplateId
				} 
				}


                var taskStartTime = $('#taskStartTime').datebox('getValue');
                var taskEndTime   = $('#taskEndTime').datebox('getValue');
                if(taskStartTime && taskEndTime){
                    taskStartTime = taskStartTime.replace(/(^\s*)|(\s*$)/g,'').replace(/-/g,'');
                    taskEndTime   = taskEndTime.replace(/(^\s*)|(\s*$)/g,'').replace(/-/g,'');
                    if(parseInt(taskEndTime) < parseInt(taskStartTime)){
                        $.messager.show({
                            title:"提示信息",
                            msg:"事项结束时间 应在 事项开始时间 之后"                           
                        });
                        return false;
                    }
                }
				return true;
			}
			 //生成
		      function generateType()
				  {
				    if(!checkItem()){
				      $.messager.show({
							title:"提示信息",
							msg:"该审计事项已经是末级,不能增加子事项!",
							timeout:5000,
							
						});
				      return false;
				    }else{
				      var title="增加类别";
				     if('enabled' == '${shenjichengxu}')
						title="增加审计事项";
				     var p='${audTask.taskTemplateId}';
				     window.paramw = "模态窗口";
		             //window.showModalDialog('${contextPath}/operate/template/addType.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
				     //window.open('${contextPath}/operate/task/addType.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>');
				     showPopWin('${contextPath}/operate/task/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid='+p+'&project_id=<%=request.getParameter("project_id")%>',550,460,title);
				     var num=Math.random();
				     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
				     //document.getElementsByName("newDoubt_type")[0].value=s;
		             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
			         //myform.submit();&type="+type+"&taskPid="+taskPid+"&taskTemplateId="+id+"&audTemplateId=08BCD152-16D0-2750-3EEB-BC30571F3622";
			          }          
			} 
			 
		      function generateType2()
			  {
					title="增加审计类别";
			     var p='${audTask.taskTemplateId}';
			     window.paramw = "模态窗口";
	             //window.showModalDialog('${contextPath}/operate/template/addType.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
			     //window.open('${contextPath}/operate/task/addType.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>');
			     showPopWin('${contextPath}/operate/task/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid='+p+'&project_id=<%=request.getParameter("project_id")%>',550,460,title);
			     
			     var num=Math.random();
			     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			     //document.getElementsByName("newDoubt_type")[0].value=s;
	             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
		         //myform.submit();&type="+type+"&taskPid="+taskPid+"&taskTemplateId="+id+"&audTemplateId=08BCD152-16D0-2750-3EEB-BC30571F3622";
		} 
		
			function generateLeaf2(){
					title="增加审计事项";
			     var p='${audTask.taskTemplateId}';
			     window.paramw = "模态窗口";
			     showPopWin('${contextPath}/operate/task/addTypenew.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid='+p+'&project_id=<%=request.getParameter("project_id")%>',550,460,title);
			     var num=Math.random();
			     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				     
			} 		
		      
			function generateLeaf()
				  {
				      if(!checkDetail()){
				      $.messager.show({
							title:"提示信息",
							msg:"已经增加了下级节点,不能增加详细内容,请到末级节点增加详细内容!",
							timeout:5000,
							
						});
				      return false;
				    }else{
				     var title="增加详细";
				     if('enabled' == '${shenjichengxu}')
						title="增加审计程序";
				     window.paramw = "模态窗口";
				      var p='${audTask.taskTemplateId}';
		             //window.open('${contextPath}/operate/task/addLeaf.action?type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>');
				     showPopWin('${contextPath}/operate/task/showContentTypeDetailEdit.action?node=${node}&path=${path}&tab=item&taskpid=&taskPid='+p+'&type=1&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',550,460,title);
				     
				     //showPopWin('${contextPath}/operate/template/showContentTypeDetail.action?type=1&selectedTab=item&node=<%=request.getParameter("taskTemplateId")%>&tab=item&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',550,460,title);
				      
				     var num=Math.random();
				     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				     
				     //type=2&taskTemplateId=43917C5D-4745-7041-BD03-56243A457B3C&project_id=62AC552B-1366-BBB4-8198-A4DF4F584884
				     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
				     //document.getElementsByName("newDoubt_type")[0].value=s;
		             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
			         //myform.submit();
			       }             
			} 
			
			
		function saveFormType(){
			//对执行小组进行非空判断
// 			if(!checkItem()){
// 				document.getElementsByName('audTask.template_type')[0].value='2';
// 			}
					   
			var resullt=''; 
		    var code='';
		    var codeAll='';
					    
				 
			var project_id = '${project_id}';
			var taskPid = '${taskPid}';
			var taskTemplateId = '${taskTemplateId}';
			var memIds = $("#audTask_taskAssign").val();
			var memAllIds='';
            /*
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);
            DWRActionUtil.execute(
				{ namespace:'/operate/task/project', action:'checkMembers',executeResult:'false' }, 
				{'project_id':project_id,'taskPid':taskPid,'taskId':taskTemplateId,'memIds':memIds,'memAllIds':memAllIds},
                xxx);
            function xxx(data){
             	result =data['auth'];
               //alert(data['auth']);
            } 
            */
            $.ajax({
                dataType:'json',
                async:false,
                url : "<%=request.getContextPath()%>/operate/task/project/checkMembers.action",
                data: {
                    'project_id':project_id,
                    'taskPid':taskPid,
                    'taskId':taskTemplateId,
                    'memIds':memIds,
                    'memAllIds':memAllIds
                },
                type: "POST",
                success: function(data){
                    result = data;        
                },
                error:function(data){
                    $.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
            
            
            if(result==''||result==null){
                
            }else{
                if( confirm(result+"在下级节点已经分工，是否删除本级节点的分工?\n点'确定'按钮保存本级节点分工，点'取消'按钮重新设置本级节点分工。")){
             
                }else{
                    return false;
                }
            }		   
        
            var v_3 = "audTask.taskName";  // field
            var title_3 = '事项类别名称';// field name
            var notNull = 'true'; // notnull
            if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "") {
                    $.messager.show({
                           title:"提示信息",
                           msg:title_3+"不能为空!",
                           timeout:5000,
                           
                    });
                    bool = false;
                    document.getElementById(v_3).focus();
                    return false;
            }
            if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                 $.messager.show({
                        title:"提示信息",
                        msg:title_3+"不能为空!",
                        timeout:5000,
                        
                    });
                     bool = false;
                     document.getElementById(v_3).focus();
                     return false;
            }
			
			
			
			if(!check()){
			   return false;
			}
			var url = "${contextPath}/operate/task/saveType.action";
			myform.action = url;
			myform.submit();
			showMessage1('保存成功');
			window.parent.parent.frames['f_left'].location.reload();
			 
		}
		
		function onlyNumbers1(s){		 
		 re = /^\d+\d*$/
		 var str=s.replace(/\s+$|^\s+/g,"");
		 if(str==""){
		 return false;
		 }
		 if(!re.test(str))
		 {
		  $.messager.show({
				title:"提示信息",
				msg:"事项序号只能输入正整数，请重新输入！",
				timeout:5000,
				
			});
		  return true ;   
		 }
		}
			
			//模板生成----------保存表单
		function saveFormLeaf(){
		//alert("111");
		
		var v_3 = "audTask.taskName";  // field
		var title_3 = '事项类别名称';// field name
		var notNull = 'true'; // notnull
			           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
				           {
			        	   $.messager.show({
								title:"提示信息",
								msg:title_3+"不能为空!",
								timeout:5000,
								
							});
						         bool = false;
						         document.getElementById(v_3).focus();
						         return false;
				           }
		                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                	 $.messager.show({
									title:"提示信息",
									msg:title_3+"不能为空!",
									timeout:5000,
								});
						         bool = false;
						         document.getElementById(v_3).focus();
						         return false;
		                   }
		
		
		
		
		/*
		var v_2 =  "audTask.taskOrder"
		
		var title_2 = '事项序号';// field name
		var notNull = 'true'; // notnull
			           if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != "")
				           {
						         window.alert(title_2+"不能为空!");
						         bool = false;
						         document.getElementById(v_2).focus();
						         return false;
				           }
		                 if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                        window.alert(title_2+"不能为空!");
						         bool = false;
						         document.getElementById(v_2).focus();
						         return false;
		                   }
		
		
		var s = document.getElementsByName(v_2)[0].value;
		if(onlyNumbers1(s)){
		 document.getElementById(v_2).focus();
		return false;
		}
		*/
		if(!check()){
		 return false;
		}
		var url = "${contextPath}/operate/task/saveLeaf.action";
		myform.action = url;
			myform.submit();
			//alert('${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>');
			//parent.location.href='${contextPath}/operate/template/main.action?audTemplateId='+<%=request.getParameter("audTemplateId")%>;
			window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?project_id=<%=request.getParameter("project_id")%>';
			//alert(window.top.frames['f_left']);
			 
		}
			 //生成
		      function generate(s)
				  {
				     d_id=document.getElementsByName("doubt_id")[0].value;
				     n_type=s;
				     d_type=document.getElementsByName("type")[0].value;
				     window.paramw = "模态窗口";
		             window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
				     var num=Math.random();
				     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
				     //document.getElementsByName("newDoubt_type")[0].value=s;
		             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
			         //myform.submit();
			                    
			} 
			
			
			function checkManu(){
			    var resullt=''; 
			    var s='${project_id}';
			    var taskPid='${audTask.taskPid}';
			    var taskId='${audTask.taskTemplateId}';			 
                $.ajax({
                    dataType:'json',
                    async:false,
                    url : "<%=request.getContextPath()%>/operate/task/manuListByPid.action",
                    data: {
                        'project_id':s,
                        'taskPid':taskPid,
                        'taskId':taskId
                    },
                    type: "POST",
                    success: function(data){
                        result = data;           
                    },
                    error:function(data){
                        $.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                    }
                });
             
             
                   if(result=='10'){
                        $.messager.show({
                            title:"提示信息",
                            msg:"请先删除该审计事项及其下级节点的审计底稿！",
                            timeout:5000,
                            
                        });
                     return false;
                   }else if(result=='01'){
                       $.messager.show({
                            title:"提示信息",
                            msg:"请先删除该审计事项及其下级节点的审计疑点！",
                            timeout:5000,
                            
                        });
                        return false;
                   }else if(result=='11'){
                       $.messager.show({
                            title:"提示信息",
                            msg:"请先删除该审计事项及其下级节点的审计底稿和审计疑点！",
                            timeout:5000,
                            
                        });
                      return false;
                   }else{
                      return true;
                   }
			  
			}
            function checkDoubt(){
			    var resullt=''; 
			    var s='${project_id}';
			    var taskPid='${audTask.taskPid}';
			    var taskId='${audTask.taskTemplateId}';
                $.ajax({
                    dataType:'json',
                    async:false,
                    url : "<%=request.getContextPath()%>/operate/task/doubtListByPid.action",
                    data: {
                        'project_id':s,
                        'taskPid':taskPid,
                        'taskId':taskId
                    },
                    type: "POST",
                    success: function(data){
                        result = data;           
                    },
                    error:function(data){
                        $.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                    }
                });
             
                if(result=='1'){
                   //alert("请先删除该审计事项下的疑点！");
                   return false;
                }else{
                   return true;
                }
			  
			}
				 //删除
			      function deleteRecord(){
					   if(!checkManu()){
					     //alert("请先删除该审计事项下的审计底稿和审计疑点！")
					    return false;
					   } 
					   
					  top.$.messager.confirm('提醒',"确认删除这条记录?", function(r){
						   if(r){
								myform.action = "${contextPath}/operate/task/deleteLeaf.action";
					            myform.submit();
					    		window.parent.parent.location.href='${contextPath}/operate/task/mainReadyEdit.action?project_id=<%=request.getParameter("project_id")%>';							   
						   }
					  }); 
					     /*
					  if(confirm("确认删除这条记录?")){
							myform.action = "${contextPath}/operate/task/deleteLeaf.action";
				            myform.submit();
					  }
				   		 window.parent.parent.location.href='${contextPath}/operate/task/mainReadyEdit.action?project_id=<%=request.getParameter("project_id")%>';
				        */            
				} 
			function exe(){
				if (confirm("是否设置为已处理状态?")) {
				document.getElementsByName("audTemplate.doubt_status")[0].value="050"
				//audTemplate.doubt_status
			         saveForm();
		         }else{
			 
		         } 
			}
			function law(){
			   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}
			
			function regu(){
			   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
			}
		             
		function backList(){
			myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&project_id=${project_id}";
			myform.submit();
		}
		
		
		
		//模板生成----------保存表单
		function saveForm(){
		//alert("111");
		var url = "${contextPath}/operate/doubt/save.action";
		myform.action = url;
			myform.submit();
			
			 
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
			        	   $.messager.show({
								title:"提示信息",
								msg:title_3+"不能为空!",
								timeout:5000,
							});
						         bool = false;
						         return false;
				           }
		
		var v_3 = "doubt.staff_str";  // field
		var title_3 = '适用人员描述';// field name
		var notNull = 'true'; // notnull
			           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
				           {
			        	   $.messager.show({
								title:"提示信息",
								msg:title_3+"不能为空!",
								timeout:5000,
							});
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
					window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
		 		

		    
		</script>
	

<s:head />
</head>
<body onload="test(<%=s%>)" class="easyui-layout" border='0'>
	<div region="north" title="事项信息" border='0' style="height:200px; overflow-x:hidden; ">
		<s:form id="myform" onsubmit="return true;" action="/ais/operate/task" method="post">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead"><font color="red">*</font>&nbsp;
						事项类别名称</td>
					<td colspan="3" class="editTd"><s:textarea cssClass="noborder" name="audTask.taskName"
							cssStyle="width:100%;height:50px;overflow-y:hidden;" /> <!--一般文本框--></td>
				</tr>
				<s:hidden name="audTask.taskTemplateId" />
				<s:hidden name="audTask.taskPid" />
				<s:hidden name="audTemplateId" />
				<s:hidden name="taskTemplateId" />
				<s:hidden name="audTask.templateId" />
				<s:hidden name="audTask.id" />
				<s:hidden name="audTask.project_id" />
				
				
				<tr style='display:none;'>
					<td class="EditHead" >
						<font color="red">*</font>&nbsp;&nbsp;事项序号
					</td>
					<td class="editTd">
	       				<s:textfield cssClass="noborder" name="audTask.taskOrder" cssStyle="width:80%" maxlength="3" />		
	       				<s:hidden name="audTask.taskOrder" />							
					</td>							
					<td class="EditHead">
						<font color="red">*</font>&nbsp;事项编码
					</td>
					<td class="editTd">
					       <s:textfield cssClass="noborder" name="audTask.taskCode" readonly="true" cssStyle="width:80%"
							maxlength="20" />
					</td>					
				</tr>				
			 	<tr>
					<td style="width: 130px" class="EditHead">
						事项开始时间
					</td>
					<td class="editTd">
					<input type="text"  id="taskStartTime" name="audTask.taskStartTime" class="easyui-datebox" style="width: 150px; padding-top: 1px; padding-bottom: 1px;"
								value="${audTask.taskStartTime}" editable="false"/>
					</td>
					<td style="width: 130px" class="EditHead">
						事项结束时间
					</td>
					<td class="editTd">
					<input type="text"  id="taskEndTime" name="audTask.taskEndTime" class="easyui-datebox" style="width: 150px; padding-top: 1px; padding-bottom: 1px;"
									value="${audTask.taskEndTime}" editable="false"/>
					</td>
				</tr> 				
				<s:if test="'enabled' == '${shenjichengxu}'">

					<tr>


						<td class="EditHead"><font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项名称:</td>
						<td class="editTd"><s:textfield cssClass="noborder" name="audTask.taskBeforeName"
								cssStyle="width:80%;background-color:#EEF7FF" readonly="true" />
						</td>

						<td class="EditHead"><font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项编码:</td>
						<!--标题栏-->
						<td class="editTd"><s:textfield cssClass="noborder" name="audTask.taskBeforeCode"
								cssStyle="width:80%" readonly="true" /> <img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/task/showTreeListSelect.action&a=a&code=${audTask.taskCode}&project_id=${project_id}&paraname=audTask.taskBeforeName&paraid=audTask.taskBeforeCode',500,330,'前置事项选择')"
							border=0 style="cursor: hand"></td>
						</td>

					</tr>

					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;是否必做:</td>
						<!--标题栏-->
						<td class="editTd"><s:if test="${audTask.taskMust=='1'}">
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust">否
		                        </s:if> <s:else>
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust" checked="checked">否
								</s:else></td>
					</tr>
					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;审计目的:</td>
						<td class="editTd" colspan="3"></td>

					</tr>
					<tr>
						<td class="editTd" colspan="4">
						 <s:textarea cssClass="noborder" name="audTask.taskTarget"
								cssStyle="width:100%;height:90;" />
						</td>
					</tr>

					</tr>

					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;备注:</td>
						<td class="editTd" colspan="3"></td>

					</tr>
					<tr>

						<td class="editTd" colspan="4">
							<s:textarea cssClass="noborder" name="audTask.taskFile"
								cssStyle="width:100%;height:90;" />

						</td>
					</tr>
				</s:if>
			</table>

			<s:hidden name="newDoubt_type" />
			<s:hidden name="audTemplate.doubt_id" />
			<s:hidden name="audTask.haveLevel" />
			<s:hidden name="doubt_id" />
			<s:hidden name="type" />
			<s:hidden name="project_id" />
			<s:hidden name="team" />
			<s:hidden name="audTask.cat_name" />
			<s:hidden name="audTask.cat_code" />
			<s:hidden name="audTask.taskPcode" />
			<s:hidden name="audTask.template_type" />
			<s:hidden name="path" />
			<s:hidden name="node" />
			<div style="position:absolute;top:2px;right:5px;">
				<s:if test="'disabled' == '${shenjichengxu}'">
					<a  href="javascript:void(0);" id="generateType" class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加类别</a>&nbsp;
					<a  href="javascript:void(0);" id="generateLeaf" class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加事项</a>&nbsp;
				</s:if>
				<s:if test="${teamAuth=='1'}">
					<a id="btn" href="javascript:void(0);" onclick="saveFormType();"  class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>&nbsp;
<!-- 					<a id="btn" href="javascript:void(0);" onclick="deleteRecord();" class="easyui-linkbutton" data-options="iconCls:'icon-delete'">删除</a>&nbsp;   -->
				</s:if>

			</div>
		</s:form>
	</div>
		<div region="center" >
			<table id="listTaskDiv"></table>
		</div>
		<div id="addType_div" title="增加类别" style="overflow:hidden">
			<%-- <iframe id="addType_frm" 
				src="${contextPath}/operate/task/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=${audTask.taskTemplateId}&project_id=<%=request.getParameter("project_id")%>"
				frameborder="0" scrolling="no" style="width:100%;height:100%;">
			</iframe> --%>
		</div>
		<div id="addTask_div" title="增加事项" style="overflow:hidden">
			<%-- <iframe id="addType_frm" 
				src="${contextPath}/operate/task/addTypenew.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=${audTask.taskTemplateId}&project_id=<%=request.getParameter("project_id")%>"
				frameborder="0" scrolling="no" style="width:100%;height:100%;">
			</iframe> --%>
		</div>
	<script>
	 $(function(){
			// 初始化生成表格
			showWin('addType_div','增加审计类别');
	 		showWin('addTask_div','增加审计事项');
			$('#listTaskDiv').datagrid({
				url : "<%=request.getContextPath()%>/operate/task/showContentTypeEditByUi.action?taskTemplateId=${audTask.taskTemplateId}&project_id=${project_id}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[  
					{field:'taskName',
							title:'事项名称',
							width:"30%",
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'taskNametype',
						title:'类别名称',
						width:"25%",
						sortable:true, 
						align:'center'
					},
					{field:'taskCode',
						 title:'事项编码',
						 width:"70px",
						 align:'center', 
						 sortable:true,
						 hidden:true
					},
					{field:'taskOther',
						 title:'审计程序和方法',
						 width:"20%", 
						 align:'center', 
						 sortable:true
					},
					{field:'law',
						 title:'相关法律法规和监管规定',
						 width:"20%",
						 align:'center', 
						 sortable:false
					},
					{field:'taskMethod',
						 title:'审计查证要点',
						 width:"20%",
						 align:'center', 
						 sortable:false
					},
					{field:'pointContent',
						 title:'重点关注内容',
						 width:"15%",
						 align:'center', 
						 sortable:false
					},
					{field:'taskStartTime',
						 title:'事项开始时间',
						 width:"120px", 
						 align:'center', 
						 sortable:false
					},
					{field:'taskEndTime',
						 title:'事项结束时间',
						 width:"120px", 
						 align:'center', 
						 sortable:false
					}
				]]   
			}); 

			/* window.setTimeout(function(){
	            var winH = document.body.clientHeight || document.documentElement.clientHeight ;
	            var winW = document.body.clientWidth || document.documentElement.clientWidth ;
	            $('#addType_div').window({   
					width:winW,   
					height:winH,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
	            $('#addTask_div').window({   
					width:winW,   
					height:winH,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				
			},1000); */
		 
 
            $('#generateType').bind('click',function(){
                //$('#addType_div').window('open');	
	   		     var url = '${contextPath}/operate/task/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=${audTask.taskTemplateId}&project_id=<%=request.getParameter("project_id")%>';
				 showWinIf('addType_div',url,'增加类别',600,300);
			});
		
            $('#generateLeaf').bind('click',function(){
            	
	   		     var url = '${contextPath}/operate/task/addTypenew.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=${node}&path=${path}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=${audTask.taskTemplateId}&project_id=<%=request.getParameter("project_id")%>';
				 showWinIf('addTask_div',url,'增加事项',600,300);
            	
                //$('#addTask_div').window('open');	
                
                // 解决IE8加载缓慢时，事项页面无法显示
                /* var winH = document.body.clientHeight || document.documentElement.clientHeight;
                addType_frm.$('#pbody').css({
                    'height':winH - addType_frm.$('#phead').height() - 40,
                    'overflow':'auto'
                }); */            
			});
		  
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
			
		  
	});
	
	function closeW(){
		$('#addType_div').window('close');
	}
	function closeTask(){
		$('#addTask_div').window('close');
	}
		</script>
</body>
</html>
