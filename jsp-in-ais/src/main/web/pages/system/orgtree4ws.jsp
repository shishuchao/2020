<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <s:head theme="ajax" debug="false"  />
<script>

     
</script>
  </head>
  
  <body>

<div style="float:left; margin-right: 15px;">
<s:tree id="orgtree"
    theme="ajax"
    rootNode="#request.orgtree" 
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