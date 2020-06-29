<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>实施方案详细信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<s:head theme="ajax" />
	</head>

	<body class="easyui-layout" border="0">
		<div region="center"  border="0">
			<div id="tt" class="easyui-tabs" fit="true"  border="0">
			 <div id='main' title='总体方案' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("main")){%> selected="true"<%} %> style="overflow:hidden;">
				<iframe id="basefrm1"
					src="${contextPath}/operate/task/showContentRootView.action?interCtrl=${interCtrl}&project_id=<%=request.getParameter("project_id")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>"
					frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
 
            <s:if test="'1' == '${type}'">
			   <div id='item' title='审计事项' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %> style="overflow:hidden;" >
				<iframe id="basefrm2"
					src="${contextPath}/operate/task/showContentTypeView.action?type=<%=request.getParameter("type")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>&fromAdjust=<%=request.getParameter("fromAdjust")%>"
					frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			    </div>
			</s:if>
		     <s:if test="'2' == '${type}'">
				<div  id='item' title='审计事项' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %> style="overflow:hidden;" >
				<iframe id="basefrm2"
					src="${contextPath}/operate/task/showContentLeafView.action?type=<%=request.getParameter("type")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>&fromAdjust=<%=request.getParameter("fromAdjust")%>"
					frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			    </div>
		     </s:if>
		   </div>
		</div>
			
			
		<script language="javascript">
		 var taskviewGrid = null;
	        $(function(){
	        	$('#tt').tabs('select','审计事项导入');
	        	var gridObj = $('#importTaskViewGrid')[0];
				// 审计事项表格
				taskviewGrid = new createQDatagrid({
					// 表格dom对象，必填
				    gridObject:gridObj,
					// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
					boName:'AuditMatter',
					// 对象主键,删除数据时使用-默认为“id”；必填
					pkName:'id',
	                // 设置每页显示的记录数，默认为10; 非必填
	                pageSize:20,
				    // 表格控件dataGrid配置参数; 必填
				    gridJson:{
				    	queryParams:{
	                        'query_in_id':"'-1'",
	                        'order':'name'
	                    },
	   					// 自定义按钮，初始化时会和插件自带的按钮合并在一起
	   					toolbar:[{   
	   							text:'关闭',
	   						    iconCls:'icon-cancel',
	   						    handler:closeImportTaskView
	   						},'-',{   
	   							text:'导入审计事项',
	   						    iconCls:'icon-go',
	   						    handler:function(){
	   						    	if( window.top.frames['f_left']){
	   						    		window.top.frames['f_left'].q$saveNodes
	   						    	}
	   						    	
	   						    	
	   						    }
	   						},'-'],
						columns:[[  
							{field:'id',    title:"事项编号",width:'120px',align:'left',sortable:true, oper:'like'},
							{field:'name',  title:'事项名称',width:'250px',align:'left', oper:'like'},
							{field:'riskPoint',title:'审计程序和方法',width:'200px',align:'left', oper:'like',
	                            formatter:function(value,rowData,rowIndex){return textFormatter(value,rowData,rowIndex);}
	                        },
	                        {field:'law',   title:'相关法律法规和监管规定',width:'200px',align:'left', oper:'like',
	                            formatter:function(value,rowData,rowIndex){return textFormatter(value,rowData,rowIndex);}
	                        },
	                        {field:'method',title:'审计查证要点',width:'200px',align:'left', oper:'like',
	                            formatter:function(value,rowData,rowIndex){ return textFormatter(value,rowData,rowIndex); }}
	                   ]]
				    }
				});
	            function textFormatter(value,rowData,rowIndex){
	                var v2 = value && value.length > 200 ? value.substr(0,200)+'...' : (value ? value : "");
	                return  value ? "<textarea style='border:0px;height:30px;'readonly title='"+v2+"'>"+value+"</textarea>" : "";
	            }
				taskviewGrid.batchSetBtn([{'index':3, 'display':false},{'index':5, 'display':true}]);
	        });
	        
	        // 显示预览tab
	        function showImportTaskView(ids){
	            try{           	
	            	var title = "审计事项导入预览";
	            	if(!$('#tt').tabs('exists',title)){
		            	$('#tt').tabs('add',{
		            		title: title,
		            		selected: true,
		            		content:$('#importTaskViewGrid').html()
		            	});
	            	}else{
	            		$('#tt').tabs('select',title);
	            	}
	            	//alert('ids:\n'+ids);
	            	var gridQueryParamJson = {'query_in_id':ids};
	                // 更新基础查询参数basicGridParams，以后不管分页、搜索等，查询结果集都会限定在ids的范围内
	            	taskviewGrid.setBasicGridParams(gridQueryParamJson);
					QUtil.loadGrid({
				        // 传入的查询参数； 可选
						param:gridQueryParamJson,
				        // 表格对象
				        gridObject:$('#importTaskViewGrid')
					});
	            }catch(e){
	                alert('showImportTaskView:'+e.message);
	            }
	        }
	        
	        function closeImportTaskView(){
	            try{           	
	            	var title = "审计事项导入预览";
	            	$('#tt').tabs('exists',title) ? $('#tt').tabs('close',title) : null;
	            }catch(e){
	                alert('closeImportTaskView:'+e.message);
	            }
	        }

		function doAutoHeight1() {
		  if(document.body.clientHeight>165)
	      document.all.basefrm1.style.height = document.body.clientHeight-60;
	   }

		function doAutoHeight2() {
		  if(document.body.clientHeight>165)
	      document.all.basefrm2.style.height = document.body.clientHeight-60;
	    }
	  <s:if test="'enabled' == '${shenjichengxu}'">
		function doAutoHeight3() {
		  if(document.body.clientHeight>165)
	      document.all.basefrm3.style.height = document.body.clientHeight-60;
	    }
	 </s:if>

</script>
	</body>
</html>
