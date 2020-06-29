<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>项目详细信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

		<script>  

			var isCheckAll = false;
			function swapCheck() {
				if (isCheckAll) {
					$("input[type='checkbox']").each(function() {
						this.checked = false;
					});
					isCheckAll = false;
				} else {
					$("input[type='checkbox']").each(function() {
						this.checked = true;
					});
					isCheckAll = true;
				}
			}

			function exportInfo() 
			{        
				var chkarr="" ;
		        var items = document.getElementsByName("category");                 
		        for (i = 0; i < items.length; i++) {                    
		            if (items[i].checked) {                        
		                //arr.push(items[i].value);   
		            	chkarr+=items[i].value+",";
		            }                
		        }                 
		        if(chkarr==""){
		        	alert('请选择再导出');
		        	return;
		        	
		        }
		        var varEmployee =$('#pro_auditleader').val();
		       // var varAudit=$('#audit_object').val();
		        window.location.href = "/ais/interact/interactProxyToWork/mutualToInformation.action?username=${user.floginname}&fpassword=${user.fpassword}&ids="+chkarr+"&strEmployee="+varEmployee;
		        
			}


</script>
	</head>
	<body>
 
	<table id="planTable" name="planTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%">
	<tr>
		<td class="editTd" style="width:3%" id="sjjg">
			<input type="checkbox" onclick="swapCheck()" />
		</td>
		<td class="editTd" style="width:35%"  colspan="2">
			<p>全选 </p>
		</td>
	</tr>
	
	<%--<tr>
		<td class="editTd" style="width:3%" id="sjjg">
			<p><input type="checkbox" name="category" value="1"  checked="checked"/> </p>
		</td>
		<td class="editTd" style="width:35%"  colspan="2">
			<p>审计机构 </p>
		</td>
	</tr>--%>
	<tr>
		<td class="editTd" style="width:3%" id="sjwtk">
			<p><input type="checkbox" name="category" value="LedgerTemplateNew" checked="checked"/> </p>
		</td>
		<td class="editTd" style="width:35%" colspan="2">
			<p>审计问题库 </p>
		</td>
	</tr>
	<tr>
		<td class="editTd" style="width:3%" id="sjjg">
			<p><input type="checkbox" name="category" value="UUser" checked="checked"/> </p>
		</td>
		<td class="EditHead"  id="zhushenTd">
	      <div style="width:80px" align="left">系统用户</div>
		</td>
		<td class="editTd" style="width:100%" id="zhushenContTd">
			<s:buttonText2 id="pro_auditleader_name" hiddenId="pro_auditleader" cssClass="noborder"
				name="crudObject.pro_auditleader_name" 
				hiddenName="crudObject.pro_auditleader"
				doubleOnclick="showSysTree(this,
				{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                      param:{
                      	'p_item':1,
                        'orgtype':1
                                  },
                       title:'请选择系统用户',
                                  type:'treeAndEmployee'
                                  
								})"  
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							maxlength="500" title="系统用户"/>
        </td>
	</tr>
	<tr>
		<td class="editTd" style="width:3%" id="sjwtk">
			<p><input type="checkbox" name="category" value="AuditMatter"  checked="checked"/> </p>
		</td>
		<td class="editTd" style="width:35%" colspan="2">
			<p>审计事项库 </p>
		</td>
	</tr>
<%-- 	<tr>
		<td class="editTd" style="width:3%" id="sjwtk">
			<p><input type="checkbox" name="category" value="AuditingObject"  checked="checked"/> </p>
		</td>
		<td class="editTd" style="width:10%" >
			<p>被审计单位 </p><!--审计对象改为被审计单位 4/23  -->
		</td>
		<td>
		<s:buttonText2 id="audit_object_name" hiddenId="audit_object" cssClass="noborder" 
							name="udit_object_name"
							hiddenName="audit_object"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
							  param:{
                                'departmentId':'${user.fdepid}'
                              },
                              cache:false,
							  checkbox:true,
							  title:'请选择被审计单位'
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
					        title="被审单位" maxlength="1500" />
		</td>
	</tr> --%>
	<tr>
		<td class="editTd" style="width:3%" id="sjwtk">
			<p><input type="checkbox" name="category" value="CodeName"  checked="checked"/> </p>
		</td>
		<td class="editTd" style="width:35%" colspan="2">
			<p>基础信息 </p>
		</td>
	</tr>
	</table>
	<div align="center">
		<s:hidden name="isOnlySave" value="no"></s:hidden>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="exportInfo()">导出</a>&nbsp;&nbsp;
	</div>
	</body>
</html>
