<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<title>被审计单位</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
			<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/validate.js"></script>
		<script type='text/javascript'
			src='${contextPath}/pages/mng/audobj/obj.js'></script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
			function setfmid(obj,name){
				var str;
				str=obj.options[obj.selectedIndex].text;
				$_name(name).value=str;
			}
			function Upload(name,filelist){
				var guid=document.getElementsByName(name)[0].value;
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_income_duty&table_guid=uuid&guid='+guid+'&param='+rnm+'&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
	function deleteFile(fileId,guid,isDelete,isEdit,appType){
		var layerName = document.getElementById(guid).parentElement.id;
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true)
		{
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
		{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
		xxx);
		function xxx(data){
		  	document.getElementById(this.layerName).innerHTML=data['accessoryList'];
		} 
		}
	}
		</script>
	</head>
	<body>
		<center>
			<s:form action="save" namespace="/mng/audobj/duty">
				<s:hidden name="person.nation"/>
				<s:hidden name="person.jiGuan"/>
				<s:hidden name="person.faction"/>
				<s:hidden name="person.staff"/>
				<s:hidden name="person.qualifi"/>
				<s:hidden name="person.uuid"/>
				<s:hidden name="person.fk"/>
				<s:hidden name="person.id"/>
				<table id='tab1' cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable">
					<tr>
						<td class="ListTableTr11">
							姓名
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.name"></s:textfield>
						</s:if><s:else>
							${person.name}
						</s:else>
						</td>
						<td class="ListTableTr11">
							性别
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:select list="#@java.util.LinkedHashMap@{'男':'男','女':'女'}" name="person.gender" emptyOption="true"></s:select>
						</s:if><s:else>
						${person.gender}
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							出生日期
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.birthDate" onclick="calendar()" readonly="true"></s:textfield>
						</s:if><s:else>
							${person.birthDate}
						</s:else>
						</td>
						<td class="ListTableTr11">
							民族
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:select list="basicUtil.nationList" name="person.nationCode" listKey="code" 
								onchange="setfmid(this,'person.nation');" listValue="name" emptyOption="true"></s:select>
						</s:if><s:else>
							${person.nation }
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							籍贯
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:select list="basicUtil.nativePlaceList" name="person.jiGuanCode" listKey="code" 
								onchange="setfmid(this,'person.jiGuan');" listValue="name" emptyOption="true"></s:select>
						</s:if><s:else>
						${person.jiGuan }
						</s:else>
						</td>
						<td class="ListTableTr11">
							政治面貌
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:select list="basicUtil.polityList" name="person.factionCode" listKey="code" 
								onchange="setfmid(this,'person.faction');" listValue="name" emptyOption="true"></s:select>
						</s:if><s:else>
						${person.faction}
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							职称
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:select list="basicUtil.postList" name="person.staffCode" listKey="code" 
								onchange="setfmid(this,'person.staff');" listValue="name" emptyOption="true"></s:select>
						</s:if><s:else>
						${person.staff }
						</s:else>
						</td>
						<td class="ListTableTr11">
							资格
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:select list="basicUtil.quaList" name="person.qualifiCode" listKey="code" 
								onchange="setfmid(this,'person.qualifi');" listValue="name" emptyOption="true"></s:select>
						</s:if><s:else>
						${person.qualifi }
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							工作部门
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.dept"></s:textfield>
						</s:if><s:else>
						${person.dept }
						</s:else>
						</td>
						<td class="ListTableTr11">
							职务
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.postion"></s:textfield>
						</s:if><s:else>
						${person.postion}
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							办公电话
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.phone"></s:textfield>
						</s:if><s:else>
						${person.phone}
						</s:else>
						</td>
						<td class="ListTableTr11">
							手机
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.mobile"></s:textfield>
						</s:if><s:else>
						${person.mobile}
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							电子邮箱
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.mail"></s:textfield>
						</s:if><s:else>
						${person.mail }
						</s:else>
						</td>
						<td class="ListTableTr11">
							工作状态
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:select list="#@java.util.LinkedHashMap@{'在职':'在职','离职':'离职'}" name="person.workStatus" emptyOption="true"></s:select>
						</s:if><s:else>
						${person.workStatus }
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							任职开始时间
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.startDate" onclick="calendar()" readonly="true"></s:textfield>
						</s:if><s:else>
						${person.startDate }
						</s:else>
						</td>
						<td class="ListTableTr11">
							任职结束时间
						</td>
						<td class="ListTableTr22">
						<s:if test="${empty(view)}">
							<s:textfield cssStyle="width:100%" name="person.endDate" onclick="calendar()" readonly="true"></s:textfield>
						</s:if><s:else>
						${person.endDate }
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							主要任职经历
						</td>
						<td class="ListTableTr22" colspan="3">
						<s:if test="${empty(view)}">
							<s:textarea  name="person.experience" cssStyle="width:100%;height:20;overflow-y:visible;"></s:textarea>
						</s:if><s:else>
						${person.experience}
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							经济责任描述
						</td>
						<td class="ListTableTr22" colspan="3">
						<s:if test="${empty(view)}">
							<s:textarea  name="person.describe" cssStyle="width:100%;height:20;overflow-y:visible;"></s:textarea>
						</s:if><s:else>
						${person.describe}
						</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
						<s:if test="${empty(view)}">
							<s:button onclick="Upload('person.uuid',accessoryList)" value="相关附件" ></s:button>
						</s:if><s:else>
							相关附件
						</s:else>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accessoryList" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>	
						</td>
					</tr>
				</table>
						<s:if test="${empty(view)}">
				<s:button value="保存" onclick="document.forms[0].submit();"/>
						</s:if>
				<s:button value="返回" onclick="history.back();"></s:button>
			</s:form>
		</center>
	</body>
</html>