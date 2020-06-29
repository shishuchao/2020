<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>定稿问题查看</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript">
		  //把引用的底稿或者疑点渲染为链接，点击引用底稿的名称
		function manu(){
          var code3=document.getElementsByName("middleLedgerProblem.linkManuName")[0].value; 
        
          var code4=document.getElementsByName("middleLedgerProblem.linkManuId")[0].value; 
      	
          var codeArray3=code3.split(',');
          var codeArray4=code4.split(',');
          //alert(codeArray3[0]);
          var tt1='';
          var tt2='';
          var tt3='';
          var tt4='';
          var tt5='';
          var strName1='引用备忘';
          var strName2='引用疑点';
          var strName4='引用重大事项';
          var strName3='引用发现';
          var strName5='引用底稿';
          if(codeArray3!=null)
          {
            for(var a=0;a<codeArray4.length;a++){
             if(codeArray4[a]!=null&&codeArray4[a]!='')
             {
              if(tt3=='')
              {
               tt3='<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
              }else{
              tt3=tt3+'&nbsp;&nbsp;<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
              }
             }
            }
           p2.innerHTML= tt3 ;
         }

       }
		 //查看底稿
	    function go1(s){
	    	var openViewUrl = "${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${project_id}";
            $('#openViewManu').attr("src",openViewUrl);
            $('#viewManu').window('open');
	    	//window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	    }
	 	// 初始化
		$(function(){
			$('#viewManu').window({
	            width:880, 
	            height:380,  
	            modal:true,
	            collapsible:false,
	            maximizable:true,
	            minimizable:false,
	            closed:true    
	        });
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
		</script>
	</head>
<body onload="doProblemComment('${middleLedgerProblem.problem_name}');manu();" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">

	<div region="center">
		<s:form id="myform" action="save" namespace="/proledger/problem">
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1">
				<tr>
					<td class="EditHead" style="width: 15%">问题类别</td>
					<td class="editTd" style="width: 35%">
						<%-- <s:textfield id="problem_all_name" name="middleLedgerProblem.problem_all_name" cssStyle="width:70%" readonly="true" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT> --%>
						<s:property value="middleLedgerProblem.problem_all_name" />
						<s:hidden id="sort_big_code" name="middleLedgerProblem.sort_big_code" />
						<s:hidden id="sort_big_name" name="middleLedgerProblem.sort_big_name" />
						<s:hidden id="sort_small_code" name="middleLedgerProblem.sort_small_code" />
						<s:hidden id="sort_small_name" name="middleLedgerProblem.sort_small_name" />
						<s:hidden id="sort_three_code" name="middleLedgerProblem.sort_three_code" />
						<s:hidden id="sort_three_name" name="middleLedgerProblem.sort_three_name" />
					</td>
					<td class="EditHead" style="width: 15%">审计问题编号</td>
					<td class="editTd" style="width: 35%">
						<%-- <s:textfield name="middleLedgerProblem.serial_num" cssStyle="width:75%" readonly="true" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT> --%>
						<s:property value="middleLedgerProblem.serial_num" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题标题</td>
					<td class="editTd">
						<%-- <s:textarea cssClass='noborder' name="middleLedgerProblem.audit_con" title="问题标题" readonly="true"
							cssStyle="width:100%;height:200px" /> --%>
						<s:property value="middleLedgerProblem.audit_con" />
						<%-- <textarea class='noborder'  name="middleLedgerProblem.audit_con" title="问题标题" readonly="readonly"
								style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_con}</textarea>	 --%>
					</td>
					<td class="EditHead">被审计单位</td>
					<td>
						<%-- <s:textfield name="middleLedgerProblem.audit_object_name" cssStyle='width:260px' readonly="true" /> --%>
						<s:property value="middleLedgerProblem.audit_object_name" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题点</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.problem_name" id="problem_name" cssStyle="width:70%" readonly="true"/> --%> 
						<s:property value="middleLedgerProblem.problem_name" />
						<s:hidden name="middleLedgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
					</td>
					<td class="EditHead" id="problemCommentText">备注（问题点为其他）</td>
					<td class="editTd">
						<%-- <s:textarea name="middleLedgerProblem.problemComment" id="problemComment" readonly="true" cssStyle="width:74%;height:30px;display:none" /> --%>
						<s:property value="middleLedgerProblem.problemComment" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">涉及金额</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.problem_money" id="problem_money" readonly="true" cssStyle="width:70%" doubles="true" maxlength="15" />&nbsp;万元 --%>
						<%-- <s:property value="middleLedgerProblem.problem_money" /> --%>
						<fmt:formatNumber value="${middleLedgerProblem.problem_money}" pattern="############.##"  minFractionDigits="2"></fmt:formatNumber>&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.problemCount" id="problemCount" readonly="true" cssStyle="width:74%" doubles="true" maxlength="5" />&nbsp;个 --%>
						<s:property value="middleLedgerProblem.problemCount" />&nbsp;个
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计发现类型</td>
					<td class="editTd">
						<%-- <s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" name="middleLedgerProblem.problem_grade_code"></s:select> --%>
						<s:property value="middleLedgerProblem.problem_grade_name" />
					</td>
					<td class="EditHead">重要程度</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.ofsDetail"/>
					</td>
				</tr>
				<tr>
					<s:if test="middleLedgerProblem.pro_type == '020312'">
						<td class="EditHead">责任<div>(经济责任审计)</div></td>
						<td class="editTd">
							<%-- <s:select  name="middleLedgerProblem.zeren" disabled="true" list="#@java.util.LinkedHashMap@{'领导责任':'领导责任','主管责任':'主管责任','直接责任':'直接责任'}" listValue="value" listKey="key"  emptyOption="true"></s:select> --%>
							<s:property value="middleLedgerProblem.zeren" />
						</td>
					</s:if>
					<s:else>
						<td class="EditHead">责任<div>(非经济责任审计)</div></td>
						<td class="editTd">
							<%-- <s:select  name="middleLedgerProblem.zeren" disabled="true" list="#@java.util.LinkedHashMap@{'领导违规':'领导违规','损失浪费':'损失浪费','管理不规范':'管理不规范'}" listValue="value" listKey="key"  emptyOption="true"></s:select> --%>
							<s:property value="middleLedgerProblem.zeren" />
						</td>
					</s:else>
					<td class="EditHead">问题发现日期</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_date"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">是否采纳审计意见</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.sfcnsjyj" />
					</td>
					<td class="EditHead">关联底稿</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.linkManuName"/>
						<s:hidden name="middleLedgerProblem.linkManuName"></s:hidden>
						<s:hidden name="middleLedgerProblem.linkManuId" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">违规违纪类型</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.wgwjlxName" />
					</td>
					<td class="EditHead">违规违纪金额</td>
					<td class="editTd">
						<fmt:formatNumber value="${middleLedgerProblem.wgwjje}" pattern="###.############"/>&nbsp;万元
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题摘要</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='noborder' name="middleLedgerProblem.describe" title="问题摘要" readonly="true"
							cssStyle="width:100%;height:200px"  /> --%>
						<%-- <s:property value="middleLedgerProblem.describe" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.describe" title="问题摘要" readonly="readonly"
								style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">定性依据</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea name="middleLedgerProblem.audit_law" title="定性依据" id="audit_law" cssClass='noborder' readonly="true" cssStyle="width:100%;height:200px" /> --%>
						<%-- <s:property value="middleLedgerProblem.audit_law" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.audit_law" title="定性依据" readonly="readonly"
								style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计建议</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea name="middleLedgerProblem.audit_advice" title="处理决定" id="audit_advice" cssClass='noborder' readonly="true" cssStyle="width:100%;height:200px" /> --%>
						<%-- <s:property value="middleLedgerProblem.audit_advice" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.audit_advice" title="审计建议" readonly="readonly"
								style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
					</td>
				</tr>
				
		<%-- 		<tr>
					<td class="EditHead"><FONT color=red>*</FONT>是否可量化</td>
					<td class="editTd" colspan="3">
						<s:select  name="middleLedgerProblem.quantify" id="quantify" disabled="true" list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" listValue="value" listKey="key" />
						<s:property value="middleLedgerProblem.quantify" />
					</td>
				</tr> --%>
				
				<%-- <tr>
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<s:textfield name="middleLedgerProblem.creater_startdate" id="creater_startdate" readonly="true"  cssStyle="width:70%" maxlength="20" />
						<s:property value="middleLedgerProblem.creater_startdate" />
					</td>
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<s:textfield name="middleLedgerProblem.creater_enddate" id="creater_enddate" readonly="true"  cssStyle="width:74%" maxlength="20" />
						<s:property value="middleLedgerProblem.creater_enddate" />
					</td>
				</tr> --%>
				<%-- <tr>
					<td class="EditHead">
						关联底稿
					</td>
					<td>
						<s:textfield name="middleLedgerProblem.linkManuName"  cssStyle='width:260px' readonly="true" />
						<!--一般文本框-->
						<span id="p2"></span>
						<s:hidden name="middleLedgerProblem.linkManuId" />
						<s:hidden name="middleLedgerProblem.linkManuName"></s:hidden>
					</td>
				</tr>	 --%>									
			</table>			
			
			<s:hidden name="project_id" />
			<s:hidden name="manuscript_id" />
			<s:hidden name="manuscriptType" />
			<s:hidden name="middleLedgerProblem.project_id" value="${project_id}" />
			<s:hidden name="middleLedgerProblem.manuscript_id" value="${manuscript_id}" />
			<s:hidden name="middleLedgerProblem.id" />
			<s:hidden name="tableType" />
			<input type="hidden" id="att" name="att" value="">
			<input type="hidden" id="att2" name="att2" value="">
		</s:form>

	</div>
	<div id="viewManu" title="审计底稿查看" style="overflow:hidden;padding:0px">
    	<iframe id="openViewManu" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
  	</div>
	<script language="javascript">
		function triggerTab(tab) {
			var isDisplay = document.getElementById(tab).style.display;
			if (isDisplay == '') {
				document.getElementById(tab).style.display = 'none';
			} else {
				document.getElementById(tab).style.display = '';
			}
		}
	
			


		//获取定性依据
		function getGist(problemCode) {
			$.ajax({
				type : "POST",
				url : "${contextPath}/proledger/problem/saveOprateTask!getGist.action",
				data : {
					"problemCode" : problemCode
				},
				success : function(msg) {
					if (msg != "") {
						$("#problem_desc").val(msg);
					}
				}
			});
		}
		
		//是否允许填写“备注”
		 function doProblemComment(problem_name){
			 if(problem_name == '其他'){
				 $("#problemComment").css("display","block");
				 $("#problemCommentText").append("<FONT color=red>*</FONT>");
			 }else{
				 $("#problemComment").val("");
				 $("#problemComment").css("display","none");
				 $("#problemCommentText").html("").html("备注（问题点为其他）:");
			 }
		 }

		/**
		 取得数量单位的下拉菜单
		 **/
		function problemUnitList(problemCode, problemUnitCode) {
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);
			DWRActionUtil.execute({
				namespace : '/proledger/problem',
				action : 'problemUnitList',
				executeResult : 'false'
			}, {
				'problemCode' : problemCode,
				'problemUnitCode' : problemUnitCode
			}, xxx);
			function xxx(data) {
				problemUnitSelect = data['problemUnitSelect'];
				if (problemUnitSelect == null) {
					problemUnitSelect = '';
				}
				document.getElementById('unitsDiv').innerHTML = problemUnitSelect;
			}
		}
	</SCRIPT>
</body>
</html>
