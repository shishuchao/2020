<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<title>通用控件(树形、数据表格)Demo</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 	
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript">
//scriptJsonp回调的函数
function scriptJsonpCallbackFn(data){
	alert("script jsonp 返回值："+data.msg);
}

// add by qfucee, 2014.3.27
$(function(){		
	
	var obj = $('#auditObjectTreeId')[0];
	var dpetId = '${user.fdepid}';
	
	// 自定义 - 组织机构树
	showSysTree(obj,{
		container:obj,
		defaultDeptId:dpetId,
		//checkbox:true,
		// true:只能选择叶子节点， 默认为false，都可以选择
		onlyLeafClick:true,
		// 展示树形tab的titile
		//treeTabTitle1:'自定义组织结构树',
		// 搜索结果tab的titile
		//treeTabTitle2:'组织结构树搜索结果',
		// 树形是否显示查询框,默认为true，显示查询框
		treeQueryBox:true,
		// 选择本级和本上级
		cascadePrior:true,
		// 选择本级和本下级
		cascadeJunior:true,
		//展开当前节点下的所有节点（为了性能默认展开节点不超过4层）, 默认：false
		cascadeExpand:true,	  
		param:{
			// 在node的atrributes中添加想要得到业务对象
			//'treeAtrributes':'template_type,taskName,taskPid,project_id,taskOrder',
			/*
			   数据授权模块id, 12:组织机构树授权; 如果是组织机构树,这个参数可选; 如果是其它树,如果想用数据授权限制查询范围,则必填;
			   如果想显示全部的节点，可以为authModuleId赋一个特殊值authModuleId=-1，使sql查询不到；
			*/
			//'authModuleId':'12',// 按数据授权过滤
			//'authModuleId':'-1',// 显示全部节点
			//'serverCache':true,//true:加载时读取后台缓存； false：每次都是重新加载, 默认true
			//'isOracle':true,//后台判断是否为oracle数据库, 如果是则使用oracle特性生成树形结构数据
			/**
				   参数plugId, 用于区别请求的组件。如果没有plugId，则默认使用beanName，
				  如果页面两个组件的beanName一样，但是有where条件，条件不一样，说明这是不同的两棵树，则需要设置plugId；
				  如果所有的条件都一样，那么就不用设置plugId。
			*/
			//'plugId':'UOrganizationTreeDemo',
			'beanName':'UOrganizationTree',
			'treeId'  :'fid',
			'treeText':'fname',
			'treeParentId':'fpid',
			'treeOrder':'fcode'
		},
		onTreeClick:function(node, treeDom){
			var selectedTab = $(qtab).tabs('getSelected');
			var selectedTabIndex = $(qtab).tabs('getTabIndex',selectedTab);
			//alert(selectedTabIndex)
			if(selectedTabIndex == 0){
				var gridObject = $('#orgTable');
				// 缓存查询参数，供分页刷新等功能使用
				var gridQueryParamJson = {'query_eq_fpid':node.id,'sort':'cityName'};
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
			}else if(selectedTabIndex == 1){
				var gridObject = $('#auditTable');
				// 缓存查询参数，供分页刷新等功能使用
				var gridQueryParamJson = {'query_eq_departmentId':node.id,'sort':'name'};
				g2.setGridQueryParams(gridQueryParamJson);
				QUtil.loadGrid({
					// 传入的查询参数； 可选
					param:gridQueryParamJson,
					// 表格对象
					gridObject:gridObject[0]
				});
			}
		}
	});
	
	
	
	// 右侧组织机构表格
	var g1 = new createQDatagrid({
		// 表格dom对象，必填
		gridObject:$('#orgTable')[0],
		// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
		boName:'UOrganization',
		// 对象主键,删除数据时使用-默认为“id”；必填
		pkName:'fid',
		// 自己指定服务类，不指定默认为ICommonPlugService接口的实现类的名称，即：commonPlugService；可选
		'serviceInstance':'commonPlugService',
		// 自己指定服务类时，还要指定执行的方法， 不指定默认为getCustomDatagrid；可选
		'serviceMethod':'getCustomDatagrid',
		// 表格加载前执行，做一些校验工作；可选
		'beforeSendFn':function(){
			//alert("beforeSendFn");
		},
		// 表格加载后执行，一般做些和表格相关的工作；可选
		'afterSuccessFn':function(data, gridObject){
			//alert("afterSuccessFn");
		},
		// 查询窗口打开时执行；可选
		'winopenFn':function(){
			//alert('winopenFn');
		},
		// 查询窗口关闭时执行；可选
		'wincloseFn':function(){
		   // alert('wincloseFn');
		},
		// 查询窗口关闭按钮单击前执行,返回true时，默认的关闭方法会继续执行 or 只执行这个方法且窗口不会关闭；可选
		'winBeforeClickCloseBtnFn':function(){
			//alert('winBeforeClickCloseBtnFn');
			return true;//false;
		},
		
		// 查询窗口搜索按钮单击前执行，返回true继续 or 停止；可选
		'winBeforeClickSearchBtnFn':function(){
			//alert('winBeforeClickSearchBtnFn');
			return true;
		},
		// 查询窗口搜索按钮单击时执行，返回true时，默认的搜索方法会继续执行 or 只执行这个方法；可选
		'winWhenClickSearchBtnFn':function(){
			//alert('winWhenClickSearchBtn');
			return true;
		},
		// 编辑窗口保存按钮单击前执行，返回true继续 or 停止；可选
		'winBeforeClickSaveBtn':function(){
			//alert('winBeforeClickSaveBtnFn');
			return true;
		},
		// 编辑窗口保存按钮单击时执行；可选
		'winWhenClickSaveBtnFn':function(){
			//alert('winWhenClickSaveBtnFn');
			return true;
		},
		// 默认删除按钮单击前执行, return ture:继续； false：停止；可选
		'beforeRemoveRowsFn':function(rows, gridObject){
			//alert(rows.length+' '+gridObject)
			return true;
		},
		/**
		.通用表格createQDatagrid
		  添加属性:myToolbar , 上面的按钮 删除、导出、查询、刷新按钮，根据参数自动生成，如果没有配置此参数，则全部显示
		  例如: myToolbar:['delete', 'export', 'search', 'reload'];
		 add by qfucee, 2017.2.28
		*/
		myToolbar:['delete'],
		//删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject)
		afterRemoveRowsFn:function(rows, gridObject){
			alert('it is called after delete success')
		},
		//定制查询
		//whereSql: apStatusCode ? " apStatusCode='"+apStatusCode+"' " : "",
		//删除时的where
		//delWhere:" ftype='C' and fstatus='Y'",
		// 表格控件dataGrid配置参数; 必填
		gridJson:{
			queryParams:{'query_eq_fpid':1, 'sort':'cityName'},
			// datagrid自带的事件
			onClickRow:function(index){
				//alert('点击了第'+(index+1)+'行');
			},
			// 自定义按钮，初始化时会和插件自带的按钮合并在一起
			toolbar:[{   
					text:'AjaxJSONP',
					iconCls:'icon-ok',
					id:'AjaxJSONP',
					handler:function(a){
						//JSONP测试
						$.ajax({
							url:"${contextPath}/commonPlug/cmjsonp.action",
							dataType: "jsonp",
							//传递给请求处理程序或页面的，用以获得jsonp回调函数名的参数名(一般默认为:callback)
							jsonp: "callback",
							//自定义的jsonp回调函数名称，默认为jQuery自动生成的随机函数名，也可以写"?"，jQuery会自动为你处理数据
							jsonpCallback:"ajaxJsonpCallbackFn",
				            success: function(data){
				                alert("jsonp 返回值："+data.msg);
				            },
				            error: function(a){
				           		alert(a);
				            }
						});
					}
				},'-',{   
					text:'ScriptJSONP',
					iconCls:'icon-ok',
					id:'ScriptJSONP',
					handler:function(a){
						var url = "${contextPath}/commonPlug/cmjsonp.action?callback=scriptJsonpCallbackFn";
						$("<script type='text/javascript'><\/script>").attr("src", url).appendTo("head");	
					}
				},'-',{   
					text:'移除本身',
					iconCls:'icon-remove',
					id:'g1Remove',
					handler:function(a){
						   g1.batchSetBtn([
							   {'id':'g1Remove','remove':true}
						]);
					}
				},'-',{   
					text:'查看状态',
					iconCls:'icon-view',
					handler:function(a){
						g1.batchSetBtn([{'index':3, 'disabled':true},
						{'index':4, 'disabled':true},
						{'index':5, 'disabled':true},
						{'index':6, 'disabled':true}]);
					}
				},'-',{   
					text:'编辑状态',
					iconCls:'icon-edit2',
					handler:function(a){
						//g1.setBtnName(1,'编辑');
						//g1.setBtnIcon(1,'edit');
						// 上面两个，可以综合起来这么写，这样就请求一次
						//g1.batchSetBtn([{'index':1, 'name':'编辑', 'icon':'edit'}]);
						g1.batchSetBtn([{'index':3, 'disabled':false},
						{'index':4, 'disabled':false},
						{'index':5, 'disabled':false},
						{'index':6, 'disabled':false}]);
					}
				},'-', {   
					text:'隐藏',
					iconCls:'icon-undo',
					handler:function(){
						g1.batchSetBtn([
						{'index':3, 'display':false},
						{'index':4, 'display':true, 'icon':'help'}]);
					}
				},'-', {   
					text:'显示',
					iconCls:'icon-redo',
					handler:function(){
						g1.batchSetBtn([ {'index':3,  'display':true},{'index':4,  'icon':'redo'}]);
					}
				},'-', {   
					text:'通用Excel解析',
					iconCls:'icon-redo',
					handler:function(){
					   $('#importExcelTest').window('open');
					}
				},'-' 
			],
			title:'组织机构详细信息',
			columns:[[ 
				{field:'fid'  ,   title:'选择',   width:'50px', checkbox:true, align:'center', show:false},      
				{field:'fname',   title:'单位名称',width:'200px',align:'left',   sortable:true, oper:'like'},
				{field:'cityName',title:'城市名称',width:'100px',align:'center', sortable:true, oper:'like'},
				{field:'cityCode',title:'城市代码',width:'100px',align:'center', sortable:true}]]
		}
	});
	
	// 修改预制按钮
	//g1.setBtnName(1,'自定义按钮');// 第一个按钮修改名称
	//g1.setBtnName(2,false);// 设置按钮的状态, false:隐藏， true：显示
	
	
	/**
		setGridBtn 设置表格按钮的名字或者状态
		参数：gridObject　-　domObject, 表格dom对象
			  btnArr      -  [], 按钮数组，每个一个元素为一个json对象，
			  包括如下信息[{
				'id':'btnAdd',//如果有按钮的id，则index失效
				'remove':true/false //把按钮对象整个从dom中移除
				'index':1, // 按钮的下标从1开始，如果超过实际按钮数组的最大长度，则默认为指向最后一个按钮
				'name' :'newName',//指定按钮的新名字
				'display':true/false, // 按钮的状态，true：显示 or  false：隐藏
				'icon':'cut', // 按钮样式，eg：’cut，save， add '等
				'disabled':'tue/false', // 按钮是否可用
				
				
			  },{}]
	*/

	
	// 右侧被审计单位表格
	var g2 = new createQDatagrid({
		// 查询form窗口的高度和宽度，插件会根据宽度自动确定一行放几列查询条件; 可选， 默认为：600,390，放两组查询条件
		winWidth:900,
		winHeight:500,
		// 表格dom对象，必填
		gridObject:$('#auditTable')[0],
		// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
		boName:'AuditingObject',
		// 对象主键,删除数据时使用-默认为id；必填
		//pkName:'id',
		// 默认删除按钮单击前执行return ture:继续； false；可选
		/*
		'beforeRemoveRowsFn':function(rows, gridObject){
			alert(rows.length+' '+gridObject)
			return true;
		},
		*/
		// 自己指定服务类，不指定默认为ICommonPlugService接口的实现类的名称，即：commonPlugService；可选
		//'serviceInstance':'commonPlugService',
		// 自己指定服务类时，还要指定执行的方法， 不指定默认为getCustomDatagrid；可选
		//'serviceMethod':'getCustomDatagrid',
		// 表格加载前执行，做一些校验工作；可选
		//beforeSendFn:function(){},
		// 表格加载后执行，一般做些和表格相关的工作；可选
		//afterSuccessFn:function(data, gridObject){},
		// 自定查询条件
		queryColumn:[
			{field:'name',          title:'对象名称',     oper:'like', request:true},
			{field:'parentName',    title:'上级单位名称'},
			{field:'departmentName',title:'所属审计单位名称', type:'custom', target:$('#myTargetTest2')[0]},
			{field:'financialDirector',title:'财务负责人',   type:'custom', target:$('#myTargetTest')[0]},
			{field:'director',      title:'负责人',         type:'custom', target:$('#myTargetTest3')[0]},
			{field:'audtask',       title:'审计事项级联复选',       type:'custom', target:$('#myTargetTest4')[0]},
			{field:'audtask2',       title:'审计事项级联打开',       type:'custom', target:$('#myTargetTest5')[0]},
			{field:'createDate',    title:'创建时间', type:'date'},
			{field:'officeAddress', title:'办公地址', oper:'like'},
			{field:'postCode',      title:'邮政编码',show:false}
		],
		myToolbar:['export','reload'],
		// 表格控件dataGrid配置对象; 必填
		gridJson:{
			queryParams:{'query_eq_departmentId':1, 'sort':'cityName'},
			// datagrid自带的事件
			onClickRow:function(index){
				//alert('点击了第'+(index+1)+'行');
			},
			// 自定义按钮，初始化时会和插件自带的按钮合并在一起
			toolbar:['query','-', {   
					text:'添加',
					iconCls:'icon-add',
					handler:function(a){
						alert(a)
					}
				},'-','delete','-',{   
					text:'修改',
					iconCls:'icon-edit2',
					handler:function(a){
						alert(a)
					}
				},'-'    
			],
			title:'审计对象详细信息',
			columns:[[ 
				{field:'id'  ,          title:'选择',   width:'50px', checkbox:true, align:'center', show:'false'},      
				{field:'name',          title:'对象名称',         width:'150px',align:'left', sortable:true, oper:'like'},
				{field:'parentName',    title:'上级单位名称',     width:'150px',align:'left', sortable:true},
				{field:'departmentName',title:'所属审计单位名称', width:'150px',align:'left', sortable:true},
				{field:'financialDirector',title:'财务负责人',    width:'100px',align:'left', sortable:true},
				{field:'director',      title:'负责人',           width:'100px',align:'left', sortable:true},
				{field:'createDate',    title:'创建时间',         width:'100px',align:'left', sortable:true, type:'date',                      
					 formatter:function(value,rowData,rowIndex){
						return value && value.length > 10 ? value.replace('T',' ').substr(0,10) :value;}}
			]]}
	});
	
	

	
	$('#importExcelTest').dialog({
		closed:true,
		modal:true,
		width:600,
		//height:200,
		toolbar:[{
			 text:"下载导入模板",
			 iconCls:'icon-go',
			 handler:function(p){
				 $('#importToDb').submit();
			 }
		 },'-',{
			 text:"导入Excel到数据库",
			 iconCls:'icon-folderGo',
			 handler:function(p){
				 $('#importToDb').submit();
				 /*
				 //jQuery('#tmpIframe').load(uploadCallback);
				 window.setTimeout(function(){
					//uploadCallback("timeout");
				 }, 500);    
				 */
			 }
		 },'-',{
			 text:"清空",
			 iconCls:'icon-reload',
			 handler:function(){
				 document.all.fileUpload_test1.outerHTML = document.all.fileUpload_test1.outerHTML;
				 $('#uploadfilepath').html("");
			 }
		 },'-',{
			 text:'关闭',
			 iconCls:'icon-folderExit',
			 handler:function(){
				 $('#importExcelTest').dialog('close');
				 document.all.fileUpload_test1.outerHTML = document.all.fileUpload_test1.outerHTML;
				 $('#uploadfilepath').html("");
			 }
		 },'-']
	});

});
function setUplodFileInfo(value){
	var path = "文件路径："+value;
	$('#uploadfilepath').html(path);
};
// end;
		
		
		
function uploadHttpData( r, type ) {
	var data = !type;
	data = type == "xml" || data ? r.responseXML : r.responseText;
	// If the type is "script", eval it in global context
	if ( type == "script" )
		jQuery.globalEval( data );
	// Get the JavaScript object, if JSON is used.
	if ( type == "json" )
		eval( "data = " + data );
	// evaluate scripts within html
	if ( type == "html" )
		jQuery("<div>").html(data).evalScripts();

	return data;
}		
		
var uploadCallback = function(isTimeout){
	var xml = {};
    var io = document.getElementById("tmpIframe");
    try {	//alert(io +' '+io.contentWindow+' '+io.contentDocument)			
        if(io.contentWindow){
             xml.responseText = io.contentWindow.document.body ? io.contentWindow.document.body.innerHTML:null;
             xml.responseXML  = io.contentWindow.document.XMLDocument ? io.contentWindow.document.XMLDocument:io.contentWindow.document;
             //alert(io.contentWindow.document.XMLDocument+','+io.contentWindow.document)
             //alert('responseText='+xml.responseText+'\nresponseXML='+xml.responseXML)
             //alert(io.contentWindow.document.body.innerHTML);
             alert(xml.responseXML.msg)
        }else if(io.contentDocument){
             xml.responseText = io.contentDocument.document.body?io.contentDocument.document.body.innerHTML:null;
             xml.responseXML = io.contentDocument.document.XMLDocument?io.contentDocument.document.XMLDocument:io.contentDocument.document;
        }						
    }catch(e){
        //alert("exception="+e.message);
        jQuery.handleError(s, xml, null, e);
    }
    //alert("xml="+xml);
    //alert(jQuery.uploadHttpData)
   
    if ( xml || isTimeout == "timeout"){				
        requestDone = true;
        var status;
        try{
            status = isTimeout != "timeout" ? "success" : "error";
            //alert( "status="+status+","+jQuery.uploadHttpData( xml, " text/xml" ))
            // Make sure that the request was successful or notmodified
            if( status != "error" ){
                // process the data (runs the xml through httpData regardless of callback)
                var data = jQuery.uploadHttpData( xml, s.dataType );    
                // If a local callback was specified, fire it and pass it the data
                if ( s.success )
                    s.success( data, status );

                // Fire the global callback
                if( s.global )
                    jQuery.event.trigger( "ajaxSuccess", [xml, s] );
            } else
                jQuery.handleError(s, xml, status);
        } catch(e){alert(e.message);
            status = "error";
            jQuery.handleError(s, xml, status, e);
        }

        // The request was completed
        if( s.global )
            jQuery.event.trigger( "ajaxComplete", [xml, s] );

        // Handle the global AJAX counter
        if ( s.global && ! --jQuery.active )
            jQuery.event.trigger( "ajaxStop" );

        // Process result
        if ( s.complete )
            s.complete(xml, status);

        jQuery(io).unbind();
        xml = null;
    }
}

$(function(){
	var isView = false;
	var tabTitle = isView ? "查看" : "编辑";
	var gridTableId = "treeTable";
	
	var addBtn = {
	         text:isView ? "矩阵查看" :'矩阵维护',
	         iconCls:'icon-add',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/mainProcess/showMainProcessList.action?view=${view}";
	         }
	};
	var downloadBtn = {   
	         text:'导出',
	         iconCls:'icon-download',
	         handler:function(){
	        	 
	         }
	     };
	var importBtn = {   
	         text:'导入',
	         iconCls:'icon-upload',
	         handler:function(){
	        	 
	         }
	     };
	
	var reloadBtn = {   
	         text:'刷新',
	         iconCls:'icon-reload',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/mainProcess/showTotalProcess.action?view=${view}";
	         }
	     };
	var cusToolbar = isView ? [addBtn,"-",reloadBtn,"-"] : [ addBtn, "-", importBtn, "-",reloadBtn,"-"];
    var g1 = new createQDatagrid({
		//表格树
		treeGrid:true,
		//查询关联表
		associate:true,
		//表格树时，记录业务对象中表示父节点Id的属性
		parentIdCol:'parentCode',
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MainProcess',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'nodeId',
        order :'asc',
        sort  :'nodeCode',
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:['export'],
	    pageSize:1000,
        gridJson:{
			idField:'nodeCode',
			treeField:'nodeName',
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
        	striped:false,
        	lines:true,
    		border:0,
    		toolbar:cusToolbar,
    		pagination:false,
            onClickCell:function(field,row){
                if(field == 'nodeName' && !row['subLevelCode']){
					var ctrlPointEditUrl = "${contextPath}/intctet/mainProcess/editControlPoint.action?view=true&cpId="+row['nodeId'];
   					aud$openNewTab("控制点" + tabTitle, ctrlPointEditUrl);
                }
            },	
    		columns:[[
    			{field:'nodeCode', width:'40px',align:'center', halign:'center', title:'选择',
	   				formatter:function(value,row,index){
	   					if(true){//是否复选框选择   						
		   					if(!row['subLevelCode']){
		   						return "<div class='datagrid-cell-check'><input type='checkbox' name='mtlIds' value='"+value+"'/></div>";
		   					}
	   					}else{
	   						return value;
	   					}
	   				}
    			},
                {field:'nodeName', title:'流程', width:'35%',align:'left', halign:'center', sortable:true,
	   				formatter:function(value,row,index){
	   					var rtVal = value;
	   					if(!row['subLevelCode']){
	   				    	rtVal = ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
	   					}
	   					return rtVal;
	   				}
                },
				{field:'ctrlImportName', title:"控制重要程度", width:'100px', align:'center', halign:'center'},
				{field:'indtSectorName', title:"适用板块", width:'100px', align:'center', halign:'center'},
				{field:'applyLevelName', title:"适用层级", width:'100px', align:'center', halign:'center'},
				{field:'manuIndex',      title:"底稿索引", width:'25%', align:'center', halign:'center'}
          ]]
        }
    });
});

</script>
</head>
<body>
	<div id="container" class='easyui-layout' fit='true' border='0'>	
		<div id='content' region="west" border='0' split="true" style='overflow:hidden;width:280px;' title=''>
			<div id='auditObjectTreeId'></div>		
	    </div>
	    <div region="center" border='0'>
	    	 <div id="qtab" class="easyui-tabs"  fit="true" border='0'>  
	    	 	<div title="组织机构" id='tab1'>  	    	 	
	    			<table id='orgTable'></table>
	    		</div>
	    		<div title='审计对象' id='tab2'>
	    			<table id='auditTable'></table>
	    		</div>
		    		<div title='表格树' id='tab3'>
	    			<table id='treeTable'></table>
	    		</div>
	    	 </div>
	    </div>
    </div>
    
    
    <!-- 使用s:buttonText2时，控件会每次点击时加载一次。如果直接使用input只有第一次时加载，之后使用缓存 -->
    
    
    <!-- 
                       组织机构树：
    	使用V6的通用树形显示，树节点已经加入角色中数据授权；
    	url已经不用，添加		 param:{
							  	'rootParentId':'0',
			                    'beanName':'UOrganizationTree',
			                    'treeId'  :'fid',
			                    'treeText':'fname',
			                    'treeParentId':'fpid',
			                    'treeOrder':'fcode'
			                 }
		确定树形对象的一些信息既可以构造树形；
     -->
    <div id='myTargetTest'>
		<input type="text"   name="query_like_financialDirector"   />
	    <input type="hidden"  /><img  style="cursor:hand;border:0"
	        src="/ais/resources/images/s_search.gif" 
	    	onclick="showSysTree(this,{
                                 title:'请选择财务负责人',
                                 type:'treeAndUser',
                                 defaultDeptId:'${user.fdepid}',
                                 defaultUserId:'${user.floginname}',
                                 // 是否显示复选框
                                 checkbox:true,
							  param:{
							  	'rootParentId':'0',
			                    'beanName':'UOrganizationTree',
			                    'treeId'  :'fid',
			                    'treeText':'fname',
			                    'treeParentId':'fpid',
			                    'treeOrder':'fcode'
			                 }                                  
					})"></img>
    
    </div>
    

    <div id='myTargetTest2'>
    	<input type="text"   name="query_like_departmentName"   />
    	<!--  v5.86写法
		<input type="hidden"  /><img  style="cursor:hand;border:0"
			src="/ais/resources/images/s_search.gif"
			onclick="showSysTree(this,{ 
			  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
			  title:'请选择2'
			})"></img>
		-->	
           <!-- 
                                 // true:只能选择叶子节点， 默认为false，都可以选择
                                 //onlyLeafClick:true,
                                 // 是否显示复选框
                                 checkbox:true,
                                 // 选择本级和本上级
                                 cascadePrior:true,
                                 // 选择本级和本下级
                                 cascadeJunior:true,
           
           -->
		<input type="hidden"  /><img  style="cursor:hand;border:0"
			src="/ais/resources/images/s_search.gif"
			onclick="showSysTree(this,{
                                 title:'所属审计单位名称',
                                 defaultDeptId:'${user.fdepid}',
                                 defaultUserId:'${user.floginname}',
                                 // checkbox =false, cascadePrior,cascadeJunior自动为false
                                 checkbox:true,
                                 // true:只能选择叶子节点， 默认为false，都可以选择
                                 onlyLeafClick:true,
                                 // 选择本级和本上级, 默认为false
                                 cascadePrior:false,
                                 // 选择本级和本下级，默认为false
                                 cascadeJunior:false,
                                 //展开当前节点下的所有节点（为了性能默认展开节点不超过4层）, 默认为false
                                 cascadeExpand:true,
							  param:{
							     // rootId, rootParentId任选其一
							  	'rootParentId':'0',
			                    'beanName':'UOrganizationTree',
			                    'treeId'  :'fid',
			                    'treeText':'fname',
			                    'treeParentId':'fpid',
			                    'treeOrder':'fcode'
			                 }                                  
					})"></img>
		
			
    </div>
    
  	<!-- 
                      组织机构树：
    	V5.86使用的组织机构树，不同树对应不同的url，通用性比较差，而且没有考虑数据授权
     -->
    <div id='myTargetTest3'>
		<input type="text"   name="query_like_director"  />
	    <input type="hidden"  /><img  style="cursor:hand;border:0"
	        src="/ais/resources/images/s_search.gif" 
	    	onclick="showSysTree(this,{url:'/ais/systemnew/orgListByAsyn.action?org=local',
                                 title:'请选择3',
                                 type:'treeAndUser',
                                 defaultDeptId:'${user.fdepid}',
                                 defaultUserId:'${user.floginname}'
							})"></img>
			
    </div>
    
    
    <div id='myTargetTest4'>
		<input type="text"   name="audTask"  />
	    <input type="hidden"  /><img  style="cursor:hand;border:0"
	        src="/ais/resources/images/s_search.gif" 
	    	onclick="showSysTree(this,{
                                 title:'审计事项级联复选',
                                 checkbox:true,
                                 // true:只能选择叶子节点， 默认为false，都可以选择
                                 onlyLeafClick:false,
                                 // 选择本级和本上级, 默认为false
                                 cascadePrior:true,
                                 // 选择本级和本下级，默认为false
                                 cascadeJunior:true,
                                 //展开当前节点下的所有节点（为了性能默认展开节点不超过4层）, 默认为false
                                 cascadeExpand:false,
							  param:{
                                   // 叶子节点判断条件, 此条件可以加快树的加载速度
                                   'leafCondition':'template_type=2',
							  	'rootParentId':'-1',//还可以使用rootId
							  	'whereHql':' 1=1 project_id=\'085EA642-AC08-21C9-A8E4-7D7C59A179D6\' ',
                                   // application-xxx.xml中对应的bean, 用户反射注入属性值
			                    'beanName':'AudTaskTree',
			                    'treeId'  :'taskTemplateId',
			                    'treeText':'taskName',
			                    'treeParentId':'taskPid',
			                    'treeOrder':'taskCode'
			                  },
                                 defaultDeptId:'${user.fdepid}',
                                 defaultUserId:'${user.floginname}'
							})"></img>
			
    </div>
    
    <div id='myTargetTest5'>
		<input type="text"   name="audTask"  />
	    <input type="hidden"  /><img  style="cursor:hand;border:0"
	        src="/ais/resources/images/s_search.gif" 
	    	onclick="showSysTree(this,{
                                 title:'审计事项级联打开', 
                                 // checkbox =false, cascadePrior,cascadeJunior自动为false
                                 checkbox:false,
                                 // true:只能选择叶子节点， 默认为false，都可以选择
                                 onlyLeafClick:false,
                                 // 选择本级和本上级, 默认为false
                                 cascadePrior:true,
                                 // 选择本级和本下级，默认为false
                                 cascadeJunior:true,
                                 //展开当前节点下的所有节点（为了性能默认展开节点不超过4层）, 默认为false
                                 cascadeExpand:true,
							  param:{
							  	'rootParentId':'-1',
							  	'whereHql':' project_id=\'085EA642-AC08-21C9-A8E4-7D7C59A179D6\' ',
                                   // application-xxx.xml中对应的bean, 用户反射注入属性值
			                    'beanName':'AudTaskTree',
			                    'treeId'  :'taskTemplateId',
			                    'treeText':'taskName',
			                    'treeParentId':'taskPid',
			                    'treeOrder':'taskCode',
                                   // 在node的atrributes中添加想要得到业务对象
                                   'treeAtrributes':'template_type,taskName,taskPid,project_id,taskOrder',
                                   // 叶子节点判断条件, 此条件可以加快树的加载速度
                                   'leafCondition':'template_type=2'
			                  },
                                 defaultDeptId:'${user.fdepid}',
                                 defaultUserId:'${user.floginname}',
                                 onTreeClick:function(node){
                                     alert(node.attributes)
                                 }
							})"></img>
			
    </div>
    
    
    
    
    
    <!-- 自定义树形的根节点
    
    
  			<tr>
			<td class="EditHead">
				<font color="red"></font>&nbsp;&nbsp;执行人														
			</td>
			<td class="editTd" colspan="3">
				<input id='audTask_taskAssignName' name='audTask.taskAssignName' value="${audTask.taskAssignName}" type='text' class='noborder'/>
				<input id='audTask_taskAssign' 	   name='audTask.taskAssign'     value="${audTask.taskAssign}"  type='hidden'/>
				<img  style="cursor:pointer;border:0;vertical-align:middle;"
			        src="/ais/resources/images/s_search.gif" 
			    	onclick="showSysTree(this,{
	                                  title:'请选择执行人',
	                                  treeTabTitle1:'小组成员',
							          queryBox:false,
							          checkbox:true,
							          noMsg:true,
							          allleaf:true,
									  param:{
									  	'rootParentId':'${project_id}',
									  	'whereHql':'proInfo.formId=\'${project_id}\'',
					                    'beanName':'ProMember',
					                    'treeId'  :'userId',
					                    'treeText':'userName',
					                    'treeParentId':'proInfo.formId',
					                    'treeOrder':'role',
		                                'customRoot':'项目小组成员'
					                  }
									})"></img>					 						
			</td>
		</tr> 
   		<tr>
			<td class="EditHead" style="width:15%;"><font color=red>*</font>源数据表</td>
			<td class="editTd" style='min-width:150px;'>
				<input type='text' title='源数据表中文名' id='tlInterTp_tableNameDesc' readonly='readonly' style='width:80%;'
				name='tlInterTp.tableNameDesc'  class="noborder required editElement clear">
				<input type='hidden' title='源数据表英文名' id='tlInterTp_tableName' name='tlInterTp.tableName'  
				class="noborder required editElement clear">
                      <a class="easyui-linkbutton editElement"  iconCls="icon-search" id='tableNameSelectBtn'></a>
                      <div id='view_tableNameDesc' class="noborder viewElement clear"  style='width:100%;'></div>
			</td>
		</tr>
   
   
   	$('#tableNameSelectBtn').bind('click', function(){		
	    var treeTarget = $('#tableNameSelectBtn')[0];
	    var winJson = showSysTree(treeTarget,{
	        title:'请选择-源数据表',
	        treeTabTitle1:'源数据表',
	        queryBox:false, 
	        noMsg:true,
	        onlyLeafClick:true,
	        param:{
	          'rootParentId':'notnull',
	          'beanName':'TlInterTable',
	          'treeId'  :'tableName',
	          'treeText':'tableNameDesc',
	          'treeParentId':'tableId',
	          'treeOrder':'createTime',
	          'customRoot':'两级交互源数据表',
	          'allleaf':true,
	          'treeAtrributes':'targetTableName,targetTableNameDesc'
	        },                             
	 	    //onTreeClick:aud$genTemplateSql,
	 	    onAfterSure:function(dms, mcs){
	 		   var jqTree = winJson.win.param.jqtree;
	 		   var node = $(jqTree).tree('getSelected');
	 		   node ? aud$genTemplateSql(node) : null;
	 	    }
		})
	});
   
     -->

    
	<!-- 通用组件： 导入、校验、解析导入的Excel => boList => saveOrUpdate to dataBase -->
	<div id='importExcelTest' style='height:200px;' title="通用Excel解析">
		<div id='dia_content' style='border-bottom:1px solid #cccccc;overflow:auto;padding:10px;height:130px; '>
			<!-- 上传下载时模拟ajax的不刷新页面，提供显示返回信息 -->
			<iframe id="tmpIframe" name="tmpIframe" style='display:none'></iframe>	     		
			<form target='tmpIframe' id='importToDb' name='importToDb' action='/ais/commonPlug/importExcelToDB.action' method="POST"  enctype="multipart/form-data">
				<!--   必填，用来确定填充的业务对象（必须自application*.xml配置文件以及配置的）  -->
				<input type='hidden' name='beanName' value='ImportExcelTest'/>
				<!--   可选， 有则用UUID填充主键   -->
				<input type='hidden' name='boPk'     value='id'/>
				<!--   可选，Excel属性行的下标(从0开始），如果不填则默认为0  -->
				<input type='hidden' name='headColumIndex'     value='1'/>
				<!--   可选，Excel数据行的下标(从0开始），如果不填则默认为1  -->
				<input type='hidden' name='rowDataStartIndex'  value='3'/>	      			
				<div style='text-align:left;padding:2px;lheight:20px;'>
					<!--   可选，对导入的Excel进行校验时，错误信息的展现形式， true：导出加重格式excel； false：alert提示    -->
					出错时是否导出错误的Excel：<input type='checkbox' name='exportEorrExcel'/>
				</div>
				<div style='text-align:left;padding:2px;height:20px;'>	
					<!--   必填， 提供导入文件   -->
					请选择要上传的文件(支持xlsx格式的Excel)：<input type='file' size=35  id='fileUpload_test1' name='fileUpload_test1' onchange='setUplodFileInfo(this.value)'/>		
				</div>  				
			</form>
			<div style='font-weight:bold;color:blue;text-align:left;padding:5px;height:30px; line-height:20px;' id='uploadfilepath'></div>
		</div>
	</div> 
	<!-- end -->
   
</body>
</html>