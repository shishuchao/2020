<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题整改跟踪列表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
     	<script type='text/javascript' src='${contextPath}/scripts/ufaudTextLengthValidator.js'></script>
     	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
     	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
     	<script type="text/javascript">
		// 初始化
		$(function(){
			$('#problemTracking_div').window({   
				width:document.documentElement.clientWidth,
				height:document.documentElement.clientHeight/2,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});	
			$('#mend_result').attr('maxlength',3000);
			$('#no_rectification_reason').attr('maxlength',3000);
			$('#examine_result').attr('maxlength',3000);
			$('#aud_track_result').attr('maxlength',3000);
		});
		</script>
	</head>
	<body>
	<div style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true">
		<div id="problemTracking_div" title="整改结果跟踪记录" style='overflow:hidden;padding:0px;'> 	  		
			<form id='problemTracking_form' name='problemTracking_form' method="POST" style='height:90%;overflow-y:auto;overflow-x:hidden;padding:10px;margin:0px;border:1px solid #cccccc;' >
				<table class="ListTable" cellpadding=1 cellspacing=1 id="tab4" align="center" style="width:98%">
					<tr>
						<td class="EditHead" style="width:25%">审计单位跟踪检查结果
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="problemTracking.examine_result" id="examine_result" cssClass='noborder' title="审计单位跟踪检查结果"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="problemTracking.examine_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改状态评价</td>
						<td class="editTd">
							<select id="f_mend_opinion_code" class="easyui-combobox" name="problemTracking.f_mend_opinion_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${problemTracking.f_mend_opinion_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						    <s:hidden id="f_mend_opinion_name" name="problemTracking.f_mend_opinion_name"></s:hidden>
						</td>
						<td class="EditHead" style="width:15%;"></td>
						<td class="editTd"></td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%;">跟踪检查人</td>
						<td class="editTd" style="width:33%;">
							<span  id="tracker_name">
								<s:property value="problemTracking.tracker_name"/>
							</span>
							<input type="hidden" name="problemTracking.tracker_name" id="tracker_name_temp">
							<input type="hidden" name="problemTracking.tracker_code" id="tracker_code_temp">
						</td>
						<td class="EditHead" style="width:15%;">跟踪检查时间</td>
						<td class="editTd" style="width:33%;">
							<span id="feedback_date">
								<s:property value="problemTracking.feedback_date"/>
							</span>
							<input type="hidden" name="problemTracking.feedback_date" id="feedback_date_temp"/>
						</td>
					</tr>
			    </table>
			    <s:hidden id="fj" name="problemTracking.fj" />
				<input type="hidden" id="formId" name="problemTracking.formId" />
				<table class="ListTable" align="center" style="width:98%">
					<tr>
						<td class="EditHead" style="width:15%;">附件</td>
						<td class="editTd">
							<div id="fj_div" class="easyui-fileUpload" data-options="fileGuid:'0'"></div>
						</td>
					</tr>
				</table>
				<div style='text-align:center;' id='trackBtnDiv' style='padding:15px;'>
					<a  id='saveProblemTracking' class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a  id='closeWin' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>			        
				</div>
			</form>
	    </div>
		<div region="center">
			<table id="trackingList"></table>
		</div>
	</div>
		<div id="viewMiddle" title="定稿问题查看" style="overflow:hidden;padding:0px">
	    	<iframe id="openViewMiddle" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
		<s:hidden id="crudIdStrings" name="crudIdStrings" />
	    <script type="text/javascript">
		    $(function(){
				$('#trackingList').datagrid({
					url : "<%=request.getContextPath()%>/intctet/proManage/trackList.action?querySource=grid&crudIdStrings=${crudIdStrings}&onlyView=true&problemcode=${problemcode}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					//idField:'id',	
					border:false,
					singleSelect:false,
					pageSize:20,
					remoteSort: false,
					<s:if test="${onlyView!='true'}">
					toolbar:[
						<s:if test="${view ne 'view' }">
						{
							id:'edit_track',
							text:'跟踪评价',
							iconCls:'icon-edit',
							handler:function(){
								var rows=$('#trackingList').datagrid('getSelections');
								if(rows.length==1){
									var crudIdStrings = '';
									var id = rows[0].formId;
									var inter_ctrl_problem_id = rows[0].inter_ctrl_problem_id;
									var flag = true;
									$.ajax({
										type: "POST",
										url: "${contextPath}/intctet/proManage/getProblemTrackingById!beforeProblemTracking.action",
										data:{'problemTracking.formId':id},
										async: false,
										success: function(returnValue){
											var json=eval("("+returnValue+")");
											if(json[0]=='in'){
												showMessage1('来自项目内整改问题跟踪记录不能修改!');
												flag = false;
											}/* else if(json[1]=='yes'){
												showMessage1('不是本人记录不能修改!');
												flag = false;
											} */
										}
									});
									if(flag){
										trackUrl = "${contextPath}/intctet/proManage/editAudTrackingLedgerEvaluate.action?inter_ctrl_problem_id="+inter_ctrl_problem_id+"&proId=${proId}&isEdit=isEdit&id="+id;
										window.location.href= trackUrl; 
									}
								}else if(rows.length>1){
									showMessage1('只能选择一个跟踪记录进行编辑');
								}else {
									showMessage1('没有选择跟踪记录');
								}
							}
						},
						</s:if>
						/* {
							id:'view_track',
							text:'查看',
							iconCls:'icon-view',
							handler:function(){
								var rows=$('#trackingList').datagrid('getSelections');
								if(rows.length==1){
									var crudIdStrings = '';
									var id = rows[0].formId;
									$.ajax({
										url:'${contextPath}/proledger/problem/getProblemTrackingById.action',
										data:{'problemTracking.formId':id,'isView':'true'},
										type: "post",
										dataType:'json',
										cache:false,
										success:function(data){
											if(data.type === 'success'){
												var rowData = data.pt;
												for ( var p in rowData ){
													var value = rowData[p] ;
													if (p == 'examine_result'){//标签是< textarea
														$ ('#' + p).text(value ? value : '');
													} else if(p == 'f_mend_opinion_code'){// select控件 */
														/* var count=$("#mend_state_code").get(0).options.length;
														 for(var i=0;i<count;i++){
														 if($("#mend_state_code").get(0).options[i].text == value)
														 {
														 $("#mend_state_code").get(0).options[i].selected = true;
														 break;
														 }
														 } */
														/* $("#"+p+"").combobox("setValue",value);
													}else if(p == 'feedback_date'){// 时间格式化
														//$('input[id='+p+']').datebox('setValue',value && value.length > 10 ? value.substring(0,10) :value);
														$('#feedback_date').val(value); 
													}else if(p == 'tracker_code'){ 
														$('#'+p+'temp').val(value); 
													}else if(p == 'tracker_name'){
														$('#'+p+'temp').val(value); 
														$('#'+p).val(value); 
													}else if(p == 'fj'){// 附件
														$('#fj_div').fileUpload('property', 'fileGuid', value);
														$('#fj_div').fileUpload('setGridBtn',[{id:'add',display:false},{id:'edit',display:false},{id:'delete',display:false},{id:'view',display:true},{id:'download', display:true}]);
														$('#fj_div').fileUpload('reloadFile');
//														$('#fj_div').fileUpload({
//															fileGuid:value,
//															isAdd:false,
//															isEdit:false,
//															isDel:false
//														});
													} else if(p == 'formId'){
														$('#'+p).val(value);
													};
												}
												$("#trackBtnDiv").hide();
												$('#problemTracking_div').window('open');
											}else{
												showMessage2(data.msg);
											}
										},
										error:function(data){
											showMessage2('请求失败！');
										},
										complete:function(data){
											callback();
										}
									});
								}else if(rows.length>1){
									showMessage1('只能选择一个跟踪记录查看');
								}else {
									showMessage1('没有选择跟踪记录');
								}
							}
						} */
						<s:if test="${problemcode != 'problemcode' }">
						,{
							id:'back',
							text:'返回',
							iconCls:'icon-undo',
							handler:function(){back();}
						}
						</s:if>
						<s:else>
						,{
							id:'closeWin',
							text:'关闭',
							iconCls:'icon-cancel',
							handler:function(){
								window.parent.$('#trackList').window('close');
							}
						}
						</s:else>
					],
					</s:if>
					frozenColumns:[[
						{field:'id',width:'50px', checkbox:true, align:'center',sortable:true},
						{field:'defect_code',title:'缺陷编号',halign:'center',align:'left',sortable:true,formatter:function(value,row,rowIndex){
							//return '<a href="${contextPath}/proledger/problem/viewMiddle.action?id='+row.middleLedgerProblem_id+'" target="_blank" >'+row.serial_num+'</a>';
							return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+row.inter_ctrl_problem_id+'\');\">'+value+'</a>';
						}},
						{field:'mend_result',title:'整改进度',width:'320px',sortable:true,halign:'center',align:'left'},
						{field:'mend_date',
							 title:'反馈日期',
							 width:'100px',
							 align:'center',
							 sortable:true,
							 formatter:function(value,row,rowIndex){if(value!=null && value!=''){return value.substring(0,10);}}
						}
					]],
					columns:[[  
						{field:'responsibility',
							title:'是否追责',
							width:'70px',
							sortable:true, 
							align:'center'
						},
						{field:'responsibility_Mode',
							 title:'追责方式',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'mend_state',
							 title:'整改状态',
							 width:'70px', 
							 align:'center', 
							 sortable:true
						},
						{field:'examine_startdate',
							 title:'实际整改开始日期',
							 width:'100px',
							 align:'center',
							 sortable:true,
							 formatter:function(value,row,rowIndex){if(value!=null && value!=''){return value.substring(0,10);}}
						},
						{field:'examine_enddate',
							 title:'实际整改结束日期',
							 width:'100px',
							 align:'center',
							 sortable:true,
							 formatter:function(value,row,rowIndex){if(value!=null && value!=''){return value.substring(0,10);}}
						},
						{field:'no_rectification_reason',
							 title:'到期未整改原因',
							 width:'180px',
							 halign:'center', 
							 align:'left', 
							 sortable:true,
							 formatter:function(value,row,rowIndex){
								 return getOverflowTextContent(value);
							 }
						},
						{field:'feedback_date',
							 title:'跟踪检查日期',
							 width:'100px',
							 align:'center',
							 sortable:true,
							 formatter:function(value,row,rowIndex){if(value!=null && value!=''){return value.substring(0,10);}}
						},
						{field:'tracker_name',
							 title:'跟踪检查人',
							 halign:'center', 
							 align:'left', 
							 sortable:true
						}
					]]   
				}); 
				//关闭
				$('#closeWin').bind('click',function(){
					$('#problemTracking_div').window('close');
				});
				//保存
				$('#saveProblemTracking').bind('click',function(){
					var crudIdStrings = $('#crudIdStrings').val();
					$.ajax({
						dataType:'json',
						url : "${contextPath}/intctet/proManage/saveProblemTracking.action?crudIdStrings="+crudIdStrings+"&flag=1",
						data: $('#problemTracking_form').serialize(),
						type: "POST",
						success: function(data){
							showMessage2('保存成功！');
							$('#problemTracking_div').window('close');
							window.location.href='${contextPath}/intctet/proManage/trackList.action?crudIdStrings=${crudIdStrings}'
						},
						error:function(data){
							showMessage2('请求失败！');
						}
					});
				});
			});
		    function openViewMiddle(id){
				var openViewUrl = "${contextPath}/proledger/problem/viewMiddle.action?id="+id;
	            $('#openViewMiddle').attr("src",openViewUrl);
	            $('#viewMiddle').window('open');
			}
			$('#viewMiddle').window({
	            width:880, 
	            height:380,  
	            modal:true,
	            collapsible:false,
	            maximized:true,
	            minimizable:false,
	            closed:true    
	        });
			function back(){
				var url='<%=request.getContextPath()%>/intctet/proManage/trackProblemList.action';
				window.location.href=url;
			}
			// 清空表单
			function clearFormDiv(){
				var arr = ['responsibility','responsibility_Mode','mend_state_code','examine_enddate','feedback_date','real_examine_creater','mend_result','no_rectification_reason','examine_result','aud_track_result'];
				$.each(arr, function(i, ele){
					$('#'+ele).val('');
				});
				//$("#fjlFileList").html("");
			}
			//上传附件
			function Upload(id,filelist){
				var rnm = $("#"+id).val();
				window.showModalDialog('${pageContext.request.contextPath}/commons/file/welcome.action?table_name=mng_auditing_object&table_guid=other_resource_file&guid='+rnm+'&param='+rnm+'&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
			//删除方法
	 		/*
	 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
	 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
	 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
	 		*/
	        function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true){
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
					function xxx(data){
					  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
					}
				}
			}
	    </script>
	</body>
	<script type="text/javascript">
		function callback(){
			$("#problemTracking_form").find("textarea").each(function(){
				autoTextarea(this);
			});
		}
		$("#problemTracking_form").find("textarea").each(function(){
			autoTextarea(this);
		});
	</script>
</html>
