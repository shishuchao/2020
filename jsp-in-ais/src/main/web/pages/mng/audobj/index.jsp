<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<style type="text/css"> 
		#content{
			width: 20%;
		}
	</style>
	<script type="text/javascript">
        var dpetId = '${magOrganization.fid}';
        var frmUrl = '${contextPath}/mng/audobj/object/${status}.action?superiorCode=${currentCode}&status=${status}&auditingObject.id=';
		$(function(){
			var obj = $('#zcfgTreeSelect')[0];
			var winJson = showSysTree(obj,{
	/* 			container:obj,
				noMsg:true,
				defaultDeptId:dpetId,
				param:{
					'rootId':1,
		            'beanName':'AuditingObjectTree',
		            'treeId'  :'id',
		            'treeText':'name',
		            'serverCache':false,
		            'treeParentId':'parentId',
		            'treeOrder':'currentCode'
		        }, */
				param:{'beanName':'AuditingObjectTree'},
		        container:obj,
				url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action?departmentId='+dpetId,
				defaultDeptId:dpetId,
				cache:false,
				checkbox:false,
				treeTabTitle1:"被审计单位",
				onTreeClick:function(node,treeDom){
					$('#childBasefrm').attr('src',frmUrl+node.id);
				},
				onTreeLoadSuccess:function(node,data){
					if(data.length == 1){
						$('#childBasefrm').attr('src', frmUrl+data[0].id);
					}					
				}
			});
            var winOption = winJson.win.param;
            var jqtree = winOption.jqtree;
            window.left$tree = jqtree;
		  });

        //定位树形节点
        function aud$locationLeftTreeNode(nodeId){
            $(left$tree).tree('reload');
            if(nodeId){
                window.setTimeout(function(){
                    var snode = $(left$tree).tree('find', nodeId);
                    if(snode){
                        QUtil.selectedSpecifiedNode(window.left$tree, snode, snode.text );
                        $(left$tree).tree('expand', snode.target);
                        $('#childBasefrm').attr('src',frmUrl+nodeId);
                    }else{
                    	snode = $(left$tree).tree('getRoot');
						$(left$tree).tree('select', snode.target);
					}
                },2000);
            }
        }
	</script>
</head>
<body  id="codenameLayout" class='easyui-layout' fit='true' border="0">
<!--  
	<table class="ListTable" style='display:none;'>
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				<s:if test="%{status=='edit1'}">
					&nbsp;<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/audobj/object/index.action?status=edit1')" />
				</s:if>
				<s:elseif test="%{status=='edit'}">
					&nbsp;<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/audobj/object/index.action?status=edit')" />
				</s:elseif>
				<s:else>
					&nbsp;<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/audobj/object/index.action?status=view')" />
				</s:else>
			</td>
		</tr>
	</table>
-->	
	
	<div id='content' region="west"  border="0" split="true" style='overflow:hidden;width:300px;' >
		<div id='zcfgTreeSelect'></div>
    </div>
    <div region="center" border="0" style="overflow:hidden;">
		<iframe id="childBasefrm"  name="childBasefrm" width="100%" frameborder="0" height="100%" src=""></iframe>
    </div>
</body>
</html>