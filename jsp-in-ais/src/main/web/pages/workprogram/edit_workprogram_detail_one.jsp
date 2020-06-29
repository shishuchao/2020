<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<jsp:directive.page import="ais.workprogram.util.WorkprogramConstant" />
<jsp:directive.page import="ais.interCtrlEvaluation.util.IntctetConstant" />
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>工作方案明细编辑表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script language="javascript">
//	function $$(nodename){
//	    return document.getElementsByName(nodename)[0];
//	}
	
//	function $$(nodeid){
//	    return document.getElementById(nodeid);
//	}
	/*
	 *上传附件
	*/
	function Upload(id,filelist){
	    var guid=$(id).value;
	    var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	    window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workprogram_detail&table_guid=template_id&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	    //parent.setAutoHeight();
	}
	/*
	* 删除附件
	*/
	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		jQuery.messager.confirm('确认','确定删除吗？',function(flag){
			if(flag){
				DWREngine.setAsync(false);DWRActionUtil.execute(
	            { namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
	            {'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
	            xxx);
		        function xxx(data){
		            document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
		        } 
			}
		});
	}
	
	function saveWorkProgramDetail(){
	
	    
	    var option = "${param.option}";
	    var rowIndex = "${param.rowIndex}";
	    var wpid = document.getElementById("workprogramid").value;
	    var wpdid = document.getElementById("workprogramdetailid").value;
	    var wpdname = document.getElementById("workprogramdetailname").value;
	    var documentType = document.getElementsByName("workprogramdetail.documentType")[0].value;
	    if(wpdname==""){
	        showMessage1("请输入流程节点名称！");
	        return false;
	    }
	    if(wpdname.length>49){
	        showMessage1("您输入的字数不能超过50，请删减！");
	        return false;
	    }
	    //var needdo=$("workprogramdetail.needdo").options[$("workprogramdetail.needdo").selectedIndex].value;
	    var needdo = document.getElementsByName("workprogramdetail.needdo")[0].value;
	    var ledgernode = "";
	    var modulename = document.getElementsByName("modulename");
	    for(var i=0;i<modulename.length;i++){
	        if(modulename[i].checked){
	            ledgernode=ledgernode+modulename[i].value+",";
	        }
	    }
	    if(ledgernode!=""){
	        ledgernode=ledgernode.substring(0,ledgernode.length-1);
	    }
	    var templateid = '${workprogramdetail.templateid}';
	    var stagecode = '${workprogramdetail.stagecode}';
	    var stagename = '${workprogramdetail.stagename}';
	    var mess="";
	    var filename = new Array();
	    var fileid = new Array();
	    var retmessage="";
	    DWREngine.setAsync(false);
	    DWREngine.setAsync(false);DWRActionUtil.execute(
	    { namespace:'/workprogram', action:'saveWorkProgramDetail', executeResult:'false' }, 
	    {'wpid':wpid,'wpdid':wpdid,'wpd_name':wpdname,'wpd_needdo':needdo,'wpd_ledgernode':ledgernode,'wpd_stagecode':stagecode,'wpd_stagename':stagename,'documentType':documentType,'wpd_templateid':templateid},
	    xxx);
	    function xxx(data){
	    	filename = data['fileName'].split(",");
	        fileid = data['fileId'].split(",");
	        retmessage=data['ret_message'];
	    } 
	    
	    if(retmessage="ok"){
	        window.location.href = '${contextPath}/workprogram/editWorkProgramDetail.action?options=edit&wpid='+wpid+'&isIntctet=${isIntctet}';
	        showMessage1("保存成功!");
	    	    
	    }else{
	        showMessage1("保存失败！");
	        return false;
	    }
	   
	   
	}
	function setmodulevalue(){
	    var ledgernode = '${workprogramdetail.ledgernode}';
	    var modulename = document.getElementsByName("modulename");
	    var temp = new Array();
	    if(ledgernode!=""){
	        temp = ledgernode.split(",");
	    }
		for(var i=0;i<modulename.length;i++){
	        for(var j=0;j<temp.length;j++){
	            if(modulename[i].value==temp[j]){
	            	modulename[i].checked=true;
	                break;
	            }
	        }
	    }
	}
	$(document).ready(function(){
		$('#workprogramdetail_file').fileUpload('reloadFile');
	});
</script>
	</head>
	<body onload="setmodulevalue()" style="overflow-y:auto;">
		<table cellpadding=0 cellspacing=1 border=0 
		    class="ListTable" width="100%" align="center">
		    <tr >
		        <td colspan="5" align="left" class="topTd">
		            <div style="display: inline;width:80%;">
		             <s:if test='#parameters.options[0]=="add"'>
		            	添加流程节点
		            </s:if>
		            <s:else>
		            	 编辑流程节点
		            </s:else>
		            </div>
		        </td>
		    </tr>
		</table>
		<s:form id="workprogramDetailForm" action="saveWorkprogramDetail" namespace="/workprogram">
			<s:hidden name="workprogramdetail.workprogramdetailid" id="workprogramdetailid" value="${workprogramdetail.workprogramdetailid}" />
			<s:hidden name="workprogramdetail.workprogramid" id="workprogramid" value="${workprogramdetail.workprogramid}" />

			<s:hidden name="workprogramdetail.stagecode" value="${workprogramdetail.stagecode}" />
			<s:hidden name="workprogramdetail.stagename" value="${workprogramdetail.stagename}" />
			<table id="workprogramdetailTable" class="ListTable" align="center">
				<tr>
					<td align="left" class="EditHead">
						流程节点：
						<font color="red">*</font>
					</td>
					<td align="left" class="editTd" >
						<s:textfield id="workprogramdetailname" name="workprogramdetail.workprogramdetailname" cssStyle="width:90%" maxlength="50" cssClass="noborder"/>
					</td>
					<td align="left" class="EditHead">
						是否必做：
					</td>
					<td class="editTd" >
					   <select id="needdo" editable="false" class="easyui-combobox" name="workprogramdetail.needdo" style="width:160px;" panelHeight='auto' >
					       <option value="">&nbsp;</option>
					       <option value="是" <s:if test="${workprogramdetail.needdo == '是'}">selected="selected"</s:if>>是</option>
					       <option value="否" <s:if test="${workprogramdetail.needdo == '否'}">selected="selected"</s:if>>否</option>
					    </select>
					</td>
					<td align="left" class="EditHead">
						文件类型：
					</td>
					<td align="left" class="editTd">
						<select class="easyui-combobox" editable="false" name="workprogramdetail.documentType" style="width:150px;"  data-options="panelHeight:'auto'">
					       <option value="">&nbsp;</option>
					       <s:iterator value="@ais.framework.util.NavigationUtil@getArchivedDocumentType()" id="entry">
					       		<s:if test="${workprogramdetail.documentType==entry}">
					       			<option selected="selected" value="${workprogramdetail.documentType}">${entry }</option>
					       		</s:if>
					       		<s:else>
					       			<option value="${entry }">${entry }</option>
					       		</s:else>
					       </s:iterator>
					    </select>
					</td>
				</tr>
				<tr>
					<td align="left" class="EditHead">
						对应系统功能：
					</td>
					<td align="left" class="editTd" colspan="5">
						<s:if test="${isIntctet != 'Y'}">
							<table border="0">
							<tr>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.PLANMODULE%>">
									计划附件
									</input>
								</td>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.WORKSUMMARY%>">
									实施方案
									</input>
								</td>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.LEDGER%>">
									审计工作底稿及附件
									</input>
								</td>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.AUDIT_PROBLEM%>">
									审计问题
									</input>
								</td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.DECIDE_PROBLEM%>">
									定稿问题
									</input>
								</td>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.LEDGERCUSTOMKEYVALUE%>">
									项目台账
									</input>
								</td>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.AUDIT_ADVICENOTE%>">
									审计通知书
									</input>
								</td>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.AUDIT_DATUM%>">
									被审计单位资料
									</input>
								</td>
							</tr>
							<tr>
							</tr>
							<s:if test="modelTypeList.size() != 0">
								<tr>
									<s:iterator value="modelTypeList" status="st">
										<td>
										<input type="checkbox" name="modulename" value="<s:property value='note'/>">
											<s:property value="name"/>
										</input>
										</td>
									</s:iterator>
								</tr>
							</s:if>
							<s:if test="modelTypeList01.size() != 0">
								<tr>
									<s:iterator value="modelTypeList01" status="st">
										<td>
										<input type="checkbox" name="modulename" value="<s:property value='note'/>">
											<s:property value="name"/>
										</input>
										</td>
									</s:iterator>
								</tr>
							</s:if>
							<tr>
								<td>
									<input type="checkbox" name="modulename" value="<%=WorkprogramConstant.SIGNEDDIGAO%>">
									已签字工作底稿
									</input>
								</td>
							</tr>
						</table>
						</s:if>
						<s:else>
							<table  border="0">
								<tr>
									<td>
										<input type="checkbox" name="modulename" value="<%=IntctetConstant.EVALUATIONPROJECT%>">
											评价方案
										</input>
									</td>
									<td>
										<input type="checkbox" name="modulename" value="<%=IntctetConstant.EVALUATIONMANU%>">
											评价底稿
										</input>
									</td>
									<td>
										<input type="checkbox" name="modulename" value="<%=IntctetConstant.GROUPSUMMARY%>">
											分组小结
										</input>
									</td>
									<td>
										<input type="checkbox" name="modulename" value="<%=IntctetConstant.EVALUATIONREPORT%>">
											评价报告
										</input>
									</td>
									<td>
										<input type="checkbox" name="modulename" value="<%=IntctetConstant.FINALDETERMINATION%>">
											缺陷最终认定表
										</input>
									</td>
								</tr>
							</table>
						</s:else>
						<s:hidden name="workprogramdetail.ledgernode" value="${workprogramdetail.ledgernode}" />
					</td>
				</tr>
<!--				<tr>
					<td align="left" class="EditHead">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="Upload('workprogramdetail.templateid',accelerys)">上传模板</a>&nbsp;&nbsp;
					</td>

					<td class="editTd" colspan="5">
						<s:hidden name="workprogramdetail.templateid" value="${workprogramdetail.templateid}" />
						<div id="accelerys" align="center">
							<s:property escape="false" value="accessoryList" />
						</div>
					</td>
				</tr> -->
				<tr>
					<td class="EditHead">
						<div id="templateBtn"></div>
						<s:hidden id="w_file" name="workprogramdetail.templateid" />
					</td>
					<td class="editTd" colspan="10" >
						<div id="workprogramdetail_file" data-options="fileGuid:'${workprogramdetail.templateid}',echoType:2,uploadFace:1,triggerId:'templateBtn'" class="easyui-fileUpload"></div>
					</td>
				</tr>
			</table>
		</s:form>
		<div align="right">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveWorkProgramDetail()">保存</a>&nbsp;&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.history.go(-1)">返回</a>&nbsp;&nbsp;
<!--  		    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="self.close()">关闭</a>  -->
		</div>
	</body>
</html>