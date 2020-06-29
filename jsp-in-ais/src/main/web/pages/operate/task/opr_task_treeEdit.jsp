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
    var menuTaskId,menuTaskName;
    var dnd = true;//'${pso.prepare_closed}'=='1'?false:true;
    // 自定义 - 实施方案树
    
    var treeOptions = {
    	  treeTabTitle1:"实施方案树",
          container:taskTree,
          checkbox:true,
          dnd:dnd,
		  cascadePrior:false,
          //cascadeJunior:true,
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
            	//alert(node.attributes)
            	var isViewTaskInfo = $('#clickViewTaskInfo').combobox("getValue");
            	if(isViewTaskInfo == '2') return;
                var parent = $('#taskTreeId').tree('getParent',node.target);
                var id = node.id;
                var type = node.leaf==0 ? "1":"2";
                var taskPid = parent ? parent.id : null;
                var path = "";
                if(!taskPid){
                   window.parent.frames['childBasefrm'].location.href="/ais/operate/task/showContentEdit.action?interCtrl=${interCtrl}&node="+node.attributes.taskTemplateId+"&path="+path+"&selectedTab=main&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=${project_id}";
                }else{
     	    	   window.parent.frames['childBasefrm'].location.href="/ais/operate/task/showContentEdit.action?interCtrl=${interCtrl}&node="+node.attributes.taskTemplateId+"&path="+path+"&selectedTab=item&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=${project_id}"+"&fromAdjust=<%=request.getParameter("fromAdjust")%>";
                }
             }catch(e){
                  isDebug ? top.$.messager.alert('提示信息',"onTreeClick:"+e.message,'error') : null;
             }
          },
        onBeforeDrag:function(node){
            var json = $.parseJSON(node.attributes);
            if(json.template_type == '0') {
                return false;
            }
        },
        onBeforeDrop:function(target,source,point){
            var targetNode = $('#taskTreeId').tree('getNode', target);
            var json = $.parseJSON(targetNode.attributes);
            if(json.template_type == '2'&&point=='append') {
                return false;
            }
            if(json.template_type == '0'&&point!='append') {
                return false;
            }
        },
        onDrop:function(target,source,point){
            var targetNode = $('#taskTreeId').tree('getNode', target);
            updateTaskNode(targetNode.id,source.id,point);
        },
        onTreeContextMenu: function(e, node){
            e.preventDefault();
            var parent = $('#taskTreeId').tree('getParent',node.target);
            if(parent.length <= 0)
                return false;

            $('#taskTreeId').tree('select', node.target);
            $('#mm').menu('show', {
                left: e.pageX,
                top: e.pageY
            });
            var json = $.parseJSON(node.attributes);
            if(json.template_type == '2') {
                $('#mm').menu('disableItem',$('#pasteMenu'));
            }else{
                $('#mm').menu('enableItem',$('#pasteMenu'));
            }
            $('#mm').menu({
                onClick:function(item){
                    if(item.id == 'copyMenu'){
                        menuTaskId = node.id;
                        menuTaskName = node.text;
                    }else if(item.id == 'pasteMenu'){
                        if(menuTaskId == null||menuTaskId == ''){
                            showMessage1('请先复制事项再执行粘贴操作!');
                            return;
                        }
                        top.$.messager.confirm('确认','确认要复制事项[<span style=\"color:red\" title="'+menuTaskName+'">'+(menuTaskName.length>20?menuTaskName.substring(0,20):menuTaskName)+'...</span>]到[<span style=\"color:red\" title="'+node.text+'">'+(node.text.length>20?node.text.substring(0,20):node.text)+'...</span>]下吗?',function(r){
                            if(r){
                                $.ajax({
                                    url:'${contextPath}/operate/taskExt/copyTaskNode.action',
                                    type:'get',
                                    cache:false,
                                    data:{
                                        'menuTaskId':menuTaskId,
                                        'pasteTaskId':node.id,
                                        'projectId':'${project_id}'
                                    },
                                    success:function(data){
                                        if(data.indexOf('ok') != -1) {
                                            var newNodeId = data.split("&")[1];
                                            reloadTree(newNodeId);
                                            menuTaskId = '';
                                            menuTaskName = '';
                                        }
                                    }
                                });
                            }
                        });

                    }
                }
            });
        }
    }

    showSysTree(taskTree,treeOptions);

    /*$('#importTaskTree').tree({
		checkbox: true,
		cascadeCheck:false, 
		lines:true,
		url: '/ais/aml/getSjsxTree.action',
		onCheck:function(node){
			$('#tt2').tree('expand', node.target);
		}
	});*/

    // 导入审计事项（树初始化）
    var importTaskTree = $('#importTaskTree');		
    showSysTree(importTaskTree,{
       treeTabTitle1:"审计事项树",
       container:importTaskTree,
       checkbox:true,
       cascadePrior:true,
       cascadeJunior:true,
       queryBox:true,
       noMsg:true,
       param:{
			//禁用oracle特性（加载会变慢），因为AuditMatter没有具体的父ID，只有parent对象，无法赋值
			'isOracle':false,
			'serverCache':false,
            'rootParentId':'null',
            'beanName':'AuditMatter',
            'treeId'  :'id',
            'treeText':'name',
            'treeParentId':'parent.id',
            //'whereHql':'name = \'contion_taskName\'',
            'treeOrder':'id'
        }
    });
    
    
    
    
    
    /********* 审计事项窗口中的方法 ***************/
    // 添加审计事项(打开窗口)
    $('#addTaskBtn').bind('click',function(){
    	 if(checkTaskNode()){
            $('#importTaskWin').window('open');        
		    $('#importTaskWin').window('resize',{
		        'top':'0px',
		        'left':'0px',
		        'width':document.body.clientWidth || document.documentElement.clientWidth,
		        'height':parseInt(document.body.clientHeight || document.documentElement.clientHeight)
		    }); 
    	 }
    });
    
    // 导入审计事项前预览
    $('#importTaskViewBtn').bind('click', function(){
        var nodes = $('#importTaskTree').tree('getChecked');
        if(nodes && nodes.length > 0){
            var ids = [];
            for(var j=0; j<nodes.length; j++){
                var node = nodes[j];
                var tmp = [];
                tmp.push("'");
                tmp.push(node.id);
                tmp.push("'");
                ids.push(tmp.join(''))
            }
            window.parent.frames['childBasefrm'].showImportTaskView(ids.join(','));
        }else{
            top.$.messager.alert('提示信息','请选择要导入的审计事项！', 'error');
        }
    });
    // 直接导入审计事项
    $('#importTaskBtn').bind('click', function(){
        saveNodes();
    });
    // 关闭(添加)审计窗口
    $('#closeTaskWinBtn').bind('click', function(){
    	closeTaskWin();
    });
    function closeTaskWin(){
        $('#importTaskWin').window('close'); 
         window.parent.frames['childBasefrm'].closeImportTaskView();       
    }
    $('#closeTaskWin').window({
        onClose:function(){
            window.parent.frames['childBasefrm'].closeImportTaskView();
        }
    });
    
    // 展开事项-审计事项窗口
    $('#expandImportTaskBtn').bind('click', function(){
    	QUtil.expandOrCollapseAllNodes('importTaskTree');
    });
    
    /********* 主页面审计事项树中的注册方法 ***********/
    // 审计事项批量删除
    $('#batchDelTaskBtn').bind('click',batchDelTaskNode);


    function checkTaskNode(){
    	var flag=true;
        try{
            var taskTree = $('#taskTreeId');
            var node = taskTree.tree('getSelected');
           if(!node){
                top.$.messager.show({
					title:'提示信息',
					msg:'请选中一个审计事项类别，勾选无效!',
					timeout:5000,
					showType:'slide'
				});
                flag=false;
            }else{
                var ids = "";
                var arr = [];
                var parent = $('#taskTreeId').tree('getParent',node.target);
                arr.push(node.id);
                if(1==arr.length){
                	var taskTemplateIdParaVal = arr[0];
						$.ajax({
							 type:"Post",
							 url:"/ais/operate/template/saveAuditMatterTemplate!checkUpstageNode.action",
							 async:false,
							 data:{
								'project_id':'${project_id}',
								'taskTemplateIdPara':taskTemplateIdParaVal
							 },
							 success:function(ret){
								if(ret=='upstage'){
									$("#taskTemplateIdPara").val('1');
								}else{
									$("#taskTemplateIdPara").val(taskTemplateIdParaVal);						
								}
							}							
						});	
						if($("#taskTemplateIdPara").val() == '1'){
							top.$.messager.show({
								title:'提示信息',
								msg:'添加审计事项不能选择最末级事项!',
								timeout:5000,
								showType:'slide'
							});
					      	   return false;
					       }else{
					    	   return true;
					       }
                	}else{             		 
                		top.$.messager.show({
        					title:'提示信息',
        					msg:'请选中一个审计事项类别，勾选无效!',
        					timeout:5000,
        					showType:'slide'
        				});
                		flag=false;              	
	                }
            }

        }catch(e){
            /* isDebug  ? alert("删除失败，"+e.message+"(batchDelTaskNode)") : null; */
            isDebug ? top.$.messager.alert('提示信息',"添加失败，checkTaskNode"+e.message+"(batchDelTaskNode)",'error') : null;
        }
        return flag; 
    }
    
    // 批量删除
    function batchDelTaskNode(){
        try{
            var parentNodeId = "";
            var taskTree = $('#taskTreeId');          
            var nodes = taskTree.tree('getChecked');
            if(nodes && nodes.length == 0){
                //$.messager.alert('提示信息',"请选择要删除的审计事项",'error');
                top.$.messager.show({
					title:'提示信息',
					msg:'请选择要删除的审计事项',
					timeout:5000,
					showType:'slide'
				});
                return;
            }else{
                var ids = "";
                var arr = [];
                for(var i=0; i<nodes.length; i++){
                    var node = nodes[i];
                    if(i == 0){
                        var parentNode = taskTree.tree('getParent', node.target);
                        parentNodeId = parentNode ? parentNode.id : "";
                    }
                    var parent = $('#taskTreeId').tree('getParent',node.target);
                    if(!parent) continue;
                    arr.push(node.id);
                }
                ids = arr.join(',');
                
                function beforeDel(deleIds){
                    var flag = true;
                    $.ajax({
                         type:"Post",
                         url:"${contextPath}/operate/task/isGoOn.action",
                         async:false,
                         data:{
                            'allMsg':deleIds,
                            'project_id':'${project_id}'
                         },
                         success:function(data){
                            flag = data && data == 1 ? false : true;
                        }
                    });    
                    return flag;
                }

                top.$.messager.confirm("审计事项批量删除","是否删除选择的["+arr.length+"个]审计事项？",function(r){
                     if(r){
                        $.ajax({
                             type:"Post",
                             url:"${contextPath}/operate/task/deleteTree.action",
                             beforeSend:function(){
                                var rtflag = beforeDel(ids);
                                if(!rtflag){
                                    top.$.messager.show({
                                        'title':'提示信息',
                                        'msg'  :"选择的事项下己登记底稿\疑点，请删除底稿\疑点后再删除！"
                                    });
                                }
                                //alert('rtflag='+rtflag)
                                return rtflag;
                             },
                             data:{
                                'treeId':ids,
                                'project_id':'${project_id}'
                             },
                             success:function(type){
                            	//alert('after delete tree node')
                                reloadTree(parentNodeId);
                            }
                        });
                     }
                 });
            }

        }catch(e){
            /* isDebug  ? alert("删除失败，"+e.message+"(batchDelTaskNode)") : null; */
            isDebug ? top.$.messager.alert('提示信息',"删除失败，"+e.message+"(batchDelTaskNode)",'error') : null;
        }
    }
    

    
    // 导入审计事项
    function saveNodes(){
    	var project_id = document.getElementsByName('project_id')[0].value;
		var nodes = $('#importTaskTree').tree('getChecked');
		var arr = [];
		if(nodes && nodes.length == 0){
            top.$.messager.show({
				title:'提示信息',
				msg  :'请选择要导入的审计事项!',
				timeout:5000,
				showType:'slide'
			});
            return;
        }
        for(var i=0; i<nodes.length; i++){
             var node = nodes[i];
             var leaf = $('#importTaskTree').tree('isLeaf',node.target);
             var parentNode = $('#importTaskTree').tree('getParent', node.target);  
             //alert("node="+node.text+"\nparentNode="+parentNode.text+"\nisLeaf="+$('#importTaskTree').tree('isLeaf',node.target))
             // 如果是根节点，跳过
              if(!parentNode || (!parentNode.id || node.id.toLowerCase() == 'c')){
                  continue;
              }   
             var jsonstr = [];
             jsonstr.push("{'id':'");
             jsonstr.push(node.id);
             jsonstr.push("','pId':'");
             jsonstr.push(parentNode.id);
			 jsonstr.push("");
             jsonstr.push("','name':'");
             jsonstr.push(node.text);
             jsonstr.push("','leaf':'");
             jsonstr.push(leaf);
             jsonstr.push("'}"); 
             arr.push(jsonstr.join(""));
        }
        var nodeString = "["+arr.join(",")+"]";
		var taskTemplateIdVal = $("#taskTemplateIdPara").val();
		$.ajax({
			 type:"Post",
			 url:"/ais/operate/template/saveAuditMatterTemplate!importAuditMatterSure.action",
			 data:{
				'nodeString':nodeString,
				'project_id':project_id,
				'taskTemplateIdPara':taskTemplateIdVal
			 },
			 success:function(ret){
				if(ret=='true'){
					top.$.messager.alert('提示信息','保存成功！','info',function(){
                        closeTaskWin();
                        var taskTree = $('#taskTreeId'); 
                        var node = taskTree.tree('getSelected');
                        reloadTree(node.id);
                   });  
				}else if(ret=='upstage'){
					top.$.messager.alert('提示信息','添加审计事项不能选择最末级事项!','info');    
				}else{
					top.$.messager.alert('提示信息','保存失败！','info');
					return;
				}
			}
		});
    }
    window.q$saveNodes = saveNodes;
    

});

/************** 公共方法 ***************/    
// 重新加载树形
function reloadTree(nodeId){
    locationTaskTreeNode(nodeId,"");
}

//页面重新定位事项节点
function locationTaskTreeNode(nodeId, text){
	try{
        $('#taskTreeId').tree('reload');
        var timeout = window.setTimeout(function(){
            //alert('nodeId='+nodeId)
            if(nodeId){
                var url = "${contextPath}/commonPlug/getPriorNodeIdsById.action?rootParentId=-1&whereHql=project_id='${project_id}'&beanName=AudTaskTree&treeId=taskTemplateId&treeText=taskName&treeParentId=taskPid&treeOrder=taskCode";
                QUtil.expandPriorNodeByIds(nodeId, url, $('#taskTreeId'), text, false);
            }
            timeout ? clearTimeout(timeout) : null;
        }, 200);
	}catch(e){
		alert("locationTaskTreeNode:\n"+e.message);
	}
}
function updateTaskNode(toNodeId,sourceNodeId,point){
    $.ajax({
        url:'${contextPath}/operate/taskExt/updateTaskNode.action',
        type:'get',
        cache:false,
        data:{
            toNodeId:toNodeId,
            sourceNodeId:sourceNodeId,
            point:point,
            'projectId':'${project_id}'
        },
        success:function(data){
            if(data == 'ok') {
                reloadTree(sourceNodeId);
            }else{
                showMessage1(data);
            }
        }
    });
}
</script>

</head>
<body class='easyui-layout' fit='true' border="0">
    <div region="south"  style='overflow:hidden; padding:10px;text-align:right;white-space:nowrap;' border="0" > 
		<select id="clickViewTaskInfo" editable="false" class="easyui-combobox easyui-tooltip"  title="单击事项节点时, 是否查看其详细信息"  style="width:120px;" panelHeight="60px">     
		    <option value="1">开启事项查看</option>   
			<option value="2">关闭事项查看</option>    
		</select>         
   		<a href='javascript:void(0)' id='addTaskBtn'      class="easyui-linkbutton" data-options="iconCls:'icon-add'">导入事项</a>
   		<a href='javascript:void(0)' id='batchDelTaskBtn' class="easyui-linkbutton" data-options="iconCls:'icon-delete'">批量删除</a>
    </div> 
    <div region="center"  style='overflow:hidden;'  border="0">
    	<div id='taskTreeId'></div>
        <div id="mm" class="easyui-menu" style="width:120px;">
            <div data-options="iconCls:'icon-edit'" id="copyMenu">复制</div>
            <div data-options="iconCls:'icon-copy'" id="pasteMenu">粘贴</div>
        </div>
    </div> 
    
    <!-- 导入审计事项 -->
    <s:hidden name="project_id" />
	<input type="hidden" name="taskTemplateId" id="taskTemplateIdPara"/>
	<div id="importTaskWin" class="easyui-window" border='0' data-options="border:0,title:'导入审计事项',modal:true,closed:true,shadow:false,maximizable:false,minimizable:false" style="width:390px;height:600px;">
		<div class="easyui-layout" border="0" fit='true' >
			<div  region="center"  border="0"  style='overflow:hidden; padding:0px;'>
		&nbsp;&nbsp;
				<ul id="importTaskTree"></ul>
			</div>
			<div region="south"  border="0" style='text-align:right;overflow:hidden; padding:10px;border-top:1px solid #cccccc;'>
				<button id='importTaskBtn'       class="easyui-linkbutton" data-options="iconCls:'icon-import'" href="javascript:void(0)">导入</button>&nbsp;
				<button id='closeTaskWinBtn'     class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" >关闭</button>
            </div>
		</div>
	</div>
    <!-- end -->
    
</body>
</html>