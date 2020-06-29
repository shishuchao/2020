<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'疑点生成审计底稿'"></s:text>
<html>
	<head>
	<!--  重构后的代码   -->
	<title><s:property value="#title" /></title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var msg="${requestScope.tipMessage}";
			if(msg != "" && msg == 'true'){
				showMessage1('保存成功!','提示信息',5000,'slide');
			}
//			changeManuType();
			//初始化引用底稿窗口
		    $('#manuReferenceDiv').window({
				width:650, 
				height:550,  
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true    
		    });
		//	$("#lr_openZcfgTree").attr("maxlength",3000);
			$("#audit_record").attr("maxlength",5000);
			$("#audit_law").attr("maxlength",3000);
			$("#audit_con").attr("maxlength",5000)
			$("#describe").attr("maxlength",6000);
			/* var  dqxm='${dqxm}'
			if(dqxm == 'GZNX'){
				$("#describe").attr("maxlength",6000);
			}else{
				$("#describe").attr("maxlength",6000);
			} */
			
		    $('#manuProblemDiv').window({
					width: '100%', 
					height:'100%',  
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true   
			    });  
			
		});	
		
	

	        
       	//选择引用底稿
       	function getOwerManu(){
       		//选择引用底稿
			var myurl = "${contextPath}/operate/manu/queryManuSelect.action?project_id=${audManuscript.project_id}&manuId=${audManuscript.id}";
			$("#myFrame").attr("src",myurl);
			var width = ($(window).width()-900)*0.5;
	        var height = ($(window).height()-550)*0.2;
			$('#manuReferenceDiv').window("open").window("resize",{width:900,height:550,left:width,top:height});
       	}
       	
       	// 关闭引用底稿
		function closeWinUI(){
			$('#manuReferenceDiv').window("close");
		}
       	
	  	function check(){
		var v_3 = "audManuscript.describe";  // field
		var title_3 = '审计记录';// field name
	/* 	if('${dqxm}'=='GZNX'){
			title_3 = '问题描述';// field name
		}else{
		} */
		var notNull = 'true'; // notnull

    /*     var manuType = $('#manuType').val();
		if(manuType=='COMPREHENSIVE'){
            if(t.length>3000){
	  			$.messager.alert('提示信息',title_3+"的长度不能大于3000字！",'info');
	   			document.getElementById(v_3).focus();
	      		return false;
          	}
        } */
            
/* 		var v_3 = "audManuscript.audit_con";  // field
		var title_3 = '问题标题';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>300){
			$.messager.alert('提示信息',"问题标题的长度不能大于300字！",'info');
			document.getElementById(v_3).focus();
			return false;
		} 
		if(t == null || t == ""){
       		window.parent.$.messager.show({
   				title:'提示信息',
   				msg:'问题标题为必录项',
   				timeout:5000,
   				showType:'slide'
   			});
        	document.getElementsByName(v_3)[0].focus();
          	return false;
      	}		 */
		                   
		var v_3 = "audManuscript.audit_file";  // field
		var title_3 = '查阅资料';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>3000){
			$.messager.alert('提示信息',"查阅资料的长度不能大于3000字！",'info');
			document.getElementById(v_3).focus();
			return false;
		}
		              
		if('${dqxm}'=='GZNX'){     
			var v_3 = "audManuscript.audit_method_name";  // field
			var title_3 = '查证过程';// field name
			var notNull = 'true'; // notnull
			var t=document.getElementsByName(v_3)[0].value;
		if(t.length>3000){
			$.messager.alert('提示信息',"查证过程的长度不能大于3000字！",'info');
			document.getElementById(v_3).focus();
			return false;
		}                   
		}              
	/* 	var v_3 = "audManuscript.audit_law";  // field
		var title_3 = '法规制度';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>3000){
			$.messager.alert('提示信息',"查证过程的长度不能大于3000字！",'info');
			document.getElementById(v_3).focus();
			return false;
		} */
		var v_3 = "audManuscript.audit_regulation";  // field
		var title_3 = '规章制度';// field name
		var notNull = 'true'; // notnull
		var t = document.getElementsByName(v_3)[0].value;
		if(t.length > 3000){
			$.messager.alert('提示信息',"规章制度的长度不能大于3000字！",'info');
			document.getElementById(v_3).focus();
			return false;
		}
		return true;
	}
	
	</script>

	<script type="text/javascript">
	
   function go2(s){
      window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
   }
		    
    function go1(s){
     	window.open("${contextPath}/operate/manu/view.action?crudId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
    }
		    
    //渲染关联底稿为链接
	function Test(){
        var code3=document.getElementsByName("audManuscript.audit_found")[0].value; 
        var code4=document.getElementsByName("audManuscript.audit_matter")[0].value; 
        var codeArray3=code3.split(',');
        var codeArray4=code4.split(',');
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
 		$('#sureSelectWtlbTreeNode').trigger('click');
	}

	
	
    //模板生成----------保存表单
    function saveGen(){
		var bool = true;//提交表单判断参数
		var v_3 = "audManuscript.ms_name";  // field
		var title_3 = '底稿名称';// field name
		var notNull = 'true'; // notnull
        if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "") {
		    $.messager.alert('提示信息',title_3+"不能为空!",'info');
		    bool = false;
		    document.getElementById(v_3).focus();
		    return false;
        }
        if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")=="") {
	        $.messager.alert('提示信息',title_3+"不能为空!",'info');
		    bool = false;
		    document.getElementById(v_3).focus();
		    return false;
        }
		if( !check()){
	        return false;
	    }  
		//完成保存表单操作
		if(bool){
			//parent.$.messager.confirm('确认', '确认保存?', function(flag){
				//if (flag) {
					var bol = true;
					if('${audManuscript.interact}' == '1' ||'${audManuscript.interact}'=='2'){
				    	var t = document.getElementById('subModelHTML');
				    	document.getElementById('audManuscript.subModelHTML').value = t.innerHTML;
					}
					var url = "${contextPath}/operate/doubt/saveManuGen.action";
					myform.action = url;
					myform.submit();
				//}
			//});
		}
	}
	
	//删除疑点生成底稿
	function deleteGen(){
		parent.$.messager.confirm('确认', '确认删除这条记录?', function(flag){
			if(flag){
				var doubt_id = document.getElementsByName("audManuscript.audit_found")[0].value;
				doubt_id = doubt_id.split(",")[0];
		    	$.ajax({
		    		url:"${contextPath}/operate/doubt/deleteManuGen.action",
		    		type:"POST",
		    		data:$("#myform").serialize(),
		    		success:function(data){
		    			parent.$.messager.alert('提示信息',"删除成功！", 'info',function(){
		    				window.location.href="/ais/operate/doubt/editDoubt.action?type=FX&doubt_id="+doubt_id+"&project_id=${audManuscript.project_id}"
		       		                      +"&taskId=${taskId}&taskPid=${taskPid}";
		    			});
		    		}
		    	});
			}
		});
	} 
	
	//关闭疑点生成底稿
	function closeGenM(){
		parent.$.messager.confirm('确认', '确认关闭?', function(flag){
			if(flag){
				window.location.href= "/ais/operate/doubtExt/mainUi.action?view=process&project_id=${audManuscript.project_id}";
			}
		});
	}

   	// 关闭问题
	function closePronlem(){
		$('#manuProblemDiv').window('close');
	}
    //返回上级list页面
    function backList(){
		location.href = "${contextPath}/operate/manu/listTobeStarted.action?taskId=${taskId}&taskPid=${taskPid}&project_id=${project_id}";
 
    }
	
    //返回上级list页面
    function backListPlan(){
		location.href = "${contextPath}/operate/manu/listTobeStarted.action?taskId=${taskId}&taskPid=${taskPid}&project_id=${project_id}";
    }

	//保存表单 
	function saveForm(){
		var bool = true;//提交表单判断参数
		if( !check()){
	    	return false;
		}   
		//完成保存表单操作
		if(bool){
		 	parent.$.messager.confirm('确认', '确认提交吗?', function(flag){
				if(flag){
					var url = "${contextPath}/operate/manu/save.action";
					myform.action = url;
					myform.submit();
				}
			});
		}
	}
	
	
		function toSubmit(act){
			{
				<s:if test="isUseBpm == 'true'">
				if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
					var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
					if(actor_name==''){
						$.messager.alert('提示信息',"下一步处理人不能为空！",'info');
						return false;
					}
				}
				</s:if>
				parent.$.messager.confirm('确认', '确认提交吗?', function(flag){
					if(flag){
						document.getElementById('submitButton').disabled=true;
						myform.action="<s:url action="submit" includeParams="none"/>";
						myform.submit();
					}
				});
			}
		}
	
	//提交表单
	function submitForm(){
		parent.$.messager.confirm('确认', '确认提交吗?', function(flag){
			if(flag){
				myform.submit();
			}
		});
	}
	    
	function regu() {
		window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
		
	function law(){
		win = window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
	//上传附件
	function Upload(id,filelist,delete_flag,edit_flag){
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=aud_manuscript_operate&table_guid=file_id&guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	//删除方法
	/*
		1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
		2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
			getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
	*/
	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		parent.$.messager.confirm('确认', '确认删除吗?', function(flag){
			if(flag){
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},xxx);
				function xxx(data){
		  			document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
				} 
			}
		});
	}
	$(document).ready(function(){
		//发生数量默认选择为1
	
		$('#manu_file').fileUpload({
			fileGuid:'${audManuscript.file_id}'
		});
		$("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});
        
		  // 法规依据obj
  	    var contain = $('#audit_law');
    	// 审计问题列表
 		var prom = document.getElementsByName("audManuscript.prom")[0].value; 
			if(prom != null &&  prom != "" && prom != '0'){
				manuLederPro();
			} 

	});
	
	

	function getTai(){
		var ms_code= '${audManuscript.formId}';
		var pro_code= '${audManuscript.project_id}';
		if(ms_code==""||ms_code=="null"){
	  		return true;
	 	}else{
	    	var iframe = document.getElementById("mainIFrame");
	    	iframe.src = "/ais/proledger/problem/listDigaoEditProblem.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&manuscriptType=digao&view=add&taskId=${taskId}&taskPid=${taskPid}&DouProblem_code=${ledgerProblem.problem_code}&DouProblem_name=${ledgerProblem.problem_name}&DouPro_type=${ledgerProblem.pro_type}&audDoubtpage=audDoubtpage";
		}

	}

	//获取定性依据
	function getGist(problemCode) {
		var problem_desc=document.getElementById("audit_law").value	;
		$.ajax({
			type : "POST",
			url : "${contextPath}/proledger/problem/saveOprateTask!getGist.action",
			data : {
				"problemCode" : problemCode
			},
			success : function(msg) {
				if (msg != "") {
					$("#audit_law").val(problem_desc == null||problem_desc == ''? msg : problem_desc+"\n"+msg);
				}else{
					$("#audit_law").val(problem_desc);
				}
			}
		});
	}
   // 新增审计问题
    
    function manuLederPro(){
	$("#sjproblemtr").css("display","block");
    	getTai();
    }

	function addManuLederPro(){
		var myurl  = '${contextPath}/proledger/problem/editDigao.action?project_id=${audManuscript.project_id}&id=0&manuscript_id=${audManuscript.formId}&manuscriptType=digao&taskId=${taskId}&taskPid=${taskPid}&DouProblem_code=${ledgerProblem.problem_code}&DouProblem_name=${ledgerProblem.problem_name}&DouPro_type=${ledgerProblem.pro_type}&audDoubtpage=audDoubtpage';
		$("#myFrameProblem").attr("src",myurl);
		$('#manuProblemDiv').window('open');
	}
	function flushProblem(){
	  	var prom = document.getElementsByName("audManuscript.prom")[0].value; 
			if(prom == null ||  prom == "" || prom == '0'){
				$("#sjproblemtr").css("display","block");
		    	getTai();
			}
		 $("#mainIFrame")[0].contentWindow.$("#ledgerProblemList").datagrid('reload');  
	}
	</script>
	</head>
	<s:if test="taskInstanceId != null && taskInstanceId != '' ">
		<body onload="Test()" 	style="overflow: auto; overflow-x: hidden;" class="easyui-layout">
	</s:if>
	<s:else>
		<body onload="Test()" 	style="overflow: auto; overflow-x: hidden;" class="easyui-layout">
	</s:else>
<div fit="true"  class='easyui-layout' region="center" border='0'  style="overflow: auto; width: 100%;height: 100%;">
	<div region="center" border='0'>
		<s:form id="myform" method="post" cssStyle="width: 100%">
		<s:token/>
		   <div style="width: 100%;position:absolute;top:0px;"  >
				<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
					<tr class="EditHead">
						<td style="text-align: left;">
						<span style='float: left; text-align: left; padding: 6px 3px 0px 5px;'>
						<s:property value="#title" /></span>
						</td>
						<td style="text-align: left;" >
						<span style='float: right; text-align: right;'>
				        <a href="javascript:void(0);" id="manuproblem" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addManuLederPro();">新增审计问题</a>&nbsp;  
				        <a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveGen();">保存</a>
				        <a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteGen();">删除</a>
				        <a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeGenM();">关闭</a>
						</span>
						</td>
					</tr>
				</table>
			</div>
			<div class="position:relative" >
			<table class="ListTable"  align="center" style="margin-top: 40px;">
				<tr>
					<td style="width:15%;" class="EditHead" >
						<font color="red"></font>底稿状态
					</td>
					<!--标题栏-->
					<td style="width:35%;" class="editTd" colspan="3">
						<s:if test="${audManuscript.ms_status == '010'}">底稿草稿</s:if>
						<s:if test="audManuscript.ms_status == '020'">正在征求</s:if>
						<s:if test="audManuscript.ms_status == '030'">等待复核</s:if>
						<s:if test="audManuscript.ms_status == '040'">正在复核</s:if>
						<s:if test="audManuscript.ms_status == '050'"> 复核完毕</s:if>
						<s:hidden id="audManuscript.ms_status" name="audManuscript.ms_status" />
						<s:hidden name="audManuscript.ms_code" />
					</td>
				</tr>
				<tr>
						<s:hidden name="audManuscript.task_id" id="task_id" />
					<s:if test="${taskId}=='-1'">
						<td style="width:15%;" class="EditHead">
							<s:hidden name="audManuscript.change_code" />
							<font color="red">*</font> 审计事项
						</td>
						<td style="width:35%;" class="editTd">
							<s:textfield name="audManuscript.task_name" id="task_name"  cssStyle='width:90%' 
								readonly="true" />
							<input type="hidden" id="task_id" name="audManuscript.task_id" value="${crudObject.task_id}"/>	
						</td>
					</s:if>
					<s:else>
						<s:hidden name="audManuscript.change_code" value="1" />
						<td style="width:15%;" class="EditHead">审计事项</td>
						<!--标题栏-->
						<td style="width:35%;" class="editTd">
							<s:textfield name="audManuscript.task_name" id="task_name"  cssStyle='width:90%' cssClass="noborder" 
								readonly="true" />
						</td>
					</s:else>
					<s:hidden name="audManuscript.project_name" />
					<td class="EditHead">
						<span  style="display:none">
						<font color="red">*</font> 审计小组
						</span>
					</td>
					<td  class="editTd">
					<span style="display:none">
						<select id="auditGroup" class="easyui-combobox" name="audManuscript.groupId"   data-options="editable:false" panelHeight="auto">
							<s:iterator id="list" value="groupList" >
							    <option value="<s:property value='#list.groupId'/>"><s:property value='#list.groupName'/></option>
							</s:iterator>
						</select>
						<s:hidden name="audManuscript.groupName"/>
						</span>
					</td>
			<%-- 		<td class="EditHead" style="width:15%">
						参与人
					</td>
					<td style="width:35%;" class="editTd">
						<select id="attendMemberIds" class="easyui-combobox" panelHeight="auto" name="audManuscript.attendMemberIds" editable="false" >
					       <option>&nbsp;</option>
					       <s:iterator value="%{memberList}" id="entry">
					       
						         <s:if test="${audManuscript.attendMemberIds==userId}">
					       			<option selected="selected" value="<s:property value='userId'/>"><s:property value='userName'/></option>
					       		 </s:if>
					       		 <s:else>
							        <option value="<s:property value='userId'/>"><s:property value='userName'/></option>
					       		 </s:else>
					       </s:iterator>
					    </select>
					</td>	 --%>				
				</tr>
				<tr>
		    	<td class="EditHead" style="width:15%">
						<font color="red">*</font> 底稿名称
					</td>
					<!--标题栏-->
					<td class="editTd" style="width:35%">
					<s:textfield name="audManuscript.ms_name" id="ms_name" cssStyle='width:90%' cssClass="noborder" maxlength="500"/>	
						<!--一般文本框-->
					</td>
					<s:hidden name="audManuscript.task_code" />
					<td class="EditHead" style="width: 15%">
								底稿编码
						</td>
						<td class="editTd" style="width: 35%">
						<s:property value="audManuscript.ms_code" />
					    </td>
				</tr>
					<s:hidden name="audManuscript.manu_start" />
					<s:hidden name="audManuscript.audit_found" />
					<s:hidden name="audManuscript.audit_matter" />
					<s:hidden name="audManuscript.manu_end" />
				<tr>
					<td class="EditHead">关联索引</td>
					<td class="editTd" colspan="1">
						<span id="p1"></span>
					</td>
					<td class="EditHead" style="width:15%;">
						<font color="red">*</font> 被审计单位
					</td>
					<td  class="editTd">
						<select id="audit_dept" class="easyui-combobox" panelHeight="auto" name="audManuscript.audit_dept" editable="false" >
					       <s:iterator value="auditObjectMap" id="entry">
						         <s:if test="${audManuscript.audit_dept==key}">
					       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
					       		 </s:if>
					       		 <s:else>
							        <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       		 </s:else>
					       </s:iterator>
					    </select>
						</td>
				</tr>
				<tr >
					<td class="EditHead">撰写人</td>
					<!--标题栏-->
					<td class="editTd">
						<s:property value="audManuscript.ms_author_name" />
						<!--一般文本框-->
						<s:hidden name="audManuscript.project_id" />
						<s:hidden name="audManuscript.ms_author_name" />
						<s:hidden name="audManuscript.ms_author" />
					</td>
					<td class="EditHead">创建日期</td>
					<!--标题栏-->
					<td class="editTd">
						<s:property value="audManuscript.ms_date" />
						<!--一般文本框-->
						<s:hidden name="audManuscript.ms_date" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">引用底稿</td>
					<td class="editTd">
						<s:textfield id="mylinkManuName" name="audManuscript.linkManuName" readonly="true"  
						       cssStyle='width:70%'     cssClass="noborder" maxlength="500"/>
						<s:hidden id="mylinkManuId" name="audManuscript.linkManuId" />
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="getOwerManu();"></a>
					</td>
					<td class="EditHead"></td>
					<td class="editTd"></td>
					
					<%-- <td class="EditHead">
						<font color="red">*</font>底稿类型
					</td>
					<td class="editTd">
						单项
						<s:hidden name="audManuscript.manuType" value="UNITERM" />
					</td> --%>
				</tr>
			<%-- 	<tr>
					<td class="EditHead">
						<div style="text-align:center; float: right;"><font color=red>*</font>问题标题<br/><font color=DarkGray>(限300字)</font></div><br/><br/>
						<a id="lr_openSjwtWin" href="javascript:void(0);" class="easyui-linkbutton"
						   data-options="iconCls:'icon-search'">问题定性</a>
					</td>
					<td class="editTd" colspan="3">
						<s:if test="${empty audManuscript.audit_con}">
							<s:textarea cssClass='noborder' id='audit_con' name="audManuscript.audit_con" rows="1" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						</s:if>
						<s:else>
							<s:textarea cssClass='noborder' id='audit_con' name="audManuscript.audit_con" rows="1" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						</s:else>
						<input type="hidden" id="audManuscript.audit_con.maxlength" value="300">
							<!--<s:textarea id='audit_con' name="crudObject.audit_con" value="${crudObject.audit_con}" cssStyle="width:100%;height:70;" />
							 <input id='audit_con' name='crudObject.audit_con' value='${crudObject.audit_con}' style='width:97%;'/> -->
					</td>
				</tr>
				<tr id="wt1">
					<td class="EditHead" style="width:15%;">问题类别</td>
					<td class="editTd" style="width:35%;">
						<s:textfield id="problem_all_name" name="ledgerProblem.problem_all_name" cssClass="noborder" cssStyle="width:70%" readonly="true" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT>
						<s:hidden id="sort_big_code" name="ledgerProblem.sort_big_code" />
						<s:hidden id="sort_big_name" name="ledgerProblem.sort_big_name" />
						<s:hidden id="sort_small_code" name="ledgerProblem.sort_small_code" />
						<s:hidden id="sort_small_name" name="ledgerProblem.sort_small_name" />
						<s:hidden id="sort_three_code" name="ledgerProblem.sort_three_code" />
						<s:hidden id="sort_three_name" name="ledgerProblem.sort_three_name" />
						<s:hidden id="ledgerProblem_id" name="ledgerProblem.id" />
					</td>
					<td class="EditHead">审计问题编号</td>
					<td class="editTd" >
						<s:textfield name="ledgerProblem.serial_num" id="serial_num" cssClass="noborder" cssStyle="width:75%" readonly="false" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT>
					</td>
				</tr>
				<tr id="wt2">
					<td class="EditHead" width="15%"><FONT color=red>*</FONT>问题点</td>
					<td class="editTd" width="35%">
						<s:textfield name="ledgerProblem.problem_name" id="problem_name" cssClass="noborder" cssStyle="width:70%" readonly="true"/>
						<s:hidden name="ledgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;

						<img  style="cursor:pointer;border:0" src="/ais/resources/images/s_search.gif" onclick="openProblemPoint();"/>

					</td>
					<td class="EditHead" id="problemCommentText"  width="15%">备注(问题点为其他)</td>
					<td class="editTd" width="35%">
						<s:textarea name="ledgerProblem.problemComment" id="problemComment" cssStyle="width:74%;height:30px;display:none" />
						<input type="hidden" id="ledgerProblem.problemComment.maxlength" value="1000">
					</td>
				</tr>
				<tr id="wt3">
					<td class="EditHead"><FONT color=red>*</FONT>是否可量化</td>
					<td class="editTd" colspan="3">
						<s:select  name="ledgerProblem.quantify" id="quantify"
								   cssClass="easyui-combobox" list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" onchange="changVle();" listValue="value"  cssStyle="width: 160px"
								   listKey="key" />
					</td>
				</tr>
				<tr id="wt4">
					<td class="EditHead">发生金额</td>
					<td class="editTd">
						<s:textfield name="ledgerProblem.problem_money" id="problem_money" cssClass="noborder" cssStyle="width:34%" doubles="true" maxlength="15" />&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd"><s:textfield name="ledgerProblem.problemCount" id="problemCount" cssClass="noborder" cssStyle="width:45%" doubles="true" maxlength="5" />&nbsp;个</td>

				</tr>

				<tr id="wt5">
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<input type="text"  id="creater_startdate" name="ledgerProblem.creater_startdate" class="easyui-datebox" style="width: 160px"
							   value="${ledgerProblem.creater_startdate }" editable="false"/>
					</td>
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<input type="text"  id="creater_enddate" name="ledgerProblem.creater_enddate" class="easyui-datebox" style="width: 160px"
							   value="${ledgerProblem.creater_enddate }" editable="false"/>
					</td>
				</tr>
				<tr id="wt6">
					<td class="EditHead">审计发现类型</td>
					<td class="editTd">
							<s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" name="ledgerProblem.problem_grade_code"></s:select>
						<select id="problem_grade_code" class="easyui-combobox" name="ledgerProblem.problem_grade_code" style="width:160px;" data-options="panelHeight:100" editable="false">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.problemMethodList" id="entry">
								<s:if test="${ledgerProblem.problem_grade_code==code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead">会计制度类型</td>
					<td class="editTd">
							<s:select cssStyle="width:45%" id="accountantSystemTypeCode" name="ledgerProblem.accountantSystemTypeCode" onchange="accountantSystemTypeFun();" list="basicUtil.accountingTypeList" listKey="code" listValue="name" headerKey="" headerValue="" theme="ufaud_simple" templateDir="/strutsTemplate" />
						<select id="accountantSystemTypeCode" class="easyui-combobox" name="ledgerProblem.accountantSystemTypeCode" style="width:160px;" editable="false" data-options="panelHeight:100">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.accountingTypeList" id="entry">
								<s:if test="${ledgerProblem.accountantSystemTypeCode==code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						</select>
						<input type="hidden" id="accountantSystemTypeName" name="ledgerProblem.accountantSystemTypeName"/>
					</td>
				</tr>
				<tr id="wt7">
					<s:if test="ledgerProblem.pro_type == '020312'">
						<td class="EditHead"><FONT color=red>(经济责任审计)</FONT>责任</td>
						<td class="editTd" colspan="3">
							<select id="zeren"  name="ledgerProblem.zerencode" style="width:160px;" editable="false" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.problemDutyList" id="entry">
									<s:if test="${ledgerProblem.zerencode==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<input type="hidden" id="accountantSystemTypeName" name="ledgerProblem.zeren"/>
							<select id="zerenattach" name="zerenattach" style="display: none;">
								<option value=""></option>
								<s:iterator value="basicUtil.problemDutyList" status="status">
									<option value="<s:property value='code'/>"><s:property value='note' /></option>
								</s:iterator>
							</select>
						</td>
					</s:if>
					<s:else>
						<td class="EditHead"><FONT color=red>(非经济责任审计)</FONT>责任</td>
						<td class="editTd" colspan="3">
							<select id="zeren"  name="ledgerProblem.zerencode" style="width:160px;" editable="false" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.problemDuty2List" id="entry">
									<s:if test="${ledgerProblem.zerencode==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<select id="zerenattach" name="zerenattach" style="display:none;">
								<option value=""></option>
								<s:iterator value="basicUtil.problemDuty2List" status="status">
									<option value="<s:property value="code"/>"><s:property value='note'/></option>
								</s:iterator>
							</select>
						</td>
					</s:else>
				</tr>
				<tr id="desc">
					<td class="EditHead">
						<div style="text-align:center; float: right;">
							<s:if test="'GZNX' == '${dqxm}'">问题描述</s:if>
							<s:else>问题摘要</s:else><br/>
						<font color=DarkGray>(限6000字)</font></div><br/><br/>
					</td>
					<td class="editTd" colspan="3">
						<s:textarea name="audManuscript.describe" cssClass='noborder' id="describe"
							       rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						<input type="hidden" id="audManuscript.describe.maxlength" value="6000">
					</td>
				</tr> --%>
				<s:if test="audManuscript.interact==1">
					<tr>
						<td class="EditHead">审计证据
							<br/><div style="text-align:right"><font color=DarkGray>(限3000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<div id="subModelHTML" runat="server" style="border-style: none; left: 0px; overflow: scroll;
							     width: 100%; position: relative; top: 0px; height: 260px;">
								<s:property escape="false" value="audManuscript.subModelHTML" />
							</div>
							<s:hidden name="audManuscript.subModelHTML" />
							<s:hidden name="audManuscript.ms_description" />
						</td>
					</tr>
					</s:if>
					<s:hidden name="audManuscript.interact" />
					<s:if test="'GZNX' == '${dqxm}'">
						<tr>
							<td class="EditHead">查证过程
								<br/><div style="text-align:right"><font color=DarkGray>(限3000字)</font></div>
							</td>
							<td class="editTd" colspan="3">
								<s:textarea cssClass='noborder' name="audManuscript.audit_method_name"
											rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							</td>
						</tr>
	                 </s:if>
		<%-- 			 <tr id="law">
						<td class="EditHead"><br>定性依据
							<br/><div style="text-align:right"><font color=DarkGray>(限3000字)</font></div>
							<div style='margin-top:3px;'>
								<a id="lr_openZcfgTree" mc='audit_law' href="javascript:void(0);" class="easyui-linkbutton" 
							       data-options="iconCls:'icon-search'" >引用法规制度</a>
								<input type="hidden" id="att" name="att" value="">
								<input type="hidden" id="att2" name="att2" value="">
							</div>
						</td>
						<td class="editTd" colspan="4">
							<s:textarea  cssClass='noborder' name="audManuscript.audit_law" id='audit_law'
								         rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="audManuscript.audit_law.maxlength" value="3000">
						</td>
					</tr> --%>
					<!-- add by qfucee, 2013.11.7 -->
			<%-- 		<tr id="advice">
						<td class="EditHead">
							<div style="text-align:center; float: right;">处理建议<br/><font color=DarkGray>(限3000字)</font></div><br/><br/>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea  cssClass='noborder' id="audit_advice" name="audManuscript.audit_advice" value="${audManuscript.audit_advice}" rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="audManuscript.audit_advice.maxlength" value="3000">
						</td>
					</tr> --%>
					
		
					<tr id="record">
						<td class="EditHead">审计过程记录
							<div>
								<font color=DarkGray>(限5000字)</font>
							</div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" title="审计过程记录" name="audManuscript.audit_record" id='audit_record'
							value="${audManuscript.audit_record}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
							<input type="hidden" id="audManuscript.audit_record.maxlength" value="5000">
						</td>
					</tr>
					<tr id="tr_audit_con" >
							<td class="EditHead">
										<span id="auditconclusion" ></span>审计结论
							   <div>
								<font color=DarkGray>(限5000字)</font>
							   </div>
							</td>
							<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" title="审计结论" name="audManuscript.audit_con" id='audit_con'
							value="${audManuscript.audit_con}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
							<input type="hidden" id="audManuscript.audit_con.maxlength" value="5000">
							</td>
					</tr>
					<!-- end -->
					<s:if test="digaofankui=='enabled'">
						<tr>
							<td class="EditHead">&nbsp;&nbsp;&nbsp;被审计单位反馈意见
								<font color=DarkGray>(限3000字)</font>
							</td>
							<td class="editTd" colspan="3"><s:textarea
									cssClass='autoResizeTexareaHeight'
									name="crudObject.audit_dept_feedback"
									cssStyle="width:100%;height:200px;overflow-y:hidden;" /></td>

						</tr>
						<%-- <tr >
							<td colspan="4" class="EditHead" style="text-align:left;">底稿反馈信息</td>
						</tr>
						<tr>
							<td class="EditHead">反馈意见</td>
							<td class="editTd" colspan="3">
								<s:textarea cssClass='noborder' name="audManuscript.audit_dept_feedback"
									        rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
							</td>
						</tr> --%>
					</s:if>
					<s:else>
						<s:hidden name="audManuscript.audit_dept_feedback" />
					</s:else>
					<s:hidden name="audManuscript.audit_regulation" />
					<s:hidden name="audManuscript.audit_file" />
					<s:hidden name="audManuscript.ms_code_sort" />
					<s:hidden name="taskInstanceId" />
					<s:hidden name="audManuscript.prom" />
					<s:hidden name="audManuscript.feedback" />
					<s:hidden name="audManuscript.batch" />
					<s:hidden name="audManuscript.audit_law" />
					<s:hidden name="owner" />
					<s:hidden name="groupCode" />
					<s:hidden name="audManuscript.file_id"></s:hidden>
				</table>
				<br>

			<%@include file="/pages/bpm/list_transition.jsp"%>
			<s:hidden name="audManuscript.formId" />
		
			</div>
		</s:form>
		
		<div id="sjproblemtr">
			<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
				<tr>
					
				 	<td class="EditHead" id="sjproblemtd1" style="text-align: left;">审计问题
					</td>
					</tr>

					<tr>

					<td class="EditHead" colspan="3" id="sjproblemtd2">
						<iframe  width=100% height=150 frameborder=0 scrolling=auto id="mainIFrame" 
							src="/ais/proledger/problem/listDigaoEditProblem.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&manuscriptType=digao&view=add&taskId=${taskId}&taskPid=${taskPid}"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<br>
		<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
			<tr>
				<td style="height: 300px;">
					<div id="manu_file" class="easyui-fileUpload"
						 data-options="fileGuid:'${audManuscript.file_id}',callbackGridHeight:300"></div>
				</td>
			</tr>
		</table>
	</div>
</div>
	<div id="manuReferenceDiv" title="引用底稿数据" style='overflow:hidden;padding:0px;'> 	  		
		<iframe id="myFrame" name="myFrame" title="引用底稿" src="" width="100%" height="100%" frameborder="0"></iframe>		
    </div>
    <div id="manuProblemDiv" title="" style='overflow: hidden; padding: 0px;'>
	<iframe id="myFrameProblem" name="myFrameProblem" title="" src="" width="100%" height="100%" frameborder="0">
	</iframe>
</div>
	<!-- 审计问题选择 -->
<!-- 	<div id='sjwtSelectWrap' title='违规问题选择' style='overflow:hidden; border:0px solid #cccccc;'>
		<div style='padding:8px; text-align:center;display:none'>
	 		<button id='addsjwtStr'  class="easyui-linkbutton" iconCls="icon-add">保存并插入</button>
	 	</div>
	 		<iframe width="100%" height="100%" frameborder=0 id="mainIFrameSjwt"></iframe>
	</div>
	问题类别树
	<div id='wtlbTreeSelectWrap' title='问题类别' style='overflow:hidden; margin:0px;'>
		<div id="container" class='easyui-layout' fit='true' >
			<div  region="west"  split="true" style='overflow:hidden;width:250px;' title='问题树'>
				<ul id='auditObjectTreeId'></ul>
			</div>
			<div region="center">
				<div id="qtab" class="easyui-tabs"  fit="true" style="overflow-x:auto;">
				</div>
			</div>
			<div region="south" style="height:40px;padding:5px 5px 3px 5px;text-align:right;overflow:hidden;">
				<button id='sureSelectWtlbTreeNode'  class="easyui-linkbutton" iconCls="icon-add">添加</button>&nbsp;&nbsp;
				<button id='closeSelectWtlbTreeNode' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button>
			</div>
		</div>

	</div> -->
	<%--  <jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" /> --%>
</body>

<script type="text/javascript">

 // 未找到对应使用位置
function editerTableCell(tableId,noEdiId){
	var tdObject = event.srcElement;
	var tObject = ((tdObject.parentNode).parentNode).parentNode;
	if(tObject.id == tableId &&tdObject.id != noEdiId&&editer_table_cell_tag == false && run_edit_flag == true){
		 var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;		
		 //var nodes = ((tpObject.parentNode.lastChild.lastChild.lastChild.lastChild.childNodes));
		tdObject.innerHTML = "<input type='text' id='edit_table_txt' name='edit_table_txt' value='"+tdObject.innerText+"' size='15' onKeyDown='enterToTab()'>  <input type=button value=' 确定 ' onclick='certainEdit()'>";
		//edit_table_txt.focus();
		//edit_table_txt.select();
		editer_table_cell_tag = true;
		//修改按钮提示信息
		//editTip.innerText = "请先点确定按钮确认修改!";		
	} else {
		return false;
	}
}

/**
 * 确定修改
 */
function certainEdit() {
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
function noblank(txtObject){
	if(txtObject.value.replace(/\s+$|^\s+/g,"")=="null"){
     	$.messager.alert('提示信息',"不能输入'null'!",'info');
		return false;
   	}
 	if(txtObject.value.replace(/\s+$|^\s+/g,"")=="NULL"){
    	$.messager.alert('提示信息',"不能输入'null'!",'info');
		return false;
    }
  	return true;
}

function enterToTab() {
    if(event.srcElement.type != 'button' && event.srcElement.type != 'textarea' && event.keyCode == 13) {
        event.keyCode = 9;
    }
}


/**
 * 控制是否编辑
 */
function editStart() {
	if(editer_table_cell_tag == false){

	}else{
		$.messager.alert('提示信息',"请先点'确定'按钮,确定修改的内容！",'info');
		return false;
	}
	 
	 
	if(event.srcElement.value == "开始编辑") {
		if(run_edit_flag==true){
			$.messager.alert('提示信息',"一次只能编辑一个表格!请先点'编辑完成'按钮!",'info');
			return false;
		} else {
			  
		}
		event.srcElement.value = "编辑完成";
		run_edit_flag = true;
		// fff();
	} else {
		//如果当前没有编辑框,则编辑成功,否则,无法提交
		//必须按确定按钮后才能正常提交
		if(editer_table_cell_tag == false) {
			$.messager.alert('提示信息',"编辑成功结束!请点页面下方的保存按钮保存数据!",'info');
			event.srcElement.value = "开始编辑"; 
			run_edit_flag = false;

			var t=document.getElementById('subModelHTML');
			document.getElementById('audDoubt.subModelHTML').value=t.innerHTML;
			

		} else {
			$.messager.alert('提示信息',"请先点'确定'按钮,确定修改的内容!",'info');
			return false;
		}
	}
}

/**
 * 根据不同的按钮提供不同的提示信息
 */
function showTip() {
	if(event.srcElement.value == "编辑完成") {
		editTip.style.top = event.y + 15;
		editTip.style.left = event.x + 12;
		editTip.style.visibility = "visible";		
	} else {
		editTip.style.visibility = "hidden";			
	}	
}
 
function deleteCell() { 
	if(editer_table_cell_tag == false) {
		
	}else{
		$.messager.alert('提示信息',"请先点'确定'按钮,确定修改的内容!",'info');
		return false;
	}
			 
	var tdObject = event.srcElement;
	var tpObject = ((tdObject.parentNode).parentNode).parentNode;	
  	if(flag){
       	parent.$.messager.confirm('确认', '确认删除本行的数据吗?', function(flag){
       		if (flag) {
       			var tpObject2 = ((tdObject.parentNode).parentNode);
        		tpObject.removeChild(tpObject2);
       		}
       	});
    }else{ 
     	$.messager.alert('提示信息',"一次只能编辑一个表格!请先点本表格'开始编辑'按钮!",'info');
    	return false;
    }
}	
var editer_table_cell_tag = false;
//开启编辑功能标志,值为true时为允许编辑
var run_edit_flag = true;
var run_edit_all = "";

function onlyNumbers1(s){
    re = /^\d+\d*$/
    var str=s.replace(/\s+$|^\s+/g,"");
    if(str==""){
    	return false;
    }
    if(!re.test(str)){
	    $.messager.alert('提示信息',"只能输入正整数,请重新输入",'info');
	    return true ;   
    }
}

// 改变问题的高度
function changProblemHeight(rows){
  if(rows){
	  document.getElementById("mainIFrame").height=100+30*rows;
   }
}

function fff() { 
var t=document.getElementById('subModelHTML');
run_edit_all = t.innerHTML;
}
		 	  
function editReset() { 
if(editer_table_cell_tag == false) {
	
}else{
	$.messager.alert('提示信息',"请先点'确定'按钮,确定修改的内容!",'info');
	return false;
}
parent.$.messager.confirm('确认', '确认重置疑点内容的数据吗?', function(flag){
		if (flag) {
			var t=document.getElementById('subModelHTML');
		t.innerHTML=document.getElementById('audDoubt.subModelHTML').value;
		}
	});

}
		 	  
function deleteCellAll(){ 
var flag=true;
if(editer_table_cell_tag == false) {
	
}else{
	$.messager.alert('提示信息',"请先点'确定'按钮,确定修改的内容!",'info');
	return false;
}
					 
var tdObject = event.srcElement;
var tpObject = (((tdObject.parentNode).parentNode).parentNode).parentNode;		
if(flag){
  	parent.$.messager.confirm('确认', '确认清空本表格的数据吗?', function(flag){
 		if (flag) {
 			var ulListChild = tpObject.childNodes;
	      		for (var i=0; i<ulListChild.length; i+=1) {
		        	var tpObject = (ulListChild[i]);	
		        	var dd = tpObject.firstChild;
					if(dd!=null){
					 	tpObject.removeChild(dd); 
					}   
	      		}
 		}
 	});
  	
}
}	
    function closeSelectWrap(){
	  $('#sjwtSelectWrap').window('close');
    }
 	
	function doSelectWrap(){
		$("#addsjwtStr").trigger("click");
	}
	
	function callback() {
		var codes = document.getElementById("att").value;
		var names = document.getElementById("att2").value;
		var sort_code = codes.split("#");
		var sort_name = names.split("#");
		var allName =sort_name[sort_name.length - 2];
		document.getElementsByName("ledgerProblem.problem_code")[0].value = sort_code[0];
		if (sort_code.length - 4 <= 0) {
			document.getElementsByName("ledgerProblem.sort_three_code")[0].value = '';
		} else {
			document.getElementsByName("ledgerProblem.sort_three_code")[0].value = sort_code[sort_code.length - 4];
		}
		if (sort_code.length - 3 == 0) {
			document.getElementsByName("ledgerProblem.sort_small_code")[0].value = '';
		} else {
			document.getElementsByName("ledgerProblem.sort_small_code")[0].value = sort_code[sort_code.length - 3];
			allName = allName+" - "+sort_name[sort_name.length - 3];
		}
		document.getElementsByName("ledgerProblem.sort_big_code")[0].value = sort_code[sort_code.length - 2];
		document.getElementsByName("ledgerProblem.problem_name")[0].value = sort_name[0];
		if (sort_name.length - 4 <= 0) {
			document.getElementsByName("ledgerProblem.sort_three_name")[0].value = '';
		} else {
			document.getElementsByName("ledgerProblem.sort_three_name")[0].value = sort_name[sort_name.length - 4];
			allName = allName+" - "+sort_name[sort_name.length - 4];

		}
		if (sort_name.length - 3 == 0) {
			document.getElementsByName("ledgerProblem.sort_small_name")[0].value = '';
		} else {
			document.getElementsByName("ledgerProblem.sort_small_name")[0].value = sort_name[sort_name.length - 3];
		}
		document.getElementsByName("ledgerProblem.sort_big_name")[0].value = sort_name[sort_name.length - 2];
		document.getElementsByName("ledgerProblem.problem_all_name")[0].value = allName;
		doProblemComment(sort_name[0]);
		if(sort_name[0] != "其他"){
			getGist(sort_code[0]);
		}
	}
	function openProblemPoint(){
		var wttreeobj = $('#auditObjectTreeId')[0];
		var dpId = $('#problem_code').val();//var dpId = '${user.fdepid}';
		// 打开问题类别树窗口
		var wtWidth = $('body').width()*0.8;
		wtWidth = wtWidth < 780 ? 780 : wtWidth;
		$('#wtlbTreeSelectWrap').window({
			width:890,
			height:430,
			modal:true,
			collapsible:false,
			maximizable:false,
		});
		// 自定义 - 组织机构树
		showSysTree(wttreeobj,{
			container:wttreeobj,
			defaultDeptId:dpId,
			param:{
				/*
				 数据授权模块id, 12:组织机构树授权; 如果是组织机构树,这个参数可选; 如果是其它树,如果想用数据授权限制查询范围,则必填;
				 如果想显示全部的节点，可以为authModuleId赋一个特殊值authModuleId=-1，使sql查询不到；
				 */
				'rootParentId':'0',
				'beanName':'LedgerTemplateNew',
				'treeId'  :'id',
				'treeText':'name',
				'treeParentId':'fid',
				'treeOrder':'orderNO'
			},
			onTreeClick:function(node, treeDom){
				genAuditCaseTabs('qtab', node.id);
			}

		});
	}
	//是否允许填写“备注”
	function doProblemComment(problem_name){

		if(problem_name == '其他' || problem_name == '其它'){
			$("#ft").remove();
			$("#problemComment").css("display","block");
			$("#problemCommentText").append("<FONT color=red id=ft>*</FONT>");
			$("#problemComment").attr("maxlength",1000);
		}else{
			$("#problemComment").val("");
			$("#problemComment").css("display","none");
			$("#problemCommentText").html("").html("备注(问题点为其他)");
		}
	}
	function loadZeren(zeren){
		$('#zeren').combobox('setText',zeren);
	}
	function zerenOpr(){
		var zerenval = $("#zeren").val();
		$("#zerenattach option[value="+zerenval+"]").attr("selected",true);
		$("#audit_law").val($("#audit_law").val()+"\n\n"+$("#zerenattach option:selected").text());
	}

	/**
	 取得数量单位的下拉菜单
	 **/
	function problemUnitList(problemCode, problemUnitCode) {
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);
		DWRActionUtil.execute({
			namespace : '/proledger/problem',
			action : 'problemUnitList',
			executeResult : 'false'
		}, {
			'problemCode' : problemCode,
			'problemUnitCode' : problemUnitCode
		}, xxx);
		function xxx(data) {
			problemUnitSelect = data['problemUnitSelect'];
			if (problemUnitSelect == null) {
				problemUnitSelect = '';
			}
			document.getElementById('unitsDiv').innerHTML = problemUnitSelect;
		}
	}
	// 创建审计案例tabs, add by qfucee, 2015.1.19
	function genAuditCaseTabs(tabsId, nodeid, max_query_count){
		try{
			max_query_count = !max_query_count ? 30 : max_query_count;
			$.ajax({
				type: "POST",
				dataType:'json',
				url : "<%=request.getContextPath()%>/commonPlug/getCustomDatagrid.action",
				data:{
					'boName':'ProblemCase',
					'sort'  :'case_name',
					'query_eq_problemId':nodeid,
					'number':max_query_count//最大查询记录
				},
				success: function(data){
					var rows = data.rows;
					var total = data.total;

					var tabs_interval = window.setInterval(function(){
						var tabs = $('#'+tabsId).tabs('tabs');
						if(tabs && tabs.length > 0){
							for(var j=0; j<tabs.length; j++){
								$('#'+tabsId).tabs('close', j);
							}
						}else{
							if(tabs_interval){
								clearInterval(tabs_interval);
								if(total){
									$.each(rows, function(index, row){
										var fjStr="";
										$.ajax({
											dataType:'json',
											url : "<%=request.getContextPath()%>/ledger/problemledger/getFujianUrl.action",
											data: {id:row['id']},
											type: "post",
											async:false,
											success: function(data){
												fjStr = data.fjUrl;
											},
											error:function(data){
												top.$.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
											}
										});
										var content = [];
										content.push("<div style='overflow:hidden;'><table class='ListTable'>");
										content.push("<tr><td style='text-align:center;' class='EditHead'>正文</td></tr>");
										content.push("<tr><td style='width:100%;' class='editTd'>");
										content.push("<textarea class='mytabcontent' readonly style='border-width:0px;word-break:break-all;word-wrap:break-word;height:140px;overflow:auto;width:590px;padding:5px;color:gray;'>");
										content.push(row.case_content);
										content.push("</textarea></td></tr>");
										content.push("<tr><td class='EditHead'><span style='float:left;'>附件信息</span><span style='float:right;color:gray;'>文件总数："+(fjStr.split('<li').length-1)+"</span></td></tr>");
										content.push("<tr><td style='width:100%;' class='editTd'><div style='color:gray;padding:5px 5px 5px 1px;height:105px;overflow:auto;'>");
										content.push(fjStr);
										content.push("</div></td></tr></table></div>");

										var tabTitle = row.case_name;
										if(tabTitle && tabTitle.length > 10){
											tabTitle = tabTitle.substring(0,10)+'...';
										}
										$('#'+tabsId).tabs('add',{
											'title':tabTitle,
											'content':content.join('')
										});
										var curTab = $('#'+tabsId).tabs('getTab', tabTitle);
										curTab.css('overflow','hidden');
									});
								}else{
									$('#'+tabsId).tabs('add',{
										'title':'案例信息',
										'content':"<div style='font-size:16px;text-align:center;padding:10px;color:red;'><strong><label style='text-align:center;'>没有符合要求的案例!</label></strong></div>"
									});
								}
								$('#'+tabsId).tabs('select',0);
							}
						}
					},100);
				},
				error:function(data){
					top.$.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
				}
			});
		}catch(e){
			alert('genAuditCaseTabs:\n'+e.message);
		}
	}
<%-- $(function(){
		var listSjwtUrl = '${contextPath}/proledger/problem/listDigaoEditProblem.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&view=add&source=doubt';
  		var addSjwtUrl  = '${contextPath}/proledger/problem/editDigao.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&id=0&manuscriptType=${manuscriptType}&source=doubt';
   		var editSjwtUrl = '${contextPath}/proledger/problem/editDigao.action?project_id=${audManuscript.project_id}&manuscript_id=${audManuscript.formId}&source=doubt';
   		// 打开问题窗口
  	    $('#sjwtSelectWrap').window({ 
  	    	width :950,   
			height:450,   
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true,
  			onOpen:function(){
  				var iframe = document.getElementById("mainIFrameSjwt");
  				$.ajax({
  					   type: "POST",
  					   url: "${contextPath}/proledger/problem/save!checkIfhasProblem.action",
  					   data: {"project_id":"${audManuscript.project_id}","manuscript_id":"${audManuscript.formId}"},
  					   success: function(problemId){
  					      if(problemId == ""){
  					    	  iframe.src = addSjwtUrl;
  					      }else{
  					    	  iframe.src = editSjwtUrl+"&id="+problemId;
  					      }
  					   }
  				});
  			}
  		});
  		// 打审计问题窗口
  		$('#lr_openSjwtWin').bind('click',function(){
  			// 判断底稿code是否已经生成，即：是否已经保存
  			var manuFormId = "${audManuscript.formId}";
  			if(!manuFormId){
  				var msg = "请您先保存底稿，【确定】继续自动保存当前底稿；否则放弃！";
  				parent.$.messager.confirm('提示信息',msg, function(flag){
  					if(flag){
  						saveForm();
  					}				
  				});	
  			}else{
  				$('#sjwtSelectWrap').window('open');
  			}			
  		});
	  	$('#addsjwtStr').bind('click',function(){
	  		var obj = document.getElementById('audit_con');
  	        $.ajax({
  	            url : '${contextPath}/proledger/problem/loadJsonStringDigao.action',
  	            data: {
  	        		'project_id':'${audManuscript.project_id}',
  	        		'manuscript_id':'${audManuscript.formId}',
  	        		'start':'0',
  	        		'limit':'20'
  	        	},
  	            type: "post",
  	            success: function(data){
  	            	var rts = [];
  	            	var list = data.list;
  	            	if(list && list.length > 0){
  	            		var row = list[0];
  	            		if(row.problem_name == '其他'){
  	            			rts.push(row.problemComment+',');
  	            		}else{
  	            			rts.push(row.problem_name+", ");
  	            		}
  		            	rts.push(row.problem_money == null ?"0万元, ": row.problem_money +"万元, ");
  		            	rts.push(row.problemCount == null ? "0个" :row.problemCount +"个");
  		                //此处判断，如果审计法规依据为空，则插入值，如果不为空则不处理
		            	contain.val(row.audit_law ==null ? "" :row.audit_law +"\n");
  		               //obj.value = rts.join('');
  	            		textMoveToEnd(obj);
  	            	}
  	            }
  	        });
	  		$('#sjwtSelectWrap').window('close');			
	  	});
	  		
//  		// 打开问题类别树窗口
//  	    $('#wtlbTreeSelectWrap').window({
//  			width:700,
//  			height:450,
//  			modal:true,
//  			collapsible:false,
//  			maximizable:false,
//  			minimizable:false,
//  			closed:true
//  		});
  		$('#lr_openWtlbTree').bind('click',function(){
  			$('#wtlbTreeSelectWrap').window('open');
  		});
  	    // 加载问题类别树
  	    $('#wtlbTreeSelect').tree({   
  			url:"<%=request.getContextPath()%>/adl/getWtlbTree.action",
  			lines:true,
  	        onClick:function(node){},
  			onDblClick:function(node){
  				$('#sureSelectWtlbTreeNode').trigger('click');
  			}
  		});
  	    
		$('#sureSelectWtlbTreeNode').bind('click',function(){
			var snode = $('#auditObjectTreeId').tree('getSelected');
			if(snode){
				if(!$('#auditObjectTreeId').tree('isLeaf',snode.target)){
					top.$.messager.alert('提示信息','不能添加问题类别，请选择问题点','error');
				}else{
					var idArr = QUtil.getPriorNodeIds(snode.id,"/ais/commonPlug/getPriorNodeIdsById.action?beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid");
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
							}
						},
						error:function(data){
							alert('请求失败！');
						}
					});
					$('#wtlbTreeSelectWrap').window('close');
				}
			}else{
				wtnode = $('#problem_code').val();
				if(wtnode){
					var idArr = QUtil.getPriorNodeIds(wtnode,"/ais/commonPlug/getPriorNodeIdsById.action?beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid");
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
							}
						},
						error:function(data){
							alert('请求失败！');
						}
					});
					$('#wtlbTreeSelectWrap').window('close');
				}else{
					top.$.messager.alert('提示信息','请选择问题点','error');
				}
			}

		});
		$('#closeSelectWtlbTreeNode').bind('click',function(){
			$('#wtlbTreeSelectWrap').window('close');
		});
	
		var problemCount = "${ledgerProblem.problemCount}";
		if(problemCount == null || problemCount == ""){
			$("#problemCount").val("1");
		}else{
			$("#problemCount").val(problemCount);
		}
		
		$('#zeren').combobox({
			panelHeight:'auto',
			onChange:function(newValue,oldValue){
				$("#zerenattach option[value="+newValue+"]").attr("selected",true);
				$("#audit_law").val($("#audit_law").val()+"\n\n"+$("#zerenattach option:selected").text());
				$("#audit_law").focus();
			}
		});
		$('#quantify').combobox({
			panelHeight:'auto',
			editable:false,
			onChange:function(newValue,oldValue){
				if(newValue=='是'){
					document.myform.problem_money.disabled = false;
					var problem_money = "${ledgerProblem.problem_money}";
					$("#problem_money").val(problem_money);
					//document.myform.problemCount.disabled = false;
				}else{
					document.myform.problem_money.value = "";
					//document.myform.problemCount.value = "";
					document.myform.problem_money.disabled = true;
					//document.myform.problemCount.disabled = true;

				}
			}
		});
   }) --%>
</script>
</html>
