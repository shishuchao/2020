<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>在线作业</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
		<script type="text/javascript"
			src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
<script type="text/javascript">
function addTab(tabPanelId,nodeText,nodeId,url,refresh){
	var tab = $("#"+tabPanelId).tabs("getTab",nodeText);
	if(tab){
		if(!refresh)
			$("#"+tabPanelId).tabs("select",nodeText);
		else{
			/* $("#tabs").tabs("update",{
				tab:tab,
				options:{content : '<iframe  id="'+nodeId+'id" src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'}
				}
			); */
			tab.panel('refresh');
			$("#"+tabPanelId).tabs("select",nodeText);
		}
	}else{
		$("#"+tabPanelId).tabs("add",{
			title:nodeText,
			closable:true,
			cache:false,
			content : '<iframe  id="'+nodeId+'id" src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
		});
	}
}

var parents = "${parents}";
$(document).ready(function(){
    $("#mTree").tree({
		url:'/ais/project/prepare/menuTreeInteraction.action?crudId=${crudId}&source=${source}&interaction=interaction',
		animate:true,
		onClick:function(node){
			if(node.attributes.url!=""&&node.attributes.url!='prepare'){
				addTab('tabs',node.text,node.id,node.attributes.url,true);
			}else if(node.attributes.url=='prepare'){
				alert("请完成项目准备。");
				return;
			}
			
			/* if(node.id=='11'){
				addTab('tabs','分组信息','fz',node.attributes.url[0]);
				addTab('tabs','成员信息','cy',node.attributes.url[1]);
				addTab('tabs','审计成果组间授权','sq',node.attributes.url[2]);
				addTab('tabs','疑点筛查','yd',node.attributes.url[3]);
				$("#tabs").tabs("select","分组信息");
			}else{
				if(node.attributes.url!=""){
					addTab('tabs',node.text,node.id,node.attributes.url,true);
				}else{
					alert("请完成项目准备。");
					return;
				}
			} */
		},
		onLoadSuccess:function(node, data){
			var parentss = parents.split(",");
			var arr = new Array;
			for(var i = parentss.length-1;i>0;i--){
				var node = $("#mTree").tree("find",parentss[i]);
				if(node){
					$("#mTree").tree("expand",node.target);
				}
			}
			setTimeout(function(){
				var node = $("#mTree").tree("find",parentss[0]);
				$("#mTree").tree("select",node.target);
				addTab('tabs',node.text,node.id,node.attributes.url,true);
			}, 500);
			
			
			
		}
	});
	
    
    //绑定tabs的右键菜单
    $("#tabs").tabs({
        onContextMenu : function (e, title) {
            e.preventDefault();
            $('#tabsMenu').menu('show', {
                left : e.pageX,
                top : e.pageY
            }).data("tabTitle", title);
        }
    });
    //实例化menu的onClick事件
    $("#tabsMenu").menu({
        onClick : function (item) {
            CloseTab(this, item.name);
        }
    });
    //几个关闭事件的实现
    function CloseTab(menu, type) {
        var curTabTitle = $(menu).data("tabTitle");
        var tabs = $("#tabs");
        
        if (type === "close") {
            tabs.tabs("close", curTabTitle);
            return;
        }
        
        var allTabs = tabs.tabs("tabs");
        var closeTabsTitle = [];
        
        $.each(allTabs, function () {
            var opt = $(this).panel("options");
            if (opt.closable && opt.title != curTabTitle && type === "Other") {
                closeTabsTitle.push(opt.title);
            } else if (opt.closable && type === "All") {
                closeTabsTitle.push(opt.title);
            }
        });
        
        for (var i = 0; i < closeTabsTitle.length; i++) {
            tabs.tabs("close", closeTabsTitle[i]);
        }
    }
    
	// add by qfucee, 2013.7.12,  解决疑点筛查列表iframe加载时表格样式错乱
	$("#tabs").tabs({
		onSelect:function(title,index){
			if(title == '疑点筛查' && ydid){
				var tab = ydid.document.getElementById('sjydQueryDataDiv');
				if(tab && tab.firstChild.firstChild.offsetWidth < 100){
					ydid.location.reload();
				}
			}
		}
	});
	// end;
	$("#mTree").tree('expandAll');
	
	/*
	if('${stateNo}'=='11'){
		addTab('tabs','分组信息','fz',node.attributes.url[0],true);
		addTab('tabs','成员信息','cy',node.attributes.url[1],true);
		addTab('tabs','审计成果组间授权','sq',node.attributes.url[2],true);
		addTab('tabs','疑点筛查','yd',node.attributes.url[3],true);
		$("#tabs").tabs("select","分组信息");
	}else{
		if(node.attributes.url!=""){
			addTab('tabs',node.text,node.id,node.attributes.url,true);
		}
	} */
	// qfucee, 2014.10.25,修改审计工具的位置
	var swidth = 180,sheight = 350;
    
	var w2 = $('body').width()*0.8;
	var h2 = $('body').height()*0.8;
	if(w2 < 600){
		w2 = 600;
	}
	if(h2<500){
		h2= 500;
	}
	$('#con_win').window('resize',{
		width:w2,
		height:h2,
		left:w2/8,
		top:h2/8
	});
    
});
function changeProject(crudId){
	window.location.href = '${contextPath}/project/prepare/projectIndex.action?crudId='+crudId+'&view=${view}';
}
function openMsg(){
	$('#con_win').window('open');
}
function closeMsg(){
	$('#con_win').window('close');
}
function openTool(tl,url){
	var w = $('body').width()*0.8;
	var h = $('body').height()*0.8;
	if(w < 600){
		w = 600;
	}
	if(h<500){
		h = 500;
	}
	$('#toolUrl').window({   
       title:tl,
       modal:false,
       minimizable:false,
       maximizable:true,
       collapsible:false,
       closable:true,
       width:w,
       height:h,
       content : '<iframe src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
    });
}
/**
 * 在线审计
 */
function zxsj(){
	if(${view eq 'view'}){
		alert('当前为预览状态。不可操作！');
		return;
	}
	var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
	var projectCode = document.getElementsByName("projectStartObject.project_code")[0].value;
	var auditStartTime = document.getElementsByName("projectStartObject.audit_start_time")[0].value;
	if(auditStartTime==''){
		alert('审计期间没有定义,无法在线作业!');
		return false;
	}
	var start_1=auditStartTime.split("-")[0];
	var start_2=auditStartTime.split("-")[1];
	var start_3=auditStartTime.split("-")[2];
	
	if(start_2.length==1){
		start_2 = '0' + start_2;
	}
	if(start_3.length==1){
		start_3 = '0' + start_3;
	}
	
	var start=start_1+start_2+start_3;
	
	var auditEndTime = document.getElementsByName("projectStartObject.audit_end_time")[0].value;
	if(auditEndTime==''){
		alert('审计期间没有定义,无法在线作业!');
		return false;
	}
	var end_1=auditEndTime.split("-")[0];
	var end_2=auditEndTime.split("-")[1];
	var end_3=auditEndTime.split("-")[2];
	
	if(end_2.length==1){
		end_2 = '0' + end_2;
	}
	if(end_3.length==1){
		end_3 = '0' + end_3;
	}
	
	var end=end_1+end_2+end_3;
	
	/*var queryString = encode64(encodeURI(""+projectCode+","+start+","+end+",${user.floginname}"));
	var url ="http://"+host+"/login.jsp?p="+queryString;*/
    var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
    var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
    var url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
	var udswin=window.open(url,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
    udswin.moveTo(0,0);
    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
	//window.open("http://"+host+"/login.jsp?p="+queryString,'','');
	//上面联网窗口打开后会修改一些本机管理的cookie信息,需要重新让管理系统用户自动认证一下才行
	//var crudId = document.getElementById('crudId').value;
	//window.location.href="/ais/project/actualize/edit.action?crudId=${projectStartObject.formId}";
	
}
</script>
</head>
<body class="easyui-layout" id="projectLayout">
	<div id="con_win" class="easyui-window" title="项目信息"
		collapsible="false" maximizable="true" closable="true"
		minimizable="false" style="width: 600px;height: 300px;" closed="true">
		<table id="projectStartTable" class="ListTable" style="width:100%">
			<tr>
				<td class="ListTableTr11">项目名称</td>
				<td class="listtableTr22"><s:property
						value="projectStartObject.project_name" /></td>
				<td class="ListTableTr11">项目编号</td>
				<td class="ListTableTr22"><input type="hidden"
					name="projectStartObject.project_code"
					value="${projectStartObject.project_code }"> <s:property
						value="projectStartObject.project_code" /></td>
			</tr>
			<tr>
				<td class="ListTableTr11">项目年度</td>
				<td class="ListTableTr22"><s:property
						value="projectStartObject.pro_year" /></td>
				<td class="ListTableTr11">项目类别</td>
				<td class="ListTableTr22"><s:property
						value="projectStartObject.pro_type_name" /> &nbsp;&nbsp; <s:property
						value="projectStartObject.pro_type_child_name" /></td>
			</tr>
			<tr>
				<td class="ListTableTr11">计划类别</td>
				<td class="ListTableTr22" colspan="3"><s:property
						value="projectStartObject.plan_type_name" /></td>
			</tr>
			<s:if test="${!projectStartObject.nbzwpg}">
				<tr>
					<td class="ListTableTr11">审计单位</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.audit_dept_name" /></td>
					<td class="ListTableTr11">被审计单位</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.audit_object_name" /></td>
				</tr>
			</s:if>
			<s:else>
				<td class="ListTableTr11">测试组织者</td>
				<td class="ListTableTr22"><s:property
						value="projectStartObject.audit_dept_name" /></td>
				<td class="ListTableTr11">测内控专岗负责人</td>
				<td class="ListTableTr22"><s:property
						value="projectStartObject.pro_teamleader_name" /></td>
			</s:else>
			<!-- 工程项目审计 -->
			<s:if test="projectStartObject.gcxmsj">
				<tr id="gcxmTr1">
					<td class="ListTableTr11" id="gcxmTd1">合同金额</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.contractAmount" />万元</td>
					<td class="ListTableTr11" id="gcxmTd2">项目管理模式</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.managerType" /></td>
				</tr>
				<tr id="gcxmTr2">
					<td class="ListTableTr11" id="gcxmTd3">开工日期</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.startProDate" /></td>
					<td class="ListTableTr11" id="gcxmTd4">竣工日期</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.finishProDate" /></td>
				</tr>
				<tr id="gcxmTr3">
					<td class="ListTableTr11" id="gcxmTd5">项目状态</td>
					<td class="ListTableTr22" colspan="3"><s:property
							value="projectStartObject.proStatus" /></td>
				</tr>
			</s:if>

			<s:if test="projectStartObject.jjzrr">
				<tr>
					<td class="ListTableTr11">经济责任人</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.jjzrrname" /></td>
					<td class="ListTableTr11">是否为总公司党组管理干部</td>
					<td class="ListTableTr22"><s:if
							test="${projectStartObject.isDangLeader=='true'}">
								是
							</s:if> <s:else>
								否
							</s:else></td>
				</tr>
			</s:if>
			<s:if test="projectStartObject.rework">
				<tr>
					<td class="ListTableTr11">后续审计项目</td>
					<td class="ListTableTr22" colspan="3"><s:property
							value="projectStartObject.reworkProjectNames" /></td>
				</tr>
			</s:if>
			<tr>
				<td class="ListTableTr11">开始日期</td>
				<td class="ListTableTr22"><s:property
						value="projectStartObject.pro_starttime" /></td>
				<td class="ListTableTr11">结束日期</td>
				<td class="ListTableTr22"><s:property
						value="projectStartObject.pro_endtime" /></td>
			</tr>
			<s:if test="${!projectStartObject.nbzwpg}">
				<tr>
					<td class="ListTableTr11" nowrap><s:if
							test="varMap['audit_start_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间开始</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.audit_start_time" /> <input
						type="hidden" name="projectStartObject.audit_start_time"
						value="${projectStartObject.audit_start_time }"></td>
					<td class="ListTableTr11" nowrap><s:if
							test="varMap['audit_end_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间结束</td>
					<td class="ListTableTr22"><s:property
							value="projectStartObject.audit_end_time" /> <input type="hidden"
						name="projectStartObject.audit_end_time"
						value="${projectStartObject.audit_end_time }"></td>
				</tr>
				<tr>
					<td class="ListTableTr11"><s:if
							test="varMap['audit_scopeRequired']">
							<font color="red">*</font>
						</s:if> 审计范围</td>
					<td class="ListTableTr22" colspan="3"><s:property
							value="projectStartObject.audit_scope" /></td>
				</tr>
				<tr>
					<td class="ListTableTr11"><s:if
							test="varMap['plan_remarkRequired']">
							<font color="red">*</font>
						</s:if> 备注</td>
					<td class="ListTableTr22" colspan="3"><s:property
							value="projectStartObject.plan_remark" /></td>
				</tr>
			</s:if>
		</table>
	</div>
	<div region="north"
		style="height:35px;background:url('${contextPath}/resources/images/layout-browser-hd-bg.gif') repeat-x center;">
	<s:if test="isView == 2">
		<span
			style="float:left;font:bold;font-size:16;color:white;padding:5px 0 5px 10px;">项目名称：&nbsp;&nbsp;<span style="font-size:15;color:white;padding:5px 0 5px 10px;">${projectStartObject.project_name }</span>
		</span> 
	</s:if>
	<s:else>
		<span
			style="float:left;font:bold;font-size:16;color:white;padding:5px 0 5px 10px;">项目名称
			${projectStartObject.project_name}
		</span> 
	</s:else>
		
		<a href="javascript:void(0)" style="cursor: pointer;"
			onclick="win_close();"> <span
			style="float:right;font:bold;font-size:12;color:white;padding:10px 10px 5px 0;">退出项目</span>
		</a>
	</div>
	<div region="west" title="作业导航" style="width: 200px;padding:10px;" split="true">
		<ul id="mTree" style="height: 100%; overflow: auto;">
		</ul>
	</div>
	<div region="center">
		<div id="tabs" class="easyui-tabs" fit=true
			style="overflow: visibility ;"></div>
	</div>
	<div region="south" style="height:20px;overflow: hidden;">
		<div style="padding-left:15px;">
			<div class="h_note_text">项目名称：${projectStartObject.project_name}&nbsp;&nbsp;</div>
		</div>
	</div>
	<div id='p' style='overflow:hidden;'>
		<ul style="padding-left:5px;padding-top:10px;font:bold;">
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openMsg();">项目信息</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('分组信息','${contextPath}/project/listGroupsInteraction.action?view=view&crudId=${projectStartObject.formId }');">分组信息</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('成员信息','${contextPath}/project/getlistMembers.action?view=${view }&crudId=${projectStartObject.formId }');">成员信息</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('实施方案','${contextPath}/operate/template/view.action?view=${view }&project_id=${projectStartObject.formId }');">实施方案</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('审计分工','${contextPath}/operate/task/project/showContentTypeWorkView.action?owner=true&project_id=${projectStartObject.formId }&view=${view }');">审计分工</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('被审单位资料','${contextPath}/auditAccessoryList/list.action?cruProId=${projectStartObject.formId }&pro_type=${projectStartObject.pro_type }&pro_type_child=${projectStartObject.pro_type_child}&view=${view }');">被审单位资料</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('组间授权','${contextPath}/project/permission/edit.action?pso.formId=${projectStartObject.formId }&view=${view }');">组间授权</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('审计文书','${contextPath}/workprogram/editWorkProgramProjectDetail.action?projectid=${projectStartObject.formId }&view=${view }');">审计文书</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('法律法规','${contextPath}/pages/operate/manu/law_redirect.jsp?projectId=${projectStartObject.formId}');">法律法规</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('审计问题库','/ais/pages/ledger/problem_tree/problemindex.jsp?view=yes');">审计问题库</a>
			</li>
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openTool('审计案例库','/ais/pages/assist/suport/lawsLib/index.action?mCodeType=sjal&m_view=view');">审计案例库</a>
			</li>
			<s:if test="@ais.project.ProjectSysParamUtil@isZXSJEnabled()">
				<li style="margin:5px;"><a href="javascript:void(0);"
					onclick="zxsj();">大数据审计</a>
				</li>
			</s:if>
		</ul>
	</div>
	<div id="toolUrl" style='overflow:hidden;'></div>
	
	     <div id="tabsMenu" class="easyui-menu" style="width:120px;">  
		    <div name="close">关闭</div>  
		    <div name="Other">关闭其他</div>  
		    <div name="All">关闭所有</div>
		 </div> 
	
</body>
</html>
<script type="text/javascript">
	function win_close(){
	if(window.confirm("确认关闭吗?")){
		window.close();
	}
}
</script>
