<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>中介机构人员维护、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){	
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	autoTextarea(isView ?  $('#view_speciality')[0] : $('#emp_speciality')[0]);
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
	if(!isView){		
		$("#empSaveBtn").bind('click', function(){
			 var sexValue = $('#sexCode').combobox('getText');//性别
        	 $("#sex").val(sexValue);
		   	 aud$saveForm('employeeForm', "${contextPath}/ea/agency/saveEmp.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						 var empId = data.empId;
							if(empId){
								 $('#emp_empId').val(empId);
							}						 
						//是否从项目送审窗口打开
						var winSelect = "${winSelect}";
						if(winSelect == true || winSelect == 'true'){
							var frameWin = aud$parentDialogWin();
							var dvapWin = frameWin.$('#dvAudProject').get(0).contentWindow;
							var winIframe = dvapWin.$('#aud_openEaInfo').find('iframe');
							winIframe.get(0).contentWindow.contractInfoList.refresh(); 
						}else{
							aud$parentDialogWin().employeeList.refresh(); 					
						}
						$("#empCloseBtn").trigger('click');
					 }
				 }
			 });
		});
	}else{
		$("#empSaveBtn").remove();
	}
	$("#empCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	$('#emplayout').layout('resize'); 
	
	$('#emp_empName').bind('change', function(){
		$('#emp_floginname').val('');
		$('#view_floginname').text('');
	});
 });
	
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id="ctlayout" class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
		    <a id='empSaveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
 			<a id='empCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>
	</div>
	<div region='center' border='0'>
		<form  id='employeeForm' name='employeeForm' method="POST" >
			<input type='hidden' id="emp_empId" name="emp.empId" value="${emp.empId}" class="noborder editElement clear"/>
			<input type='hidden' id="agencyId" name="emp.agencyId"   value="${param.agencyId}" class="noborder editElement clear"/>
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>姓名</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='emp_empName' name='emp.empName' title='姓名' value="${emp.empName}" 
						class="noborder editElement clear  required"  />
						<input type='hidden' id='emp_floginname' name='emp.floginname' title="系统账号Code"  value="${emp.floginname}"
						class="noborder editElemecrudObjectnt clear required"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
                                  title:'系统账号',
                                  type:'treeAndUser',
                                  defaultDeptId:'${user.fdepid}',
                                  defaultUserId:'${user.floginname}',
                                  // 是否显示复选框
                                  checkbox:false,
                                  singleSelect:true,
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 },
				                 onAfterSure:function(dms,mcs){
				                 	var rows = $(this).datagrid('getChecked');
				                 	var row = rows[0];
				                 	var gender = row['fsex'];
				                 	$('#sexCode').combobox('select', gender == '男' ? '0':'1');
				                 	$('#emp_telephone').val(row['fphone']);
				                 	$('#emp_mobilephone').val(row['fmobile']);
				                 	$('#emp_fname').val(mcs[0]);
				                 	$('#view_floginname').html(dms[0]);
				                 }                                 
						})"></img>
						<span id='view_empName' class="noborder viewElement clear"
						 style='width:50%;display:inline;'>${emp.empName}</span>
					</td>
					<td class="EditHead" style="width:15%;">系统账号</td>
					<td class="editTd" style="width:35%;">
						<span id='view_floginname' class="noborder clear" >${emp.floginname}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">专业</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='emp_major' name='emp.major' title="专业" value="${emp.major}"
						 class="noborder editElement clear"/>
						<input type='hidden' id='emp_majorCode' name='emp.majorCode' title="专业code"  value="${emp.majorCode}"
						class="noborder editElement clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
								  title:'专业',
                               	  onlyLeafClick:true,
								  param:{
									 'serverCache':false,
									 'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'whereHql':'type=\'16\'',
				                    'plugId':'16',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'code'
				                 }                                  
						})"></img>
						<span id='view_major' class="noborder viewElement clear" style='width:50%;display:inline;'>${emp.major}</span>
					</td>
					<td class="EditHead" style="width:15%;">性别</td>
					<td class="editTd" style="width:35%;">					
						<input type='hidden' id='sex' name='emp.sex' value="${emp.sex}" 
						class="noborder editElement clear"/>
						<s:if test="${view != true}">
							<select class="easyui-combobox" id="sexCode" panelHeight='auto' name="emp.sexCode" style="width:150px;" editable="false" >
					   	    	<option value="">&nbsp;</option>
					      	 	<s:iterator value="#@java.util.LinkedHashMap@{0:'男',1:'女'}" id="status">
									<s:if test="${emp.sexCode==key}">
						         		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       		</s:if>
						       		<s:else>
						       	 		<option value="<s:property value="key"/>"><s:property value="value"/></option>						       	 		
									</s:else>
						      	</s:iterator>
					    	</select>
					    </s:if>
					    <s:else>
				    		<span id='view_sex' class="noborder viewElement clear" style='width:50%;display:inline;'>${emp.sex}</span>
						</s:else>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">座机</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='emp_telephone' name='emp.telephone' value="${emp.telephone}" class="noborder editElement clear len20"/>
						<span id='view_telephon' class="noborder viewElement clear"
						 style='width:50%;display:inline;'>${emp.telephone}</span>
					</td>
					<td class="EditHead" style="width:15%;">学历</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='emp_education' name='emp.education' title="学历" value="${emp.education}"
						 class="noborder editElement clear"/>
						<input type='hidden' id='emp_majorCode' name='emp.educationCode' title="学历code"  value="${emp.educationCode}"
						class="noborder editElement clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
								  title:'学历',
                               	  onlyLeafClick:true,
								  param:{
									 'serverCache':false,
									 'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'whereHql':'type=\'17\'',
				                    'plugId':'17',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'code'
				                 }                                  
						})"></img>
						<span id='view_education' class="noborder viewElement clear" style='width:50%;display:inline;'>${emp.education}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">手机</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='emp_mobilephone' name='emp.mobilephone' value="${emp.mobilephone}" class="noborder editElement clear len20"/>
						<span id='view_mobilephone' class="noborder viewElement clear"
						 style='width:50%;display:inline;'>${emp.mobilephone}</span>
					</td>
					<td class="EditHead" style="width:15%;">职业资格</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='emp_proQualification' name='emp.proQualification' title="职业资格" value="${emp.proQualification}"
						 class="noborder editElement clear"/>
						<input type='hidden' id='emp_pqCode' name='emp.pqCode' title="职业资格code"  value="${emp.pqCode}"
						class="noborder editElement clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
								  title:'职业资格',
                               	  onlyLeafClick:true,
								  param:{
									'serverCache':false,
									'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'whereHql':'type=\'201\'',
				                    'plugId':'201',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'code'
				                 }                                  
						})"></img>
						<span id='view_proQualification' class="noborder viewElement clear" style='width:50%;display:inline;'>${emp.proQualification}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">擅长</td>
					<td class="editTd" colspan='3'>
						<textarea  id='emp_speciality' name='emp.speciality' class="noborder editElement clear len2000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${emp.speciality}</textarea>
						<textarea id='view_speciality' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${emp.speciality}</textarea>					
					</td>
				</tr>											
			</table>
		</form>
    </div>			
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>