<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title><s:property value="#title" />反馈底稿列表</title>
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
		//匹配查询
		function searchList(){
			var url = "${contextPath}/operate/feedback/feedbackManu.action";
			myform.action = url;
			myform.submit();
			
		}

        //重置
		function searchrecal(){
			var url = "${contextPath}/operate/feedback/feedbackManu.action";
		    window.location = url;
		}
 
         //全选
         function checkAll(){
		    var checkbox=document.getElementsByName("manuIds"); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=true;   	
			    
          }
          
          //检查选择
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
          
           
          //反馈意见
         function   goForm1()  
         	{if(checkSelect()){
             var count=0;
             var checkbox=document.getElementsByName("manuIds"); 
             var id="";
             for(var i=0;i<checkbox.length;i++){
			     if(checkbox[i].checked==true){
			        count=count+1;
			        id=checkbox[i].value;
			     }	
			     
			}
			 
            if(count==1){
              document.myform.action="/ais/operate/manu/singleFeedback.action?crudId="+id;
              document.myform.submit();
            }else{
              document.myform.action="/ais/operate/feedback/feedbackBatch.action"
              document.myform.submit();
            }
           
             
          } 
            
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
							反馈底稿列表
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
							底稿编码:
						</td>
						<td>
							<s:textfield name="audManuscript.ms_code" cssStyle="width:37%" />
						</td>
						 
					</tr>
				</table>



				<div align="right">
					<s:button value="查询" onclick="javascript:searchList();" />
					&nbsp;&nbsp;
					<s:button value="重置" onclick="javascript:searchrecal();" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>

				<s:hidden name="pro_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<display:table name="list" id="row"
					requestURI="${contextPath}/operate/feedback/feedbackManu.action"
					class="its" pagesize="10" partialList="true" size="resultSize">
					 


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

					<display:column property="sdate_comment" title="征求开始日期: "
						headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
						class="center"></display:column>

					<display:column property="edate_comment" title="征求结束日期: "
						headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
						class="center"></display:column>

					<display:column title="操作" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" media="html">
						<a
							href="${contextPath}/operate/manu/singleFeedback.action?crudId=${row.formId}">反馈意见</a>
					</display:column>

				</display:table>
				<br>
				<br>
				 <div align="right">
					<input type="button" value="全选" onclick="checkAll()" />
					<input type="button" value="全取消" onclick="uncheckAll()" />
					<input type="button" value="反馈意见" onclick="goForm1()" />



				</div>
		</center>
		</form>
	</body>
</html>
