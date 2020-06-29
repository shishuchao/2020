<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>项目查询列表</title>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<SCRIPT type="text/javascript">
			
		function allcheOrcl(myform,cheOrclear)
		{		
			var ische = cheOrclear;
			for (var i=0;i<document.getElementsByName(myform).length;i++)  //用来历遍form中所有控件,
			{
				var e = document.getElementsByName(myform)[i];
				if (e.Type="checkbox")					//当是checkbox时才执行下面
				{
					if(ische==1)
					{
						if(!e.checked)						//当是checkbox未被选取时才执行下面
						{
							e.checked=true;					
						}
					}
					else if(ische==8)
					{	
						e.checked=false;
					}
					else
					{
						if(!e.checked)						//当是checkbox未被选取时才执行下面
						{
							e.checked=true;		
						}
						else
						{
							e.checked=false;
						}
								
					}
				}
			}
		}
		
 function getCheckValue(){
  var vs="";
  var arr=document.getElementsByTagName('INPUT');
	  for(var k=0;k<arr.length;k++){
	  	var check=arr[k];
	  	if(check.getAttribute('type')=='checkbox'&&check.checked){
	  		     if(vs=="")
			     	vs=check.value;
			     else
			    	 vs=vs+";"+check.value;
			     
	  	}
	  }
  
  return vs;
 }		
		</SCRIPT>
	</head>

	<body>
		<center>
			<s:form action="searchProject" namespace="/mng/audobj/doubt"
				method="post">
				<table id="planTable" cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable">
					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							项目名称
						</td>
						<td align="left" class="listtabletr1">
							<s:textfield name="crudObject.project_name" size="15" />
						</td>
						<td align="left" class="listtabletr1">
							项目年度
						</td>
						<td align="left" class="listtabletr1">
							<s:select name="crudObject.temp1"
								list="{'2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020'}"
								emptyOption="true" disabled="false" display="true" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<s:submit value="查询" />
						</td>

					</tr>

					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							开始时间
						</td>
						<td align="left" class="listtabletr1">
							<s:select list="#@java.util.LinkedHashMap@{'>':'大于','<':'小于','=':'等于'}"
								name="crudObject.start_flag"></s:select>
							<s:textfield name="crudObject.project_starttime" readonly="true"
								size="15" maxlength="20" title="单击选择日期" disabled="false"
								display="true" onclick="calendar()"></s:textfield>
						</td>
						<td align="left" class="listtabletr1">
							结束时间
						</td>
						<td align="left" class="listtabletr1" >
							<s:select list="#@java.util.LinkedHashMap@{'>':'大于','<':'小于','=':'等于'}"
								name="crudObject.end_flag"></s:select>
							<s:textfield name="crudObject.project_endtime" readonly="true"
								size="15" maxlength="20" title="单击选择日期" disabled="false"
								display="true" onclick="calendar()"></s:textfield>
						</td>
					</tr>

				</table>
			</s:form>
			
			<display:table id="row" name="projectSearchList" pagesize="10"
				class="its"
				requestURI="${contextPath}/mng/audobj/doubt/searchProject.action">
				<display:column title="选择" media="html">
					<input type="checkbox" name="crudId" value="${row.formId},${row.project_name},${row.project_starttime},${row.project_endtime}" />
				</display:column>
				<display:column title="项目名称" style="WHITE-SPACE: nowrap"
					sortable="true">
					<a
						href='<s:url action="toTabbedPanel" namespace="/project/start" includeParams="none"></s:url>?plan_id=${row.plan_form_id}&project_link_id=${row.formId}'
						target="_blank">${row.project_name}</a>
				</display:column>
				<display:column title="启动时间" property="project_starttime"
					style="WHITE-SPACE: nowrap" sortable="true"></display:column>
				<display:column title="关闭时间" property="project_endtime"
					style="WHITE-SPACE: nowrap" sortable="true"></display:column>

				<display:column title="项目状态" property="projectStatus"
					style="WHITE-SPACE: nowrap" sortable="true"></display:column>
				<display:setProperty name="paging.banner.placement" value="bottom" />
			</display:table>
			<s:if test="projectSearchList.size!=0">
				<br>
				<div align="right">
					<input type="button" name="Submit" value="全选"
						onClick="allcheOrcl('crudId',1)">
					&nbsp;
					<input type="button" name="Submit2" value="反选"
						onClick="allcheOrcl('crudId',0)">
					&nbsp;

				</div>
			</s:if>
		</center>
	</body>
</html>
