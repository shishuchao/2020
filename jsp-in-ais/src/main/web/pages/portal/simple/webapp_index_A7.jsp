<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ais.framework.util.MyProperty"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<title>${titleName}</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<%--	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/portal.js"></script>--%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/main/ais.css">
	<link rel="shortcut icon" type="icon" href="<%=request.getContextPath()%>/images/displaytag/favicon.ico">
<style type="text/css">
.menu-collect{
	margin-top:8px;
	padding-left:2px;
	display:inline-block;
}
.menuActive{
	background-image: url('${contextPath}/index/assets/global/img/a7/menuActive.png')!important;
	font-weight:bold;
}
.menu-line{
    border-left-width:0px!important;
}
.home-menu-item{
	height:25px!important;
	line-height:25px!important;
}
.menu-icon{
	margin-top:-12px!important;
}
.menu{
	padding-left:15px!important;
	padding-right:10px!important;
	padding-top:10px!important;
	padding-bottom:10px!important;
}
.m-btn-plain-active,
.s-btn-plain-active  {
  background-color: transparent!important;
  border-width:0px!important;
}
.m-btn-downarrow{
	opacity:0.3;
    -moz-opacity:0.3;
    filter:alpha(opacity=30);
}

	/*导航菜单*/
	.navbar-menu{
		
		height:41px;
		width: 100%;
		font-size: 15px;
		text-align: center;
		overflow:auto;
		border-bottom: 2px solid #253646;
		margin-top: 77px;
		padding-left: 10px;
	}

	.navbar-menu a {
	    position: relative;
		text-decoration: none;	
		display: block;
		float:left;
		width: 120px;
		height: 30px;
		margin-top: 8px;
		margin-left: -10px;
		line-height: 30px;
		border-right: 2px solid #93b2e7;
		border-left: 1px solid #93b2e7;
		border-top: 1px solid #93b2e7;
		border-bottom: 1px solid #93b2e7;
		-moz-border-radius: 10px 10px 0px 0px;
		-webkit-border-radius: 10px 10px 0px 0px;
		border-radius: 10px 10px 0px 0px;
		background-color: #d9fdfd;
  		background: -webkit-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%);
  		background: -moz-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%);
  		background: -o-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%);
  		background: linear-gradient(to bottom,#EFF5FF 0,#d9fdfd 100%);
  		background-repeat: repeat-x;
  		filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#EFF5FF,endColorstr=#d9fdfd,GradientType=0);
	}
	
  
    /*左侧菜单*/
	.sidebar-menu{
	  border-right: 1px solid #c4c8cb;
	}
	
	.nav-list,.nav-list li a{
	  padding: 0px;
	  margin: 0px;
	  text-align:left;
	  padding-left: 25px;
	}
	.headletter a {
		font-size: 14px;
		font-weight: bold;
		color: #000;
	}


/*下拉菜单*/
.menubtn *{margin:0;padding:0;list-style-type:none;}
.menubtn a{border:0;color:#666666;text-decoration:none;-webkit-transition-property:color;-moz-transition-property:color;-o-transition-property:color;transition-property:color;-webkit-transition-duration:.2s;-webkit-transition-timing-function:ease-in;-moz-transition-duration:.2s;-moz-transition-timing-function:ease-in;-o-transition-duration:.2s;-o-transition-timing-function:ease-in;transition-duration:.2s;transition-timing-function:ease-in}
.menubtn a:hover{color:#cd0606;text-decoration:underline}
.menubtn{z-index:99999;position:fixed;/*width:150px;*/}
.menubtn h2{font-size:14px;}
.menubtn h2 a{font-size:14px;font-weight:normal}
.menubtn h2 a:hover{text-decoration:none;font-weight:bold;}
.menubtn h2 i{}
.menubtn h2 strong{}
.menubtn ul{z-index:99999;position:absolute;background-color:#60a411;width:150px;display:none;/*height:486px;top:36px;*/left:0px}
.menubtn ul li{padding-bottom:1px;zoom:1;clear:both;cursor:default}
.menubtn ul li .tx{line-height:35px;background-color:#d0d0ff;padding-left:20px;padding-right:10px;background-position:right center;height:35px;}
.menubtn ul li .tx a{font-size:14px;-webkit-transition:color 0.1s ease-out 0s;-moz-transition:color 0.1s ease-out 0s;-ms-transition:color 0.1s ease-out 0s;-o-transition:color 0.1s ease-out 0s;transition:color 0.1s ease-out 0s}
.menubtn ul li .tx a i{line-height:25px;margin-top:5px;width:25px;background-position:0px 0px;float:left;height:25px;margin-right:10px;text-decoration:none}
.menubtn ul li dl{zoom:1;color:#ffffff;clear:both;overflow:auto;padding-top:4px}
.menubtn ul li dl a{line-height:22px;white-space:nowrap;float:left;color:#d9e7ce;margin-left:6px;margin-right:6px;-webkit-transition:color 0.1s ease-out 0s;-moz-transition:color 0.1s ease-out 0s;-ms-transition:color 0.1s ease-out 0s;-o-transition:color 0.1s ease-out 0s;transition:color 0.1s ease-out 0s}
.menubtn ul li dt{padding-left:10px;width:30px;float:left;padding-top:1px}
.menubtn ul li dd{line-height:22px;width:150px;float:left;padding-top:2px}
.menubtn ul li .pop{border-bottom:#599900 2px solid;position:absolute;border-left:medium none;padding-bottom:10px;background-color:#fcfcfc;min-height:412px;padding-left:30px;width:540px;padding-right:30px;display:none;/*height:466px;*/border-top:medium none;top:0px;border-right:#599900 2px solid;padding-top:10px;left:150px;box-shadow:4px 4px 5px -1px #999999;-webkit-box-shadow:4px 4px 5px -1px #999999;-moz-box-shadow:4px 4px 5px -1px #999999}
.menubtn ul li .pop h3{display:none;font-size:14px}
.menubtn ul li .pop dl{padding-bottom:6px;color:#666666;padding-top:6px}
.menubtn ul li .pop dl:hover{background-color:#f3f3f3}
.menubtn ul li .pop dl a{color:#666666;margin-left:6px;margin-right:6px;margin-top:-2px;}
.menubtn ul li .pop dl a.un{color:#a5a5a5}
.menubtn ul li .pop dt{padding-left:0px;width:152px;text-align:right;font-weight:bold;}
.menubtn ul li .pop dd{padding-left:10px;width:375px;margin-left:-6px;}
.menubtn:hover ul{display:block}
.menubtn ul li:hover{background-color:#fcfcfc}
.menubtn ul li:hover .tx{background-color:#f5f5f5}
.menubtn ul li:hover .tx a{color:#333333;font-weight:bold;}
.menubtn ul li:hover .tx a i{background-position:0px -25px}
.menubtn ul li:hover .pop{display:block;top:0px;left:150px}
.menubtn ul li:hover .pop dl a.un{color:#a5a5a5;text-decoration:none;}
.menubtn ul li:hover dl{color:#6e6e6e}
.menubtn ul li:hover a{color:#666666;}
.menubtn ul li:hover a:hover{color:#cd0606;font-weight:bold;}
</style>
</head>

<script type="text/javascript">
    var contextPath = '${smvc}';
    var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';

	function addTab(tabPanelId,nodeText,nodeId,url,refresh,data){
		if(url == '') {
			return ;
		}
		$.ajax({
			url:"${contextPath}/updateTimes.action",
			type:'POST',
			data:{
				tabId:nodeId,
			}
		});
		var tab = $("#"+tabPanelId).tabs("getTab",nodeText);

		if(url.indexOf('login.jsp') > -1) {
			var queryString = url.substring(url.indexOf('p=') + 2) + ',${user.floginname}';
			var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
			url ="http://"+host+"/login.jsp?p="+encode64(encodeURI(queryString))+"&type=1";
			var udswin=window.open(url,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			udswin.moveTo(0,0);
			udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
		} else {
			if(data != null && data != '') {
				$('#leaderForm').attr('action',url);
				$('#leaderForm').attr('target',nodeId);
				$('#sjdw').val(data);
				$('#tjfw').val(data);
				url='';
			}
			if(tab){
				$("#"+tabPanelId).tabs('update', {
					tab : tab,
					title:nodeText,
					options : {
						content : '<iframe  id="'+nodeId+'id" src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden" ></iframe>'
					}
				});
				$("#"+tabPanelId).tabs("select",nodeText);
			}else{
				$("#"+tabPanelId).tabs("add",{
					id:nodeId,
					title:nodeText,
					closable:false,
					cache:false,
					content : '<iframe  id="'+nodeId+'id" name="'+nodeId+'" src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" allow="geolocation; microphone; camera; midi; encrypted-media;"></iframe>'
				});
			}
			if(data != null && data != '') {
				leaderForm.submit();
			}
			//IE9版本所有tabs选项卡出现滚动条，加上此如属性会隐藏掉滚动条，
			//由于此页面为重要页面，先加入此属性进行测试，如影响其他地方，到时再重新修改 by wudi
		    $("#tabs").find('.panel-body').each(function(){
				$(this).css('overflow','hidden');
			});
			showHideClose();
			
		}
	}
	//页面布局
	var mm = "${firstPage}";
	//获取子系统下的菜单
	function childMenu(pid,pName,zindex){
	    if(pName.indexOf('预警')>-1){
	    	var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
			var queryString = encode64(encodeURI(",,,${user.floginname}"));
			var url ="http://"+host+"/login.jsp?p="+queryString;
			var aa = document.getElementById("goYj");
			aa.href=url;
			aa.click();
			return;
		}

		var west_width = 200;
	    //$('#menu'+mm).css({'background-color': '#d9fdfd','background': '-webkit-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%)','background': '-moz-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%)','background': '-o-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%)','background':'linear-gradient(to bottom,#EFF5FF 0,#d9fdfd 100%)','background-repeat': 'repeat-x','filter': 'progid:DXImageTransform.Microsoft.gradient(startColorstr=#EFF5FF,endColorstr=#d9fdfd,GradientType=0)',"color": "#0E2D5F","z-index":zindex});
	    //$('#menu'+pid).css({'background': '#9be5fe',"color": "#0E2D5F","z-index":"9999"});
	    $('#menu'+mm).css({'background-color': '#d9fdfd','background': '-webkit-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%)','background': '-moz-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%)','background': '-o-linear-gradient(top,#EFF5FF 0,#d9fdfd 100%)','background':'linear-gradient(to bottom,#EFF5FF 0,#d9fdfd 100%)','background-repeat': 'repeat-x','filter': 'progid:DXImageTransform.Microsoft.gradient(startColorstr=#EFF5FF,endColorstr=#d9fdfd,GradientType=0)',"z-index":$('#menu'+mm).data('zindex')});
	    $('#menu'+pid).data('zindex', zindex).css({'background': '#9be5fe'});
	    
	    if(pid =="firstPage"){
	    	$("#tabs").tabs("select","首页");
	    	
	    }else{
		    $("#mTree").tree({
		        url:'${contextPath}/portal/simple/simple-firstPageAction!getChildMenu.action?fparentId='+pid,
		        cache:false,
		        //async:false,
		        lines:false,
		        onLoadSuccess:function(node, data){
		        	$.each( data, function(i, n){		    
		        		var node = $('#mTree').tree('find', data[i].id);
		    	    	$('#mTree').tree('expand', node.target);
		    	    	//alert(node.target.nodeName + "\n" + node.target.innerHTML)
	        		}); 
		        },
		        onContextMenu:function(e, node){
		        	if(aud$isShowCollectMenu()){		        		
			        	var isLeaf = $(this).tree('isLeaf', node.target);
			        	if(isLeaf){		        		
				        	e.preventDefault();
				        	$('#subMenuCollection').data('collectNode', node);
							$('#subMenuCollection').menu('show', {
								'left':e.pageX,
								'top' :e.pageY
							})
			        	}
		        	}
		        }, 
		        onClick:function(node){
		        	var url = node.attributes.url;
		            if(url!=null){
		            	var target = node.attributes.target;
		            	if(target && target.toLowerCase() == '_blank'){
		            		var wH = $(window).height();
		            		wH = wH <= 0 ? 700 : wH;
		            		var wW = $(window).width();
		            		wW = wW <= 0 ? 800 : wW;
		            		window.open(url,'','width='+wW+'px,height='+wH+'px,toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		            	}else{		            		
		                	goMenu(node.text,url,node.id);
		            	}
		            }
		        }
		    });
		    
		    
		    $('#mTree').show();    
		    $("#navMenu").panel({title:pName});
		    
	    }
	    if(pid=="firstPage"){
	        $("#mainLayout").layout("collapse","west");
	    }else{
	    	var panelClass = $("#mainLayout").layout("panel","west").parent().find('.panel-header').find('.panel-tool').find('a:last').attr('class');
	    	if(panelClass && (panelClass.indexOf('layout-button-right') != -1 || panelClass.indexOf('panel-tool-collapse') != -1)){
	    		$("#mainLayout").layout("expand","west");
	    	}
	    }
	    mm = pid;
	}
	function openwindow(url,name,iWidth,iHeight){
	  var url;                                 //转向网页的地址;
	  var name;                           //网页名称，可为空;
	  var iWidth;                          //弹出窗口的宽度;
	  var iHeight;                        //弹出窗口的高度;
	  var iTop = (window.screen.availHeight-iHeight)/2;       //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-iWidth)/2;           //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=no,resizeable=yes,location=no,status=no');
	}
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
	function reloadHomePage(){
        //reloadIframe('fistPage');
        var iframe = document.getElementById("firstPageTabid");
        if(iframe && iframe.contentWindow){
            var mywin = iframe.contentWindow;
            if(mywin.OnlineFirstPage){
				mywin.OnlineFirstPage.todoTaskTable();
			}else if(mywin.FirstPageTables){
				mywin.FirstPageTables.todoTaskTable();
			}else if(mywin.AotempFirstPage) {
				mywin.AotempFirstPage.specialData();
			}

        }
	}	
	//var msgId = data.inners[i].msgId;
	function openUrl(url){
		window.open(url,"_blank",'width=700,height=400,resizable=yes');
	}
	function viewinner(msgId){		
		openUrl('/ais/msg/innerMsg_view.action?innerMsg.msgId='+msgId);
	}   

</script>
<body class="easyui-layout" id="mainLayout" border="0">

    <div region="north" border="true" id='layoutNorth' split="false" 
    	style="overflow:hidden;height:100px;background-color:#2094d6!important;background:url('<%=request.getContextPath()%>/index/assets/global/img/a7/homeHeader.png');background-repeat: no-repeat; background-position: left top; overflow: hidden;;border:none;">
       <div style="position:absolute;">
			<label style="display:inline-block;vertical-align:middle;padding-left:50px;color:white;font-size:32px;
			font-weight:bold;line-height:70px;"><strong><span id="moduleName">审计综合管理系统</span></strong></label>
       		<span style="position:relative;top:20px;left:20px;float:left;">
       			<img src="<%=request.getContextPath()%>/index/assets/global/img/a7/navi_version.png" style="width:150px;"/>
       		</span>
       </div>
       
        <div style="margin-top: -63px;height:73px;">  
		    <div style='float:left;position:relative;top:-5px;'>
		        <a class="brand">
					<label class="icons icons-logo" style="height:52px;"></label>
				</a>
		    </div>
			<s:if test="${stage == null || stage == ''}">
		    <div style="float:right;line-height:20px;position:relative;top:65px;padding-right:2px;white-space: nowrap;">
				<s:if test="${sysOldVersion == 'true' && (user.floginname == 'superadmin' || user.floginname == 'admin') && oldVersionUrl != null  && oldVersionUrl != ''}">
					<a href="javascript:void(0);" class="l-btn l-btn-small l-btn-plain m-btn m-btn-small"  id="sysOldVersion" onclick="throwOldVersion()" title="系统旧版本" style="cursor:pointer;text-decoration: none;color:white;">
						<strong>系统旧版本</strong>
					</a>
				</s:if>
				<c:if test="${user.flevel ne 'aotemp' && audportal ne 'audportal'}"><!--&& audportal ne 'audportal'-->
				<a href="javascript:void(0);" id="interactiveMenu" title="交互" style="cursor:pointer;">
				  	<img alt="" style="width:24px;position:relative;top:3px;" src="<%=request.getContextPath()%>/index/assets/global/img/a7/interactive.png"> 
				</a>
				</c:if>
				<a href="javascript:void(0);" id="collectionMenu" title="收藏"   style="cursor:pointer;" > 
				  	<img alt="" style="width:24px;position:relative;top:3px;" src="<%=request.getContextPath()%>/index/assets/global/img/a7/collection.png"> 
				</a>				
				<a href="javascript:void(0);"  id="userInfoMenu" title="${user.fdepname}-${user.fname}" 
					 style="cursor:pointer;text-decoration: none;color:white;">
					<strong>${user.fdepname}&nbsp;&nbsp;${user.fname}</strong>
				</a>
		    </div>
			</s:if>
			<s:else>
			<div style="float:right;line-height:20px;position:relative;top:65px;padding-right:2px;white-space: nowrap;">
				<s:if test="${sysOldVersion == 'true' && (user.floginname == 'superadmin' || user.floginname == 'admin') && oldVersionUrl != null && oldVersionUrl != ''}">
					<a href="javascript:void(0);" class="l-btn l-btn-small l-btn-plain m-btn m-btn-small"  id="sysOldVersionOnline" onclick="throwOldVersion()" title="系统旧版本" style="cursor:pointer;text-decoration: none;color:white;">
						<strong>系统旧版本</strong>
					</a>
				</s:if>
				<a href="javascript:void(0);"  id="" title="${user.fdepname}-${user.fname}"
				   style="cursor:pointer;text-decoration: none;color:white;margin-right: 10px">
					<strong>${user.fdepname}&nbsp;&nbsp;${user.fname}</strong>
				</a>
			</div>
			</s:else>
		</div>
		<div id="pageMenubar" class="navbar-menu" style="position:relative;top:-25px;">
			<%int count = request.getAttribute("count")==null?0:(Integer)request.getAttribute("count"); %>
			 <c:forEach items="${menuList}" var="pm" varStatus="st">
	            <a id="menu${pm.ffunid}" href="#${pm.ffunid }" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('${pm.ffunid}','${pm.ffundisplay}',<%=count%>)" style="text-decoration: none;z-index:<%=count%>">${pm.ffundisplay}</a>
	        	<%count = count-1;%>
	        </c:forEach>
		</div>
		<c:if test="${audportal ne 'audportal'}">
			<div style="position:absolute;top:72px;right:5px;cursor:pointer;" title="收起" onclick="changePageHead()">
				<i class="fa fa-angle-double-up" style="color: white;font-size: 1.5em;"></i>
			</div>
		</c:if>
		<c:if test="${audportal eq 'audportal'}">
			<div data-options="iconCls:'icon-jc'" onclick="openSubsystem('决策支持系统','/portal/simple/http/ais//portal/simple/simple-firstPageAction!menu.action?isDecision=Y&parentMenuId=06')" class="home-menu-item menu-item" style="position:absolute;top:72px;right:830px;cursor:pointer;">
				<div class="menu-text" style="color: whitesmoke">决策支持系统</div>
				<div class="menu-icon icon-jc"></div>
			</div>
			<div data-options="iconCls:'icon-gl'" onclick="openSubsystem('审计管理系统','/portal/simple/http/ais//portal/simple/simple-firstPageAction!menu.action?parentMenuId=10')" class="home-menu-item menu-item" style="position:absolute;top:72px;right:700px;cursor:pointer;">
				<div class="menu-text" style="color: whitesmoke">审计管理系统</div>
				<div class="menu-icon icon-gl"></div>
			</div>
		   <div data-options="iconCls:'icon-zx'" onclick="openSubsystem('在线作业系统','/portal/simple/http/ais//portal/simple/simple-firstPageAction!menu.action?isOnline=Y&parentMenuId=15')" class="home-menu-item menu-item" style="position:absolute;top:72px;right:570px;cursor:pointer;">
			   <div class="menu-text" style="color: whitesmoke">在线作业系统</div>
			   <div class="menu-icon icon-zx"></div>
		   </div>
		   <div data-options="iconCls:'icon-sjfx'" onclick="openSubsystem('审计数据中心','/portal/simple/simple-firstPageAction!menu.action?isSystem=Y=&parentMenuId=')" class="home-menu-item menu-item" style="position:absolute;top:72px;right:440px;cursor:pointer;">
			   <div class="menu-text" style="color: whitesmoke">审计数据中心</div>
			   <div class="menu-icon icon-sjfx"></div>
		   </div>
		   <div data-options="iconCls:'icon-cxfx'" onclick="openSubsystem('查询分析系统','/portal/simple/simple-firstPageAction!menu.action?isSystem=Y=&parentMenuId=')" class="home-menu-item menu-item" style="position:absolute;top:72px;right:310px;cursor:pointer;">
			   <div class="menu-text" style="color: whitesmoke">查询分析系统</div>
			   <div class="menu-icon icon-cxfx"></div>
		   </div>
		   <div data-options="iconCls:'icon-yujing'" onclick="openSubsystem('监控预警系统','/portal/simple/simple-firstPageAction!menu.action?isSystem=Y=&parentMenuId=')" class="home-menu-item menu-item" style="position:absolute;top:72px;right:180px;cursor:pointer;">
			   <div class="menu-text" style="color: whitesmoke">监控预警系统</div>
			   <div class="menu-icon icon-yujing"></div>
		   </div>
		   <div data-options="iconCls:'icon-audCloud'" onclick="openSubsystem('审友云','http://10.2.112.21:28466/')" class="home-menu-item menu-item" style="position:absolute;top:72px;right:80px;cursor:pointer;">
			   <div class="menu-text" style="color: whitesmoke">审友云</div>
			   <div class="menu-icon icon-audCloud"></div>
		   </div>
		</c:if>

	</div>
	<c:if test="${user.flevel ne 'aotemp'}"><!--临时账号没有菜单-->
		<div region="west" title="首页" style="width:200px;overflow: hidden;" split="true" id="navMenu" collapsible="true" collapsed="true">
			<ul id="mTree" style="overflow:auto;padding:5px;height:98%;" class="tree treelines">
			</ul>
		</div>
	</c:if>
	<div region="center" style="overflow:hidden;" border="0">
		<a id="goYj" target="_blank"></a>
		<div id="tabs" class="easyui-tabs" fit="true" style="overflow: hidden;">
		</div>
	</div>
	<div region="south" border="true" split="false" style="overflow:hidden;height:25px;" >
		<%-- <div style="width:40%;font-size:13px;line-height:25px;float:left;text-align:left;padding-left:5px;">${productTitle}</div> --%>
		<div style="width:40%;font-size:13px;line-height:25px;float:right;text-align:right;padding-right:5px;">${copyright}</div>
	</div>
	<div id="newswindow"  title="站内消息" style="padding:0px;overflow:hidden;"  >
		<div class="easyui-layout" fit="true" border='0' style="padding:0px;overflow:hidden;">
			 <div region="center" border="0" style="padding:0px;overflow:hidden;">
			    <div class="easyui-tabs" fit="true" id="newsTabs" border='0'>
		            <div id='mynews' title='提示信息' style="padding:0px;overflow:hidden;">
		                 <iframe id="news_ifr" name="news_ifr" src=""  scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
		            </div>
		            <div id='weidu' title='未读消息' style="padding:0px;overflow:hidden;">
		                 <iframe id="weidu_ifr" name="weidu_ifr" src="" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
					</div>
					<div id='yidu' title='已读消息' style="padding:0px;overflow:hidden;">
					     <iframe id="yidu_ifr" name="yidu_ifr" src="" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
					</div>
					<div id='yifa' title="已发消息" style="padding:0px;overflow:hidden;">
					     <iframe id="yifa_ifr" name="yifa_ifr" src="" scrolling='yes' frameborder="0" width="100%" height="100%" ></iframe>
					</div>
					<div id='eamil' title='已发邮件' style="padding:0px;overflow:hidden;">
					     <iframe id="email_ifr" name="email_ifr" src="" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
					</div>
				</div>
			 </div>
			 <div region="south" border="0" style="text-align:right;padding:5px;overflow:hidden;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  href="javascript:void(0)" onclick="sendF()">&nbsp;新建消息</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"  href="javascript:void(0)" onclick="closeWin()">&nbsp;关闭</a>
			 </div>
		</div>
	</div>
	
	<div id="tab-tools">
		<a href="javascript:void(0)"  title="最大化、最小化" class="easyui-linkbutton easyui-tooltip" 
			plain="true" iconCls="icon-winmax"  onclick="setPageMaxOrMin(this)"></a>
	</div>

	<div style="display: none">
	<form action="" target="" id="leaderForm" method="post">
		<input type="text" name="sjdw" id="sjdw">
		<input type="text" name="tjfw" id="tjfw">
	</form>
	</div>
	<script type="text/javascript">	
	
	function menuActive(target){
		$('#pageMenubar').find('.menuActive').removeClass('menuActive').css('font-weight','normal');
		$(target).addClass("menuActive");
	}
	
	var tabsObj = $("#tabs");
    function changePageHead(){
		$("#mainLayout").layout("collapse","north");
		$('.layout-expand-north').bind('click',function () {
			if($(this).css('display') == 'block'){
				$("#mainLayout").layout("expand","north");
			}
		});
	}
	function showSubmenu(pid, pName){
	    if(pName.indexOf('预警')>-1){
	    	var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
			var queryString = encode64(encodeURI(",,,${user.floginname}"));
			var url ="http://"+host+"/login.jsp?p="+queryString;
			var aa = document.getElementById("goYj");
			aa.href=url;
			aa.click();
			return;
		}
	    if(pid =="firstPage"){
	    	$("#tabs").tabs("select","首页");
	    	
	    }else{
	        $("#mTree").tree({
	            url:'${contextPath}/portal/simple/simple-firstPageAction!getChildMenu.action?fparentId='+pid,
	            cache:false,
	            //async:false,
	            lines:true,
	            onLoadSuccess:function(node, data){
	                 $.each( data, function(i, n){		    
	                    var node = $('#mTree').tree('find', data[i].id);
                        $('#mTree').tree('expand', node.target);
                    }); 
	            },
	            onClick:function(node){
	                if(node.attributes.url!=null){
	                    goMenu(node.text,node.attributes.url,node.id);
	                }
	            }
	        });
	    }
	    //$('#mTree').show();    
	    $("#navMenu").panel({title:pName});
	    if(pid=="firstPage"){
	        $("#mainLayout").layout("collapse","west");
	    }else{
	    	var panelClass = $("#mainLayout").layout("panel","west").parent().find('.panel-header').find('.panel-tool').find('a:last').attr('class');
	    	//alert(panelClass)
	    	if(panelClass && (panelClass.indexOf('layout-button-right') != -1 || panelClass.indexOf('panel-tool-collapse') != -1)){
	    		$("#mainLayout").layout("expand","west");
	    	}
	    }
	}


    function throwOldVersion() {
        $.ajax({
            url:'${contextPath}/sysOldVersion.action',
            cache:false,
            dataType:'json',
            success:function(data){
                if(data != null){
                    var url = data.sysOldVersionMenu[0].flink;
                    aud$openNewWin(url,'系统旧版本');
                }
            }
        })
    }



	function setPageMaxOrMin(target){
		try{
	        var spanicon1 = $(target).find('.icon-winmax');
	        var spanicon2 = $(target).find('.icon-winmin');
	        var spanaction = "";
	        if(spanicon1.length){
	        	spanicon1.removeClass("icon-winmax").addClass("icon-winmin");
	            spanaction = "collapse";
	        }else if(spanicon2.length){
	            spanicon2.removeClass("icon-winmin").addClass("icon-winmax");
	            spanaction = "expand";
	        }
	        $('#mainLayout').layout(spanaction, 'north');
	        if($("#navMenu").panel("options").title!="首页"||spanaction!="expand")
	        	$('#mainLayout').layout(spanaction, 'west');
	        //$('#mainLayout').layout(spanaction, 'south');

            //下拉菜单
            if(spanaction=="collapse") window.setTimeout("newmenu()",500);
		}catch(e){
			//alert("setPageMaxOrMin:\n"+e.message);
		}       
   }

	function innerMsg() {
		if('${isDecision}' != 'Y' && '${isOnline}' != 'Y') {
			$.ajax({
				type:'post',
				dataType:'json',
				url:'${request.contextPath}/msg/innerMsg2firstPage.action',
				success:function(data){
					if(data.size > 0){
						$('#innerMsgCount').html(data.size);
						var info = "您有 <font color=\"red\">"+data.size+"</font> 条未读站内消息！<br />";
						info += "<div style=\"width:100%;overflow-x:hidden;\"><table class=\"ListTable\"><tr><td class=\"ListTableTr22\" style='text-align:center;white-space: nowrap;'><strong>序号</strong></td><td class=\"ListTableTr22\" style='text-align:center;white-space: nowrap;'><strong>主题</strong></td><td nowrap  class=\"ListTableTr22\" style='width:60px;text-align:center;'><strong>发送人</strong></td></tr>";
						for(var i=0; i<data.inners.length; i++){
							info += "<tr><td class=\"ListTableTr22\" style='text-align:center;' >"+(i+1)+"</td><td class=\"ListTableTr22\" ><a href=\"javascript:void(0)\" title='"+data.inners[i].subject+"' style='white-space: nowrap;width:280px; overflow:hidden;text-overflow: ellipsis; text-align:left;' onclick=\"viewinner('"+data.inners[i].msgId+"');\">"+data.inners[i].subject+"</a></td><td class=\"ListTableTr22\" style='width:60px;text-align:center;'>"+data.inners[i].fromUserName+"</td></tr>";
						}
						info += "</table></div>";
						$.messager.show({
							title:'站内消息',
							msg:info,
							timeout:3599000,
							showSpeed:1000,
							width:450,
							height:'auto',
						});
					}
				}
			});
		}
	}

	function reminder(){
		if('${hasRemindMessage}'=='true'){
			$.ajax({
				type:'post',
				dataType:'json',
				url:'${request.contextPath}/portal/simple/reminder.action?online=${isOnline}',
				success:function(data){
					if(data.rows.length > 0){
						var info = "您有待办任务需要处理！<br />";
						info += "<div style=\"width:100%;overflow-x:hidden;\"><table class=\"ListTable\"><tr><td class=\"ListTableTr22\" style='text-align:center;white-space: nowrap;'><strong>序号</strong></td><td class=\"ListTableTr22\" style='text-align:center;white-space: nowrap;'><strong>任务信息</strong></td></tr>";
						for(var i=0; i<data.rows.length; i++){
							info += "<tr><td class=\"ListTableTr22\" style='text-align:center;' >"+(i+1)+"</td><td class=\"ListTableTr22\" ><a href=\"javascript:;\" title='"+data.rows[i].description+"' style='white-space: nowrap;width:280px; overflow:hidden;text-overflow: ellipsis; text-align:left;cusor:pointer;' onclick=\"addTab('tabs','待办事项处理','backlog2','${contextPath}"+data.rows[i].editUrl+"&todoback=1',true);\">"+data.rows[i].description+"</a></td></tr>";
/* 							info += "<tr><td class=\"ListTableTr22\" style='text-align:center;' >"+(i+1)+"</td><td class=\"ListTableTr22\" ><a href=\"javascript:;\" title='"+data.rows[i].description+"' style='white-space: nowrap;width:280px; overflow:hidden;text-overflow: ellipsis; text-align:left;cusor:pointer;' onclick=\"goMenu('待办事项处理','${contextPath}"+data.rows[i].editUrl+"&todoback=1','reminder');\">"+data.rows[i].description+"</a></td></tr>"; */
						}
						info += "</table></div>";
						$.messager.show({
							title:'待办催办',
							msg:info,
							timeout:0,
							showSpeed:1000,							
							width:450,
							height:'auto'
						});
					}
				}
			});
		}
	}

		function showNewWin(){
			$('#news_ifr').attr('src','<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=-1');
			//$('#newswindow').window('open');
			$('#newswindow').window({
				modal: true,
				shadow: true,
				fit:true,
				closed: false,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
		}
		function closeWin(){
			$('#newswindow').window('close');
		}
		function sendF(){
			//var tabIndex = $('#newsTabs').tabs('option','selected');
			//var currentTab =$('#newsTabs').tabs('getSelected');
        	//var title = currentTab.panel('options').title;
        	var url = '<%=request.getContextPath()%>/msg/innerMsg_edit.action?readFlag=3';
			window.open(url,"_blank",'width=700,height=400,resizable=yes');
			<%-- $('#yifa_ifr').attr('src','<%=request.getContextPath()%>/msg/innerMsg_edit.action?readFlag=3');
			$('#newsTabs').tabs('select','已发消息'); --%>
		}
		
		function aud$isShowCollectMenu(){
			try{
				return "${firstpageType}" == "menu" || "${firstpageType}" == "decision";
			}catch(e){
				
			}
		}
		   
		jQuery(document).ready(function() {
			var firstpageUrl = null;
			var titleName = '';
			if("${firstpageType}" == "menu"){
				firstpageUrl = "${contextPath}/portal/simple/simple-firstPageAction!show.action";
				titleName = "${titleName}";
			}else if("${firstpageType}" == "online" ){
				firstpageUrl = "${contextPath}/portal/simple/simple-firstPageAction!show.action?isOnline=Y";
				$('body').layout('remove', 'west');
				titleName = "${titleName}";
			}else if("${firstpageType}" == "decision"){
				var decisionUrl = "${contextPath}/Leadershipinquiry/index.action";
				firstpageUrl = decisionUrl;
				titleName = "${titleName}";
				$('#menu620').click();
				//addTab("tabs","领导视图","decision_leaderView",decisionUrl,true);
			}else if(aud$isonline){
				titleName = "${projectStartObject.project_name}";
				$("#navMenu").panel({title:"审计作业"});
			}else if("${firstpageType}" == "interCtrl"){
				titleName = "${titleName}";
				firstpageUrl = "${contextPath}/portal/simple/simple-firstPageAction!show.action?isInterCtrl=Y";
			}else if(aud$interCtrl$online){
				titleName = "${ep.epName}";
			}
			if('${user.flevel}' == 'aotemp'){
				titleName = '远程协同审计工作平台';
			}
			if('${audportal}' == 'audportal'){
                titleName = '审计信息化集成平台';
                firstpageUrl = "${contextPath}/portal/simple/simple-firstPageAction!audportalA7.action";

            }
			$('#moduleName').text(titleName);

			innerMsg();
			reminder();
			setInterval('innerMsg()',3600000);//每小时自动检测是否有新站内消息
		
		   if(firstpageUrl){			   
			   $("#tabs").tabs("add",{
					id:'firstPageTab',
			     	iconCls:'icons-first',
			        content : '<iframe name="first" id="firstPageTabid" src="'+firstpageUrl+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  style="overflow: hidden;" frameborder="0" ></iframe>',
			        cache:false
			        /*,
			        tools:[{    
			            iconCls:'icon-mini-refresh',    
			            handler:function(){    
			            	 reloadHomePage();
			            }    
			        }]*/
			    });
		   }
		   
		 	//绑定tabs的右键菜单
		    $("#tabs").tabs({
		        onContextMenu : function (e, title) {
		            e.preventDefault();
		            $('#tabsMenu').menu('show', {
		                left : e.pageX,
		                top : e.pageY
		            }).data("tabTitle", title);

		        },
                //tools:"#tab-tools",
				toolPosition:'left'
		    });
		    //实例化menu的onClick事件
		    $("#tabsMenu").menu({
		        onClick : function (item) {
		        	if(item.name=='refresh'){
						var currTab = $("#tabs").tabs('getSelected');
						reloadIframe(currTab.panel('options').id+'id');
					}else {
						CloseTab(this, item.name);
					}
		        }
		    });
		    //几个关闭事件的实现
		    function CloseTab(menu, type) {
		        var curTabTitle = $(menu).data("tabTitle");
		        var tabs = $("#tabs");
		        
		        if (type === "close") {
		        	if(curTabTitle == ''){
		        		showMessage1('首页不可关闭');
		        		return;
					}
		            tabs.tabs("close", curTabTitle);
		            return;
		        }
		        
		        var allTabs = tabs.tabs("tabs");
		        var closeTabsTitle = [];
		        
		        $.each(allTabs, function () {
		            var opt = $(this).panel("options");
		            if(opt.title && opt.title != '首页'){		            	
			            if (opt.title != curTabTitle && type === "Other") {
			                closeTabsTitle.push(opt.title);
			            } else if (type === "All") {
			                closeTabsTitle.push(opt.title);
			            }
		            }
		        });
		        for(var i = 0; i < closeTabsTitle.length; i++) {
		            tabs.tabs("close", closeTabsTitle[i]);
		        }
		        tabs.tabs('select',curTabTitle);
		    }
		    $('#newsTabs').tabs({ 
		        border:false, 
		        onSelect:function(title,index){ 
					if(index == 0){
						$('#news_ifr')[0].contentWindow.refreshF();
					}else if(index == 1){
						var src = $('#weidu_ifr').attr('src');
						if(src == ''){
							$('#weidu_ifr').attr('src','<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=2');
						}else{
							$('#weidu_ifr')[0].contentWindow.refreshF();
						}
					}else if(index == 2){
						var src = $('#yidu_ifr').attr('src');
						if(src == ''){
							$('#yidu_ifr').attr('src','<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=1');
						}else{
							$('#yidu_ifr')[0].contentWindow.refreshF();
						}
					}else if(index == 3){
						var src = $('#yifa_ifr').attr('src');
						if(src == ''){
							$('#yifa_ifr').attr('src','<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=3');
						}else{
							$('#yifa_ifr')[0].contentWindow.refreshF();
						}
					}else if(index == 4){
						var src = $('#email_ifr').attr('src');
						if(src == ''){
							$('#email_ifr').attr('src','<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=4');
						}else{
							$('#email_ifr')[0].contentWindow.refreshF();
						}
					}
		        } 
		    });
		    //IE9版本所有tabs选项卡出现滚动条，加上此如属性会隐藏掉滚动条，
			//由于此页面为重要页面，先加入此属性进行测试，如影响其他地方，到时再重新修改 by wudi
		    $("#tabs").find('.panel-body').each(function(){
				$(this).css('overflow','hidden');
			});
		    

		});
</script>

<script type="text/javascript">



//菜单点击事件
function goMenu(tabName,flink,tabId,fparentid){
	if(flink == '') {
		return ;
	}
	$.ajax({
		url:contextPath+"/updateTimes.action",
		type:'POST',
		data:{
			tabId:tabId,
		}
	});
    if(tabName.indexOf('预警')>-1){
    	var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
		var queryString = encode64(encodeURI(",,,${user.floginname}"));
		var url ="http://"+host+"/login.jsp?p="+queryString;
		var aa = document.getElementById("goYj");
		aa.href=url;
		aa.click();
		return;
	}else{
		if(fparentid == '1'){
			return;
		}
		//modify by liyuchen 2016-03-24 begin 当点击url链接为空的情况下，无动作
		if(flink==null||flink=='null'){
			return;
		}
		//modify by liyuchen 2016-03-24 end   当点击url链接为空的情况下，无动作
		var tab = $("#tabs").tabs("getTab",tabName);
		if(tab){
			$("#tabs").tabs("getTab",tabName).panel('refresh');
			$("#tabs").tabs("select",tabName);
		}else{
			$("#tabs").tabs("add",{
				id:tabId,
				title:tabName,
				closable:false,
				cache:false,
				/*
				tools:[{    
		            iconCls:'icon-mini-refresh',    
		            handler:function(){  
		            	 reloadIframe(tabId+'id');
		            }
		        }],
		        */
				content : '<iframe  id="'+tabId+'id" src="'+flink+'" width="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" height="100%"></iframe>'
			});
			//IE9版本所有tabs选项卡出现滚动条，加上此如属性会隐藏掉滚动条，
			//由于此页面为重要页面，先加入此属性进行测试，如影响其他地方，到时再重新修改 by wudi
			$("#tabs").find('.panel-body').each(function(){
				$(this).css('overflow','hidden');
			});
			showHideClose();
		}
	}
}

function showHideClose() {
	$("#tabs").find('.tabs li').each(function(){
		var tabName='';
		$(this).find('.tabs-title').each(function(){
			tabName = $(this).text();
		});
		if(tabName != '') {

			$(this).bind('mouseenter',function(e){
				var pp = $("#tabs").tabs('getTab', tabName);
				var opts = pp.panel("options");
				var tab = opts.tab;
				var _32f = tab.find("span.tabs-title");
				var _330 = tab.find("span.tabs-icon");
				_330.attr("class", "tabs-icon");
				tab.find("a.tabs-close").remove();
				_32f.addClass("tabs-closable");
				$("<a href=\"javascript:void(0)\" class=\"tabs-close\"></a>").appendTo(tab);
			});
			$(this).bind('mouseleave',function(e){
				var pp = $("#tabs").tabs('getTab', tabName);
				var opts = pp.panel("options");
				var tab = opts.tab;
				var _32f = tab.find("span.tabs-title");
				var _330 = tab.find("span.tabs-icon");
				_330.attr("class", "tabs-icon");
				tab.find("a.tabs-close").remove();
				_32f.addClass("tabs-closable");
				_32f.removeClass("tabs-closable");
			});
		}
	});
}

function layout(){
	top.$.messager.confirm('确认','您确定要注销登录吗？',function(r){
		if(r){
			/*
			var iframe = document.getElementById("fistPage");
	        if(iframe && iframe.contentWindow){
	            var mywin = iframe.contentWindow;
	            mywin.close_win_close();
	        }*/
	        try{	        	
		       	//opener.close();
		       	aud$closeAllOpener();
	        }catch(e){}
			window.location="<%=request.getContextPath()%>/system/uSystemAction!loginOut.action";
		}
	});
}

function acntMngShow(){
	var url = '/ais/general/acntMng.action';
	$('#acntMng_ifr').attr('src',url);
  	$('#acntMng_div').window({
		width:350, 
		height:320,  
		modal:true,
		collapsible:false,
		maximizable:false,
		minimizable:false,
		closed:false    
	});
}

//跳转到非在线的功能，firstpage.jsp调用
var sname;
var slink;
var sid;
function goOther(formId,stage){
	if(stage == 'account'){
		sname = '项目台账';
		slink = '/ais/ledger/prjledger/projectLedgerNew/listTobeStarted.action';
		sid = '1021';
	}else if(stage == 'rework'){
		sname = '审计跟踪阶段';
		slink = '/ais/project/rework/listAll.action';
		sid = '1030';
	}else if(stage == 'archives'){
		sname = '项目归档';
		slink = '/ais/archives/pigeonhole/listTobeStarted.action?isUseTableName=noUse&projectId='+formId;
		sid = '1025';
	}
	var tab = $("#tabs").tabs("getTab",sname);
	if(tab){
		$("#tabs").tabs("getTab",tabName).panel('refresh');
		$("#tabs").tabs("select",tabName);
	}else{
		$("#tabs").tabs("add",{
			id:sid,
			title:sname,
			closable:false,
			cache:false,
			/*
			tools:[{    
	            iconCls:'icon-mini-refresh',    
	            handler:function(){  
	            	 reloadIframe(tabId+'id');
	            }
	        }],
	        */
			content : '<iframe  id="'+sid+'id" src="'+slink+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden" ></iframe>'
		});
		//IE9版本所有tabs选项卡出现滚动条，加上此如属性会隐藏掉滚动条，
		//由于此页面为重要页面，先加入此属性进行测试，如影响其他地方，到时再重新修改 by wudi
		$("#tabs").find('.panel-body').each(function(){
			$(this).css('overflow','hidden');
		});
		showHideClose();
	}
}

    //下拉菜单
    function newmenu() {
        var ttl=$('.layout-expand-north').find('.panel-header').find('.panel-title');
        if(ttl&&ttl.html()!='&nbsp;') return;
       	var str='';
		str+='<div id="_titlemsg" style="float:right;position:relative;padding-right:30px;;white-space: nowrap;">';
		str+='<a href="javascript:void(0);"  title="${user.fdepname}" style="text-decoration: none">欢迎您！<strong>${user.fname}</strong></a>';
		str+='&nbsp;<a href="javascript:void(0);" style="cursor:pointer;" title="注销" onclick="layout()">';
		str+='<img alt="" style="margin-top:-5px;" src="<%=request.getContextPath()%>/easyui/1.4/themes/icons/exit_off_power_shutdown_turn_.png"></a>';
		str+='&nbsp;<a style="cursor: pointer;" title="用户管理" onclick="acntMngShow()">';
		str+='<img style="margin-top:-5px;" src="${contextPath }/resources/images/newimg/web_08.gif" width="17" height="17"/></a>';
		str+='&nbsp;<a href="javascript:void(0);"  title="站内消息" class="dropdown-toggle" onclick="showNewWin()">';
		str+='<img style="margin-top:-5px;" src="${contextPath }/resources/images/newimg/web_14.gif" width="17" height="13"/></a>';
		//str+='<ul id="allMsg" class="dropdown-menu extended inbox"><li><p id="msgCount"></p></li></ul>';
		str+='</div>';

        ttl.html(str);
	}
    function newmenuevent(){
		$("#_titlemsg").on("click",function(){
			event.stopPropagation();
       		return false;
		});
		$("div.menubtn").on("click",function(){
			event.stopPropagation();
       		return false;
		});
		$("div.menubtn ul li div.pop dl dd a").on("click",function(){
			event.stopPropagation();
			//event.preventDefault(); 
        	goMenu($(this).text(),$(this).attr("menuurl"),$(this).attr("menunid"));
            $("div.menubtn ul").hide();
            window.setTimeout('$("div.menubtn ul").removeAttr("style");',500);
            return false;
      	});
	}
    
    //生成新的窗口时，若以存在关闭后从新打开一个窗口。
    function addNewTab(tabName,flink,tabId,fparentid){
    	var tab = $("#tabs").tabs("getTab",tabName);
    	if(tab){
    		$("#tabs").tabs("close",tabName)
    	}
    	$("#tabs").tabs("add",{
    		id:tabId,
    		title:tabName,
    		closable:false,
    		cache:false,
    		/*
    		tools:[{    
                iconCls:'icon-mini-refresh',    
                handler:function(){  
                	 reloadIframe(tabId+'id');
                }
            }],
            */
    		content : '<iframe  id="'+tabId+'id" src="'+flink+'" width="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" height="100%"></iframe>'
    	});
    	//IE9版本所有tabs选项卡出现滚动条，加上此如属性会隐藏掉滚动条，
    	//由于此页面为重要页面，先加入此属性进行测试，如影响其他地方，到时再重新修改 by wudi
    	$("#tabs").find('.panel-body').each(function(){
    		$(this).css('overflow','hidden');
    	});
		showHideClose();
    }

</script>
<div id="acntMng_div" title="账号管理" style="overflow:hidden;padding:0px">
  	<iframe id="acntMng_ifr" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
</div>

<div id="tabsMenu" class="easyui-menu" style="width:150px;">  
    <div data-options="iconCls:'icon-reload'" name="refresh">刷新当前</div>
    <div data-options="iconCls:'icon-cancel'" name="close">关闭当前</div>
    <div data-options="iconCls:'icon-cancel'" name="Other">关闭其他</div>
    <div data-options="iconCls:'icon-cancel'" name="All">关闭所有</div>
</div>
<div id="interactiveItems"></div>
<div id="collectionItems" style="width:210px;"></div>
<div id="userInfoItems">
	<div data-options="iconCls:'icon-user'" class='home-menu-item' onclick='acntMngShow()'>账号管理</div>
<%--	<c:if test="${user.floginname eq 'admin' or user.floginname eq 'superadmin' or user.flevel eq 'aotemp' or user.flevel eq 'admin'}">--%>
	<c:if test="${param.fromPortal ne '1'}">
		<div data-options="iconCls:'icon-cancel'" class='home-menu-item' onclick='layout()'>系统注销</div>
	</c:if>
	<div data-options="iconCls:'icon-help'" class='home-menu-item' onclick='openHelp()'>系统帮助</div>   
</div>
<div id="subMenuCollection" style="width:150px;">   
	<div data-options="iconCls:'icon-ok'"  class='home-menu-item' onclick='aud$CollectMenu(1)'>收藏菜单</div>   
	<div data-options="iconCls:'icon-cancel'"   class='home-menu-item' onclick='aud$CollectMenu(0)'>取消收藏</div>  
</div>
<script src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js" type="text/javascript" ></script>
<script src="<%=request.getContextPath()%>/resources/js/jQuery.md5.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/index/webappindex.js" type="text/javascript"></script>
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />

<script type="text/javascript">
var aud$isonline = "${projects}" ? true : false;
var contextPath = '${contextPath}';
var crudId = '${crudId}';
var source = '${source}';
var projectview = '${projectview}';
var menuIds = '${parents}';
var stateI = '${stateI}';
var aud$interCtrl$online = "${aud$interCtrl$online}" == "true";
var interCtrl$stage = '${stage}';
var interCtrl$isEnd = '${isEnd}';
///alert('crudId:'+crudId+'\nsource:'+source+'\nprojectview:'+projectview+'\nmenuIds:'+menuIds)
$(function(){
	try{
		var url = "<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!sysPortal.action";
		$.getJSON(url, {'homepage':'1'},  function (data) {
			var menus = data;//top.opener.menus || top.opener.opener.menus || top.opener.opener.opener.menus;
			if(menus){
				var menuSize = menus.menus.length;
				for(var i = 0; i < menuSize; i++){
					var menu = menus.menus[i];
					if(menu.iconCls.indexOf('gray') > -1) {
						continue;
					}
					var menuName = menu.menuName;
					var menuUrl = menu.flink+menu.menuId;
					var menuIcon = menu.iconCls;
					$("<div data-options=\"iconCls:'icon-"+menuIcon+"'\" class='home-menu-item'>"+menuName+"</div>")
					.appendTo('#interactiveItems')
					.data("menuName", menuName)
					.data("menuUrl", menuUrl).bind('click', function(){
						var n = $(this).data('menuName');
						var u = $(this).data('menuUrl');
						//alert(n+"\n"+u)
						openSubsystem(n, u);
					});
				}
			}
			$('#interactiveMenu').menubutton({
				 menu: '#interactiveItems'   
			});
		});
	}catch(e){
		//alert(e.message)
	}
	

	if(aud$isShowCollectMenu()){		
		$('#collectionMenu').menubutton({
			 menu: '#collectionItems'   
		});
	}else{
		$('#collectionMenu').hide();
	}
	
	$('#userInfoMenu').menubutton({
		menu: '#userInfoItems',
		menuAlign:'right'
	});
    $('#userInfoMenu1').menubutton({
        menu: '#userInfoItems',
        menuAlign:'right'
    });
	$("#mainLayout").data('expand', false);
	$("#mainLayout").layout('panel','west').panel({
		'onExpand': function(){
			$("#mainLayout").data('expand', true);			
			//aud$resize$firstpage$stbar(225);
		},
		'onCollapse':function(){
			$("#mainLayout").data('expand', false);
			//aud$resize$firstpage$stbar(240);
		}
	})
	
	function aud$resize$firstpage$stbar(divWidth){
		try{			
			setTimeout(function(){				
				var tabWin = top.$('#fistPage').get(0).contentWindow;
				tabWin.audRecomputeHomeStBar('homeStBar', 5, divWidth);
			},500);
		}catch(e){
			//alert("aud$resize$firstpage$stbar:"+e.message)
		}
	}
	
	$('#subMenuCollection').menu({
		'onHide':function(){
			$(this).removeData('collectNode');
		}
	});
	
});
function openSubsystem(sysName,link){
    if(sysName.indexOf('监控预警')>-1){
        link ="http://"+host+"/login.jsp?type=2&p="+queryString;
    }else if(sysName.indexOf('数据分析')>-1 || sysName.indexOf('大数据')>-1){
        link ="http://"+host+"/vision/Login-YY.jsp?audit=" + encodeURIComponent(queryString) + "&vision=A6";
    }else if(sysName.indexOf('数据预警')>-1){
        link ="http://"+host+"/login.jsp?type=0&p="+queryString;
    }else if(sysName.indexOf('审友云')>-1){
		link ="http://cloud.yonyouaud.com/";
	}else if(sysName.indexOf('监控预警')>-1){
		link ="http://"+host+"/login.jsp?type=2&p="+queryString;
	}else if(sysName.indexOf('查询分析')>-1){
		link ="http://"+host+"/login.jsp?type=1&p="+queryString;
	}else if(sysName.indexOf('数据中心')>-1){
		link ="http://"+host+"/login.jsp?type=3&p="+queryString;
	}
    else if(sysName.indexOf('离线作业系统')>-1){
		if (!confirm("离线作业系统需要安装的离线作业客户端，是否启动？")) {
			return;
		}
		link ="shenyi://offline";
	}
	else{
        link = "<%=request.getContextPath()%>/" + link;
		var lns = link.split("http");
		link = "http" + lns[lns.length - 1];
    }
    aud$openNewWin(link, sysName);
}

function aud$openNewWin(link, sysName){
    var windowArray = [];
    var udswin = window.open(
            link, sysName,
            'height='+window.screen.availHeight+'px, width='+window.screen.availWidth+'px, fullscreen=yes, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

        udswin.moveTo(0, 0);
        udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
        if(jQuery.inArray(udswin, windowArray) == -1){
        	windowArray.push(udswin);
        }else{
        	udswin.focus();
        }
}

function openHelp(){
	if (document.title == '决策支持系统')
	  	aud$openNewWin("<%=request.getContextPath()%>/A7AHLP.html", "系统帮助");
	else if (document.title == '在线作业系统')
		aud$openNewWin("<%=request.getContextPath()%>/A7OHLP.html", "系统帮助");
	else
		aud$openNewWin("<%=request.getContextPath()%>/A7MHLP.html", "系统帮助");
}

/**
 * 寻找最上层的opener
 */
function aud$getTopOpener(){
	try{		
		var t = opener;
		var openerArr = aud$getOpeners();
		if(openerArr != null && openerArr.length > 0){
			t = openerArr[openerArr.length - 1];
		}
		return t;
	}catch(e){
		//alert("aud$getTopOpener:"+ e.message)
	}
	
}
/**
 * 返回当前页面的所有前辈opener
 */
function aud$getOpeners(){
	var openerArr = [];
	var t = opener;
	try{
		var i = 1;
		while(t != null){
			openerArr.push(t);
			t = t.opener;
			//alert(++i)
		}
	}catch(e){
		//alert("aud$getOpeners:"+ e.message)
	}
	return openerArr;
}
/**
 * 关闭当前页面的所有前辈opener
 */
function aud$closeAllOpener(){
	try{		
		var openerArr = aud$getOpeners();
		if(openerArr != null && openerArr.length > 0){
			for(var i = 0; i < openerArr.length; i++){
				var p = openerArr[i];
				p.close();
			}
		}
	}catch(e){
		//alert("aud$closeAllOpener:"+ e.message)
	}
}

function aud$clearMenuNodeData(){
	
}

// type : 1-收藏， 0-取消收藏
function aud$CollectMenu(type){
	var firstpageType = "${firstpageType}";
	var node = $('#subMenuCollection').data('collectNode');
	if(type == '1'){		
		var linkUrl = node.attributes.url;
		$.ajax({
			url:"${contextPath}/addMarks.action",
	        type:'POST',
	        data:{
	            'tabName':node.text,
	            'flink':linkUrl,
	            'tabId':node.id,
	            'moduleName':'${firstpageType}'
	        },            
	        dataType:'json',
	        success:function(data) {
	        	aud$loadCollectMenu();
	        }
	    });
	}else{
		aud$removeCollectMenu(node.id)
	}

}

function aud$removeCollectMenu(tabId){
	$.ajax({
		url:"${contextPath}/removeMarks.action",
        type:'POST',
        data:{
            tabId:tabId,
        },            
        dataType:'json',
        success:function(data) {
        	aud$loadCollectMenu();
        }
    });
}

function aud$loadCollectMenu(){
    $.ajax({
        url:'${contextPath}/bookMarks.action',
        cache:false,
        dataType:'json',
        data:{
        	'moduleName':'${firstpageType}'
        },
        success:function(data){
        	var html = [];
    		var list = data.bookMarksList;
        	var length= list.length;
        	if(length >0){
				$('#collectionMenu').show();
        		$('#collectionItems').html('');
            	for(var i=0;i<length;i++) {
            		var tabId = list[i].menuId;
            		var tabName =  list[i].menuName;
            		var flink = list[i].menuLink;
            		var menuItem = $("<div class=\"home-menu-item menu-item\" style='cursor:pointer;'></div>");
            		var menuText = $("<div class=\"menu-text\"></div>");
            		menuText.text(tabName).attr('tabId', tabId).attr('tabName', tabName).attr('flink', flink)
            		.bind('click', function(){
            			var tabName_ = $(this).attr('tabName');
            			var flink_ = $(this).attr('flink');
            			var tabId_ = $(this).attr('tabId');
            			goMenu(tabName_, flink_, tabId_);
            		}).appendTo(menuItem);
            		var menuIcon = $("<div class=\"menu-icon tree-file\" style='margin-top:-10px!important;'></div>");
            		menuIcon.appendTo(menuItem);
            		var menuIcon2 = $("<div class=\"icon-cancel\" style='float:right;width:20px;height:20px;'></div>");
            		menuIcon2.attr('tabId', tabId).bind('click', function(){
            			var tabId_ = $(this).attr('tabId');
            			aud$removeCollectMenu(tabId_);
            		}).appendTo(menuItem);
            		menuItem.bind('mouseover', function(){
            			$(this).addClass('menu-active');
            		}).bind('mouseout', function(){
            			$(this).removeClass('menu-active');
            		}).appendTo($('#collectionItems'));
            	} 
        	}else{
                $('#collectionItems').html('');
				$('#collectionMenu').hide();
            }
        }
    });
}
if(aud$isShowCollectMenu()){	
	aud$loadCollectMenu()
}
</script>
</body>

</html>

