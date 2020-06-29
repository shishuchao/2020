<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<title>修改审计方案</title>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">  	
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript">

// add by qfucee, 2014.3.27
$(function(){
    var isDebug = true;
    var taskTree = $('#taskTreeId');		
    // 自定义 - 组织机构树
    showSysTree(taskTree,{
          container:taskTree,
          queryBox:false,
          noMsg:true,
          param:{
        	  'isOracle':false,
          	'serverCache':false,
              'rootParentId':'-1',
              'whereHql':"project_id='${project_id}'",
              'beanName':'AudTaskTree',
              'treeId'  :'taskTemplateId',
              'treeText':'taskName',
              'treeParentId':'taskPid',
              'treeOrder':'taskOrder',
              'treeAtrributes':'template_type'
          },
          onTreeClick:function(node, treeDom){
             try{
                var parent = $('#taskTreeId').tree('getParent',node.target);
                var id = node.id;
                var type = node.leaf==0 ? "1":"2";
                var taskPid = parent ? parent.id : null;
                var path = "";
                if(!taskPid){
                	window.parent.frames['childBasefrm'].location.href="/ais/operate/task/showContentView.action?selectedTab=main&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>";
            	}else{
            		window.parent.frames['childBasefrm'].location.href="/ais/operate/task/showContentView.action?selectedTab=item&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>&fromAdjust=<%=request.getParameter("fromAdjust")%>";
                 }
             }catch(e){
                  isDebug ? alert("onTreeClick:"+e.message) : null;
             }
          },
          onTreeCheck:function(node, checked){
              var jtree = $('#taskTreeId');
              var curNodeId = $('#taskTreeId').data('myCheckNodeId');
              //alert('curNodeId:'+curNodeId);
              !curNodeId ? ($('#taskTreeId').data('myCheckNodeId', node.id),curNodeId = node.id) : null;
              if(node.id == curNodeId){
                  //alert(node.text+' \n'+node.id +'\n'+ curNodeId)
                  //alert(node.text+' '+checked);
                  // 复选时，打开为展开的节点
                  QUtil.expandOrCollapseAllNodes('taskTreeId', node);
                  window.setTimeout(function(){
                      var childrenNodes = jtree.tree('getChildren', node.target);
                      //alert('childrenNodes:'+childrenNodes)
                      if(childrenNodes && childrenNodes.length > 0){
                          $.each(childrenNodes, function(i, children){
                              //alert(children.text+' '+checked);
                              jtree.tree(checked ? 'check' : 'uncheck', children.target);
                          });
                      }
                      // 清除缓存变量
                      $('#taskTreeId').removeData('myCheckNodeId'); 
                  },550);
              }
          }
    });
   
    /************** 公共方法 ***************/    
    // 重新加载树形
    function reloadTree(id){
        $('#'+id).tree('reload');
        window.setTimeout(function(){
            QUtil.expandOrCollapseAllNodes(id); 
        }, 600); 
    }
});


</script>

</head>
<body class='easyui-layout' fit='true' border="0">
    <div region="center"  style='overflow:hidden;' border="0"> 
    	<div id='taskTreeId'></div>
    </div> 
</body>
</html>