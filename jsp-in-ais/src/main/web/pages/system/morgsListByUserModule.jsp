<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List,ais.auth.model.AuthUserModule,ais.organization.model.UOrganization"%>
<%
	String spath=request.getContextPath()+"/scripts/portal/checktree/";
 %>
<html>
  <head>
 <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="Javascript">
var t2_t;
function getSelectedValue()
{	
  document.all("paraIds").value=getSelectedValues();//获取数据
  document.all("selectedLoginName").value=window.parent.document.getElementsByName("selectName")[0].value;
	  document.forms[0].submit();
}
function doClose(){
window.parent.close();
}
function allSelected(){// 所有的复选框都被选中
	t2_t.allSlct();
}
function allNoSelected(){
	t2_t.clearValue();
};
function getSelectedValues(){
	return t2_t.getValue();
}

</script>
<link rel="stylesheet" type="text/css" href="/ais/styles/portal/ext-all.css">
  <link rel="stylesheet" type="text/css" href="<%=spath%>css/Ext.ux.tree.CheckTreePanel.css">
  <link rel="stylesheet" type="text/css" href="<%=spath%>css/checktree.css">
  <script type="text/javascript" src="/ais/scripts/portal/extjs22/ext-base.js"></script>
  <script type="text/javascript" src="/ais/scripts/portal/extjs22/ext-all.js"></script>
  <script type="text/javascript" src="<%=spath%>js/Ext.ux.tree.RemoteTreePanel.js"></script>
  <script type="text/javascript" src="<%=spath%>js/Ext.ux.tree.CheckTreePanel.js"></script>
  <title id="page-title">Ext.ux.tree.CheckTreePanel by Saki</title>
  <SCRIPT type="text/javascript">
  Ext.ux.tree.CheckTreePanel.prototype.allSlct =function() {
		this.root.cascade(function(n) {
			var ui = n.getUI();
			if(ui && ui.setChecked) {
				ui.setChecked(true);
				if(this.attributes.value){
					this.attributes.value=n.id;
				}else{
					this.attributes.value+=","+n.id;
				}
			}
		});
	};
  </SCRIPT>
  <script type="text/javascript">
  
  	Ext.onReady(function() {
    Ext.QuickTips.init();
		 var Tree = Ext.tree;
	var t2=new Ext.ux.tree.CheckTreePanel({
		renderTo:'ct2'
		,id:'t2'
		,width:300
		,height:'auto'
		,autoScroll:true
		,rootVisible:false
		,border:false
		,root:{
			id:'root'
			,text:'root'
			,expanded:true
			,uiProvider:false
		}
	});
	t2_t=t2;
	var root=t2.root;
	 <s:iterator value="map.keySet()" id="key2">
	 	<s:iterator value="map.get(#key2)" id="org">
	 		var node_<s:property value="id"/>=new Tree.TreeNode({id:'<s:property value="id"/>',text:'<s:property value="name"/>',leaf:<s:property value="leaf"/>,uiProvider:Ext.ux.tree.CheckTreeNodeUI});
	 	</s:iterator>
	 </s:iterator>
	  <s:iterator value="map.keySet()" id="key">
	 	<s:iterator value="map.get(#key)" id="org">
	 		<s:if test="pid!=null&&pid!=''">
	 		node_<s:property value="pid"/>.appendChild(node_<s:property value="id"/>);
	 		</s:if>
	 		<s:else>
	 			root.appendChild(node_<s:property value="id"/>);
	 		</s:else>
	 	</s:iterator>
	 </s:iterator> 
	 t2.setValue('${morg_ids}');
	/*
	var value2 = new Ext.form.TextField({
		 renderTo:'ct2'
		,id:'value2'
		,style:'margin-top:2px'
		,name:'value2'
		,width:300
		,listeners:{
			 focus:function() {
				this.setValue(t2.getValue());
			}
			,change:function() {
				t2.setValue(this.getValue());
			}
			,render:function() {
				Ext.QuickTips.register({
					 target:this.el
					,text:'<div><b>Focus</b> to call <b>tree.getValue()</b></div><div><b>Blur</b> to call <b>tree.setValue()</b></div>'
				})
			}
		}
	});*/
});
  </script>
  </head>
  
  <body >
  <s:if test="${empty(view) or user.floginname=='admin'}">
	  <table border=0 cellspacing=1 cellpadding=1 width=95% >
	<tr>
	<td width=60%>
		<td>
		<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="保存" onclick="getSelectedValue()"></div>
		</td>
		<td width=10 nowrap></td>
		<td>
		<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="doClose()"></div>
		</td>
		<td width=10 nowrap></td>
		<td>	
		<div id="oneSelect" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="全选" onclick="allSelected();"></div>					
		</td>
		<td>	
		<div id="oneSelect2" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="反选" onclick="allNoSelected();"></div>					
		</td>
	</tr>
	</table>
</s:if>
  <!-- ******* -->
 
<s:form action="saveToAuthUserModule" namespace="/system">
<!--数据存储位置-->
<input type="hidden" id="paraName" name="paraName">
<input type="hidden" id="paraIds" name="paraIds">
<input type="hidden" id="companyId" name="companyId" value="${companyId}">
<input type="hidden" id="selectedLoginName" name="selectedLoginName">
<s:hidden name="fmoduleId"></s:hidden>
</s:form>
<!-- start -->
<div id="ct2" 
			style="height: 95%; width: 100%;clear: both;"></div>
<!-- end -->
  </body>
</html>