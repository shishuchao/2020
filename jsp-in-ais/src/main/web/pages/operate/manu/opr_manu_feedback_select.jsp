<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />底稿反馈意见</title>
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
		
		//查询
		function searchList(){
			var url = "${contextPath}/operate/manu/feedback.action";
			myform.action = url;
			myform.submit();
			
		}

       	//在线反馈设置    
      	function   goForm1()  
         	{if(checkSelect()){
             var count=0;
             var checkbox=document.getElementsByName("manuIds"); 
             for(var i=0;i<checkbox.length;i++){
			     if(checkbox[i].checked==true){
			        count=count+1;
			     }	
			     
			}
			 
            if(count==1){
              document.myform.action="/ais/operate/manu/single.action"
              document.myform.submit();
            }else{
              document.myform.action="/ais/operate/manu/feedbackBatch.action"
              document.myform.submit();
            }
           
             
          } 
            
    	} 
	    //重置
		function searchrecal(){
			var url = "${contextPath}/operate/manu/feedback.action?project_id=${project_id}";
		    window.location = url;
		}
		</script>
		<script type="text/javascript">
		
		//全选
        function checkAll(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=true;   	
			    
         }
          //判断选择底稿
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
          
          //反选
          function uncheckAll(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=false;   	
			    
          }
           
          
         
          
		   
		   
           
            
     </script>
	 </head>
	 <body>
		<center>

			<form id="myform" name="my_form" onsubmit="return checkSelect();"
				action="/ais/operate/manu/single.action" method="post"
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
							<s:select
								list="#@java.util.LinkedHashMap@{'050':'复核完毕','015':'等待征求','020':'正在征求'}"
								emptyOption="true" name="audManuscript.ms_status"
								cssStyle="width:37%" />

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
							审计小组:
						</td>
						<td>
							<s:textfield name="audManuscript.groupName" cssStyle="width:37%" />
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


                   	<display:column property="groupName" title="审计小组"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center"></display:column>




					<display:column property="ms_name" title="底稿名称"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center"></display:column>
						
						
					<display:column property="sdate_comment" title="开始日期"
						headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
						class="center"></display:column>
						
						
						
					<display:column property="edate_comment" title="结束日期"
						headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
						class="center"></display:column>
						
						
					<display:column property="feedback_name" title="征求人"
						headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
						class="center"></display:column>
						

					<display:column property="ms_author_name" title="提交人"
						headerClass="center" maxLength="4" style="WHITE-SPACE: nowrap"
						class="center"></display:column>



				</display:table>
				<br>
				<br>
				<div align="right">
					 
					<input type="button" value="全选" onclick="checkAll()" />
					<input type="button" value="全取消" onclick="uncheckAll()" />
					<input type="button" value="在线反馈设置" onclick="goForm1()" />

 

				</div>
		</center>
		</form>
	</body>
</html>
