<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.operate.template.model.AudTemplate" />
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:head theme="ajax" />
		<title>审计方案库维护1</title>
		<link href="/ais/resources/csswin/subModal.css" rel="stylesheet"
			type="text/css" />
		<link href="/ais/styles/main/ais4ext.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="/ais/resources/csswin/common.js"></script>
		<script type="text/javascript" src="/ais/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="/ais/scripts/ais_functions.js"></script>
		<link rel="stylesheet" type="text/css"
			href="/ais/styles/portal/ext-all.css" />
		<script type="text/javascript" src="/ais/scripts/portal/ext-base.js"></script>
		<script type="text/javascript" src="/ais/scripts/portal/ext-all.js"></script>
		<script type="text/javascript"
			src="/ais/scripts/portal/ext-lang-zh_CN.js"></script>
		<link rel="stylesheet" type="text/css"
			href="/ais/pages/cncext/grid-examples.css" />
		<link rel="stylesheet" type="text/css"
			href="/ais/pages/cncext/examples.css" />
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<style type="text/css">
body.x-panel {
	margin-bottom: 20px;
}

.icon-grid {
	background-image: url(/ais/pages/cncext/shared/icons/fam/grid.png)
		!important;
}

#button-grid.x-panel-body {
	border: 1px solid #99bbe8;
	border-top: 0 none;
}

.add {
	background-image: url(/ais/pages/cncext/shared/icons/fam/add.gif)
		!important;
}

.option {
	background-image: url(/ais/pages/cncext/shared/icons/fam/plugin.gif)
		!important;
}

.remove {
	background-image: url(/ais/pages/cncext/shared/icons/fam/delete.gif)
		!important;
}

.save {
	background-image: url(/ais/pages/cncext/shared/icons/save.gif)
		!important;
}
</style>		
			
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>
//调用父窗口方法
function useParentFun(){
this.opener.stopx();  
}

function viewInfo(id,link){
var url;
if(link!=null && link!=''){
url = "${contextPath}/"+link;
window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}else{
url = "${contextPath}/bpm/systemprompt/viewDetailSystemPrompt.action?id="+id;
window.location = url;
}

}
</script>

	</head>
<body  onload="refurbishit()">
		<form>
		<br>
<s:tabbedPanel id='test' theme='ajax'>
<s:if test="list!=null && list.size!=0" >
<s:div id='sys' label='预制方案' theme='ajax'
							labelposition='top' loadingText="正在加载内容......">
		 
<input type="hidden" name="month" value="0">

			<s:hidden name="type" />
			<s:hidden name="project_id" />

			<div id="myList" style="margin-left: 150px"></div>
			<br>
			<div align="center">
				<input type="button" value="查看" onclick="deleteRecord()" />
				<input type="button" value="增加" onclick="add()" />
				<input type="button" value="编辑" onclick="editRecord()" />
				<input type="button" value="删除" onclick="deleteRecord()" />

			</div>
			<script type="text/javascript">
	Ext.onReady(function(){

    //Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

var myData = [
<%
	List myList=(List)request.getAttribute("list");
	for(int i=0;i<myList.size();i++)
	{
		AudTemplate po=(AudTemplate)myList.get(i);
		out.print("[");
		out.print("'<input type=radio name=audTemplateId ops=\"mix\"  value="+po.getAudTemplateId()+">',");
		out.print("'"+po.getTemplateName()+"',");
		
		out.print("'"+po.getProVer()+"',");
		out.print("'"+po.getTypeName()+"',");
		out.print("'"+po.getTypeName2()+"',");
		 
		out.print("'"+po.getDept_name()+"',");
		out.print("'"+po.getProAuthorName()+"',");
		out.print("'"+po.getDept_name_author()+"',");
		out.print("'"+po.getProDate()+"',");
		//out.print("'"+"<a href=");
		if(i==myList.size()-1)    
			out.print("]");
		else
			out.print("],");
	}
%>
];
 
    // create the data store
    var store = new Ext.data.SimpleStore({
        fields: [
           {name: 'audTemplateId'},
           {name: 'templateName'},
           {name: 'proVer'},
           {name: 'typeName'},
           {name: 'typeName2'},
           {name: 'dept_name'},
           {name: 'proAuthorName'},
           {name: 'dept_name_author'},
           {name: 'proDate',type: 'date', dateFormat: 'Y-m-d'}
           //{name: 'link'}
           
        ]
    });
    
 ;
 
    

    // create the Grid
    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: "选择", width: 80, sortable: false,  dataIndex: 'audTemplateId',hideable:false},
            {header: "方案名称", sortable: true,  dataIndex: 'templateName'},
            {header: "方案版本", sortable: true,  dataIndex: 'proVer'},
            {header: "类别名称", sortable: true,  dataIndex: 'typeName'},
            {header: "子类别名称", sortable: true,  dataIndex: 'typeName2'},
            {header: "适用单位", sortable: true,  dataIndex: 'dept_name'},
            {header: "编制人", sortable: true,  dataIndex: 'proAuthorName'},
            {header: "编制单位", sortable: true,  dataIndex: 'dept_name_author'},
            {header: "编制日期", sortable: true, renderer: Ext.util.Format.dateRenderer('Y-m-d'), dataIndex: 'proDate'}
            //{id:'link',header: "操作", width: 125, sortable: false,  dataIndex: 'link'}
        ],
        stripeRows: true,
        //autoExpandColumn: 'link',
        bodyStyle:'100%',
        autoWidth:true,
        viewConfig: {forceFit: true},
        autoHeight:true,
        frame:true,
        collapsible: true,
        animCollapse: false,
        
        title:'',
         bbar: new Ext.PagingToolbar({
	        pageSize: 5,
	        store: store,
	        displayInfo: true,
	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
	        emptyMsg: "没有记录"
	    })
    });
    store.loadData(myData);
    grid.render('myList');
    grid.getSelectionModel().selectFirstRow();
});
</script>
		 
		<br>
</s:div>
</s:if>

<s:if test="list!=null && list.size!=0" >


<s:div id='pending' label='回传方案' theme='ajax'
							labelposition='top' loadingText="正在加载内容......">]
							
<s:url id="returnUrl" namespace="/operate/template" action="list" />
 
<display:table name="list" id="row"
					requestURI="/portal/simple/sysView.action"
					pagesize="5" class="its" cellpadding="1" >
					<display:column property="templateName" title="方案名称"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
						 
						 <display:column property="proVer" title="方案版本"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
						 
						 <display:column property="typeName" title="类别名称"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
						 
						 <display:column property="typeName2" title="子类别名称"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
						 
						 <display:column property="dept_name" title="适用单位"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
						 
						 <display:column property="proAuthorName" title="编制人"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
						 
						  <display:column property="dept_name_author" title="编制单位"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
						 
						  <display:column property="proDate" title="编制日期"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
					 
    </display:table>
							
<br>
</s:div>		
</s:if>		
 
</s:tabbedPanel>		
		</form>
		
		<br><br><br>
		
		<div align="center">
		 
		&nbsp;&nbsp;
<%--		<s:button value="不再提示" onclick="useParentFun();"/>--%>
		</div>
	<script language="JavaScript">
	
	   //上传附件
	  function add()
		{
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog();
		}
	
　　function refurbishit() {
    //window.opener.location.href=window.opener.location.href; //刷新父窗口
　　//setTimeout('window.close()',3000);//间隔10秒钟自动关闭
　  //setTimeout('window.location.href=window.location.href',10000);//间隔10秒钟自动刷新
　　}
　 </script>
</form>
	</body>
</html>

