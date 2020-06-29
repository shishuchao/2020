<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计报告查阅</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript">
		
			function submitFunc(){
				var subForm = document.getElementById('reportForm') ;
				var name = document.getElementById('projectStartObject.audit_dept_name').value ;
				if(name==''){
					showMessage1("所属单位不能为空！");
					return false ;
				}
				subForm.submit();
			}
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
		<s:form action="listReport" namespace="/project/report" method="post" id="reportForm">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td align="left" class="EditHead" style="width: 15%">
							项目编号
						</td>
						<td align="left" class="editTd" style="width: 35%">
						<s:textfield cssClass="noborder" name="projectStartObject.project_code" cssStyle="width:80%"
								maxlength="50" />
						</td>
						<td align="left" class="EditHead" style="width: 15%">
							项目名称
						</td>
						<td align="left" class="editTd" style="width: 35%">
							<s:textfield cssClass="noborder" name="projectStartObject.project_name" cssStyle="width:80%"
								maxlength="50" />
						</td>
					</tr>
					<tr >
						<td align="left" class="EditHead">
							审计机构报告
						</td>
						<td align="left" class="editTd">
						<s:textfield name="shenjijuName" cssClass="noborder" cssStyle="width:80%"
								maxlength="50" />
						</td>
						<td align="left" class="EditHead">
							审计决定报告
						</td>
						<td align="left" class="editTd">
							<s:textfield name="juedingshuName" cssStyle="width:80%" cssClass="noborder"
								maxlength="50" />
						</td>
					</tr>
					<tr >
						<td align="left" class="EditHead">
							项目年度
						</td>
						<td align="left" class="editTd">
						<!-- 
							<s:select name="projectStartObject.pro_year" cssClass="easyui-combobox"
								cssStyle="width:160px;"
								list="#@java.util.LinkedHashMap@{'':'','2009':'2009','2010':'2010','2011':'2011','2012':'2012','2013':'2013','2014':'2014','2015':'2015'}"
								disabled="false" theme="ufaud_simple"
								templateDir="/strutsTemplate" />
						 -->		
							 <select id="w_plan_year" class="easyui-combobox" name="projectStartObject.pro_year" style="width:80%"  editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
					             <option value="<s:property value='key'/>"><s:property value='value'/></option>
						       </s:iterator>
						    </select> 
						</td>
						<td align="left" class="EditHead">
							审计组报告
						</td>
						<td align="left" class="editTd">
							<s:textfield name="reportName" cssStyle="width:80%" cssClass="noborder"
								maxlength="50" />
						</td>
					</tr>
					<tr >
						<td align="left" class="EditHead">
							所属单位
						</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="projectStartObject.audit_dept_name" name="projectStartObject.audit_dept_name" cssClass="noborder"
								cssStyle="width:80%" hiddenName="projectStartObject.audit_dept"
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/systemnew/orgListByAsyn.action',
									  title:'请选择审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  }
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
						</td>
						<td align="left" class="EditHead">
							被审计单位
						</td>
						<td align="left" class="editTd">
							<s:buttonText2 name="projectStartObject.audit_object_name" cssClass="noborder"
								cssStyle="width:80%"
								hiddenName="projectStartObject.audit_object"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								  param:{
								    'departmentId':$('#projectStartObject.audit_dept').val()
								  },
								  cache:false,
								  checkbox:true,
								  title:'请选择被审计单位'
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
					</tr>
					<tr >
						<td align="left" class="EditHead" style="width:15%">
							项目类别
						</td>
						<td align="left" class="editTd" colspan="3" style="width:85%">
							<s:select id="pro_type_name" name="projectStartObject.pro_type" cssClass="easyui-combobox" cssStyle="width:32%;"
								list="basicUtil.PlanProjectTypeList" listKey="code" listValue="name" headerKey="" headerValue=""
								theme="ufaud_simple" templateDir="/strutsTemplate" />
						</td>
					</tr>
				</table>
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
		<div region="center" >
			<table id="resultList"></table>
		</div>
		<div id="subwindow" class="easyui-window" title="项目类型" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-tip" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			    </div>
			</div>
		</div>
	</div>
		<script type="text/javascript">
			function setWorkProgramId(){
             var projtype = document.getElementsByName("projectStartObject.pro_type");
             var childprojtype = document.getElementsByName("projectStartObject.pro_type_child")[0];
             var pvalue="";
             var cpvalue="";
             if(projtype){
                 //针对如果projtypedisable，struts就会产生一个hiden的input
                 if(projtype.length==1){
                 	projtype = projtype[0];
                 }else if(projtype.length==2){
                 	projtype = projtype[1];
                 }
                 if(projtype){
                 	pvalue=projtype.value;
                 }
             }
           
             if(childprojtype){
             	if(childprojtype){
             		cpvalue=childprojtype.value;
             	}
             }
             if(cpvalue == ''){
             	document.getElementById('pro_type_child_name').style.display='none';
             }else{
                 document.getElementById('pro_type_child_name').style.display='';
             }
             var retmessage="";
             DWREngine.setAsync(false);
             DWREngine.setAsync(false);DWRActionUtil.execute(
             { namespace:'/workprogram', action:'getWorkProgramByProjType', executeResult:'false' }, 
             {'wp_projtypeid':pvalue,'wp_childprojtypeid':cpvalue},
             xxx);
             function xxx(data){
                 retmessage=data['ret_message'];
             } 
             if(retmessage!=""){
             	document.getElementById("workprogramid").value=retmessage;
             }else{
             	document.getElementById("workprogramid").value="";
             }
         }
		function getItem(url,title,width,height){
			$('#item_ifr').attr('src',url);
			$('#subwindow').window({
				title: title,
				width: width,
				height:height,
				modal: true,
				shadow: true,
				closed: false,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
		}
		function saveF(){
			var ayy = $('#item_ifr')[0].contentWindow.saveF();
			var res = ayy[0].split(',');
			var name = ayy[1].split(',');
			if(res.length != 1){
				document.all('projectStartObject.pro_type_child').value=res[0];
				document.all('projectStartObject.pro_type').value=res[1];
    			document.all('projectStartObject.pro_type_name').value=name[0];
    			document.all('projectStartObject.pro_type_child_name').value=name[1];
    			document.getElementById('pro_type_child_name').style.display='';
			}else{
				document.all('projectStartObject.pro_type_child').value='';
				document.all('projectStartObject.pro_type').value=ayy[0];
				document.all('projectStartObject.pro_type_name').value=name[0];
    			document.all('projectStartObject.pro_type_child_name').value='';
    			document.getElementById('pro_type_child_name').style.display='none';
			}
    		closeWin();
    		projectTypeChangeHandler();
    		setWorkProgramId();
		}
		function cleanF(){
			document.all('projectStartObject.pro_type').value='';
    		document.all('projectStartObject.pro_type_child').value='';
    		document.all('projectStartObject.pro_type_name').value='';
    		document.all('projectStartObject.pro_type_child_name').value='';
    		document.getElementById('pro_type_child_name').style.display='none';
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
        function freshGrid(){
			$('#dlgSearch').dialog('open');
		}
		/*
		* 查询
		*/
		function doSearch(){
        	$('#resultList').datagrid({
    			queryParams:form2Json('reportForm')
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
			document.getElementsByName("projectStartObject.audit_dept_name")[0].value = '';
			document.getElementsByName("projectStartObject.audit_object_name")[0].value = '';
			resetForm('reportForm');
			/*doSearch();*/
			setWorkProgramId();
		}
		$(function(){
			var d = new Date();
			$('#w_plan_year').combobox('setValue',d.getFullYear());
			document.getElementsByName("projectStartObject.audit_dept_name")[0].value = '中国铁路总公司审计和考核局';
			showWin('dlgSearch');
			$('#resultList').datagrid({
				url : "<%=request.getContextPath()%>/project/report/listReport.action?querySource=grid",
				method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:false,
				//idField:'id',	
				pageSize: 20,
				border:false,
				singleSelect:true,
				remoteSort: false,
				sortName:'project_code',
				sortOrder:'desc',
				toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					}
				],
				frozenColumns:[[
	       			{field:'project_code',title:'项目编号',halign:'center',width:'280',align:'left',sortable:true,
		       			formatter:function(value,row,rowIndex){
			       			return row[0].project_code;
			       			}
	       			},
	       			{field:'project_name',title:'项目名称',halign:'center',width:'150',sortable:true,align:'left',
		       			formatter:function(value,row,rowIndex){
		       				return row[0].project_name;
		       				 }
       				}
	    		]],
				columns:[[  
				    {field:'fileName1',
						title:'审计组报告',
						width:200,
						halign:'center',
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
				    		return '<a href="${contextPath}/commons/file/downloadFile.action?fileId='+row[1].fileId +'" >'+row[1].fileName+'</a>'; 
						}	
					 },		
				    {field:'fileName2',
						title:'审计机构报告',
						width:200,
						halign:'center',
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
						 return '<a href="${contextPath}/commons/file/downloadFile.action?fileId='+row[2].fileId +'" >'+row[2].fileName+'</a>';
						}	
					 },		
				    {field:'fileName3',
						title:'审计决定报告',
						width:200,
						halign:'center',
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
						 	return '<a href="${contextPath}/commons/file/downloadFile.action?fileId='+row[3].fileId +'" >'+row[3].fileName+'</a>';
						}	
					 },		
				    {field:'pro_year',
						title:'年度',
						halign:'center',
						align:'right',
						sortable:true,
						formatter:function(value,row,rowIndex){
							return row[0].pro_year;
						}	
					 },		
				    {field:'pro_type_name',
						title:'项目类别',
						width:100, 
						halign:'center',
						align:'right',
						sortable:true,
						formatter:function(value,row,rowIndex){
							return row[0].pro_type_name;
						}	
					 },		
					{field:'pro_type_name',
						 title:'审计类型',
						 width:100, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,index){
							 return row[0].pro_type_name;
						 }
					},
					{field:'pro_type_child_name',
						 title:'审计子类型',
						 width:150, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,index){
							 return row[0].pro_type_child_name;
						 }
					},
					{field:'audit_dept_name',
						 title:'审计单位',
						 width:200, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,index){
							 return row[0].audit_dept_name;
						 }
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:200, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,index){
							 return row[0].audit_object_name;
						 }
					}
				]]   
			}); 
		});
		</script>	
	</body>
</html>
