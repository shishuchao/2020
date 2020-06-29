/**
 * 内控测试模块JS
 * @author JunXu
 * 
 */
$.messager.defaults = {ok:"确定",cancel:"取消"};
function editBp(bpId){
	var tl = (bpId==null||bpId=='')?"新增流程":"修改流程";
	bpId = bpId==null?"":bpId;
	$.ajax({
		type:"get",
		url:"${contextPath}/introcontrol/bp-editBp.action",
		data:{"businessProcess.bpId":bpId},
		cache:false,
		success:function(ht){
			$("#addBp").html(ht);
			$("#addBp").show();
			$('#addBp').dialog({
				title : tl,
				width : 600,
				height : 400,
				closed : false,
				modal : true,
				buttons : [ {
					text : "保存",
					iconCls : "icon-save",
					handler : function() {
						var bpName = $("#bpName").val();
						if (bpName == null || bpName == "") {
							$.messager.alert("错误", "流程名称不能为空！");
							return;
						} else {
							$.ajax({
									type : "post",
									url : "${contextPath}/introcontrol/bp-saveBp.action",
									cache : false,
									data : {
										'businessProcess.bpName' : bpName,
										'businessProcess.bpId' : bpId,
										'businessProcess.fileId':$("#fileId").val()
									},
									success : function(ret) {
										if (ret == 'true') {
												$.messager.alert("提示","保存流程成功！");
												$("#addBp").dialog("close", false);
												window.location.reload();
											} else {
												$.messager.alert("提示",
														"保存失败，请稍候重试！");
											}
									}
							});
						}
					}
				} ]
			});
		}
	});
}
function delBp(bpId){
	$.messager.confirm("确认","此操作将删除流程下所有信息！确认吗？",function(r){
		if(r){
			$.ajax({
				type:"get",
				url:"${contextPath}/introcontrol/bp-deleteBp.action",
				data:{"businessProcess.bpId":bpId},
				success:function(ret){
					if (ret == 'true') {
						$.messager.alert("提示","删除流程成功！","info");
						window.location.reload();
					} else {
						$.messager.alert("错误",
								"删除失败，请稍候重试！","error");
					}
				}
			});
		}
	});
}
function revBp(bpId){
	$.messager.confirm("确认","此操作将复制此流程下所有信息生成新版本，旧版本将留作历史！确认吗？",function(r){
		if(r){
			$.ajax({
				type:"get",
				url:"${contextPath}/introcontrol/bp-bpRevision.action",
				data:{"businessProcess.bpId":bpId},
				success:function(ret){
					if (ret == 'true') {
						$.messager.alert("提示","流程版本变更成功！","info");
						window.location.reload();
					} else {
						$.messager.alert("错误",
								"版本变更失败，请稍候重试！","error");
					}
				}
			});
		}
	});
}
function listBpChilds(bpId) {
	$.ajax({
		type : "get",
		url : "${contextPath}/introcontrol/bp-listBpChilds.action",
		cache : false,
		data : {
			'businessProcess.bpId' : bpId
		},
		success : function(ht) {
			$("#bpChilds").html(ht);
			$("#chBpMain").linkbutton({
				iconCls:"icon-edit"
			});
		}
	});
}
// 子流程列表对话框
function showChBpList(bpId) {
	$.ajax({
		type : "get",
		url : "${contextPath}/introcontrol/bp-chBpList.action",
		cache : false,
		data : {
			'businessProcess.bpId' : bpId
		},
		success : function(ht) {
			$("#chBpList").html("");
			$("#chBpList").html(ht);
			$("#chBpList").show();
			$("#chBpList").dialog({
				title:"子流程",
				width : 700,
				height : 400,
				closed : false,
				cache : false,
				modal : true,
				onClose:function(){$('#chBpList').panel("destroy",true);},
				toolbar : [ {
					text : "新增",
					iconCls : "icon-add",
					handler : function() {
						showAddChBp(bpId);
					}
				}, {
					text : "修改",
					iconCls : "icon-edit",
					handler : function() {
						var chBpId = "";
						var n = 0;
						$("input[name='chBpIds']").each(function() {
								if ($(this).attr("checked")) {
									n++;
									chBpId = $(this).val();
								}
						});
						if (n == 0) {
							$.messager.alert("错误","请选择一项进行修改！");
							return;
						} else if (n > 1) {
							$.messager.alert("错误","只能选择一项进行修改！");
							return;
						} else {
							showAddChBp(bpId,chBpId);
						}
					}
				}, {
					text : "删除",
					iconCls : "icon-remove",
					handler : function() {
						delChBp(bpId);
					}
				}, {
					text : "下一步维护控制目标",
					iconCls : "icon-edit",
					handler : function() {
						if ($("#cbpListSize").val() > 0) {
							getControlObjective(bpId);
						} else {
							$.messager.alert("错误", "没有子流程，无法添加控制目标，请先新增子流程！");
							return;
						}
					}
				} ]
			});
		}
	});
}
function delChBp(bpId){
	var cpIdString = "";
	$("input[name='chBpIds']").each(function(){
		if($(this).attr("checked")){
			cpIdString = cpIdString+$(this).val()+",";
		}
	});
	if(cpIdString==""){
		$.messager.alert("错误","至少选择一项来删除！");
		return;
	}else{
		$.messager.confirm("确认","将要删除所选项以及其下的所有关联信息，确定吗？",function(r){
			if(r){
				$.ajax({
					type:"get",
					url:"/ais/introcontrol/bp-deleteChBp.action",
					data:{'cpIdString':cpIdString,'businessProcess.bpId':bpId},
					cache:false,
					success:function(ret){
						if (ret == 'true') {
							$.messager.alert("提示","所选项删除成功！","info");
							$("#chBpList").dialog("refresh","${contextPath}/introcontrol/bp-chBpList.action?businessProcess.bpId="
									+ bpId);
						} else {
							$.messager.alert("错误",
									"删除失败，请稍候重试！","error");
						}
					}
				});
			}
		});
	}
}
function delCo(chBpId){
	var cpIdString = "";
	$("input[name='coId']").each(function(){
		if($(this).attr("checked")){
			cpIdString = cpIdString+$(this).val()+",";
		}
	});
	if(cpIdString==""){
		$.messager.alert("错误","至少选择一项来删除！");
		return;
	}else{
		$.messager.confirm("确认","将要删除所选项以及其下的所有关联信息，确定吗？",function(r){
			if(r){
				$.ajax({
					type:"get",
					url:"${contextPath}/introcontrol/bp-deleteCo.action",
					data:{'cpIdString':cpIdString,
						'childBusinessProcess.chBpId':chBpId},
					cache:false,
					success:function(ret){
						if (ret == 'true') {
							$.messager.alert("提示","所选项删除成功！","info");
							listChBpCo(chBpId);
						} else {
							$.messager.alert("错误",
									"删除失败，请稍候重试！","error");
						}
					}
				});
			}
		});
	}
}
function delCa(coId){
	var cpIdString = "";
	$("input[name='caId']").each(function(){
		if($(this).attr("checked")){
			cpIdString = cpIdString+$(this).val()+",";
		}
	});
	if(cpIdString==""){
		$.messager.alert("错误","至少选择一项来删除！");
		return;
	}else{
		$.messager.confirm("确认","将要删除所选项以及其下的所有关联信息，确定吗？",function(r){
			if(r){
				$.ajax({
					type:"get",
					url:"${contextPath}/introcontrol/bp-deleteCa.action",
					data:{'cpIdString':cpIdString,'controlObjective.coId':coId},
					cache:false,
					success:function(ret){
						if (ret == 'true') {
							$.messager.alert("提示","所选项删除成功！","info");
							listCoCa(coId);
						} else {
							$.messager.alert("错误",
									"删除失败，请稍候重试！","error");
						}
					}
				});
			}
		});
	}
}
function delCud(caId){
	var cpIdString = "";
	$("input[name='cudId']").each(function(){
		if($(this).attr("checked")){
			cpIdString = cpIdString+$(this).val()+",";
		}
	});
	if(cpIdString==""){
		$.messager.alert("错误","至少选择一项来删除！");
		return;
	}else{
		$.messager.confirm("确认","将要删除所选项以及其下的所有关联信息，确定吗？",function(r){
			if(r){
				$.ajax({
					type:"get",
					url:"${contextPath}/introcontrol/bp-deleteCud.action",
					data:{'cpIdString':cpIdString,'controlActivity.caId':caId},
					cache:false,
					success:function(ret){
						if (ret == 'true') {
							$.messager.alert("提示","所选项删除成功！","info");
							listCaCud(caId);
						} else {
							$.messager.alert("错误",
									"删除失败，请稍候重试！","error");
						}
					}
				});
			}
		});
	}
}
//子流程新增对话框
function showAddChBp(bpId,chBpId) {
	var tl = chBpId==null?"新增子流程":"修改子流程";
	chBpId = chBpId==null?"":chBpId;
	$.ajax({
		type:"get",
		url:"${contextPath}/introcontrol/bp-editChBp.action",
		data:{"childBusinessProcess.chBpId":chBpId},
		success:function(ht){
			$("#addChBp").html(ht);
			$("#addChBp").show();
			$('#addChBp').dialog({
								title : tl,
								width : 400,
								height : 200,
								closed : false,
								cache : false,
								modal : true,
								buttons : [ {
									text : "保存",
									iconCls : "icon-save",
									handler : function() {
										var chBpName = $("#chBpName").val();
										if (chBpName == null || chBpName == "") {
											$.messager.alert("错误", "子流程名称不能为空！");
											return;
										} else {
											$.ajax({
													type : "post",
													url : "${contextPath}/introcontrol/bp-saveChBp.action",
													cache : false,
													data : {
														'childBusinessProcess.chBpName' : chBpName,
														'childBusinessProcess.chBpId' : chBpId,
														'businessProcess.bpId' : bpId
													},
													success : function(ret) {
														if (ret == 'true') {
															$.messager.alert("提示","保存子流程成功！");
															$("#addChBp").dialog("close", false);
															$("#chBpList").dialog("refresh","${contextPath}/introcontrol/bp-chBpList.action?businessProcess.bpId="
																				+ bpId);
															} else {
																$.messager.alert("提示",
																		"保存失败，请稍候重试！");
															}
														}
											});
										}
									}
						} ]
			});
		}
	});
}
//------------------控制目标相关--------------
//控制目标维护对话框
function getControlObjective(bpId) {
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-listControlObjective.action",
				cache : false,
				data : {
					'businessProcess.bpId' : bpId
				},
				success : function(ret) {
					$("#controlObjectiveMaintain").html("");
					$("#controlObjectiveMaintain").html(ret);
					$("#chBpList").dialog("close");
					$("#controlObjectiveMaintain").show();
					$("#coTree").tree({
						animate : true
					});
					$("#co").layout();
					$('#controlObjectiveMaintain')
							.dialog(
									{
										title : '控制目标维护',
										width : 800,
										height : 450,
										closed : false,
										cache : false,
										modal : true,
										resizable : true,
										onClose:function(){$('#controlObjectiveMaintain').panel("destroy",true);},
										toolbar : [
												{
													text : "新增",
													iconCls : "icon-add",
													handler : function() {
														showAddCo($("#chBpId")
																.val(), null);
													}
												},
												{
													text : "修改",
													iconCls : "icon-edit",
													handler : function() {
														var coId = "";
														var n = 0;
														$("input[name='coId']")
																.each(
																		function() {
																			if ($(this).attr(
																							"checked")) {
																				n++;
																				coId = $(
																						this)
																						.val();
																			}
																		});
														if (n == 0) {
															$.messager
																	.alert(
																			"错误",
																			"请选择一项进行修改！");
															return;
														} else if (n > 1) {
															$.messager
																	.alert(
																			"错误",
																			"只能选择一项进行修改！");
															return;
														} else {
															showAddCo($("#chBpId").val(),coId);
														}
													}
												},
												{
													text : "删除",
													iconCls : "icon-remove",
													handler : function() {
														delCo($("#chBpId").val());
													}
												},
												{
													text : "下一步维护控制活动",
													iconCls : "icon-edit",
													handler : function() {
														if ($("#coListSize")
																.val() > 0) {
															getControlActivity($(
																	"#chBpId")
																	.val());
														} else {
															$.messager
																	.alert(
																			"错误",
																			"子流程没有控制目标，无法添加控制活动，请先新增控制目标！");
															return;
														}
													}
												} ]
									});
				}
			});
}
//控制目标修改或新增
function showAddCo(chBpId, coId) {
	var tl = coId == null ? "新增控制目标" : "修改控制目标";
	coId = coId == null ? "" : coId;
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-editCo.action",
				data : {
					"controlObjective.coId" : coId
				},
				cache : false,
				success : function(ht) {
					$("#addCo").html(ht);
					$("#addCo").show();
					$('#addCo').dialog(
									{
										title : tl,
										width : 400,
										height : 200,
										closed : false,
										cache : false,
										modal : true,
										buttons : [ {
											text : "保存",
											iconCls : "icon-save",
											handler : function() {
												var coCode = $("#coCode").val();
												var coContent = $("#coContent").val();
												$.ajax({
															type : "post",
															url : "${contextPath}/introcontrol/bp-saveCo.action",
															cache : false,
															data : {
																'controlObjective.coCode' : coCode,
																'controlObjective.coContent' : coContent,
																'controlObjective.coId' : coId,
																'childBusinessProcess.chBpId' : chBpId
															},
															success : function(ret) {
																if (ret == 'true') {
																	$.messager.alert("提示","保存控制目标成功！");
																	$("#addCo").dialog("close",false);
																	listChBpCo(chBpId);
																} else {
																	$.messager.alert("提示","保存失败，请稍候重试！");
																	return;
																}
															}
														});

											}
										} ]
									});
				}
			});

}
//获取子流程下的控制目标
function listChBpCo(chBpId) {
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-listChBpCo.action?childBusinessProcess.chBpId="
						+ chBpId,
				cache : false,
				success : function(ht) {
					$("#coTableList").html("");
					$("#coTableList").html(ht);
				}
			});
}
//-----------------控制活动相关--------------------
//控制活动维护对话框
function getControlActivity(chBpId) {
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-listControlActivity.action",
				cache : false,
				data : {
					'childBusinessProcess.chBpId' : chBpId
				},
				success : function(ret) {
					$("#controlActivityMaintain").html(ret);
					$("#controlActivityMaintain").show();
					$("#caTree").tree({
						animate : true
					});
					$("#ca").layout();
					$('#controlActivityMaintain')
							.dialog(
									{
										title : '控制活动维护',
										width : 1000,
										height : 450,
										closed : false,
										cache : false,
										modal : true,
										resizable : true,
										onClose:function(){$('#controlActivityMaintain').panel("destroy",true);},
										toolbar : [
												{
													text : "新增",
													iconCls : "icon-add",
													handler : function() {
														showAddCa($("#coId")
																.val(), null);
													}
												},
												{
													text : "修改",
													iconCls : "icon-edit",
													handler : function() {
														var caId = "";
														var n = 0;
														$("input[name='caId']").each(function() {
															if ($(this).attr("checked")) {
																	n++;
																	caId = $(this).val();
															}
														});
														if (n == 0) {
															$.messager.alert("错误","请选择一项进行修改！");
															return;
														} else if (n > 1) {
															$.messager.alert("错误","只能选择一项进行修改！");
															return;
														} else {
															showAddCa($("#coId").val(),caId);
														}
													}
												},
												{
													text : "删除",
													iconCls : "icon-remove",
													handler : function() {
														delCa($("#coId").val());
													}
												},
												{
													text : "下一步维护底稿",
													iconCls : "icon-edit",
													handler : function() {
														if ($("#caListSize").val() > 0)
															getCheckUnderdrawing();
														else {
															$.messager.alert("错误","控制目标没有控制活动，无法添加底稿，请先新增控制活动！");
															return;
														}
													}
												} ]
									});
				}
			});
}
//控制活动修改或新增
function showAddCa(coId, caId) {
	var tl = caId == null ? "新增控制活动" : "修改控制活动";
	caId = caId == null ? "" : caId;
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-editCa.action",
				data : {
					"controlActivity.caId" : caId
				},
				cache : false,
				success : function(ht) {
					$("#addCa").html(ht);
					$("#addCa").show();
					$('#addCa').dialog(
									{
										title : tl,
										width : 500,
										height : 300,
										closed : false,
										cache : false,
										modal : true,
										buttons : [ {
											text : "保存",
											iconCls : "icon-save",
											handler : function() {
												var caCode = $("#caCode").val();
												var caContent = $("#caContent").val();
												var caName = $("#caName").val();
												$.ajax({
															type : "post",
															url : "${contextPath}/introcontrol/bp-saveCa.action",
															cache : false,
															data : {
																'controlActivity.caCode' : caCode,
																'controlActivity.caContent' : caContent,
																'controlActivity.caName' : caName,
																'controlActivity.caId' : caId,
																'controlObjective.coId' : coId
															},
															success : function(
																	ret) {
																if (ret == 'true') {
																	$.messager.alert("提示","保存控制活动成功！");
																	$("#addCa").dialog("close",false);
																	listCoCa(coId);
																} else {
																	$.messager.alert("提示","保存失败，请稍候重试！");
																}
															}
														});

											}
										} ]
									});
				}
			});

}
//获取控制目标下的控制活动
function listCoCa(coId) {
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-listCoCa.action?controlObjective.coId="
						+ coId,
				cache : false,
				success : function(ht) {
					$("#caTableList").html(ht);
				}
			});
}
//-----------------控制活动底稿相关--------------------
//控制活动底稿维护对话框
function getCheckUnderdrawing() {
	$.ajax({
		type : "get",
		url : "${contextPath}/introcontrol/bp-listCheckUnderdrawing.action",
		cache : false,
		data : {
			'controlObjective.coId' : $("#coId").val()
		},
		success : function(ret) {
			$("#checkUnderdrawing").html(ret);
			$("#checkUnderdrawing").show();
			$("#cudTree").tree({
				animate : true
			});
			$("#cud").layout();
			$('#checkUnderdrawing').dialog({
				title : '控制活动底稿维护',
				width : 1000,
				height : 450,
				closed : false,
				cache : false,
				modal : true,
				resizable : true,
				onClose:function(){$('#checkUnderdrawing').panel("destroy",true);},
				toolbar : [ {
					text : "新增",
					iconCls : "icon-add",
					handler : function() {
						showAddCud($("#hideCaId").val(), null);
					}
				}, {
					text : "修改",
					iconCls : "icon-edit",
					handler : function() {
						var cudId = "";
						var n = 0;
						$("input[name='cudId']").each(function() {
							if ($(this).attr("checked")) {
								n++;
								cudId = $(this).val();
							}
						});
						if (n == 0) {
							$.messager.alert("选择错误", "请选择一项进行修改！");
							return;
						} else if (n > 1) {
							$.messager.alert("错误", "只能选择一项进行修改！");
							return;
						} else {
							showAddCud($("#hideCaId").val(), cudId);
						}
					}
				}, {
					text : "删除",
					iconCls : "icon-remove",
					handler : function() {
						delCud($("#hideCaId").val());
					}
				}, {
					text : "下一步维护测试点",
					iconCls : "icon-edit",
					handler : function() {
						if ($("#cudListSize").val() > 0)
							getCheckPoint($("#hideCaId").val());
						else {
							$.messager.alert("错误", "控制活动没有底稿，无法添加测试点，请先新增底稿！");
							return;
						}
					}
				} ]
			});
		}
	});
}
//底稿修改或新增
function showAddCud(caId, cudId) {
	var tl = cudId == null ? "新增控制活动底稿" : "修改控制活动底稿";
	cudId = cudId == null ? "" : cudId;
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-editCud.action",
				data : {
					"checkUnderdrawing.cudId" : cudId
				},
				cache : false,
				success : function(ht) {
					$("#addCud").html(ht);
					$("#addCud").show();
					$('#addCud').dialog(
									{
										title : tl,
										width : 800,
										height : 400,
										closed : false,
										cache : false,
										modal : true,
										buttons : [ {
											text : "保存",
											iconCls : "icon-save",
											handler : function() {
												var al = "";
												$("input[name='cj']").each(function(){
													if($(this).attr("checked")){
														al = al+$(this).val()+",";
													}
												});
												var ab = "";
												$("input[name='bk']").each(function(){
													if($(this).attr("checked")){
														ab = ab+$(this).val()+",";
													}
												});
												var cudCode = $("#cudCode").val();
												var caDescription = $("#caDescription").val();
												var checkStep = $("#checkStep").val();
												var applicableBusiness = ab;
												var applicableLevel = al;
												var importance = $("#importance").val();
												$.ajax({
															type : "post",
															url : "${contextPath}/introcontrol/bp-saveCud.action",
															cache : false,
															data : {
																'checkUnderdrawing.cudCode' : cudCode,
																'checkUnderdrawing.cudId' : cudId,
																'checkUnderdrawing.importance' : importance,
																'checkUnderdrawing.caDescription' : caDescription,
																'checkUnderdrawing.applicableLevel' : applicableLevel,
																'checkUnderdrawing.applicableBusiness' : applicableBusiness,
																'checkUnderdrawing.checkStep' : checkStep,
																'controlActivity.caId' : caId
															},
															success : function(ret) {
																if (ret == 'true') {
																	$.messager.alert("提示","保存控制活动底稿成功！");
																	$("#addCud").dialog('close');
																	listCaCud(caId);
																} else {
																	$.messager.alert("提示","保存失败，请稍候重试！");
																	return;
																}
															}
														});

											}
										} ]
									});
				}
			});

}
//获取控制活动下的底稿
function listCaCud(caId) {
	$.ajax({
				type : "get",
				url : "${contextPath}/introcontrol/bp-listCaCud.action?controlActivity.caId="
						+ caId,
				cache : false,
				success : function(ht) {
					$("#cudTableList").html(ht);
				}
			});
}
//-----------------测试点相关--------------------
//测试点维护对话框
function getCheckPoint(caId) {
	$.ajax({
		type : "get",
		url : "${contextPath}/introcontrol/bp-listCheckPoint.action",
		cache : false,
		data : {
			'controlActivity.caId' : caId
		},
		success : function(ret) {
			$("#checkPointMaintain").html(ret);
			$("#checkPointMaintain").show();
			$("#cpTree").tree({
				animate : true
			});
			$("#cp").layout();
			$('#checkPointMaintain').dialog({
				title : '测试点维护',
				width : 1000,
				height : 450,
				closed : false,
				modal : true,
				resizable : true,
				onClose:function(){$('#checkPointMaintain').panel("destroy",true);},
				toolbar : [ {
					text : "新增",
					iconCls : "icon-add",
					handler : function() {
						showAddCp($("#cudId").val());
					}
				},{
					text : "删除所选",
					iconCls : "icon-remove",
					handler : function() {
						var cpIdString = "";
						$("input[name='cpId']").each(function(){
							if($(this).attr("checked")){
								cpIdString = cpIdString+$(this).val()+",";
							}
						});
						if(cpIdString==""){
							$.messager.alert("错误","至少选择一项来删除！");
							return;
						}else{
							$.messager.confirm("确认？","将要删除所选项以及其下的所有关联信息，确定吗？",function(r){
								if(r){
									$.ajax({
										type:"get",
										url:"${contextPath}/introcontrol/bp-deleteCheckPoint.action",
										data:{
											'cpIdString':cpIdString,
											'checkUnderdrawing.cudId':$("#cudId").val()
										},
										cache:false,
										success:function(ret){
											if(ret=='true'){
												$.messager.alert("成功","所选项删除成功！");
												listCheckPoints($("#cudId").val());
											}else{
												$.messager.alert("失败","部分删除操作失败，请重试！");
												return;
											}
										}
									});
								}
							});
						}
					}
				},{
					text:"维护完成",
					iconCls:"icon-ok",
					handler:function(){
						window.location.reload();
					}
				} ]
			});
		}
	});
}
//测试点新增
function showAddCp(caId) {
	$("#addCp").show();
	$('#addCp').dialog({
		title : '新增测试点',
		width : 1000,
		height : 450,
		closed : false,
		cache : false,
		modal : true
	});

}
//excel单元格转化成表格
function excelToTable() {
	var tableContent = $("#tableContent").val();
	$.ajax({
		type : "post",
		url : "${contextPath}/introcontrol/bp-excelToTable.action",
		cache : false,
		data : {
			tableContent : tableContent,
			'checkUnderdrawing.cudId' : $("#cudId").val()

		},
		success : function(html) {
			$("#dynamicTable").html(html);
		}
	});
}

/**
 * 显示下拉列表内容输入框
 * @param mval
 * @param id
 */
function showSelectValue(mval, id) {
	if (mval == 'SELECT') {
		document.getElementById(id + ".selectValue").style.display = "block";
	} else {
		document.getElementById(id + ".selectValue").style.display = "none";
	}
}
function changeValue(val, id) {
	if(document.getElementById(id + ".selectValue").value=='输入列表内容，以英文标点逗号分割') 
		document.getElementById(id + ".selectValue").value = val;
}
/**
 * 获取底稿下的测试点
 * @param caId
 */
function listCheckPoints(cudId) {
	$.ajax({
		type : "get",
		url : "${contextPath}/introcontrol/bp-listCheckPoints.action",
		cache : false,
		data : {
			'checkUnderdrawing.cudId' : cudId
		},
		success : function(ht) {
			$("#cpTableList").html(ht);
		}
	});
}
/**
 * 保存测试点属性
 */
function saveCpAttrType() {
	var str = "";
	$("input[name='parentId']").each(
		function() {				
			var id = $(this).val();
			str = str + id + "*" + $("#" + id).val();
			if ($("input[name='" + id + "']").size() > 0) {
				str = str + "(";
				$("input[name='" + id + "']").each(function() {
					var md = $(this).val();
					var mn = $("#" + md).val();
					var type = document.getElementById(md+ ".cpAttrType").value;
					str = str + md + "*" + mn + "*"+ type;
					if (type == 'SELECT') {
						str = str+ "*"+ document.getElementById(md+ ".selectValue").value;
					}
					str = str + "|";
				});
				str = str + ")";
			} else {
				var type = document.getElementById(id+ ".cpAttrType").value;
				str = str + "*" + type;
				if (type == 'SELECT') {
					str = str+ "*"+ document.getElementById(id+ ".selectValue").value;
				}
			}
			str = str + "#";
	});
	$.ajax({
		type : "post",
		cache : false,
		url : "${contextPath}/introcontrol/bp-saveCpAttrType.action",
		data : {
			'cpTypeString' : str,
			'checkUnderdrawing.cudId' : $("#cudId").val()
		},
		success : function(ret) {
			if (ret == 'true') {
				$.messager.alert("提示", "保存成功！");
				$("#addCp").dialog("close", false);
				listCheckPoints($("#cudId").val());
			} else {
				$.messager.alert("错误", "保存失败，请稍候重试！");
			}
		}
	});
}
//全选功能通用
function checkAll(ckName,evtObj){
	if($(evtObj).attr("checked")){
		$("input[name='"+ckName+"']").each(function(){
			$(this).attr("checked","checked");
		});
	}else{
		$("input[name='"+ckName+"']").each(function(){
			$(this).removeAttr("checked");
		});
	}
}

function getCheckPoints(cudId) {
	$.ajax({
		type : "get",
		url : "/ais/introcontrol/bp-getCheckPoints.action",
		cache : false,
		data : {
			'checkUnderdrawing.cudId' : cudId
		},
		success : function(ht) {
			$("#checkPoint").html(ht);
			$("#checkPoint").show().css('overflow','auto');
			$("#checkPoint").dialog({
				title:"测试点",
				width:900,
				height:450,
				closed:false,
				modal:true,
				resizable:true,
				onClose:function(){
					$('#checkPoint').panel("destroy",true);
					document.location.reload();
				}
			});
		}
	});
}