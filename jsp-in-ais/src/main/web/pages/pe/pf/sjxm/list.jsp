<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>绩效考核--审计项目</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/checkboxSelected.js"></script>
					<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/validateCommon.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
			
	</head>
	<body>
		<!--<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
			class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					绩效考核-审计项目考核
				</td>
			</tr>
		</table>  -->
		 <table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
			class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					<span style="display: inline; width: 80%;float: left;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pe/pf/sjxm/listAll.action')"/>
					</span>
					<span style="float: right;"><a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a></span>
				</td>
			</tr>
		</table>
		<s:form namespace="/pe/pf/sjxm" action="listAll" onsubmit="return numberValidate_out('sjxm.name',50,'项目名称')">
			<table id="searchTable" style="display: none;" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
				class="ListTable" align="center">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						考核体系
					</td>
					<TD class="listtabletr1">
						<s:select name="sjxm.peSytem_id" headerKey="" 
							headerValue="" list="psList"
							listKey="id" listValue="name" />
					</TD>
					<TD align="center" class="listtabletr1">
						考核状态
					</TD>
					<TD class="listtabletr1">
						<s:select name="sjxm.status"  list="#@java.util.LinkedHashMap@{'0':'','1':'等待考核','2':'正在考核','3':'考核完毕'}"  />
					</TD>					
				</tr>
				
								
				
				<tr class="listtablehead">
					<TD class=listtabletr1>
						项目名称
					</TD>
					<TD class=listtabletr1>
	        			<s:textfield name="sjxm.name"></s:textfield>
                    </TD>
					<TD align=center class=listtabletr1>
						考核方式
					</TD>
					<TD class=listtabletr1>
						<s:select name="sjxm.peTypeCode" headerKey=""
								headerValue="请选择考核方式" list="basicUtil.peTypeList" listKey="code"
								listValue="name" />
					</TD>					
				</TR>	
				<tr class="listtablehead">
					<TD class=listtabletr1>
						计划类别
					</TD>
					<TD class=listtabletr1>
	        				<s:select  name="sjxm.plan_type"  emptyOption="true"
							list="basicUtil.planTypeList" listKey="code" listValue="name"	
							theme="ufaud_simple"					
							templateDir="/strutsTemplate" />
                    </TD>
					<TD align=center class=listtabletr1>
						项目类别
					</TD>
					<TD class=listtabletr1>
						<s:doubleselect emptyOption="true"
							doubleList="projectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="sjxm.pro_type" list="projectTypeMap.keySet()"
							doubleName="sjxm.pro_type_child" theme="ufaud_simple"
							templateDir="/strutsTemplate"></s:doubleselect>
					</TD>					
				</TR>							
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit value="查询" />
							&nbsp;&nbsp;&nbsp;&nbsp;
														<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/pe/pf/sjxm/listAll.action'" />
						</div>
					</td>
				</tr>
			</TABLE>
		</s:form>
		<s:form namespace="/pe/pf/sjxm" name="batchSaveAndStart" action="batchSaveAndStart" method="post">
			<center>
				<display:table requestURI="${contextPath}/pe/pf/sjxm/listAll.action" name="soList" id="row" class="its" pagesize="10" >
					<display:column>
						<input type="checkbox" name="ids" value="${row.id}:${row.peSytem_id}">
						<s:hidden name="status" value="${row.status}"></s:hidden>
						<s:hidden name="name" value="${row.name}"></s:hidden>
					</display:column>
					<display:column  title="状态"headerClass="center" sortable="true" media="html" >
				           <s:if test="${row.status==1}">
				           <s:div cssStyle="text-align:center; color:green">等待考核</s:div>
				           </s:if>
				           <s:elseif test="${row.status==2}">
				           <s:div cssStyle="text-align:center;   color:red">正在考核</s:div>
				           </s:elseif>	
				           <s:elseif test="${row.status==3}">
				           <s:div cssStyle="text-align:center;   color:blue">考核完毕</s:div>
				           </s:elseif>				           			
				    </display:column>	
				    <display:column property="name" title="项目名称" headerClass="center" sortable="true"/>		
					<display:column property="peTypeName" title="考核方式" headerClass="center" sortable="true" />										
					<display:column property="plan_type_name" title="计划类别" sortable="true" headerClass="center" />		
					<display:column property="pro_type_name" title="项目类别" sortable="true" headerClass="center" />	
	                <display:column property="audit_dept_name" title="审计单位" headerClass="center" sortable="true" />
	                <display:column property="audit_object_name" title="被审计单位" headerClass="center" sortable="true" />
					<display:column property="real_start_time" title="项目开始时间" headerClass="center" sortable="true" />
			        <display:column property="real_closed_time" title="项目结束时间" headerClass="center" sortable="true" />
					<display:column title="详细信息" headerClass="center" sortable="true">
					<s:a cssStyle="cursor:hand"  onclick="openWindowByUrl_common('/ais/project/view.action?crudId=${row.id}')"><s:div cssStyle="text-align:center; color:gray">详细信息</s:div></s:a>			
			
					</display:column>
				</display:table>
				<br>
                 
			</center>
			<div align="right">
				<s:button onclick="doPe('ids')" value="考核" />
				&nbsp;&nbsp;
				<s:button onclick="selall_inform('ids')" value="全选" />
				&nbsp;&nbsp;
				<s:button onclick="selall_inform('ids',false)" value="全不选" />
				&nbsp;&nbsp;&nbsp;
			</div>
		</s:form>
		<script type="text/javascript">
    function doPe(checkboxName){
                 //alert(checkboxName);
	            if(delOrEdit(checkboxName)&&isPermit(checkboxName)){	            
	            if(window.confirm('确定要对选择项目进行考核？')){	
	               document.forms[1].submit();
	               }
	              }	                   		
           		}             		
    function isPermit(checkboxName){//是否允许处理	（删除，注销，恢复，发布） 
			 var entries=document.getElementsByName(checkboxName);
			 var names=document.getElementsByName("name");
			 var statuses=document.getElementsByName("status");
			 var str='';
			 for(var i=0;i<entries.length;i++){			 	   
			 	if(entries[i].checked==true&&statuses[i].value!='1'){			 	
			 	 str=str+':'+names[i].value;			 	
			 	}                 
              }
			 if(str!=''){			 
				 alert('所选<'+str+'>不能进行此操作！');
				 return false;			 	 		 	
			 }
			 return true;
		}		     
		</script>
	</body>
</html>
