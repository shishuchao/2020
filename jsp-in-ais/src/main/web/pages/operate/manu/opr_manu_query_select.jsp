<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title><s:property value="#title" />底稿列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
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
		<script language="javascript">
function searchList(){
//匹配查询

	var url = "${contextPath}/operate/manu/searchSelect.action";
	myform.action = url;
	myform.submit();
	
}


function searchrecal(){
	var url = "${contextPath}/operate/manu/searchSelect.action";
    window.location = url;
}
</script>
		<script type="text/javascript">
          function checkAll(){
		    
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=true;   	
			    
          }
          
           function checkSelect(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++){
			       if(checkbox[i].checked==true){
			        return true;
			       }
			    }
			    alert("请选择底稿！");
			    return false;  	
			    
          }
          
          
           function uncheckAll(){
		    
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=false;   	
			    
          }
          function baogao(){
            window.open("/ais/pages/operate/manu/general_edit_redirect.jsp?pro_id=${pro_id}","baogao","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          
          function taizhang(s){
            window.open("/ais/proledger/problem/listEditProblem.action?project_code=${pro_id}&&manuscript_code="+s+"&&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          function add(){
             window.location.href='/ais/operate/manu/edit.action?type=${type}&pro_id=${pro_id}&taskId=${taskId}&taskPid=${taskPid}';
           }
           //删除
          function deleteRecord(s,q,p)
		  {
		  if('${user.floginname}'==p){
		                    //alert("123");
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
		                  if(q=='040'){
		                    alert("正在复核，不能删除！");
		                    return false;
		                  }else{
		                  }
		                  if(q=='050'){
		                    alert("已复核完毕，不能删除！");
		                    return false;
		                  }else{
		                  }
		     
						if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("manu_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/manu/deleteManu.action?crudId="+s;
	                    myform.submit();
	                    }
	            
		   } 
		   
		  //编辑
          function editRecord(s,q,p)
		  {
		  if('${user.floginname}'==p){
		                    //alert("123");
		                  }else{
		                    alert("没有权限编辑！");
		                    return false;
		                  }
		                  
		                  if(q=='040'){
		                    alert("正在复核，不能编辑！");
		                    return false;
		                  }else{
		                  }
		                  
		                  if(q=='050'){
		                    alert("已复核完毕，不能编辑！");
		                    return false;
		                  }else{
		                  }
		     
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/manu/edit.action?crudId="+s;
	                    myform.submit();
	                    
		   } 
           
           //查看
          function viewRecord(s)
		  {
		     
						//alert(doubt_idArray[i].value); 
						//if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						window.open("${contextPath}/operate/manu/view.action?crudId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	                   // myform.submit();
	            
		   } 
     </script>
	</head>
	<body>
		<center>

			<form id="myform" name="my_form" onsubmit="return checkSelect();"
				action="/ais/operate/doubt/exportDigao.action" method="post"
				style="">
				<table>
					<tr class="listtablehead">
						<td colspan="5" align="left" class="edithead">
							底稿列表
						</td>
					</tr>
				</table>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="titletable1">
						<td style="width: 20%">
							底稿名称:
						</td>
						<!--标题栏-->
						<td style="width: 30%">

							<s:textfield name="audManuscript.ms_name" cssStyle="width:78%" />
							<!--一般文本框-->

						</td>

						<td style="width: 20%">
							提交人:
						</td>
						<!--标题栏-->
						<td style="width: 30%">

							<s:textfield name="audManuscript.ms_author_name" readonly="true"
								cssStyle="width:37%"></s:textfield>
							<s:hidden name="audManuscript.ms_author" />
							&nbsp;
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showPopWin('/ais/pages/system/search/frameselect4s.jsp?url=../userindex.jsp&paraname=audManuscript.ms_author_name&paraid=audManuscript.ms_author',600,450)"
								border=0 style="cursor: hand">
							<!-- 
					扩展的时候,需要增加参数如下
					eg.
						search/frameselect4s.jsp?url=../userindex.jsp&paraname=users&paraid=usersid&extend=5
				 -->

						</td>
					</tr>





					<tr class="titletable1">
						<td>
							提交日期:
						</td>
						<td>
							<s:textfield name="audManuscript.start_search" title="单击选择日期"
								onclick="calendar()" readonly="true" cssStyle="width:37%" />
							~
							<s:textfield name="audManuscript.end_search" title="单击选择日期"
								onclick="calendar()" readonly="true" cssStyle="width:37%" />
						</td>
						<td>
							底稿状态:
						</td>
						<td>
						 <s:if test="'${digaofankui}'!='enabled'">
							<s:select
								list="#@java.util.LinkedHashMap@{'010':'底稿草稿','030':'等待复核','040':'正在复核','050':'复核完毕','060':'已经注销'}"
								emptyOption="true" name="audManuscript.ms_status"
								cssStyle="width:37%" />
                         </s:if>
                         <s:else>
                             <s:select
								list="#@java.util.LinkedHashMap@{'010':'底稿草稿','030':'等待复核','040':'正在复核','050':'复核完毕','060':'已经注销','015':'等待征求','020':'正在征求'}"
								emptyOption="true" name="audManuscript.ms_status"
								cssStyle="width:37%" />
                         </s:else>

						</td>
					</tr>
					<tr class="titletable1">
						<td>
							底稿编码:
						</td>
						<td>
							<s:textfield name="audManuscript.ms_code" cssStyle="width:37%" />
						</td>
						<td>

						</td>
						<td>


						</td>
					</tr>
				</table>



				<div align="right">
					<s:button value="查询" onclick="javascript:searchList();" />
					&nbsp;&nbsp;
					<s:button value="重置" onclick="javascript:searchrecal();" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>

				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<display:table name="list" id="row"
					requestURI="${contextPath}/operate/manu/searchSelect.action"
					class="its" partialList="true" size="resultSize">
					<display:column title="序号" headerClass="center" maxLength="3"
						style="WHITE-SPACE: nowrap" class="center">${row_rowNum}</display:column>
					<display:column title="选择" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center">
						<input type="checkbox" value="'${row.formId}'" name="manuIds">
					</display:column>

					<display:column property="ms_statusName" title="底稿状态"
						headerClass="center" maxLength="4" style="WHITE-SPACE: nowrap"
						class="center"></display:column>

					<display:column property="ms_code" title="底稿编码"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center"></display:column>







					<display:column property="ms_name" title="底稿名称"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center"></display:column>

					<display:column property="ms_author_name" title="提交人"
						headerClass="center" maxLength="4" style="WHITE-SPACE: nowrap"
						class="center"></display:column>


					<display:column property="ms_date" title="提交日期"
						headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
						class="center"></display:column>


				</display:table>
				<br>
				<br>
				<div align="right">
					<input type="button" value="全选" onclick="checkAll()" />&nbsp;
					<input type="button" value="全不选" onclick="uncheckAll()" />&nbsp;
					<input type="submit" value="导出底稿" />&nbsp;&nbsp;&nbsp;




				</div>
		</center>
		</form>
	</body>
</html>
