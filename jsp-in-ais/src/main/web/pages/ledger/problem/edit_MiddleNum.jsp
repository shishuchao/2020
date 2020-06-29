<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>入报告问题</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		function myCheck(){
			 obj=document.getElementById("middleLedgerProblem.serial_num");
			 if(obj.value==""){
				alert("问题编号不能为空,请完善信息!");  
	    		return false;
			 }
			 var id=document.getElementById("middleLedgerProblem.id").value;
			 $.ajax({
				type: "POST",
				dataType:'json',
				url : "/ais/proledger/problem/saveMiddleNum.action",
				data:{
					'middleLedgerProblem.serial_num':obj.value,
					'id':id
				},
				success: function(data){
					if(data.type == 'ok'){
						alert('保存成功');	
					}else{
						alert('保存失败');
					}		
				},
				error:function(data){
					alert('请求失败！');
				}
			});
		}
		function doClear(){
			try{
				window.parent.document.getElementById('WebOffice').style.display='block';
			}catch(e){}
			window.parent.hidePopWin(false);
		}
	</script>
</head>
<body>

    <s:hidden name="str" />
    <div style='padding:10px; text-align:center;'>
    <table align="center" cellpadding=1 cellspacing=1 border=0 style='padding:5px; font-size:12px;text-align:center;'>
        <tr >
            <td valign="middle" nowrap="nowrap"  style="width: 10%;">问题编号：
            </td>
            <td style="width: 90%">
                <s:textfield id="middleLedgerProblem.serial_num" name="middleLedgerProblem.serial_num" cssStyle="width:90%"  />
                <s:hidden name="middleLedgerProblem.id" value="${id}" />
            </td>
        </tr>
    </table>
    </div>
</body>
</html>
