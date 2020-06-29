<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>添加经济责任人基本信息</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>		
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
	<!-- 长度验证 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript">
	  	$(function(){
	  		$('#through').attr('maxlength',1000);
	  		$('#bewrite').attr('maxlength',3000);
	  	});
	   /*
		*   删除附件
		*/
		function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
			$.messager.confirm('确认','确认删除吗?',function(boolFlag){    
				if (boolFlag){    
					DWREngine.setAsync(false);
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
			
		function Upload(id, filelist){
			var guid = document.getElementById(id).value;
			var num = Math.random();
			var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_econduty_baseinfo&table_guid=accessory&guid=' + guid + '&deletePermission=true&isEdit=false&param=' + rnm, filelist, 'dialogWidth:700px;dialogHeight:450px;status:yes');
		}

		function save(){
			var isZG = '<s:property value="isExistZg"/>';
			var incumbency = document.getElementsByName("econDutyBaseInfo.incumbencyStateCode")[0];
			var beginDate = document.getElementsByName("econDutyBaseInfo.beginDate")[0].value;
			var endDate = document.getElementsByName("econDutyBaseInfo.endDate")[0].value;
			var mc = document.getElementsByName('econDutyBaseInfo.name')[0].value;
			var ssdw = document.getElementsByName('econDutyBaseInfo.company')[0].value;
			/* var personCode = document.getElementsByName("econDutyBaseInfo.personCode")[0].value;
			if(personCode == ''){
				alert("员工编号不能为空！");
				return false;
			} */
			//验证必填字段
			if (mc == null || mc == '') {
				showMessage1('姓名不能为空！');
				return false;
			}
			
			if (ssdw == null || ssdw == '') {
				showMessage1('所属单位不能为空！');
				return false;
			}
			/*if(incumbency.options[incumbency.selectedIndex].text!=""&&incumbency.options[incumbency.selectedIndex].text=="在岗"&&isZG=="1"){
				alert("该单位下已经有一位在岗的经济责任人了，若您要将当前人设置为在岗，请将其他人的在职状态置为离岗！")
				return false;
			}*/
			if(beginDate!=null && beginDate!='' && endDate!=null && endDate!=''){
				if(!compareDate(beginDate,endDate)){
					$.messager.show({title:'消息',msg:'任职结束日期 要大于 任职开始日期'});
					return false;
				}
			}
			document.forms[0].submit();
			showMessage1('保存成功！');
		}
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center" border="0" style="height:100%;overflow:auto;">
		<s:form action="economyDutyAction!save" namespace="/mng/economyduty" id="serchForm">
			<div style="height: 40px;">
				<div style="width: 100%;position:fixed;top:0;z-index:1" align="center" >
					<table class="ListTable" align="center" style="width: 100%;margin:0;">
						<tr class="EditHead">
							<td style="float: left">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save()">保存</a>&nbsp;&nbsp;
								<a class="easyui-linkbutton"  onclick="window.location='${contextPath}/mng/economyduty/economyDutyAction!list.action?audobjid=${audobjid}&status=${param.status}'" data-options="iconCls:'icon-undo'" >返回</a>&nbsp;&nbsp;
							</td>
						</tr>
					</table>
				</div>
			</div>
			<table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr><td nowrap class="EditHead" colspan="4" style="text-align: left"><b>经济责任人基本信息</b></td></tr>
				<tr>
					<td nowrap class="EditHead" width="15%">
						<font color=red>*</font>&nbsp;姓名
					</td>
					<td class="editTd" width="35%">
						<s:textfield cssClass="noborder" name="econDutyBaseInfo.name" size="37" maxlength="30"/>
					</td>
					<td nowrap class="EditHead">性别</td>
					<td class="editTd">
						<select class="easyui-combobox" name="econDutyBaseInfo.sex" editable="false"
								style="width:150px;">
							<option value="">&nbsp;</option>
							<s:iterator value="#@java.util.LinkedHashMap@{ '男':'男', '女':'女'}" id="entry">
								<s:if test="${econDutyBaseInfo.sex==key}">
									<option selected="selected" value="${key }">${value}</option>
								</s:if>
								<s:else>
									<option value="${key }">${value}</option>
								</s:else>
							</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">出生日期</td>
					<td class="editTd">
						<input class="easyui-datebox" name="econDutyBaseInfo.birth" title="单击选择日期" editable="false" width="150px"  />
					</td>
					<td nowrap class="EditHead">民族</td>
					<td class="editTd">
						<select  class="easyui-combobox" name="econDutyBaseInfo.nationCode" editable="false" style="width:150px;"  >
					       <option value="">&nbsp;</option>
					       <s:iterator value="basicUtil.nationList" id="entry">
					         <s:if test="${econDutyBaseInfo.nationCode==code}">
					             <option selected="selected" value="${code }">${name}</option>
					         </s:if>
					         <s:else>
					            <option value="${code }">${name}</option>
					         </s:else>
					       </s:iterator>
					    </select> 
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">籍贯</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="econDutyBaseInfo.nativePlace" maxlength="64"/>
					</td>
					<td  nowrap class="EditHead" width="10%" >政治面貌</td>
					<td class="editTd" width="35%" align="left">
						<select  class="easyui-combobox" name="econDutyBaseInfo.polityVisageCode"  editable="false" style="width:150px;"  >
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.polityVisageList" id="entry">
						         <s:if test="${econDutyBaseInfo.polityVisageCode==code}">
						             <option selected="selected" value="${code }">${name}</option>
						         </s:if>
						         <s:else>
						            <option value="${code }">${name}</option>
						         </s:else>			      
						       </s:iterator>
						    </select> 
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">职称级别</td>
					<td class="editTd">
					    <s:buttonText2 id="technicalPost" name="econDutyBaseInfo.technicalPost" 
					         hiddenId="technicalPostCode" hiddenName="econDutyBaseInfo.technicalPostCode"
					         cssClass="noborder"
							 doubleOnclick="queryData('/ais/mng/employee/quertTechnicalPost.action','职称级别',440,410,'technicalPostCode','technicalPost')"
							 doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							 doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td nowrap class="EditHead">职业资格</td>
					<td class="editTd">
					    <s:buttonText2 id="competence" name="econDutyBaseInfo.competence" 
					         hiddenId="competenceCode" hiddenName="econDutyBaseInfo.competenceCode"
					         cssClass="noborder"
							 doubleOnclick="queryData('/ais/mng/employee/queryCompetence.action','职业资格',440,410,'competenceCode','competence')"
							 doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							 doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">手机</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="econDutyBaseInfo.mobileTelephone" size="37" maxlength="20" />
					</td>
					<td class="EditHead">电子邮箱</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="econDutyBaseInfo.email" size="37" maxlength="32" />
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">任职经历<br><font color="#a9a9a9">(限1000个字)</font></td>
					<td class="editTd" colspan="3">
						<s:textarea  cssClass="noborder" name="econDutyBaseInfo.through" id="through" title="任职经历" cssStyle='width:100%;'/>
						<input type="hidden" id="econDutyBaseInfo.through.maxlength" value="1000">
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">
						<font color=red>*</font>&nbsp;所属被审计单位
					</td>
					<td class="editTd" colspan="3">
						<s:buttonText2 cssClass="noborder"
									   name="econDutyBaseInfo.company"
									   hiddenName="econDutyBaseInfo.audobjid"
									   doubleOnclick="showSysTree(this,
											{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
											  checkbox:true,
											  title:'所属单位',
											  onAfterSure:function(){
											    $('#audobjid').val('');
											    $('#company').val('');
											  }
											})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:hand;border:0"
									   cssStyle="width: 80%"
									   readonly="true"/>
						<br>
						<font color="#a9a9a9">(一人在多单位任职时，多选单位后，以上基本信息将同步至对应单位经济责任人基本信息中)</font>
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">
						最近一次审计期间结束
					</td>
					<td class="editTd" colspan="3">
						<input type="text"
							   name="econDutyBaseInfo.audit_end_time"
							   value="${econDutyBaseInfo.audit_end_time}"
							   class="easyui-datebox noborder"
							   editable="false"/>
					</td>
				</tr>

				<tr><td nowrap class="EditHead" colspan="4" style="text-align: left"><b>${econDutyBaseInfo.company}任职情况说明</b></td></tr>
				<tr>
					<td nowrap class="EditHead">在职状态</td>
					<td class="editTd">
						<select class="easyui-combobox" name="econDutyBaseInfo.incumbencyStateCode" editable="false"
								style="width:150px;">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.incumbencyStateList" id="entry">
								<s:if test="${econDutyBaseInfo.incumbencyStateCode==code}">
									<option selected="selected" value="${code }">${name}</option>
								</s:if>
								<s:else>
									<option value="${code }">${name}</option>
								</s:else>
							</s:iterator>
						</select>
					</td>
					<td nowrap class="EditHead" width="15%" nowrap="nowrap">员工编号</td>
					<td class="editTd" width="35%">
						<s:textfield cssClass="noborder" name="econDutyBaseInfo.personCode" size="37" maxlength="64"/>
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">工作部门</td>
					<td class="editTd">
						<s:textfield  cssClass="noborder" name="econDutyBaseInfo.department" size="37" maxlength="64" />
					</td>
					<td nowrap class="EditHead">职务</td>
					<td class="editTd">
						<select  class="easyui-combobox" name="econDutyBaseInfo.dutyCode" editable="false" style="width:150px;"  >
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.dutyList" id="entry">
								<s:if test="${econDutyBaseInfo.dutyCode==code}">
									<option selected="selected" value="${code }">${name}</option>
								</s:if>
								<s:else>
									<option value="${code }">${name}</option>
								</s:else>
							</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td  class="EditHead">任职开始日期</td>
					<td class="editTd">
						<input class='easyui-datebox' type="text" name="econDutyBaseInfo.beginDate"  title="单击选择日期" width="150px"  editable="false"/>
					</td>
					<td  class="EditHead">任职文件号</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="econDutyBaseInfo.beginDocNum" size="37" maxlength="64" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">任职结束日期</td>
					<td class="editTd">
						<input type="text" class="easyui-datebox" editable="false" name="econDutyBaseInfo.endDate"  title="单击选择日期" width="150px" />
					</td>
					<td  class="EditHead">离职文件号</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="econDutyBaseInfo.endDocNum" size="37" maxlength="64" />
					</td>
				</tr>
				<tr>
					<td nowrap class="EditHead">
						经济责任描述<br><font color="#a9a9a9">(限3000个字)</font>
					</td>
					<td class="editTd" colspan="3">
						<s:textarea   cssClass="noborder" name="econDutyBaseInfo.bewrite" id="bewrite" title="经济责任描述" cssStyle='width:100%;'/>
						<input type="hidden" id="econDutyBaseInfo.bewrite.maxlength" value="1000">
					</td>
				</tr>
				<tr>
					<td class="EditHead">附件
						<s:hidden name="econDutyBaseInfo.accessory" id="econDutyBaseInfo.accessory"/>
					</td>
					<td class="editTd" colspan="3">
							<div id="doubtReasionFile" class="easyui-fileUpload"
								 data-options="fileGuid:'${econDutyBaseInfo.accessory}', 
								               isAdd:true,
								               isEdit:true,
								               isDel:true,
								               isView:true,
								               isDownload:true,
								               isdebug:true,
								               spaceSumibtFiles:false" ></div>
					</td>
				</tr>
			</table>
			<s:hidden name="audobjid"/>
			<s:hidden name="status"/>
		</s:form>
	</div>
	<div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" title=""></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
			        <input type="hidden" id="para1" value="">
			        <input type="hidden" id="para2" value="">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">取消</a>
			    </div>
			</div>
		</div>
	</div>
</body>
	<script type="text/javascript">
		$("#serchForm").find("textarea").each(function(){
			autoTextarea(this);
		});
	</script>
	<script type="text/javascript">
		$(function(){
			$('#subwindow').window({
				title: 'xxx',
				width: 800,
				height:400,
				modal: false,
				closed: true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				onClose:function(){
					$('#subwindow #item_ifr').attr('src','');
				}
			});
		});
		function queryData(url,title,width,height,para1,para2){
			if($('#item_ifr').attr('title') == title){
				if($('#item_ifr').attr('src') == ''){
					$('#item_ifr').attr('src',url);
				}
			}else{
				$('#item_ifr').attr('title',title);
				$('#item_ifr').attr('src',url);
			}
			$('#para1').attr('value',para1);
			$('#para2').attr('value',para2);
			openWin('subwindow',title,width,height);
		}
		function saveF(){
			var ayy = $('#item_ifr')[0].contentWindow.saveF();
			var p1 = $('#para1').attr('value');
			var p2 = $('#para2').attr('value');
			document.all(p1).value=ayy[0];
    		document.all(p2).value=ayy[1];
    		closeWin();
		}
		function cleanF(){
			var p1 = $('#para1').attr('value');
			var p2 = $('#para2').attr('value');
			document.all(p1).value='';
    		document.all(p2).value='';
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
	</script>
</html>
