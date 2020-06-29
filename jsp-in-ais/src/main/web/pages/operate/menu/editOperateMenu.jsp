<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<s:form action="save" namespace="/operate/menu" id="menuForm">
	<table id="toolbar"></table>
	<s:hidden name="parentId"></s:hidden>
	<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	<tr><td  class="EditHead" ><s:label>菜单编码</s:label></td><td class="editTd"><s:textfield name="operateMenu.menuId" maxlength="100" readonly="true"></s:textfield>（编码自动生成）</td></tr>
	<s:if test="${operateMenu.menuId ne '-1' }">
		<tr><td  class="EditHead" ><s:label><font color="red">*</font>&nbsp;菜单名称</s:label></td><td class="editTd"><s:textfield id="menuName" name="operateMenu.menuName" maxlength="100"></s:textfield></td></tr>
		<tr><td  class="EditHead" ><s:label><font color="red">*</font>&nbsp;排序</s:label></td><td class="editTd"><s:textfield id="orderBy" name="operateMenu.orderBy" maxlength="100"></s:textfield><font color="red">（只能输入整数）</font></td></tr>
		<tr>
			<td  class="EditHead" ><s:label>菜单链接</s:label></td>
			<td class="editTd">
				<s:textfield id="menuLink" name="operateMenu.menuLink" maxlength="400" size="70"></s:textfield>
				<s:select id="mc" onchange="changeMenuLink(this.value)" list="#request.menuForChoose" listKey="url" listValue="name" headerValue="--请选择--" headerKey=""></s:select>
				（可以选择一个预置的菜单链接，也可以手工输入）
			</td>
		</tr>
	</s:if>
	<s:else>
		<tr><td  class="EditHead" ><s:label>菜单名称</s:label></td><td class="editTd"><s:textfield name="operateMenu.menuName" maxlength="100" readonly="true"></s:textfield></td></tr>
		<tr><td  class="EditHead" ><s:label><font color="red">*</font>&nbsp;排序</s:label></td><td class="editTd"><s:textfield id="orderBy" name="operateMenu.orderBy" maxlength="100"></s:textfield><font color="red">（只能输入整数）</font></td></tr>
		<tr><td  class="EditHead" ><s:label>菜单链接</s:label></td>
			<td class="editTd">
				<s:textfield name="operateMenu.menuLink" maxlength="400" size="60" readonly="true"></s:textfield>
			</td>
		</tr>
	</s:else>
		<s:if test="${operateMenu.parent.menuId eq '-1'}">
			<tr>
				<td class="EditHead">
					<s:label>菜单图标</s:label>
				</td>
				<td class="editTd" colspan="3"><i style="font-size: 22px;" id="iconShow" class="${operateMenu.iconCls }"/>&nbsp;&nbsp;
					<a class="easyui-linkbutton" iconCls="icon-edit" onclick="showIconWin();">更换</a>
					<input type="hidden" id="menuIcons" name="operateMenu.iconCls" value="${operateMenu.iconCls }">
				</td>
			</tr>
		</s:if>
	<tr>
		<td class="EditHead">使用帮助</td>
		<td class="editTd" colspan="3">
			<textarea name="operateMenu.helpCon" id="helpCon" style="width:100%;height: 50px" class="noborder">${operateMenu.helpCon}</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="4" class="editTd">
			<p>
				<div>链接参数说明：</div>
				<div>#view#: 是否查看</div>
				<div>#projectId#: 项目主键（启动表主键）</div>
				<div>#projectCode#: 项目编码</div>
				<div>#prepareFormId#: 项目准备阶段主键</div>
				<div>#operateFormId#: 项目实施阶段主键</div>
				<div>#reportFormId#: 项目终结阶段主键</div>
				<div>#prepareAudAdviceFormId#: 审计通知书主键</div>
				<div>#projectType#: 项目类型</div>
				<div>#auditObject#: 被审计单位</div>
				<div>#auditStartTime#: 审计开始时间</div>
				<div>#auditEndTime#: 审计结束时间</div>
			</p>
		</td>
	</tr>
	</table>
	<s:if test="${add != 'yes'}">
		<div id="tools">
			<s:if test="${not empty operateMenu.menuId }">
				<a id="addBtn" iconCls="icon-add" onclick="addOperateMenu('${operateMenu.menuId }');">增加</a>&nbsp;&nbsp;
			</s:if>
			<s:if test="${operateMenu.menuId ne '-1' }">
				<a id="saveBtn" iconCls="icon-save" onclick="saveOperateMenu();">保存</a>&nbsp;&nbsp;
				<s:if test="${not empty operateMenu.menuId }">
					<a id="delBtn" iconCls="icon-delete" onclick="deleteOperateMenu('${operateMenu.menuId }','${hasChild}')">删除</a>
				</s:if>
			</s:if>
		</div>
	</s:if>
	<s:else>
		<div id="addtool">
			<s:if test="${operateMenu.menuId ne '-1' }">
				<a id="saveBtn" iconCls="icon-save" onclick="saveOperateMenu();">保存</a>&nbsp;&nbsp;
				<a id="backBtn" iconCls="icon-back" onclick="backOperateMenu('${operateMenu.menuId }');">返回</a>&nbsp;&nbsp;
			</s:if>			
		</div>
	</s:else>
</s:form>