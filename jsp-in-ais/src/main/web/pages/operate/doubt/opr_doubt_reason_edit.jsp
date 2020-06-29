<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:if test="type == 'BW'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加备忘'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'查看备忘'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'YD'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加疑点'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'查看疑点'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'FX'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加发现'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'查看发现'"></s:text>
	</s:else>
</s:if>

<s:if test="type == 'DS'">
	<s:if test="doubt_id == null">
		<s:text id="title" name="'添加重大事项'"></s:text>
	</s:if>
	<s:else>
		<s:text id="title" name="'查看重大事项'"></s:text>
	</s:else>
</s:if>

<html>
	<head>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>

   <%String owner=request.getParameter("owner");
    String strOwner="";
	if("true".equals(owner)){//为true的时候，加前缀，定义新的tab页id用
		owner="-owner";
		strOwner="true";
	}else{
		owner="";
	}
	%>
	<script language="JavaScript">
	
	 $(document).ready(function(){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
  });
	/*
	 *  打开或关闭
	*/
	function triggerSearchTable(flag){
		if (flag == '1') {
			$("#viewDoubt").hide();
			$("#hideDoubt").show();
			$("#searchTable").show();
			$("#file_Table").show();
			$('#doub_file').fileUpload({
				fileGuid:'${audDoubt.file_id}',
				isAdd:false,
				isEdit:false,
				isDel:false
			});
			
		} else {
			$("#viewDoubt").show();
			$("#hideDoubt").hide();
			$("#searchTable").hide();
			$("#file_Table").hide();
		}
	}
				
// 	全局变量 
	//标志位,值为false代表未打开一个编辑框,值为true为已经打开一个编辑框开始编辑
	var editer_table_cell_tag = false;
	//开启编辑功能标志,值为true时为允许编辑
	var run_edit_flag = true;
	var run_edit_all = "";
	</script>

	<script language="JavaScript">
	/**
	 * 编辑表格函数
	 * 单击某个单元格可以对里面的内容进行自由编辑
	 * @para tableID 为要编辑的table的id
	 * @para noEdiID 为不要编辑的td的ID,比如说table的标题
	 * 可以写为<TD id="no_editer">自由编辑表格</TD>
	 * 此时该td不可编辑
	 */
	function editerTableCell(tableId,noEdiId) {
	 
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

	function enterToTab() {
	    if(event.srcElement.type != 'button' && event.srcElement.type != 'textarea' && event.keyCode == 13) {
	        event.keyCode = 9;
	    }
	}

	/**
	 * 控制是否编辑
	 */
	function editStart() {
		if (editer_table_cell_tag == false) {
			
		} else {
			alert("请先点'确定'按钮,确定修改的内容!");
			return false;
		}
		if(event.srcElement.value == "开始编辑") {
			 if(run_edit_flag==true){
				  alert("一次只能编辑一个表格!请先点'编辑完成'按钮");
				  return false;
			 }else{
				  
			 }
			event.srcElement.value = "编辑完成";
			run_edit_flag = true;
			// fff();
		} else {
			//如果当前没有编辑框,则编辑成功,否则,无法提交
			//必须按确定按钮后才能正常提交
			if(editer_table_cell_tag == false) {
				alert("编辑成功结束!请点页面下方的保存按钮保存数据!");
				event.srcElement.value = "开始编辑"; 
				run_edit_flag = false;
	
				var t=document.getElementById('subModelHTML');
				document.getElementById('audManuscript.subModelHTML').value=t.innerHTML;
				
	
			} else {
				alert("请先点'确定'按钮,确定修改的内容!");
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
	</script>
	<script language="javascript">
	function go(s){
	      window.open("${contextPath}/operate/doubt/view.action?doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	 }
	    
	function go1(s){
	     window.open("${contextPath}/operate/manu/viewAll.action?project_id=${project_id}&crudId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
          tt4='<a href=# onclick=go1(\"'+codeArray5[0]+'\")>'+codeArray5[1]+'</a>';
          tt4=tt4+"<br />";
        }
 	   p.innerHTML=tt1+tt2+tt3+tt4+tt5;
	}
  
    //法规制度
	function regu(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	//法规制度
	function law(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
     //返回上级list页面
    function backList(){
           var doubtListUrl = "";
           if('<%=strOwner%>' == 'true'){
        	   window.parent.location.reload();//返回到我的事项模块
             //doubtListUrl = '${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action?project_id=${audDoubt.project_id}&taskId=${audDoubt.task_id}&taskPid=${audDoubt.task_id}';
           }else{
              doubtListUrl = '${pageContext.request.contextPath}/operate/doubtExt/mainUi.action?project_id=${audDoubt.project_id}&taskId=-1&taskPid=${audDoubt.task_id}';
           }
		window.location.href = doubtListUrl;
     }
    //关闭
	function closeGenW(s){
		window.location.reload();
		window.parent.document.frames[s].location.reload(); 
	}

   //-------保存表单
   function saveForm(){
      var v_3 = "audDoubt.doubt_reason";  // field
	  var title_3 = '无问题原因';// field name
	  var notNull = 'true'; // notnull
	  var t=document.getElementsByName(v_3)[0].value;
	  if(t == null || t == ''){
	  	 $.messager.alert('提示信息',"无问题原因不能为空!",'info');
	  	 return false;
	  }
	  if(t.length > 1000){
	     $.messager.alert('提示信息',"无问题原因的长度不能大于1000字！!",'info');
	     document.getElementById(v_3).focus();
	     return false;
	  }
	  $.ajax({
	  	url:"${contextPath}/operate/doubt/saveDoubtReason.action?owner=<%=strOwner%>",
	  	type:"post",
	  	data:$("#myform").serialize(),
	  	async:false,
	  	success:function(){
        	top.$.messager.show({
	        	 title:"确认",
	         	 msg:"处理成功！",
	         	 timeout:5000,	         	 
	         });
	  	},
	  	error:function(){
	  		alert("系统错误，请联系系统管理员！");
	  	}
	  });
	 
   }
    //关闭
	function closeGenM(){
		window.parent.closeGenW('MS');
		window.close()
	}
    //上传附件
	function Upload(id,filelist,delete_flag,edit_flag){
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
      function getItem(url,title,width,height){
			$('#item_ifr').attr('src',url);
			$('#subwindow').window({
				title: title,
				width: width,
				height:height,
				top:($(window).height() - 420) * 0.5,   
		        left:($(window).width() - 1050) * 0.5,
				modal: true,
				shadow: true,
				closed: false,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
		}
    </script>
	</head>
	<body onload=Test();>
		<center>
			<s:form id="myform" onsubmit="return true;" cssStyle="width: 100%" action="/ais/operate/doubt" method="post">
				<table class="ListTable" width="98%">
					<tr>
						<td class="EditHead" width="15%">
							<div style="text-align: center; float: right;"><font color='red'>*</font>无问题原因:<br/><font color=DarkGray>(限1000字)</font></div>
						</td>
						<td class="editTd" colspan="3" width="85%">
							<s:textarea id="doubt_reason" name="audDoubt.doubt_reason" cssClass='noborder'
							 			rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						</td>
					</tr>
					<tr>
						<td class="editTd" colspan="4">
							<div align="right">
								<a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton" 
								   data-options="iconCls:'icon-redo'" onclick="saveForm();">处理</a>
								<a id="viewDoubt" href="javascript:void(0);" class="easyui-linkbutton" 
								   data-options="iconCls:'icon-search'" onclick="triggerSearchTable('1');">查看疑点</a>
								<a id="hideDoubt" href="javascript:void(0);" class="easyui-linkbutton" style="display:none;" 
								   data-options="iconCls:'icon-cancel'" onclick="triggerSearchTable('0');">关闭疑点</a>
								<s:if test="'${chuli}' == '1'">
									<a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton" 
									   data-options="iconCls:'icon-undo'" onclick="backList();">返回</a>
								</s:if>
								<s:else>
									<a id="saveFormFX" href="javascript:void(0);" class="easyui-linkbutton" 
									   data-options="iconCls:'icon-back'" onclick="closeGenM();">返回</a>
			                    </s:else>
							</div>
						</td>
					</tr>
				</table>
				<table id="searchTable" class="ListTable" style="display: none;width:98%">
					<tr>
						<td style="width:15%" class="EditHead">
							<font color="red"></font>疑点名称
						</td>
						<!--标题栏-->
						<td style="width: 35%" class="editTd">
						${audDoubt.doubt_name}
							<!--一般文本框-->
						</td>

						<td style="width: 15%" class="EditHead">状态</td>
						<!--标题栏-->
						<td style="width: 35%" class="editTd">
							<s:if test="audDoubt.doubt_status == '010'">未处理</s:if>
							<s:if test="audDoubt.doubt_status == '020'">等待批示</s:if>
							<s:if test="audDoubt.doubt_status == '030'">正在审批</s:if>
							<s:if test="audDoubt.doubt_status == '040'">审批完毕</s:if>
							<s:if test="audDoubt.doubt_status == '050'">
								<s:if test="audDoubt.doubt_manu == ''||audDoubt.doubt_manu == null||audDoubt.doubt_manu == 'null'">
										已处理无问题
   								</s:if>
								<s:else>已处理有问题</s:else>
							</s:if>
							<!--  s:property value="audDoubt.doubt_status" /-->
							<s:hidden name="audDoubt.doubt_status" />
							<s:hidden name="audDoubt.doubt_manu_name" id="audDoubt.doubt_manu_name"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width: 15%">
							<font color="red"></font>审计小组
						</td>
						<!--标题栏-->
						<td class="editTd" tyle="width: 35%">
							<s:property value="audDoubt.groupName" />
						</td>
						<td class="EditHead" style="width: 15%">
							<font color="red"></font>被审计单位
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<s:property value="audDoubt.audit_dept_name" />
						</td>
 					</tr>
					<tr>
						<td class="EditHead" style="width: 15%">
							<font color="red"></font>疑点编码
						</td>
						<!--标题栏-->
						<td class="editTd" style="width: 35%">
							<s:property value="audDoubt.doubt_code" />
							<s:hidden name="audDoubt.doubt_code" />
							<!--  s:textfield name="audDoubt.doubt_code" cssStyle="width:80%"/>-->
							<!--一般文本框-->
						</td>
						<td class="EditHead" style="width: 15%">
							<font color="red"></font>撰写人
						</td>
						<td class="editTd" style="width: 35%">
							<s:property value="audDoubt.doubt_author" />
							<s:hidden name="audDoubt.doubt_author_code" />
							<s:hidden name="audDoubt.doubt_author" />
						</td>
					</tr>
                     <s:hidden name="audDoubt.task_id" />
					 <s:hidden name="audDoubt.task_code" />
					 <s:hidden name="audDoubt.doubt_date" />
					<tr>
						<td class="EditHead" style="width: 15%">
							<font color="red"></font>审计事项
						</td>
						<td class="editTd" style="width: 35%">
						<s:property value="audDoubt.task_name" />
							<s:hidden name="audDoubt.task_name" />
							<s:hidden name="audDoubt.t_id" />
							<s:hidden name="audDoubt.doubt_memorandum" />
							<s:hidden name="audDoubt.doubt_found" />
							<s:hidden name="audDoubt.doubt_matters" />
							<s:hidden name="audDoubt.doubt_doubt" />
							<s:hidden name="audDoubt.doubt_manu" />
						</td>
						<td class="EditHead" style="width: 15%">
							<font color="red"></font>创建日期
						</td>
						<!--标题栏-->
						<td class="editTd" style="width:35%">
							<s:property value="audDoubt.doubt_date" />
							<s:hidden name="audDoubt.doubt_date" />
							<!--一般文本框-->
						</td>
					</tr>
					<!-- add by qfucee, 2013.7.15, 加入问题类别和政策依据 -->
		        	<tr>
		        		<td class="EditHead" style="width: 15%">问题类别</td>
		        		<td class="editTd" style="width:35%">${audDoubt.wtlbMc}</td>
		        		<td class="EditHead" style="width: 15%">政策法规依据</td>
		        		<td class="editTd" style="width:35%">${audDoubt.zcfgMc}</td>
		        	</tr>
		        	<!-- end -->
					<tr>
						<td class="EditHead" style="width: 15%">关联索引</td>
						<td class="editTd" colspan="3" style="width: 85%">
							<span id="manuCode"></span>
						</td>
					</tr>
					<tr>
						<td class="EditHead">疑点内容</td>
						<td class="editTd" colspan="3">
							<s:hidden name="audDoubt.interact" />
							<s:if test="audDoubt.interact==1">
								<textarea  class='noborder' name="audDoubt.subModelHTML" readonly="readonly" UNSELECTABLE='on'
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" > ${audDoubt.subModelHTML}</textarea>
									<s:hidden name="audDoubt.doubt_content" />
							</s:if>
							<s:elseif test="audDoubt.interact==2">
									<textarea  class='noborder' name="audDoubt.subModelHTML" readonly="readonly" UNSELECTABLE='on'
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" > ${audDoubt.subModelHTML}</textarea>
								<s:hidden name="audDoubt.doubt_content" />
							</s:elseif>
							<s:else>
								<textarea  class='noborder'  name="audDoubt.doubt_content" id="doubt_content" readonly="readonly" UNSELECTABLE='on'
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" >${audDoubt.doubt_content} </textarea>
									<s:hidden name="audDoubt.subModelHTML" />
								<s:hidden name="subModelHTML" />
							</s:else>
						</td>
					</tr>
					<tr>
						<td class="EditHead">法规制度</td>
						<td class="editTd" colspan="4">
							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
								<textarea  class='noborder' name="audDoubt.audit_law" id="audit_law" readonly="true" UNSELECTABLE='on'
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" >${audDoubt.audit_law} </textarea>
						</td>
					</tr>
					<s:if test="audDoubt.doubt_reason_flag == 1">
						<tr>
							<td class="EditHead" >无问题原因
							</td>
							<td class="editTd" colspan="4">
							<textarea  class='noborder' name="audDoubt.doubt_reason" id="doubt_reason" readonly="true" UNSELECTABLE='on'
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" > ${audDoubt.doubt_reason}</textarea>
							</td>
						</tr>
					</s:if>
					<s:hidden name="audDoubt.audit_regulation" />
				</table>
				<table id="file_Table" class="ListTable" style="display:none;width:98%" >
					<tr>
						<td class="EditHead" style="width: 14%">
							附件
							<s:hidden id="file_id" name="audDoubt.file_id" />
						</td>
						<td class="editTd" style="width: 86%">
							<div id="doub_file"></div>
						</td>
					</tr>
					<tr>
						<td class="editTd" colspan="2">
							<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
						</td>
					</tr>
				</table>
                 <s:hidden name="chuli" />
				<s:hidden name="newDoubt_type" />
				<s:hidden name="audDoubt.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
			</s:form>
		</center>
	</body>
</html>
