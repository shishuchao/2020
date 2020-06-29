<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计整改情况统计分析</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript">
		/**
		* 选择被审计单位
		*/
		function selectAuditObject(){
			var auditDeptId = '${organization.fid}';
			showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdatamuti.jsp?url=${pageContext.request.contextPath}/mng/audobj/object/auditedDeptList.action&paraname=ledgerProblem.m_audit_dept&paraid=ledgerProblem.m_audit_dept_code&showRootNode=_show&where='+auditDeptId,600,350,'被审计单位');
		}
		
		function selectProblem(){
			showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/ledger/problemledger/problemTreeView.action&paraname=ledgerProblem.problem_name&paraid=ledgerProblem.problem_code',600,450,'审计问题点选择');
		}

		function queryAnalyse(){
			 /*var project_name= document.getElementsByName("ledgerProblem.project_name")[0].value;
			 var pro_year= document.getElementsByName("ledgerProblem.pro_year")[0].value;
			 var pro_type= document.getElementsByName("ledgerProblem.pro_type")[0].value;
			 var audit_object_name= document.getElementsByName("ledgerProblem.audit_object_name")[0].value;
			 var audit_dept_name= document.getElementsByName("ledgerProblem.audit_dept_name")[0].value;
			 var problem_name= document.getElementsByName("ledgerProblem.problem_name")[0].value;
			 var sort_big_name= document.getElementsByName("ledgerProblem.sort_big_name")[0].value;
			 var flog='false';
			 if(project_name!=null&&project_name!=''){
				 flog='true';
			 }
			 if(pro_year!=null&&pro_year!=''){
				 flog='true';
			 }
			 if(pro_type!=null&&pro_type!=''){
				 flog='true';
			 }
			 if(audit_object_name!=null&&audit_object_name!=''){
				 flog='true';
			 }
			 if(audit_dept_name!=null&&audit_dept_name!=''){
				 flog='true';
			 }
			 if(problem_name!=null&&problem_name!=''){
				 flog='true';
			 }
			 if(sort_big_name!=null&&sort_big_name!=''){
				 flog='true';
			 }
			 if(flog=='false'){
               $.messager.show({
            	   title:"提示信息",
               		msg:"条件不能为空！",
               		timeout:5000,
               });
               return false;
			 }*/
			 //queryform.submit();
			drawDataGrid();
		}
		function clearQuery(){
			try{
			 /*document.getElementsByName("ledgerProblem.project_name")[0].value = '';
			 document.getElementsByName("ledgerProblem.pro_year")[0].value = '';
			 document.getElementsByName("ledgerProblem.pro_type")[0].value  = '';
			 document.getElementsByName("ledgerProblem.audit_object_name")[0].value  = '';
			 document.getElementsByName("ledgerProblem.audit_object")[0].value  = '';
			 document.getElementsByName("ledgerProblem.audit_dept_name")[0].value  = '';
			 document.getElementsByName("ledgerProblem.audit_dept")[0].value  = '';
			 document.getElementsByName("ledgerProblem.problem_name")[0].value  = '';
			 document.getElementsByName("ledgerProblem.problem_code")[0].value  = '';
			 document.getElementsByName("ledgerProblem.sort_big_name")[0].value  = '';
			 document.getElementsByName("ledgerProblem.pro_type_name")[0].value  = '';
			 document.getElementsByName("ledgerProblem.pro_type_child_name")[0].value  = '';*/
			 
			 //setWorkProgramId();

                resetForm('queryform');

            }catch(e){
				//alert(e.message)
			}
			
		}
		function showQuery(){
			var tab1 = document.getElementById('tab1');
			tab1.style.display =  tab1.style.display == 'none' ? '' :'none';
		}

		$(function () {
			var bodyh = $("body").height();
			$("#mainDiv").css("height", bodyh);
			var centerh = $("body").height() - $("#northDiv").height();
			$("#centerDiv").css("height", centerh);
		});
		</script>
	</head>
<body onload="setWorkProgramId()" style="overflow:hidden;" class="easyui-layout">
	<div id="subwindow" class="easyui-window" title="项目类型" border="0" iconCls="icon-search" style="overflow:hidden;width:500px;height:500px;padding:0px;" closed="true">
		<div class="easyui-layout" fit="true" border="0">
			<div region="center" border="0" style="padding:0px;background:#fff;border:0px solid #ccc;overflow:hidden;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">取消</a>
			    </div>
			</div>
		</div>
	</div>
	<div id="mainDiv">
	<div id="northDiv" region="north" title="查询条件" data-options="split:false" style="height:160px;">
		<s:form id="queryform" action="mendAnalyseList" namespace="/proledger/problem" method="post">
			<table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td align="left" class="EditHead">项目名称</td>
					<td align="left" class="editTd">
						<s:textfield cssClass="noborder" name="ledgerProblem.project_name" />
					</td>
					<td align="left" class="EditHead">项目年度</td>
					<td align="left" class="editTd">
						<select id="w_plan_year" class="easyui-combobox" style="width:160px" name="ledgerProblem.pro_year"  editable="false">
					       <option value="">&nbsp;</option>
					       <%--<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>--%>

							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
								<s:if test="${ledgerProblem.pro_year == key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
							</s:iterator>
					    </select>
					</td>
				</tr>
				<tr>
					<td align="left" class="EditHead">项目类型</td>
					<td align="left" class="editTd">
						<div style="float: left;width:100%">
							<s:textfield cssClass="noborder" name="ledgerProblem.pro_type_name"  id="pro_type_name" readonly="true"/>
							<s:textfield cssClass="noborder" name="ledgerProblem.pro_type_child_name"  id="pro_type_child_name" readonly="true"/>
							<img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" 
						    	onclick="getItem('/ais/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类型',500,400)"></img>
								<input type="hidden" id="pro_type" name="ledgerProblem.pro_type" value="<s:property value='ledgerProblem.pro_type'/>">
								<input type="hidden" id="pro_type_child" name="ledgerProblem.pro_type_child" value="<s:property value='ledgerProblem.pro_type_child'/>">
						</div>
                        <div id="showWorkProgram" style="float: left;"></div>		
							
					</td>
					<td align="left" class="EditHead">被审计单位</td>
					<td align="left" class="editTd">
						<s:buttonText2 hiddenId="audit_object" cssClass="noborder"
							id="audit_object_name" name="ledgerProblem.audit_object_name"
							hiddenName="ledgerProblem.audit_object"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
							  param:{
							    'departmentId':'${organization.fid}'
							  },
							  cache:false,
							  checkbox:true,
							  title:'请选择被审计单位'
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							title="被审计单位" maxlength="1500" />
					</td>
				</tr>
				<tr >
					<td align="left" class="EditHead">审计单位</td>
					<td align="left" class="editTd">
						<s:buttonText2 id="audit_dept_name"  cssClass="noborder"
							name="ledgerProblem.audit_dept_name" 
							hiddenId="audit_dept" hiddenName="ledgerProblem.audit_dept"
									   doubleOnclick="showSysTree(this,
								{url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'请选择审计单位',
                                  param:{
                                    'p_item':3
                                  },
                                   checkbox:true
								})"
									   doubleSrc="${contextPath }/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td align="left" class="EditHead" >问题点</td>
					<td align="left" class="editTd">
						<s:buttonText  id="problems" hiddenId="ledgerProblem.problem_code" cssClass="noborder"
							 name="ledgerProblem.problem_name"
							hiddenName="ledgerProblem.problem_code"
							doubleOnclick="showSysTree(this,{
				    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
				    				onlyLeafCheck:true,
				    				onlyLeafClick:true,
				    				title:'请选择问题点'
								})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr >
					<td align="left" class="EditHead">问题类别</td>
					<td align="left" class="editTd" colspan="3" style="width:85%">
						<%--<s:textfield cssClass="noborder" cssStyle="width:90%" name="ledgerProblem.sort_big_name" />--%>
						<s:buttonText  id="problems" hiddenId="ledgerProblem.sort_big_code" cssClass="noborder"
									   name="ledgerProblem.sort_big_name"
									   hiddenName="ledgerProblem.sort_big_code"
									   doubleOnclick="showSysTree(this,{
								url:'${contextPath}/plan/detail/problemCategoryTree.action',
								//onlyLeafCheck:true,
								title:'请选择问题类别'
							})"
									   doubleSrc="/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr>
					<td  class="editTd" colspan="4">
						<div style="text-align:right;padding-right:5px;">
							<a  onclick="queryAnalyse();" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">分析</a>
							&nbsp;
							<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick='clearQuery()' >重置</a>
						</div>
					</td>
				</tr>
			</table>
		</s:form>
	</div>
	<div id="centerDiv" region="center" style="overflow: hidden; margin: auto 5px;" border="false">
		<iframe allowtransparency="true" style="z-Index: 1" name="viewData" src="" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
	</div>
	</div>
	<script type="text/javascript">
		function setWorkProgramId(){
             var projtype = document.getElementsByName("ledgerProblem.pro_type");
             var childprojtype = document.getElementsByName("ledgerProblem.pro_type_child")[0];
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
             /*var retmessage="";
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
             }*/
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
				top:5,
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
				document.all('ledgerProblem.pro_type_child').value=res[0];
				document.all('ledgerProblem.pro_type').value=res[1];
    			document.all('ledgerProblem.pro_type_name').value=name[0];
    			document.all('ledgerProblem.pro_type_child_name').value=name[1];
    			document.getElementById('pro_type_child_name').style.display='';
			}else{
				document.all('ledgerProblem.pro_type_child').value='';
				document.all('ledgerProblem.pro_type').value=ayy[0];
				document.all('ledgerProblem.pro_type_name').value=name[0];
    			document.all('ledgerProblem.pro_type_child_name').value='';
    			document.getElementById('pro_type_child_name').style.display='none';
			}
    		closeWin();
    		projectTypeChangeHandler();
    		setWorkProgramId();
		}
		function cleanF(){
			document.all('ledgerProblem.pro_type').value='';
    		document.all('ledgerProblem.pro_type_child').value='';
    		document.all('ledgerProblem.pro_type_name').value='';
    		document.all('ledgerProblem.pro_type_child_name').value='';
    		document.getElementById('pro_type_child_name').style.display='none';
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}

		function drawDataGrid(){
			document.forms[0].action = "${contextPath}/proledger/problem/queryMendAnalyseData.action";
			document.forms[0].target = "viewData";
			document.forms[0].submit();
		}

		$(function () {
			drawDataGrid();
		});
	</script>
</body>
</html>
