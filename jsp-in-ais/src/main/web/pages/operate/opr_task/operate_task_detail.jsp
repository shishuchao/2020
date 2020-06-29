	<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page import="ais.framework.util.MyProperty"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title></title>
		<script type="text/javascript">	
 
Ext.onReady(function(){
//toolbar
    var toolbar=new Usp.ToolBar();
	toolbar.addBtn({btnType:'-'});
	toolbar.addBtn({btnType:'EDIT',btnStyle:'visible',handler:edit});
	toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:view});
	toolbar.addBtn({btnType:'DEL',btnStyle:'visible',handler:del});
	
    var toolbarDoubt=new Usp.ToolBar();
	toolbarDoubt.addBtn({btnType:'-'});
	toolbarDoubt.addBtn({btnType:'ADD',btnStyle:'visible',handler:addDoubt});
	toolbarDoubt.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editDoubt});
	toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubt});
	toolbarDoubt.addBtn({btnType:'DEL',btnStyle:'visible',handler:delDoubt});	
	
	var toolbarFound=new Usp.ToolBar();
	toolbarFound.addBtn({btnType:'-'});
	toolbarFound.addBtn({btnType:'ADD',btnStyle:'visible',handler:addFound});
	toolbarFound.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editFound});
	toolbarFound.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewFound});
	toolbarFound.addBtn({btnType:'DEL',btnStyle:'visible',handler:delFound});
	
	var toolbarItem = new Usp.ToolBar();
	<%String right=request.getParameter("isView");%>
    
    <% if("true".equals(right)){%>
         toolbarItem.addBtn({text: '查看',handler:viewItem});
     <%}else{%>
        toolbarItem.addBtn({text: '查看',handler:viewItem});
        toolbarItem.addSeparator(); 
	    toolbarItem.addBtn({text: '保存',handler:digao});
     <%}%>

 
     var btns=[{text:'保存',
        		handler:function(){
        		formSubmit(form.getFormPanel(),'${pageContext.request.contextPath}/common/data/dataDetailSave.action',0,back);
        		}
        	}, 
        	{text:'保存并新建',
        		handler:function(){
        		formSubmit(form.getFormPanel(),'${pageContext.request.contextPath}/common/data/dataDetailSave.action',1,add);
        		}
        	},
        	{text:'保存并查看',
        		handler:function(){
        		formSubmit(form.getFormPanel(),'${pageContext.request.contextPath}/common/data/dataDetailSave.action',2,view);
        		}
        	},
        	{   
                    text : "返回",   
                    handler : function() { 
                    back();
                    }
            }];
//grid

    
 
  
		 var dataModelItem={url:'${pageContext.request.contextPath}/operate/taskExt/taskListJson.action',
             cells:['taskTemplateId','taskMethod','taskPid','taskId','taskName','taskCode','taskTarget','taskProgress','taskAssign','taskAssignBak','taskAssignName','project_id','id','cat_name','cat_code','taskMust','taskMustName','manu','doubt']
		};
		
		var viewModelItem=[{header:'taskTemplateId',dataIndex:'taskTemplateId',hidden:true,sortable:true},
		{header:'taskPid',dataIndex:'taskPid',hidden:true,sortable:true},
		 {header:'<div style="text-align:center">程序名称</div>',dataIndex:'taskName',width:130},
		 {header:'程序编码',dataIndex:'taskCode',sortable:true,width:60,align:'center'},
         {header:'审计程序内容',dataIndex:'taskMethod',width:60,align:'center'},
         {header:'是否必做',dataIndex:'taskMustName',sortable:true,width:70,align:'center'},
         {header:'执行人',dataIndex:'taskAssignName',sortable:true,width:60,align:'center'},
         {header:'是否执行',dataIndex:'taskProgress',renderer:setdo, sortable:true,width:150,align:'center'},
         {header:'',dataIndex:'taskAssign',renderer:setcz2 ,sortable:true,width:30,align:'center'},
         {header:'关联',dataIndex:'taskAssignName',renderer:setcz,width:130,align:'center'}
         
        
         ];	
         
         
         var gridItem =new Usp.Grid({
          gridConfig:{title:'审计程序',collapsible:true,autoHeight:false,height:window.screen.height-310,collapsed:false,
           tbar:toolbarItem.getToolPanel()},
		    isSelect:'1',
			isRowNo:'0',
			dataModel:dataModelItem,
			viewModel:viewModelItem,
			limit:${page.limit20}
		}); 
        gridItem.getGridPanel().on('beforeexpand',function( p,animate ){
		//gridDigao.getGridPanel().collapse(true);
	// window.scrollTo(0,1000); 
		
		});
		<%String s=request.getParameter("taskPid");%>
        	      
       <% if("-1".equals(s)||s==null){%>
           gridItem.getGridPanel().loadData({'audTask.taskPid':'-1','audTask.project_id':'<%=request.getParameter("project_id")%>'}); 
        <%}else{%>
            gridItem.getGridPanel().loadData({'audTask.taskPid':'<%=request.getParameter("taskId")%>','audTask.project_id':'<%=request.getParameter("project_id")%>'}); 
        <%}%>
        
        
  
       
	//panel
     var singlePanel=new Usp.SinglePanel();
     singlePanel.main.add(gridItem.getGridPanel());
    
    singlePanel.main.render('common-data-datadetaillist');
  
   //handler
    function add(){
      addDigaoFrame();
    }	
   function edit(){
   if(isSingle(gridDigao.getGridPanel())){
   var ms_author=gridDigao.getFieldValue('ms_author');
        var ms_status=gridDigao.getFieldValue('ms_status');
            //删除
          if('${user.floginname}'==ms_author){
		                  }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
		                  
      if('010'==ms_status){
		                    //alert("123");
		                  }else{
		                    alert("只有底稿草稿状态可以修改！");
		                    return false;
		                  }
   var ms_id=gridDigao.getFieldValue('formId');

     editDigaoFrame(ms_id);
    }
   } 
   function addDoubt(){
   
      addDoubtFrame();
      
    }	
    function editDoubt(){
    if(isSingle(gridDoubt.getGridPanel())){
     var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      var doubt_status=gridDoubt.getFieldValue('doubt_status');
     if('${user.floginname}'==doubt_author_code){
		                    //alert("123");
		                  }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
	 if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能修改！");
		                    return false;
		                  }   	                  
    if(isSingle(gridDoubt.getGridPanel())){
     var doubt_id=gridDoubt.getFieldValue('doubt_id');
     editDoubtFrame(doubt_id,'YD');
         }
         }
         }
      function viewDoubt(){
       if(isSingle(gridDoubt.getGridPanel())){
       var doubt_id=gridDoubt.getFieldValue('doubt_id');
      window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
      }
      }
     function view(){
       if(isSingle(gridDigao.getGridPanel())){
       var formId=gridDigao.getFieldValue('formId');
       var project_id=gridDigao.getFieldValue('project_id'); 
      window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
      }
      }
     function del(){
             if(isSingle(gridDigao.getGridPanel())){
        var ms_author=gridDigao.getFieldValue('ms_author');
        var ms_status=gridDigao.getFieldValue('ms_status');
            //删除
          if('${user.floginname}'==ms_author){
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
      if('010'==ms_status){
		                    //alert("123");
		                  }else{
		                    alert("只有底稿草稿状态可以删除！");
		                    return false;
		                  }
		  
       var id=gridDigao.getFieldValue('formId');
       Usp.doGridDel({
       				component:gridDigao,
       				url:'${pageContext.request.contextPath}/operate/manuExt/manuDel.action',
       				params:{'audManuscript.formId':id}
       			});
      }
      <%String q=request.getParameter("taskPid");%>
        	      
       <% if("-1".equals(q)||q==null){%>
 
           gridFound.getGridPanel().loadData({'audDoubt.doubt_type':'FX','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1'});
        <%}else{%>
            gridFound.getGridPanel().loadData({'audDoubt.doubt_type':'FX','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
        <%}%>
        
      }

      function viewItem(){
         if(isSingle(gridItem.getGridPanel())){
          var taskId=gridItem.getFieldValue('taskId'); 
          var taskTemplateId=gridItem.getFieldValue('taskTemplateId'); 
          var taskPid=gridItem.getFieldValue('taskPid'); 
          var project_id=gridItem.getFieldValue('project_id'); 
          //alert("/operate/task/showContentLeafView.action?taskId="+taskId+"&taskTemplateId="+taskTemplateId+"&taskPid="+taskPid+"&project_id="+project_id);
          window.open("${contextPath}/operate/task/showContentLeafView.action?taskId="+taskId+"&taskTemplateId="+taskTemplateId+"&taskPid="+taskPid+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
         }else{
       	  alert("请选择要查看的审计程序!");
         }
         }
    function delDoubt(){
     if(isSingle(gridDoubt.getGridPanel())){
     var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      var doubt_status=gridDoubt.getFieldValue('doubt_status');
     if('${user.floginname}'==doubt_author_code){
		                    //alert("123");
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		 if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能删除！");
		                    return false;
		                  }                  
     var id=gridDoubt.getFieldValue('id');
       Usp.doGridDel({
       				component:gridDoubt,
       				url:'${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action',
       				params:{'audDoubt.doubt_id':id}
       			});
   
    }
    }
    function addFound(){
       addFoundFrame();
    }	
    function editFound(){
    if(isSingle(gridFound.getGridPanel())){
     var doubt_author_code=gridFound.getFieldValue('doubt_author_code');
     var doubt_status=gridFound.getFieldValue('doubt_status');
     
     if('${user.floginname}'==doubt_author_code){
		                    //alert("123");
		                  }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
    if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能修改！");
		                    return false;
		                  }
     var doubt_id=gridFound.getFieldValue('doubt_id');
     editFoundFrame(doubt_id);
    
      }
   }
      function viewFound(){
      if(isSingle(gridFound.getGridPanel())){
       var doubt_id=gridFound.getFieldValue('doubt_id');
      window.open("${contextPath}/operate/doubt/view.action?type=FX&doubt_id="+doubt_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
      }
      }
      
      function setcz(value, cellmeta, record, rowIndex, columnIndex,store) { 
       var all="0";
       if(record.data["taskAssign"]==""||record.data["taskAssign"]=="null"||record.data["taskAssign"]==null){
          all="1";
	   }
       
       var doubt_author_code=","+record.data["taskAssign"]+",";
       var kk=record.data["taskAssignBak"];
       var doubt_author_code_bak=","+record.data["taskAssignBak"]+",";
        
       var mc=record.data["manu"];
       var dc=record.data["doubt"];
        var test=","+'${user.floginname}'+",";
        var sq="0";
        if(doubt_author_code.indexOf(test)!=-1){
           sq="1";
        }else{
		                     
		}
		if(all=="1"){//没选人 都可以操作
		
		    if(kk!=null&&kk!="null"&&kk!=""){
		     var sq="0";
             if(doubt_author_code_bak.indexOf(test)!=-1){
             sq="1";
             }else{
		                     
		     }
		   
		   }else{
		      sq="1";
		   }
         
		}
        var project_id = record.data["project_id"];
        var taskPid = record.data["taskPid"];
        var taskTemplateId = record.data["taskTemplateId"];
        var str="<a href='javascript:void(0);' onclick='javascript:digao(\""+sq+"\","+"\""+project_id+"\","+"\""+taskTemplateId+"\","+"\""+taskPid+"\")' title='该审计程序已有"+mc+"个底稿'>底稿("+mc+")</a>&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' onclick='javascript:yidian(\""+sq+"\","+"\""+project_id+"\","+"\""+taskTemplateId+"\","+"\""+taskPid+"\")' title='该审计程序已有"+dc+"个疑点'>疑点("+dc+")</a>";
 
        return str; 
      } 
      
        function setcz2(value, cellmeta, record, rowIndex, columnIndex,store) { 
       var doubt_author_code=","+record.data["taskAssign"]+",";
        var str="";
        var test=","+'${user.floginname}'+",";
        var sq="0";
        if(doubt_author_code.indexOf(test)!=-1){
           str="<img src=task/person.gif >";
        }else{
		   str="";                 
		}
        return str; 
      }
      
     
      
       function setdo(value, cellmeta, record, rowIndex, columnIndex,store) { 
       var tt=record.data["taskTemplateId"];
       if(value==null||value=='null'||value==0||value=='0'){
       var str = "<select id ='"+tt+"'  ><option value='0' selected >未执行</option><option value='2'>已执行，无记录</option><option value='1'>已执行，有记录</option></select>"; 
        return str;
       }else if(value==2||value=='2' ){
        var str = "<select id ='"+tt+"' ><option value='0' >未执行</option><option value='2' selected >已执行，无记录</option><option value='1'>已执行，有记录</option></select>"; 
        return str;
       }else {
        var str = "<select id ='"+tt+"' ><option value='0' >未执行</option><option value='2' >已执行，无记录</option><option value='1' selected>已执行，有记录</option></select>"; 
        return str;
       }
         
      } 
      function editv(){
      }
      
       function setdigao(value, cellmeta, record, rowIndex, columnIndex,store) { 
        var name = record.data["cat_name"];
        var code = record.data["cat_code"];
        var str = test(name,code);
        return str;
         
      }
      
      function delFound(){
      if(isSingle(gridFound.getGridPanel())){
        var doubt_author_code=gridFound.getFieldValue('doubt_author_code');
        var doubt_status=gridFound.getFieldValue('doubt_status');
            //删除
          if('${user.floginname}'==doubt_author_code){
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
      if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能删除！");
		                    return false;
		                  }
		  
       var id=gridFound.getFieldValue('doubt_id');
       Usp.doGridDel({
       				component:gridFound,
       				url:'${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action',
       				params:{'audDoubt.doubt_id':id}
       			});
      }
      }
      
      
       function editItem(){
      if(isSingle(gridItem.getGridPanel())){
        var task = gridItem.getFieldValue('taskTemplateId');
         var taskDo=document.getElementById(task).value;
        var doubt_author_code=","+gridItem.getFieldValue('taskAssign')+",";
        var test=","+'${user.floginname}'+",";
        if(doubt_author_code.indexOf(test)!=-1){
        
        }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
       var id=gridItem.getFieldValue('id');
       var taskProgress=gridItem.getFieldValue('taskProgress')
       
       Usp.doPost({
       				component:gridItem,
       				msg:'确认修改吗?',
       				url:'${pageContext.request.contextPath}/operate/taskExt/taskDo.action',
       				params:{'audTask.id':id,'taskDo':taskDo}
       			});
      }
      }
      
      
      
});
 
function digao3(sq,project_id,task_id,taskPid){

 Usp.doTabPanel({
	 height:Ext.getBody().getHeight()-98, 
 id:'common-data-dataframe-tab3',
 pid:'common-data-dataframe-tab',
 title:'审计底稿',
 url:'${pageContext.request.contextPath}/operate/manuExt/manuUi.action',
 params:{project_id:project_id,taskId:task_id,taskPid:taskPid,sq:sq,isView:<%=request.getParameter("isView")%>},
 refresh:true
 });
}

function faxian3(project_id,task_id,taskPid){
//Usp.openTabPanel('common-data-dataframe-tab3','审计底稿','${pageContext.request.contextPath}/operate/manuExt/manuUi.action','common-data-dataframe-tab');
window.open('${pageContext.request.contextPath}/operate/doubtExt/foundUi.action?type=FX&project_id='+project_id+'&taskId='+task_id+'&taskPid='+taskPid,'审计发现',"height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no")
}
function yidian3(sq,project_id,task_id,taskPid){
//Usp.openTabPanel('common-data-dataframe-tab3','审计底稿','${pageContext.request.contextPath}/operate/manuExt/manuUi.action','common-data-dataframe-tab');
//window.open('${pageContext.request.contextPath}/operate/doubtExt/doubtUi.action?type=YD&project_id='+project_id+'&taskId='+task_id+'&taskPid='+taskPid,'审计疑点')
//Usp.openTabPanel('common-data-dataframe-tab4','审计疑点','${pageContext.request.contextPath}/operate/doubtExt/doubtUi.action?sq='+sq+'&type=FX&project_id='+project_id+'&taskId='+task_id+'&taskPid='+taskPid,'common-data-dataframe-tab');
 Usp.doTabPanel({
	 height:Ext.getBody().getHeight()-88,
 id:'common-data-dataframe-tab4',
 pid:'common-data-dataframe-tab',
 title:'审计疑点',
 url:'${pageContext.request.contextPath}/operate/doubtExt/doubtUi.action',
 params:{project_id:project_id,taskId:task_id,taskPid:taskPid,sq:sq,isView:<%=request.getParameter("isView")%>},
 refresh:true
 });

}

	function go(s){
	//var q=s;
	//alert(q);
	window.open('http://<%=MyProperty.getProperties("fap.host")%>:<%=MyProperty.getProperties("fap.port")%>/<%=MyProperty.getProperties("fap.context")%>/instanceAction.do?action=editCell&taskPid=${taskPid}&taskId=${taskTemplateId}&commonProId=${project_id}&templateId='+s,s,'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no');
	}
	function test(name,code){
       if(name!=null){
       }else{
         return "";
       }
        //alert(name);
        //alert(code);
        var nameArray=name.split(',');
        var codeArray=code.split(',');
        var strName='';
        var strCode='';
        var tt='';
        for(var a=0;a<nameArray.length;a++){
          strName=nameArray[a];
          strCode=codeArray[a];
          if(tt!=''){
            tt=tt+'    '+'<a href=# onclick=go(\"';
            tt+=strCode+'\")>'+strName+'</a>';
          }else{
            tt='<a href=# onclick=go(\"'+strCode+'\")>'+strName+'</a>';
          }
         
        }
       var ss="";
        ss=tt+"<br />";
        return ss;
        //setTimeout('Test();',1000);
}
	</script>
	</head>
	<body>
		<div id='common-data-datadetaillist' />
	</body>
</html>