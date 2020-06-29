<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
	<title>基本信息</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript">
	var editFlag1 = undefined;
	/*DWR2删除附件回传附件列表---LIHAIFENG 2007-12-20*/
	function deleteFile(fileId,guid,isDelete,isEdit,appType){
		$.messager.confirm('确认','确认删除吗?',function(boolFlag){
			if (boolFlag){    
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
				xxx);
				function xxx(data){
				  	document.getElementById("accelerys").innerHTML=data['accessoryList'];
				} 
			}    
		});
	}
	function openDialog(){
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=base_info&table_guid=uuid&guid=${baseInfo.uuid}&&param='+rnm+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	function toEdit(){
		window.location.href="<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!edit.action?baseInfo.orgId=${baseInfo.orgId}&status=1";
	}
	
	function exportExcel(){
		myForm.action="${pageContext.request.contextPath}/assist/baseInfo/exportBaseInfo.action";
		myForm.submit();
	}
	function submitF(){
		// 编制人数
		var totalNo = document.getElementsByName('baseInfo.totalNo')[0].value;
		if('' == totalNo){
			showMessage1('编制人数不能为空！');
			return false;
		}else{
			var re = /^[0-9]+.?[0-9]*$/;
			if (!re.test(totalNo)){
				showMessage1("编制人数必须为数字！");
				return false;
			}
		}

		// 内审岗位资格人数
		var innerAuthNo = document.getElementsByName('baseInfo.innerAuthNo')[0].value;
		if (innerAuthNo) {
			var re = /^[0-9]+.?[0-9]*$/;
			if (!re.test(innerAuthNo)){
				showMessage1("内审岗位资格人数必须为数字！");
				return false;
			}
		}

		// 联系人
		var contactObj = document.getElementById("contact");
		var contactIndex = contactObj.selectedIndex;
		var contactValue = contactObj.options[contactIndex].text;
		$("#baseInfo_contactName").val(contactValue);

		$.ajax({
			type:"post",
			data:$('#myForm').serialize(),
			url:"${contextPath}/assist/baseInfo/baseInfoAction!save.action",
			async:false,
			success:function(){
		    	showMessage1('保存成功！');
			}
		});
		//myForm.submit();
	}
	function showme(){
		document.body.style.display="";
	}
	
	$(function(){
		$('#test').tabs({ 
	        border:false, 
	        onSelect:function(title,index){ 
				if(index == 1){
					var src = $('#prjInfo').attr('src');
					if(src == ''){
						$('#prjInfo').attr('src','${contextPath}/assist/baseInfo/baseInfoAction!prjinfo.action?deptInfo.orgId=${baseInfo.orgId}&status=2');
					}
				}
				if(index == 2){
					var src = $('#prjhisinfo').attr('src');
					if(src == ''){
						$('#prjhisinfo').attr('src','${contextPath}/assist/baseInfo/baseInfoAction!prjhisinfo.action?deptInfo.orgId=${baseInfo.orgId}&status=2');
					}
				}
	        } 
	    });

		var bodyW = $('body').width();
		var g2 = new createQDatagrid({
			// 表格dom对象，必填
			gridObject:$('#jcTable')[0],
			// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
			boName:'BonusPenalty',
			// 对象主键,删除数据时使用-默认为“id”；必填
			pkName:'id',
		    whereSql: 'pId=\'${baseInfo.id}\'',
			order:'asc',
			sort:'id',
			winWidth:800,
			winHeight:250,
			gridJson:{    
				checkOnSelect:true,
				selectOnCheck:false,
				singleSelect:false,
				<s:if test="${status==1}">
				toolbar: [
					{
						text: '新增',
						iconCls: 'icon-add',
						handler: function () {
							$("#jcTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
								index: 0, // 行数从0开始计算
								row: {
									id: '',
									pId: '${baseInfo.id}',
									prizeName: '',
									prizeYear: '',
									remark: ''
								}
							});
							var rowNumbers = $('#jcDiv .datagrid-cell-rownumber');
							for (i = 0; i < rowNumbers.length; i++) {
								$(rowNumbers[i]).html("");
								$(rowNumbers[i]).html(i + 1);
							}
						}
					},
					'-',
					{
						text: '保存',
						iconCls: 'icon-save',
						handler: function () {
							$("#jcTable").datagrid('endEdit', editFlag1);

							if (!checkTemplateStatus()) {
								return;
							}
							//使用JSON序列化datarow对象，发送到后台。
							var rows = $("#jcTable").datagrid('getChanges');
							var rowstr = JSON.stringify(rows);
							$.ajax({
								url: '${contextPath}/mng/employee/saveJC.action',
								async: false,
								type: 'POST',
								data: {'rowstr': rowstr},
								success: function (data) {
									if (data == '1') {
										$("#jcTable").datagrid('reload');
										showMessage1('保存成功！');
									}
								}
							});
						}
					}
				],
				</s:if>
				columns:[[
					{field: 'id', title: '选择', checkbox: true, align: 'center', show: 'false', hidden: 'true'},
					{
						field: 'prizeName', title: '获奖名称', width: bodyW * 0.3 + 'px', align: 'center', sortable: true, show: 'true', oper: 'like',
						editor: {
							type: 'text'
						}
					},
					{
						field: 'prizeYear', title: '获奖年度', width: bodyW * 0.2 + 'px', align: 'center', sortable: true, show: 'true', oper: 'like',
						editor: {type: 'numberbox', options: {precision: 0, min: 1900}}
					},
					{
						field: 'remark', title: '备注', width: bodyW * 0.3 + 'px', align: 'left', sortable: true, show: 'true', oper: 'eq',
						editor: {
							type: 'text'
						}
					}
				]],
				<s:if test="${status==1}">
				onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
					editFlag1 = undefined;//重置
				}, 
				onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
					if (editFlag1 != undefined) {
						$("#jcTable").datagrid('endEdit', editFlag1);//结束编辑，传入之前编辑的行
					}
					if (editFlag1 == undefined) {
						$("#jcTable").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
						editFlag1 = rowIndex;
					}
				}
				</s:if>
			}
		});	
		g2.batchSetBtn([
			<s:if test="${status==1}">
			{'index':1, 'display':true},
			{'index':2, 'display':true},
			{'index':3, 'display':true},
			</s:if>
			<s:else>
			{'index':1, 'display':false},
			{'index':2, 'display':false},
			{'index':3, 'display':false},
			</s:else>
			{'index':4, 'display':false},
			{'index':5, 'display':false},
			{'index':6, 'display':false},
			{'index':7, 'display':false},
			{'index':8, 'display':false}
		]);
    });

	function checkTemplateStatus() {
		var rows = $('#jcTable').datagrid("getRows");

		if (rows && rows.length) {
			var rlen = rows.length;
			for (var i = 0; i < rlen; i++) {
				var row = rows[i];

				if (!row.prizeName || row.prizeName.replace(/\s+/g, "").length == 0) {
					editFlag1 = i;
					$('#jcTable').datagrid('selectRow', editFlag1).datagrid('beginEdit', editFlag1);
					showMessage1("第"+(i+1)+"行[获奖名称]不能为空");
					return false;
				}
				if (!row.prizeYear || row.prizeYear.replace(/\s+/g, "").length == 0) {
					editFlag1 = i;
					$('#jcTable').datagrid('selectRow', editFlag1).datagrid('beginEdit', editFlag1);
					showMessage1("第"+(i+1)+"行[获奖年度]不能为空");
					return false;
				}
			}
		}

		return true;
	}

	function contactEmali(){
		var obj = document.getElementById("contact");
		var index = obj.selectedIndex; // 选中索引
		var value = obj.options[index].value; // 选中值
		$.ajax({
			type:"post",
			data:{'peopleCode':value},
			url:"${contextPath}/assist/baseInfo/getContactEmail.action",
			async:false,
			success:function(data){
		    	if(data != "0"){
		    		document.getElementById('email2').value=data;
		    	}
			}
		});
    }
	</script>
	</head>
	<body onload="setOnchange2sedSelect();">
		<div class='easyui-tabs' fit='true' border="0" style="overflow:hidden;height:100%" id="test">
			<div id='one' border='0' title='基本信息' fit='true'style="overflow-x:hidden;height:100%; width:100%">
			<div class='easyui-layout' border='0' fit='true'>
			<div  region="center" border='0'>
				<s:form action="baseInfoAction!save" namespace="/assist/baseInfo" id="myForm" cssStyle='margin:0px;padding:0px;' onsubmit="return chkBaseInfo()" method="post">
					<div style="width: 98.3%;position:fixed;top:30px;" align="center">
						<table class="ListTable" align="center" style='width: 100%; padding: 0; margin: 0;'>
							<tr class="EditHead">
								<td>
									<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'"  onclick="planName()">人员构成</a>&nbsp;
									<s:if test="${status==1}">
										<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="submitF()">保存</a>&nbsp;
									</s:if>
									<a class="easyui-linkbutton" data-options="iconCls:'icon-export'"  onclick="exportExcel()">导出本级及下级</a>
									&nbsp;
								</td>
							</tr>
						</table>
					</div>
					<s:hidden name="baseInfo.orgId"/>
					<s:hidden name="baseInfo.uuid"/>
					<s:hidden name="baseInfo.id"/>
					<s:hidden name="status" />
					<table id='tab1' cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="margin-top: 35px">
						<tr>
							<td class="EditHead" style="width: 35%" >
								部门状态
							</td>
							<td class="editTd" style='width: 35%'>
								<input type="text" name="baseInfo.deptState" disabled="true" style="border:0px;background-color:#fff;color:#000" value="${baseInfo.deptState}" >
							</td>
							<td class="EditHead" style="width: 15%">
								本级机构编码
							</td>
							<td class="editTd" style='width: 35%'>
								<input type="text" name="baseInfo.deptState" disabled="true" style="border:0px;background-color:#fff;color:#000" value="${baseInfo.currentDeptCode}" >
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap="nowrap">
								是否作为管理层级
							</td>
							<td class="editTd">
									${baseInfo.isManage}
							</td>
							<td class="EditHead" nowrap="nowrap">
								部门名称
							</td>
							<td class="editTd">
									${baseInfo.deptName}
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap="nowrap">
								部门负责人
							</td>
							<td class="editTd">
									${baseInfo.principal}
							</td>
							<!-- liuchunhua 新增字段 -->
							<td class="EditHead" nowrap="nowrap">
								部门负责人电话
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.principalPhone" cssClass="noborder"
										value="${baseInfo.principalPhone}" maxlength="20" />
								</s:if>
								<s:else>
									${baseInfo.principalPhone}
								</s:else>
							</td>
						</tr>
						<tr>
							<s:if test="${status==1}">
								<td class="EditHead" nowrap="nowrap">
									<!-- <font color=red>*</font>&nbsp;主管审计领导 -->
									主管审计领导
								</td>
								<td class="editTd">
									<s:textfield name="baseInfo.charger" cssClass="noborder"
										value="${baseInfo.charger}" maxlength="16" />
								</td>
							</s:if>
							<s:else>
								<td class="EditHead" nowrap="nowrap">
									主管审计领导

								</td>
								<td class="editTd">
									${baseInfo.charger}
								</td>
							</s:else>

							<td class="EditHead" nowrap="nowrap">
								主管审计领导电话
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.managerPhone" cssClass="noborder"
										value="${baseInfo.managerPhone}" maxlength="20" />
								</s:if>
								<s:else>
									${baseInfo.managerPhone}
								</s:else>
							</td>
						</tr>
						<!-- liuchunhua 新增字段 -->
						<tr>
							<td class="EditHead" nowrap="nowrap">
								主管审计领导职务
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.chargerPost" cssClass="noborder"
										value="${baseInfo.chargerPost}" maxlength="20" />
								</s:if>
								<s:else>
									${baseInfo.chargerPost}
								</s:else>
							</td>
							<td class="EditHead" nowrap="nowrap">
								办公地址
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.address" cssClass="noborder"
										value="${baseInfo.address}" maxlength="100" />
								</s:if>
								<s:else>
									${baseInfo.address}
								</s:else>
							</td>
						</tr>
						<tr>
							<s:if test="${status==1}">
								<td class="EditHead" nowrap="nowrap">
									<font color=red>*</font>&nbsp;编制人数
								</td>
								<td class="editTd">
									<s:textfield name="baseInfo.totalNo" cssClass="noborder"
										value="${baseInfo.totalNo}" maxlength="11" />
								</td>
							</s:if>
							<s:else>
								<td class="EditHead" nowrap="nowrap">
									编制人数
								</td>
								<td class="editTd">
									${baseInfo.totalNo}
								</td>
							</s:else>
							<td class="EditHead" nowrap="nowrap">
								实有人数
							</td>
							<td class="editTd">
									${baseInfo.realNo}
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap="nowrap">
								专职审计人数
							</td>
							<td class="editTd">
									${baseInfo.fullTimeNo}
							</td>
							<td class="EditHead" nowrap="nowrap">
								兼职审计人数
							</td>
							<td class="editTd">
									${baseInfo.partTimeNo}
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap="nowrap">
								内审岗位资格人数
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.innerAuthNo" cssClass="noborder" />
								</s:if>
								<s:else>
									${baseInfo.innerAuthNo}
								</s:else>
							</td>
							<td class="EditHead" nowrap="nowrap">
								传真
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.fax"  cssClass="noborder" value="${baseInfo.fax}"
										maxlength="20" />
								</s:if>
								<s:else>
									${baseInfo.fax}
								</s:else>
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap="nowrap">
								办公电话
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.officePhone" cssClass="noborder"
										value="${baseInfo.officePhone}" maxlength="20" />
								</s:if>
								<s:else>
									${baseInfo.officePhone}
								</s:else>
							</td>
							<td class="EditHead" nowrap="nowrap">
								联系电话
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.telephone" cssClass="noborder"
										value="${baseInfo.telephone}" maxlength="20" />
								</s:if>
								<s:else>
									${baseInfo.telephone}
								</s:else>
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap="nowrap">
								联系人
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<input type='hidden' id='baseInfo_contactName' name='baseInfo.contactName' value="${baseInfo.contactName}" class="noborder editElement clear"/>
									<select id="contact" editable="false" name="baseInfo.contact"  PanelHeight="auto" onchange="contactEmali();">
					   	   				<option value="">&nbsp;</option>
							       		<s:iterator value="map">
							       			 <s:if test="${baseInfo.contact ==key}">
												<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
											 </s:if>
								 			<s:else>
												<option value="<s:property value="key"/>"><s:property value="value"/></option>
								 			</s:else>
							       		</s:iterator>
									</select> 
								</s:if>
								<s:else>
									${baseInfo.contactName}
								</s:else>
							</td>
							<td class="EditHead" nowrap="nowrap">
								联系人邮箱
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.email2" id="email2" value="${baseInfo.email2}" cssClass="noborder" cssStyle="width:80%;" maxlength="60" readonly="true"/>
								</s:if>
								<s:else>
									${baseInfo.email2}
								</s:else>
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap="nowrap">
								部门邮箱
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.email1" value="${baseInfo.email1}"
										maxlength="60" cssClass="noborder" />
								</s:if>
								<s:else>
									${baseInfo.email1}
								</s:else>
							</td>
							<td class="EditHead" nowrap="nowrap">
								备注
							</td>
							<td class="editTd">
								<s:if test="${status==1}">
									<s:textfield name="baseInfo.note" value="${baseInfo.note}" cssClass="noborder"
										maxlength="100" />
								</s:if>
								<s:else>
									${baseInfo.note}
								</s:else>
							</td>
						</tr>
						<tr style="height:300px; border: 1px solid #ccc;" id="jcTr">
							<td colspan="4">
								<div id="jcDiv" style="height:300px;">
									<table id="jcTable" title="奖惩信息"></table>
								</div>
							</td>
						</tr>
					</table>
				</s:form>
			</div>
		
			<div region="south" border="0">
				<s:if test="status==2">
					<div id="manu_file" class="easyui-fileUpload" data-options="fileGuid:'${baseInfo.id}',isAdd:false,isDel:false,callbackGridHeight:200"></div>
				</s:if>
				<s:else>
					<div id="manu_file" class="easyui-fileUpload" data-options="fileGuid:'${baseInfo.id}',callbackGridHeight:200"></div>
				</s:else>
			</div>
			</div>
		</div>
		<div id='two' title='在审项目信息' border="0" style="overflow:hidden;">
			<iframe id="prjInfo"
				src="${contextPath}/assist/baseInfo/baseInfoAction!prjinfo.action?deptInfo.orgId=${baseInfo.orgId}&status=2"
				frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
		</div>
		<div id='three' title='历史项目信息' border="0" style="overflow:hidden;">
			<iframe id="prjhisinfo"
				src="${contextPath}/assist/baseInfo/baseInfoAction!prjhisinfo.action?deptInfo.orgId=${baseInfo.orgId}&status=2"
				frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
		</div>
		<div id="planName" title="人员构成" style="overflow:hidden;padding:0px" border='0'>
            <iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
  		</div>
  		<script type="text/javascript">
  		function planName(){
		    var viewUrl = "${contextPath}/mng/employee/employeeInfoList4Dept.action?employeeInfo.companyCode="+"${baseInfo.orgId}";
		    showWinIf('planName',viewUrl,'人员构成');
//		    $('#showPlanName').attr("src",viewUrl);
//	   		$('#planName').window('open');
		}
		$('#planName').window({
		    width:1000, 
		    height:400,  
		    modal:true,
		    collapsible:false,
		    maximizable:true,
		    minimizable:false,
		    closed:true    
		});	
  		</script>
	</body>
</html>