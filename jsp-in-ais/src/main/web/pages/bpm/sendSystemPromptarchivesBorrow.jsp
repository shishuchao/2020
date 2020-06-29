<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>档案借阅完毕-发送系统通知</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript">
		//复选框选择控制
 		function deletebook(myform)
		{
		
			var str = "";		
			for (var i=0;i<myform.elements.length;i++)
			{
				var e = myform.elements[i];
				if(e.Type="checkbox")
				{
					if(e.checked)
					{
						str = str + e.value;					
					}
				}
			}
			
			if(str=="")
			{
				alert("请选择要操作的记录！");
				return false;
			}
			if(!confirm("确认执行这项操作吗？"))
			{
				return false;
			}
			return true;
		}

		function allcheOrcl(myform,cheOrclear)
		{		
			var ische = cheOrclear;
			for (var i=0;i<myform.elements.length;i++)  //用来历遍form中所有控件,
			{
				var e = myform.elements[i];
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
		</script>
	</head>

	<body>
		<s:form name="msqForm" action="saveSystemPrompt"
			namespace="/bpm/systemprompt" method="post">
			<s:hidden name="back_url"></s:hidden>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<s:iterator value="sysList" status="index">
					<tr class="listtablehead">
						<td colspan="2" align="left" class="edithead">
							&nbsp;档案借阅管理流程执行完毕，发送系统通知 ---
							<s:property value="%{project_name}" />
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							档案借阅发起人：
						</td>
						<td class="listtabletr2">
							<s:checkboxlist name="sysList[%{#index.index}].listStartBorrowMans"
								list="mapStartBorrowMans" value="mapStartBorrowMans"></s:checkboxlist>
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							档案借阅人：
						</td>
						<td class="listtabletr2">
							<s:checkboxlist name="sysList[%{#index.index}].listInBorrowMans"
								list="mapInBorrowMans" value="mapInBorrowMans"></s:checkboxlist>
						</td>
					</tr>
				    <tr>
						<td class="listtabletr1">
							发送信息
						</td>
						<td class="listtabletr2">
							<s:textarea name="sysList[%{#index.index}].description"
								value="%{description}"
								cssStyle="width:100%;height:20;overflow-y:visible"></s:textarea>
						</td>
					</tr>
				</s:iterator>
				<tr>
					<td class="listtabletr1" colspan="2">
						<input type="button" name="Submit" value="全选"
							onClick="allcheOrcl(msqForm,1)">
						&nbsp;
						<input type="button" name="Submit2" value="反选"
							onClick="allcheOrcl(msqForm,0)">
						&nbsp;
						<s:submit value="发送" onclick="return deletebook(msqForm)"></s:submit>
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>
