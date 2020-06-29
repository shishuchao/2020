<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>项目统计</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript">
			$(function(){
			    $('#tt').tabs({ 
			        border:false, 
			        onSelect:function(title){
				    	if(title=='整改问题'){
			        		$('#a_ifr').attr('src','<%=request.getContextPath()%>/proledger/problem/decideLedgerProblemListNew.action?view=${param.view}&project_id=${project_id}&p_subject='+encodeURI(encodeURI(title))+'&permission=${permission}&isView=${isView}&isEdit=false');
				    	}
			        } 
			    });
			});
		</script>
	</head>
	<body>
	<div class="easyui-layout" fit="true">
		<div style="padding-top: 2px;width: 60%;position:absolute;top:0px;right:20px;text-align: right;z-index: 1000;">
		<s:if test="${sourceSite != 'syEdit' }">
		  <a id="backButton" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/ledger/prjledger/projectLedgerNew/edit.action?auditleader=${auditleader}&teamleader=${teamleader}&crudId=${crudId}&permission=full&view=${view}&project_id=${project_id}'" >返回</a>
		</s:if>
		</div>
		<div region="center" border="false" style="background:#fff;border:1px solid #ccc;">
			<div id="tt" class="easyui-tabs" fit="true">
				<%
			        List list= (List)request.getAttribute("list");
			        for(int i=0;i<list.size();i++){
			        	String str="";
			            String name= (String)list.get(i);
			            //为了不再url中传递的参数中出现汉子，故1=汇总台账2=汇总台账（续）
			            if("汇总台账".equals(name)){
			            	str = "1";
		  				}else if("汇总台账（续）".equals(name)){
		  					str = "2";
		  				}

		  				name = name.replace("账", "帐");

						{
						%>
						<div title='<%=name%>'>
							<iframe id="b_ifr" name="b_ifr" src='<%=request.getContextPath()%>/ledger/customledger/createLedgerTable.action?view=${param.view}&project_id=${project_id}&p_subject=<%=str%>&permission=${permission}&isView=${isView}' frameborder="0" width="100%" height="99%" ></iframe>
						</div>
						<%
						}
			        }
			    %>



				<c:if test="${pso.planProcess ne 'simplified'}">
					<div title='整改问题' style="overflow: hidden; border-top: 1px solid #ccc;">
						<iframe id="a_ifr" name="a_ifr" src="#" frameborder="0" width="100%" height="100%" ></iframe>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	</body>
</html>