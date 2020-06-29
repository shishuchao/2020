<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/ais.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/css.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
				

<head>
<title><s:property value="#title" /></title>
<s:head />
<script type="text/javascript">
$(function(){
	$("#zeren option[value="+'${ledgerProblem.zerencode}'+"]").attr("selected",true);
	accountantSystemTypeFun();
   var problemComment = $("#problemComment").val();
   if(problemComment != ""){
       $("#problemComment").css("display","block");
	   /* $("#problemCommentText").append("<FONT color=red>*</FONT>"); */
   }
   $("#quantify").change(function(){
	   var checkValue = $("#quantify").val();
	   if(checkValue=='是'){
		   document.myform.problem_money.disabled = false;
		   document.myform.problemCount.disabled = false;
	   }else{
		   document.myform.problem_money.value = "";
		   document.myform.problemCount.value = "";
		   document.myform.problem_money.disabled = true;
		   document.myform.problemCount.disabled = true;
		   
	   }
   });    
   
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
                                                        $.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
                                                    }
                                                });
                                                var content = [];
                                                content.push("<div style='overflow:hidden;'><table class='ListTable'>");
                                                content.push("<tr><td style='text-align:center;' class='ListTableTr11'>正文</td></tr>");
                                                content.push("<tr><td style='width:100%;' class='ListTableTr22'>");
                                                content.push("<textarea class='mytabcontent' readonly style='border-width:0px;word-break:break-all;word-wrap:break-word;height:140px;overflow:auto;width:590px;padding:5px;color:gray;'>");
                                                content.push(row.case_content);
                                                content.push("</textarea></td></tr>");
                                                content.push("<tr><td class='ListTableTr11'><span style='float:left;'>附件信息</span><span style='float:right;color:gray;'>文件总数："+(fjStr.split('<li').length-1)+"</span></td></tr>");
                                                content.push("<tr><td style='width:100%;' class='ListTableTr22'><div style='color:gray;padding:5px 5px 5px 1px;height:105px;overflow:auto;'>");
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
							$.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
						}
			       });
                }catch(e){
                    alert('genAuditCaseTabs:\n'+e.message);
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
			width:870,   
			height:410,   
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			inline:true,
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
					if(snode.state){
						$.messager.alert('提示信息','不能添加问题类别，请选择问题点','error');
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
									alert('入报告失败');
								}		
							},
							error:function(data){
								alert('请求失败！');
							}
						});
					    //$('#problem_code').val(snode.id);
					    //$('#problem_name').val(snode.text);
					    $('#wtlbTreeSelectWrap').window('close');
					}
				}else{
					$.messager.alert('提示信息','请选择问题点','error');
				}

			});
			$('#closeSelectWtlbTreeNode').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('close');
			});

});
</script>
</head>
<body onload="doProblemComment('${ledgerProblem.problem_name}');">
	<center>
		<s:form id="myform" action="save" namespace="/proledger/problem">
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" id="tab1">
				<tr>
					<td class="ListTableTr11">问题类别${ledgerProblem.zeren}</td>
					<td class="ListTableTr22" >
						<s:textfield id="problem_all_name" name="ledgerProblem.problem_all_name" cssStyle="width:70%" readonly="true" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT>
						<s:hidden id="sort_big_code" name="ledgerProblem.sort_big_code" />
						<s:hidden id="sort_big_name" name="ledgerProblem.sort_big_name" />
						<s:hidden id="sort_small_code" name="ledgerProblem.sort_small_code" />
						<s:hidden id="sort_small_name" name="ledgerProblem.sort_small_name" />
						<s:hidden id="sort_three_code" name="ledgerProblem.sort_three_code" />
						<s:hidden id="sort_three_name" name="ledgerProblem.sort_three_name" />
						<s:hidden id="ledgerProblem_id" name="ledgerProblem.id" />
						<%--<input type="hidden" id="ledgerProblem_id" name="ledgerProblem.id"/>
					--%></td>
					<td class="ListTableTr11">审计问题编号</td>
					<td class="ListTableTr22" >
						<s:textfield name="ledgerProblem.serial_num" id="serial_num" cssStyle="width:75%" readonly="true" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT>
					</td>
					<%-- <td class="ListTableTr11">问题一级分类:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.sort_big_name" cssStyle="width:90%" readonly="true" /> <s:hidden name="ledgerProblem.sort_big_code" /></td>
					<td class="ListTableTr11">问题二级分类:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.sort_small_name" cssStyle="width:90%" readonly="true" /> <s:hidden name="ledgerProblem.sort_small_code" /></td>
					<td class="ListTableTr11">问题三级分类:</td>
					<td class="ListTableTr22" style="width:25%;"><s:textfield name="ledgerProblem.sort_three_name" cssStyle="width:90%" readonly="true" /> <s:hidden name="ledgerProblem.sort_three_code" /></td> --%>
				</tr>
				<tr>
					<td class="ListTableTr11" width="15%"><FONT color=red>*</FONT>问题点</td>
					<td class="ListTableTr22" width="35%">
						<s:textfield name="ledgerProblem.problem_name" id="problem_name" cssStyle="width:70%" readonly="true"/> 
						<s:hidden name="ledgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						<image id='lr_openWtlbTree' src='<%=request.getContextPath()%>/pages/introcontrol/util/themes/icons/search.png' style='border:0px;'></image> 
						<!-- <img src="<%=request.getContextPath()%>/resources/images/s_search.gif" 
							onclick="showPopWin('<%=request.getContextPath()%>/pages/ledger/problem_tree/select/searchdata.jsp?url=<%=request.getContextPath()%>/ledger/problemledger/allTree.action&paraname=att2&paraid=att&funname=callback()',550,300)" 
							border="0" style="cursor: hand">  -->
					</td>
					<td class="ListTableTr11" id="problemCommentText"  width="15%">备注(问题点为其他)</td>
					<td class="ListTableTr22" width="35%">
					<s:textarea name="ledgerProblem.problemComment" id="problemComment" cssStyle="width:74%;height:30px;display:none" />
					<input type="hidden" id="ledgerProblem.problemComment.maxlength" value="1000">
					</td>
				</tr>
<%-- 				<tr>
					<td class="ListTableTr11"><FONT color=red>*</FONT>是否可量化</td>
					<td class="ListTableTr22" colspan="3">
						${ledgerProblem.quantify}
					</td>
				</tr> --%>
				<tr>
					<td class="ListTableTr11">发生金额</td>
					<td class="ListTableTr22">
						<input type="text" name="ledgerProblem.problem_money" id="problem_money" cssStyle="width:70%" maxlength="15" readonly="true" value='<fmt:formatNumber value="${ledgerProblem.problem_money}" pattern="###.############"/>'/>&nbsp;万元					
					</td>
					<td class="ListTableTr11">发生数量</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.problemCount" id="problemCount" cssStyle="width:74%" readonly="true" doubles="true" maxlength="5" />&nbsp;个</td>
					
				</tr>
				
				<tr>
					<td class="ListTableTr11">问题所属开始日期</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.creater_startdate" id="creater_startdate" readonly="true" title="单击选择日期" cssStyle="width:70%" maxlength="20" /></td>
					<td class="ListTableTr11">问题所属结束日期</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.creater_enddate" id="creater_enddate" readonly="true" title="单击选择日期" cssStyle="width:74%" maxlength="20" /></td>
				</tr>
				<%-- <tr>
					<td class="ListTableTr11">创建人:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.problemCreater" id="problemCreater" cssStyle="width:90%" doubles="true" maxlength="15" /></td>
				</tr>
				<tr>
					<td class="ListTableTr11">问题定性: <FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22"><s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" name="ledgerProblem.problem_grade_code"></s:select></td>
					<td class="ListTableTr11">统计数量单位: <FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22" id="unitsDiv"></td>
					<td class="ListTableTr11">被审计单位:</td>
					<td class="ListTableTr22"><s:buttonText2 id="audit_object_name" hiddenId="audit_object" name="ledgerProblem.audit_object_name" cssStyle="width:90%" hiddenName="ledgerProblem.audit_object" doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/utilTee/ansyCheckBoxTreeFrame.jsp?urlAction=${pageContext.request.contextPath}/proledger/problem/utilTree!ansyMakeAudedUnitZtree.action?isFirstLoad=yes&parentid=${ledgerProblem.audit_dept}&nameid=audit_object_name&codeid=audit_objects&chkStyle=radio&radioType=all',600,450,'被审单位');" doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" /></td>
				</tr> --%>
				<tr>
					<td class="ListTableTr11">审计发现类型</td>
					<td class="ListTableTr22">
					${ledgerProblem.problem_grade_name}
					</td>
                    <td class="ListTableTr11">会计制度类型</td>
					<td class="ListTableTr22">
					${ledgerProblem.accountantSystemTypeName}
					</td>
				</tr>
				<tr>
					<s:if test="ledgerProblem.pro_type == '020312'">
						<td class="ListTableTr11">责任<div>(经济责任审计)</div></td>
						<td class="ListTableTr22" colspan="3">
							${ledgerProblem.zeren}					
						</td>						
					</s:if>
					<s:else>
						<td class="ListTableTr11">责任<div>(非经济责任审计)</div></td>
						<td class="ListTableTr22" colspan="3">
							${ledgerProblem.zeren}					
						</td>
					</s:else>
				</tr>
				<s:if test="${tableType == '1'}">
					<tr>
						<td class="ListTableTr11">
							关联底稿
						</td>
						<td>
							<s:textfield name="ledgerProblem.linkManuName"  cssStyle='width:260px' readonly="true" />
							<!--一般文本框-->
							<s:hidden name="ledgerProblem.linkManuId" />
							<img src="<%=request.getContextPath()%>/resources/images/s_search.gif" onclick="getOwerManu()" border=0 style="cursor: hand">
						</td>
						<td class="ListTableTr11">
							<font color="red">*</font> 被审计单位
						</td>
						<td  colspan="1">
							<s:textfield name="ledgerProblem.audit_object_name" cssStyle='width:260px' readonly="true" />
							<s:hidden name="ledgerProblem.audit_object" />
							<img src="<%=request.getContextPath()%>/resources/images/s_search.gif" onclick="getGroup();" border=0 style="cursor: hand">
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">审计结论</td>
						<td class="ListTableTr22" colspan="5">
							<s:textarea name="ledgerProblem.sjjl" title="审计结论" id="sjjl" cssClass='autoResizeTexareaHeight' cssStyle="width:90%;height:200" />
							<input type="hidden" id="ledgerProblem.sjjl.maxlength" value="500">
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">事实描述</td>
						<td class="ListTableTr22" colspan="5">
							<s:textarea name="ledgerProblem.ssms" title="事实描述" id="ssms" cssClass='autoResizeTexareaHeight' cssStyle="width:90%;height:200" />
							<input type="hidden" id="ledgerProblem.ssms.maxlength" value="500">
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">处理决定</td>
						<td class="ListTableTr22" colspan="5">
							<s:textarea name="ledgerProblem.cljd" title="处理决定" id="cljd" cssClass='autoResizeTexareaHeight' cssStyle="width:90%;height:200" />
							<input type="hidden" id="ledgerProblem.cljd.maxlength" value="500">
						</td>
					</tr>
				</s:if>
				<tr>
					<td class="ListTableTr11">定性依据<br><font color=DarkGray>(限3000字)</font></td>
					<td class="ListTableTr22" colspan="5">
						<s:textarea name="ledgerProblem.audit_law" title="定性依据" id="problem_desc" cssClass='autoResizeTexareaHeight' readonly="true" cssStyle="width:90%;height:200" />
						<input type="hidden" id="ledgerProblem.audit_law.maxlength" value="3000">
					</td>
				</tr>
				
			</table>
			<!-- <div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab2');">问题整改要求</a>
				</div> -->
			<%-- <table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" id="tab2" style="display: none;">
				<tr>
					<td class="ListTableTr11">是否需要整改:</td>
					<td class="ListTableTr22"><s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" name="ledgerProblem.isNotMend" id="isNotMend" emptyOption="true"></s:select></td>
					<td class="ListTableTr11">整改期限:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.mend_term" id="mend_term" readonly="true" title="单击选择日期" onclick="calendar()" cssStyle="width:30%" maxlength="20" /> 至 <s:textfield name="ledgerProblem.mend_term_enddate" id="mend_term_enddate" readonly="true" title="单击选择日期" onclick="calendar()" cssStyle="width:30%" maxlength="20" /></td>
				</tr>
				<tr>
					<td class="ListTableTr11">责任单位:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.zeren_company" maxlength="200" /></td>
					<td class="ListTableTr11">整改责任部门:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.zeren_dept" maxlength="200" /></td>

				</tr>
				<tr>
					<td class="ListTableTr11">整改负责人:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.zeren_person" maxlength="100" /></td>
					<td class="ListTableTr11">监督检查人:</td>
					<td class="ListTableTr22"><s:textfield name="ledgerProblem.examine_creater_code" maxlength="100" /></td>
				</tr>
				<tr>
					<td class="ListTableTr11">建议追责方式:</td>
					<td class="ListTableTr22"><s:select list="basicUtil.mendMethodList" listKey="code" id="mendSelect" listValue="name" emptyOption="true" name="ledgerProblem.mend_method_code">
						</s:select> <s:hidden name="ledgerProblem.mend_method"></s:hidden></td>
					<td class="ListTableTr11">检查方式:</td>
					<td class="ListTableTr22"><s:select list="basicUtil.examineMethodList" listKey="code" id="examineSelect" listValue="name" emptyOption="true" name="ledgerProblem.examine_method_code">
						</s:select> <s:hidden name="ledgerProblem.examine_method"></s:hidden></td>
				</tr>
				<tr>
					<td class="ListTableTr11">整改建议:<font color=DarkGray>(限3000字)</font></td>
					<td class="ListTableTr22" colspan="7"><s:textarea name="ledgerProblem.aud_action_plan" title="整改建议" cssStyle="width:90%" /> <input type="hidden" id="ledgerProblem.aud_action_plan.maxlength" value="3000"></td>
				</tr>
			</table> --%>
			
			<s:hidden name="project_id" />
			<s:hidden name="manuscript_id" />
			<s:hidden name="manuscriptType" />
			<s:hidden name="ledgerProblem.project_id" value="${project_id}" />
			<s:hidden name="ledgerProblem.manuscript_id" value="${manuscript_id}" />
			<s:hidden name="ledgerProblem.id" />
			<s:hidden name="ledgerProblem.creater_code" />
			<s:hidden name="ledgerProblem.creater_name" />
			<s:hidden name="tableType" />
			<input type="hidden" id="att" name="att" value="">
			<input type="hidden" id="att2" name="att2" value="">
			<s:if test="${viewFlag != 'view'}">
			<input id='lr_openZcfgTree' mc='problem_desc' type="button" value="引用法规制度" />
			<s:button value="保存" onclick="this.style.disabled='disabled';saveForm1('${ledgerProblem.pro_type }');" />&nbsp;&nbsp;
			<s:if test="${tableType != '1'}">
				<s:button value="返回" onclick="back();" />&nbsp;&nbsp;
				<s:button value="删除" onclick="deletePro('${ledgerProblem.id}');" />
			</s:if>
			</s:if>
		</s:form>
		<jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" />
		<s:if test="">

		</s:if>
	     
	     
	<!-- 问题类别树 -->
	<div id='wtlbTreeSelectWrap' title='问题类别' style='overflow:hidden; margin:0px;'>
		<div id="container" class='easyui-layout' fit='true' >
			<div id='auditObjectTreeId' region="west"  split="true" style='overflow:hidden;width:250px;' title=''>
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
		    <div region="south" style="height:30px;padding:5px 5px 3px 5px;text-align:right;overflow:hidden;">
			 	<button id='sureSelectWtlbTreeNode'  class="easyui-linkbutton" iconCls="icon-add">添加</button>&nbsp;&nbsp;
			 	<button id='closeSelectWtlbTreeNode' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button> 
		 </div>
		 </div>
		 			    		    				 	
	</div>
	     
	</center>
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
				alert("问题所属开始日期不能大于结束日期!");
				return false;
			}

			if (frmCheck(document.forms[0], 'tab1')) {
				if (!isMoneyNum1(problem_money)) {
					alert("发生数应该填写金额!");
					return false;
				}
				var p_unit = document.getElementsByName("ledgerProblem.p_unit_code")[0].value;
				if (p_unit == '' || p_unit == null) {
					alert("请选择统计数量单位!");
					return false;
				}
				//取得 select 的text值
				var selectObj = document.getElementById("mendSelect");
				document.getElementById("ledgerProblem.mend_method").value = selectObj.options[selectObj.selectedIndex].text;
				var selectObj = document.getElementById("examineSelect");
				document.getElementById("ledgerProblem.examine_method").value = selectObj.options[selectObj.selectedIndex].text;
				var mend_term = document.getElementById("mend_term").value;
				var mend_term_enddate = document.getElementById("mend_term_enddate").value;
				var isNotMend = document.getElementById("isNotMend").value;
				if (isNotMend == '是') {
					if (mend_term == null || mend_term == '') {
						alert("整改期限开始日期不能为空!");
						return false;
					}
					if (mend_term_enddate == null || mend_term_enddate == '') {
						alert("整改期限结束日期不能为空!");
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
				
				var problemCount = document.getElementById("problemCount").value;
				if(fillNumOnly(problemCount)){
					 return true;
				}else{
					return false;
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
			             alert("问题所属开始日期必须小于问题所属结束日期!");
			             return false;
			         }
			             return true;
			}
		             return true;
		}	
		function saveForm1(proType) {
			if (frmCheck(document.forms[0], 'tab1')) {
				var problem_name = document.getElementById("problem_name").value;
				//var sel=document.getElementsByName("ledgerProblem.problem_grade_code")[0];
				//var problem_grade_code= sel.options[sel.options.selectedIndex].value;
				//var sel1=document.getElementsByName("ledgerProblem.zeren")[0];
				//var zeren= sel1.options[sel1.options.selectedIndex].value;
				if(problem_name != '其他'){
					if(problem_name == ''||problem_name == null){
						alert("请选择问题点！");
						return false;
					}
				}else{
					var problemComment = document.getElementById("problemComment").value;
					if (problemComment == '' || problemComment == null) {
							alert("请填写备注!");
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

				/*			
				var problemCount = document.getElementById("problemCount").value;
				var regu = /^[0-9]\d*$/;
				if (problemCount!= '' && problemCount!= null) {
					if(!regu.test(problemCount)){
						alert("请输入整数");
						return false;
					}
				}*/
				
				var tempVal = $("#problem_money").val();
				if(tempVal!='' && tempVal!=null){
					if(!/^(\d+(,\d\d\d)*(\.\d{2})?|\d+(\.\d{1,2})?)$/.test(tempVal)){
						alert("发生金额填写数字，最多支持2位小数!");
						return false;
					}
				}				
				
				var mend_term = document.getElementById("creater_startdate").value;
				var mend_term_enddate = document.getElementById("creater_enddate").value;
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
			       /*   if(ts<tt){
			             alert("问题所属开始日期不能小于当前时间!");
			             return false;
			        }else if(te<tt){
			             alert("问题所属结束日期必须大于当前时间!");
			             return false;
			         }else */
			         if(ts>te){
			             alert("问题所属开始日期必须小于问题所属结束日期!");
			             return false;
			         }
			}
				$.ajax({
					type : "POST",
					dataType:"json",
					async:false,
					url : "${contextPath}/proledger/problem/save.action?t="+new Date().getTime(),
					data : $("#myform").serialize(),
					success : function(msg) {
					
						if (msg[0] == 1) {
							alert('保存成功！');
							$("#ledgerProblem_id").val(msg[1]);
							$("#serial_num").val(msg[2]);
							parent.doSelectWrap();
						}
					}
				});
				
			}
			
		}
			

		function callback() {
			var codes = document.getElementById("att").value;
			var names = document.getElementById("att2").value;
			var sort_code = codes.split("#");
			var sort_name = names.split("#");
			var allName =sort_name[sort_name.length - 2];
			document.getElementById("ledgerProblem.problem_code").value = sort_code[0];
			if (sort_code.length - 4 <= 0) {
				document.getElementsByName("ledgerProblem.sort_three_code")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_three_code")[0].value = sort_code[sort_code.length - 4];
			}
			if (sort_code.length - 3 == 0) {
				document.getElementById("ledgerProblem.sort_small_code").value = '';
			} else {
				document.getElementById("ledgerProblem.sort_small_code").value = sort_code[sort_code.length - 3];
				allName = allName+" - "+sort_name[sort_name.length - 3];
			}
			document.getElementById("ledgerProblem.sort_big_code").value = sort_code[sort_code.length - 2];
			document.getElementById("ledgerProblem.problem_name").value = sort_name[0];
			if (sort_name.length - 4 <= 0) {
				document.getElementsByName("ledgerProblem.sort_three_name")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_three_name")[0].value = sort_name[sort_name.length - 4];
				allName = allName+" - "+sort_name[sort_name.length - 4];
				
			}
			if (sort_name.length - 3 == 0) {
				document.getElementById("ledgerProblem.sort_small_name").value = '';
			} else {
				document.getElementById("ledgerProblem.sort_small_name").value = sort_name[sort_name.length - 3];
			}
			document.getElementById("ledgerProblem.sort_big_name").value = sort_name[sort_name.length - 2];
			document.getElementById("ledgerProblem.problem_all_name").value = allName;
			//problemUnitList(sort_code[0], '');
			doProblemComment(sort_name[0]);
			$("#problem_desc").val("");	
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
			 }else{
				 $("#problemComment").val("");
				 $("#problemComment").css("display","none");
				 $("#problemCommentText").html("").html("备注(问题点为其他)");
			 }
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
	//选择引用底稿
    function  getOwerManu(){
    	var code=document.getElementsByName("project_id")[0].value; 
    	showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/manu/selectManu.action&a=a&manu=all&taskPid=-1&project_id='+code+'&paraname=ledgerProblem.linkManuName&paraid=ledgerProblem.linkManuId',600,400,'底稿选择')
    }
	
			//选择被审计单位
        	function getGroup(){
				var project_id = document.getElementsByName("project_id")[0].value;
          		var num=Math.random();
		  		var rnm=Math.round(num*9000000000+1000000000);
          		var url='/ais/pages/system/search/searchdataManu.jsp?url=<%=request.getContextPath()%>/operate/task/selectDept.action&a=a&x='+rnm+'&project_id='+project_id+'&paraname=ledgerProblem.audit_object_name&paraid=ledgerProblem.audit_object';
          		showPopWin(url,500,330,'被审计单位选择');
        	} 
	function accountantSystemTypeFun(){
		$("#accountantSystemTypeName").val($("#accountantSystemTypeCode").find("option:selected").text());
	}
	function zerenOpr(){
		//alert("zerenCode:"+$("#zeren").val()+"|name:"+$("#zeren option:selected").text());
		var zerenval = $("#zeren").val();
		$("#zerenattach option[value="+zerenval+"]").attr("selected",true);		
		$("#problem_desc").val($("#problem_desc").val()+"\n\n"+$("#zerenattach option:selected").text());
		//alert("zerenattachCode:"+$("#zerenattach").val()+"|zerenattachname:"+$("#zerenattach option:selected").text());
	}
		//problemUnitList('${ledgerProblem.problem_code}', '${ledgerProblem.p_unit_code}');
	</SCRIPT>
</body>
</html>
