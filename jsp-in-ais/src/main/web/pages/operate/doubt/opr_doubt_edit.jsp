<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
 String strOwner="";
if("true".equals(owner)){
	strOwner="true";
	owner="-owner";
}else{
	owner="";
}
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		
		<!--  重构后的代码   -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
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
		<style type="text/css">
			/* 浮动最上层 */
			#div1 {
				z-index: 9;
			}
			
			#div2 {
				z_index: 1;
			}
		</style>
	<script type="text/javascript">
		//====================== js加载方法start ================================
			
		function refreshMyTaskDoubtGrid(){
			try{
				var browser=navigator.appName 
				var b_version=navigator.appVersion 
				var version=b_version.split(";"); 
				var trim_Version=version[1].replace(/[ ]/g,""); 
			     if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
				{ 
				 
				} else{
					// 刷新我的事项-疑点表格
					var mytaskTab = top.$("#tabs").tabs("getTab","我的事项");
					if(mytaskTab){
						var mytaskIfm = mytaskTab.find('iframe');
						if(mytaskIfm.length){					
							var cwin = mytaskIfm[0].contentWindow;
							cwin.$('#operate-task-detail-list-2').datagrid('reload');
							cwin.$('#'+cwin.$('#mytaskTableId').val()).datagrid('reload');
						}
					}
				}
			
			}catch(e){
				
			}
		}
			
			
		$(function(){
			refreshMyTaskDoubtGrid();
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
				title:"消除疑点",
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
					
					var idArr = QUtil.getPriorNodeIds(node.id,"/ais/commonPlug/getPriorNodeIdsById.action?beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid");
				    var str='';
				    for(var i=0;i<idArr.length;i++){
				    	str+=idArr[i]+'#';
				    }
				    $.ajax({
						type: "POST",
						dataType:'json',
						url : "/ais/proledger/problem/getLedgerTemplateNewNames.action",
						data:{
							'str':str
						},
						success: function(data){
							if(data.type == 'ok'){
								$('#att2').val(data.names);
								$('#att').val(data.ids);
								callback();
							}else{
								alert('入报告失败');
							}		
						},
						error:function(data){
							alert('请求失败！');
						}
					});
					
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
        				  var taskName = arr[0];
        				  taskName = taskName.replace(/<font style="color:red;">/g,"").replace(/<\/font>/g,"");
        				  var ms_name =document.getElementsByName("audDoubt.doubt_name")[0].value;
        				  if(ms_name == "" ){
        					  $("#doubt_name").val(taskName);
        				  }
        				  
        			      $("#task_name").val(taskName);
        			      var content = $('#crudaudit_record');
        			      //先去掉审计记录自动添加的一句话
        			      var s2 = '';
        			      //var s2 = "\n\n结论意见（按审计人员的岗位分工或查证要点，逐条提出评价意见）:";
        			      var s = (arr[1]==null||arr[1]=='null')?'':arr[1];
        			      s += s2;
        			      var t = content.val("");
        			      content.focus().val(s);
        			          			      
        			   }
       			});
       		}
        }
		
		//-------保存表单
		function saveForm(){
	       var auth='';
	       var doubt_taskId = document.getElementsByName('audDoubt.task_id')[0].value;
		   var v_3 = "audDoubt.doubt_name";  // field
		   var title_3 = '疑点名称';// field name 
		   var notNull = 'true'; // notnull
           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "") {
		         //$.messager.alert('提示信息',title_3+"不能为空1111!",'info');
		         parent.$.messager.show({
		        	 title:"提示信息",
		         	 msg:title_3+"不能为空!",
		         	 timeout:5000
		         });
		         bool = false;
		         document.getElementById(v_3).focus();
		         return false;
	        }
            if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
            	parent.$.messager.show({
		        	 title:"提示信息",
		         	 msg:title_3+"不能为空!",
		         	 timeout:5000
		         });
		         bool = false;
		         document.getElementById(v_3).focus();
		         return false;
            }
            if('${audDoubt.doubt_id}'!=null&&'${audDoubt.doubt_id}'!='null'&&'${audDoubt.doubt_id}'!=''){
                 var v_3 = "audDoubt.doubt_code";  // field
	             var title_3 = '疑点编码';// field name
	             var notNull = 'true'; // notnull
	             if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "") {
	            	 parent.$.messager.show({
			        	 title:"提示信息",
			         	 msg:title_3+"不能为空!",
			         	 timeout:5000
			         });
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		    	 }
            	 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
            		 parent.$.messager.show({
    		        	 title:"提示信息",
    		         	 msg:title_3+"不能为空!",
    		         	 timeout:5000
    		         });
				        bool = false;
				        document.getElementById(v_3).focus();
				        return false;
                 }                 
             }
             if('${taskId}'!=null&&'${taskId}'!='null'&&'${taskId}'!=''){
                 
              }else{
            	  v_3 = "audDoubt.task_name";  // field
 	             title_3 = '审计事项';// field name
 	             notNull = 'true'; // notnull
 	             if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != ""){
 	            	 parent.parent.$.messager.show({
 			        	 title:"提示信息",
 			         	 msg:title_3+"不能为空!",
 			         	 timeout:5000
 			         });
 				         bool = false;
 				         document.getElementById(v_3).focus();
 				         return false;
 		         }
                  if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"") == ""){
                 	 parent.parent.$.messager.show({
     		        	 title:"提示信息",
     		         	 msg:title_3+"不能为空!",
     		         	 timeout:5000
     		         });
 				         bool = false;
 				         document.getElementById(v_3).focus();
 				         return false;
                  }
              }
             
                v_3 = "audDoubt.groupId";  // field
                title_3 = '审计小组';// field name
                var notNull = 'true'; // notnull
  	            if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != ""){
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
                	parent.$.messager.show({
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
  	             if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "") {
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
		 	var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
			var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
	        if('${user.floginname}' == q){
	                    //alert("123");
	        }else{
	        	parent.parent.$.messager.show({
		        	 title:"提示信息",
		         	 msg:"没有权限操作！",
		         	 timeout:5000
		         });
            	return false;
	        }
            if(p == '050'){
            	parent.$.messager.show({
		        	 title:"提示信息",
		         	 msg:"已处理状态，不能执行操作！",
		         	 timeout:5000
		         });
            	return false;
            }else{
            }
			var t = document.getElementById('subModelHTML');
			$('#audDoubt.subModelHTML').val($("#subModelHTML").html());
			var url = "${contextPath}/operate/doubt/save.action";
			document.getElementById("saveFormFX").disabled = true;
			$.ajax({
				url:"${contextPath}/operate/doubt/saveDoubt.action",
				type:"Post",
				data:$("#myform").serialize(),
				success:function(data){
					window.parent.parent.$.messager.show({
						title:"提示信息",
						msg:"保存成功！",
						timeout:5000,
					});
					if ('<%=strOwner%>' == 'true' ){
						//top.$(".nav-tabs li").each(function(){
						top.$(".tabs li").each(function(){
							var  gg = $(this).text();
							if( gg == '我的事项'){
								var tabId = $(this).children('a').attr("aria-controls");
								refreshMyTaskManuGrid(tabId);
							}
						});
					}
					window.location.href = data.redirect;
				}
			});
		}
		
    	// 保存后 刷新我的事項 
    	function refreshMyTaskManuGrid(tabId){
    		try{
    			var browser=navigator.appName 
    			var b_version=navigator.appVersion 
    			var version=b_version.split(";"); 
    			var trim_Version=version[1].replace(/[ ]/g,""); 
    		     if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
    			{ 
    			 
    			} else{
    				// 刷新我的事项-疑点
    		       	//var t = top.Addtabs.options.obj.children(".tab-content");
    	            //var tabIfm = t.find('#'+tabId).find('.iframeClass');
					var tabIfm = top.$("#tabs").tabs("getTab",'我的事项').find('iframe');
    	            if(tabIfm.length){
    		            var ifmWin = tabIfm.get(0).contentWindow;
    		            ifmWin.$('#operate-task-detail-list-2').datagrid('reload');
    		            ifmWin.$('#'+ifmWin.$('#mytaskTableId').val()).treegrid('reload');
    	            }
    			}
    		}catch(e){
    			
    		}
    	}
		//处理疑点
		function handleDoubt(){
			 var v_3 = "audDoubt.doubt_reason";  // field
			  var t=document.getElementsByName(v_3)[0].value;
			  if(t==null || t==''){
				  top.$.messager.show({
			        	 title:"提示信息",
			         	 msg:"无问题原因不能为空!",
			         	 timeout:5000
			         });
			  	return false;
			  }
			  if(t.length>1000){
				  top.$.messager.show({
			        	 title:"提示信息",
			         	 msg:"无问题的原因不能大于1000字！",
			         	 timeout:5000
			         });
				     document.getElementById(v_3).focus();
			  return false;
			 } 
			top.$.messager.confirm('确认', '确认要处理疑点吗?', function(flag){
				if (flag){
					$.ajax({
					  	url:"${contextPath}/operate/doubt/saveDoubtReason.action?owner=<%=strOwner%>",
					  	type:"post",
					  	data:$("#doubtform").serialize(),
					  	async:false,
					  	success:function(){
					  		 top.$.messager.show({
					        	 title:"提示信息",
					         	 msg:"处理成功！",
					         	 timeout:5000
					         });
					  		
					  
					  			  var type = '1';
						  		  if('${type}' == 'YD'){
						  			type = '2';
						  		  }else{
						  			type = '3';
						  		  }
						  		  gobackDoubtList();
					  	},
					  	error:function(){
					  		alert("系统错误，请联系系统管理员！");
					  	}
					});
				}
			});
		}
		
		function gobackDoubtList(){
			var doubtListUrl = "";
	        if('<%=strOwner%>' == 'true'){
	           //u='${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action?project_id=${audDoubt.project_id}&taskId=${audDoubt.task_id}&taskPid=${audDoubt.task_id}'
	           doubtListUrl = '${pageContext.request.contextPath}/operate/taskExt/myTask.action?view=process&project_id=${project_id}&projectType=${projectType}';
	           $('#win').window('close');
	           window.location.reload();
	        }else{
	           doubtListUrl = '${pageContext.request.contextPath}/operate/doubtExt/mainUi.action?project_id=${audDoubt.project_id}&taskId=-1&taskPid=${audDoubt.task_id}';
	 	    	window.location.href = doubtListUrl;
	        }
		}
		//删除
	    function deleteRecord(){
			 var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
			 var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
		     if('${user.floginname}'==q){
		        //alert("123");
		     }else{
		    	 parent.$.messager.show({
		    			title:'提示信息',
		    			msg:'没有权限删除！',
		    			timeout:5000,
		    			showType:'slide'
		    		});

               	return false;
		     }
			           
			 if(p == '050'){
				 parent.$.messager.show({
						title:'提示信息',
						msg:'已处理状态，不能删除！',
						timeout:5000,
						showType:'slide'
					});

			    return false;
			 }else{
			 }
			 $.messager.confirm('确认', '确认删除这条记录?', function(flag){
				if (flag){
					var id = document.getElementsByName("doubt_id")[0].value;
					//上面条件都不满足，进行删除 
			  		$.ajax({
			  			url:"${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action",
			  			type:"POST",
			  			async:false,
			  			data:{"audDoubt.doubt_id":id},
			  			success:function(data){
			  				$.messager.alert('提示信息','删除成功!','info',function(){
			  					 if('true' == '${owner}'){
			  					/* 	var selectedTab = top.$('#tabs').tabs('getSelected');
				  				           if(selectedTab){
				  				                var tabIndex = top.$('#tabs').tabs('getTabIndex', selectedTab);
				  				                top.$('#tabs').tabs('close', tabIndex); 
				  				           } */
				  				           
			  						top.$(".nav-tabs li").each(function(){ 
			  					  	      var  gg = $(this).text();
			  					  	      var tabId = $(this).children('a').attr("aria-controls");
			  					  	  
			  		    	              
			  					  	      if( gg == '编辑疑点' || gg == '增加疑点'){
			  					  	         top.Addtabs.close(tabId);
			  					  	      }else if(gg == '我的事项'){
			  					  	      var t = top.Addtabs.options.obj.children(".tab-content");
			  		    	              var tabIfm = t.find('#'+tabId).find('.iframeClass');
			  		    	              if(tabIfm.length){
			  		    		            var ifmWin = tabIfm.get(0).contentWindow;
			  		    		            ifmWin.$('#'+ifmWin.$('#mytaskTableId').val()).datagrid('reload');
			  		    	               }
			  					  	      }
			  					  	      
			  					  	    });
			  					
			  					
			  					
			  					}else{
			  						gobackDoubtList();
			  					} 
			  					
			  				});
			  			}
			  		});
				}
			 });
		} 
		
		//返回上级list页面
		function backList(){
			<%-- var flag = window.confirm('请先确定填写疑点数据已保存过，以免数据丢失');//isSubmit
	  		if(flag){
	  		  var type = '1';
	  		  if('${type}' == 'YD'){
	  			type = '2';
	  		  }else{
	  			type = '3';
	  		  }
	 	      var doubtListUrl = "";
		      if('<%=strOwner%>' == 'true'){
		           //u='${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action?project_id=${audDoubt.project_id}&taskId=${audDoubt.task_id}&taskPid=${audDoubt.task_id}'
		           doubtListUrl = '${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action?owner=${owner}&groupCode=<%=request.getParameter("groupCode")%>&type=FX&project_id=${project_id}&taskId=-1&taskPid=${taskId}';
		      }else{
		           doubtListUrl = '${pageContext.request.contextPath}/operate/doubtExt/mainUi.action?project_id=${audDoubt.project_id}&taskId=<%=request.getParameter("taskId")%>&taskPid=${audDoubt.task_id}';
		      }
	  	      window.location.href = doubtListUrl;
	  		}else{
	  			return false;
	  		} --%>
			
	  		top.$.messager.confirm('确认对话框', '请先确定填写疑点数据已保存过，以免数据丢失', function(r){
	  			if(r){
	  	  		  var type = '1';
	  	  		  if('${type}' == 'YD'){
	  	  			type = '2';
	  	  		  }else{
	  	  			type = '3';
	  	  		  }
	  	 	      var doubtListUrl = "";
	  		      if('<%=strOwner%>' == 'true'){
	  		           doubtListUrl = '${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action?owner=${owner}&groupCode=<%=request.getParameter("groupCode")%>&type=FX&project_id=${project_id}&taskId=-1&taskPid=${taskId}';
	  		      }else{
	  		           doubtListUrl = '${pageContext.request.contextPath}/operate/doubtExt/mainUi.action?project_id=${audDoubt.project_id}&taskId=<%=request.getParameter("taskId")%>&taskPid=${audDoubt.task_id}';
	  		      }
	  	  	      window.location.href = doubtListUrl;
	  	  		}else{
	  	  			return false;
	  	  		}
	  		});
		}
		
		//生成
      	function generate(s) {
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
// 		     if('${user.floginname}' == q){
		                    alert("123");
// 		     }else{
// 		         alert("没有权限操作！");
// 		         return false;
// 		     }
		           
// 		     if(p == '050'){
// 		         lert("已处理状态，不能执行操作！");
// 		         return false;
// 		     }else{
		     	
// 		     }
		     var d_id = document.getElementsByName("doubt_id")[0].value;
		     var n_type = s;
		     var title = "";
		     if(s == "YD"){
		     	title = "生成审计疑点";
		     }else if(s=="FX"){
		     	title = "生成审计发现";
		     }else if(s=="DS"){
		     	title = "生成重大程序";
		     } 
		     d_type=document.getElementsByName("type")[0].value;
		     showPopWin('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&newDoubt_type='+n_type+'&type='+d_type+'&project_id=${project_id}',700,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
		}
		//生成
	    function generateMS(s) {
	    	  var v_3 = "audDoubt.doubt_name";  // field
			  var title_3 = '疑点名称';// field name 
			  var notNull = 'true'; // notnull
	          if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "") {
			         parent.$.messager.show({
			        		title:'提示信息',
			        		msg:title_3+"不能为空!",
			        		timeout:5000,
			        		showType:'slide'
			        	});

			         bool = false;
			         document.getElementById(v_3).focus();
			         return false;
	          }
	          if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
	        	  parent.$.messager.show({
		        		title:'提示信息',
		        		msg:title_3+"不能为空!",
		        		timeout:5000,
		        		showType:'slide'
		        	});
					bool = false;
	      			document.getElementById(v_3).focus();
	      			return false;
	          }
	          v_3 = "audDoubt.groupId";  // field
	          title_3 = '审计小组';// field name
	          var notNull = 'true'; // notnull
	          if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != ""){
	        	  parent.$.messager.show({
		        		title:'提示信息',
		        		msg:title_3+"不能为空!",
		        		timeout:5000,
		        		showType:'slide'
		        	});
			         bool = false;
			         document.getElementById(v_3).focus();
			         return false;
	          }
	          if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
	        	  parent.$.messager.show({
		        		title:'提示信息',
		        		msg:title_3+"不能为空!",
		        		timeout:5000,
		        		showType:'slide'
		        	});
	      			bool = false;
	      			document.getElementById(v_3).focus();
	      			return false;
	          }
	          if( !check()){
	            return false;
	          } 
		     var q = document.getElementsByName('audDoubt.doubt_author_code')[0].value;
		     var p = document.getElementsByName('audDoubt.doubt_status')[0].value;
             if(p == '050'){
            	 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:"已处理状态，不能执行操作！",
		        		timeout:5000,
		        		showType:'slide'
		        	});
                return false;
             }else{
             	
             }
		     d_id = document.getElementsByName("doubt_id")[0].value;
		     $('#generateFX').linkbutton('disable');
		     $('#deleteRecordFX').linkbutton('disable');
		     $('#exeFX').linkbutton('disable');
		     $('#saveFormFX').linkbutton('disable');
		     //document.getElementById("generateFX").disabled = true;
		     //document.getElementById("deleteRecordFX").disabled = true;
		     //document.getElementById("exeFX").disabled = true;
		     //document.getElementById("saveFormFX").disabled = true;
		     n_type='MS';
		     var title = "生成底稿";
		     d_type=document.getElementsByName("type")[0].value;
		     window.location.href = '${contextPath}/operate/doubt/genManu.action?file_id=${audDoubt.file_id}&doubt_id='+d_id+'&newDoubt_type='+n_type+'&type='+s+'&project_id=${project_id}';
		     var num = Math.random();
		     var rnm = Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		}
		
		//处理
		function exe(){
		  var v_3 = "audDoubt.doubt_name";  // field
		  var title_3 = '疑点名称';// field name 
		  var notNull = 'true'; // notnull
          if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"&& notNull != ""){
        	   parent.$.messager.show({
	        		title:'提示信息',
	        		msg:title_3+"不能为空!",
	        		timeout:5000,
	        		showType:'slide'
	        	});
	         bool = false;
	         document.getElementById(v_3).focus();
	         return false;
      	  }
          if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
        	  parent.$.messager.show({
	        		title:'提示信息',
	        		msg:title_3+"不能为空!",
	        		timeout:5000,
	        		showType:'slide'
	        	});
      		 bool = false;
      		 document.getElementById(v_3).focus();
      		 return false;
          }
		                     
		  if('${audDoubt.doubt_id}'!=null&&'${audDoubt.doubt_id}'!='null'&&'${audDoubt.doubt_id}'!=''){
		  		var v_3 = "audDoubt.doubt_code";  // field
	         	var title_3 = '疑点编码';// field name
	         	var notNull = 'true'; // notnull
             	if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "") {
             		 parent.$.messager.show({
			        		title:'提示信息',
			        		msg:title_3+"不能为空!",
			        		timeout:5000,
			        		showType:'slide'
			        	});
		        	bool = false;
		        	document.getElementById(v_3).focus();
		        	return false;
             	}
             	if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
             		 parent.$.messager.show({
			        		title:'提示信息',
			        		msg:title_3+"不能为空!",
			        		timeout:5000,
			        		showType:'slide'
			        	});
		        	bool = false;
		        	document.getElementById(v_3).focus();
		        	return false;
            	}
           }
           document.getElementsByName(v_3)[0].value = document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,""); 
           v_3 = "audDoubt.groupId";  // field
           title_3 = '审计小组';// field name
           var notNull = 'true'; // notnull
           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "") {
        	   parent.$.messager.show({
	        		title:'提示信息',
	        		msg:title_3+"不能为空!",
	        		timeout:5000,
	        		showType:'slide'
	        	});
		         bool = false;
		         document.getElementById(v_3).focus();
		         return false;
	        }
            if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
            	 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:title_3+"不能为空!",
		        		timeout:5000,
		        		showType:'slide'
		        	});
		         bool = false;
		         document.getElementById(v_3).focus();
		         return false;
            }
		    v_3 = "audDoubt.audit_dept";  // field
            title_3 = '被审计单位';// field name
            var notNull = 'true'; // notnull
	        if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"&& notNull != "") {
	        	 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:title_3+"不能为空!",
		        		timeout:5000,
		        		showType:'slide'
		        	});
			     bool = false;
			     document.getElementById(v_3).focus();
			     return false;
	        }
	        if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
	        	 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:title_3+"不能为空!",
		        		timeout:5000,
		        		showType:'slide'
		        	});
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
		    	 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:"没有权限处理！",
		        		timeout:5000,
		        		showType:'slide'
		        	});
                return false;
		    }
		           
		    if(p=='050'){
		    	 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:"已处理状态，不能重复处理！",
		        		timeout:5000,
		        		showType:'slide'
		        	});
                return false;
		     }else{
		     }
			$("#win").window("open");
//            var title = "录入处理无问题原因";
//            showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?chuli=2&doubt_id=${audDoubt.doubt_id}',600,400,title,function(){window.location.reload();});
					
		   /*	
		   if(confirm("是否录入处理无问题原因?\n点‘确定’按钮录入处理无问题原因，点‘取消’按钮直接处理疑点。")){
           var title = "录入处理无问题原因";
           showPopWin('${contextPath}/operate/doubt/editDoubtReason.action?chuli=2&doubt_id=${audDoubt.doubt_id}',600,400,title,function(){window.location.reload();});
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
           }*/
		
		}
		
		function viewManu(manuId){
	    	var width = ($(window).width()-1200)*0.5;
	     	var height = ($(window).height()-550)*0.2;
	     	var myurl = "${pageContext.request.contextPath}/operate/manu/viewAll.action?project_id=${project_id}&crudId="+manuId;
	     	parent.addTab("tabs","查看关联底稿","manuViewTab",myurl,false);
	    	//$('#veiwManu').window("open").window("resize",{width:1200,height:550,left:width,top:height}).window("refresh",myurl);
	    }
 	</script>
 	<script type="text/javascript">
 		// 输入检查
	     function check(){
		     var v_3 = "audDoubt.doubt_name";  // field
		     var title_3 = '疑点名称';// field name
		     var notNull = 'true'; // notnull
		     var t = document.getElementsByName(v_3)[0].value;
		     if(t.length > 50){
		       parent.$.messager.show({
	        		title:'提示信息',
	        		msg:"疑点名称的长度不能大于50字！",
	        		timeout:5000,
	        		showType:'slide'
	        	});
		       document.getElementById(v_3).focus();
		       return false;
		     } 
	        var v_3 = "audDoubt.doubt_content";  // field
	        var title_3 = '疑点内容';// field name
	        var notNull = 'true'; // notnull
	        var t=document.getElementsByName(v_3)[0].value;
	        if(t.length>3000){
	        	 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:"疑点内容的长度不能大于3000字！",
		        		timeout:5000,
		        		showType:'slide'
		        	});
	         document.getElementById(v_3).focus();
	         return false;
	        }          
	        //||'${audDoubt.interact}'=='2'在线分析去掉疑点描述
	        if('${audDoubt.interact}'=='1'){
	         	var v_3 = "audDoubt.describe";  // field
			 	var title_3 = '疑点描述';// field name
			 	var notNull = 'true'; // notnull
			 	var t=document.getElementsByName(v_3)[0].value;
			 	if(t.length>500){
			 		 parent.$.messager.show({
			        		title:'提示信息',
			        		msg:"疑点描述的长度不能大于500字！",
			        		timeout:5000,
			        		showType:'slide'
			        	});
					document.getElementById(v_3).focus();
					return false;
				} 
	        }
			var v_3 = "audDoubt.audit_law";  // field
			var title_3 = '法规制度';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>3000){
				 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:"法规制度的长度不能大于3000字！",
		        		timeout:5000,
		        		showType:'slide'
		        	});
			   document.getElementById(v_3).focus();
			   return false;
	      }
			var v_3 = "audDoubt.audit_regulation";  // field
			var title_3 = '规章制度';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>2000){
				 parent.$.messager.show({
		        		title:'提示信息',
		        		msg:"规章制度的长度不能大于2000字！",
		        		timeout:5000,
		        		showType:'slide'
		        	});
				document.getElementById(v_3).focus();
				return false;
			}
			return true;
		}
		
		//显示关联底稿为链接
		function Test(){
	        var code1=document.getElementsByName("audDoubt.doubt_memorandum")[0].value;
	        var code2=document.getElementsByName("audDoubt.doubt_doubt")[0].value; 
	        var code3=document.getElementsByName("audDoubt.doubt_found")[0].value; 
	        var code4=document.getElementsByName("audDoubt.doubt_matters")[0].value; 
	        var manuId = document.getElementsByName("audDoubt.doubt_manu")[0].value;
	        var codeArray1=code1.split(',');
	        var codeArray2=code2.split(',');
	        var codeArray3=code3.split(',');
	        var codeArray4=code4.split(',');
	        var codeArray5 = manuId.split(',');
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
	          	tt4='<a href="javascripp:void(0)" onclick=viewManu(\"'+codeArray5[0]+'\")>'+codeArray5[1]+'</a>';
	          	tt4=tt4+"<br />";
	          }
	 		  p.innerHTML=tt1+tt2+tt3+tt4+tt5;
		}
		
		function callback() {
			var codes = document.getElementById("att").value;
			var names = document.getElementById("att2").value;
			var sort_code = codes.split("#");
			var sort_name = names.split("#");
			var allName =sort_name[sort_name.length - 2];
			
			if (sort_code.length - 4 <= 0) {
				document.getElementsByName("audDoubt.sort_three_code")[0].value = '';
			} else {
				document.getElementsByName("audDoubt.sort_three_code")[0].value = sort_code[sort_code.length - 4];
			}
			if (sort_code.length - 3 == 0) {
				document.getElementsByName("audDoubt.sort_small_code")[0].value = '';
			} else {
				document.getElementsByName("audDoubt.sort_small_code")[0].value = sort_code[sort_code.length - 3];
				allName = allName+" - "+sort_name[sort_name.length - 3];
			}
			document.getElementsByName("audDoubt.sort_big_code")[0].value = sort_code[sort_code.length - 2];
			

			if (sort_name.length - 4 <= 0) {
				document.getElementsByName("audDoubt.sort_three_name")[0].value = '';
			} else {
				document.getElementsByName("audDoubt.sort_three_name")[0].value = sort_name[sort_name.length - 4];
				allName = allName+" - "+sort_name[sort_name.length - 4];
				
			}
			if (sort_name.length - 3 == 0) {
				document.getElementsByName("audDoubt.sort_small_name")[0].value = '';
			} else {
				document.getElementsByName("audDoubt.sort_small_name")[0].value = sort_name[sort_name.length - 3];
			}
			document.getElementsByName("audDoubt.sort_big_name")[0].value = sort_name[sort_name.length - 2];
			
			document.getElementsByName("audDoubt.problem_all_name")[0].value = allName;
		}
 	</script>
	</head>
<body>
<div  fit="true"   class='easyui-layout' region="center" border='0'  style="overflow: auto; width: 100%;height: 100%;">
	<div region="center" border='0'>
			<s:form id="myform" method="post" cssStyle="width: 100%">
				<s:token/>
			<div style="width: 99%;position:absolute;top:0px;"  id="div1">
				<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
					<tr class="EditHead" >
						<td style="text-align: left;" >
						<span style='float: left; text-align: left; padding: 6px 3px 0px 5px;'>
						<s:property value="#title" /></span>
						</td>
				
						<td style="text-align: left;" >
						<span style='float: right; text-align: right;'>
				<s:if test="audDoubt.doubt_status == '050' || audDoubt.doubt_status == '055'">
						<a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton" disabled="true" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>
					</s:if>
					<s:else>
						<a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>
					</s:else>
					<s:if test="from == 'risk'">
					    <a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="changeHref();">返回</a>
					</s:if>
					<s:else>
						<s:if test="type == 'BW'">
							<s:if test="doubt_id == null"></s:if>
							<s:else>
								<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="exe();">消除疑点</a>
								<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除</a>
								<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generate('FX');">生成审计发现</a>
							</s:else>
						</s:if>
						<s:if test="type == 'YD'">
							<s:if test="doubt_id == null">
							</s:if>
							<s:else>
								<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="exe();">消除疑点</a>
								<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除</a>
								<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generate('FX');">生成审计疑点</a>
					<!--<s:button value="生成重大程序" onclick="generate('DS')"/>-->
							</s:else>
						</s:if>
						<s:if test="type == 'FX'">
							<s:if test="doubt_id == null">
							</s:if>
							<s:else>
								<s:if test="audDoubt.doubt_status == '050' || audDoubt.doubt_status == '055'">
									<a id="exeFX" href="javascript:void(0);" class="easyui-linkbutton" disabled="true" data-options="iconCls:'icon-cancel'" onclick="exe();">消除疑点</a>
									<a id="deleteRecordFX" href="javascript:void(0);" class="easyui-linkbutton" disabled="true" data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除</a>
									<a id="generateFX" href="javascript:void(0);" class="easyui-linkbutton" disabled="true" data-options="iconCls:'icon-add'" onclick="generateMS('FX');">生成底稿</a>
								</s:if>
								<s:else>
									<a id="exeFX" href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-cancel'" onclick="exe();">消除疑点</a>
									<a id="deleteRecordFX" href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除</a>
									<a id="generateFX" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateMS('FX');">生成底稿</a>
								</s:else>
							</s:else>
						</s:if>
						<s:if test="type == 'DS'">
							<s:if test="doubt_id == null"></s:if>
							<s:else>
								<a id="exeFX" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="exe();">消除疑点</a>
								<a id="deleteRecordFX" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="icon-delete();">删除</a>
								<a id="generateFX" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateMS('DS');">生成底稿</a>
							</s:else>
						</s:if>
						<s:if test="'${owner}'!='true'">
							<a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="backList();">返回</a>
						</s:if>
					</s:else>
						    </span>
						</td>
					</tr>
			
				</table>
			</div>
	       <div class="position:relative" id="div2">
				<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
					<tr>
						<td style="width: 20%" class="EditHead">
							<font color="red">*</font> 疑点名称
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<s:textfield id="doubt_name" name="audDoubt.doubt_name"  cssStyle='width:90%' cssClass="noborder" maxlength="500"/>
						</td>
						<td style="width: 15%" class="EditHead">状态</td>
						<!--标题栏-->
						<td class="editTd" style="width: 30%">
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
						<td  class="EditHead">
							<font color="red">*</font> 被审计单位 
						</td>
						<td class="editTd">
						<select id="audit_dept" style="width:60%" class="easyui-combobox" panelHeight="auto" name="audDoubt.audit_dept"   editable="false" >
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
 						<td class="EditHead" style="display:none">
							<font color="red">*</font> 审计小组 
						</td>
						<!--标题栏-->
						<td class="editTd" style="display:none">
	 						<select id="auditGroup" class="easyui-combobox" name="audDoubt.groupId" editable="false" panelHeight="auto">
								<s:iterator id="list" value="groupList" >
								    <option value="<s:property value='#list.groupId'/>"><s:property value='#list.groupName'/></option>
								</s:iterator>
							</select>
	 						<s:hidden name="audDoubt.groupName"/>
						</td>
					</tr>

					<tr>
						<td  class="EditHead">
							疑点编码<br/><font color="DarkGray" size="2">(自动生成,请谨慎修改)</font>
						</td>
						<!--标题栏-->
						<td class="editTd" >
							<s:if test="doubt_id == null">
								<s:property value="audDoubt.doubt_code" />
								<s:hidden name="audDoubt.doubt_code" />
							</s:if>
							<s:else>
								<input type="text" name="audDoubt.doubt_code"  value="${audDoubt.doubt_code}" maxLength="80" 
								 style="width: 90%"      class="noborder" onfocus="conCode()" >
							</s:else>

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
						<s:if test="${taskPid=='auditObject'} || ${taskPid =='groupId'}">
							<s:hidden name="audDoubt.task_name" id="task_name" />
							<td class="EditHead">
								<font color="red">*</font> 审计事项
							</td>
							<td class="editTd" style="width: 35%">
								<select id="task_id" class="easyui-combobox" panelHeight="auto" name="audDoubt.task_id" style="width: 32%;" editable="false">
									<s:iterator value="matterObjectMap" id="entry">
										<s:if test="${audDoubt.task_id==key}">
											<option selected="selected" value="<s:property value="key"/>"><s:property value="value" /></option>
										</s:if>
										<s:else>
											<option value="<s:property value="key"/>"><s:property value="value" /></option>
										</s:else>
									</s:iterator>
								</select>
							</td>
						</s:if>
						<s:else>
							<s:if test="${taskId}=='-1' || ${taskId}==null|| ${taskId}==''">
							<td class="EditHead">
								<font color="red">*</font> 审计事项
							</td>
							<td class="editTd">
								<input type="text" name="audDoubt.task_name" value="${audDoubt.task_name}" id="task_name" style='width:70%' readonly="readonly" class="noborder">
								<a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="$('#atTreeWrap').window('open')"></a>
								<s:hidden name="audDoubt.task_id" id="task_id" />
								<s:hidden name="audDoubt.task_code" />
							</td>
							</s:if>
							<s:else>
								<td class="EditHead">
									<font color="red">*</font>审计事项
								</td>
								<td class="editTd">
									<s:property value="audDoubt.task_name"  />
								</td>
								<s:hidden name="audDoubt.task_name" />
								<s:hidden name="audDoubt.task_id" id="task_id" />
								<s:hidden name="audDoubt.task_code" />
	
							</s:else>
						</s:else>
						<td class="EditHead">
							<font color="red"></font>创建日期
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:property value="audDoubt.doubt_date" />
							<s:hidden name="audDoubt.doubt_date" />
							<!--一般文本框-->
						</td>
					</tr>
					<!-- add by qfucee, 2013.7.15, 加入问题类别和政策依据 -->
		        	<tr>
		        		<td class="EditHead">问题点</td>
		        		<td class="editTd">
		        			<input type="text" name="audDoubt.wtlbMc" value="${audDoubt.wtlbMc}" readonly="readonly" id="wtlbMc" class="noborder" style='width:70%'>
		        			<a href="javascript:void(0)" id='lr_openWtlbTree' class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick=""></a>
			        		<input type='hidden' id='wtlbDm' name='audDoubt.wtlbDm'  value="${audDoubt.wtlbDm}"/>
			        		<s:hidden id="sort_big_code" name="audDoubt.sort_big_code" />
							<s:hidden id="sort_big_name" name="audDoubt.sort_big_name" />
							<s:hidden id="sort_small_code" name="audDoubt.sort_small_code" />
							<s:hidden id="sort_small_name" name="audDoubt.sort_small_name" />
							<s:hidden id="sort_three_code" name="audDoubt.sort_three_code" />
							<s:hidden id="sort_three_name" name="audDoubt.sort_three_name" />
							<s:hidden id="problem_all_name" name="audDoubt.problem_all_name"></s:hidden>
		        		</td>
		        		<td class="EditHead">政策法规依据</td>
		        		<td class="editTd">
			        		<input type="text" name="audDoubt.zcfgMc" style='width:70%' value="${audDoubt.zcfgMc}" readonly="readonly" id="zcfgMc" class="noborder">
			        		<a href="javascript:void(0)" id='lr_openzcfgOnlyTree' class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick=""></a>
			        		<input type='hidden'  id='zcfgDm' name='audDoubt.zcfgDm'  value="${audDoubt.zcfgDm}"/>	
		        		</td>
		        	</tr>
		        	<!-- end -->
					<s:hidden name="audDoubt.t_id" />
					<s:hidden name="audDoubt.file_id" />
					<s:hidden name="audDoubt.doubt_type" />
					<s:hidden name="audDoubt.doubt_memorandum" />
					<s:hidden name="audDoubt.doubt_found" />
					<s:hidden name="audDoubt.doubt_matters" />
					<s:hidden name="audDoubt.doubt_doubt" />
					<s:hidden name="audDoubt.doubt_manu" />
					<s:hidden name="audDoubt.doubt_manu_name" />
					<s:hidden name="audDoubt.do_code_sort" />
					<s:hidden name="audDoubt.task_code_sort" />
					<input type="hidden" id="att" name="att" value="">
					<input type="hidden" id="att2" name="att2" value="">
					
					<input type="hidden" value="${from }" name="from">
					<tr>
						<td class="EditHead">关联索引</td>
						<td class="editTd" colspan="3">
							<span id="p"></span>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<s:if test="type == 'BW'">备忘内容 </s:if>
							<s:if test="type == 'FX'">
								<div style="text-align: center; float: right;" >疑点内容<br/><font color=DarkGray>(限3000字)</font></div>
							</s:if>
							<s:if test="type == 'YD'">发现内容</s:if>
							<s:if test="type == 'DS'">重大程序内容 </s:if>
						</td>
						<td class="editTd" colspan="4" style="padding: 5px 5px 5px 5px">
							<s:if test="audDoubt.interact == 1">
								<div id="subModelHTML" runat="server" style="border-style: none; left: 0px; 
								     overflow: scroll; width: 100%; position: relative; top: 0px; height: 260px;">
									<s:property escape="false" value="audDoubt.subModelHTML" />
								</div>
								<s:hidden name="audDoubt.subModelHTML" />
								<s:hidden name="audDoubt.doubt_content" />
							</s:if>
							<s:else>
								<s:textarea id="doubt_content" title="疑点内容"  cssClass='noborder' name="audDoubt.doubt_content"
							                rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
								<s:hidden name="audDoubt.subModelHTML" />
								<s:hidden name="subModelHTML" />
							</s:else>
							<s:hidden name="audDoubt.interact" />
						</td>
					</tr>
					<s:if test="audDoubt.interact == 1">
						<tr>
							<td class="EditHead">疑点描述</td>
							<td colspan="3"></td>
						</tr>
						<tr>
							<td class="EditHead" colspan="4" style="padding: 5px 5px 5px 5px">
								<s:textarea id="" cssClass='noborder' name="audDoubt.describe"
							               rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							</td>
						</tr>
					</s:if>
					<s:else>
						<s:hidden name="audDoubt.describe" />
					</s:else>
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
<!-- 							<input id="audit_law" class="easyui-textbox" name="audDoubt.audit_law"  -->
<!-- 							       data-options="multiline:true" value="" style="width:1088px;height:100px"> -->
							<s:textarea id="audit_law" cssClass="noborder" title="法规制度" name="audDoubt.audit_law"
							               rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
						</td>
					</tr>
					<s:if test="audDoubt.doubt_reason_flag == 1">
						<tr>
							<td class="EditHead" >无问题原因</td>
							<td class="editTd" colspan="4">
<!-- 								<s:textarea name="audDoubt.doubt_reason" cssStyle="width:100%;height:70;" /> -->
								<s:textarea cssClass='noborder' name="audDoubt.doubt_reason"
							                 rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
							</td>
						</tr>
					</s:if>
					<s:hidden name="audDoubt.audit_regulation" />
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
			   <table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
				   <tr>
					   <td style="height: 300px;">
						   <div id="manu_file" class="easyui-fileUpload"
								data-options="fileGuid:'${audDoubt.file_id}',callbackGridHeight:300"></div>
					   </td>
				   </tr>
			   </table>
			</div>
			</s:form>
			<jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" />	
		</div>
</div>

	 <!-- 问题类别树 -->
	 <div id='wtlbTreeSelectWrap' title='问题类别树' style='overflow:hidden;padding:5px; border:1px solid #cccccc;'>
	 	<div style='padding:0 0 2px 5px; text-align:left;'>
	 		<button id='sureSelectWtlbTreeNode'  class="easyui-linkbutton" iconCls="icon-add">添加</button>
	 		<button id='clearSelectWtlbTreeNode' class="easyui-linkbutton" iconCls="icon-empty">清 空</button> 		
	 	</div>
	 	<ul id='wtlbTreeSelect' class='easyui-tree' style='height:350px;width:99%;border:1px solid #cccccc; padding:5px;overflow:auto;'></ul>
	 </div>
	 
	<!-- 政策法规树 -->
	<div id='zcfgOnlyTreeSelectWrap' title='政策法规树' style='overflow:hidden;padding:5px 5px 5px 5px; border:1px solid #cccccc;'>
	 	<div style="text-align:left;padding:0 0 2px 5px;">
	 		<button id='sureSelectzcfgOnlyTreeNode'  class="easyui-linkbutton" iconCls="icon-add">添加</button>
	 		<button id='clearSelectzcfgOnlyTreeNode' class="easyui-linkbutton" iconCls="icon-empty">清 空</button> 		
	 	</div>
	 	<ul id='zcfgOnlyTreeSelect' class='easyui-tree' style='height:350px;width:99%;border:1px solid #cccccc; padding:5px;overflow:auto;'></ul>
	</div>
	
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
	
	
	<div id="win">
		<s:form id="doubtform" method="post">
			<table class="ListTable" width="100%" style="height:100%;">
				<tr>
					<td class="editTd" colspan="2" style="height:30px;">
						<a href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="handleDoubt();">处理</a>
						<a href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="$('#win').window('close')">返回</a>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:150px;">
						<div style="text-align: center; float: right;">
							<font color='red'>*</font>无问题原因:<br><font color=DarkGray>(限1000字)</font>
						</div>
					</td>
					<td class="editTd">
						<s:textarea id="no_doubt_reason" name="audDoubt.doubt_reason" cssClass='noborder' cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
						<input type="hidden" id="audDoubt.doubt_reason" value="1000"/>
					</td>
				</tr>
			</table>
			<s:hidden name="doubt_id"/>
		</s:form>
	</div>
</body>
<script type="text/javascript">
	$("#myform").find("textarea").each(function(){
		autoTextarea(this);
	});
	$("#win").find("textarea").each(function(){
		autoTextarea(this);
	});
	$(document).ready(function(){
		$("#doubt_content").attr("maxlength",3000);
		$("#audit_law").attr("maxlength",3000);
		$("#no_doubt_reason").attr("maxlength",1000);
		});
</script>
</html>
