<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<title>审计分工</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>		
</head>
<body class="easyui-layout" border='0' fit='true'>
	<div region="north" border='0' id='layoutnorth'>
			<div class="EditHead" style="border-bottom:1px solid #ccccc;text-align:right;padding:5px 10px 2px 10px;">
				<input type="radio" name="mycheck" value="recover" checked="checked"/> 级联选择&nbsp;
				<input type="radio" name="mycheck" value="remove" /> 取消级联&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="batchSaveFun();">批量保存</a>
			</div>	
	</div>
	<div region="center" border='0' id='layoutcenter' style='overflow:hidden;'>
		<ul id="taskAssignTree" style="padding:10px 0px 2px 5px;"></ul>
	</div>
    <form id="myformTree" name="my_form_tree" method="post" style=""
        action="/ais/operate/task/deleteTree.action?project_id=<%=request.getParameter("project_id")%>" >
        <s:hidden id="treeId"   name="treeId"/>
        <s:hidden id="groupIds" name="groupIds"/>
        <s:hidden id="memIds"   name="memIds"/>
        <div id="tree-div"></div>
    </form>	
    <input name="triggerTreeCheck" id="triggerTreeCheck" value="true" style="display:none;"/>
<script type="text/javascript">
 	$(function() {
 		//级联选择
		$('input:radio[name="mycheck"]').change(function(){
			 var myVal = $('input[name="mycheck"]:checked').val();
			 if('remove'==myVal){
			 	$('#taskAssignTree').tree({cascadeCheck:false})
			 }else if('recover'==myVal){
			 	$('#taskAssignTree').tree({cascadeCheck:true})
			 }
		});
 		//审计事项分工树
        $('#taskAssignTree').tree({
            url : '${contextPath}/operate/task/project/showTreeListBatchEdit.action',
            queryParams : {
                'project_id':'${project_id}',
                'treeSource':'myTree'
            },
			checkbox:true,
			onLoadSuccess:function(node, data){
				if(null==node){
					var rootNode = $("#taskAssignTree").tree('getRoot');
					$("#taskAssignTree").tree('expand',rootNode.target);
				}else{
					$("#taskAssignTree").tree('expandAll',node.target);		
				}
			},
			onClick:function(node){
				//alert("${gm}")
				if("${gm}" == 2){					
					var childwin = window.parent.frames['childBasefrm'];
	                $('#triggerTreeCheck').val(false);
	                childwin.setPMGridCheckbox(node.taskAssign, node.taskAssign ? true : false);
	                $('#triggerTreeCheck').val(true);
				}
			}
        });

 		window.setTimeout(function(){			
	        $('#taskAssignTree').css({
	            'overflow':'auto',
	            'height'  : document.documentElement.clientHeight - $('#layoutnorth')[0].offsetHeight - 12
	        });
 		},1000);
        
    });
    //批量提交
 	function batchSaveFun(){
        var msg = '';
        var selNodes = $('#taskAssignTree').tree('getChecked');
        var taskTemplateId = '';
        var taskIdArr = [];
		$.each(selNodes, function(m,node){
          /*
          if(msg.length > 0){
              msg += ',';
          }		  		
		  msg += node.id;
          */
          taskIdArr.push(node.id);
		});   
        msg = taskIdArr.join(",");
        taskIdArr = null;
        if(msg==''){
			top.$.messager.show({title:'提示信息', msg:'请选择要保存的审计事项!'});
            return false;
        }else{
  		  //document.getElementsByName('treeId')[0].value = msg;
          $('#treeId').val(msg);
       }		
       var Switcher = Array();
       //把数据写入到manuIds
        <%
        if("1".equals(request.getParameter("gm"))){%>
            window.parent.frames['childBasefrm'].getAlLCheckedGroupData();
        <%}else if("2".equals(request.getParameter("gm"))){%>
            window.parent.frames['childBasefrm'].getAlLCheckedMemberData();
        <%}%>          
          var checkbox = window.parent.frames['childBasefrm'].document.getElementById("manuIds").value;
          var selected="1";
          var gID="";
          if(null!=checkbox && checkbox!=''){
          	gID = checkbox;
          	selected="2";
          }
          
         if(selected=='1'){
            var temp1 = "";
            
                   <%
            if("1".equals(request.getParameter("gm"))){%>
             temp1 = "没有选择审计小组，是否要删除所选审计事项的审计小组?";
            <%}else if("2".equals(request.getParameter("gm"))){%>
             temp1 = "没有选择审计组员，是否要删除所选审计事项的审计组员?";
            <%}%>

            top.$.messager.confirm('确认对话框', temp1, function(r){
                if (r){
                <%
                if("1".equals(request.getParameter("gm"))){%>
                    document.getElementsByName('treeId')[0].value=msg;
                    document.getElementsByName('groupIds')[0].value=gID;
                    saveGroupDataFun(msg,gID);
                    <%}else if("2".equals(request.getParameter("gm"))){%>
                    document.getElementsByName('treeId')[0].value=msg;
                    document.getElementsByName('memIds')[0].value=gID;
                    saveMemberDataFun(msg,gID);
                    <%}%>
                }
            });     
        }else{	        
            top.$.messager.confirm('确认对话框', '是否要保存选定的审计事项?', function(r){
                if (r){
                       <%
                        if("1".equals(request.getParameter("gm"))){%>
                            document.getElementsByName('treeId')[0].value=msg;
                            document.getElementsByName('groupIds')[0].value=gID;
                            saveGroupDataFun(msg,gID);				
                        <%}else if("2".equals(request.getParameter("gm"))){%>
                            document.getElementsByName('treeId')[0].value=msg;
                            document.getElementsByName('memIds')[0].value=gID;
                            saveMemberDataFun(msg,gID);
                        <%}%>	
                }
            });
                 
        }             
         
 	}
 	
 	  function saveMemberDataFun(msg,gID){
  			$.ajax({
  			   type: "POST",
  			   url: "<%=request.getContextPath()%>/operate/task/project/batchSaveMember.action",
  			   data: {"treeId":msg,"memIds":gID,"project_id":'<%=request.getParameter("project_id")%>'},
   			   success: function(msg){
     				if(msg=='suc'){
                        top.$.messager.show({title:'提示信息', msg:'保存成功!'});
                        
						window.parent.frames['f_left'].location.href="/ais/operate/task/project/showTreeListBatchEdit.action?project_id=<%=request.getParameter("project_id")%>&gm=<%=request.getParameter("gm")%>";     					
						window.parent.frames['childBasefrm'].location.href="/ais/operate/task/project/showContentEditGroupOrMember.action?project_id=<%=request.getParameter("project_id")%>&gm=<%=request.getParameter("gm")%>";
                            					
     				}else{
     					top.$.messager.show({title:'提示信息',msg:'保存失败!'});
     				}
   			   }
  			}); 	  
 	  } 	
 	
 	  function saveGroupDataFun(msg,gID){
  			$.ajax({
  			   type: "POST",
  			   url: "<%=request.getContextPath()%>/operate/task/project/batchSaveGroup.action",
  			   data: {"treeId":msg,"groupIds":gID,"project_id":'<%=request.getParameter("project_id")%>'},
   			   success: function(msg){
     				if(msg=='suc'){
                        top.$.messager.show({title:'提示信息', msg:'保存成功!'});
						window.parent.frames['f_left'].location.href="/ais/operate/task/project/showTreeListBatchEdit.action?project_id=<%=request.getParameter("project_id")%>&gm=<%=request.getParameter("gm")%>";     					
						window.parent.frames['childBasefrm'].location.href="/ais/operate/task/project/showContentEditGroupOrMember.action?project_id=<%=request.getParameter("project_id")%>&gm=<%=request.getParameter("gm")%>";                         
     				}else{
     					top.$.messager.show({title:'提示信息', msg:'保存失败!'});
     				}
   			   }
  			}); 	  
 	  }
 	
	  //dwr 提交验证
	  function checkNodeTree(id,id2){
	    var resullt=''; 
	    var s='${project_id}';
		DWREngine.setAsync(false);
		DWREngine.setVerb("POST");
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'checkNodeTree4Member', httpMethod:'POST',executeResult:'false' }, 
		{'project_id':s,'treeId':id,'memId':id2},xxx);
	     function xxx(data){
	     result =data['auth'];
		} 
	  if(result==''){
	    return true;
	  }else{
	    top.$.messager.show({title:'提示信息', msg:result});
	  return false;
	  }
	} 	
	
	 function checkTreeSelect(checked,id){
         if($('#triggerTreeCheck').val() == 'false'){
            return;
         }
		 var resullt=''; 
		 jQuery.ajax({
			 async:false,
			 url:'/ais/operate/task/getTreeNodeId.action?project_id=${project_id}&gm=${gm}&treeId='+id,
			 type:'post',
			 success:function(data){
				result = data;
			 }
		 });
			if(result!=''){
				var ids = result.split(',');
				for(var i = 0;i<ids.length;i++){
				var node = $('#taskAssignTree').tree('find', ids[i]);
					if(node){
						if(checked){
							$('#taskAssignTree').tree('check', node.target);
						}else{
							$('#taskAssignTree').tree('uncheck', node.target);
						}
					}
				}
			}
			
		} 
</script>
</body>
</html>

