<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <s:head theme="ajax" debug="true"  />
<script>
function RightGo(arg)
{
<s:url id="url"  action="uCompanyAction" method="view" />
var id=arg.source.widgetId;
 parent.main.location.href='<s:text name="%{url}"/>?nodeid='+id;
 
}
dojo.addOnLoad(function() {                
                //var s = dojo.widget.byId('0').selector;                
                //dojo.event.connect(s, 'select', 'RightGo');
                var treeSelector = dojo.widget.manager.getWidgetById('orgtree');
               // treeSelector.expandToLevel(dojo.widget.byId('3'),2);
                //treeSelector.expandToLevel(dojo.widget.byId('orgtree'),2);
                var s = dojo.widget.byId('orgtree').selector;                
                dojo.event.connect(s, 'select', 'RightGo');
            });
     
</script>
  </head>
  
  <body>

<div style="float:left; margin-right: 15px;">
<s:tree id="orgtree"
    theme="ajax"
    rootNode="%{rootNode}" 
    childCollectionProperty="children" 
    nodeIdProperty="id"
    nodeTitleProperty="name"
    treeSelectedTopic="treeSelected" 
    showRootGrid="false" 
    showGrid="false" treeExpandedTopic="treeExpanded">
</s:tree> 

</div>

  </body>
</html>
