<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<title><s:property value="#title" /></title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<style type="text/css">
/* 浮动最上层 */
#div1 {
	z-index: 9;
}

#div2 {
	z_index: 1;
}
</style>
<script type="text/javascript">
//限定字数
$(document).ready(function(){
	$("#audit_con").attr("maxlength",300);
	$("#describe").attr("maxlength",6000);
	$("#audit_law").attr("maxlength",2000);
	$("#audit_advice").attr("maxlength",2000);
	$("#myform").find("textarea").each(function(){
		autoTextarea(this);
	});
});

$(function(){
	$("#zeren option[value="+'${middleLedgerProblem.zerencode}'+"]").attr("selected",true);
	accountantSystemTypeFun();
   var problemComment = $("#problemComment").val();
   if(problemComment != ""){
       $("#problemComment").css("display","block");
	   /* $("#problemCommentText").append("<FONT color=red>*</FONT>"); */
   }
   
   			var obj = $('#auditObjectTreeId')[0];
			var dpetId = '${user.fdepid}';
			// 自定义 - 组织机构树
			showSysTree(obj,{
				container:obj,
				defaultDeptId:dpetId,
				param:{
                    /*
					   数据授权模块id, 12:组织机构树授权; 如果是组织机构树,这个参数可选; 如果是其它树,如果想用数据授权限制查询范围,则必填;
					   如果想显示全部的节点，可以为authModuleId赋一个特殊值authModuleId=-1，使sql查询不到；
					*/
					//'authModuleId':'12',// 按数据授权过滤
					//'authModuleId':'-1',// 显示全部节点
					'rootParentId':'0',
                    'beanName':'LedgerTemplateNew',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'fid',
                    'treeOrder':'orderNO'
                },
                onTreeClick:function(node, treeDom){
                		
                		/*
			        	var gridObject = $('#orgTable');
			        	// 缓存查询参数，供分页刷新等功能使用
			        	var gridQueryParamJson = {'query_eq_problemId':node.id,'sort':'case_name'};
			        	g1.setGridQueryParams(gridQueryParamJson);
			        	// datagrid加载通用方法
						QUtil.loadGrid({
					        // 请求的url, 可选如果没有，则使用表格默认的url； 可选
					        //url:xx,
					        // 传入的查询参数； 可选
					        param:gridQueryParamJson,
					        // 请求类型post or get， 默认为post请求; 可选
					        type:'post',
					        // 表格对象
					        gridObject:gridObject[0],
					        // 查询前和加载后执行的function
					        beforeSend:function(){},
					        afterSuccess:function(){}
						});
			        	*/	

                   genAuditCaseTabs('qtab', node.id);                  
			    }
			   
			});
            
			
            // 创建审计案例tabs, add by qfucee, 2015.1.19
            function genAuditCaseTabs(tabsId, nodeid, max_query_count){
                try{
                   max_query_count = !max_query_count ? 30 : max_query_count;
			       $.ajax({
						type: "POST",
						dataType:'json',
						url : "<%=request.getContextPath()%>/commonPlug/getCustomDatagrid.action",
						data:{
							'boName':'ProblemCase',
							'sort'  :'case_name',
							'query_eq_problemId':nodeid,
							'number':max_query_count//最大查询记录
						},
						success: function(data){
							var rows = data.rows;
							var total = data.total;
                            var tabs_interval = window.setInterval(function(){
                                var tabs = $('#'+tabsId).tabs('tabs');
                                if(tabs && tabs.length > 0){
                                    for(var j=0; j<tabs.length; j++){
                                        $('#'+tabsId).tabs('close', j);
                                    }
                                }else{
                                    if(tabs_interval){
                                        clearInterval(tabs_interval);
                                        if(total){
                                            $.each(rows, function(index, row){
                                                var fjStr="";
                                                $.ajax({
                                                    dataType:'json',
                                                    url : "<%=request.getContextPath()%>/ledger/problemledger/getFujianUrl.action",
                                                    data: {id:row['id']},
                                                    type: "post",
                                                    async:false,
                                                    success: function(data){						
                                                        fjStr = data.fjUrl;
                                                    },
                                                    error:function(data){
                                                        showMessage1('请求失败，请检查网络连接或与管理员联系');
                                                    }
                                                });
                                                var content = [];
                                                content.push("<div style='overflow:hidden;'><table class='ListTable'>");
                                                content.push("<tr><td style='text-align:center;' class='EditHead'>正文</td></tr>");
                                                content.push("<tr><td style='width:100%;' class='editTd'>");
                                                content.push("<textarea class='mytabcontent' readonly style='border-width:0px;word-break:break-all;word-wrap:break-word;height:140px;overflow:auto;width:590px;padding:5px;color:gray;'>");
                                                content.push(row.case_content);
                                                content.push("</textarea></td></tr>");
                                                content.push("<tr><td class='EditHead'><span style='float:left;'>附件信息</span><span style='float:right;color:gray;'>文件总数："+(fjStr.split('<li').length-1)+"</span></td></tr>");
                                                content.push("<tr><td style='width:100%;' class='editTd'><div style='color:gray;padding:5px 5px 5px 1px;height:105px;overflow:auto;'>");
                                                content.push(fjStr);
                                                content.push("</div></td></tr></table></div>");
                                                
                                                var tabTitle = row.case_name;
                                                if(tabTitle && tabTitle.length > 10){
                                                	tabTitle = tabTitle.substring(0,10)+'...';
                                                }
                                                $('#'+tabsId).tabs('add',{
                                                    'title':tabTitle,
                                                    'content':content.join('')
                                                });         
                                                var curTab = $('#'+tabsId).tabs('getTab', tabTitle);
                                                curTab.css('overflow','hidden');
                                            });
                                        }else{
                                            $('#'+tabsId).tabs('add',{
                                                'title':'案例信息',
                                                'content':"<div style='font-size:16px;text-align:center;padding:10px;color:red;'><strong><label style='text-align:center;'>没有符合要求的案例!</label></strong></div>"
                                            });
                                        }
                                        $('#'+tabsId).tabs('select',0);
                                    }
                                }
                            },100);
						},
						error:function(data){
							showMessage1('请求失败，请检查网络连接或与管理员联系');
						}
			       });
                }catch(e){
                    showMessage1('genAuditCaseTabs:\n'+e.message);
                }
            }
            
			/**
			// 右侧组织机构表格
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
			    gridObject:$('#orgTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'ProblemCase',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
			    // 表格控件dataGrid配置参数; 必填
			    gridJson:{
					queryParams:{'query_eq_problemId':'null', 'sort':'case_name'},
					// datagrid自带的事件
					onClickRow:function(index){
						//alert('点击了第'+(index+1)+'行');
					},
					title:'',
					columns:[[ 
						{field:'case_name',  title:'案例名称',        width:'150px',align:'left', sortable:true, oper:'like'},
						{field:'case_key',   title:'关键字',     width:'150px',align:'left', sortable:true},
						{field:'create_date',title:'创建时间',  width:'100px',align:'left', sortable:true},
						{field:'creater_name',title:'创建人',    width:'100px',align:'left', sortable:true},
						{field:'id',title:'附件信息',    width:'300px',align:'left',
							formatter:function(value,rowData,rowIndex){
								var fjUrl="";
								$.ajax({
				                    dataType:'json',
				                    url : "<%=request.getContextPath()%>/ledger/problemledger/getFujianUrl.action",
				                    data: {id:rowData['id']},
				                    type: "post",
				                    async:false,
				                    success: function(data){						
				                        fjUrl = data.fjUrl;
				                    },
				                    error:function(data){
				                        alert('请求失败！');
				                    }
				                });
								return fjUrl;
						}}
					]]
			    }
			});
			g1.batchSetBtn([{'index':1, 'display':false},{'index':2, 'display':false},{'index':3, 'display':false},{'index':4, 'display':false}] );
			*/
			   
			// 打开问题类别树窗口
		var wtWidth = $('body').width()*0.8;
		wtWidth = wtWidth < 780 ? 780 : wtWidth;	
		 $('#wtlbTreeSelectWrap').window({   
				width:800,   
				height:430,   
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
	   
   			
			$('#lr_openWtlbTree').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('open');
				$('#wtlbTreeSelectWrap').window('resize',{
					'top':$('body')[0].scrollTop+($('body').height()-$('#wtlbTreeSelectWrap').height())/4
				});
			});
			
			$('#sureSelectWtlbTreeNode').bind('click',function(){
				var snode = $('#auditObjectTreeId').tree('getSelected');
				if(snode){
					/* if(snode.state){ */
					if(!$('#auditObjectTreeId').tree('isLeaf',snode.target)){
						showMessage1('不能添加问题类别，请选择问题点');
					}else{
					    var idArr = QUtil.getPriorNodeIds(snode.id,"/ais/commonPlug/getPriorNodeIdsById.action?beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid");
					    var str='';
					    for(var i=0;i<idArr.length;i++){
					    	str+=idArr[i]+'#';
					    }
					    $.ajax({
							type: "POST",
							dataType:'json',
							url : "/ais/proledger/problem/getLedgerTemplateNewNames.action",
							data:{
								'str':str
							},
							success: function(data){
								if(data.type == 'ok'){
									$('#att2').val(data.names);
									$('#att').val(data.ids);
									callback();
								}else{
									showMessage1('入报告失败');
								}		
							},
							error:function(data){
								showMessage1('请求失败！');
							}
						});
					    //$('#problem_code').val(snode.id);
					    //$('#problem_name').val(snode.text);
					    $('#wtlbTreeSelectWrap').window('close');
					}
				}else{
					showMessage1('请选择问题点');
				}

			});
			$('#closeSelectWtlbTreeNode').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('close');
			});

});
	function toOpenWindow(id){
		var viewSjwtUrl = "${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId="+id;
		window.parent.addTab('tabs','查看审计底稿','tempframe',viewSjwtUrl,true);
	}
</script>
</head>
<body onload="doProblemComment('${middleLedgerProblem.problem_name}');loadZeren('${middleLedgerProblem.zeren}')">
<div class="easyui-layout" fit="true">
	<div region="center">
		<s:form id="myform" action="save2" namespace="/proledger/problem" cssStyle="text-align: center">
		
		
		<div style="width: 98.3%;position:absolute;top:0px;"  id="div1" >
			<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;margin-top:0px;'>
				<tr class="EditHead" style="background-color: white; ">
				<td style="text-align: left;background-color: white; "class="edithead">
				<span style='float: right; text-align: right;'>
				<s:if test="${viewFlag != 'view'}">
				<a id="lr_openZcfgTree" mc='audit_law' href="javascript:void(0);" class="easyui-linkbutton" 
								       data-options="iconCls:'icon-search'" >引用法规制度</a>
				<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';saveForm1('${middleLedgerProblem.pro_type }');">保存</a>		       
				&nbsp;
				<s:if test="${tableType != '1'}">
					<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="back();" >返回</a>		       
					&nbsp;
					<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deletePro('${middleLedgerProblem.id}');" >删除</a>		       
				</s:if>
			</s:if>
			</span>
			</td>
			</tr>
			</table>
		</div>
		<div class="position:relative" id="div2">
				<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
			
			
	<!-- 		<table cellpadding=1 cellspacing=1 border=0  class="ListTable" id="tab1" align="center"> -->
				<tr>
					<td class="EditHead">所属底稿名称</td>
					<td class="editTd">
						<%-- <a style="cursor:hand" href="${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId=${middleLedgerProblem.manuscript_id}" target="_blank"><s:property value="middleLedgerProblem.manuscript_name"/></a> --%>
						<a style="cursor:hand" href="javascript:void(0)" onclick="toOpenWindow('${middleLedgerProblem.manuscript_id}');"><s:property value="middleLedgerProblem.manuscript_name"/></a>
					</td>
			<%-- 		<td class="EditHead">审计小组</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.taskAssignName"/>
					</td> --%>
						<td class="EditHead"></td>
					<td class="editTd">
					</td> 
				</tr>

						<tr>
					<td class="EditHead">审计事项</td>
					<td class="editTd" colspan="3">
						<s:property value="middleLedgerProblem.task_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题类别</td>
					<td class="editTd">
						<s:textfield id="problem_all_name" name="middleLedgerProblem.problem_all_name" cssStyle="width:70%" readonly="true" cssClass="noborder"/>&nbsp;&nbsp;<FONT color=red>自动生成</FONT>
						<s:hidden id="sort_big_code" name="middleLedgerProblem.sort_big_code" />
						<s:hidden id="sort_big_name" name="middleLedgerProblem.sort_big_name" />
						<s:hidden id="sort_small_code" name="middleLedgerProblem.sort_small_code" />
						<s:hidden id="sort_small_name" name="middleLedgerProblem.sort_small_name" />
						<s:hidden id="sort_three_code" name="middleLedgerProblem.sort_three_code" />
						<s:hidden id="sort_three_name" name="middleLedgerProblem.sort_three_name" />						
					</td>
					<td class="EditHead">审计问题编号</td>
					<td class="editTd">
						<s:if test="${empty middleLedgerProblem.manuscript_name}">
							<s:textfield name="middleLedgerProblem.serial_num" cssClass="noborder"/>
						</s:if>
						<s:else>
							<s:property value="middleLedgerProblem.serial_num"/>
							<s:hidden name="middleLedgerProblem.serial_num" />		
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead"><FONT color=red>*</FONT>问题标题</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.audit_con" title="审计结论"
							cssStyle="width:100%;height:70;" /> --%>
						<s:textarea id="audit_con" name="middleLedgerProblem.audit_con" cssClass="noborder" 
							cssStyle="width:100%;height:72%;overflow-y:visible;line-height:160%;" title="审计结论"/>
						<input type="hidden" id="middleLedgerProblem.audit_con.maxlength" value="300"/>					
					</td>
				</tr>	
		
		
				<tr>
					<td class="EditHead" width="15%"><FONT color=red>*</FONT>问题点</td>
					<td class="editTd" width="35%">
						<s:textfield name="middleLedgerProblem.problem_name" id="problem_name" cssStyle="width:70%" readonly="true" cssClass="noborder"/> 
						<s:hidden name="middleLedgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" onclick="$('#wtlbTreeSelectWrap').window('open')"></img>
						<%-- <image id='lr_openWtlbTree' src='<%=request.getContextPath()%>/pages/introcontrol/util/themes/icons/search.png' style='border:0px;'></image> --%> 
					</td>					
					<td class="EditHead" width="15%">备注(问题点为其他)</td>
					<td class="editTd" width="35%">
					<s:textfield name="middleLedgerProblem.problemComment" id="problemComment"  cssClass="noborder"/>
					<input type="hidden" id="middleLedgerProblem.problemComment.maxlength" value="1000">						
					</td>
				</tr>									
				<tr>
					<td class="EditHead">发生金额</td>
					<td class="editTd">
						<%-- <input type="text" name="middleLedgerProblem.problem_money" id="problem_money" cssStyle="width:45%;border:0" maxlength="15" value='<fmt:formatNumber value="${middleLedgerProblem.problem_money}" pattern="###.############"/>' />&nbsp;万元 --%>					
						<s:textfield name="middleLedgerProblem.problem_money" id="problem_money" cssStyle="width:34%" doubles="true" maxlength="15" cssClass="noborder"/>&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd"><s:textfield name="middleLedgerProblem.problemCount" id="problemCount" cssStyle="width:34%" doubles="true" maxlength="5" cssClass="noborder"/>&nbsp;个</td>
				</tr>
				<tr>
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<input type="text" id="creater_startdate" name="middleLedgerProblem.creater_startdate"  editable="false"
								value="${middleLedgerProblem.creater_startdate }" class="easyui-datebox" style="width: 160px"/>
						</td>
					
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<input type="text" id="creater_enddate" name="middleLedgerProblem.creater_enddate"  editable="false"
								value="${middleLedgerProblem.creater_enddate }" class="easyui-datebox" style="width: 160px"/>	
					</td>
					
				</tr>
				<tr>
					<td class="EditHead">审计发现类型</td>
					<td class="editTd">
						<%-- <s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" name="middleLedgerProblem.problem_grade_code"></s:select> --%>
						<select id="problem_grade_code" class="easyui-combobox" name="middleLedgerProblem.problem_grade_code" style="width:160px;" editable="false" data-options="panelHeight:100">
					       <option value="">&nbsp;</option>
					       <s:iterator value="basicUtil.problemMethodList" id="entry">
						         <s:if test="${middleLedgerProblem.problem_grade_code==code}">
					       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
					       		 </s:if>
					       		 <s:else>
							        <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       		 </s:else>
					       </s:iterator>
					    </select>	
						</td>
<%-- 					<td class="EditHead">会计制度类型</td>
					<td class="editTd">
						<s:select id="accountantSystemTypeCode" name="middleLedgerProblem.accountantSystemTypeCode" cssStyle="width:34%" onchange="accountantSystemTypeFun();" list="basicUtil.accountingTypeList" listKey="code" listValue="name" headerKey="" headerValue="" theme="ufaud_simple" templateDir="/strutsTemplate" />
						<select id="accountantSystemTypeCode" class="easyui-combobox" name="middleLedgerProblem.accountantSystemTypeCode" style="width:160px;" editable="false" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.accountingTypeList" id="entry">
							         <s:if test="${middleLedgerProblem.accountantSystemTypeCode==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						 </select>
						<input type="hidden" id="accountantSystemTypeName" name="middleLedgerProblem.accountantSystemTypeName"/>
						
						
					</td> --%>					
				</tr>
				<tr>
					<s:if test="middleLedgerProblem.pro_type == '020312'">
						<td class="EditHead"><FONT color=red>(经济责任审计)</FONT>责任</td>
						<td class="editTd" >
						<%-- <select id="zeren" name="middleLedgerProblem.zerencode" onchange="zerenOpr();" class="easyui-combobox" editable="false" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="%{problemList2}" status="status">
									<option value="<s:property value='%{problemList2[#status.index].code}'/>"><s:property value='%{problemList2[#status.index].name}' /></option>
								</s:iterator>
						</select> --%>
						<select id="zeren" class="easyui-combobox" name="middleLedgerProblem.zerencode" style="width:160px;" editable="false" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="%{problemList2}" id="entry">
							         <s:if test="${middleLedgerProblem.zerencode==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						 </select>
						 <input type="hidden" id="zerencname" name="middleLedgerProblem.zeren"/>
						<select id="zerenattach" name="zerenattach" style="display: none;">
								<option value="">&nbsp;</option>
								<s:iterator value="%{problemList2}" status="status">
									<option value="<s:property value='%{problemList2[#status.index].code}'/>">
									<s:property value='%{problemList2[#status.index].note}' /></option>
								</s:iterator>
						</select>
						</td>					
					</s:if>
					<s:else>
						<td class="EditHead"><FONT color=red>(非经济责任审计)</FONT>责任</td>
						<td class="editTd" >
						<select id="zeren" name="middleLedgerProblem.zerencode" onchange="zerenOpr();" class="easyui-combobox" editable="false" data-options="panelHeight:100">
								<option value=""></option>
								<s:iterator value="%{problemList}" status="status">
									<option
										value="<s:property value='%{problemList[#status.index].code}'/>"><s:property value='%{problemList[#status.index].name}' /></option>
								</s:iterator>
						</select> 
						<select id="zerenattach" name="zerenattach"
							style="display: none;">
								<option value=""></option>
								<s:iterator value="%{problemList}" status="status">
									<option
										value="<s:property value='%{problemList[#status.index].code}'/>"><s:property
											value='%{problemList[#status.index].note}' /></option>
								</s:iterator>
						</select>
						</td>
					
					
					</s:else>
						<td class="EditHead"></td>
					  <td class="editTd"></td>
				</tr>
				<tr>
					<td class="EditHead">发现人</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.creater_name"/>
					</td>
					<td class="EditHead">发现时间</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_date"/>
					</td>
				</tr>	
				<tr>
					<td class="EditHead">被审计单位</td>
					<td class="editTd" >
						<%-- 	<s:select list="auditObjectMap" listValue="value" listKey="key"  name="ledgerProblem.audit_object"  cssStyle='width:200px;'>
 						</s:select>
 						<s:hidden name="ledgerProblem.audit_object_name"/> --%>							
 						
 						<select id="audit_object" class="easyui-combobox" style="width:160px;" editable="false" data-options="panelHeight:50">
						       <s:iterator value="auditObjectMap" id="entry">
							         <s:if test="${middleLedgerProblem.audit_object==key}">
						       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       		 </s:else>
						       </s:iterator>
						 </select>
					</td>
					<td class="EditHead"></td>
					 <td class="editTd"></td>
				</tr>
				<tr>
					<td class="EditHead">问题摘要</td>
					<td class="editTd" colspan="3">
						<s:textarea id="describe" name="middleLedgerProblem.describe" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:160%;" title="问题摘要"/>
						<input type="hidden" id="middleLedgerProblem.describe.maxlength" value="6000"/>							
					</td>
				</tr>		
				<tr>
					<td class="EditHead">定性依据</td>
					<td class="editTd" colspan="3">
						<s:textarea id="audit_law" name="middleLedgerProblem.audit_law" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:160%;" title="定性依据"/>
						<input type="hidden" id="middleLedgerProblem.audit_law.maxlength" value="2000"/>							
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计建议</td>
					<td class="editTd" colspan="3">
						<s:textarea id="audit_advice" name="middleLedgerProblem.audit_advice" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:160%;" title="审计建议"/>
							<input type="hidden" id="middleLedgerProblem.audit_advice.maxlength" value="2000"/>								
					</td>
				</tr>									
			</table>
			
			<s:hidden name="project_id" />
			<s:hidden name="manuscript_id" />
			<s:hidden name="manuscriptType" />
			
			<s:hidden name="middleLedgerProblem.id" />
			<s:hidden name="middleLedgerProblem.project_id" />
			<s:hidden name="middleLedgerProblem.project_code" />
			<s:hidden name="middleLedgerProblem.project_name" />
			<s:hidden name="middleLedgerProblem.pro_year" />
			<s:hidden name="middleLedgerProblem.pro_type" />
			<s:hidden name="middleLedgerProblem.pro_type_name" />
			<s:hidden name="middleLedgerProblem.pro_type_child" />
			<s:hidden name="middleLedgerProblem.pro_type_child_name" />		
			<s:hidden name="middleLedgerProblem.real_start_time" />
			<s:hidden name="middleLedgerProblem.real_closed_time" />
			<s:hidden name="middleLedgerProblem.pro_teamleader" />
			<s:hidden name="middleLedgerProblem.pro_teamleader_name" />
			<s:hidden name="middleLedgerProblem.audit_dept" />
			<s:hidden name="middleLedgerProblem.audit_dept_name" />
			<input type="hidden" id="audit_object_id" name="middleLedgerProblem.audit_object" />
			<input type="hidden" id="audit_object_name" name="middleLedgerProblem.audit_object_name"/>
			<s:hidden name="middleLedgerProblem.taskTemplateId" />
			<s:hidden name="middleLedgerProblem.templateId" />
			<s:hidden name="middleLedgerProblem.taskPid" />
			<s:hidden name="middleLedgerProblem.task_name" />
			<s:hidden name="middleLedgerProblem.taskAssign" />
			<s:hidden name="middleLedgerProblem.taskAssignName" />
			<s:hidden name="middleLedgerProblem.manuscript_id" />
			<s:hidden name="middleLedgerProblem.manuscript_code" />
			<s:hidden name="middleLedgerProblem.manuscript_name" />
			<s:hidden name="middleLedgerProblem.manuscript_creator" />
			<s:hidden name="middleLedgerProblem.manuscript_creator_name" />
			<s:hidden name="middleLedgerProblem.m_audit_dept_code" />
			<s:hidden name="middleLedgerProblem.m_audit_dept" />
			<s:hidden name="middleLedgerProblem.manuscript_date" />
			<s:hidden name="middleLedgerProblem.digao_state" />
			<s:hidden name="middleLedgerProblem.problem_grade_name" />
			<s:hidden name="middleLedgerProblem.p_unit_code" />
			<s:hidden name="middleLedgerProblem.p_unit" />
			<s:hidden name="middleLedgerProblem.creater_startdate" />
			<s:hidden name="middleLedgerProblem.creater_enddate" />
			<s:hidden name="middleLedgerProblem.creater_code" />
			<s:hidden name="middleLedgerProblem.creater_name" />			
			<s:hidden name="middleLedgerProblem.problem_date" />		
			
			<s:hidden name="middleLedgerProblem.quantify" />			
			
			
			<s:hidden name="tableType" />
			<input type="hidden" id="att" name="att" value="">
			<input type="hidden" id="att2" name="att2" value="">	
			<%-- <s:if test="${viewFlag != 'view'}">
				<input id='lr_openZcfgTree' mc='problem_desc' type="button" value="引用法规制度11" />
				<s:button value="保存" onclick="this.style.disabled='disabled';saveForm1('${middleLedgerProblem.pro_type }');" />&nbsp;&nbsp;
				<s:if test="${tableType != '1'}">
					<s:button value="返回" onclick="back();" />&nbsp;&nbsp;
					<s:button value="删除" onclick="deletePro('${middleLedgerProblem.id}');" />
				</s:if>
			</s:if> --%>
			

			
		</s:form>
		<jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" />
	    </div>
	</div>
	     
	<!-- 问题类别树 -->
	<div id='wtlbTreeSelectWrap' title='问题类别' style='overflow:hidden; margin:0px;'>
		<div id="container" class='easyui-layout' fit='true' >
			<div  region="west"  split="true" style='overflow:hidden;width:250px;' title=''>
				<ul id='auditObjectTreeId'></ul>
		    </div>
		    <div region="center">
		    	 <div id="qtab" class="easyui-tabs"  fit="true" style="overflow-x:auto;">
		    	 	<!--  
		    		<div title='问题案例信息' id='tab2'>
		    			<table id='orgTable'></table>
		    		</div>
		    		-->
		    	 </div>
		    </div>
		    <div region="south" style="height:40px;padding:5px 5px 3px 5px;text-align:right;overflow:hidden;">
			 	<button id='sureSelectWtlbTreeNode'  class="easyui-linkbutton" iconCls="icon-add">添加</button>&nbsp;&nbsp;
			 	<button id='closeSelectWtlbTreeNode' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button> 
		 </div>
		 </div>
		 			    		    				 	
	</div>
	     
	<script language="javascript">
		function triggerTab(tab) {
			var isDisplay = document.getElementById(tab).style.display;
			if (isDisplay == '') {
				document.getElementById(tab).style.display = 'none';
			} else {
				document.getElementById(tab).style.display = '';
			}
		}
		function saveForm() {
			var problem_money = document.getElementById("problem_money").value;
			var creater_startdate = document.getElementById("creater_startdate").value.replace(/-/g, "/");
			var creater_enddate = document.getElementById("creater_enddate").value.replace(/-/g, "/");
			var d1 = new Date(creater_startdate);
			var d2 = new Date(creater_enddate);
			if (Date.parse(d1) - Date.parse(d2) > 0) {
				showMessage1("问题所属开始日期不能大于结束日期!");
				return false;
			}

			if (frmCheck(document.forms[0], 'tab1')) {
				if (!isMoneyNum1(problem_money)) {
					showMessage1("发生数应该填写金额!");
					return false;
				}
				var p_unit = document.getElementsByName("middleLedgerProblem.p_unit_code")[0].value;
				if (p_unit == '' || p_unit == null) {
					showMessage1("请选择统计数量单位!");
					return false;
				}
				//取得 select 的text值
				var selectObj = document.getElementById("mendSelect");
				document.getElementById("middleLedgerProblem.mend_method").value = selectObj.options[selectObj.selectedIndex].text;
				var selectObj = document.getElementById("examineSelect");
				document.getElementById("middleLedgerProblem.examine_method").value = selectObj.options[selectObj.selectedIndex].text;
				var mend_term = document.getElementById("mend_term").value;
				var mend_term_enddate = document.getElementById("mend_term_enddate").value;
				var isNotMend = document.getElementById("isNotMend").value;
				if (isNotMend == '是') {
					if (mend_term == null || mend_term == '') {
						showMessage1("整改期限开始日期不能为空!");
						return false;
					}
					if (mend_term_enddate == null || mend_term_enddate == '') {
						showMessage1("整改期限结束日期不能为空!");
						return false;
					}
					/*var dts = new Date(Date.parse(mend_term.replace(/-/g, "/")));
					var dte = new Date(Date.parse(mend_term_enddate.replace(/-/g, "/")));
					if (dte < dts) {
						alert("结束日期不能小于开始日期!");
						return false;
					}*/
					 if(judgeTimeS_E(mend_term,mend_term_enddate)){
					      return true;
					   }else{
					     return false;
					   }
				}
				
				$.ajax({
					type : "POST",
					url : "${contextPath}/proledger/problem/save.action",
					data : $("#myform").serialize(),
					success : function(msg) {
						if (msg == 1) {
							parent.doSelectWrap();
						}
					}
				});
			}
		}
		  /*
		 *校验问题所属结束日期必须大于问题所属开始日期 
		 */
		function judgeTimeS_E(mend_term,mend_term_enddate){
			//结束时间必须大于开始时间的校验
			if(mend_term!=null && mend_term!="" && mend_term_enddate!=null && mend_term_enddate!=""){
			   	    var reg=new RegExp("-","g"); //创建正则RegExp对象
			        var tempBeginTime=(mend_term).replace(reg,"");
			        var tempEndTime=(mend_term_enddate).replace(reg,"");
			        var today   =   new   Date();    //获得当前时间
			        var date=today.getDate();//格式化拼接获得正确的当前时间
			        month=today.getMonth();
			        month=month+1;
			        if(month<=9)
			        month="0"+month;
			        year=today.getYear();
			        var nowDate=year+'-'+month+'-'+date;
			        var tempDate=(nowDate).replace(reg,"");
			        var ts=tempBeginTime-0;
			        var te=tempEndTime-0;
			        var tt=tempDate-0;
			        /* if(ts<tt){
			             alert("问题所属开始日期不能小于当前时间!");
			             return false;
			        }else if(te<tt){
			             alert("问题所属结束日期必须大于当前时间!");
			             return false;
			         }else */
			        if(ts>te){
			             showMessage1("问题所属开始日期必须小于问题所属结束日期!");
			             return false;
			         }
			             return true;
			}
		             return true;
		}	
		function saveForm1(proType) {
			//if (frmCheck(document.forms[0], 'tab1')) {
				var problem_name = document.getElementById("problem_name").value;
				var text = $('#audit_object').combobox('getText');
				var value = $('#audit_object').combobox('getValues');
				$('#audit_object_id').val(value);
				$('#audit_object_name').val(text);
				//var sel=document.getElementsByName("middleLedgerProblem.problem_grade_code")[0];
				//var problem_grade_code= sel.options[sel.options.selectedIndex].value;
				//var sel1=document.getElementsByName("middleLedgerProblem.zeren")[0];
				//var zeren= sel1.options[sel1.options.selectedIndex].value;
				if(problem_name != '其他'){
					if(problem_name == ''||problem_name == null){
						showMessage1("请选择问题点！");
						return false;
					}
				}else{
					var problemComment = document.getElementById("problemComment").value;
					if (problemComment == '' || problemComment == null) {
							showMessage1("请填写备注!");
							return false;
						}
				}
				/*if (problem_grade_code == '' || problem_grade_code == null) {
					alert("请选择问题性质!");
					return false;
				}
				if(proType == '020312'){
					var zeren= sel1.options[sel1.options.selectedIndex].value;
					if (zeren == '' || zeren == null) {
						alert("请选择责任!");
						return false;
					}
				}*/

				var problemCount = document.getElementById("problemCount").value;
				var regu = /^[0-9]\d*$/;
				if (problemCount!= '' && problemCount!= null) {
					if(!regu.test(problemCount)){
						showMessage1("请输入整数");
						return false;
					}
				}
				
				var tempVal = $("#problem_money").val();
				if(tempVal!='' && tempVal!=null){
					if(!/^(\d+(,\d\d\d)*(\.\d{2})?|\d+(\.\d{1,2})?)$/.test(tempVal)){
						showMessage1("发生金额填写数字，最多支持2位小数!");
						return false;
					}
				}		
				
				var tempAudit_con=$("#audit_con").val();
				if(tempAudit_con == ''||tempAudit_con == null){
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"问题标题不能为空！"
					});
					return false;
				}

				$.ajax({
					type : "POST",
					dataType:"json",
					async:false,
					url : "${contextPath}/proledger/problem/save2.action?t="+new Date().getTime(),
					data : $("#myform").serialize(),
					success : function(msg) {
						if (msg[0] == 1) {
							window.parent.$.messager.show({
								title:"提示信息",
								msg:"保存成功！"
							});
							parent.doSelectWrap();
						}
					}
				});
				
			//}
			
		}
			

		function callback() {
			var codes = document.getElementById("att").value;
			var names = document.getElementById("att2").value;
			var sort_code = codes.split("#");
			var sort_name = names.split("#");
			var allName =sort_name[sort_name.length - 2];
			document.getElementsByName("middleLedgerProblem.problem_code")[0].value = sort_code[0];
			if (sort_code.length - 4 <= 0) {
				document.getElementsByName("middleLedgerProblem.sort_three_code")[0].value = '';
			} else {
				document.getElementsByName("middleLedgerProblem.sort_three_code")[0].value = sort_code[sort_code.length - 4];
			}
			if (sort_code.length - 3 == 0) {
				document.getElementsByName("middleLedgerProblem.sort_small_code")[0].value = '';
			} else {
				document.getElementsByName("middleLedgerProblem.sort_small_code")[0].value = sort_code[sort_code.length - 3];
				allName = allName+" - "+sort_name[sort_name.length - 3];
			}
			document.getElementsByName("middleLedgerProblem.sort_big_code")[0].value = sort_code[sort_code.length - 2];
			document.getElementsByName("middleLedgerProblem.problem_name")[0].value = sort_name[0];
			if (sort_name.length - 4 <= 0) {
				document.getElementsByName("middleLedgerProblem.sort_three_name")[0].value = '';
			} else {
				document.getElementsByName("middleLedgerProblem.sort_three_name")[0].value = sort_name[sort_name.length - 4];
				allName = allName+" - "+sort_name[sort_name.length - 4];
				
			}
			if (sort_name.length - 3 == 0) {
				document.getElementsByName("middleLedgerProblem.sort_small_name")[0].value = '';
			} else {
				document.getElementsByName("middleLedgerProblem.sort_small_name")[0].value = sort_name[sort_name.length - 3];
			}
			document.getElementsByName("middleLedgerProblem.sort_big_name")[0].value = sort_name[sort_name.length - 2];
			document.getElementsByName("middleLedgerProblem.problem_all_name")[0].value = allName;
			//problemUnitList(sort_code[0], '');
			doProblemComment(sort_name[0]);
			//$("#problem_desc").val("");	
			if(sort_name[0] != "其他"){
				getGist(sort_code[0]);
			}
		}

		//获取定性依据
		function getGist(problemCode) {
			$.ajax({
				type : "POST",
				url : "${contextPath}/proledger/problem/saveOprateTask!getGist.action",
				data : {
					"problemCode" : problemCode
				},
				success : function(msg) {
					if (msg != "") {
						$("#problem_desc").val(msg);
					}
				}
			});
		}
		
		//是否允许填写“备注”
		 function doProblemComment(problem_name){
			 if(problem_name == '其他' || problem_name == '其它'){
				 $("#ft").remove();
				 $("#problemComment").css("display","block");
				 $("#problemCommentText").append("<FONT color=red id=ft>*</FONT>");
				 $("#problemComment").attr("maxlength",1000);
			 }else{
				 $("#problemComment").val("");
				 $("#problemComment").css("display","none");
				 $("#problemCommentText").html("").html("备注(问题点为其他)");
			 }
		 }
		function loadZeren(zeren){
			$('#zeren').combobox('setText',zeren);
		}
		/**
		 取得数量单位的下拉菜单
		 **/
		function problemUnitList(problemCode, problemUnitCode) {
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);
			DWRActionUtil.execute({
				namespace : '/proledger/problem',
				action : 'problemUnitList',
				executeResult : 'false'
			}, {
				'problemCode' : problemCode,
				'problemUnitCode' : problemUnitCode
			}, xxx);
			function xxx(data) {
				problemUnitSelect = data['problemUnitSelect'];
				if (problemUnitSelect == null) {
					problemUnitSelect = '';
				}
				document.getElementById('unitsDiv').innerHTML = problemUnitSelect;
			}
		}

		function back() {
			//window.location.href = "${contextPath}/proledger/problem/listDigaoEditProblem.action?project_id=${project_id}&manuscript_id=${manuscript_id}&manuscriptType=${manuscriptType}&isView=false";
			parent.closeSelectWrap();
		}
	//删除问题记录
	function deletePro(id){
		DWREngine.setAsync(true);
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true){
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:"/proledger/problem", action:"deleteLedgerProblem", executeResult:"false" }, 
				{'id':id},backRefu);
				
			function backRefu(data){
				var a= 	window.parent.document.getElementById("audit_con");
			  	a.value="无问题";
			  	parent.closeSelectWrap();
			} 
		}
	}	
	

		function accountantSystemTypeFun(){
			$("#accountantSystemTypeName").val($("#accountantSystemTypeCode").find("option:selected").text());
		}
		function zerenOpr(){
			//alert("zerenCode:"+$("#zeren").val()+"|name:"+$("#zeren option:selected").text());
			var zerenval = $("#zeren").val();
			$("#zerenattach option[value="+zerenval+"]").attr("selected",true);		
			$("#audit_law").val($("#audit_law").val()+"\n\n"+$("#zerenattach option:selected").text());
			//alert("zerenattachCode:"+$("#zerenattach").val()+"|zerenattachname:"+$("#zerenattach option:selected").text());
		}
			//problemUnitList('${middleLedgerProblem.problem_code}', '${middleLedgerProblem.p_unit_code}');
		$('#zeren').combobox({
			onChange:function(newValue,oldValue){
				$("#zerenattach option[value="+newValue+"]").attr("selected",true);		
				$("#audit_law").val($("#audit_law").val()+"\n\n"+$("#zerenattach option:selected").text().trim());
			}
		});
		
	</SCRIPT>
</body>
</html>
