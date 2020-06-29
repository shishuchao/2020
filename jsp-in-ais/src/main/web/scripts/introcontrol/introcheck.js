/**
 * @author JunXu
 */
$.messager.defaults = {ok:"确定",cancel:"取消"};


function checkUnderdrawing(ucId,cudId,groupId){
	var tab = $("#bpInfo").tabs("getTab",'测试底稿');
	
	if(tab){
		//tab.panel("refresh","/ais/introcontrol/check/getCheckUnderdrawing.action?underdrawingCheck.ucId="+ucId+"&groupId="+groupId+"&checkUnderdrawing.cudId="+cudId);
		$("#bpInfo").tabs("select",1);
	}else{
		$("#bpInfo").tabs("add",{
			title:"测试底稿",
			closable:true,
			content:"<iframe src='/ais/introcontrol/check/getCheckUnderdrawing.action?underdrawingCheck.ucId="+ucId+"&groupId="+groupId+"&checkUnderdrawing.cudId="+cudId+"' width='100%' height='100%'></iframe>"
		});
	} 
}
function getBpDetailInfo(bpId,ccId,applicableOrg,groupId){
	$("#bpInfo").tabs({border:false});
	var tab = $("#bpInfo").tabs("getTab",'流程详细');
	if(tab){
		//tab.panel("refresh","/ais/introcontrol/check/getCheckUnderdrawing.action?underdrawingCheck.ucId="+ucId+"&groupId="+groupId+"&checkUnderdrawing.cudId="+cudId);
		$("#bpInfo").tabs("select",'流程详细');
	}else{
		$("#bpInfo").tabs("add",{
			title:"流程详细",
			closable:true,
			content:"<iframe src='/ais/introcontrol/check/editIntroControlCheck.action?businessProcess.bpId="+bpId+"&introControlCheck.iccId="+ccId+"&introControlCheckCaseDetail.applicableOrg="+applicableOrg+"&groupId="+groupId+"' width='100%' height='100%'></iframe>"
		});
	} 
	
}

function checkPoint(cpId,cpcId,ucId){
	var tab = $("#bpInfo").tabs("getTab","测试点测试");
	if(tab){
		$("#bpInfo").tabs("select","测试点测试");
	}else{
		$("#bpInfo").tabs("add",{
			title:"测试点测试",
			closable:true,
			content:"<iframe src='/ais/introcontrol/check/loadCheckPoint.action?checkPoint.cpId="+cpId+"&underdrawingCheck.ucId="+ucId+"&checkPointCheck.cpcId="+cpcId+"' width='100%' height='100%'></iframe>"
		});
	} 
}
 function openReplace(obj){
    try{ 
    	if(obj){
    		var value = obj.value;
    		var tdObj = $(obj).parent().next();
    		var inputObj = $(tdObj[0].firstChild);
    		if(value === '0'){
    			inputObj.val('').hide();
    		}else if(value === '1'){
    			inputObj.show();
    		}
    	}
	 }catch(e){
	 	alert(e.message);
	 }
 }
function viewCheckPoint(cpId,cpcId,ucId){
	var tab = $("#tt").tabs("getTab","测试点查看");
	if(tab){
		//tab.panel("refresh","/ais/introcontrol/check/viewCheckPoint.action?checkPoint.cpId="+cpId+"&underdrawingCheck.ucId="+ucId+"&checkPointCheck.cpcId="+cpcId);
		$("#tt").tabs("select","测试点查看");
	}else{
		$("#tt").tabs("add",{
			title:"测试点查看",
			closable:true,
			content:"<iframe src='/ais/introcontrol/check/viewCheckPoint.action?checkPoint.cpId="+cpId+"&underdrawingCheck.ucId="+ucId+"&checkPointCheck.cpcId="+cpcId+"' width='100%' height='100%'></iframe>"
		});
	} 
}

function saveSamples(tablId,cpcId,ucId){
	$.messager.confirm('提示','确定要保存吗？',function(r){
		if(r){
			var frequency = $("#frequency").val();
			var transactionNum = $("#transactionNum").val();
			var sampleSize = $("#sampleSize").val();
			var sampleSizeDescription = $("#sampleSizeDescription").val();
			var len =  $("#"+tablId+" tr").length;
			var cpId = $("#cpId").val();
			if(len>2){
				var i = 0;
				var str = "";
				for(i=0;i<=len-2;i++){
					if(document.getElementById("cs"+i+".sampleDescription")!='undefined'&&document.getElementById("cs"+i+".sampleDescription")!=null){
						str = str+document.getElementById("cs"+i+".sampleDescription").value
							+"@@"+document.getElementById("cs"+i+".sampleCode").value
							+"@@"+document.getElementById("cs"+i+".sampleStatus").value
							+"@@"+ document.getElementById("cs"+i+".sampleReplace").value +"≮";
						$("input[name='cs"+i+"']").each(function(){
							var id = $(this).val()+i+".value";
							str = str+$(this).val()+"@@"+document.getElementById(id).value+"TWO";
						});
						str = str+"≯ONE";
					}
				}
				
				$.ajax({
					type:"post",
					url:"/ais/introcontrol/check/saveSamples.action",
					async:false,
					data:{
						'checkPointCheck.cpcId':cpcId,
						'checkPointCheck.frequency':frequency,
						'checkPointCheck.transactionNum':transactionNum,
						'checkPointCheck.sampleSize':sampleSize,
						'checkPointCheck.sampleSizeDescription':sampleSizeDescription,
						'underdrawingCheck.ucId':ucId,
						'sampleString':str
					},
					success:function(ret){
						if(ret=='true'){
								$.messager.alert("提示","样本保存成功！","info",function(){
									window.parent.updateCheckPoint(cpId,ucId,cpcId);
								});
							}else{
								$.messager.alert("错误","样本保存失败！","error");
								return;
							}				
					}
				});
			}
		}
	});
	
}
function updateCheckPoint(cpId,ucId,cpcId){
	var tab = $("#bpInfo").tabs("getTab","测试点测试");
	if(tab){
		$("#bpInfo").tabs("close","测试点测试");
		$("#bpInfo").tabs("add",{
				title:"测试点测试",
				closable:true,
				content:"<iframe src='/ais/introcontrol/check/loadCheckPoint.action?checkPoint.cpId="+cpId+"&underdrawingCheck.ucId="+ucId+"&checkPointCheck.cpcId="+cpcId+"' width='100%' height='100%'></iframe>"
		});
	}
}
function addRow(tablId,cpId,size){
	 var tr_id = $("#"+tablId+" tr:last").attr("id");
		if(!tr_id){
			tr_id = 0;
		}else{
			tr_id++;
		}
		$.ajax({
			type:"get",
			url:"/ais/introcontrol/check/addRow.action",
			data:{'checkPoint.cpId':cpId,trId:tr_id,'sampleSize':size},
			cache:false,
			async:false,
			dataType:'json',
			success:function(data){
				$("#"+tablId).append(data.tr);
			}
		});
	}
function delRow(tablId){
	var len =  $("#"+tablId+" tr").length;
	if(len>3){
		$.messager.confirm("确认","确定删除？",function(r){
			if(r){
				var tr_id = $("#"+tablId+" tr:last").attr("id");
				$("#"+tr_id).remove();
			}
		});
	}else{
		$.messager.alert("错误","至少要留有一个样本！","error");
		return;
	}
}

function del(tablId,sampleId,cpcId){
	$.messager.confirm("确认","确定删除？",function(r){
		if(r){
			$(tablId).parent().remove();
		    $.ajax({
				type:"post",
				url:"/ais/introcontrol/check/delRow.action",
				data:{
					'sampleId':sampleId,
					'checkPointCheck.cpcId':cpcId
				},
				success:function(ret){
					if(ret=='true'){
						$.messager.alert("提示","删除成功！","info");
					}else{
						$.messager.alert("错误","删除失败，请稍后重试！","error");
						return;
					}
				}
			});
		}
	});
}

function delR(tablId){
	$.messager.confirm("确认","确定删除？",function(r){
		if(r){
			$(tablId).parent().remove();
			$("#sampleSize").val($("#sampleSize").val()-1);
		}
	});
}

function saveUnderdrawingCheck(){
	var entityName = $("#entityName").val();
	var interviewer = $("#interviewer").val();
	var checkConclusion = $("#checkConclusion").val();
	var checkConclusionDesc = $("#checkConclusionDesc").val();
	var businessSituation = $("#businessSituation").val();
	var ucId = $("#ucId").val();
	var fj = $("#fj").val();
	var defect = $("#defectType").val();
	var groupId = $("#groupId").val();
	var checker = $("#checker").val();
	var checkStatus = $("#checkStatus").val();
	var checkerName = $("#checker").find("option:selected").text();
	var checkConclusionName = $("#checkConclusion").find("option:selected").text();
	$.messager.confirm("确认","确定保存？",function(r){
		if(r){
		    $.ajax({
				type:"post",
				url:"/ais/introcontrol/check/saveUnderdrawingCheck.action",
				data:{
					'underdrawingCheck.entityName':entityName,
					'underdrawingCheck.fj':fj,
					'underdrawingCheck.interviewer':interviewer,
					'underdrawingCheck.checkConclusion':checkConclusion,
					'underdrawingCheck.checkConclusionName':checkConclusionName,
					'underdrawingCheck.checkConclusionDesc':checkConclusionDesc,
					'underdrawingCheck.businessSituation':businessSituation,
					'underdrawingCheck.checker':checker,
					'underdrawingCheck.checkerName':checkerName,
					'underdrawingCheck.groupId':groupId,
					'underdrawingCheck.ucId':ucId,
					"underdrawingCheck.defectType":defect,
					'underdrawingCheck.checkStatus':checkStatus
				},
				success:function(ret){
					if(ret=='true'){
						$.messager.alert("提示","保存成功！","info");
					}else{
						$.messager.alert("错误","保存失败！请稍后重试！","error");
						return;
					}
				}
			});
		}
	});
}

function reviewUnderdrawingCheck(){
	var entityName = $("#entityName").val();
	var interviewer = $("#interviewer").val();
	var checkConclusion = $("#checkConclusion").val();
	var checkConclusionDesc = $("#checkConclusionDesc").val();
	var businessSituation = $("#businessSituation").val();
	var ucId = $("#ucId").val();
	var fj = $("#fj").val();
	var defect = $("#defectType").val();
	var groupId = $("#groupId").val();
	var checker = $("#checker").val();
	var checkerName = $("#checker").find("option:selected").text();
	var checkConclusionName = $("#checkConclusion").find("option:selected").text();
	$.messager.confirm("确认","确定提交？",function(r){
		if(r){
			if(checker==null||checker==''){
				$.messager.alert("错误","请选择复核人！","error");
				return;
			}
		    $.ajax({
				type:"post",
				url:"/ais/introcontrol/check/reviewUnderdrawingCheck.action",
				data:{
					'underdrawingCheck.entityName':entityName,
					'underdrawingCheck.interviewer':interviewer,
					'underdrawingCheck.fj':fj,
					'underdrawingCheck.checkConclusion':checkConclusion,
					'underdrawingCheck.checkConclusionName':checkConclusionName,
					'underdrawingCheck.checkConclusionDesc':checkConclusionDesc,
					'underdrawingCheck.businessSituation':businessSituation,
					'underdrawingCheck.checker':checker,
					'underdrawingCheck.checkerName':checkerName,
					'underdrawingCheck.groupId':groupId,
					'underdrawingCheck.ucId':ucId,
					"underdrawingCheck.defectType":defect
				},
				success:function(ret){
					if(ret=='true'){
						$.messager.alert("提示","提交成功！","info");
					}else{
						$.messager.alert("错误","提交失败！请确认每个样本下都有测试点","error");
						return;
					}
				}
			});
		}
	});
}

function genSample(vl,tablId,cpId){
	var len =  $("#"+tablId+" tr").length;
	if(len>=2){
		if(vl!=null&&vl!=""){
			if(vl>len-2){
				vl = vl-len+2;
				if(vl>0){
					addRow(tablId,cpId,vl);
				}
			}else if(len-2>vl){
				vl = len-2-vl;
				if(vl>0){
					var i = 0;
					var len =  $("#"+tablId+" tr").length;
					$.messager.confirm("确认","确定删除？",function(r){
						if(len>3){
							if(r){
								for(i=0;i<vl;i++){
									var tr_id = $("#"+tablId+" tr:last").attr("id");
									$("#"+tr_id).remove();
								}
							}
						}else{
							$.messager.alert("错误","至少要留有一个样本！","error");
							return;
						}
					});
				}
			}
		}
	}
}
function listCheckCaseDetail(level,bus,org,orgName,proId,stage){
	$.ajax({
		type:"post",
		url:"/ais/introcontrol/checkcase/listCheckCaseDetail.action",
		cache:false,
		contentType: "application/x-www-form-urlencoded; charset=utf-8", 
		data:{
			'checkUnderdrawing.applicableLevel':level,
			'checkUnderdrawing.applicableBusiness':bus,
			'introControlCheckCaseDetail.applicableOrg':org,
			'introControlCheckCaseDetail.applicableOrgName':orgName,
			'introControlCheckCase.cccId':$("#cccId").val(),
			'projectId':proId,
			'stage':stage
		},
		success:function(ret){
			$("#cudInfoList").html(ret);
			if(stage=='operate'){
				$("#saveBtn").css("display","none");
			}else{
				$("#saveBtn").linkbutton({
					iconCls:"icon-save"
				});
			}
		}
	});
}
function listCheckCaseDetailNew(level,bus,org,orgName,proId,stage){
	document.getElementById("bpName").value = "";
	document.getElementById("chBpName").value = "";
	document.getElementById("caCode").value = "";
	ids = new Array();
	document.getElementById("applicableLevelId").value = level;
	document.getElementById("applicableBusinessId").value= bus;
	document.getElementById("applicableOrg").value= org;
	document.getElementById("applicableOrgName").value= orgName;
	document.getElementById("cccId").value= $("#cccId").val();
	document.getElementById("projectId").value= proId;
	document.getElementById("stage").value= stage;
	$.ajax({
		type: "post",
		dataType:'json',
		url:"/ais/introcontrol/checkcase/listCheckCaseDetail.action",
		data:{
			'checkUnderdrawing.applicableLevel':level,
			'checkUnderdrawing.applicableBusiness':bus,
			'introControlCheckCaseDetail.applicableOrg':org,
			'introControlCheckCaseDetail.applicableOrgName':orgName,
			'introControlCheckCase.cccId':$("#cccId").val(),
			'view':$("#view").val(),
			'projectId':proId,
			'stage':stage,
			'page':"0",
			'rows':"10"
		},
		success:function(data){
			if(data.page == "0"){
				$('#cudInfoList').datagrid('options').pageNumber = 1;
				$('#cudInfoList').datagrid('getPager').pagination({pageNumber:1});
			}
			if(data.cudString!=null&&data.cudString!=""){
			var strs = data.cudString.split(",");
				for(var i = 0;i<strs.length;i++){
					addItem(strs[i]);
				}
			}
			$('#cudInfoList').datagrid('loadData',data);
		}
	});
}
function editCheckCaseDetail(cccId){
	$.ajax({
		type:"get",
		url:"/ais/introcontrol/checkcase/editCheckCaseDetail.action",
		cache:false,
		data:{
			"introControlCheckCase.cccId":cccId
		},
		success:function(ret){
			$("#editCheckCase").html(ret);
			$("#checktree").tree({
				animate : true				
			});
			$("#checklayout").layout();
			$("#editCheckCase").show();
			$("#editCheckCase").dialog({
				title:"内控测试方案维护",
				closable:true,
				width:800,
				height:400
			});
		}
	});
}
function editCheckCase(cccId){
	$.ajax({
		type:"get",
		url:"/ais/introcontrol/checkcase/editCheckCase.action",
		cache:false,
		data:{
			"introControlCheckCase.cccId":cccId
		},
		success:function(ret){
			$("#editCheckCase").html(ret);
//			$("#prolist").datagrid();
			$("#editCheckCase").show();
			$("#editCheckCase").dialog({
				title:"内控测试方案",
				closable:true,
				width:800,
				height:400,
				buttons:[{
					text:"保存",
					iconCls:"icon-save",
					handler:function(){
						saveCheckCase();
					}
				},{
					text:"取消",
					iconCls:"icon-cancel",
					handler:function(){
						$("#editCheckCase").dialog("close");
					}
				}]
			});
		}
	});
}
function saveCheckCaseDetail(){
	$("#checkCaseForm").form("submit",{
		url:"/ais/introcontrol/checkcase/saveCheckCaseDetail.action",
		onSubmit:function(){
			var n = 0;
			$("input[ischeck='ischeck']").each(function(){
				if($(this).attr("checked")){
					n++;
				}
			});
			if(n==0){
				$.messager.alert("错误","请选择控制活动说明！","error");
				return false;
			}
		},
		success:function(ret){
			if(ret=='true'){
				$.messager.alert("提示","保存成功！","info");
			}else{
				$.messager.alert("错误","存在被引用的标准控制活动，保存失败！","error");
				return;
			}
		}
	});
}
function saveCheckCase(){
	$("#sccForm").form("submit",{
		url:"/ais/introcontrol/checkcase/saveCheckCase.action",
		onSubmit:function(){
			var n = 0;
			$("input[name='introControlCheckCase.projectId']").each(function(){
				if($(this).attr("checked")){
					n++;
				}
			});
			if(n==0){
				$.messager.alert("错误","请选择方案所属项目！","error");
				return false;
			}
		},
		success:function(ret){
			if(ret=='true'){
				$.messager.alert("提示","保存成功！","info");
				$("#editCheckCase").dialog("close");
				var tab = $("#tt").tabs("getSelected");
				if(tab){
					tab.panel("refresh","/ais/introcontrol/checkcase/listCheckCase.action");
					var index = $("#tt").tabs('getTabIndex',tab);
					$("#tt").tabs("select",index);
				}
			}else{
				$.messager.alert("错误","保存失败，请稍后重试！","error");
				return;
			}
		}
	});
}

function doChange(){
 	var checkText = $("#checkConclusion").find("option:selected").text();
 	var project_id = $("#projectId").val();
 	var ucId = $("#ucId").val();
 	var myFrame = document.getElementById('myFrame');
 	var g = "<iframe width=100% height=275 frameborder=0 scrolling=auto src=/ais/proledger/problem/listDigaoEditProblem.action?project_id="+project_id+"&manuscript_id="+ucId+"&manuscriptType=uc&view=add></iframe>";
 	if(checkText=='未达标'){				
		myFrame.innerHTML = g;
		$('#dgFjTr').show();
		$('#defect').show();
 	}else{
 		myFrame.innerHTML = "";
 		$('#dgFjTr').hide();
 		$('#defect').hide();
 	}
}
function checkUnderdrawingForAudit(ucId,cudId,groupId){
	var tab = $("#tt").tabs("getTab",'测试底稿');
	
	if(tab){
		//tab.panel("refresh","/ais/introcontrol/check/getCheckUnderdrawing.action?underdrawingCheck.ucId="+ucId+"&groupId="+groupId+"&checkUnderdrawing.cudId="+cudId);
		$("#tt").tabs("select",1);
	}else{
		$("#tt").tabs("add",{
			title:"测试底稿",
			closable:true,
			content:"<iframe src='/ais/introcontrol/check/getCheckUnderdrawing.action?from=audit&underdrawingCheck.ucId="+ucId+"&groupId="+groupId+"&checkUnderdrawing.cudId="+cudId+"' width='100%' height='100%'></iframe>"
		});
	} 
}
function checkPointForAudit(cpId,cpcId,ucId){
	var tab = $("#tt").tabs("getTab","测试点测试");
	if(tab){
		$("#tt").tabs("select","测试点测试");
	}else{
		$("#tt").tabs("add",{
			title:"测试点测试",
			closable:true,
			content:"<iframe src='/ais/introcontrol/check/loadCheckPoint.action?checkPoint.cpId="+cpId+"&underdrawingCheck.ucId="+ucId+"&checkPointCheck.cpcId="+cpcId+"' width='100%' height='100%'></iframe>"
		});
	} 
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