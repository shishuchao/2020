<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<title>中介机构添加、修改、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){	
	var empId;
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
	if(!isView){		
		$("#aySaveBtn").bind('click', function(){
		   	 aud$saveForm('agencyForm', "${contextPath}/ea/agency/saveAgency.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						var agencyId = data.agencyId;
						if(agencyId){
							 $('#agency_agencyId').val(agencyId);
						}
						//是否从项目送审窗口打开
						var winSelect = "${winSelect}"; 
						//alert('winSelect='+winSelect) 
						if(winSelect == true || winSelect == 'true'){
							var frameWin = aud$getTabIframByTabId(parentTabId);
							var dvapWin = frameWin.$('#dvAudProject').get(0).contentWindow;
							var winIframe = dvapWin.$('#aud_openEaInfo').find('iframe');
							winIframe.get(0).contentWindow.tenderList.refresh(); 
						}else{
							aud$getTabIframByTabId(parentTabId).refresh(); 					
						}
						$("#ayCloseBtn").trigger('click');
					 }
				 }
			 });
		});
	}else{
		$("#aySaveBtn").remove();
	}
	$("#ayCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
 });	
 	function showProjectByEmp() {
 		var src="${contextPath}/ea/agency/getProjectDetail.action?agencyId=${param.agencyId}&empId="+empId;
 		document.getElementById('projectDetail').src=src;
 	}
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id="aylayout" class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
		    <a id='aySaveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
 			<a id='ayCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>
	</div>
	<div region='center' border='0'>
		<div style="padding:5px;background:#fafafa;">公司情况</div>
		<form  id='agencyForm' name='agencyForm' method="POST" >
			<input type='hidden' id="agency_agencyId" name="agency.agencyId"  class="noborder editElement clear" value="${agency.agencyId}"/>  
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>中介机构名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='agency_agencyName' name='agency.agencyName' value="${agency.agencyName}"
						title='中介机构名称' class="noborder editElement clear len100 required"/>
						<span id='view_agencyName'
						 class="noborder viewElement clear" style='width:50%;display:inline;'>${agency.agencyName}</span>
					</td>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>所属审计单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='agency_deptName' name='agency.deptName' title="所属审计单位" value="${agency.deptName}"
						 class="noborder editElement clear required" readonly/>
						<input type='hidden' id='agency_deptId' name='agency.deptId' title="所属审计单位ID"  value="${agency.deptId}"
						class="noborder editElement clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
                                  title:'所属审计单位选择',
								  param:{
								  	'rootId':'${user.fdepid}',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
						})"></img>
						<span id='view_deptName' class="noborder viewElement clear" style='width:50%;display:inline;'>${agency.deptName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">公司性质</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='agency_companyProperty' name='agency.companyProperty' title="公司性质" 
						class="noborder editElement clear"value="${agency.companyProperty}" readonly/>
						<input type='hidden' id='agency_propertyCode' name='agency.propertyCode' title='公司性质code'	 
						value="${agency.propertyCode}" readonly class="noborder editElement clear"/>								
						 <img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
									onclick="showSysTree(this,{
		                                  title:'公司性质选择',
		                                  onlyLeafClick:true,
										  param:{
											'plugId':'6006',
											'serverCache':false,
										  	'rootParentId':'0',
						                    'beanName':'CodeName',
						                    'whereHql':'type=\'6006\'',
						                    'treeId'  :'id',
						                    'treeText':'name',
						                    'treeParentId':'pid',
						                    'treeOrder':'code'
						                 }                                  
								})"></img>	
						<span id='view_companyProperty' class="noborder viewElement clear" style='width:50%;display:inline;'>${agency.companyProperty}</span>
					</td>
					<td class="EditHead" style="width:15%;">涉密资质</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='agency_qualification' name='agency.secretQualification'
						class="noborder editElement clear"value="${agency.secretQualification}" readonly/>
						<input type='hidden' id='agency_sqCode' name='agency.sqCode'
						class="noborder editElement clear"value="${agency.sqCode}"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
									onclick="showSysTree(this,{
		                                  title:'涉密资质选择',
		                                  onlyLeafClick:true,
										  param:{
											'plugId':'6010',
											'serverCache':false,
											'rootParentId':'0',
						                    'beanName':'CodeName',
						                    'whereHql':'type=\'6010\'',
						                    'treeId'  :'id',
						                    'treeText':'name',
						                    'treeParentId':'pid',
						                    'treeOrder':'code'
						                 }                                  
								})"></img>
						<span id='view_secretQualification' class="noborder viewElement clear" 
						style='width:50%;display:inline;'>${agency.secretQualification}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">公司专长</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='td_acceptanceCost' 
						name='agency.speciality' class="noborder editElement clear len100" value="${agency.speciality}"/>
						<span id='view_speciality' 
						class="noborder viewElement clear" style='width:50%;display:inline;'>${agency.speciality}</span>
					</td>

					<td class="EditHead" style="width:15%;">公司经理</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='agency_manager' name='agency.manager' value="${agency.manager}"
						class="noborder editElement clear len100" editable="false"/>
						<span id='view_manager' class="noborder viewElement clear" style='width:50%;display:inline;'>${agency.manager}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">座机</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='agency_telephone' name='agency.telephone' value="${agency.telephone}"
						class="noborder editElement clear len20" editable="false"/>
						<span id='view_telephone' class="noborder viewElement clear" 
						style='width:50%;display:inline;'>${agency.telephone}</span>
					</td>

					<td class="EditHead" style="width:15%;">所在地</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='agency_location' name='agency.location' value="${agency.location}"
						class="noborder editElement clear len200" />
						<span id='view_location' class="noborder viewElement clear" 
						style='width:100%; height:50px;overflow:auto;display:inline;'>${agency.location}</span>
					</td>					
				</tr>						
			</table>
		</form>
		<div style="padding-top:10px">
              <div style="padding:5px;background:#fafafa;">人员情况</div>
              <div title='人员情况'  border="0" style='height:300px;overflow:hidden;'>
	           <iframe id='employeenfo' name='employee'
	           	width="100%" height="100%" marginheight="0" src="${contextPath}/ea/agency/showEmployee.action?agencyId=${param.agencyId}&view=true&display=true" marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
		</div>
		<div style="padding-top:10px;width:100%">
              <div style="padding:0px;margin:0px;background:#fafafa;">项目情况</div>
              <div title='项目情况'  border="0" style='height:300px;overflow:hidden;'>
	           <iframe id='projectDetail' name='projectDetail'
	           	width="100%" height="100%" marginheight="0" src="${contextPath}/ea/agency/getProjectDetail.action?agencyId=${param.agencyId}&empId="+empId marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
		</div>		
	</div>		
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>