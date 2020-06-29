<%@page import="ais.framework.util.MyProperty"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.Map" />
<jsp:directive.page import="java.util.Set" />
<jsp:directive.page import="java.util.Iterator" />
<jsp:directive.page import="java.util.List" />
<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script>
function chooseProject(url){
window.location = url;
}


//取消发送系统通知，跳转回代办
function cancel_send(){
		if(confirm("确认取消发送？")){
		var url = "${contextPath}/bpm/taskinstance/pending.action";
		window.location = url;
		}else{
		return false;
		}
		}
</script>
<s:if test="formInfoList.size!=0">
	<%
		Boolean boolDefinitionMap = Boolean.FALSE;
		Map map = (Map) request.getAttribute("definitionGroupMap");
		Set set = map.keySet();
		Iterator it = set.iterator();
		int count = 0;
		while (it.hasNext()) {
			List list = (List) map.get(it.next());
			if (list.size() > 1) {
				boolDefinitionMap = Boolean.TRUE;
				break;
			}
			count++;
			if (count > 1) {
				boolDefinitionMap = Boolean.TRUE;
				break;
			}
		}
		pageContext.setAttribute("displayFlag", boolDefinitionMap);
	%>
			
	<s:if
		test="@ais.bpm.util.FormTypeConstant@MNG_PROJECT_ACTUALIZE==formType||'1127'==formType">
		
		<input type="button" value="实施作业" onclick="ops()" />
		<!-- add by rain  -begin------------------------------>
		<input type="button" value="联网作业" onclick="ops1()" />
		<!-- end --------------------------------------------->
		<%
			String param = SysParamUtil.getSysParam("ais.audwork");
		%>
		<script language="javascript">
		function ops()
		{
			if(!hasSelectOnlyOne2(document.getElementsByName("batch_start_form")[0],'crudIds'))
			{
				alert("请选择一条记录！");
				return false;
			}
			else
			{
				var cs=document.getElementsByName('crudIds');
				for(var i=0;i<cs.length;i++)
				{
					if(cs[i].checked&&cs[i].ops=="bs")
					{
						var num=Math.random();
						var rnm=Math.round(num*9000000000+1000000000);
						window.open("/<%=MyProperty.getProperties('gap.context')%>/gap/initproject.jsp?pro_id="+cs[i].pro_code,"_self","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
						break;
						
					}
					else if(cs[i].checked&&cs[i].ops=="cs")
					{
						var num=Math.random();
						var rnm=Math.round(num*9000000000+1000000000);
						window.open("<%=request.getContextPath()%>/pages/operate/oprtools.jsp?pro_id='+cs[i].pro_code+'&ops=cs","_self","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
						break;
						
					}
					else if(cs[i].checked&&cs[i].ops=="na")
					{
						var num=Math.random();
						var rnm=Math.round(num*9000000000+1000000000);
						<%
							if(param != null && param.trim().equals("work1")){
						%>
						window.open("/<%=MyProperty.getProperties('gap.context')%>/gap/initproject.jsp?pro_id="+cs[i].pro_code,"_self","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
						<%
							}else if(param != null && param.trim().equals("work2")){
						%>
						window.open("${contextPath}/pages/operate/main.jsp?formId="+cs[i].pro_code,"_self","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
						<%
							}
						%>
						break;
						
					}
					else if(cs[i].checked&&cs[i].ops=="mix")
					{
						var num=Math.random();
						var rnm=Math.round(num*9000000000+1000000000);
						<%
							if(param != null && param.trim().equals("work1")){
						%>
						window.open("/<%=MyProperty.getProperties('gap.context')%>/gap/initproject.jsp?pro_id="+cs[i].pro_code,"_self","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
						<%
							}else if(param != null && param.trim().equals("work2")){
						%>
						window.open('${contextPath}/pages/operate/main.jsp?formId='+cs[i].pro_code,'_self','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
						<%
							}else if(param != null && param.trim().equals("work3")){
						%>
						window.open("<%=request.getContextPath()%>/pages/operate/oprtools.jsp?pro_id='+cs[i].pro_code+'&ops=cs","_self","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
						<%
							}
						%>
						break;
						
					}
				}
			}
		}
			function ops1()
		{
			if(!hasSelectOnlyOne2(document.getElementsByName("batch_start_form")[0],'crudIds'))
			{
				alert("请选择一条记录！");
				return false;
			}
			else
			{
				var lwsj=document.getElementsByName("crudIds");
				for(var i=0;i<lwsj.length;i++)
				{
				if(lwsj[i].checked){
						var num=Math.random();
						var rnm=Math.round(num*9000000000+1000000000);
						//----add by rain-------2009-03-10----------------//						
						var start=lwsj[i].start_time;		
						var end=lwsj[i].end_time;				
						
						if(start!=''){										
						var start_1=start.split("-")[0];
						var start_2=start.split("-")[1];
						var start_3=start.split("-")[2];
						start=start_1+start_2+start_3;
							
                            }
		                if(end!=''){
						var end_1=end.split("-")[0];
						var end_2=end.split("-")[1];
						var end_3=end.split("-")[2];
						end=end_1+end_2+end_3;			
					
					       }
						//--------------------------------------------------//

          	window.open("http://<%=MyProperty.getProperties('nc.host')+':'+MyProperty.getProperties('nc.port')+'/'+MyProperty.getProperties('nc.context')%>/login.jsp?pro_id='+lwsj[i].pro_code+'&pjstartdate='+start+'&pjenddate='+end+'","lwsj","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");					
			break;
				}
	
				}
			}
		}
		
		</script>
	</s:if>
</s:if>