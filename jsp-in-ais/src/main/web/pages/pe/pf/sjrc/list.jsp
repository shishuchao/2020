<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>绩效考核--审计人员</title>
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
					绩效考核-审计人员考核
				</td>
			</tr>
		</table>  -->
		 <table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
			class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					<span style="display: inline; width: 80%;float: left;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pe/pf/sjrc/listAll.action')"/>
					</span>
					<span style="float: right;"><a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a></span>
				</td>
			</tr>
		</table>
		<s:form namespace="/pe/pf/sjrc" action="listAll" onsubmit="return numberValidate_out('sjrc.name',50,'姓名')">
			<table id="searchTable" style="display: none;" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
				class="ListTable" align="center">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						考核体系
					</td>
					<TD class="listtabletr1">
						<s:select name="sjrc.peSytem_id" headerKey="" 
							headerValue="" list="psList"
							listKey="id" listValue="name" />
					</TD>
					<TD align="center" class="listtabletr1">
						考核状态
					</TD>
					<TD class="listtabletr1">
						<s:select name="sjrc.status"  list="#@java.util.LinkedHashMap@{'0':'','1':'等待考核','2':'正在考核','3':'考核完毕'}"  />
					</TD>					
				</tr>
      <s:doubleselect 
      name="sjrc.peTypeCode" emptyOption="true"  firstName="考核方式" 
      list="peTypeList"
      listKey="code" listValue="name"
     
      
      doubleName="sjrc.peRangeValue" doubleEmptyOption="true" secondName="考核周期"
      doubleList="peRangeValueMap.get(top)"
      doubleListKey="code" doubleListValue="name" 
      
      
      theme="ufaud_2" templateDir="/strutsTemplate">
     </s:doubleselect>				
								
				<tr class="listtablehead">
					<TD class=listtabletr1>
						人才类别
					</TD>
					<TD class=listtabletr1>
						<s:select name="sjrc.typeCode" headerKey="" headerValue=""
							list="basicUtil.typeList" listKey="code" listValue="name" />
					</TD>
					<TD align=center class=listtabletr1>
						姓名
					</TD>
					<TD class=listtabletr1>
						<s:textfield name="sjrc.name"></s:textfield>
					</TD>
					
				</TR>
				<tr class="listtablehead">
					<TD class=listtabletr1>
						工作部门
					</TD>
					<TD class=listtabletr1>
					<s:buttonText name="sjrc.department" 
							hiddenName="sjrc.departmentCode" 
							cssStyle="width:60%" 
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/system/uSystemAction!morgList.action&paraname=sjrc.department&paraid=sjrc.departmentCode',600,450,'组织机构选择')" 
							doubleSrc="/resources/images/s_search.gif" 
							doubleCssStyle="cursor:hand;border:0" 
						    readonly="true"
							doubleDisabled="false" />
                    </TD>
					<TD align=center class=listtabletr1>
						
					</TD>
					<TD class=listtabletr1>
						
					</TD> 
					
					
				</TR>				
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit value="查询" />
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/pe/pf/sjrc/listAll.action'" />
						</div>
					</td>
				</tr>
			</TABLE>
		</s:form>
		<s:form namespace="/pe/pf/sjrc" name="batchSaveAndStart" action="batchSaveAndStart" method="post">
			<center>
				<display:table requestURI="${contextPath}/pe/pf/sjrc/listAll.action" name="soList" id="row" class="its" pagesize="10" >
					<display:column>
						<input type="checkbox" name="ids" value="${row.id}:${row.peSytem_id}:${row.peRangeValue}">
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
					<display:column property="peTypeName" title="考核方式" headerClass="center" sortable="true" />	
					<display:column property="peRangeValue" title="考核周期" headerClass="center" sortable="true" />					
					<display:column property="name" title="姓名" headerClass="center" sortable="true"/>			
					<display:column property="type" title="人才类型" sortable="true" headerClass="center" />					
					<display:column property="sex" title="性别" sortable="true"	headerClass="center" />
					<display:column property="department" title="所属单位" headerClass="center" sortable="true" />
					<display:column property="department" title="工作部门" headerClass="center" sortable="true" />					
					<display:column property="duty" title="职务" headerClass="center" sortable="true" />		
					<display:column property="agency" title="中介机构" headerClass="center" sortable="true" />
					<display:column title="详细信息" headerClass="center" sortable="true">
					<s:a cssStyle="cursor:hand"  onclick="openWindowByUrl_common('${contextPath}/mng/employee/employeeInfoView.action?employeeInfo.id=${row.id}&listStatus=pe')"><s:div cssStyle="text-align:center; color:gray">详细信息</s:div></s:a>			
					
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
	            if(window.confirm('确定要对选择人员进行考核？')){	
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
