<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title></title>
		<script type="text/javascript">	

function addFrame(){
Usp.doTabLoad({url:'/ais/operate/diary/editDiary.action?project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
				isFrame:true,
				tabId:'operate-index-tab',
                pid:'common-data-dataframe-tab12'});
}

function editFrame(id,q){
 if('${user.floginname}'==q){
		                    
		                  }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
//var obj=document.getElementById("operate-diary-list");
//obj.innerHTML="<iframe src=\"/ais/operate/diary/editDiary.action?type=YD&diary_id="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>\" frameborder=\"0\" width=\"100%\" height=\"540\" SCROLLING=\"YES\"></iframe>";
//window.location.href="/ais/operate/diary/editDiary.action?type=YD&diary_id="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
Usp.doTabLoad({url:'/ais/operate/diary/editDiary.action?project_id=<%=request.getParameter("project_id")%>&type=YD&diary_id='+id,
				isFrame:true,
				tabId:'operate-index-tab',
                pid:'common-data-dataframe-tab12'});
 
}
Ext.onReady(function(){
//tool
var toolbar=new Usp.ToolBar();


 <%String right = request.getParameter("isView");%>
       
       <%if ("true".equals(right)) {%>
           toolbar.addBtn({btnType:'-'});
	       toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:view});
        <%} else {%>

	toolbar.addBtn({btnType:'-'});
	toolbar.addBtn({btnType:'ADD',btnStyle:'visible',handler:add});
	toolbar.addBtn({btnType:'EDIT',btnStyle:'visible',handler:edit});
	toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:view});
	toolbar.addBtn({btnType:'DEL',btnStyle:'visible',handler:del});
	<%}%>
	
//grid
var dataModel={url:'${pageContext.request.contextPath}/operate/diaryExt/diaryQuery.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
                   cells:['diary_id','diary_name','diary_code','diary_author','diary_author_code','diary_date']
					};
var viewModel=[{header:'diary_id',dataIndex:'diary_id',hidden:true,sortable:true},
         {header:'<div style="text-align:center">日记名称</div>',dataIndex:'diary_name',width:100,renderer: formatQtip},
         {header:'日记编码',dataIndex:'diary_code',sortable:true,width:100,align:'center'},
         {header:'提交人',dataIndex:'diary_author',sortable:true,width:100,align:'center'},
         {header:'提交日期',dataIndex:'diary_date',sortable:true,width:100,align:'center',

        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
             if(value!=null){
             
              return value.substring(0,10);
             }else{
                 return null;
             }
              
           } }
         ];	
         
         
         var grid =new Usp.Grid({
					//comId:'common-data-datadetaillist',
        	    gridConfig:{title:'审计日记',collapsible:true,autoHeight:false,height:window.screen.availHeight-200,collapsed:false},
				isSelect:'2',
				isRowNo:'1',
				dataModel:dataModel,
				viewModel:viewModel,
				limit:${page.limit20}
				});
 			
					
	grid.getGridPanel().loadData();

	//panel
     var singlePanel=new Usp.SinglePanel();
     singlePanel.main.add(toolbar.getToolPanel());
    //singlePanel.main.add(grid1.getGridPanel());
    singlePanel.main.add(grid.getGridPanel());
    singlePanel.main.render('operate-diary-list');
   //handler
   
    function formatQtip(data,metadata){ 
    	var title ="";
    	var tip =data; 
    	metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + '双击查看' + '"';  
    	return data;  
   	}
    function add(){
     addFrame();
    }	
    
     grid.getGridPanel().addListener('rowdblclick', rowdblclickFn);  
    function rowdblclickFn(grid, rowindex, e){  //双击事件   
   		grid.getSelectionModel().each(function(rec){    
        var diary_id=rec.get('diary_id');
        window.open("${contextPath}/operate/diary/view.action?diary_id="+diary_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	});  
    }
    function edit(){
    if(isSingle(grid.getGridPanel())){
    var diary_id=grid.getFieldValue('diary_id');
    var diary_author_code=grid.getFieldValue('diary_author_code');
     editFrame(diary_id,diary_author_code);
         }
       }
      function view(){
      if(isSingle(grid.getGridPanel())){
      var diary_id=grid.getFieldValue('diary_id');
      window.open("${contextPath}/operate/diary/view.action?diary_id="+diary_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
       } else{
     	  //alert("请选择要查看的审计日记!");
       } }
       function del(){
       if(isSingle(grid.getGridPanel())){
        var diary_author_code=grid.getFieldValue('diary_author_code');
            //删除
          if('${user.floginname}'==diary_author_code){
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
 
		  
       var id=grid.getFieldValue('diary_id');
       Usp.doGridDel({
       				component:grid,
       				url:'${pageContext.request.contextPath}/operate/diaryExt/diaryDel.action',
       				params:{'audDiary.diary_id':id}
       			});
      }
    }
});
	</script>
	</head>
	<body>
		<div id='operate-diary-list' />
	</body>
</html>