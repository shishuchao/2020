<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<s:head theme="ajax" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>
	<title>被审计单位资料模板编辑</title>
	
	<script type="text/javascript">
		var tip = "${tip}";
		if(tip == "1"){
			showMessage1("保存成功！");
		}
		function saveval(){
			var option = '${checkOption}';
			var projtype = document.getElementsByName("auditAccessoryTemp.pro_type")[0].value;
			var typename = document.getElementsByName("auditAccessoryTemp.pro_type_name")[0].value;
		    var programname=document.getElementsByName("auditAccessoryTemp.templatename")[0];
		    
		    var tId = document.getElementsByName("auditAccessoryTemp.id")[0].value;
		    if(programname){
		        if(programname.value==""){
		            showMessage1("请填写模板的名称!");
		            return false;
		        }
		        if(programname.value.length>50){
		            showMessage1("您输入的模板名称的长度不能超过50个字!");
		            return false;
		        }
		    }
		    if(projtype==""){
				showMessage1("请填写项目类别!");
				return false;
			}
		    if(typename.length>256){
	            showMessage1("您选择的类别名称的长度不能超过256个字!");
	            return false;
	        }
		
		    var retmessage="true";
			$.ajax({
				type : "post",
				url : "${contextPath}/auditAccessoryList/checkTempType.action",
				cache : false,
				async : false,
				data : {'pro_type':projtype,'pro_type_name':typename,'auditUuid':tId,'checkOption':option},
				success : function(ret) {
					if (ret != 'ok') {
						showMessage1("已经存在项目类别为【"+ret+"】的被审计单位资料模板，请重新选择项目类别！");
						retmessage='false';
					}else{
						submitF();
					} 
					return true;
				}
			});
				
			
			}
		
			function UploadModel(uuid) {
				/*var idName = "accelerysModel";
			    var contextPath = '${contextPath}';
			    var table_name = 'AUDIT_TEMPLATE_LIST';
			    var table_guid = 'templateList';
				var deletePermission = 'true';
				var isEdit = "false";
				var width = 650;
				var height = 450;
				uploadFile(contextPath,table_name,table_guid,uuid,deletePermission,isEdit,idName,'模板',width,height);
				var tId = document.getElementsByName("auditAccessoryTemp.id")[0].value;
				window.location = "${contextPath}/auditAccessoryList/auditAccessoryTempList.action?&auditUuid="+tId;*/
				$('#fileUploadId').val(uuid);
				$('#filelist').fileUpload('property','fileGuid',uuid);
				
				
	    		if(parseInt(ieVersion) < 10){
	    			$('#aaUploadWin').dialog('open');
	    		}else{
	    			$("#filebtn .icon-addFile").trigger("click");
	    		}
				
			}
			function delTemp(tempFileId,tempId){
				$.messager.confirm('提示信息','您确定要删除该模板么？',function(isDel){
					if(isDel){
						window.location = "${contextPath}/auditAccessoryList/deltemplateFile.action?tempFileId="+tempFileId+"&tempId="+tempId;
						showMessage1('删除成功！');
					}
				});
			}
			
			function editTempList(tempId){
				var url = "${contextPath}/auditAccessoryList/addAuditAccessoryTemp.action?checkOption=edit&tempId="+tempId;
				var width = $(window).width()*0.65;
				showWinIf('commonPage',url,'修改',width,300);
				//window.location = "${contextPath}/auditAccessoryList/addAuditAccessoryTemp.action?checkOption=edit&tempId="+tempId;
			}
			
			function addTempList(tempId){
				var url = "${contextPath}/auditAccessoryList/addAuditAccessoryTemp.action?checkOption=add&auditAccessoryTempId="+tempId;
				var width = $(window).width()*0.65
				showWinIf('commonPage',url,'新增',width,300);
				//window.location = "${contextPath}/auditAccessoryList/addAuditAccessoryTemp.action?checkOption=edit&tempId="+tempId;
			}
			
			function delTempList(tempId){
				$.messager.confirm('提示信息','您确定要删除资料清单么？',function(isDel){
					if(isDel){
						window.location = "${contextPath}/auditAccessoryList/delAuditAccessoryTempList.action?&tempId="+tempId;
						showMessage1('删除成功！');
					}
				});
			}
			function submitF(){
				$.messager.confirm('提示信息','确定保存吗?',function(isSave){
					if(isSave){
						document.getElementById('accessoryTemplateFrom').submit();
						showMessage1('保存成功！');
					}
				});
               
			}


			function getItem(url,title,width,height){
				var proTypeValue = document.getElementsByName('auditAccessoryTemp.pro_type')[0].value;
				$('#tempProType').val(proTypeValue);
				$('#item_ifr').attr('src',url);
				openWin('subwindow',title,width,height);
			}
			function saveF(){
				var ayy = $('#item_ifr')[0].contentWindow.saveF();
				document.all('auditAccessoryTemp.pro_type').value=ayy[0];
        		document.all('auditAccessoryTemp.pro_type_name').value=ayy[1];
        		closeWin();
			}
			function cleanF(){
				document.all('auditAccessoryTemp.pro_type').value='';
        		document.all('auditAccessoryTemp.pro_type_name').value='';
        		closeWin();
			}
			function closeWin(){
				$('#subwindow').window('close');
			}
			function selectAllF(boo){
				$('#item_ifr')[0].contentWindow.selectAllF(boo); 
			}
		</script>
</head>
<body class="easyui-layout" style="margin: 0;padding: 0;overflow:hidden;">
		<div region="center" border='0' >
		<div>
		<table cellpadding=0 cellspacing=1 border=0 class="ListTable" width="100%" align="center">
		    <tr class="listtablehead">
		        <td colspan="5" align="left" class="topTd">
		            <div style="display: inline;width:80%;">
						<s:if test="${view == 'edit'}">编辑被审计单位资料模板</s:if>
						<s:else>查看被审计单位资料模板</s:else>
						<s:if test="${checkOption == 'copy'}">复制被审计单位资料模板</s:if>
		            </div>
		        </td>
		    </tr>
		</table>
		<s:form id="accessoryTemplateFrom" action="${action}" namespace="/auditAccessoryList" onsubmit="return saveval()" method="post">
			<s:hidden name="auditAccessoryTemp.id" />
			<table cellpadding=0 cellspacing=1 border=0 class="ListTable" width="100%" align="center" style="margin-bottom:20px;" id="templateInfo">
	            <s:if test="${view == 'edit'}">
					<tr >
						<td align="left" class="EditHead" style="width:10%"><font color="red">*</font>&nbsp;模板名称</td>
	
			  			<td align="left" class="editTd" style="width:40%">
			   				<s:textfield name="auditAccessoryTemp.templatename" cssStyle="width:160;" title="工作方案模板名称" maxlength="255" cssClass="noborder"/>
			  			</td>
	
			  			<td align="left" class="EditHead"><font color="red">*</font>&nbsp;适用项目类别</td>
	
			    		<td align="left" class="editTd">
			    		<s:buttonText name="auditAccessoryTemp.pro_type_name" cssClass="noborder"
								hiddenName="auditAccessoryTemp.pro_type" cssStyle="width:160px;"
								doubleOnclick="getItem('/pages/basic/code_name_tree.jsp?type=add','请选择适用项目类别',500,400)"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" />
							<input type="hidden" id="tempProType" value="">
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">创建人</td>
						<td align="left" class="editTd">
							<s:textfield name="auditAccessoryTemp.createName" readonly="true" cssStyle="width:160px;" title="创建人" maxlength="20" cssClass="noborder"/>
						</td>
	 					<td align="left" class="EditHead">创建时间</td>
						<td align="left" class="editTd">
							<s:textfield name="auditAccessoryTemp.createTime" readonly="true" cssStyle="width:160px;" title="创建日期" maxlength="255" cssClass="easyui-datebox noborder"/>
						</td>
					</tr>
				</s:if>
				<s:else>
					<tr >
						<td align="left" class="EditHead" style="width:10%">模板名称</td>
			  			<td align="left" class="editTd" style="width:40%">
			  				<s:label name="auditAccessoryTemp.templatename" />
			  			</td>
			  			<td align="left" class="EditHead" nowrap>适用项目类别</td>
			    		<td align="left" class="editTd" >
			    			<s:label name="auditAccessoryTemp.pro_type_name" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">创建人</td>
						<td align="left" class="editTd">
							<s:label name="auditAccessoryTemp.createName" />
						</td>
	 					<td align="left" class="EditHead">创建时间</td>
						<td align="left" class="editTd">
							<s:label name="auditAccessoryTemp.createTime" />
						</td>
					</tr>
				</s:else>
				<tr>
					<td colspan="10" class="editTd" style="text-align:right;">
						<s:if test="${view == 'edit'}">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveval()">保存模板</a>
							<s:if test="${auditAccessoryTemp.id != null && checkOption != 'copy'}">
				        	    <a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addTempList('${auditAccessoryTemp.id}')">新增资料清单</a>
				        	</s:if>
				        </s:if>
					   	<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:window.location='${contextPath}/auditAccessoryList/auditAccessoryTemplate.action'">返回模板列表</a>
					</td>
				</tr>
			</table>
		</div>
	    <div style="margin: 0;padding: 0;overflow:hidden;padding:15px;" >
			<s:if test="${auditAccessoryTemp.id != null}">
				<table id="auditAccessoryTempTable" cellpadding=0 cellspacing=1 border=0 width="100%" align="center" ></table>
				<div id='aaUploadWin' style='padding:10px;overflow:hidden;' >
					<div id="filebtn" align='center'></div>
					<div id="filelist"></div>
					<input id="fileUploadId" type="hidden" value="">
				</div>
			</s:if>
		</div>
		</s:form>
	</div>
	<div id="commonPage"></div>
	 <div id="subwindow" class="easyui-window" title="适用项目类别" style="overflow:hidden;">
			<div class="easyui-layout" fit="true" style="overflow:hidden;">
				<div region="center" border="0" style="padding:5px; overflow:hidden;">
					<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" style="overflow:hidden;"></iframe>
				</div>
				<div region="south" border="0" style="text-align:right;padding:5px 0;">
					<div style="display: inline;" align="right">
					    <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="selectAllF(true)">全选</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="selectAllF(false)">全不选</a>
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
						<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">取消</a>
				    </div>
				</div>
			</div>
		</div>
	<script type="text/javascript">
		var ieVersion = $.browser.version;
	    $(function(){

			if(parseInt(ieVersion) < 10){
				// 文件上传窗口
				$('#aaUploadWin').dialog({
					'title':'文件上传',
					'closed': true,
					'width' : 200,
					'height': 100,
					'modal' : true   
				});
				
			}else{
				$('#aaUploadWin').css({
					'height':'0px',
					'display':'none'
				});
			}
	    	
	    	
	    	
	    	$('#subwindow').window({
				title: 'xxxx',
				width: 800,
				height:800,
				modal:true,
				shadow: true,
				closed:true,
				collapsible: false,
				maximizable: true,
				minimizable: false,
				onClose:function(){
					$('#item_ifr').attr('src','');
				}
			});
			showWin('commonPage','公用弹窗');
			
			$('#filelist').fileUpload({
				fileGuid:'-1',
				uploadFace:1,
				isDel:false,
				isEdit:false,
				triggerId:'filebtn',
				echoType:2,
				callbackGridHeight:1,
				onFileSubmitSuccess:function(data,options){
					$('#auditAccessoryTempTable').datagrid('reload');
					if(parseInt(ieVersion) < 10){
						// 文件上传窗口
						$('#aaUploadWin').dialog('close');								
					}
				}
			});
			
			$('#auditAccessoryTempTable').datagrid({
				url : "<%=request.getContextPath()%>/auditAccessoryList/queryAccessoryTempListFile.action?auditUuid=${auditUuid}",
				method:'post',
				rownumbers:true,
				pagination:false,
				striped:true,
				autoRowHeight:true,
				//fit: true,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[  
					{field:'auditProgram',
							title:'资料清单',
							width:200,
							halign:"center",
							align:'left', 
							sortable:true
					},
					{field:'needDo',
						title:'是否必传',
						halign:"center",
						width:50,
						sortable:true, 
						align:'center'
					},
					{field:'templateList',
						 title:'模板',
						 halign:"center",
						 width:250, 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
					        if(value != null){
	                           var templateList = value;
	                           var res='';
	                           $.each(templateList,function(i,f){
	                               res += '<a title="[上传人]'+f.uploader_name+'\n[上传时间]'+f.fileTime+'\n[最后修改人]'+f.remark_name+'\n[修改时间]'+f.fileEditTime+'"' 
	                                   +'href=\"${contextPath}/commons/file/downloadFile.action?fileId='+f.fileId+'\">'+f.fileName+'</a>&nbsp;&nbsp;&nbsp;&nbsp;';
	                               <s:if test="${view == 'edit' && checkOption != 'copy'}">
	                                   res += '<a href=\"javascript:void(0)\" onclick=\"delTemp(\''+f.fileId+'\',\''+rowData.aaid+'\');\">删除</a><br>';
	                               </s:if>
	                                <s:else>
	                               		res += '</br>';
	                               </s:else>
	                           });
	                           return res;
					        }
						 }
					}
					<s:if test="${view == 'edit'}">
					,
					{field:'id',
						 title:'操作',
						 width:200, 
						 halign:"center",
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
						 	 var param = [row.aaid];
						 	 var btn2 = "修改,editTempList,"+param.join(',')+"-btnrule-删除,delTempList,"+param.join(',')
							           +"-btnrule-上传模板,UploadModel,"+param.join(',');
							 return ganerateBtn(btn2);
						 }
					}
					</s:if>
				]]
			});
	    });
	</script>
</body>
</html>