<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
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
<!--  重构后的代码   -->
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		

	<script type="text/javascript">
		$(function(){
			$('#veiwManu').window({
				modal:true,
				title:"查看关联底稿详情",
				collapsible:false,
				maximizable:true,
				minimizable:true,
				closed:true
			});
		})
		function go(s){
	    	window.open("${contextPath}/operate/doubt/view.action?doubt_id="+s,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	    }
	    function viewManu(manuId){
	    	/* var width = ($(window).width()-1200)*0.5;
	     	var height = ($(window).height()-550)*0.2; */
	     	
	     //	var myurl = "${pageContext.request.contextPath}/operate/manu/viewAll.action?project_id=${project_id}&crudId="+manuId;
	     //	top.addTab("tabs","查看关联底稿","manuViewTab",myurl,false);
	     	window.location.href = "${pageContext.request.contextPath}/operate/manu/viewAll.action?project_id=${project_id}&crudId="+manuId; 
	    	//$('#veiwManu').window("open").window("resize",{width:1200,height:550,left:width,top:height}).window("refresh",myurl);
	    }
	    
		function Test(){
	        var code1 = document.getElementsByName("audDoubt.doubt_memorandum")[0].value;
	        var code2 = document.getElementsByName("audDoubt.doubt_doubt")[0].value; 
	        var code3 = document.getElementsByName("audDoubt.doubt_found")[0].value; 
	        var code4 = document.getElementsByName("audDoubt.doubt_matters")[0].value; 
	        var manuId = document.getElementsByName("audDoubt.doubt_manu")[0].value;
	        var manuName = document.getElementById("audDoubt.doubt_manu_name").value;
	        var codeArray1=code1.split(',');
	        var codeArray2=code2.split(',');
	        var codeArray3=code3.split(',');
	        var codeArray4=code4.split(',');
	        var mamuIdArr = manuId.split(',');
	        //alert(manuName);
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
	          tt1='<a href=# onclick=go(\"'+codeArray1[0]+'\")>'+code6+'</a>';
	          tt1=tt1+"<br />";
	        }
	        if(codeArray2[0]!=null&&codeArray2[0]!=''){
	          tt2='<a href=# onclick=go(\"'+codeArray2[0]+'\")>'+code6+'</a>';
	          tt2=tt2+"<br />";
	        }
	        if(codeArray3[0]!=null&&codeArray3[0]!=''){
	          tt3='<a href=# onclick=go(\"'+codeArray3[0]+'\")>'+code6+'</a>';
	          tt3=tt3+"<br />";
	        }
	        if(codeArray4[0]!=null&&codeArray4[0]!=''){
	          tt4='<a href=# onclick=go(\"'+codeArray4[0]+'\")>'+code6+'</a>';
	          tt4=tt4+"<br />";
	        }
	        if(mamuIdArr.length > 0){
	          tt5='<a href="javascript:void(0)" onclick=viewManu(\"'+mamuIdArr[0]+'\")>'+manuName+'</a>';
	          tt5=tt5+"<br />";
	        }
	         document.getElementById("manuCode").innerHTML=tt1+tt2+tt3+tt4+tt5; 
	        
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
	function regu(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law',"height=700px, width=700px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
	
	function law(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu',"height=700px, width=700px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");if(win && win.open && !win.closed) win.focus();
	}
function backList(){
	myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&taskId=${taskId}&taskPid=${taskPid}&project_id=${project_id}";
	myform.submit();
}

function closeGenW(s){
	window.location.reload();
	//alert(s);
	window.parent.document.frames[s].location.reload(); 
	
	 //window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type=<s:property value="type" />&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>";
}

//模板生成----------保存表单
function saveForm(){
//alert("111");
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
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }


var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

var v_3 = "doubt.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true" && notNull != "")
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
 			}
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
     $(function(){
 		$("#myform").find("textarea").each(function(){
 			autoTextarea(this);
 		});
 	});
</script>
</head>
<body onload=Test(); >
	<div class='easyui-layout' fit='true' border='0'>
		<div region='center' border='0'>
		<center>
			<table class=ListTable style="width:98%">
				<tr>
					<td colspan="5" style="text-align:left;" class="EditHead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" onsubmit="return true;" cssStyle="width: 100%"  method="post">
				<table class="ListTable" style="width:98%">
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
							</s:if>
							<s:if test="audDoubt.doubt_status == '055'">已处理有问题</s:if>
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
							</s:if>
							<s:elseif test="audDoubt.interact==2">
							    <textarea  class='noborder' name="audDoubt.subModelHTML" readonly="readonly" UNSELECTABLE='on'
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" > ${audDoubt.subModelHTML}</textarea>
							
							</s:elseif>
							<s:else>
								<textarea  class='noborder'  name="audDoubt.doubt_content" id="doubt_content" readonly="readonly" UNSELECTABLE='on'
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" >${audDoubt.doubt_content} </textarea>
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
				<s:hidden name="newDoubt_type" />
				<s:hidden name="audDoubt.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<table class="ListTable" align="center" style='width: 98%; padding: 0px; margin: 0px;'>
					<tr>
						<td style="height: 300px;">
							<div id="manu_file" class="easyui-fileUpload"
								 data-options="fileGuid:'${audDoubt.file_id}',isAdd:false,isEdit:false,isDel:false,callbackGridHeight:300"></div>
						</td>
					</tr>
				</table>
			</s:form>
			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
			</center>
		</div>
	</div>
	<div id="veiwManu" style="padding:10 10 10 10"></div>
	</body>
</html>
