<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>被审计单位关联核算单位</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	</head>
	<script type="text/javascript">
	</script>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center">
			<table id="tool"></table>
			<input type="hidden" id="aoCount" value="${fn:length(aoList)}"/>
			<input type="hidden" id="projectId" value="${projectId}"/>
			<table   cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width: 15%;text-align: center;">
						被审计单位
					</td>
					<td class="EditHead" style="width: 55%;text-align: center;">
						账套列表
					</td>
					<td class="EditHead" style="width: 30%;text-align: center;">
						已选账套
					</td>
				</tr>
				<c:forEach items="${aoList}" var="ao" varStatus="st">
					<tr>
						<td class="editTd" style="width: 15%;">
							<input type="hidden" id="auditObject${st.index}" value="${ao.id}"/>
							${ao.name}
						</td>
						<td class="editTd" style="width: 55%;vertical-align: top;">
							<!--搜索区-->
							<div style="margin:10px;">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="checkAll('${st.index}')">全选</a>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="unCheckAll('${st.index}')">全不选</a>
								<input id="tb${st.index}" type="text" style="width:300px">
							</div>
							<div id="unsynced${st.index}"></div>
						</td>
						<td class="editTd" style="width: 30%;vertical-align: top;">
							<div id="synced${st.index}"></div>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
<script type="text/javascript">
	/**
	 * 获取未同步到预警系统的账套
	 * @param auditObject
	 * @param i
     */
	function loadUnSynced(auditObject,i){
		var bookCode = $('#tb'+i).textbox('getValue');
		$.ajax({
			type:'get',
			cache:false,
			url:'${contextPath}/project/prepare/accountbookUnSynced.action',
			data:{'auditObject':auditObject,'projectId':$('#projectId').val(),'accountbookCode':bookCode},
			dataType:'json',
			success:function(data){
				var list = data.accountBookAuditObjectList;
				var div = [];
				var div1 = [];
				$('#unsynced'+i).html('');
				for(var m = 0;m < list.length;m++){
					div1.push('<span id="unsyncedSpan');
					div1.push(list[m].accountbookCode);
					div1.push('"><input type="checkbox" onchange="addBookCode(\'');
					div1.push(i);
					div1.push('\',\'');
					div1.push(list[m].accountbookCode);
					div1.push('\',\'');
					div1.push(list[m].id);
					div1.push('\')" name="unsyncedCode')
					div1.push(i);
					div1.push('" id="unsyncedCheckBox');
					div1.push(list[m].accountbookCode);
					if(list[m].synced==1)
						div1.push('" checked="checked"/>');
					else
						div1.push('"/>');
					div1.push(list[m].accountbookCode);
					div1.push('</span>');
					if((m+1)%4==0||m==list.length-1){
						div.push('<div>');
						div.push(div1.join(''));
						div.push('</div>');
						$('#unsynced'+i).append(div.join(''));
						div = [];
						div1 = [];
					}
				}
			  checkAll(i);
			}
		});
	}
	/**
	 * 获取已同步到预警系统的账套
	 * @param auditObject
	 * @param i
     */
	function loadSynced(auditObject,i){
		$.ajax({
			type:'get',
			cache:false,
			url:'${contextPath}/project/prepare/accountbookSynced.action',
			data:{'auditObject':auditObject,'projectId':$('#projectId').val()},
			dataType:'json',
			success:function(data){
				var list = data.accountBookAuditObjectList;
				for(var m = 0;m < list.length;m++){
					var div1 = [];
					div1.push('<div id="syncedCode');
					div1.push(list[m].accountbookCode);
					div1.push('"><input type="hidden" name="syncedId');
					div1.push(i);
					div1.push('" value="');
					div1.push(list[m].id);
					div1.push('"/>');
					div1.push(list[m].accountbookCode);
					div1.push('<img src="${contextPath}/easyui/1.4/themes/icons/delete_small_16px.png" style="cursor:pointer;" onclick="removeBookCode(\'syncedCode');
					div1.push(list[m].accountbookCode);
					div1.push('\')"/>');
					div1.push('</div>');
					$('#synced'+i).append(div1.join(''));
				}
			}
		});
	}

	/**
	 * 左侧选中添加到已选账套
	 * @param i
	 * @param code
     * @param id
     */
	function addBookCode(i,code,id){
		var obj = $('#syncedCode'+code);
		var unsynced = $('#unsyncedCheckBox'+code);
		if(unsynced.attr('checked')){
			if(obj.length == 0){
				var div1 = [];
				div1.push('<div id="syncedCode');
				div1.push(code);
				div1.push('"><input type="hidden" name="syncedId');
				div1.push(i);
				div1.push('" value="');
				div1.push(id);
				div1.push('"/>');
				div1.push(code);
				div1.push('<img src="${contextPath}/easyui/1.4/themes/icons/delete_small_16px.png" style="cursor:pointer;" onclick="removeBookCode(\'syncedCode');
				div1.push(code);
				div1.push('\')"/>');
				div1.push('</div>');
				$('#synced'+i).append(div1.join(''));
			}
		}else{
			removeBookCode('syncedCode'+code);
		}
	}
	/**
	 * 移除右侧已选账套
	 * @param objid
     */
	function removeBookCode(objid){
		$('#'+objid).remove();
	}
	/**
	 * 全选
	 * @param i
     */
	function checkAll(i){
		$('input[name="unsyncedCode'+i+'"]').attr('checked',true);
		$('input[name="unsyncedCode'+i+'"]').trigger('change');
	}
	/**
	 * 全不选
	 * @param i
     */
	function unCheckAll(i){
		$('input[name="unsyncedCode'+i+'"]').attr('checked',false);
		$('input[name="unsyncedCode'+i+'"]').trigger('change');
	}

	/**
	 * 保存设置结果
	 */
	function saveAccountBook(){
		var aoCount = $('#aoCount').val();
		if(aoCount > 0) {
			var ids = [];
			for (var i = 0; i < aoCount; i++) {
				var books = $('input[name="syncedId'+i+'"]');
				$.each(books,function(obj,m){
					ids.push($(this).val());
				});
			}
			if(ids.length > 0){
				$.ajax({
					url:'${contextPath}/project/prepare/saveAccountBook.action',
					type:'post',
					data:{'accountBookIds':ids.join(','),'projectId':$('#projectId').val()},
					success:function(data){
						if(data=='1'){
							window.location.reload();
						}
					}
				});
			}
		}
	}

	$(document).ready(function(){
		$('#tool').datagrid({
			toolbar:[{
				text:'保存',
				iconCls:'icon-save',
				handler:function(){
					saveAccountBook();
				}
			}]
		});
		var aoCount = $('#aoCount').val();
		if(aoCount > 0){
			for(var i = 0;i < aoCount;i++){
				var auditObject = $('#auditObject'+i).val();
				$('#tb'+i).textbox({
					buttonText:'查询',
					buttonIcon:'icon-search',
					onClickButton:function(){
						loadUnSynced(auditObject,i-1);
					}
				});
				loadUnSynced(auditObject,i);
				loadSynced(auditObject,i);
			}
		}
	});
</script>
</body>
</html>