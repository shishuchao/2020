<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- 调入计划的基本信息 -->
<script type="text/javascript">
			var project_code="";
			var project_name="";
			var project_shape_name="";
			var plan_type_name="";
			var project_type_name="";
			var project_starttime="";
			var project_endtime="";
			var project_charge_budget="";
			var project_person_day_budget="";
			var project_audit_dept_name="";
			var project_teamleader_name="";
			var project_auditleader_name="";
			var project_team_members_name="";
			var project_audited_dept_name="";
			var project_audit_scope="";
			var project_remark="";
			var project_cognizance_person_name="";
			var project_duty_person_name ="";
			var ps_formId ="";
			var plan_id="";
			function selectProject()
			{
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				//打开选择计划窗口
				var url ='<s:url action="selectProject" namespace="/mng/opr" includeParams="none"></s:url>?param='+rnm;
				window.showModalDialog
				(url,window,"unadorned:yes;help:no;dialogHide:yes;center:yes;scroll:auto;status:no;dialogWidth=300px;dialogHeight=400px");
				//向表格指定位置写入数据
				if(project_name!=null&&project_name!="")
				{
					document.getElementById("project_code").innerHTML=project_code+"<input type='hidden' name='crudObject.project_code' value='"+project_code+"'/>";
					document.getElementById("project_name").innerHTML=project_name+"<input type='hidden' name='crudObject.project_name' value='"+project_name+"'/>";
					document.getElementById("project_shape_name").innerText=project_shape_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("plan_type_name").innerText=plan_type_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_type_name").innerText=project_type_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_starttime").innerText=project_starttime.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_endtime").innerText=project_endtime.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_charge_budget").innerText=project_charge_budget.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_person_day_budget").innerText=project_person_day_budget.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_audit_dept").innerText=project_audit_dept_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_teamleader").innerText=project_teamleader_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_auditleader").innerText=project_auditleader_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_team_members").innerText=project_team_members_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_audited_dept").innerText=project_audited_dept_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_audit_scope").innerText=project_audit_scope.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_remark").innerText=project_remark.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_cognizance_person").innerText=project_cognizance_person_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_duty_person").innerText=project_duty_person_name.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_remark").innerText=project_remark.replace(/\s+$|^\s+/g,"");
					document.getElementById("project_id").value=ps_formId.replace(/\s+$|^\s+/g,"");
				}
		}
			var XMLHttpReq_include=false;
 		//创建一个XMLHttpRequest对象
 		function createXMLHttpRequest_include(){
 				if(window.XMLHttpRequest){ //Mozilla 浏览器
 					XMLHttpReq_include=new XMLHttpRequest();
 					}
 					else if(window.ActiveXObject){ //微软IE 浏览器
 						try{
 							XMLHttpReq_include=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
 							}catch(e){
 								try{
 									XMLHttpReq_include=new ActiveXObject("Microsoft.XMLHTTP");
									//IE 5.0版本
 									}catch(e){}
 									}
 								}
 		}
 		//发送请求函数---获取计划附件列表
 		function send_include(url){
 			createXMLHttpRequest_include();
 			XMLHttpReq_include.open("GET",url,true);
 			XMLHttpReq_include.onreadystatechange=proce_include;//指定响应的函数
 			XMLHttpReq_include.send(null);  //发送请求
 			};
 		function proce_include(){
 			if(XMLHttpReq_include.readyState==4){ //对象状态
 				if(XMLHttpReq_include.status==200){//信息已成功返回，开始处理信息
 				var resText = XMLHttpReq_include.responseText;
 				document.getElementById("planFileList").innerHTML=resText;
 				}else{
 					window.alert("所请求的页面有异常");
 					}
 					}
 		}
 		var XMLHttpReq_include2=false;
 			//创建一个XMLHttpRequest对象
 		function createXMLHttpRequest_include2(){
 				if(window.XMLHttpRequest){ //Mozilla 浏览器
 					XMLHttpReq_include2=new XMLHttpRequest();
 					}
 					else if(window.ActiveXObject){ //微软IE 浏览器
 						try{
 							XMLHttpReq_include2=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
 							}catch(e){
 								try{
 									XMLHttpReq_include2=new ActiveXObject("Microsoft.XMLHTTP");
									//IE 5.0版本
 									}catch(e){}
 									}
 								}
 		}
 		//发送请求函数---获取流程处理人
 		function send_include2(url){
 			createXMLHttpRequest_include2();
 			XMLHttpReq_include2.open("GET",url,true);
 			XMLHttpReq_include2.onreadystatechange=proce_include2;//指定响应的函数
 			XMLHttpReq_include2.send(null);  //发送请求
 			};
 		function proce_include2(){
 			if(XMLHttpReq_include2.readyState==4){ //对象状态
 				if(XMLHttpReq_include2.status==200){//信息已成功返回，开始处理信息
 				var resText = XMLHttpReq_include2.responseText;
 				document.getElementById("transitionActor").innerHTML=resText;
 				}else{
 					window.alert("所请求的页面有异常");
 					}
 					}
 		}
 		</script>
<script type="text/javascript">
var flag=0;
function hidden()
{
	if(flag==0)
	{	
		document.getElementById("includeTable").style.display="none";
		flag=1;
		document.getElementById("docName").innerText="显示项目信息";
	}
	else
	{
		document.getElementById("includeTable").style.display="";
		flag=0;
		document.getElementById("docName").innerText="隐藏项目信息";
	}
}
</script>
<center>
	<div align="left">
		<a id="docName" style="cursor:hand" onclick="hidden();">隐藏项目信息</a>
	</div>
	<div id="includeTable">
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					&nbsp;项目信息
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					项目名称
					<s:if test="varMap['project_nameRequired']">
						<font color=red>*</font>
					</s:if>
					<s:hidden name="crudObject.project_id" id="project_id"></s:hidden>
				</td>
				<td class="listtableTr22" colspan="3" id="project_name">
					<s:buttonText name="crudObject.project_name" cssStyle="width:96%"
						readonly="!(varMap['project_nameWrite']==null?true:varMap['project_nameWrite'])"
						doubleDisabled="!(varMap['project_name_buttonWrite']==null?true:varMap['project_name_buttonWrite'])"
						doubleCssStyle="cursor:hand" display="varMap['project_nameRead']"
						doubleSrc="/resources/images/s_search.gif"
						doubleOnclick="selectProject();" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					项目编号
				</td>
				<td class="listtableTr22" id="project_code">
					<s:property value="crudObject.project_code" />
					<input type="hidden" name="crudObject.project_code"
						value="<s:property value="crudObject.project_code" />">
				</td>
				<td class="listtableTr11">
					计划形式
				</td>
				<td class="listtableTr22" id="project_shape_name">
					<s:property value="projectStartObject.project_shape_name" />
				</td>
			</tr>

			<tr>
				<td class="listtableTr11">
					计划类别
				</td>
				<td class="listtableTr22" id="plan_type_name">
					<s:property value="projectStartObject.plan_type_name" />
				</td>
				<td class="listtableTr11">
					项目类别
				</td>
				<td class="listtableTr22" id="project_type_name">
					<s:property value="projectStartObject.project_type_name" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					开始时间
				</td>
				<td class="listtableTr22" id="project_starttime">
					<s:property value="projectStartObject.project_starttime" />
				</td>
				<td class="listtableTr11">
					结束时间
				</td>
				<td class="listtableTr22" id="project_endtime">
					<s:property value="projectStartObject.project_endtime" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					费用预算
				</td>
				<td class="listtableTr22" id="project_charge_budget">
					<s:property value="projectStartObject.project_charge_budget" />
				</td>
				<td class="listtableTr11">
					人天预算
				</td>
				<td class="listtableTr22" id="project_person_day_budget">
					<s:property value="projectStartObject.project_person_day_budget" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					审计单位
				</td>
				<td class="listtableTr22" id="project_audit_dept">
					<s:property value="projectStartObject.project_audit_dept_name" />
				</td>
				<td class="listtableTr11">
					项目组长
				</td>
				<td class="listtableTr22" id="project_teamleader">
					<s:property value="projectStartObject.project_teamleader_name" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					项目主审
				</td>
				<td class="listtableTr22" id="project_auditleader">
					<s:property value="projectStartObject.project_auditleader_name" />
				</td>
				<td class="listtableTr11">
					项目组员
				</td>
				<td class="listtableTr22" id="project_team_members">
					<s:property value="projectStartObject.project_team_members_name" />
				</td>
			</tr>

			<tr>
				<td class="listtableTr11">
					被审计单位
				</td>
				<td class="listtableTr22" colspan="3" id="project_audited_dept">
					<s:property value="projectStartObject.project_audited_dept_name" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					审计范围
				</td>
				<td class="listtableTr22" colspan="3" id="project_audit_scope">
					<s:property value="projectStartObject.project_audit_scope" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					项目审理人
				</td>
				<td class="listtableTr22" id="project_cognizance_person">
					<s:property
						value="projectStartObject.project_cognizance_person_name" />
				</td>
				<td class="listtableTr11">
					项目负责人
				</td>
				<td class="listtableTr22" id="project_duty_person">
					<s:property value="projectStartObject.project_duty_person_name" />
				</td>
			</tr>
			<tr>
				<td class="listtableTr11">
					备注
				</td>
				<td class="listtableTr22" colspan="3" id="project_remark">
					<s:property value="projectStartObject.project_remark" />
				</td>
			</tr>
		</table>
		<div id="planFileList">
			<s:property value="planList" escape="false" />
		</div>
	</div>
</center>
