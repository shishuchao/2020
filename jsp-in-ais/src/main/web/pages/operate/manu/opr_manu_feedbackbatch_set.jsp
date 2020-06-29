<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'审计底稿反馈意见批量设置'"></s:text>
<html>
	<head>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/main/manu.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
 
	 
		<script language="javascript">
	 
		//返回上级list页面
		function backList(){
			location.href = "${contextPath}/operate/manu/feedback.action?project_id=${project_id}";
		 
		}
		//保存表单
		function saveForm(){
		
		var bool = true;//提交表单判断参数
		 	
			//完成保存表单操作
			if(checkSelect()){
			}else{
			  return false;
			}
			if(bool){
			var flag=window.confirm('确认保存吗?');//isSubmit
			if(flag==true){
			var url = "${contextPath}/operate/manu/saveFeedback.action?formId=${crudObject.formId}";
			myform.action = url;
			myform.submit();
			}else{
				 	return false;
				 }
			}
		}
		
	 
	 
	 	//输入检查	
	 	function checkSelect(){
		    var checkbox=document.getElementsByName("crudObject.formId")[0].value; 	
			    document.getElementsByName("formId")[0].value=checkbox;
			    //alert(checkbox);
			    var s =  document.getElementsByName("sdate_comment")[0].value;
			    var e =  document.getElementsByName("edate_comment")[0].value;
			    var feedback_name =  document.getElementsByName("feedback_name")[0].value;
			   if(s==""&&e==""&&feedback_name==""){
			     return true;
			   }else if(s==""){
			     alert("请输入开始时间！");
			     return false;
			   }else if(e==""){
			     alert("请输入结束时间！");
			     return false;
			   }else if(feedback_name==""){
			     alert("请输入反馈人！");
			     return false;
			   }
			   if(judgeTimeS_E(s,e)){
			      return true;
			   }else{
			     return false;
			   }
          }
          
          
    /*
	 *校验结束时间必须大于开始时间 或 结束时间必须大于延期时间
	 */
	function judgeTimeS_E(issue_start_time,issue_end_time){
		//结束时间必须大于开始时间的校验
		if(issue_start_time!=null && issue_start_time!=""
		   && issue_end_time!=null && issue_end_time!=""){
		   
		   	    var reg=new RegExp("-","g"); //创建正则RegExp对象
		        var tempBeginTime=(issue_start_time).replace(reg,"");
		        var tempEndTime=(issue_end_time).replace(reg,"");
		         
		        
		        var today   =   new   Date();    //获得当前时间
		         
		        var date=today.getDate();//格式化拼接获得正确的当前时间
		        month=today.getMonth();
		        month=month+1;
		        if(month<=9)
		        month="0"+month;
		        year=today.getYear();
		        var nowDate=year+'-'+month+'-'+date;
		        var tempDate=(nowDate).replace(reg,"");
		        var ts=tempBeginTime-0;
		        var te=tempEndTime-0;
		        var tt=tempDate-0;
		       // alert(ts+" "+te+" "+tt);
		         if(ts<tt){
		             alert("征求意见的开始时间不能小于当前时间!");
		             return false;
		        }else if(te<tt){
		             alert("征求意见的结束时间必须大于当前时间!");
		             return false;
		         }else if(ts>te){
		             alert("征求意见的开始时间必须小于征求意见的结束时间!");
		             return false;
		         }
		             return true;
		}
	             return true;
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
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<title><s:property value="#title" /></title>
		<s:head />
	</head>




	<body  >

		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" action="submit" onsubmit="return checkSelect();"
				action="saveFeedbackBatch.action" method="post">

			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<tr class="listtablehead">
					<td colspan="6" align="center" class="edithead">
						&nbsp;征求期间
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="right" width="11%" class="ListTableTr1">
						开始日期:
					</td>
					<td class="ListTableTr2" width="17%" align="left">
 
							<s:textfield id="sdate_comment" name="sdate_comment"
								readonly="true" cssStyle="width:100%" maxlength="20"
								title="单击选择日期" onclick="calendar()" theme="ufaud_simple"
								templateDir="/strutsTemplate"></s:textfield>
						 
					</td>
					<td align="right" width="11%" class="ListTableTr1">
						结束日期:
					</td>
					<td class="ListTableTr2" width="18%" align="left">
						 
							<s:textfield id="edate_comment" name="edate_comment"
								readonly="true" cssStyle="width:100%" maxlength="20"
								title="单击选择日期" onclick="calendar()" theme="ufaud_simple"
								templateDir="/strutsTemplate"></s:textfield>
					</td>

				</tr>
			</table>

			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<tr class="listtablehead">
					<td colspan="6" align="center" class="edithead">
						&nbsp;反馈人
					</td>
				</tr>

				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red>*</font> 反馈人：
					</td>
					<td class="ListTableTr22">

						<s:textfield name="feedback_name"  
							readonly="readonly" id="feedback_name" cssStyle="width:50%" />
						<s:hidden name="feedback_code" />
						<img style="cursor: hand; border: 0"
							src="/ais/resources/images/s_search.gif"
							onclick="showPopWin('/ais/pages/system/search/mutiselect.jsp?url=/ais/pages/system/morg/userindex4morg.jsp&paraname=feedback_name&paraid=feedback_code&p_issel=1',600,420)"></img>
					</td>
				</tr>
				<s:hidden name="crudObject.formId" />
				<s:hidden name="formId" />
				<s:hidden name="project_id" />
				<s:hidden name="manuIds" />
			</table>
			<div align="right">
			
			    <input type="button" value="返回" onclick="backList()" />
				&nbsp;&nbsp;
				<input type="submit" value="保存" />&nbsp;&nbsp;
				 
				&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<br>
               
			</s:form>
		</center>
	</body>
</html>
