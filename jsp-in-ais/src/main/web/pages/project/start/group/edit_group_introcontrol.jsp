<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="_self">
		<title>内控项目小组</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
	</head>
	
  <body>
  	<s:form id="groupForm" action="saveGroup!introcontrolSaveGroup.action" namespace="/project"> 
  	  	<s:hidden id="projectFormId" name="projectFormId"/>
  		<s:hidden  id="groupId" name="groupId"/>
  		<s:hidden name="crudId"/>
  		<s:hidden name="group.groupType"/>
  		<s:hidden name="group.groupTypeName"/>
		<table id="projectGroupTable" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					分组名称：
				</td>
				<td class="ListTableTr22">
					<s:textfield id="groupName" name="group.groupName"
						maxlength="100" cssStyle="width:96%" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					所属片区：
				</td>
				<td class="ListTableTr22">
					<select id="area" name="group.area" onchange="doChange()">
					   <s:iterator value="#request.areaSet">
					      <option id="<s:property/>" value="<s:property/>"><s:property/></option>
					   </s:iterator>
					</select>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					被审计单位：
				</td>
				<td class="ListTableTr22">
					<s:iterator value="auditObjects" id="obj">
					    <span><input type="checkbox" ck="ck" name="<s:property value="#obj.area"/>" id="<s:property value="#obj.code"/>" value="<s:property value="#obj.code"/>"><s:property value="#obj.name"/></span>
					</s:iterator>
					<input type="hidden" id="audObj" name="group.auditObject">
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					备注说明：
				</td>
				<td class="ListTableTr22">
					<s:textfield id="description" name="group.description"
						maxlength="100" cssStyle="width:96%"/>
				</td>
			</tr>
		</table>
		
		<div align="right" style="width: 96%;">
		    <a onclick="return toSave();" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
			&nbsp;&nbsp;
			<a href="javascript:window.location.href='${contextPath}/project/listGroups!introcontrolListGroups.action?crudId=${crudId}'" class="easyui-linkbutton" data-options="iconCls:'icon-back'">取消</a>
		</div>
	</s:form>
	
	<script type="text/javascript">
	jQuery(function(){
	   //初始化selected
	   var area = '<s:property value="group.area"/>';
	   if(null != area || "" != area){ //判断是否是添加，还是修改操作
	        jQuery("#"+area).attr("selected","selected"); //设置被选中区域
	        doChange();
	   }
	   
	   
	   //初始化checkbox
	   var checkeds = '<s:property value="#request.checkeds"/>';
	   var checkedss = checkeds.split(",");
	   for(var i=0;i<checkedss.length;i++){
	      jQuery("#"+checkedss[i]).attr("checked","checked");
	   }
	   
	})
	
	function doChange(){
	     var $selected = jQuery("#area").val();
	     changeNone("none");
	     
	     var $spans = jQuery("[name='"+$selected+"']");
	     $.each($spans, function(i, n){
	           
               jQuery(n).parent().attr("style","display:black;");
         });
	}
	
	function changeNone(bl){
	   if(bl == 'none'){
	      jQuery(":checkbox").parent().attr("style","display:none;");
	   }
	   if(bl == 'black'){
	      jQuery(":checkbox").parent().attr("style","display:black;");
	   }
	   
	}
	    //判断小组名称是否存在
		function isNameAlreadyExsit(){
			var result = 'Y';
			var groupName = document.getElementById('groupName').value;
			var currentGroupId = document.getElementById('groupId').value;
			var projectId = document.getElementById('crudId').value;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/members', action:'isNameAlreadyExsit', executeResult:'false' }, 
				{'group.groupName':groupName,'group.groupId':currentGroupId,'group.proInfo.formId':projectId},
				xxx);
			function xxx(data){
				var messages = data['messages'];
				if(messages != ''){
					result = messages;
				}
			} 
			
			if(result == 'Y'){
				return true;
			}else{
				return false;
			}
		}
	
		function toSave(){
		    var chk = "";
		    $("input[ck='ck']").each(function(){
		    	if($(this).attr("checked")){
		    		chk = chk + $(this).val() + ",";
		    	}
		    });
		    var $groupName = $("#groupName").val();
		    if("" == $groupName){
		        alert("组名不能为空！");
		        return;
		    }
		    
		    if("" == chk){
		        alert("至少选择一个被审计单位！");
		        return;
		    }
		    
		    $("#audObj").val("");
		    $("#audObj").val(chk);
		    
			$("#groupForm").submit();
			
		}
	</script>
	
  </body>
</html>
