<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>		   
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计方案维护事项概要信息修改</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script language="javascript">
		$(function (){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
      //检查是否是类别1还是子项2，是2就返回false
      function checkItem(){
	    var resullt=''; 
	    var s='<%=request.getParameter("taskTemplateId")%>';
	    var q='<%=request.getParameter("audTemplateId")%>';
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/template', action:'checkItem', executeResult:'false' }, 
		{'taskTemplateId':s,'audTemplateId':q},xxx);
	     function xxx(data){
	     result =data['auth'];
		} 
	 
	  if(result=='1'){
	  return true;
	  }else{
	  return false;
	  }
	   
	}
	
	  //检查是否有下级 有下级返回false
      function checkDetail(){
	    var resullt=''; 
	    var s='<%=request.getParameter("taskTemplateId")%>';
	    var q='<%=request.getParameter("audTemplateId")%>';
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/template', action:'checkDetail', executeResult:'false' }, 
		{'taskTemplateId':s,'audTemplateId':q},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	 
	  if(result=='1'){
	  return true;
	  }else{
	  return false;
	  }
	   
	}
	//输入检查
	function check(){

		var v_3 = "audTaskTemplate.taskName";  // field
		var title_3 = '事项名称';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>1000){
		showMessage1("事项名称的长度不能大于1000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
        if('${shenjichengxu}'=='true'){
		var v_3 = "audTaskTemplate.taskTarget";  // field
		var title_3 = '审计目的';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		showMessage1("审计目的的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 

		var v_3 = "audTaskTemplate.taskFile";  // field
		var title_3 = '备注';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		showMessage1("备注的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
		 
        }
		 
		return true;
	}
	
	function generateLeaf2(){
		var url = '${contextPath}/operate/template/addLeaf.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=<%=request.getParameter("taskTemplateId")%>&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>';
		showWinIf('addLeaf_div',url,'增加审计事项',800,400);
		//title="增加审计事项";
	     //window.paramw = "模态窗口";
	      //showPopWin('${contextPath}/operate/template/addLeaf.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=<%=request.getParameter("taskTemplateId")%>&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',550,460,title);
	     //var num=Math.random();
	     //var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	}
	//生成
      function generateType() {
		    if(!checkItem()){
		      showMessage1("已经增加了审计事项的详细内容,不能增加子事项!");
		      return false;
		    }else{
		     var url = '${contextPath}/operate/template/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=<%=request.getParameter("taskTemplateId")%>&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>';
			 showWinIf('addType_div',url,'增加事项类别',800,400);
		     //title="增加审计事项";
		     //window.paramw = "模态窗口";
		     //showPopWin('${contextPath}/operate/template/addType.action?selectedTab=<%=request.getParameter("selectedTab")%>&type=<%=request.getParameter("type")%>&node=<%=request.getParameter("taskTemplateId")%>&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',550,460,title);
		     //var num=Math.random();
		     //var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	       }           
	} 
	function generateLeaf()
		  {
	        if(!checkDetail()){
		      showMessage1("已经增加了下级节点,不能增加详细内容,请到末级节点增加详细内容!");
		      return false;
		    }else{
		     title="增加审计事项详细内容";
		     window.paramw = "模态窗口";
		     showPopWin('${contextPath}/operate/template/showContentTypeDetail.action?type=1&selectedTab=item&node=<%=request.getParameter("taskTemplateId")%>&tab=item&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',550,360,title);
		      
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	         }           
	} 
	 //删除
     function deleteRecord() {
     	$.messager.confirm('提示','删除后会丢失该类别下的相关事项，确认删除事项类别吗？',function(flag){
			if(flag){
				$.ajax({
					type:"post",
					data:$('#myform').serialize(),
					url:"${contextPath}/operate/template/deleteLeaf.action",
					async:false,
					success:function(){
				    	parent.parent.reloadChildTreeNode('delete');
				    	showMessage1('删除成功！');
					}
				});
				//myform.action = "${contextPath}/operate/template/deleteLeaf.action";
				//myform.submit();
				//window.parent.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${audTaskTemplate.taskPid}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
			}
		});
	 }  
	function exe(){
		if (confirm("是否设置为已处理状态?")) {
		document.getElementsByName("audTemplate.doubt_status")[0].value="050"
		//audTemplate.doubt_status
	         saveForm();
         }else{
	 
         } 
	}
	function law(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	
	function regu(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
             





	function onlyNumbers1(s)
	{
	 
		 re = /^\d+\d*$/
		 var str=s.replace(/\s+$|^\s+/g,"");
		 if(str==""){
		 return false;
		 }
		 if(!re.test(str))
		 {
			  showMessage1("事项序号只能输入正整数,请重新输入!");
			  return true ;   
		 }
	}

		//保存表单
		function saveFormLeaf(){
		
		var v_3 = "audTaskTemplate.taskName";  // field
		var title_3 = '事项名称';// field name
		var notNull = 'true'; // notnull
			           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
				           {
						         showMessage1(title_3+"不能为空!");
						         bool = false;
						         document.getElementById(v_3).focus();
						         return false;
				           }
		                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                        showMessage1(title_3+"不能为空!");
						         bool = false;
						         document.getElementById(v_3).focus();
						         return false;
		                   }
		
		
		
		
		
		var v_2 =  "audTaskTemplate.taskOrder"
		
		
		
		var title_2 = '事项序号';// field name
		var notNull = 'true'; // notnull
			           if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != "")
				           {
						         showMessage1(title_2+"不能为空!");
						         bool = false;
						         document.getElementById(v_2).focus();
						         return false;
				           }
		                 if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
		                        showMessage1(title_2+"不能为空!");
						         bool = false;
						         document.getElementById(v_2).focus();
						         return false;
		                   }
		
		
		var s = document.getElementsByName(v_2)[0].value;
		if(onlyNumbers1(s)){
		 document.getElementById(v_2).focus();
		return false;
		}
		
		if(!check()){
			return false;
		}
		//var url = '${contextPath}/operate/template/saveType.action?selectedTab=<%=request.getParameter("selectedTab")%>';
		$.ajax({
			type:"post",
			data:$('#myform').serialize(),
			url:'${contextPath}/operate/template/saveType.action?selectedTab=<%=request.getParameter("selectedTab")%>',
			async:false,
			success:function(){
		    	showMessage1('保存成功！');
			}
		});
		//myform.action = url;
		//myform.submit();
		//showMessage1('保存成功！');
		//window.parent.frames['treeIframe'].location.href='${contextPath}/operate/template/showTreeList.action?node=${node}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
			 
		}
    </script>
	</head>
	<body  class="easyui-layout" border="0" >
		<div region="north" border="0" style="height:100px; overflow:auto;">
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/template" method="post">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead">
							事项名称
						</td>

						<td class="editTd" colspan="3">
							<s:textarea name="audTaskTemplate.taskName" cssClass="noborder"
								cssStyle="width:100%;height:60;overflow-y:hidden;" />
							<!--一般文本框-->
						</td>
					</tr>
					<s:hidden name="audTaskTemplate.taskTemplateId" />
					<s:hidden name="audTaskTemplate.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTaskTemplate.templateId" />
					<s:hidden name="audTaskTemplate.template_type" value="1" />
					<tr style='display:none;'>
						<!-- <td class="EditHead">
							执行人
						</td>
						<td class="editTd">
							<s:hidden name="audTaskTemplate.taskAssign" />
						</td>-->
						<td class="EditHead">
							事项序号
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield name="audTaskTemplate.taskOrder" cssClass="noborder"
								cssStyle="width:160px;overflow-y:hidden;" maxlength="3" />
							<!--一般文本框-->
						</td>
						<td  class="EditHead">
							事项编码
						</td>
						<!--标题栏-->
						<td class="editTd" colspan="3">
							<s:property value="audTaskTemplate.taskCode" />
							<s:hidden name="audTaskTemplate.taskCode" />
						</td>
					</tr>
					<!--<tr>
						<td  class="EditHead">
							事项开始时间
						</td >
						<td class="editTd">
							<input type="text"  id="taskStartTime" name="audTaskTemplate.taskStartTime" class="easyui-datebox" style="width: 150px"
								value="${audTaskTemplate.taskStartTime}" editable="false"/>
						</td>
						<td class="EditHead">
							事项结束时间
						</td>
						<td class="editTd">
							<input type="text"  id="taskEndTime" name="audTaskTemplate.taskEndTime" class="easyui-datebox" style="width: 150px;height:30px;"
								value="${audTaskTemplate.taskEndTime}" editable="false"/>
						</td>
					</tr>-->
					<s:if test="'enabled' == '${shenjichengxu}'">
						<tr>
							<td class="EditHead">
								前置事项名称
							</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="audTaskTemplate.taskBeforeName"
									cssStyle="width:80%;background-color:#EEF7FF" readonly="true" />
							</td>
							<td class="EditHead">
								前置事项编码
							</td>
							<!--标题栏-->
							<td class="editTd">
								<s:textfield cssClass="noborder" name="audTaskTemplate.taskBeforeCode"
									cssStyle="width:80%" />
								<!--一般文本框-->
								<img
									src="<%=request.getContextPath()%>/resources/images/s_search.gif"
									onclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/template/showTreeListSelect.action&a=a&code=${audTaskTemplate.taskCode}&audTemplateId=${audTemplateId}&paraname=audTaskTemplate.taskBeforeName&paraid=audTaskTemplate.taskBeforeCode',450,400,'前置事项选择')"
									border=0 style="cursor: hand">
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								是否必做
							</td>
							<!--标题栏-->
							<td class="editTd">
								<s:if test="${audTaskTemplate.taskMust=='1'}">
									<input type="radio" value="1" name="audTaskTemplate.taskMust"
										checked="checked">是&nbsp;<input type="radio" value="0"
										name="audTaskTemplate.taskMust">否
                        </s:if>
								<s:else>
									<input type="radio" value="1" name="audTaskTemplate.taskMust"
										checked="checked">是&nbsp;<input type="radio" value="0"
										name="audTaskTemplate.taskMust" checked="checked">否
						</s:else>
							</td>
							<td>
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								审计目的
							</td>
							<td class="editTd" colspan="3">
							</td>
						</tr>
						<tr>
							<td class="editTd" colspan="4">
								<s:textarea cssClass="noborder" name="audTaskTemplate.taskTarget"
									cssStyle="width:100%;height:70;overflow-y:hidden;" />
							</td>
						</tr>
						</tr>
						<tr>
							<td class="EditHead">
								备注
							</td>
							<td class="editTd" colspan="3">
							</td>
						</tr>
						<tr>
							<td class="editTd" colspan="4">
								<s:textarea cssClass="noborder" name="audTaskTemplate.taskFile"
									cssStyle="width:100%;height:70;overflow-y:hidden;" />
							</td>
						</tr>
					</s:if>
				</table>
				</s:form>
				<div style="text-align:right;padding:8px 8px 0 0;">
					<s:hidden name="audTaskTemplate.taskPcode" />
					<s:hidden name="type" />
					<s:hidden name="pro_id" />
					<s:hidden name="node" />
					<s:hidden name="path" />
					<%--  <s:if test="'1' == '${detail}'">
						<input type="button" value="增加详细内容" onclick="generateLeaf();"
							title="增加下级节点后不能再增加详细内容" disabled="true" />
					</s:if>
					<s:else>
						<input type="button" value="增加详细内容" onclick="generateLeaf();"
							title="增加下级节点后不能再增加详细内容" />
					</s:else>  --%>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateType();">增加类别</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateLeaf2();">增加事项</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除类别</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormLeaf();">保存</a>

				</div>
			</div>
		</div>
		<div region="center" border="0">
			<table id="listTaskDiv" ></table>
		</div>
		<div id="addType_div" ></div>
		<div id="addLeaf_div" ></div>
	</body>
	<script>
	 	$(function(){
	 		showWin('addType_div','增加审计类别');
	 		showWin('addLeaf_div','增加审计事项');
			// 初始化生成表格
			$('#listTaskDiv').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/showContentTypeViewByUi.action?taskTemplateId=${taskTemplateId}&project_id=${project_id}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination: true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[  
					{field:'taskName',
						title:'事项名称',
						width:200,
						halign:'center',
						align:'left', 
						sortable:true
					},
					{field:'taskNametype',
						title:'类别名称',
						width:150,
						sortable:true, 
						align:'left'
					},
					{field:'taskCode',
						 title:'事项编码',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 hidden:true,
					},
					{field:'taskOther',
						 title:'审计程序和方法',
						 width:150, 
						 align:'left', 
						 sortable:true
					},
					{field:'law',
						 title:'相关法律法规和监管规定',
						 width:150, 
						 align:'left', 
						 sortable:false
					},
					{field:'taskMethod',
						 title:'审计查证要点',
						 width:150, 
						 align:'left', 
						 sortable:false
					},
					{field:'pointContent',
						 title:'重点关注内容',
						 width:150, 
						 align:'left', 
						 sortable:false
					}
					/**,
					{field:'taskStartTime',
						 title:'事项开始时间',
						 width:120, 
						 align:'center', 
						 sortable:false
					},
					{field:'taskEndTime',
						 title:'事项结束时间',
						 width:120, 
						 align:'center', 
						 sortable:false
					}**/
				]]   
			}); 
		});
	</script>
</html>
