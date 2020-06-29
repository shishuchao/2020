<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'审计工作台账'"></s:text>
<html>
	<script language="javascript">

function check(){

               var v_3 = "audManuscript.dg_sjyj";  // field
	           var title_3 = '审计意见/建议';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("审计意见/建议的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }  	
	            var v_3 = "audManuscript.dg_lszg";  // field
	           var title_3 = '落实/整改情况';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("落实/整改情况的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            
	            var v_3 = "audManuscript.dg_sjyj";  // field
	           var title_3 = '未上报告初稿原因';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("未上报告初稿原因的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            
	            var v_3 = "audManuscript.cg_yuaanyin";  // field
	           var title_3 = '未上报告初稿原因';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("未上报告初稿原因的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            
	            var v_3 = "audManuscript.zq_yuaanyin";  // field
	           var title_3 = '未上征求意见稿原因';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("未上征求意见稿原因的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            
	            var v_3 = "audManuscript.fk_neirong";  // field
	           var title_3 = '反馈内容';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("反馈内容的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            
	            var v_3 = "audManuscript.zg_yuaanyin";  // field
	           var title_3 = '未上终稿原因';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("未上终稿原因的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            
	            var v_3 = "audManuscript.zg_zgjy";  // field
	           var title_3 = '整改建议';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("整改建议的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            } 
	            
	             var v_3 = "audManuscript.zg_zgjy";  // field
	           var title_3 = '整改建议';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("整改建议的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }
	            
	             var v_3 = "audManuscript.zg_zgjy";  // field
	           var title_3 = '整改建议';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("整改建议的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }
	            
	             var v_3 = "audManuscript.zg_clyj";  // field
	           var title_3 = '处理意见';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("处理意见的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }
	            
	             var v_3 = "audManuscript.zheng_zgjy";  // field
	           var title_3 = '整改建议';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("整改建议的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }
	            
	             var v_3 = "audManuscript.zheng_clyj";  // field
	           var title_3 = '处理意见';// field name
	           var notNull = 'true'; // notnull
	           var t=document.getElementsByName(v_3)[0].value;
	           if(t.length>1000){
	             showMessage1("处理意见的长度不能大于1000字！");
	             document.getElementById(v_3).focus();
	             return false;
	            }
	            
	            return true;
} 
	
	
function saveForm(){
	var url = "${contextPath}/operate/manuExt/saveManuLed.action";
 
	if(check()){
	}else{
	return false;
	}
	$.messager.confirm('提示信息','确认保存吗？',function(isSave)({
		if(isSave){
		}else{
			return false;
		}
	});
	myform.action = url;
	myform.submit();
	
}

function back(){
  window.location.href="${contextPath}/operate/manuExt/manuLed.action?project_id=${project_id}&isView=<%=request.getParameter("isView")%>";
}

</script>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<head>
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>
	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" action="saveManuLed"
				namespace="/operate/manuExt"> 
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					  <%String right=request.getParameter("isView");%>
					  <%if(!("true").equals(right)){%>
					 <tr>
					   <td class="ListTableTr11"  rowspan=3>
							工作底稿:
						</td>
						<td class="ListTableTr11"  >
							工作底稿编号:
						</td>
						<td class="ListTableTr22"  >
							<s:property value="audManuscript.ms_code" />
						</td>
						 
					</tr>
					<tr>
						<td class="ListTableTr11">
							审计意见/建议:
						</td>
						<td class="ListTableTr22">
							<s:textarea name="audManuscript.dg_sjyj"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					<tr>
					   	
						<td class="ListTableTr11">
							落实/整改情况:
						</td>
						<td class="ListTableTr22">
							<s:textarea name="audManuscript.dg_lszg"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					<tr>
					  <td class="ListTableTr11" rowspan=2>
							审计报告初稿:
						</td>
						<td class="ListTableTr11">
							是否上报告初稿:
						</td>
						<td class="ListTableTr22">
							 <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.cg_shifou" id="cg_shifou"></s:select>
						</td>
						 
					</tr>
					<tr>
						<td class="ListTableTr11">
							未上报告初稿原因:
						</td>
						<td class="ListTableTr22">
							<s:textarea name="audManuscript.cg_yuaanyin"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					
										 
					<tr>
					  <td class="ListTableTr11" rowspan=2>
							征求意见稿:
						</td>
						<td class="ListTableTr11">
							是否上征求意见稿:
						</td>
						<td class="ListTableTr22">
						    <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.zq_shifou" id="zq_shifou"></s:select>
						</td>
						 
					</tr>
			 
					<tr>
					     <td class="ListTableTr11">
							未上征求意见稿原因:
						</td>
						<td class="ListTableTr22">
						       <s:textarea name="audManuscript.zq_yuaanyin"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					 
					<tr>
					  <td class="ListTableTr11" rowspan=2>
							反馈意见:
						</td>
						<td class="ListTableTr11">
							是否反馈意见:
						</td>
						<td class="ListTableTr22">
						    <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.fk_shifou" id="fk_shifou"></s:select>
						</td>
						 
					</tr>
			 
					<tr>
					     <td class="ListTableTr11">
							反馈内容:
						</td>
						<td class="ListTableTr22">
						       <s:textarea name="audManuscript.fk_neirong"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					
					 
					<tr>
					<td class="ListTableTr11" rowspan=4>
							审计报告终稿:
						</td>
					     <td class="ListTableTr11">
							是否上报告终稿:
						</td>
						<td class="ListTableTr22">
						       <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.zg_shifou" id="zg_shifou"></s:select>
					    </td>
					</tr>
					<tr>
					     <td class="ListTableTr11">
							未上终稿原因:
						</td>
						<td class="ListTableTr22">
						<s:textarea name="audManuscript.zg_yuaanyin"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					
					<tr>
					     <td class="ListTableTr11">
							整改建议:
						</td>
						<td class="ListTableTr22">
						<s:textarea name="audManuscript.zg_zgjy"
								cssStyle="width:100%;height:50;" />
						       
					    </td>
					</tr>
					
					<tr>
					     <td class="ListTableTr11">
							处理意见:
						</td>
						<td class="ListTableTr22">
						       <s:textarea name="audManuscript.zg_clyj"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					
					 
					
					<tr>
					  <td class="ListTableTr11" rowspan=3>
							整改情况:
						</td>
						<td class="ListTableTr11">
							整改建议:
						</td>
						<td class="ListTableTr22">
						    <s:textarea name="audManuscript.zheng_zgjy"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					<tr>
					   
						<td class="ListTableTr11">
							处理意见:
						</td>
						<td class="ListTableTr22">
						    <s:textarea name="audManuscript.zheng_clyj"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
						<tr>
					   
						<td class="ListTableTr11">
							计划执行时间:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="audManuscript.zheng_date" id="zheng_date"
								readonly="true" title="单击选择日期" onclick="calendar()"
								cssStyle="width:90%" maxlength="20" />
						</td>
						 
					</tr>
					 <%}else{ %>
					 		 <tr>
					   <td class="ListTableTr11" rowspan=3>
							工作底稿:
						</td>
						<td class="ListTableTr11">
							工作底稿编号:
						</td>
						<td class="ListTableTr22">
							<s:property value="audManuscript.ms_code" />
						</td>
						 
					</tr>
					<tr>
						<td class="ListTableTr11">
							审计意见/建议:
						</td>
						<td class="ListTableTr22">
							<s:textarea name="audManuscript.dg_sjyj"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					<tr>
					   	
						<td class="ListTableTr11">
							落实/整改情况:
						</td>
						<td class="ListTableTr22">
							<s:textarea name="audManuscript.dg_lszg"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					<tr>
					  <td class="ListTableTr11" rowspan=2>
							审计报告初稿:
						</td>
						<td class="ListTableTr11">
							是否上报告初稿:
						</td>
						<td class="ListTableTr22">
							 <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.cg_shifou" id="cg_shifou"></s:select>
						</td>
						 
					</tr>
					<tr>
						<td class="ListTableTr11">
							未上报告初稿原因:
						</td>
						<td class="ListTableTr22">
							<s:textarea name="audManuscript.cg_yuaanyin"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					
										 
					<tr>
					  <td class="ListTableTr11" rowspan=2>
							征求意见稿:
						</td>
						<td class="ListTableTr11">
							是否上征求意见稿:
						</td>
						<td class="ListTableTr22">
						    <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.zq_shifou" id="zq_shifou"></s:select>
						</td>
						 
					</tr>
			 
					<tr>
					     <td class="ListTableTr11">
							未上征求意见稿原因:
						</td>
						<td class="ListTableTr22">
						       <s:textarea name="audManuscript.zq_yuaanyin"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					 
					<tr>
					  <td class="ListTableTr11" rowspan=2>
							反馈意见:
						</td>
						<td class="ListTableTr11">
							是否反馈意见:
						</td>
						<td class="ListTableTr22">
						    <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.fk_shifou" id="fk_shifou"></s:select>
						</td>
						 
					</tr>
			 
					<tr>
					     <td class="ListTableTr11">
							反馈内容:
						</td>
						<td class="ListTableTr22">
						       <s:textarea name="audManuscript.fk_neirong"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					
					 
					<tr>
					<td class="ListTableTr11" rowspan=4>
							审计报告终稿:
						</td>
					     <td class="ListTableTr11">
							是否上报告终稿:
						</td>
						<td class="ListTableTr22">
						       <s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="audManuscript.zg_shifou" id="zg_shifou"></s:select>
					    </td>
					</tr>
					<tr>
					     <td class="ListTableTr11">
							未上终稿原因:
						</td>
						<td class="ListTableTr22">
						<s:textarea name="audManuscript.zg_yuaanyin"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					
					<tr>
					     <td class="ListTableTr11">
							整改建议:
						</td>
						<td class="ListTableTr22">
						<s:textarea name="audManuscript.zg_zgjy"
								cssStyle="width:100%;height:50;" />
						       
					    </td>
					</tr>
					
					<tr>
					     <td class="ListTableTr11">
							处理意见:
						</td>
						<td class="ListTableTr22">
						       <s:textarea name="audManuscript.zg_clyj"
								cssStyle="width:100%;height:50;" />
					    </td>
					</tr>
					
					 
					
					<tr>
					  <td class="ListTableTr11" rowspan=3>
							整改情况:
						</td>
						<td class="ListTableTr11">
							整改建议:
						</td>
						<td class="ListTableTr22">
						    <s:textarea name="audManuscript.zheng_zgjy"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
					<tr>
					   
						<td class="ListTableTr11">
							处理意见:
						</td>
						<td class="ListTableTr22">
						    <s:textarea name="audManuscript.zheng_clyj"
								cssStyle="width:100%;height:50;" />
						</td>
						 
					</tr>
						<tr>
					   
						<td class="ListTableTr11">
							计划执行时间:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="audManuscript.zheng_date" id="zheng_date"
								readonly="true" title="单击选择日期" onclick="calendar()"
								cssStyle="width:90%" maxlength="20" />
						</td>
						 
					</tr>
					
					<%} %>
					
				</table>
				<s:hidden name="project_code" />
				<s:hidden name="project_id" />
				<s:hidden name="audManuscript.project_id" value="%{project_id}" />
				<s:hidden name="audManuscript.formId" />
				<s:hidden name="isView" />
				<%if(!("true").equals(right)){%>
				  <s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;<s:button value="返回" onclick="back();" />
				<%}else{%>
				    <s:button value="返回" onclick="back();" />
				<%} %>
				 
				 
			</s:form>

		</center>
	</body>
</html>
