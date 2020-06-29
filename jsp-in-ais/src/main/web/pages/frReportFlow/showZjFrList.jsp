<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>铁总接收路局报表</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/pages/frReportFlow/frReportFlow.js"></script>
<script type="text/javascript">
$(function(){	
	var bodyW = $('body').width();
    var status = '${statusMap}';
    // 设置年度
    frflow.genYearSelectOption("query_eq_reportYear", "${curYear}", 3);
    frflow.genStatusSelectOption("query_eq_status", status.replace('{','').replace('}','').split(','));	
    var g1 = new createQDatagrid({
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		if(rows){			
    			for(var i=0; i<rows.length; i++){
    				var row = rows[i];
    				//for(var p in row) alert(p+'='+row[p])
    				var status = row.status;
    				var formId = row.formId;
    				//alert('formId='+formId+'\nstatus='+status);
    				if(formId != null || status != '1'){
    					alert('只有状态为草稿的总局报表才能删除！');
    					//alert($(datagridObj).datagrid)
    					$(datagridObj).datagrid('uncheckAll');
    					return false;
    				}
    			}
    		}
    		return true;
    	},
        // 表格dom对象，必填
        gridObject:$('#frflowZJTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'FrReportFlowReceive',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        order:'desc',
        sort:'createTime',
        whereSql:'source =\'0\' or ( source =\'1\' and recipientsId like \'%${user.floginname}%\')',
        // 表格控件dataGrid配置参数; 必填
        gridJson:{
            queryParams:{},
            onClickCell:function(rowIndex, field, value){
                if(field == 'templateName'){		
                    var rows = $('#frflowZJTable').datagrid('getRows');
                    var row = rows[rowIndex];
                    var sformId = row.sformId;
                    /*
                    if(sformId){// snapshot transmited by inferior department
                    	frflow.viewFrSnapshot(row);
                    }else{// local template view
                    	frflow.viewFrTemplate(row,true);
                    }*/
                    var isUseTemplate = !Boolean(sformId);
                    var frtablehtml = frflow.viewFrTemplate(row,isUseTemplate);
                    if(!isUseTemplate){                   	
	                    if(frtablehtml){                  	
		                    $('#formId').val(sformId);
		                    $('#fileName').val(row.templateName);
		                    $('#frtablehtml').html(frtablehtml);
		                    $('#frTableWin').dialog('setTitle',row.templateName +"  预览");
		                    $('#frTableWin').dialog('open');
		                    $('#frflowZJTable').datagrid('unSlectRow',rowIndex);
	                    }else{
	                    	top.$.messager.alert('提示信息','没有报表数据！','error');
	                    }
                    }
                }
            },	
            toolbar:[{   
                    text:'上报审批',
                    iconCls:'icon-ok',
                    handler:zjPassed
                },'-',{
                    text:'本地审批',
                    iconCls:'icon-ok',
                    handler:localPassed
                },'-',{   
                    text:'退回',
                    iconCls:'icon-return',
                    handler:retreateToDSJ
                },'-',{   
                    text:'解锁',
                    iconCls:'icon-unlock',
                    handler:unlockFlow
                }
            ],
    		columns:[[
                {field:'formId', title:'选择',   width:'20px', checkbox:true, align:'center', halign:'center', show:'false'},      
                {field:'templateName',title:'模板名称',width:bodyW*0.2+'px',align:'left',  halign:'center', sortable:true, oper:'like',
                    formatter:function(value,rowData,rowIndex){
                        //return rowData.reportContent ? "<a href='javascript:void(0);' style='cursor:hand;color:blue;border-bottom:1px solid blue;'>"+value+"</a>" : value;
                        return  ["<label title='单击预览' style='cursor:hand;color:blue;'>",value,"</label>"].join('') ;
                    }
                },
                {field:'orgName',title:'审计单位',width:bodyW*0.2+'px',align:'left', halign:'center',sortable:true,
                    type:'custom', target:$('#orgNameBox2')[0]},
                {field:'reportYear',title:'年度',width:'40px',align:'center', halign:'center',sortable:true, oper:'like',
                    type:'custom', target:$('#reportYearBox')[0]},
                {field:'sourceName',title:'来源',width:'40px',align:'center', halign:'center', show:false,
                    formatter:function(value,rowData,rowIndex){
                        var source = rowData.source;
                        value = value ? value:"";
                        return  "<span style='color:"+(source == '0' ? 'blue' : 'black')+"'><strong>"+value+"</strong></span>";
                    }
                },
                {field:'statusName',title:'状态',width:'70px',align:'center', halign:'center', sortable:true,
                    type:'custom', target:$('#statusBox')[0],
                    formatter:function(value,rowData,rowIndex){
                        var status = rowData.status;
                        var color = "black";
                        if(status == '4'){
                            color = "blue";
                        }else if(status == '5'){
                            color = "#00AAAA";
                        }else if(status == '9'){
                            color = "green";
                        }else if(status == '0'){
                            color = "red";
                        }
                        return  "<span style='color:"+color+"'><strong>"+value+"</strong></span>";
                    }
                },
                {field:'recipients',title:'铁总接收人',width:'90px',align:'center',halign:'center', sortable:false, show:false},
                {field:'informant',title:'填报人',width:'60px',align:'center',halign:'center', sortable:true,
                    type:'custom', target:$('#informantBox')[0]},
                {field:'informantTime',title:'填报时间',width:'140px',align:'center', halign:'center',sortable:true,type:'date', oper:'like'},
                {field:'creator',title:'创建人',width:'70px',align:'center', sortable:true,
                    type:'custom', target:$('#creatorBox')[0]},
                {field:'createTime',title:'创建时间',width:'140px',align:'center',halign:'center', oper:'like',sortable:true,type:'date'}
          ]]
        }
    });
    g1.batchSetBtn([{'index':5, 'display':false},{'index':8, 'display':false}]);

   // 报表流程解锁
   function unlockFlow(){
       try{
            var parr = getCheckedRows("formId",true);
            var checkedIds = parr[0];
            var sourceCodes = parr[1];
            $.ajax({
                dataType:'json',
                url : "${contextPath}/fr/report/flow/zj/unlockFlow.action",
                type: "POST",
                data:{
                    'formIds':checkedIds.join(','),
                    'sourceCodes':sourceCodes.join(','),
                    'isZj':'1'
                },
                beforeSend: function(){
                    var check = checkedIds.length ? true : false;
                    check ? frloadOpen() : null;
                    return check;
                },
                success: function(data){
                    frloadClose();
                    top.$.messager.alert('提示信息', data.msg, data.type, function(){
                        if(data.type != 'error'){
                             g1.refresh();
                        }  
                    });            
                },
                error:function(data){
                    frloadClose();
                    top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
       }catch(e){
           alert('unlockFlow:\n'+e.message)
       }
   }     
    
    // 通用 - 获得列表选中的行
    function getCheckedRows(field, unlock){
        try{
            var rows = $('#frflowZJTable').datagrid('getChecked');
            var formIds = [];
            var orgIds  = [];
            if(rows && rows.length > 0){
                for(var i=0; i<rows.length; i++){
                    var rowData = rows[i];
                    var status = rowData.status;
                    if(unlock){
                        // 4: 审批完成 , 5:已上报, 9:审批通过
                        if(status == '4' || status == '5' || status == '9'){
                            formIds.push(rowData[field]);
                            orgIds.push(rowData.source);
                        }
                    }else {
                          // 4: 审批完成 , 5:已上报
                        if(status == '4' || status == '5'){
                            if(!rowData.sformId && field == 'formId' && rowData.source == '0'){
                                formIds.push(rowData[field]);
                            }else if(field == 'sformId' && rowData.sformId){
                                //alert(field+'='+rowData[field])
                                formIds.push(rowData[field]);
                                orgIds.push(rowData.orgId);
                            }
                        }                      
                    }

                }
                if(formIds.length == 0){
                	top.$.messager.alert('提示信息','没有符合要求的数据！','error',function(){
                        $('#frflowZJTable').datagrid('uncheckAll');
                    });
                }
            }else{
            	top.$.messager.alert('提示信息','请选择记录!','error');
            }
            return [formIds,orgIds];
        }catch(e){
             alert("getCheckedRows:\n"+e.message);
        }
    }
    
    // 铁总本级报表审批通过
    function localPassed(){
        try{
            var parr = getCheckedRows("formId");
            var formIds = parr[0];
            $.ajax({
                dataType:'json',
                url : "${contextPath}/fr/report/flow/zj/localPassed.action",
                data: {
                    'formIds':formIds.join(',')
                },
                type: "POST",
                beforeSend: function(){
                    var check = formIds.length ? true : false;
                    g1.batchSetBtn([{'index':2, 'disabled':check}]);
                    check ? frloadOpen() : null;
                    return check;
                },
                success: function(data){
                	frloadClose();
                	top.$.messager.alert('提示信息', data.msg, data.type, function(){              	
                        if(data.type != 'error'){
                            g1.refresh();
                        }    
                        g1.batchSetBtn([{'index':2, 'disabled':false}]);
                    });            
                },
                error:function(data){
                    frloadClose();
                    top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
        }catch(e){
             alert("zjPassed:\n"+e.message);
        }
    }
    
    //铁总审批通过
    function zjPassed(){
        try{
            var parr = getCheckedRows("sformId");
            var sformIds = parr[0];
            var orgIds   = parr[1];
            //alert(sformIds)
            //alert(orgIds)
            $.ajax({
                dataType:'json',
                url : "${contextPath}/fr/report/flow/zj/zjpassed.action",
                data: {
                    'sformIds':sformIds.join(','),
                    'orgIds' :orgIds.join(',')
                },
                type: "POST",
                beforeSend: function(){
                    var check = sformIds.length ? true : false;
                    g1.batchSetBtn([{'index':1, 'disabled':check}]);
                    check ? frloadOpen() : null;
                    return check;
                },
                success: function(data){
                	frloadClose();
                	top.$.messager.alert('提示信息', data.msg, data.type, function(){              	
                        if(data.type != 'error'){
                            g1.refresh();
                        }    
                        g1.batchSetBtn([{'index':1, 'disabled':false}]);
                    });            
                },
                error:function(data){
                    frloadClose();
                    top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
        }catch(e){
             alert("zjPassed:\n"+e.message);
        }
    }
    
    // 铁总退回报表到路局
    function retreateToDSJ(){
        try{
            var parr = getCheckedRows("sformId");
            var sformIds = parr[0];
            var orgIds  = parr[1];
            
            $.ajax({
                dataType:'json',
                url : "${contextPath}/fr/report/flow/zj/retreatToDSJ.action",
                data: {
                    'sformIds':sformIds.join(','),
                    'orgIds' :orgIds.join(',')
                },
                type: "POST",
                beforeSend: function(){
                    var check = sformIds.length ? true : false;
                    g1.batchSetBtn([{'index':2, 'disabled':check}]);
                    check ? frloadOpen() : null;
                    return check;                   
                },
                success: function(data){
                	frloadClose();
                	top.$.messager.alert('提示信息', data.msg, data.type, function(){              	
                        if(data.type != 'error'){
                             g1.refresh();
                        } 
                        g1.batchSetBtn([{'index':2, 'disabled':false}]);
                    });            
                },
                error:function(data){
                    frloadClose();
                    top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
        }catch(e){
            alert("retreateToDSJ:\n"+e.message);
        }
    }
    //alert("${isAdmin}")
    if("${isAdmin}" === 'true'){
        $('#qtab').tabs({
            onSelect:function(title, index){
                if(index == 1 && !$('#webAdressifm').data('isload')){
                    $('#webAdressifm').attr('src', '${contextPath}/fr/report/flow/zj/showWebAdressList.action');
                    $('#webAdressifm').data('isload',true);
                }
            }
        });            
    }
    
    $('#frTableWin').dialog({
        title:'报表预览',
        closed:true,
        zIndex:200,
        width:$('body').width(),
        height:$('body').height(),
        toolbar:[{
            text:'导出到Excel',
            iconCls:'icon-export',
            handler:function(){
            	$('#exportFrTable').submit();
            }
        },'-',{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#frTableWin').dialog('close');
             }
         },'-']
    }); 
    $('#frtablehtml').css({
        width:$('body').width() - 15,
        height:$('body').height() - 70,
        overflow:'auto'
    });
});
</script>
</head>
<body>
	<!-- layout 布局  -->
    <div id="container" class='easyui-layout' fit='true' border="0">	
        <div region="center" border="0">   
            <s:if test="${isAdmin == true}">
                <div id="qtab" class="easyui-tabs"  fit="true" border="0">  
                   <div title="报表列表" id='tab1' border="0">  	    	 	
                       <table id='frflowZJTable'></table>
                   </div>
                   <div title='路局服务地址' id='tab2' border="0" style='overflow:hidden;'>
                       <iframe id='webAdressifm' name='webAdressifm'
                        width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
                   </div>
                </div>
            </s:if>
            <s:else>
           	 	<table id='frflowZJTable'></table>
            </s:else>

        </div>
    </div>
    
    <!-- 报表预览窗口 -->
    <div id="frTableWin" name="frTableWin" style='overflow:hidden;'>
		<div id="frtablehtml" name="frtablehtml"></div>
	</div>
   
   <!-- 报表预览时导出（模拟异步模式导出文件） -->
   <form id="exportFrTable" target="exportTmpIfm" method="POST" action="${contextPath}/fr/report/flow/exportTableData.action">
   	   <iframe id="exportTmpIfm" name="exportTmpIfm" style="display:none;"></iframe>
   	   <input type='hidden' id="formId" name="formId"/>
   	   <input type='hidden' id="fileName" name="fileName"/>
   </form>
   
   <!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/frQueryConditions.jsp" />
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>