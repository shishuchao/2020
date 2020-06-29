<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>路局报表流程列表</title>
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
    frflow.genStatusSelectOption("query_eq_status", status.replace('{','').replace('}','').split(','));;
    
    var g1 = new createQDatagrid({

        // 表格dom对象，必填
        gridObject:$('#frflowTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'FrReportFlow',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        //whereSql:'status !=\'-1\'',
        order:'desc',
        sort:'createTime',
        //whereSql:'orgid = \'${user.fdepid}\'',
        gridJson:{
            queryParams:{'query_neq_status':'-1'},
            onClickCell:function(rowIndex, field, value){
                if(field == 'templateName'){		
                    var rows = $('#frflowTable').datagrid('getRows');
                    frflow.viewFrTemplate(rows[rowIndex],true);
                    $('#frflowTable').datagrid('unSlectRow',rowIndex);
                }
            },	               
            toolbar:[{text:'两级连通测试',
	                 iconCls:'icon-connect',
	                 handler:testWsAddress
	              },'-',{
	            	 text:'上报',
                     iconCls:'icon-redo',
                     handler:onReportToTz
                  },'-',{   
                    text:'解锁',
                    iconCls:'icon-unlock',
                    handler:unlockFlow
                  }
                ],
            columns:[[
               {field:'formId', title:'选择',   width:'20px', checkbox:true, align:'center', show:'false'},      
               {field:'templateName',title:'模板名称',width:bodyW*0.25+'px',align:'left',   sortable:true, oper:'like',
                   formatter:function(value,rowData,rowIndex){
                       return  ["<label title='单击预览' style='cursor:hand;color:blue;'>",value,"</label>"].join('') ;
                   }
               },
               {field:'orgName',title:'审计单位',width:bodyW*0.15+'px',align:'left', sortable:true,
                   type:'custom', target:$('#orgNameBox')[0] },
               {field:'reportYear',title:'年度',width:'40px',align:'center', sortable:true, oper:'like',
                   type:'custom', target:$('#reportYearBox')[0] },
               {field:'statusName',title:'状态',width:'70px',align:'center', sortable:true,
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
                {field:'recipients',title:'铁总接收人',width:'70px',align:'center', sortable:false, show:false},
                {field:'informant',title:'填报人',width:'60px',align:'center', sortable:true, 
                    type:'custom', target:$('#informantBox')[0]},
                {field:'informantTime',title:'填报时间',width:'140px',align:'center', sortable:true, type:'date',oper:'like'},
                {field:'creator',title:'创建人',width:'60px',align:'center', sortable:true,
                    type:'custom', target:$('#creatorBox')[0]},
                {field:'createTime',title:'创建时间',width:'140px',align:'center', sortable:true, type:'date', oper:'like'}
          ]]
        }
    });		
    //alert('${isAdmin}')
    g1.batchSetBtn([{'index':1, 'display':'${isAdmin}' === 'true' ? true : false},
                    {'index':4, 'display':false},
                    {'index':7, 'display':false}]);

   function unlockFlow(){
       try{
            var checkedIds = getCheckedRows();
            $.ajax({
                dataType:'json',
                url : "${contextPath}/fr/report/flow/unlockFlow.action",
                type: "POST",
                data:{
                    'formIds':checkedIds.join(',')
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
                    
    function testWsAddress(){
        try{
            $.ajax({
                dataType:'json',
                url : "${contextPath}/fr/report/flow/testWsAddress.action",
                type: "POST",
                beforeSend: function(){
                    frloadOpen();
                    return true;
                },
                success: function(data){
                    frloadClose();
                    top.$.messager.alert('提示信息', data.msg, data.type, function(){
                    });            
                },
                error:function(data){
                    frloadClose();
                    top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
        }catch(e){
            alert("testAddress:\n"+e.message);
        }
    }
    
    function getCheckedRows(){
        try{
            var rows = $('#frflowTable').datagrid('getChecked');
            var ids = [];
            if(rows && rows.length > 0){
                for(var i=0; i<rows.length; i++){
                    var rowData = rows[i];
                    var status = rowData.status;
                    // 4: 审批完成
                    if(status == '4'){
                        ids.push(rowData.formId);
                    }
                }
                if(ids.length == 0){
                	top.$.messager.alert('提示信息','没有符合要求的数据，</br>只有【审批完成】的记录才能选择','error',function(){
                        $('#frflowTable').datagrid('uncheckAll');
                    });
                }else if(ids.length != rows.length){
                    //top.$.messager.alert('提示信息','只有【审批完成】的记录才能上报到铁总，\n选择的部分数据不会上报','warning');
                }
            }else{
            	top.$.messager.alert('提示信息','请选择记录!','error');
            }
            //alert("ids:"+ids);
            return ids;
        }catch(e){
             alert("getCheckedRows:\n"+e.message);
        }
    }
    
    // 路局上报到铁总
    function onReportToTz(){
        try{         
            getCheckedRows().length ? openReportPersonSelectWin() : null;
        }catch(e){
            alert("onReportToTz:\n"+e.message);
        }
    }
    
    function openReportPersonSelectWin(){
        //alert($('#reportToDiv').length)
        // 打开选人窗口，选择要上报的人（铁总）
        $('#reportToDiv').show().find('img').trigger('click');
    }
    window.qreportToZJ_ = reportToZJ;
    function reportToZJ(recipientsId,recipients){
        try{
            //alert(recipientsId+"\n"+recipients)
            if(!recipientsId){
            	top.$.messager.alert('提示信息','路局报表上报接收人不能为空！','error',openReportPersonSelectWin);
                return;
            }            
            var ids = getCheckedRows();
            $.ajax({
                dataType:'json',
                url : "${contextPath}/fr/report/flow/reportToZJ.action",
                data: {
                    'ids':ids.join(','),
                    'recipientsId':String(recipientsId),
                    'recipients':String(recipients)
                },
                type: "POST",
                beforeSend: function(){
                    var check = ids.length ? true : false;
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
            alert("reportToZJ:\n"+e.message);
        }
    }

});


</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true' border="0">	
        <div region="center" border="0">   	 	
            <table id='frflowTable'></table>
        </div>
    </div> 
    <jsp:include flush="true" page="/pages/frReportFlow/frQueryConditions.jsp" />
    <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />    
</body>
</html>