<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>

		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>

		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/checkboxSelected.js"></script>	
					<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/validateCommon.js"></script>	
<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>	
<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='/ais/dwr/engine.js'></script>
<script type='text/javascript' src='/ais/dwr/util.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
			
		<title>绩效考核-考核体系</title>
		<script language="javascript">
function doSubmit()
{	
 if(!numberValidate_out('peSystem.name',50,'体系')){
 return false;
 }else{
    document.forms[0].submit();
    }
}
</script>
	</head>
	<body onload="xxx1()">	
	
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
					<span style="display: inline; width: 80%;float: left;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pe/pesystem/listAll.action')"/>
					</span>
					<span style="float: right;"><a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a></span>
					</td>
				</tr>
			</table>
			 
		<s:form action="listAll.action" namespace="/pe/pesystem">
	
			<table  id="searchTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center" style="display: none;">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						体系名称
					</td>
					<TD class=listtabletr1>
						<s:textfield name="peSystem.name" />
					</TD>

					<TD align=center class=listtabletr1>
						考核方式
					</TD>
					<TD class=listtabletr1>
						<s:select name="peSystem.peTypeCode" headerKey="" headerValue="请选择考核方式"
							list="basicUtil.peTypeList" listKey="code" listValue="name" />
					</TD>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						考核主体类型
					</td>
					<TD class=listtabletr1>
						<s:select name="peSystem.peMainCode" headerKey="" headerValue="请选择考核主体类型"
							list="basicUtil.peMainList" listKey="code" listValue="name" />
					</TD>

					<TD align=center class=listtabletr1>
						考核对象类型
					</TD>
					<TD class=listtabletr1>
						<s:select name="peSystem.peObjectCode" headerKey="" headerValue="请选择考核对象类型"
							list="basicUtil.peObjectList" listKey="code" listValue="name" />
					</TD>
				</tr>				
				
				<tr class="listtablehead" align="right">
						<td colspan="6" align="right" class="listtabletr1">
							<div align="right">
							<s:button onclick="return doSubmit();" value="查询"/>
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/pe/pesystem/listAll.action'" />
							</div>
						</td>
					</tr>
			</TABLE>			
		</s:form>
		<!-- 列表FORM -->
		<s:form namespace="/pe/pesystem">
			<div align="center">
			<display:table name="peSystemList" id="row" requestURI="${contextPath}/pe/pesystem/listAll.action" 
				class="its" pagesize="30" cellspacing="0"  export="false" >
				<display:column>
					<input type="checkbox" name="ids" value="${row.id}">
					<s:hidden name="name" value="${row.name}"></s:hidden>
					<s:hidden name="status" value="${row.status}"></s:hidden>
					<s:hidden name="ys_id" value="${row.ys_id}"></s:hidden>
					<s:hidden name="flow_id" value="${row.flow_id}"></s:hidden>										
				</display:column>
				

				<display:column  title="状态"headerClass="center" sortable="true" media="html" >
				<s:if test="${row.status=='0'}">
				<s:div cssStyle="text-align:center; color:green">草稿</s:div>
				</s:if>
				<s:elseif test="${row.status=='2'}">
				<s:div cssStyle="text-align:center; color:red">已发布</s:div>
				</s:elseif>
				<s:elseif test="${row.status=='1'}">
				<s:div cssStyle="text-align:center; color:brown">已注销</s:div>
				</s:elseif>		
				</display:column>						
				<display:column property="name" title="体系名称"
					headerClass="center" sortable="true" >
				</display:column>
				<display:column property="edition" title="版本"
					headerClass="center" sortable="true" >
				</display:column>

				<display:column property="peObjectName" title="考核对象类型"
					headerClass="center" sortable="true" >
				</display:column>								
				<display:column property="peMainName" title="考核主体类型"
					headerClass="center" sortable="true" >
				</display:column>
				<display:column property="peTypeName" title="考核方式"
					headerClass="center" sortable="true" >
				</display:column>	
				
				<display:column  title="考核指标" headerClass="center" sortable="true"  media="html">
				<s:if test="${row.ys_id=='no'}">	
                <s:a cssStyle="cursor:hand"  onclick="openWindowByUrl_common('${contextPath}/pe/ys/listAll.action?id=${row.id}')"><s:div cssStyle="text-align:center; color:red">未定义</s:div></s:a>			
				</s:if>
				<s:elseif test="${row.ys_id=='yes'}">					
				<s:a cssStyle="cursor:hand" onclick="openWindowByUrl_common('${contextPath}/pe/ys/listAll.action?id=${row.id}')"><s:div cssStyle="text-align:center; color:green">已定义</s:div></s:a>			
				</s:elseif>				
				</display:column>
				<display:column  title="考核环节" headerClass="center" sortable="true" media="html">
				<s:if test="${row.flow_id=='no'}">
                <s:a cssStyle="cursor:hand"  onclick="openWindowByUrl_common('${contextPath}/pe/flowpoint/listAll.action?id=${row.id}')"><s:div cssStyle="text-align:center; color:red">未定义</s:div></s:a>			
				</s:if>
				<s:elseif test="${row.flow_id=='yes'}">
                <s:a cssStyle="cursor:hand" onclick="openWindowByUrl_common('${contextPath}/pe/flowpoint/listAll.action?id=${row.id}')"><s:div cssStyle="text-align:center; color:green">已定义</s:div></s:a>
				</s:elseif>	
				</display:column>
															
			    <display:column  title="操作" headerClass="center" sortable="true"  media="html">
				<s:a href="${contextPath}/pe/pesystem/listOne.action?id=${row.id}">明细</s:a>
				</display:column>	
		       <display:setProperty name="export.csv" value="false"/>  
               <display:setProperty name="export.xml" value="false"/>     		
			</display:table>
			</div>

            <s:hidden id="id" name="id"></s:hidden>
            <br>
        <div align="right">
				<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<s:url action="toAddPageAction" namespace="/pe/pesystem"/>';"
					value="新建" />
				&nbsp;&nbsp;
				<s:button onclick="delete_submit('ids','delete')"
					value="删除" 				 
					 />
				&nbsp;&nbsp;
				<s:button onclick="initUpdate_submit('ids')"
					value="编辑"/>
				&nbsp;&nbsp;
				
				<s:button onclick="delete_submit('ids','logout')"
					value="注销"/>
				&nbsp;&nbsp;
				<s:button onclick="delete_submit('ids','recover')"
					value="恢复"/>
				&nbsp;&nbsp;
				<s:button onclick="delete_submit('ids','send')"
					value="发布"/>
				&nbsp;&nbsp;												
				<s:button
				    onclick="selall_inform('ids')" 
				    value="全选" />
				&nbsp;&nbsp;
				<s:button
					onclick="selall_inform('ids',false)" value="全不选" />
				&nbsp;&nbsp;&nbsp;

			
			</div>
		</s:form>

<script language="javascript"> 
	function isPermit(checkboxName,tag){//是否允许处理	（删除，注销，恢复，发布） 
			 var entries=document.getElementsByName(checkboxName);
			 var names=document.getElementsByName("name");
			 var statuses=document.getElementsByName("status");
			 var ys_ids=document.getElementsByName("ys_id");
			 var flow_ids=document.getElementsByName("flow_id");			 			 
			 var id=document.getElementById("id");
			 var str='';
	         var str2='';
			 for(var i=0;i<entries.length;i++){
			 
			 	if(tag=='delete'){//删除		       
			 	if(entries[i].checked==true&&statuses[i].value!='1'){			 	
			 	 str=str+':'+names[i].value;			 	
			 	}
			 	 id.value='3';//删除标记
			 	}else if(tag=='logout'){//注销
                 id.value='1';              
			 	}
			 	else if(tag=='recover'){//恢复
			 	 if(entries[i].checked==true&&statuses[i].value!='1'){			 	
			 	    str=str+':'+names[i].value;			 	
			 	   }
			 	   id.value='0';
			 	}
			 	else if(tag=='send'){//发布
			 	
			 	 if(entries[i].checked==true&&statuses[i].value!='0'){			 	
			 	    str=str+':'+names[i].value;			 	
			 	   }
			 	 if(entries[i].checked==true&&(ys_ids[i].value=='no'||flow_ids[i].value=='no')){			 	
			 	    str2=str2+':'+names[i].value;			 	
			 	   }			 	   			 	   
			 	   id.value='2';			 	
			 	}
			 				 	
			 }
			 if(str!=''){			 
				 alert('所选<'+str+'>不能进行此操作！');
				 return false;			 	 		 	
			 }
			 
			 if(str2!=''){			 
				 alert('所选<'+str2+'> 指标或流程没有定义！');
				 return false;			 	 		 	
			 }
			 return true;
		}

	function isPermit_edit(checkboxName){//是否允许处理	（修改） 
			 var entries=document.getElementsByName(checkboxName);
			 var names=document.getElementsByName("name");
			 var statuses=document.getElementsByName("status");
			 
			 var count=0;
			 var str='';
	        
			 for(var i=0;i<entries.length;i++){			       
			 	if(entries[i].checked==true){			 			 	
			 	count=count+1;			 	 	
			 	}		 	
			 }			 
			 if(count!=1){alert('只能单个修改'); return false;}	
			 
			 for(var i=0;i<entries.length;i++){				      
			 	if(entries[i].checked==true&&statuses[i].value!='0'){			 	
			 	str=str+':'+names[i].value;		 	
			 	}		 	
			 }			 
			 if(str!=''){			 
				 alert('所选<'+str+'>不能进行此操作！');
				 return false;			 	 		 	
			 }
			 return true;
		}
		
   function delete_submit(checkboxName,tag){//删除,注销，发布，恢复               
            if(delOrEdit(checkboxName)&&isPermit(checkboxName,tag)){  
            var s='';
            if(tag=='delete'){
             s='删除';
            }
            else if(tag=='logout'){
             s='注销';
            }
            else if(tag=='send'){
             s='发布';
            } 
            else if(tag=='recover'){
             s='恢复';
            }        
            
           // alert('--'+testIsHaveFlow());
           
                            
              if(window.confirm('确定要'+s+'选中的记录吗？')){
                document.forms[1].action="deleteAction.action";
                document.forms[1].submit();
               }              
             
              
            }            
           }  
   function initUpdate_submit(checkboxName){//修改处理 
                  
            if(delOrEdit(checkboxName)&&isPermit_edit(checkboxName)){             
              document.forms[1].action="initUpdateAction.action";             
              document.forms[1].submit();
            }            
           } 
           
           
           
  
function xxx1(){//针对没有流程的体系发布，给予提示
 
if(${status=='no'}){
	window.alert("体系工作流程没有发布，请先发布体系工作流!");
}
  
} 
        
</script>

	</body>
</html>
