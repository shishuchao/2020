<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>在线作业</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
<script type="text/javascript">
(function($){
    $.fn.hoverForIE6=function(option){
        var s=$.extend({current:"hover",delay:10},option||{});
        $.each(this,function(){
            var timer1=null,timer2=null,flag=false;
            $(this).bind("mouseover",function(){
                if (flag){
                    clearTimeout(timer2);
                }else{
                    var _this=$(this);
                    timer1=setTimeout(function(){
                        _this.addClass(s.current);
                        flag=true;
                    },s.delay);
                }
            }).bind("mouseout",function(){
                if (flag){
                    var _this=$(this);timer2=setTimeout(function(){
                        _this.removeClass(s.current);
                        flag=false;
                    },s.delay);
                }else{
                    clearTimeout(timer1);
                }
            })
        })
    }
})(jQuery);
</script>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
.allsort a,img{border:0;}
/*body{font-family:"宋体",Arial,Lucida,Verdana,Helvetica,sans-serif;font-size:15px;line-height:150%;}*/
.allsort a:link,a:visited{color:#333;text-decoration:none;}
.allsort a:hover{color:#c00;text-decoration:underline;font-weight:bold;}
.allsort a:active{color:#900;}
/* navsort */
.navsort{font-size:15px;float:left;color:white;position:absolute;left:80px;top:12px;}
/*allsort*/
.allsort{height:50px;position:relative;z-index:11;font-weight:normal;}
.allsort .mt{height:24px;padding:14px 12px 12px 16px;line-height:24px;cursor:pointer;overflow:hidden;}
.allsort .mt strong{float:left;font-size:15px;color:#630;}
.allsort .mt .extra{float:right;overflow:hidden;width:22px;height:22px;background-position:-214px -52px;}
.allsort .mc{display:none;position:fixed;left:95px;top:56px;overflow:visible;width:630px;padding:0 3px 0;border:solid #95B8E7;border-width:0 1px 1px;background:#E0ECFF;-moz-border-radius:0 0 5px 5px;-webkit-border-radius:0 0 5px 5px;}
.allsort .item{width:203px;height:32px;border-top:1px solid #FDE6D2;}
.allsort .fore{border-top:none;}
.allsort span{display:block;position:relative;z-index:1;}
.allsort h3{font-size:15px;width:140px;height:30px;padding-left:20px;border:solid #FEF8EF;border-width:1px 0 1px 1px;background-position:-241px -57px;font-weight:normal;}
.allsort h3 a:link,.allsort h3 a:visited{display:block;height:30px;line-height:30px;color:#333;}
.allsort h3 a:hover,.allsort h3 a:active{color:#1B578A;}
.allsort s{display:block;position:absolute;top:10px;left:182px;width:13px;height:13px;background-position:-218px -106px;}
.allsort .item .i-mc{display:none;position:absolute;left:163px;top:0;width:630px;border:1px solid #c30;background:#FFF9EF;overflow:hidden;}
.allsort .item dt{padding:3px 6px 0 0;font-weight:bold;}
.allsort .item dd{padding:3px 0 0;overflow:hidden;zoom:1;}
.allsort .subitem{float:left;width:550px;min-height:300px;height:auto;padding:0 4px 0 28px;}
.allsort .subitem dl{border-top:1px solid #95B8E7;padding:6px 0;overflow:hidden;zoom:1;}
.allsort .subitem .fore{border-top:none;}
.allsort .subitem dt{float:left;width:100px;line-height:22px;text-align:right;color:blue;}
.allsort .subitem dd{float:left;width:425px;}
.allsort .subitem em{float:left;height:14px;margin:4px 0;line-height:14px;padding:0 8px;border-left:1px solid #ccc;font-style:normal;white-space:nowrap;}
.allsort .fr{background:#fff;width:194px;padding:0 15px 2010px 15px;margin-bottom:-2000px;float:right;}
.allsort .fr dl{padding-bottom:0;}
.allsort .mc .extra{padding:7px 8px;background:#FDF1DE;border-top:1px solid #FDE6D2;}
.allsorthover{background-position:0 -50px;}
.allsorthover .mt .extra{background-position:-214px -75px;}
.allsorthover .mc{display:block;margin:-20px auto 0 auto;}
.allsort .hover span{z-index:13;width:160px;}
.allsort .hover h3{font-size:15px;border:solid #c30;border-width:1px 0 1px 1px;overflow:hidden; #FFF9EF no-repeat -241px -57px;font-weight:bold;}
.allsort .hover s{display:none;}
.allsort .hover .i-mc{display:block;z-index:12;}
*html .allsort .item dd{padding-bottom:6px;}
*html .allsort .subitem{height:400px;}
</style>
<script type="text/javascript">
function addTab(tabPanelId,nodeText,nodeId,url,refresh){
	var tab = $("#"+tabPanelId).tabs("getTab",nodeText);
	if(tab){
		 $("#"+tabPanelId).tabs('update', {
	      tab : tab,
	      title:nodeText,
	      options : {
	       content : '<iframe  id="'+nodeId+'id" src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
	      }
	     });	
	     $("#"+tabPanelId).tabs("select",nodeText);
	}else{
		$("#"+tabPanelId).tabs("add",{
			title:nodeText,
			closable:true,
			cache:false,
			tools:[{    
	            iconCls:'icon-mini-refresh',    
	            handler:function(){    
	            	 reloadIframe(nodeId+'id');  
	            }    
	        }],
			content : '<iframe  id="'+nodeId+'id" src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
		});
	}
}

$(window).unload(function(){
	if('${source}'!='view')
		window.opener.top.reloadHomePage();//.location.reload();
});
//根据id刷新iframe,add by qfucee, 2015.10.26
function reloadIframe(ifid, cache){
    try{
        if(ifid){
            var iframe = document.getElementById(ifid);
            if(iframe && iframe.contentWindow){
                iframe.contentWindow.location.reload(cache ? true : false);
            }
        }
        //alert('reload iframe:'+ifid);
    }catch(e){
        alert('reloadIfram\n'+e.message);
    }
}
var parents = "${parents}";
$(document).ready(function(){
    $("#mTree").tree({
		url:'/ais/project/prepare/menuTree.action?crudId=${crudId}&source=${source}&projectview=${projectview}',
		animate:true,
		onClick:function(node){
			if(node.attributes.url!=""&&node.attributes.url!='prepare'){
				addTab('tabs',node.text,node.id,node.attributes.url,true);
			}else if(node.attributes.url=='prepare'){
				alert("请完成项目准备。");
				return;
			}
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
		}
	});
	
    
	setTimeout(function(){
		var parentss = parents.split(",");
		var snodeId = parentss[0];
		var node = $("#mTree").tree("find",snodeId);
		if(node && node.target){
			$("#mTree").tree("select",node.target);
		}
	}, 2000);
    
    
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
        tabs.tabs('select',curTabTitle);
    }
    
	// add by qfucee, 2013.7.12,  解决疑点筛查列表iframe加载时表格样式错乱
	$("#tabs").tabs({
		onSelect:function(title,index){
			var currTab = $('#tabs').tabs('getTab', title);
			if(currTab){
				if(title=='小组审计分工' || title=='组员审计分工' || title=='修改方案'|| title=='实施方案查看'){
					var iframe = $(currTab.panel('options').content);
					var src = iframe.attr('src');
					 $('#tabs').tabs('update', {
				      tab : currTab,
				      title:title,
				      options : {
				       content : '<iframe  id="'+'abc'+index+'id" src="'+src+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
				      }
				     });				
				}
			}
			if(title == '疑点筛查' && ydid){
				var tab = ydid.document.getElementById('sjydQueryDataDiv');
				if(tab && tab.firstChild.firstChild.offsetWidth < 100){
					ydid.location.reload();
				}
			}
		},
		onAdd:function(title, index){//去掉tab页的y方向滚动条,qfucee,16.5.6
			var tab = $("#tabs").tabs('getTab', index);
			//alert(tab[0].outerHTML)
			$(tab).filter(".panel-body").css('overflow','hidden');
		},
		onClose:function(title, index){
			var tabs = $("#tabs").tabs('tabs');
	        if (tabs.length==0) {
				$.messager.show({
					title:'消息',
					msg:'请从【作业导航】或点击左上部>>符号选择您的工作项目！',
					timeout:10000
				});
	        }
		}
	});
	// end;
	$("#mTree").tree('expandAll');
	
	var swidth = 135,sheight = 250;
    $('#p').window({   
       title:"审计工具",
       minimizable:false,
       maximizable:false,
       closable:false,
       shadow:false,
       resizable:false,
       width:swidth,
       height:'auto',
       style:{padding:"6px 0 0 0"},
       onMove:function(left,top){
       	if(top<0){
			$(this).window('resize',{
		       top:0
			});
       	}
       },
       top:0,
       left:$('body').width()-270
    }); 
    $('#p').window('collapse');
    
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
    
	//window.setTimeout("newmenu()",500);
	window.setTimeout(function(){
		var parentss = parents.split(",");
		var snodeId = parentss[0];
		newmenu(snodeId ? snodeId : "");
	},0);
});
function clickmenu() {
  	var node=$(this);
  	var id=node.attr("id").substr(4);
  	var txt=node.text();
  	var url=node.attr("ihref");
	if(url!=""&&url!='prepare'){
		addTab('tabs',txt,id,url,true);
	}else if(url=='prepare'){
		$.messager.show({
			title:'消息',
			msg:'请完成项目准备！'
		});
	}
	$(".item").removeClass("hover"); 
	$(".allsort").removeClass("allsorthover");
}
function newmenu(nodeId) {
	jQuery.ajax({
		url:'/ais/project/prepare/menuTree.action?crudId=${crudId}&source=${source}&tree=true&projectview=${projectview}',
		type:'POST',
		async:'false',
		success:function(data){
			var json=$.parseJSON(data);
			var p=$(".subitem");
			for(var i=0;i<json.length;i++) {
				var o=json[i];
				if(o.pid=="") {
					$(".mt").text($(".mt").text().replace("......","作业导航"));//【...】
					//$(".mt").text($(".mt").text().replace("...",o.text));
					continue;
				}
				if(o.pid=="-1"){
					var c=document.createElement("dl");
					$(c).attr("id","fold"+o.id);
					if(p.children.length==0) $(c).addClass("fore");
					var tt=document.createElement("dt");
					$(tt).text(o.text);
					$(c).append(tt);
					var cc=document.createElement("dd");
					$(c).append(cc);
					p.append(c);
				}
				var fold=null;
				if(o.pid!="-1")
					fold=o.pid;
				else if(o.attributes.url!=null && o.attributes.url!="")
					fold=o.id;
				if(fold!=null){
					var d=$("#fold"+fold);
					var e=document.createElement("em");
					var c=document.createElement("a");
					$(c).attr("ihref",o.attributes.url);
					$(c).attr("href","javascript:void(0)");
					$(c).attr("id","menu"+o.id);
					$(c).text(o.text);
					$(c).bind("click",clickmenu);
					$(e).append(c);
					d.find("dd").append(e);
					
					if(nodeId && o.id == nodeId){
						$(c).trigger('click');
					}
				}
			}
		}
	});
}

function changeProject(vars){
	var params = vars.split(',');
	var stage = 'prepare';
	if(params != null&&params.length>0){
		if(params[1] == '0'){
			stage='prepare';
		}else if(params[2]!=null&&params[2]=='0'){
			stage='actualize';
		}else if(params[3]!=null&&params[3]=='0'){
			stage='actualize';
		}else if(params[4]!=null&&params[4]=='0'){
			stage='account';
		}else if(params[5]!=null&&params[5]=='0'){
			stage='archives';
		}else if(params[6]!=null&&params[6]=='0'){
			stage='rework';
		}
	}
	window.location.href = '${contextPath}/project/prepare/projectIndex.action?crudId='+params[0]+'&view=${view}&stage='+stage;
}
function openMsg(){
	$('#con_win').window('open');
}
function closeMsg(){
	$('#con_win').window('close');
}
function openTool(tl,url){
	addTab('tabs',tl+"[审计工具]", "",url,true);
    $('#p').window('collapse');
	/*
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
	*/
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
    var password = decode64("${user.dataPass}");
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
<body class="easyui-layout" id="projectLayout" border="0">
	<div id="con_win" class="easyui-window" title="项目信息"
		collapsible="false" maximizable="true" closable="true"
		minimizable="false" style="width: 600px;height: 300px;" closed="true">
		<table id="projectStartTable" class="ListTable" style="width:100%">
			<tr>
				<td class="EditHead">项目名称</td>
				<td class="editTd"><s:property
						value="projectStartObject.project_name" /></td>
				<td class="EditHead">项目编号</td>
				<td class="editTd"><input type="hidden"
					name="projectStartObject.project_code"
					value="${projectStartObject.project_code }"> <s:property
						value="projectStartObject.project_code" /></td>
			</tr>
			<tr>
				<td class="EditHead">项目年度</td>
				<td class="editTd"><s:property
						value="projectStartObject.pro_year" /></td>
				<td class="EditHead">项目类别</td>
				<td class="editTd"><s:property
						value="projectStartObject.pro_type_name" /> &nbsp;&nbsp; <s:property
						value="projectStartObject.pro_type_child_name" /></td>
			</tr>
			<tr>
				<td class="EditHead">计划类别</td>
				<td class="editTd" colspan="3"><s:property
						value="projectStartObject.plan_type_name" /></td>
			</tr>
			<s:if test="${!projectStartObject.nbzwpg}">
				<tr>
					<td class="EditHead">审计单位</td>
					<td class="editTd"><s:property
							value="projectStartObject.audit_dept_name" /></td>
					<td class="EditHead">被审计单位</td>
					<td class="editTd"><s:property
							value="projectStartObject.audit_object_name" /></td>
				</tr>
			</s:if>
			<s:else>
				<td class="EditHead">测试组织者</td>
				<td class="editTd"><s:property
						value="projectStartObject.audit_dept_name" /></td>
				<td class="EditHead">测内控专岗负责人</td>
				<td class="editTd"><s:property
						value="projectStartObject.pro_teamleader_name" /></td>
			</s:else>
			<!-- 工程项目审计 -->
			<s:if test="projectStartObject.gcxmsj">
				<tr id="gcxmTr1">
					<td class="EditHead" id="gcxmTd1">合同金额</td>
					<td class="editTd"><s:property
							value="projectStartObject.contractAmount" />万元</td>
					<td class="EditHead" id="gcxmTd2">项目管理模式</td>
					<td class="editTd"><s:property
							value="projectStartObject.managerType" /></td>
				</tr>
				<tr id="gcxmTr2">
					<td class="EditHead" id="gcxmTd3">开工日期</td>
					<td class="editTd"><s:property
							value="projectStartObject.startProDate" /></td>
					<td class="EditHead" id="gcxmTd4">竣工日期</td>
					<td class="editTd"><s:property
							value="projectStartObject.finishProDate" /></td>
				</tr>
				<tr id="gcxmTr3">
					<td class="EditHead" id="gcxmTd5">项目状态</td>
					<td class="editTd" colspan="3"><s:property
							value="projectStartObject.proStatus" /></td>
				</tr>
			</s:if>

			<s:if test="projectStartObject.jjzrr">
				<tr>
					<td class="EditHead">经济责任人</td>
					<td class="editTd"><s:property
							value="projectStartObject.jjzrrname" /></td>
					<td class="EditHead">是否为总公司党组管理干部</td>
					<td class="editTd"><s:if
							test="${projectStartObject.isDangLeader=='true'}">
								是
							</s:if> <s:else>
								否
							</s:else></td>
				</tr>
			</s:if>
			<s:if test="projectStartObject.rework">
				<tr>
					<td class="EditHead">后续审计项目</td>
					<td class="editTd" colspan="3"><s:property
							value="projectStartObject.reworkProjectNames" /></td>
				</tr>
			</s:if>
			<tr>
				<td class="EditHead">开始日期</td>
				<td class="editTd"><s:property
						value="projectStartObject.pro_starttime" /></td>
				<td class="EditHead">结束日期</td>
				<td class="editTd"><s:property
						value="projectStartObject.pro_endtime" /></td>
			</tr>
			<s:if test="${!projectStartObject.nbzwpg}">
				<tr>
					<td class="EditHead" nowrap><s:if
							test="varMap['audit_start_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间开始</td>
					<td class="editTd"><s:property
							value="projectStartObject.audit_start_time" /> <input
						type="hidden" name="projectStartObject.audit_start_time"
						value="${projectStartObject.audit_start_time }"></td>
					<td class="EditHead" nowrap><s:if
							test="varMap['audit_end_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间结束</td>
					<td class="editTd"><s:property
							value="projectStartObject.audit_end_time" /> <input type="hidden"
						name="projectStartObject.audit_end_time"
						value="${projectStartObject.audit_end_time }"></td>
				</tr>
				<tr>
					<td class="EditHead">
						立项依据
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.content" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计目的
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.audit_purpose" />
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						审计安排
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.audArrange" />
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						审计重点
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.audEmphasis"/>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead">
						备注
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.plan_remark"/>
					</td>
				</tr>
			</s:if>
		</table>
	</div>
	<div region="north" border="0"
		style="height:auto;overflow:hidden;background:url('${contextPath}/resources/images/layout-browser-hd-bg.gif') repeat-x center;">
	<s:if test="isView == 2">
		<span style="float:left;font-weight: bold;font-size:16px;color:white;padding:15px 0 5px 10px;">项目名称：&nbsp;&nbsp;
</span>

<div class="navsort">
		<div class='allsort'>
        <strong class='mt'>${projectStartObject.project_name}......&nbsp;▽</strong>
        <div class='mc'>
            <div class='item fore'>
                    <div class='subitem'>
                    </div>
                </div>
        </div>
    </div>
</div>  

	</s:if>
	<s:else>
		<span
			style="float:left;font-weight:bold;font-size:16px;color:white;padding:5px 0 5px 10px;">项目切换
			<select style="width:200px;" id="project_list" class="easyui-combobox" data-options="panelWidth:'auto',editable:false"
			name="${projectStartObject.formId }">
				<s:iterator value="myProjectList" id="pro">
					<option value="${pro.formId },${pro.prepare_closed},${pro.actualize_closed},${pro.actualize_closed},${pro.report_closed},${pro.account_closed},${pro.archives_closed},${pro.rework_closed}"
						<s:if test='${projectStartObject.formId eq pro.formId }'>selected="selected"</s:if>>${pro.project_name}</option>
				</s:iterator>
			</select>
			
<div class="navsort" style="left:284px;top:4px">
		<div class='allsort'>
        <strong class='mt'>......&nbsp;▽</strong>
        <div class='mc'>
            <div class='item fore'>
                <div class='subitem'></div>
           </div>
        </div>
    </div>
</div>
<script language=javascript>
	$(document).ready(function(){
		$("#project_list").combobox({
			onChange:function(newValue, oldValue){
				changeProject(newValue);
			}
		});
		$("#project_list").combobox('setValue',$("#project_list").combobox('getValue'));
	});
</script> 
		</span>
	</s:else>
		
		<a href="javascript:void(0)" style="cursor: pointer;"
			onclick="win_close();"> <span
			style="float:right;font:bold;font-size:12;color:white;padding:10px 10px 5px 0;">退出项目</span>
		</a>
	</div>
	<div region="west" border='0' title="作业导航" style="width: 200px;padding:10px;" split="true" collapsed="true">
		<ul id="mTree" style="height: 100%; overflow: auto;">
		</ul>
	</div>
	<div region="center" border='0'>
		<div id="tabs" class="easyui-tabs" fit=true
			style="overflow: visibility ;"></div>
	</div>
	<div region="south" border='0' style="height:20px;overflow: hidden;">
		<div style="padding:3px 5px 0px 5px;">
		<!-- 	<div style='float:right;'>北京用友审计软件有限公司开发</div> -->
			<div style='float:left;' class="h_note_text">项目名称【${projectStartObject.project_name}】&nbsp;&nbsp;&nbsp;&nbsp;用户【${user.fname}】</div>
		</div>
	</div>
	<div id='p' style='overflow:hidden;'>
		<ul style="padding-left:10px;font:bold;">
			<li style="margin:5px;"><a href="javascript:void(0);"
				onclick="openMsg();">项目信息</a>
			</li>
			<li style="margin:5px; display:none;"><a href="javascript:void(0);"
				onclick="openTool('分组信息','${contextPath}/project/listGroups.action?view=${view }&crudId=${projectStartObject.formId }');">分组信息</a>
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
			<li style="margin:5px; display:none;"><a href="javascript:void(0);"
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
			<s:if test="${editAccountBook eq 'Y'}">
				<s:if test="${viewAccountBook eq 'Y'}">
					<li style="margin:5px;"><a href="javascript:void(0);"
						onclick="openTool('被审单位账套','/ais/project/prepare/accountbookEdit.action?projectId=${projectStartObject.formId}');">被审单位账套</a>
					</li>
				</s:if> 
			</s:if> 
			<s:if test="@ais.project.ProjectSysParamUtil@isZXSJEnabled()">
				<li style="margin:5px;"><a href="javascript:void(0);"
					onclick="zxsj();">大数据审计</a>
				</li>
			</s:if>
		</ul>
	</div>
	<div id="toolUrl" style='overflow:hidden;'></div>
	
	     <div id="tabsMenu" class="easyui-menu" style="width:120px;">  
		    <div data-options="iconCls:'icon-cancel'" name="close">关闭当前</div>  
		    <div data-options="iconCls:'icon-cancel'" name="Other">关闭其它</div>  
		    <div data-options="iconCls:'icon-cancel'" name="All">关闭所有</div>
		 </div> 
	
</body>
</html>
<script type="text/javascript"> 
$(".allsort").hoverForIE6({current:"allsorthover",delay:200});
$(".allsort .item").hoverForIE6({delay:150});
</script>

<script type="text/javascript">
	function win_close(){
	/* if(window.confirm("确认关闭吗?")){
		window.close();
	} */
	$.messager.confirm('确认对话框', '确认关闭吗?', function(r){
		if (r){
			window.close();
		}
	});


}
</script>
