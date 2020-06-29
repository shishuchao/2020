<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>分配给自己的待跟踪评价的问题列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />  
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form id="myform" name="myform" action="closeProblemList.action" namespace="/intctet/proManage" method="post">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td  class="EditHead" style="width:15%">
							是否关闭
						</td>
						<td class="editTd" style="width:35%">
							<select editable="false" name="interCtrlProblem.isClosedOrNot" data-options="panelHeight:'auto'" class="easyui-combobox" style="width:80%" >
								<option value="">&nbsp;</option>
							       <s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
							         <option value="<s:property value="key"/>"><s:property value="value"/></option>
							       </s:iterator>
							</select>
						</td>
						<td  class="EditHead" style="width:15%">
							评价项目编号
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="interCtrlProblem.proCode" cssStyle="width:80%" maxlength="50"/>
						</td>
					</tr>
					<tr >
						<td  class="EditHead">
							被评价单位
						</td>
						<td class="editTd">
							<s:buttonText2 name="interCtrlProblem.evaDept" cssClass="noborder"
								hiddenName="interCtrlProblem.evaDeptCode" cssStyle="width:80%"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
	                              cache:false,
								  checkbox:true,
								  title:'请选择被评价单位树'
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td class="EditHead">
						</td>
						<td class="editTd">
						</td>
					</tr>
				</table>
			</s:form>
			<s:form id="trackform" name="trackform" action="trackList" namespace="/intctet/proManage" method="post" >
				<s:hidden id="crudIdStrings" name="crudIdStrings"/>
			</s:form>
			</div>
			<div class="serch_foot">
		         <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				 </div>
			 </div>	
		</div>
		<div region="center">
			<table id="list"></table>
		</div>
		<div id="addYearPlan"></div>
		<script type="text/javascript">		
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#list').datagrid({
	    			queryParams:form2Json('myform')
	    		});
				$('#dlgSearch').dialog('close');
	        }
	        /*
			* 取消
			*/
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			/**
				重置
			*/
			function restal(){
				resetForm('myform');
				//doSearch();
			}
			function trackProblem(){
				var crudIdStrings = $('#list').datagrid('getSelections');
				if(crudIdStrings.length<1){
					showMessage1("请选择一条纪录！");
					return false;
				}
				$('#crudIdStrings').val(crudIdStrings[0].id);
				$('#trackform').submit();
			}	
			function openMsg(projectid){
				var viewUrl = "${contextPath}/proledger/problem/viewPro.action?crudId="+projectid;
	            $('#showPlanName').attr("src",viewUrl);
	            $('#planName').window('open');
			}
			$('#planName').window({
	            width:950, 
	            height:400,  
	            modal:true,
	            collapsible:false,
	            maximizable:true,
	            minimizable:false,
	            closed:true    
	        });
			function openViewMiddle(id){
				var openViewUrl = "${contextPath}/proledger/problem/viewMiddle.action?id="+id;
	         	$('#openViewMiddle').attr("src",openViewUrl);
	         	$('#viewMiddle').window('open');
			}
			$('#viewMiddle').window({
		        width:950, 
		        height:450,  
		        modal:true,
		        collapsible:false,
		        maximizable:true,
		        minimizable:false,
		        closed:true    
		    });
			function openTrackList(id){
				var openViewUrl = "${contextPath}/proledger/problem/trackList.action?crudIdStrings="+id+"&onlyView=true";
	            $('#openTrackList').attr("src",openViewUrl);
	            $('#trackList').window('open');
			}
			$('#trackList').window({
		        width:950, 
		        height:450,  
		        modal:true,
		        collapsible:false,
		        maximizable:true,
		        minimizable:false,
		        closed:true    
		    });
			$(function(){
				showWin('dlgSearch');
				// 初始化生成表格
				$('#list').datagrid({
					url : "<%=request.getContextPath()%>/intctet/proManage/trackProblemList.action?querySource=grid",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit:true,
					pageSize: 20,
					idField:'crudIds',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					},
					{
						id:'newYear',
						text:'跟踪评价',
						iconCls:'icon-user',
						handler:function(){
							trackProblem();
						}
					}],
					frozenColumns:[[
		       			{field:'id',width:'50px', hidden:true,halign:'center',align:'center',sortable:true},
		       			{field:'isClosedOrNot',title:'是否关闭',align:'center',sortable:true,
	       					formatter:function(value ,rowData,rowIndex){
	       						if(rowData.isClosedOrNot=='是'){
		       						return '是';
		       					}else{
		       						return '否';
		       					}
	       					}	
	       				},
		       			{field:'proCode',title:'项目编号',width:'280px',sortable:true,halign:'center',align:'left'
		       				/* formatter:function(value,row,index){
								 return '<a href=\"javascript:void(0)\" onclick=\"openMsg(\''+row.proId+'\');\">'+value+'</a>';
							} */
		       			}
		    		]],
					columns:[[  
						{field:'defectCode',
								title:'内控缺陷编号',
								width:200,
								halign:'center',
								align:'left', 
								sortable:true
								/* formatter:function(value,rowData,rowIndex){
									return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+rowData.id+'\');\">'+value+'</a>';
								} */
						},
						{field:'defectName',
							title:'内控缺陷名称',
							sortable:true,
							halign:'center',
							align:'center'
						},
						{field:'manuscriptIndex',
							 title:'底稿索引',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'controlName',
							 title:'所属控制点',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'circuitName',
							 title:'所属主流程',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'defectTypeName',
							 title:'缺陷类型',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'relateLoss',
							 title:'涉及到损失/错报的金额',
							 halign:'center',
							 align:'right', 
							 sortable:true
							 },
						{field:'defineResult',
							 title:'认定结果',
							 halign:'center',
							 align:'right', 
							 sortable:true
						},
						{field:'mendAdvice',
							 title:'整改建议',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'mendDeadline',
							 title:'整改期限',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },	 
						{field:'mendMethod',
							 title:'整改方式',
							 halign:'center',
							 align:'right', 
							 sortable:true
							 },
						{field:'mendStatus',
							 title:'整改状态',
							 width:100,
							 halign:'center', 
							 align:'left', 
							 sortable:true
						},
						{field:'lastFeedbackTime',
							 title:'最近反馈时间',
							 width:100,
							 halign:'center', 
							 align:'left', 
							 sortable:true,
							 formatter:function (value,row,rowIndex){return value;}
							 },
						{field:'mendStatusEvaluate',
							 title:'整改状态评价',
							 align:'left',
							 halign:'center', 
							 sortable:true,
							 formatter:function(value,row,rowIndex){return value;}
						 },
						{field:'lastEvaluateTime',
							 title:'最近评价时间',
							 width:100, 
							 halign:'center',
							 align:'left', 
							 sortable:true
						}
					]]    
				}); 
			});
		</script>
	</body>
</html>
