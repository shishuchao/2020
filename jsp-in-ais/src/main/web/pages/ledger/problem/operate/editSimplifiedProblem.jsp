<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<s:if test="ledgerProblem.id!=null">
	<s:text id="title" name="'修改问题'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'增加问题'"></s:text>
</s:else>
<head>
<%-- <title><s:property value="#title" /></title> --%>

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
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
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
var parentTabId = '${parentTabId}';
var curTabId = aud$getActiveTabId();
$(function(){
	$("#audit_con").attr("maxlength",300);
	$("#describe").attr("maxlength",6000);
	$("#audit_law").attr("maxlength",2000);
	$("#audit_advice").attr("maxlength",2000);
	accountantSystemTypeFun();
    var problemComment = $("#problemComment").val();
    if(problemComment != ""){
       $("#problemComment").css("display","block");
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

        onDblClick:function(node){

            //	$('#sureSelectWtlbTreeNode').trigger('click');

        },
        onTreeClick:function(node, treeDom){

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
                                                top.$.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
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
                                        'content':"<div style='font-size:16px;text-align:center;padding:10px;'><strong><label style='text-align:center;'>该问题点下无问题案例!</label></strong></div>"
                                    });
                                }
                                $('#'+tabsId).tabs('select',0);
                            }
                        }
                    },100);
                },
                error:function(data){
                    top.$.messager.alert('提示信息','请求失败，请检查网络连接或与管理员联系','error');
                }
            });
        }catch(e){
            alert('genAuditCaseTabs:\n'+e.message);
        }
    }
            

		// 打开问题类别树窗口
		var wtWidth = $('body').width()*0.8;
		wtWidth = wtWidth < 780 ? 780 : wtWidth;
		
		var wtHeight = $('body').height()*0.8;
		wtHeight = wtHeight < 400 ? 400 : wtHeight;	
	   $('#wtlbTreeSelectWrap').window({   
			width:wtWidth,   
			height:wtHeight,   
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
					if(!$('#auditObjectTreeId').tree('isLeaf',snode.target)){
						top.$.messager.alert('提示信息','不能添加问题类别，请选择问题点','error');
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
								}
							},
							error:function(data){
								alert('请求失败！');
							}
						});
					    $('#wtlbTreeSelectWrap').window('close');
					}
				}else{
					top.$.messager.alert('提示信息','请选择问题点','error');
				}

			});
			$('#closeSelectWtlbTreeNode').bind('click',function(){
				$('#wtlbTreeSelectWrap').window('close');
			});

});


</script>
</head>
<body class="easyui-layout" onload="doProblemComment('${ledgerProblem.problem_name}');">
<div fit="true"   region="center" border='0'  style="overflow: auto; width: 100%;height: 100%;">
	<div region="center" border='0'>
		<s:form id="myform" action="save" namespace="/proledger/problem" cssStyle="text-align: center" >
		<div style="width: 100%;position:absolute;top:0px;"  id="div1" >
			<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;margin-top:0px;'>
			    
				<tr class="EditHead" >
				<td >
						<span style='float: left; text-align: left;'>
						<s:property value="#title" /></span>
			    </td> 
				<td style="text-align: left;">
				<span style='float: right; text-align: right;'>
					<s:if test="${viewFlag != 'view'}">
						<a id="lr_openZcfgTree" mc='audit_law' href="javascript:void(0);" class="easyui-linkbutton"
											   data-options="iconCls:'icon-search'" >引用法规制度</a>
						<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';saveForm1('${ledgerProblem.pro_type }');">保存</a>
						<a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closePronlem();">关闭</a>
					</s:if>
				</span>
			</td>
			</tr>
			</table>
		</div>
		<div class="position:relative" id="div2">
				<table class="ListTable" align="center" style='margin-top: 40px; overflow: auto;'>
				<tr>
					<td class="EditHead" style="width:15%;">问题类别</td>
					<td class="editTd" style="width:35%;">
						<s:textfield id="problem_all_name" name="ledgerProblem.problem_all_name" cssClass="noborder" cssStyle="width:70%" readonly="true" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT>
						<s:hidden id="sort_big_code" name="ledgerProblem.sort_big_code" />
						<s:hidden id="sort_big_name" name="ledgerProblem.sort_big_name" />
						<s:hidden id="sort_small_code" name="ledgerProblem.sort_small_code" />
						<s:hidden id="sort_small_name" name="ledgerProblem.sort_small_name" />
						<s:hidden id="sort_three_code" name="ledgerProblem.sort_three_code" />
						<s:hidden id="sort_three_name" name="ledgerProblem.sort_three_name" />
						<s:hidden id="ledgerProblem_id" name="ledgerProblem.id" />
						<%--<input type="hidden" id="ledgerProblem_id" name="ledgerProblem.id"/>
					--%></td>
					<td class="EditHead">审计问题编号</td>
					<td class="editTd" >
						<s:textfield name="ledgerProblem.serial_num" id="serial_num" cssClass="noborder" cssStyle="width:75%" readonly="true" />&nbsp;&nbsp;<FONT color=red>自动生成</FONT>
					</td>
				</tr>
				<tr>
					<td class="EditHead" width="15%"><FONT color=red>*</FONT>问题点</td>
					<td class="editTd" width="35%">
						<s:textfield name="ledgerProblem.problem_name" id="problem_name" cssClass="noborder" cssStyle="width:70%" readonly="true"/>
						<s:hidden name="ledgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						
						<img  style="cursor:pointer;border:0" src="/ais/resources/images/s_search.gif" onclick="$('#wtlbTreeSelectWrap').window('open')"></img>
					</td>
					<td class="EditHead" id="problemCommentText"  width="15%">备注(问题点为其他)</td>
					<td class="editTd" width="35%">
					<s:textarea name="ledgerProblem.problemComment" id="problemComment" cssStyle="width:74%;height:30px;display:none" />
					<input type="hidden" id="ledgerProblem.problemComment.maxlength" value="1000">
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<font color="red">*</font> 被审计单位
					</td>
					<td  class="editTd">
						<select id="audit_object"  class="easyui-combobox"  style="width:60%;" data-options="panelHeight:50" editable="false">
							<s:iterator value="auditObjectMap" id="entry">
								<s:if test="${ledgerProblem.audit_object==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead"><FONT color=red>*</FONT>问题标题<br></td>
					<td class="editTd">
						<s:textfield name="ledgerProblem.audit_con" id="audit_con" cssClass="noborder" cssStyle="width:70%"/>
						<input type="hidden" id="ledgerProblem.audit_con.maxlength" value="300">
					</td>
				</tr>
				<tr>
					<td class="EditHead">涉及金额</td>
					<td class="editTd">
						<s:textfield name="ledgerProblem.problem_money" id="problem_money" cssClass="noborder" title="涉及金额" cssStyle="width:34%" doubles="true" maxlength="15" />&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd"><s:textfield name="ledgerProblem.problemCount" id="problemCount" title="发生数量" cssClass="noborder" cssStyle="width:45%" doubles="true" maxlength="5" />&nbsp;个</td>
					
				</tr>
				<tr>
					<td class="EditHead">审计发现类型</td>
					<td class="editTd">
						<select id="problem_grade_code" class="easyui-combobox" name="ledgerProblem.problem_grade_code" style="width:160px;" data-options="panelHeight:100" editable="false">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.problemMethodList" id="entry">
								<s:if test="${ledgerProblem.problem_grade_code==code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead"><FONT color=red>*</FONT>重要程度</td>
					<td class="editTd">
						 <select name="ledgerProblem.orderOfSeverity" class="easyui-combobox" id="orderOfSeverity" data-options="editable:false,panelHeight:'100'" style="width:160px">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.importtant_degreeList" id="entry">
								<s:if test="${ledgerProblem.orderOfSeverity==code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						 </select>
						<s:hidden  name="ledgerProblem.ofsDetail" id="ofsDetail"/>
					</td>
				</tr>
				<tr>
					<s:if test="ledgerProblem.pro_type == '020312'">
						<td class="EditHead">责任
							<div><FONT color=red>(经济责任审计)</FONT></div>
						</td>
						<td class="editTd">
							<select id="zerencode" class="easyui-combobox" name="ledgerProblem.zerencode"  style="width:160px;" data-options="panelHeight:100,editable:false" editable="false">
							   <option value="">&nbsp;</option>
							   <s:iterator value="basicUtil.problemDutyList" id="entry">
									 <s:if test="${ledgerProblem.zerencode==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									 </s:if>
									 <s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									 </s:else>
							   </s:iterator>
							</select>
						</td>
					</s:if>
					<s:else>
						<td class="EditHead">责任
							<div><FONT color=DarkGray>(非经济责任审计)</FONT></div>
						</td>
						<td class="editTd" >
							<select id="zerencode" class="easyui-combobox" name="ledgerProblem.zerencode" style="width:160px;" data-options="panelHeight:100,editable:false">
							   <option value="">&nbsp;</option>
							   <s:iterator value="basicUtil.problemDuty2List" id="entry">
									 <s:if test="${ledgerProblem.zerencode==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									 </s:if>
									 <s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									 </s:else>
							   </s:iterator>
							</select>
						</td>
					</s:else>
					<s:hidden  name="ledgerProblem.zeren" id="zeren"/>
					<td class="EditHead">问题发现日期</td>
					<td class="editTd">
						<s:property value="ledgerProblem.problem_date"/>
						<s:hidden  name="ledgerProblem.problem_date"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题录入人</td>
					<td class="editTd">
						<s:property value="ledgerProblem.creater_name"/>
					</td>
					<td class="EditHead">问题发现人</td>
					<td class="editTd">
						<select id="lp_owner" class="easyui-combobox"  data-options="editable:false,panelHeight:'auto'"  name="ledgerProblem.lp_owner" style="width: 32%;"
							editable="true">
							<option value="">&nbsp;</option>
							<s:iterator value="memberObjectMap" id="entry">
								<s:if test="${ledgerProblem.lp_owner==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property
											value="value" /></option>
								</s:if>
								<s:else>
									<option value="<s:property value="key"/>"><s:property
											value="value" /></option>
								</s:else>
							</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						关联底稿
					</td>
					<td class="editTd">
					  <s:if test="${sourceSite == 'historyedit' || sourceSite == 'syEdit' }">
					  	<s:textfield name="ledgerProblem.linkManuName"  id="mylinkManuName" cssStyle='width:260px' cssClass="noborder"  />
					  </s:if>
					  <s:else>
						<s:textfield name="ledgerProblem.linkManuName"  id="mylinkManuName" cssStyle='width:260px' cssClass="noborder" readonly="true" />
						<!--一般文本框-->
						<s:hidden name="ledgerProblem.linkManuId" id="mylinkManuId" value="${ledgerProblem.linkManuId}"/>
						<img src="<%=request.getContextPath()%>/resources/images/s_search.gif" onclick="getOwerManu()" border=0 style="cursor: hand">
					 </s:else>
					</td>
					<td class="EditHead"></td>
					<td class="editTd"></td>
				</tr>
				<tr>
					<td class="EditHead"><FONT color=red>*</FONT>是否入报告
					</td>
					<td class="editTd" >
			<%-- 			<select editable="false" id="isToReport" class="easyui-combobox" name="ledgerProblem.isToReport" style="width:160px;" data-options="panelHeight:80">
							<option value="">&nbsp;</option>
						    <s:iterator value='#@java.util.LinkedHashMap@{"是":"是","否":"否"}' id="entry">
								<s:if test="${ledgerProblem.isToReport==key}">
						       		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						        </s:if>
						       	<s:else>
								    <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:else>
						    </s:iterator>
						</select> --%>
						<input id="isToReport" name="ledgerProblem.isToReport"  style="width:160px;">  
					</td>
					<td class="EditHead"><FONT color=red>*</FONT>是否整改
					</td>
					<td class="editTd" >
					<%-- 	<select editable="false" id="isInReport" class="easyui-combobox" name="ledgerProblem.isInReport" style="width:160px;" data-options="panelHeight:80">
							<option value="">&nbsp;</option>
						    <s:iterator value='#@java.util.LinkedHashMap@{"是":"是","否":"否"}' id="entry">
								<s:if test="${ledgerProblem.isInReport==key}">
						       		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						        </s:if>
						       	<s:else>
								    <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:else>
						    </s:iterator>
						</select> --%>
						<input id="isInReport" name="ledgerProblem.isInReport"  style="width:160px;">  
					</td>
				</tr>
				<tr>
					<td class="EditHead"><font color="red" id="isToReportRed" style="display: none">*</font> 不入报告原因<br></td>
					<td class="editTd">
						<s:textfield name="ledgerProblem.reportRemarks" id="reportRemarks" cssClass="noborder" cssStyle="width:70%"/>
						<input type="hidden" id="ledgerProblem.reportRemarks.maxlength" value="1000">
					</td>
					<td class="EditHead"><font color="red" id="isInReportRed" style="display: none">*</font>不整改原因<br></td>
					<td class="editTd">
						<s:textfield name="ledgerProblem.remarks" id="remarks" cssClass="noborder" cssStyle="width:70%"/>
						<input type="hidden" id="ledgerProblem.remarks.maxlength" value="1000">
					</td>
				</tr>
				<tr>
					<td class="EditHead"><font color="red"  class="isInReportClassRed"  style="display: none">*</font>是否采纳审计意见</td>
					<td class="editTd">
						 <select class="easyui-combobox" name="ledgerProblem.sfcnsjyj" id="sfcnsjyj" data-options="editable:false,panelHeight:'100'" style="width:160px">
						 	<option value="">&nbsp;</option>
						    <s:iterator value='#@java.util.LinkedHashMap@{"是":"是","否":"否"}' id="entry">
								<s:if test="${ledgerProblem.sfcnsjyj==key}">
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
					<td class="EditHead"><font color="red"  class="isInReportClassRed" style="display: none">*</font>违规违纪类型</td>
					<td class="editTd">
						<select id="wgwjlxCode" class="easyui-combobox" name="ledgerProblem.wgwjlxCode" style="width:160px;" data-options="panelHeight:100" editable="false">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.wgwjlxList" id="entry">
								<s:if test="${ledgerProblem.wgwjlxCode==code}">
									<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						</select>
						<s:hidden name="ledgerProblem.wgwjlxName" id="wgwjlxName" />
					</td>
					<td class="EditHead"><font color="red"  class="isInReportClassRed" style="display: none">*</font>违规违纪金额（万元）</td>
					<td class="editTd">
						 <s:textfield name="ledgerProblem.wgwjje" id="wgwjje" cssClass="noborder" title="违规违纪金额" cssStyle="width:34%" doubles="true" maxlength="15" />&nbsp;万元
					</td>
				</tr>
				
				<%-- 
				<tr>
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<input type="text"  id="creater_startdate" name="ledgerProblem.creater_startdate" class="easyui-datebox" style="width: 160px"
							value="${ledgerProblem.creater_startdate }" editable="false"/>
					</td>
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<input type="text"  id="creater_enddate" name="ledgerProblem.creater_enddate" class="easyui-datebox" style="width: 160px"
							value="${ledgerProblem.creater_enddate }" editable="false"/>
						</td>
				</tr>
					<tr>
						<td class="EditHead">问题发现人</td>
						<td class="editTd">
							<s:property value="ledgerProblem.creater_name"/>
						</td>
						<td class="EditHead">问题发现日期</td>
						<td class="editTd">
							<s:property value="ledgerProblem.problem_date"/>
							<s:hidden  name="ledgerProblem.problem_date"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd" colspan="3">
								<s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" name="ledgerProblem.problem_grade_code"></s:select>
							<select id="problem_grade_code" class="easyui-combobox" name="ledgerProblem.problem_grade_code" style="width:160px;" data-options="panelHeight:100" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.problemMethodList" id="entry">
									<s:if test="${ledgerProblem.problem_grade_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
					</tr> --%>

					<tr>
						<td class="EditHead">问题描述<br><font color=DarkGray>(限6000字)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea name="ledgerProblem.describe"  title="问题摘要" id="describe" cssClass='noborder'  rows="5" cssStyle="width:100%;overflow-y:visible;line-height:160%;"  />
							<input type="hidden" id="ledgerProblem.describe.maxlength" value="6000">
						</td>
					</tr>	
					<tr>
						<td class="EditHead">定性依据<br><font color=DarkGray>(限3000字)</font></td>
						<td class="editTd" colspan="3">
							<s:if test="${empty ledgerProblem.audit_law}">
								<s:textarea cssClass='noborder' id='audit_law'
									name="ledgerProblem.audit_law" rows="5"
									cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							</s:if> <s:else>
								<s:textarea cssClass='noborder' id='audit_law'
									name="ledgerProblem.audit_law" value="${ledgerProblem.audit_law}"
									rows="5"
									cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							</s:else>
						</td>
					</tr>
		

					<tr>
						<td class="EditHead" nowrap>审计建议<br><font color=DarkGray>(限3000字，如无建议请填写“无”)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea name="ledgerProblem.audit_advice" title="审计建议" id="audit_advice" cssClass='noborder'  rows="5" cssStyle="width:100%;overflow-y:visible;line-height:160%;"  />
							<input type="hidden" id="ledgerProblem.audit_advice.maxlength" value="500">
						</td>
					</tr>		

			</table>

			<s:hidden name="project_id" />
			<s:hidden name="manuscript_id" />
			<s:hidden name="manuscriptType" />
			<s:hidden name="ledgerProblem.project_id" value="${project_id}" />
			<s:hidden name="ledgerProblem.manuscript_id" value="${manuscript_id}" />
			<s:hidden name="ledgerProblem.creater_code" />
			<s:hidden name="ledgerProblem.creater_name" />
			<s:hidden name="audDoubtpage" value="${audDoubtpage}"/>
			<s:hidden name="tableType" />
	       <input type="hidden" id="audit_object_id" name="ledgerProblem.audit_object" /> 
			<input type="hidden" id="audit_object_name" name="ledgerProblem.audit_object_name"/>
			<input type="hidden" id="att" name="att" value="">
			<input type="hidden" id="att2" name="att2" value="">

		</div>
		</s:form>
		<jsp:include flush="true" page="/pages/adl/zcfgTree.jsp" />
	 </div>
	</div>
	     
	<!-- 问题类别树 -->
	<div id='wtlbTreeSelectWrap' title='问题类别' style='overflow:hidden; margin:0px;'>
		<div id="container" class='easyui-layout' fit='true' >
			<div  region="west"  split="true" style='overflow:hidden;width:250px;' title='问题树'>
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
     <div id="manuReferenceDiv" title="关联底稿数据" style='overflow:hidden;padding:0px;'> 	  		
			<iframe id="myFrame" name="myFrame" title="引用底稿" src="" width="100%" height="100%" frameborder="0"><!-- main --></iframe>				
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
			//if (frmCheck(document.forms[0], 'tab1')) {
				var problem_name = document.getElementById("problem_name").value;
				if(null!='${tableType}'&&''!='${tableType}'&&'1'=='${tableType}'){
					var text = $('#audit_object').combobox('getText');
					var value = $('#audit_object').combobox('getValue');
					$('#audit_object_id').val(value);
					$('#audit_object_name').val(text);
				}

				if(problem_name != '其他'){
					if(problem_name == ''||problem_name == null){
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"请选择问题点！"
						});
						return false;
					}
				}else{
					var problemComment = document.getElementById("problemComment").value;
					if (problemComment == '' || problemComment == null) {
						top.$.messager.show({
							title:"提示信息",
							msg:"请填写备注！"
						});
							return false;
						}
				}
				
				var tempVal = $("#problem_money").val();
				if(tempVal!='' && tempVal!=null){
					if(!/^(\d+(,\d\d\d)*(\.\d{2})?|\d+(\.\d{1,2})?)$/.test(tempVal)){
						top.$.messager.show({
							title:"提示信息",
							msg:"涉及金额填写数字，最多支持2位小数!"
						});
						return false;
					}
				}	
				
				var tempAudit_con=$("#audit_con").val().trim();
				if(tempAudit_con == ''||tempAudit_con == null ){
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"问题标题不能为空！"
					});
					return false;
				}
							
				var tempVal = $("#problemCount").val();
				if(tempVal!='' && tempVal!=null){
					if(!/^\d+$/.test(tempVal)){
						top.$.messager.show({
							title:"提示信息",
							msg:"发生数量请填写整数!"
						});
						return false;
					}
				}								

				//校验字数
				var dlg = $("#describe").val().length;
				if(dlg > 6000){
                    top.$.messager.show({
                        title:"提示信息",
                        msg:"问题描述的长度不能大于6000字!"
                    });
                    return false;
				}
				var audlg = $("#audit_advice").val().length;
				if(audlg > 3000){
					top.$.messager.show({
						title:"提示信息",
						msg:"审计建议的长度不能大于3000字!"
					});
					return false;
				}
				var aualg = $("#audit_law").val().length;
				if(aualg > 3000){
					top.$.messager.show({
						title:"提示信息",
						msg:"定性依据的长度不能大于3000字!"
					});
					return false;
				}

				var orderOfSeverity = $('#orderOfSeverity').combobox('getValue');
				$('#ofsDetail').val($('#orderOfSeverity').combobox('getText'));
				if(orderOfSeverity == '') {
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"重要程度不能为空！"
					});
					return false;
				}
				
				var isToReport = $('#isToReport').combobox('getValue');
				if(isToReport == '') {
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"是否入报告不能为空！"
					});
					return false;
				}

				var isInReport = $('#isInReport').combobox('getValue');
				if(isInReport == '') {
					window.parent.top.$.messager.show({
						title:"提示信息",
						msg:"是否整改不能为空！"
					});
					return false;
				}
				
				if(isToReport!='是'){
					var reportRemarks = $('#reportRemarks').val();
					if(reportRemarks==''){
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"不入报告原因不能为空！"
						});
						return false;
					}
				}

				if(isInReport!='是'){
					var remarks = $('#remarks').val();
					if(remarks==''){
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"不整改原因不能为空！"
						});
						return false;
					}
				}else{
					var sfcnsjyj = $('#sfcnsjyj').combobox('getValue');
					if(sfcnsjyj == '') {
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"是否采纳审计意见不能为空！"
						});
						return false;
					}
					
					var wgwjlxCode = $('#wgwjlxCode').combobox('getValue');
					var wgwjlxName = $('#wgwjlxCode').combobox('getText');
					if(wgwjlxCode == '') {
						window.parent.top.$.messager.show({
							title:"提示信息",
							msg:"违规违纪类型不能为空！"
						});
						return false;
					}
					$('#wgwjlxName').val(wgwjlxName);

					var tempVal1 = $("#wgwjje").val();
					if(tempVal1!='' && tempVal1!=null){
					    if(/[^\d|\.]/.test(tempVal1)){
	                        top.$.messager.show({
	                            title:"提示信息",
	                            msg:"违规违纪金额格式不正确!"
	                        });
	                        return false;
	                    }

						if(!/^(\d+(,\d\d\d)*(\.\d{2})?|\d+(\.\d{1,2})?)$/.test(tempVal1)){
							top.$.messager.show({
								title:"提示信息",
								msg:"违规违纪金额填写数字，最多支持2位小数!"
							});
							return false;
						}
					}
				}
				
				if($('#zerencode').combobox('getValue')!=''){
					$('#zeren').val($('#zerencode').combobox('getText'));
				}
				
				/* //var mend_term = document.getElementById("creater_startdate").value;
				var mend_term = $('#creater_startdate').datebox('getValue'); 
				//var mend_term_enddate = document.getElementById("creater_enddate").value;
				var mend_term_enddate = $('#creater_enddate').datebox('getValue'); 
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
			         if(ts>te){
			             top.$.messager.show({
								title:"提示信息",
								msg:"问题所属开始日期必须小于问题所属结束日期!"
							});
			             return false;
			         }
			} */
				$.ajax({
					type : "POST",
					dataType:"json",
					async:false,
					url : "${contextPath}/proledger/problem/saveSimplifiedProblem.action?t="+new Date().getTime(),
					data : $("#myform").serialize(),
					success : function(msg) {
					
						if (msg[0] == 1) {
							 window.parent.top.$.messager.show({
									title:"提示信息",
									msg:"保存成功"
								});
							$("#ledgerProblem_id").val(msg[1]);
							$("#serial_num").val(msg[2]);

							if(parentTabId) {
								var frameWin = aud$getTabIframByTabId(parentTabId);
						   		frameWin.g1.datagrid('reload');
							}else{
								 window.parent.flushProblem();
							}
						}
					}
				});

		}

		function callback() {
			var codes = document.getElementById("att").value;
			var names = document.getElementById("att2").value;
			var sort_code = codes.split("#");
			var sort_name = names.split("#");
			var allName =sort_name[sort_name.length - 2];
			document.getElementsByName("ledgerProblem.problem_code")[0].value = sort_code[0];
			if (sort_code.length - 4 <= 0) {
				document.getElementsByName("ledgerProblem.sort_three_code")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_three_code")[0].value = sort_code[sort_code.length - 4];
			}
			if (sort_code.length - 3 == 0) {
				document.getElementsByName("ledgerProblem.sort_small_code")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_small_code")[0].value = sort_code[sort_code.length - 3];
				allName = allName+" - "+sort_name[sort_name.length - 3];
			}
			document.getElementsByName("ledgerProblem.sort_big_code")[0].value = sort_code[sort_code.length - 2];
			document.getElementsByName("ledgerProblem.problem_name")[0].value = sort_name[0];
			if (sort_name.length - 4 <= 0) {
				document.getElementsByName("ledgerProblem.sort_three_name")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_three_name")[0].value = sort_name[sort_name.length - 4];
				allName = allName+" - "+sort_name[sort_name.length - 4];
				
			}
			if (sort_name.length - 3 == 0) {
				document.getElementsByName("ledgerProblem.sort_small_name")[0].value = '';
			} else {
				document.getElementsByName("ledgerProblem.sort_small_name")[0].value = sort_name[sort_name.length - 3];
			}
			document.getElementsByName("ledgerProblem.sort_big_name")[0].value = sort_name[sort_name.length - 2];
			document.getElementsByName("ledgerProblem.problem_all_name")[0].value = allName;
			//problemUnitList(sort_code[0], '');
			doProblemComment(sort_name[0]);
		//	$("#audit_law").val("");	
			if(sort_name[0] != "其他"){
				getGist(sort_code[0]);
			}
		}

		//获取定性依据
		function getGist(problemCode) {
			var problem_desc=document.getElementById("audit_law").value	;
			$.ajax({
				type : "POST",
				url : "${contextPath}/proledger/problem/saveOprateTask!getGist.action",
				data : {
					"problemCode" : problemCode
				},
				success : function(msg) {
					if (msg != "") {
					//	$("#audit_law").val(msg);
						$("#audit_law").val(problem_desc+"\n"+msg);
					}else{
						$("#audit_law").val(problem_desc);
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

		// 关闭问题
		function closePronlem(){
			if(parentTabId) {
				aud$closeTab(curTabId, parentTabId);
			}else{
				parent.closePronlem();
			}			
		}

	function accountantSystemTypeFun(){
		$("#accountantSystemTypeName").val($("#accountantSystemTypeCode").find("option:selected").text());
	}
	</SCRIPT>
</body>
<script type="text/javascript">
	$(function(){
		$("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});
		$("#audit_law").attr("maxlength",3000);
		$("#audit_con").attr("maxlength",300);
		$("#describe").attr("maxlength",6000);
		$("#audit_advice").attr("maxlength",3000);
		
	    var options01 = [{text : "是", value : "是"}, 
	                     {text : "否", value : "否"}];
	    
	    //是否入报告
		$('#isToReport').combobox({
		    valueField: 'value',
	        textField: 'text',                                          
	        data : options01,
	        panelHeight:'auto',  
			editable:false,
			onChange:function(newValue,oldValue){
				if(newValue !='是'){
                    document.getElementById("isToReportRed").style.display="";
				}else{
					document.getElementById("isToReportRed").style.display="none";
				}
			}
		});
		
		//是否整改
		$('#isInReport').combobox({
		    valueField: 'value',
	        textField: 'text',                                          
	        data : options01,
	        panelHeight:'auto', 
			editable:false,
			onChange:function(newValue,oldValue){
				if(newValue != '是'){
					  document.getElementById("isInReportRed").style.display="";
					  $(".isInReportClassRed").css('dispaly','none');
					   var x = document.getElementsByClassName("isInReportClassRed");
					   for ( var i=0;i<x.length;i++ ){
						   x[i].style.display="none";
					   }
				   }else{
					   document.getElementById("isInReportRed").style.display="none";
					   var x = document.getElementsByClassName("isInReportClassRed");
					   for ( var i=0;i<x.length;i++ ){
						   x[i].style.display="";
					   }
				   }
			}
		});
		
		
		$('#quantify').combobox({
			panelHeight:50,
			editable:false,
			onChange:function(newValue,oldValue){
				if(newValue=='是'){
					   document.myform.problem_money.disabled = false;
					   //document.myform.problemCount.disabled = false;
				   }else{
					   document.myform.problem_money.value = "";
					   //document.myform.problemCount.value = "";
					   document.myform.problem_money.disabled = true;
					   //document.myform.problemCount.disabled = true;
					   
				   }
			}
		});

		if('${ledgerProblem.isToReport}' != ''){
		    $('#isToReport').combobox('setValue','${ledgerProblem.isToReport}');
        }
		if('${ledgerProblem.isInReport}' != ''){
		    $('#isInReport').combobox('setValue','${ledgerProblem.isInReport}');
        }
        if('${ledgerProblem.isNotMend}' != ''){
            $('#isNotMend').combobox('setValue','${ledgerProblem.isNotMend}');
        }
 	   $('#manuReferenceDiv').window({
			width:650, 
			height:550,  
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true    
	    });

	});

	//选择引用底稿
    function  getOwerManu(){
    	var code=document.getElementsByName("project_id")[0].value; 
    	var myurl = "${contextPath}/operate/manu/queryManuSelect.action?project_id="+code;
		$("#myFrame").attr("src",myurl);
		$('#manuReferenceDiv').window('open');
    }
    function closeWinUI(){
    	$('#manuReferenceDiv').window('close');
    }
</script>
</html>
