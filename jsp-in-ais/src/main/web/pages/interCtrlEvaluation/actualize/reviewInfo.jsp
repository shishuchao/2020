<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<title>内控评价-底稿-流转信息</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){	
	var preStepIsPass = "${preStepIsPass}";	
	if("${errMsg}"){		
		top.$.messager.alert('提示信息', "${errMsg}", 'error', function(){
			aud$closeTab();
		});
		setTimeout(aud$closeTab,0);
		return;	
	}	
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';
	
	isView ?  $('.editElement, #rvSaveBtn').remove() : $('.viewElement').remove();
	//复核意见：通过、不通过
	$('input:radio[name="rvAdviceRadio"]').bind('click', function(){		
		$('#rv_rvAdvice').val($(this).attr('mc'));
		$('#rv_rvAdviceCode').val($(this).val());	
		var idArr = [], nameArr = [];
		if(this.value == '0'){//不通过的话还原上一步处理人
			$("input[name='rvLevelChk']").removeAttr('checked').attr('disabled','disabled');
			$('#rv_nextRvPersonId').removeData('idArr').removeData('nameArr');
			$('#rvLevelSelectTitle').hide();
			$('#rv_rvLevel').val(rvLevels[curMinRvLevelIndex]);
			$('#rv_rvLevelCode').val(rvLevelCodes[curMinRvLevelIndex]);
			$('#rv_rvLevelName').val(rvLevelNames[curMinRvLevelIndex]);
			$('#rv_rvExplain').val("不通过");
			$('#rv_rvEnd').val(0);
			//审核不同意时，查询上次审核通过的时的处理人员
			var personData = genPreviousPersonSelect(rvinfoMaxRvLevel);
			if(personData){
				//alert(personData.rvPerson)
				idArr.push(personData.rvPersonId);
				nameArr.push(personData.rvPerson);
			}else{
				nameArr.push("${rv.preRvPerson}");
				idArr.push("${rv.preRvPersonId}");	
			}
			if(rvinfoMaxRvLevel == '0'){
				$('#isDraftPostFallback').val(true);
			}
		}else{
			$('#isDraftPostFallback').val(false);
			$("input[name='rvLevelChk']").removeAttr('disabled');
			$('#rvLevelSelectTitle').show();
			$('#rv_rvLevel,#rv_rvLevelCode,#rv_rvLevelName').val('');
			$('#rv_rvExplain').val("通过");
		}
		//alert(idArr +"\n"+ nameArr)
		//生成下一步处理人select
		genSelectOptions("rv_nextRvPersonId", idArr, nameArr);
	});
	
	$('#rv_rvAdvice').val("通过");
	$('#rv_rvAdviceCode').val("1");
	
	$('#rvSaveBtn').bind('click', function(){
		 var batchPost = $('#batchPost').val();
		 //alert('batchPost='+batchPost)
		 if(batchPost && batchPost == '1'){			 
			 var parentWin = aud$parentDialogWin();
		     if(parentWin){	    	 
				 var batchMauIds = parentWin.aud$getCheckRows();
				 if(batchMauIds && batchMauIds.length){			 
					 $('#batchMauIds').val(batchMauIds.join(','));	
				   	 aud$saveForm('reviewForm', "${contextPath}/intctet/evaluationActualize/saveReview.action", function(data){
						 if(data){
							 data.msg ? showMessage1(data.msg) : null;	
							 if(data.type == 'info'){
								 //刷新底稿复核表格
								 var tabWin = aud$parentDialogWin();
								 //alert(tabWin.aud$manuGrid.refresh)
								 tabWin && tabWin.aud$manuGrid ? tabWin.refresh() : null;
								 //关闭当前的窗口
								 $('#rvCloseBtn').trigger('click');
							 }
						 }
					 });
				 }else{
					 showMessage1("请选择要复核的记录!");
					 $('#closeBtn').trigger('click');
				 }
		     }else{
				 showMessage1("无法获得父窗口或者页签对象");
				 $('#closeBtn').trigger('click');
		     }
		 }

	});
	
	$('#rvCloseBtn').bind('click', function(){
		aud$closeTopDialog();
	});

	var mrCodes = "${mrCodes}";
	var mrNames = "${mrNames}";
	var mrlLevels = "${mrlLevels}";
	var maxRvLevel = "${maxRvLevel}";
	var rvLevelNames = mrNames.split(",");
	var rvLevelCodes = mrCodes.split(",");
	var rvLevels     = mrlLevels.split(",");
	//alert(rvLevelNames+"\n"+rvLevelCodes+"\n"+rvLevels+"\n"+maxRvLevel);
	var rvLevelSelect = $('#rvLevelSelect').get(0);
	var curMaxRvLevel  = "", curMinRvLevel = "", curMinRvLevelIndex = "";
	var rvinfoMaxRvLevel = maxRvLevel;
	//alert('preStepIsPass='+preStepIsPass+"\nrvinfoMaxRvLevel="+rvinfoMaxRvLevel)
	if(!preStepIsPass || !(preStepIsPass == true || preStepIsPass == 'true')){
		rvinfoMaxRvLevel = rvinfoMaxRvLevel - 1;
	}
	//alert('preStepIsPass='+preStepIsPass+"\nrvinfoMaxRvLevel="+rvinfoMaxRvLevel)
	$.each(rvLevelNames, function(i, rvLevelName){		
		var rvLevel = rvLevels[i];
		if(rvLevel > rvinfoMaxRvLevel){
			if(curMinRvLevel == ""){				
				curMinRvLevel = rvLevel;
				curMaxRvLevel = rvLevel;
				curMinRvLevelIndex = i;
			}
			var wrap = $("<label></labe>").appendTo(rvLevelSelect);
			$("<input type='checkbox' name='rvLevelChk' value='"+rvLevelCodes[i]+"' level='"+rvLevel+"' levelName='"+rvLevelNames[i]+"'/>").appendTo(wrap[0])
			.bind('click', function(){
				changeLevel(this);
			});
			$("<label'></label>").text(rvLevelName+" ").appendTo(wrap[0]);
			if(rvLevel < curMinRvLevel){//找出层级的最小值
				curMinRvLevel = rvLevel;
				curMinRvLevelIndex = i;
			}
			if(rvLevel > curMaxRvLevel){//找出层级的最大值
				curMaxRvLevel = rvLevel;
			}
		}
	});
	//alert('curMinRvLevel='+curMinRvLevel)
	
	//复核级次选择时触发
	function changeLevel(target){
		try{
			//找到level值最大的复选框
			var inputChks = $("#rvLevelSelect input:checkbox:checked");
			//alert(inputChks.length)
			if(inputChks.length == 0){
				$('#rv_rvLevelName').val("");
				$('#rv_rvLevelCode').val("");
				$('#rv_rvLevel').val("");
				$('#rv_nextRvPerson').val("");
				$('#rv_nextRvPersonId').empty();
				$('#rv_nextRvPersonId').removeData('nameArr');
				$('#rv_nextRvPersonId').removeData('idArr');
			}else{		
				//把级次值小于当前选中复选框级次的其它复选框选中， 如：选择了三级复核，则一级复核、二级复核也选中
				if($(target).attr('checked')){
					var tlevel = $(target).attr('level');
					$("#rvLevelSelect input:checkbox").each(function(i, obj){
						var level = $(obj).attr('level');
						if(level < tlevel){
							$(obj).attr('checked', true);
						}
					});
				}
				//重新计算选中的复选框
				inputChks = $("#rvLevelSelect input:checkbox:checked");
				//alert(inputChks.length)
				var curMaxRvLevel = rvLevels[rvLevels.length-1];
				//循环选中的层级复选框，找到层级最大的那个，更新复核状态
				inputChks.each(function(i, obj){
					var tlevel = $('#rv_rvLevel').val();		
					var level = $(obj).attr('level');
					var levelCode = obj.value;
					var levelName = $(obj).attr('levelName');
					//根据选择的层级，更新复核状态
					if(i == 0){
						$('#rv_rvLevelName').val(levelName);
						$('#rv_rvLevelCode').val(levelCode);
						$('#rv_rvLevel').val(level);
						return true;
					}					
					if(level > tlevel){//和上一次的值比较
						$('#rv_rvLevelName').val(levelName);
						$('#rv_rvLevelCode').val(levelCode);
						$('#rv_rvLevel').val(level);
					}
				});
				//产生下一步处理人
				//alert($('#rv_rvEnd').val())
				genNextPersonSelect("${rv.projectId}", "${groupId}", $('#rv_rvLevel').val());
			}			
		}catch(e){
			alert('changeLevel:\n'+e.message);
		}
	}
	
	//生成下一步选人select
	function genNextPersonSelect(projectId, groupId, curMrLevel){
		try{
			$.ajax({
				url : "${contextPath}/intctet/evaluationActualize/queryRvPersons.action",
				dataType:'json',
				type:"post",
				data:{
					'projectId':projectId,
					'groupId'  :groupId,
					'curMrLevel':curMrLevel
				},
				beforeSend:function(){
					return true;
				},
				success: function(data){ 
					if(data.type == 'info'){
						//判断是否复核结束
						var isEnd = data.isEnd;
						if(isEnd && (isEnd == true || isEnd == '') ){
							$('#rv_rvEnd').val(1);
							$('#rv_nextRvPersonId').empty();
							//$('#rv_nextRvPersonId').removeData('nameArr');
							//$('#rv_nextRvPersonId').removeData('idArr');
							$('#rv_nextRvPerson, #rv_nextRvPersonId').val('').removeClass('required');
							$('#rv_nextRvPersonId').hide();
						}else{
							$('#rv_rvEnd').val(0);
							$('#rv_nextRvPersonId').show();
							$('#rv_nextRvPerson, #rv_nextRvPersonId').val('').addClass('required');
							var memName = data.memName;
							var memId = data.memId;
							//alert(memName+"\n"+memId);
							var selectData = [];
							if(memName && memId){
								var nameArr = memName.split(",");
								var idArr   = memId.split(",");
								$('#rv_nextRvPersonId').data('nameArr', nameArr);
								$('#rv_nextRvPersonId').data('idArr', idArr);
								genSelectOptions("rv_nextRvPersonId", idArr, nameArr);
							}else{
								$('#rv_nextRvPersonId').empty();
								$('#rv_nextRvPersonId').removeData('nameArr');
								$('#rv_nextRvPersonId').removeData('idArr');
							}						
						}
					}
				},
				error:function(data){
					aud$loadClose();
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
		}catch(e){
			alert("queryRvPersons:\n"+e.message);
		}
	}
	
	//审核不同意时，查询上次审核通过的时的处理人员
	function genPreviousPersonSelect(rvLevel){
		try{
			var rvPerson = "";
			var rvPersonId = "";
			$.ajax({
				url : "${contextPath}/intctet/evaluationActualize/queryRvPrePerson.action",
				dataType:'json',
				type:"post",
				async:false,
				data:{
					'projectId':"${rv.projectId}",
					'manuId'  :"${manu.manuId}",
					'rvLevel':rvLevel
				},
				success: function(data){ 
					if(data.type == 'info'){
						rvPerson = data.rvPerson;
						rvPersonId = data.rvPersonId;
					}
				},
				error:function(data){
					aud$loadClose();
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
			return {
				'rvPerson':rvPerson,
				'rvPersonId':rvPersonId
			};
		}catch(e){
			alert("genPreviousPersonSelect:\n"+e.message);
		}
	}
	
	//生成下一步处理人select
	function genSelectOptions(targetId, idArr, nameArr){
		$('#'+targetId).empty();
		if(!idArr || !nameArr){
			idArr = $('#'+targetId).data('idArr');
			nameArr = $('#'+targetId).data('nameArr');
		}
		//alert('genSelectOptions:\n'+idArr+"\n"+nameArr);
		if(idArr && nameArr){			
			$.each(nameArr, function(i, name){
				$('#'+targetId).append("<option value='"+idArr[i]+"'>"+name+"</option>");								
			});
			$('#'+targetId).show().trigger('change');
		}
	}
	
	$('#rv_nextRvPersonId').bind('change', function(){
		$('#rv_nextRvPerson').val($(this).find('option:selected').text());
	});
	


});
</script>
</head>
<body style='margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true' >
	<div style="overflow:hidden;position:absolute;top:2px;right:5px;z-index:99999;" >	
		<a id='rvSaveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
			<a id='rvCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
	</div>	
	<div region='center' border='0' style='padding:0px;overflow:hidden;'>
		<div class="easyui-tabs" fit='true' style='padding:0px;overflow:hidden;' border='0'>
			<div title='复核信息' style='padding:0px;overflow:hidden;' border='0'>
				<form id="reviewForm" name="reviewForm">
					<input type="hidden" id="rv_rvEnd" name="rvEnd" value="0"/>
					<input type="hidden" id="rv_rvId"  name="rv.rvId" value="${rv.rvId}"/>
					<input type="hidden" id="rv_projectId" name="rv.projectId" value="${rv.projectId}"/> 
					<input type="hidden" id="rv_manuId"    name="rv.manuId" value="${rv.manuId}"/>
					<input type="hidden" id='batchPost'    name='batchPost' value='${batchPost}'/>
					<input type="hidden" id='batchMauIds'  name='batchMauIds' value=''/>
					<input type="hidden" id="isDraftPostFallback" name="isDraftPostFallback"/>
					<table class="ListTable" align="center" style='table-layout:fixed;'>
						<tr>
							<td class="EditHead" style="width:25%;" nowrap><font class='editElement' color='red'>*</font>复核意见</td>
							<td class="editTd"   colSpan="3">
								<div>						
									<label><input type='radio' name='rvAdviceRadio' value="1"  mc="通过" checked />通过</label>
									<label><input type='radio' name='rvAdviceRadio' value="0"  mc="不通过"/>不通过</label>
								</div>
								<input type='hidden' id='rv_rvAdvice' name='rv.rvAdvice' value="${rv.rvAdvice}"
								 title="复核意见" class="noborder editElement clear required" />
								<input type='hidden' id='rv_rvAdviceCode' name='rv.rvAdviceCode' value="${rv.rvAdviceCode}"
								 title="复核意见Code" class="noborder editElement clear required" />
								<span id='view_rvAdvice' class="noborder viewElement clear" >${rv.rvAdvice}</span>
							</td>
						</tr>
						<tr id='rvLevelTr'>
							<td class="EditHead"  nowrap><font id='rvLevelSelectTitle' class='editElement' color='red'>*</font>复核级次</td>
							<td class="editTd"   colSpan="3"">
								<div id="rvLevelSelect"></div>
							</td>
						</tr>
						<tr>
							<td class="EditHead"  nowrap>复核状态</td>
							<td class="editTd"   colSpan="3">
								<input type='hidden' id='rv_rvLevel' name='rv.rvLevel' value="${rv.rvLevel}"
								 title="复核级次" class="noborder editElement clear required" />
								<input type='hidden' id='rv_rvLevelCode' name='rv.rvLevelCode' value="${rv.rvLevelCode}"
								 title="复核级次Code" class="noborder editElement clear required" />
								<input type='hidden' id='rv_rvLevelName' name='rv.rvLevelName' value="${rv.rvLevelName}"
								 title="复核级次名字" class="noborder editElement clear required" />
								<span id='view_rvLevelName' class="noborder  clear" >${rv.rvLevelName}${rv.rvAdvice}</span>
							</td>
						</tr>
						<tr>
							<td class="EditHead"  nowrap>
								<font id='rv_nextRvPersonTitle' class='editElement' color='red'>*</font>下一步处理人</td>
							<td class="editTd" colSpan='3'>
								<select title='下一步处理人' id='rv_nextRvPersonId' name='rv.nextRvPersonId' 
								style='background: transparent;border: 1px solid #ccc;' 
								class="noborder editElement clear required">
								</select>
								<input type='hidden' id='rv_nextRvPerson' name='rv.nextRvPerson' value="${rv.nextRvPerson}"
								 title="下一步处理人" class="noborder editElement clear required" />
							</td>
						</tr>
						<tr>
							<td class="EditHead"  nowrap>上一步处理人</td>
							<td class="editTd" colSpan='3'>
								<input type='hidden' id="rv_preRvPerson"   name="rv.preRvPerson"   value="${rv.preRvPerson}"/>
								<input type='hidden' id="rv_preRvPersonId" name="rv.preRvPersonId" value="${rv.preRvPersonId}"/>
								<input type='hidden' id="rv_preRvDate"     name="rv.preRvDate"     value="${rv.preRvDate}"/>				
								<span  class="noborder">${rv.preRvPerson}</span>
							</td>
						</tr>
						<tr>
							<td class="EditHead"  nowrap>意见说明</br>
								<font class='editElement' color='red'>（100字以内）</font>
							</td>
							<td class="editTd"   colSpan="3">
								<textarea  title="意见说明" id='rv_rvExplain' name='rv.rvExplain' 
								class="noborder editElement clear  len100" 
								style='border-width:0px;height:100px;width:100%;overflow:auto;padding:5px;'>${rv.rvExplain}</textarea>
							</td>
						</tr>
						<tr>
							<td class="EditHead"  nowrap>复核人</td>
							<td class="editTd"   style="width:35%;">
								<input type="hidden" id="rv_rvPersonId" name="rv.rvPersonId" value="${rv.rvPersonId}" readonly/>
								<input type="hidden" id="rv_rvPerson"   name="rv.rvPerson"   value="${rv.rvPerson}" readonly/>
								<span  class="noborder">${rv.rvPerson}</span>
							</td>
							<td class="EditHead"  nowrap>复核时间</td>
							<td class="editTd"   style="width:35%;">
								<span  class="noborder">${rv.rvDate}</span>
							</td>
						</tr>
					</table>
				</form>			
			</div>
			<div title='流转信息' style='padding:0px;overflow:hidden;' border='0'>
				<!-- 底稿提交流转信息 -->
				<jsp:include flush="true" page="/pages/interCtrlEvaluation/actualize/showReviewInfoList.jsp" />
			</div>
		</div>
	</div>
</body>
</html>