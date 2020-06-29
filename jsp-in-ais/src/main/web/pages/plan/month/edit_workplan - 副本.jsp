<html class="panel-fit"><head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
<title>审计管理系统</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

	<script type="text/javascript" src="/ais/easyui/boot.js"></script><link href="http://10.2.112.21:30302/ais/easyui/querytable.css" rel="stylesheet" type="text/css"><link href="http://10.2.112.21:30302/ais/easyui/1.4/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css"><link href="http://10.2.112.21:30302/ais/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css"><script src="http://10.2.112.21:30302/ais/easyui/1.4/jquery-1.7.1.min.js" type="text/javascript"></script><script src="http://10.2.112.21:30302/ais/easyui/1.4/jquery.easyui.min.js" type="text/javascript"></script><script src="http://10.2.112.21:30302/ais/easyui/1.4/locale/easyui-lang-zh_CN.js" type="text/javascript"></script><script src="/ais/index/preventBackspace.js" type="text/javascript"></script>
	<script type="text/javascript" src="/ais/resources/js/common.js"></script>
	<script type="text/javascript" src="/ais/scripts/base64_Encode_Decode.js"></script>
	<link rel="stylesheet" type="text/css" href="/ais/resources/csswin/style.css">
	<link rel="stylesheet" type="text/css" href="/ais/resources/csswin/subModal.css">
	<link rel="stylesheet" type="text/css" href="/ais/index/assets/global/plugins/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="/ais/styles/main/ais.css">
	<link rel="shortcut icon" type="icon" href="/ais/images/displaytag/favicon.ico">

<body class="easyui-layout layout panel-noscroll easyui-fluid" id="mainLayout" border="0" style="">

    <div class="panel layout-panel layout-panel-north" style="width: 1904px; left: 0px; top: 0px;">
		<div region="north" border="true" id="layoutNorth" split="false" style="background-image: url(&quot;/ais/index/assets/global/img/a7/homeHeader.png&quot;); background-size: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-repeat: no-repeat; background-position: left top; overflow: hidden; border: none; background-color: rgb(32, 148, 214) !important; width: 1904px; height: 100px;" title="" class="panel-body panel-body-noheader layout-body">
		   <div style="position:absolute;">
				<label style="display:inline-block;vertical-align:middle;padding-left:50px;color:white;font-size:32px;
				font-weight:bold;line-height:70px;"><strong><span id="moduleName">审计管理系统</span></strong></label>
				<span style="position:relative;top:20px;left:20px;float:left;">
					<img src="/ais/index/assets/global/img/a7/navi_version.png" style="width:150px;">
				</span>
		   </div>
       
			<div style="margin-top: -63px;height:73px;">  
				<div style="float:left;position:relative;top:-5px;">
					<a class="brand">
						<label class="icons icons-logo" style="height:52px;"></label>
					</a>
				</div>
				
				<div style="float:right;line-height:20px;position:relative;top:65px;padding-right:2px;white-space: nowrap;">
					
					<!--&& audportal ne 'audportal'-->
					<a href="javascript:void(0);" id="interactiveMenu" title="交互" style="cursor:pointer;" class="l-btn l-btn-small l-btn-plain m-btn m-btn-small" group=""><span class="l-btn-left"><span class="l-btn-text"><img alt="" style="width:24px;position:relative;top:3px;" src="/ais/index/assets/global/img/a7/interactive.png"></span><span class="m-btn-downarrow"></span><span class="m-btn-line"></span></span></a>
					
					<a href="javascript:void(0);" id="collectionMenu" title="收藏" style="cursor: pointer; display: none;" class="l-btn l-btn-small l-btn-plain m-btn m-btn-small" group=""><span class="l-btn-left"><span class="l-btn-text"><img alt="" style="width:24px;position:relative;top:3px;" src="/ais/index/assets/global/img/a7/collection.png"></span><span class="m-btn-downarrow"></span><span class="m-btn-line"></span></span></a>
					<a href="javascript:void(0);" id="userInfoMenu" title="审友集团-石树超" style="cursor:pointer;text-decoration: none;color:white;" class="l-btn l-btn-small l-btn-plain m-btn m-btn-small" group=""><span class="l-btn-left"><span class="l-btn-text"><strong>审友集团&nbsp;&nbsp;石树超</strong></span><span class="m-btn-downarrow"></span><span class="m-btn-line"></span></span></a>
				</div>
				
				
			</div>
			<div id="pageMenubar" class="navbar-menu" style="position:relative;top:-25px;">
				
				 
					<a id="menu1010" href="#1010" class="nav-header collapsed menuActive" data-toggle="collapse" onclick="menuActive(this);childMenu('1010','计划管理',11)" style="text-decoration: none; z-index: 11; font-weight: bold; background: rgb(155, 229, 254);">计划管理</a>
					
				
					<a id="menu1020" href="#1020" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1020','项目管理',10)" style="text-decoration: none; z-index: 10; font-weight: normal;">项目管理</a>
					
				
					<a id="menu1040" href="#1040" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1040','档案管理',9)" style="text-decoration: none; z-index: 9; font-weight: normal;">档案管理</a>
					
				
					<a id="menu1044" href="#1044" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1044','整改跟踪',8)" style="text-decoration: none; z-index: 8; font-weight: normal;">整改跟踪</a>
					
				
					<a id="menu1050" href="#1050" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1050','审计成果',7)" style="text-decoration: none; z-index: 7; font-weight: normal;">审计成果</a>
					
				
					<a id="menu1052" href="#1052" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1052','审计资源',6)" style="text-decoration: none;z-index:6">审计资源</a>
					
				
					<a id="menu1070" href="#1070" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1070','审计对象',5)" style="text-decoration: none;z-index:5">审计对象</a>
					
				
					<a id="menu1080" href="#1080" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1080','审计标准',4)" style="text-decoration: none;z-index:4">审计标准</a>
					
				
					<a id="menu1082" href="#1082" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1082','审计知识',3)" style="text-decoration: none;z-index:3">审计知识</a>
					
				
					<a id="menu1083" href="#1083" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('1083','专项填报',2)" style="text-decoration: none;z-index:2">专项填报</a>
					
				
					<a id="menu90" href="#90" class="nav-header collapsed" data-toggle="collapse" onclick="menuActive(this);childMenu('90','系统管理',1)" style="text-decoration: none;z-index:1">系统管理</a>
					
				
			</div>		
			<div style="position:absolute;top:72px;right:5px;cursor:pointer;" title="收起" onclick="changePageHead()">
				<i class="fa fa-angle-double-up" style="color: white;font-size: 1.5em;"></i>
			</div>
		
		

		</div>
	</div>
	<!--临时账号没有菜单-->
	<div class="panel layout-panel layout-panel-west layout-split-west" style="width: 195px; left: 0px; top: 99px; display: block;">
		<div class="panel-header" style="width: 183px;">
			<div class="panel-title">计划管理</div>
			<div class="panel-tool">
				<a class="panel-tool-collapse" href="javascript:void(0)" style="display: none;"></a>
				<a href="javascript:void(0)" class="layout-button-left"></a>
			</div>
		</div>
		<div region="west" title="" style="overflow: hidden; display: block; width: 193px; height: 830px;" split="true" id="navMenu" collapsible="true" collapsed="true" class="panel-body layout-body">
			<ul id="mTree" style="overflow:auto;padding:5px;height:98%;" class="tree treelines">
				<li>
					<div id="_easyui_tree_1" class="tree-node">
						<span class="tree-indent"></span>
						<span class="tree-icon tree-file "></span>
						<span class="tree-title">年度计划制定</span>
					</div>
				</li>
				<li>
					<div id="_easyui_tree_2" class="tree-node"><span class="tree-indent"></span>
						<span class="tree-icon tree-file "></span>
						<span class="tree-title">年度计划查看</span>
					</div>
				</li>
				<li>
					<div id="_easyui_tree_3" class="tree-node tree-node-selected">
						<span class="tree-indent"></span>
						<span class="tree-icon tree-file "></span>
						<span class="tree-title">年度计划调整</span>
					</div>
				</li>
				<li>
					<div id="_easyui_tree_4" class="tree-node">
						<span class="tree-indent"></span>
						<span class="tree-icon tree-file "></span>
						<span class="tree-title">计划甘特图</span>
					</div>
				</li>
				<li>
					<div id="_easyui_tree_5" class="tree-node">
						<span class="tree-indent"></span>
						<span class="tree-icon tree-file "></span>
						<span class="tree-title">我的排程</span>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="panel layout-panel layout-panel-center" style="width: 1704px; left: 200px; top: 99px;">
		<div region="center" style="overflow: hidden; width: 1704px; height: 859px;" border="0" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body panel-noscroll">
			<a id="goYj" target="_blank"></a>
			<div id="tabs" class="easyui-tabs tabs-container easyui-fluid" fit="true" style="overflow: hidden; width: 1704px; height: 859px;">
				<div class="tabs-header" style="width: 1702px;">
					<div class="tabs-scroller-left" style="display: none;"></div>
					<div class="tabs-scroller-right" style="display: none;"></div>
					<div class="tabs-wrap" style="margin-left: 0px; margin-right: 0px; width: 1702px;">
						<ul class="tabs" style="height: 26px;">
						<li class="">
							<a href="javascript:void(0)" class="tabs-inner" style="height: 25px; line-height: 25px;">
								<span class="tabs-title tabs-with-icon"></span>
								<span class="tabs-icon icons-first"></span>
							</a>
						</li>
						<li class="tabs-selected">
							<a href="javascript:void(0)" class="tabs-inner" style="height: 25px; line-height: 25px;">
								<span class="tabs-title">年度计划调整</span>
								<span class="tabs-icon"></span>
							</a>
						</li>
						</ul>
					</div>
				</div>
				<div class="tabs-panels" style="height: 828px; width: 1702px;">
					<div class="panel" style="display: none; width: 1702px;">
						<div title="" class="panel-body panel-body-noheader panel-body-noborder" id="firstPageTab" style="width: 1702px; height: 828px; overflow: hidden;">
							<iframe name="first" id="firstPageTabid" src="/ais/portal/simple/simple-firstPageAction!show.action" width="100%" height="100%" marginheight="0" marginwidth="0" style="overflow: hidden;" frameborder="0">
							</iframe>
						</div>
					</div>
					<div class="panel" style="display: block; width: 1702px;">
						<div title="" class="panel-body panel-body-noheader panel-body-noborder" id="101050" style="width: 1702px; height: 828px; overflow: hidden;">			
							<iframe id="101050id" src="/ais/plan/year/listAllAdjust!listAllAdjustMain.action" width="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="auto" height="100%">
							</iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="panel layout-panel layout-panel-south" style="width: 1904px; left: 0px; top: 957px;">
		<div region="south" border="true" split="false" style="overflow: hidden; width: 1902px; height: 23px;" title="" class="panel-body panel-body-noheader layout-body">
		
		<div style="width:40%;font-size:13px;line-height:25px;float:right;text-align:right;padding-right:5px;">北京用友审计软件有限公司</div>
		</div>
	</div>
	<div id="newswindow" title="站内消息" style="padding:0px;overflow:hidden;" class="panel-noscroll">
		<div class="easyui-layout layout easyui-fluid" fit="true" border="0" style="padding: 0px; overflow: hidden; width: 1904px; height: 1px;">
			 <div class="panel layout-panel layout-panel-center" style="width: 1904px; left: 0px; top: 0px;"><div region="center" border="0" style="padding: 0px; overflow: hidden; width: 1904px; height: 10px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body panel-noscroll">
			    <div class="easyui-tabs tabs-container easyui-fluid" fit="true" id="newsTabs" border="0" style="width: 1904px; height: 10px;">
		            
		            
					
					
					
				<div class="tabs-header tabs-header-noborder" style="width: 1904px;"><div class="tabs-scroller-left" style="display: none;"></div><div class="tabs-scroller-right" style="display: none;"></div><div class="tabs-wrap" style="margin-left: 0px; margin-right: 0px; width: 1904px;"><ul class="tabs" style="height: 26px;"><li class="tabs-selected"><a href="javascript:void(0)" class="tabs-inner" style="height: 25px; line-height: 25px;"><span class="tabs-title">提示信息</span><span class="tabs-icon"></span></a></li><li><a href="javascript:void(0)" class="tabs-inner" style="height: 25px; line-height: 25px;"><span class="tabs-title">未读消息</span><span class="tabs-icon"></span></a></li><li><a href="javascript:void(0)" class="tabs-inner" style="height: 25px; line-height: 25px;"><span class="tabs-title">已读消息</span><span class="tabs-icon"></span></a></li><li><a href="javascript:void(0)" class="tabs-inner" style="height: 25px; line-height: 25px;"><span class="tabs-title">已发消息</span><span class="tabs-icon"></span></a></li><li><a href="javascript:void(0)" class="tabs-inner" style="height: 25px; line-height: 25px;"><span class="tabs-title">已发邮件</span><span class="tabs-icon"></span></a></li></ul></div></div><div class="tabs-panels tabs-panels-noborder" style="height: 0px; width: 1904px;"><div class="panel" style="display: block; width: 1904px;"><div id="mynews" title="" style="padding: 0px; overflow: hidden; width: 1904px; height: 154px;" class="panel-body panel-body-noheader panel-body-noborder">
		                 <iframe id="news_ifr" name="news_ifr" src="" scrolling="no" frameborder="0" width="100%" height="100%"></iframe>
		            </div></div><div class="panel" style="display: none;"><div id="weidu" title="" style="padding:0px;overflow:hidden;" class="panel-body panel-body-noheader panel-body-noborder">
		                 <iframe id="weidu_ifr" name="weidu_ifr" src="" scrolling="no" frameborder="0" width="100%" height="100%"></iframe>
					</div></div><div class="panel" style="display: none;"><div id="yidu" title="" style="padding:0px;overflow:hidden;" class="panel-body panel-body-noheader panel-body-noborder">
					     <iframe id="yidu_ifr" name="yidu_ifr" src="" scrolling="no" frameborder="0" width="100%" height="100%"></iframe>
					</div></div><div class="panel" style="display: none;"><div id="yifa" title="" style="padding:0px;overflow:hidden;" class="panel-body panel-body-noheader panel-body-noborder">
					     <iframe id="yifa_ifr" name="yifa_ifr" src="" scrolling="yes" frameborder="0" width="100%" height="100%"></iframe>
					</div></div><div class="panel" style="display: none;"><div id="eamil" title="" style="padding:0px;overflow:hidden;" class="panel-body panel-body-noheader panel-body-noborder">
					     <iframe id="email_ifr" name="email_ifr" src="" scrolling="no" frameborder="0" width="100%" height="100%"></iframe>
					</div></div></div></div>
			 </div></div>
		 <div class="panel layout-panel layout-panel-south" style="width: 1904px; left: 0px; top: -35px;">
			 <div region="south" border="0" style="text-align: right; padding: 5px; overflow: hidden; width: 1894px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
				<a class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="sendF()" group="" id="">
					<span class="l-btn-left l-btn-icon-left">
						<span class="l-btn-text">&nbsp;新建消息</span>
						<span class="l-btn-icon icon-ok">&nbsp;</span>
					</span>
				</a>&nbsp;
				<a class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="closeWin()" group="" id="">
					<span class="l-btn-left l-btn-icon-left">
						<span class="l-btn-text">&nbsp;关闭</span>
						<span class="l-btn-icon icon-cancel">&nbsp;</span>
					</span>
				</a>
			 </div>
		 </div>
		<div class="layout-split-proxy-h"></div>
		<div class="layout-split-proxy-v"></div></div>
	</div>
	
	<div id="tab-tools">
		<a href="javascript:void(0)" title="" class="easyui-linkbutton easyui-tooltip tooltip-f l-btn l-btn-small l-btn-plain" plain="true" iconcls="icon-winmax" onclick="setPageMaxOrMin(this)" group="" id="">
			<span class="l-btn-left l-btn-icon-left">
				<span class="l-btn-text l-btn-empty">&nbsp;</span>
				<span class="l-btn-icon icon-winmax">&nbsp;</span>
			</span>
		</a>
	</div>

	<div style="display: none">
		<form action="" target="" id="leaderForm" method="post">
			<input type="text" name="sjdw" id="sjdw">
			<input type="text" name="tjfw" id="tjfw">
		</form>
	</div>

<div id="acntMng_div" title="账号管理" style="overflow:hidden;padding:0px">
  	<iframe id="acntMng_ifr" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
</div>







<div id="tabsMenu" class="easyui-menu menu-top menu" style="overflow: hidden; width: 123px; height: 128px; display: none; left: 0px; top: 0px;">
	<div class="menu-line" style="height: 148px;"></div>  
    <div data-options="iconCls:'icon-reload'" name="refresh" class="menu-item">
		<div class="menu-text">刷新当前</div>
		<div class="menu-icon icon-reload"></div>
	</div>
    <div data-options="iconCls:'icon-cancel'" name="close" class="menu-item">
		<div class="menu-text">关闭当前</div>
		<div class="menu-icon icon-cancel"></div>
	</div>
    <div data-options="iconCls:'icon-cancel'" name="Other" class="menu-item">
		<div class="menu-text">关闭其他</div>
		<div class="menu-icon icon-cancel"></div>
	</div>
    <div data-options="iconCls:'icon-cancel'" name="All" class="menu-item">
		<div class="menu-text">关闭所有</div>
		<div class="menu-icon icon-cancel"></div>
	</div>
</div>
<div class="layout-split-proxy-h"></div><div class="layout-split-proxy-v"></div><div class="panel layout-expand layout-expand-west" style="display: none; width: 28px; left: 0px; top: 99px;"><div class="panel-header" style="width: 16px;"><div class="panel-title">&nbsp;</div><div class="panel-tool"><a href="javascript:void(0)" class="layout-button-right"></a></div></div><div title="" class="panel-body" style="width: 26px; height: 831px;"></div></div><div id="collectionItems" style="overflow: hidden; width: 183px; height: 0px; display: none; left: 0px; top: 0px;" class="menu-top menu"></div><div id="userInfoItems" class="menu-top menu" style="overflow: hidden; width: 101px; height: 74px; display: none; left: 0px; top: 0px;"><div class="menu-line" style="height: 94px;"></div>
	<div data-options="iconCls:'icon-user'" class="home-menu-item menu-item" onclick="acntMngShow()" style="height: 10px;"><div class="menu-text">账号管理</div><div class="menu-icon icon-user"></div></div>

	
	<div data-options="iconCls:'icon-help'" class="home-menu-item menu-item" onclick="openHelp()" style="height: 10px;"><div class="menu-text">系统帮助</div><div class="menu-icon icon-help"></div></div>   
</div><div id="subMenuCollection" style="overflow: hidden; width: 123px; height: 74px; display: none; left: 0px; top: 0px;" class="menu-top menu"><div class="menu-line" style="height: 94px;"></div>   
	<div data-options="iconCls:'icon-ok'" class="home-menu-item menu-item" onclick="aud$CollectMenu(1)"><div class="menu-text">收藏菜单</div><div class="menu-icon icon-ok"></div></div>   
	<div data-options="iconCls:'icon-cancel'" class="home-menu-item menu-item" onclick="aud$CollectMenu(0)"><div class="menu-text">取消收藏</div><div class="menu-icon icon-cancel"></div></div>  
</div><div id="interactiveItems" class="menu-top menu" style="overflow: hidden; width: 131px; height: 296px; display: none; left: 0px; top: 0px;"><div class="menu-line" style="height: 316px;"></div><div data-options="iconCls:'icon-jc'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">决策支持系统</div><div class="menu-icon icon-jc"></div></div><div data-options="iconCls:'icon-gl'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">审计管理系统</div><div class="menu-icon icon-gl"></div></div><div data-options="iconCls:'icon-zx'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">在线作业系统</div><div class="menu-icon icon-zx"></div></div><div data-options="iconCls:'icon-gc'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">离线作业系统</div><div class="menu-icon icon-gc"></div></div><div data-options="iconCls:'icon-sjfx'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">审计数据中心</div><div class="menu-icon icon-sjfx"></div></div><div data-options="iconCls:'icon-cxfx'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">查询分析系统</div><div class="menu-icon icon-cxfx"></div></div><div data-options="iconCls:'icon-yujing'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">监控预警系统</div><div class="menu-icon icon-yujing"></div></div><div data-options="iconCls:'icon-audCloud'" class="home-menu-item menu-item" style="height: 10px;"><div class="menu-text">审友云</div><div class="menu-icon icon-audCloud"></div></div></div><div class="panel window" style="display: block; width: 1816px; left: 38px; top: 31px; z-index: 9010;"><div class="panel-header panel-header-noborder window-header" style="width: 1816px;"><div class="panel-title panel-with-icon" style="">&nbsp;编辑</div><div class="panel-icon icon-viewList"></div><div class="panel-tool"><a class="panel-tool-max" href="javascript:void(0)"></a><a class="panel-tool-close" href="javascript:void(0)"></a></div></div><div id="topDialogId_1592456205929" style="overflow: hidden; width: 1814px; height: 884px; margin-top: 0px; margin-bottom: 0px;" title="" class="panel-body panel-body-noborder window-body"><iframe width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" scrolling="hidden" src="/ais/plan/detail/editDetail.action?planUpdate=yes&amp;fromAdjust=yes&amp;crudId=D25F3E61-FD09-98BE-D8CB-421D8F7D09B2&amp;option=edityuxuan&amp;yearFormId=524913E7-6C64-6E67-9FBB-1582BC0052E5&amp;activeTabId=101050&amp;activeTabId=101050"></iframe></div></div><div class="window-mask" style="width: 1904px; height: 982px; display: block; z-index: 9009;"></div></body></html>