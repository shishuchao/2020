<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>路局服务地址配置</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script> 
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript">

$(function(){
   var isAdmin = parent.$('#isAdmin').val() == 'true' ? true : false;
   //isdebug = true;
   var bodyW = $('body').width();
   var g2 = new createQDatagrid({
       // 表格dom对象，必填
       gridObject:$('#wsConfigTable')[0],
       // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
       boName:'FrReportFlowWsConfig',
       // 对象主键,删除数据时使用-默认为“id”；必填
       pkName:'orgId',
       order:'desc',
       sort:'createTime',
       // 表格控件dataGrid配置参数; 必填
       gridJson:{
	       singleSelect:true,
	       checkOnSelect:true,
	       selectOnCheck:false,
           queryParams:{},
           onClickCell:function(rowIndex, field, value){
               if(field == 'dpmNodeName'){		
                   var rows = $('#wsConfigTable').datagrid('getRows');
                   var row = rows[rowIndex];
                   editWs(row);
                   //$('#wsConfigTable').datagrid('unSlectRow',rowIndex);
               }
           },	
           toolbar:[{   
                   text:'两级连通测试',
                   iconCls:'icon-connect',
                   handler:batchTestWebs
               },'-',{
                   text:'添加',
                   iconCls:'icon-add',
                   handler:addWs
               },'-',{
                    text:'编辑',
                    iconCls:'icon-edit',
                    handler:function(){
                    	editWs();
                    }
              },'-'
           ],
           idField:'orgId',
           columns:[[ 
               // show:'false  导出和查询都忽略此列，show:false 查询忽略，导出不忽略
               {field:'orgId', title:'选择',    width:'30px', checkbox:true, align:'center', halign:'center', show:'false'},
               {field:'dpmNodeName',title:'系统部署节点',width:bodyW*0.25+'px',align:'left', sortable:true, halign:'center', type:'custom',
                   target:$('#orgNameBox')[0],
                   formatter:function(value,rowData,rowIndex){
                       return  isAdmin ? ["<label title='单击编辑' style='cursor:hand;color:blue;'>",value,"</label>"].join('') : value;
                   }
               },
               {field:'orgName',      title:'审计单位',width:bodyW*0.25+'px',align:'left', sortable:true, halign:'center' },
               {field:'address',      title:'交互服务地址',width:'150px',align:'center', sortable:true, halign:'center', show:false },
               {field:'connectStatus',title:'连接状态',width:'100px',align:'center', sortable:true, halign:'center', show:false },
               {field:'createTime',   title:'创建时间',width:'150px',align:'center', sortable:true, oper:'like',type:'date'}
         ]]
       }
   });
   
   if(isAdmin){
	   g2.batchSetBtn([{'index':5, 'display':false},
	                   {'index':6, 'display':false},
	                   {'index':7, 'display':false}
	                  ]);
   }else{
	   g2.batchSetBtn([{'index':2, 'display':false},
	                   {'index':3, 'display':false},
	                   {'index':4, 'display':false},
	                   {'index':5, 'display':false},
	                   {'index':6, 'display':false},
	                   {'index':7, 'display':false}
	                  ]);
   }
   
   // 批量测试web服务
   function batchTestWebs(){
	   try{
		   var rows = $('#wsConfigTable').datagrid('getChecked');
		   if(!rows || rows.length == 0){
			   showMessage1("请选择测试记录!");
			   return ;
		   }else{
			   var isOne = rows.length == 1 ? true : false;
               $.each(rows, function(i, row){
                   testWsAddress(row['orgId'], row['address'], isOne, true);
               });
		   }
		   
	   }catch(e){
		   isdebug ? alert("batchTestWebs:\n"+e.message) : null;
	   }
   }
   
   // 更新datagrid列
   function updateWsRow(orgId, address, testRt){
       try{
           if(orgId && address){
               var rowIndex = $('#wsConfigTable').datagrid('getRowIndex', orgId);
               if(rowIndex != -1){
                   $('#wsConfigTable').datagrid('updateRow', {
                        index: rowIndex,
                        row: {
                            'connectStatus': testRt ? "连通" : "<font color='red'>断开</font>"
                        }
                   });  
                   //$("#wsConfigTable").datagrid('clearChecked');
               }
           }
       }catch(e){
           isdebug ? alert("updateWsRow:\n"+e.message) : null;
       }
   }
   
   function addWs(){
       $('#frFlowWin').dialog('open');
       clearWsform();
   }
   
   function editWs(row){
        var checkedRow = row || getWsCheckedRow();
        if(checkedRow){
            $('#frFlowWin').dialog('open');
            clearWsform(); 
            $('#wsOrgId').val(checkedRow.orgId);
            $('#wsOrgName').val(checkedRow.orgName);
            $('#wsDpmNodeName').val(checkedRow.dpmNodeName);
            $('#wsAddress').val(checkedRow.address);
        }
    }
   
   function clearWsform(){
      $('#wsOrgId').val("");
      $('#wsOrgName').val("");
      $('#wsDpmNodeName').val("");
      $('#wsAddress').val("");
      
   }
   
   function saveWsform(checkws){
	   
	   var checkws = $('#checkWsBeforeSave::checked').val() ? true :  false;
	   
       if(checkws){
          var r = testWsAddress(null, $('#wsAddress').val(), true, false);
          if(!r) return ;
       }
       saveAddress();
       
       function saveAddress(){
           $.ajax({
               dataType:'json',
               url : "${contextPath}/fr/report/flow/zj/addWebAddress.action",
               data: $('#addWebAddress').serialize(),
               type: "POST",
               beforeSend:function(){
                   var f = validateWsform();
                   f ? frloadOpen() : null;
                   return f;
               },
               success: function(data){
                   frloadClose();
                   top.$.messager.alert('提示信息', data.msg, data.type, function(){              	
                       if(data.type != 'error'){
                           $('#frFlowWin').dialog('close');
                           g2.refresh();
                       } 
                   });            
               },
               error:function(data){
                   frloadClose();
                   top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
               }
           }); 
       }

   }
   
   function validateWsform(){
      var orgName = $('#wsOrgName').val();
      if(!orgName){
   	      top.$.messager.alert('提示信息','审计单位不能为空！','error',function(){
              $('#wsOrgName').parent().find('a').trigger('click');
          });
          return false;
      }
      
      var wsDpmNodeName = $('#wsDpmNodeName').val();
      if(!wsDpmNodeName){
   	      top.$.messager.alert('提示信息','系统部署节点不能为空！','error');
          return false;
      }
      
      var address = $('#wsAddress').val();
      return checkWsAddress(address, "wsAddress");
   }
   
   function checkWsAddress(address, targetId){
      if(!address){
   	      top.$.messager.alert('提示信息','交互服务地址不能为空！','error',function(){
              targetId ? $('#'+targetId).focus() : null;
          });
          return false;
      }else{
          var reg = /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9]):\d{0,5}$/;
          if(!reg.test(address)){
       	      top.$.messager.alert('提示信息','【'+address+'】非法！</br>正确格式如:[127.0.0.1:8090]','error',function(){
                  targetId ? $('#'+targetId).val('').focus() : null;
              });
              return false;
          }
      }
      return true;
   }
   
   function getWsCheckedRow(){
       try{
           var rows = $('#wsConfigTable').datagrid('getChecked');
           var len = rows.length; 
           if(rows && len){
               return rows[0];
           }
           return null;
       }catch(e){
            alert("getWsCheckedRow:\n"+e.message);
       }
   }
   
   $('#frFlowWin').dialog({
       title:'交互服务地址配置',
       closed:true,
       collapsible:true,
       modal:true,
       fit:true,
	   onOpen:function(){
          audEvd$resizeWin('frFlowWin');
	   },
       buttons:[{
            text:'保存',
            iconCls:'icon-save',
            handler:function(){
                saveWsform(true);
            }
        },{
            text:'清空',
            iconCls:'icon-reload',
            handler:clearWsform
        },{
            text:'关闭',
            iconCls:'icon-cancel',
            handler:function(){
                $('#frFlowWin').dialog('close');
            }
        }]
   }); 
   
   function audEvd$resizeWin(winId){
		var posJson = computeBodySize();
		$('#'+winId).dialog('resize',{
			width :posJson.width,
			heigth:posJson.height
		});
   }
   
   // 计算body的高度和宽度
   function computeBodySize(){
	 	try{
	 		return {
	 			width : document.body.clientWidth  || document.documentElement.clientWidth,
	 			height: document.body.clientHeight || document.documentElement.clientHeight
	 		};
	 	}catch(e){
	 		isdebug ? alert('computeBodySize:\n'+e.message) : null;
	 	}
   }
   
   // 测试web服务是否连通
   function testWsAddress(orgId, address, isShowMsg, isAsync){
       var rt = false;
       try{
           $.ajax({
               dataType:'json',
               url : "${contextPath}/fr/report/flow/zj/testWsAddress.action",
               data: {"address":address},
               type: "POST",
               async:isAsync ? true : false,
               beforeSend:function(){
                   var f = checkWsAddress(address);
                   f ? frloadOpen() : null;
                   return f;
               },
               success: function(data){
                   rt = data.type != 'error' ? true : false;
                   frloadClose();
                   isShowMsg ? top.$.messager.alert('提示信息', data.msg, data.type) : null;
                   orgId ? updateWsRow(orgId, address, rt) : null;
               },
               error:function(data){
                   frloadClose();
                   top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
               }
           });
       }catch(e){
           isdebug ? alert("testAddress:\n"+e.message) : null;
       }
       return rt;
    }
   
    $('#testWsbtn').bind('click',function(){
        testWsAddress($('#wsOrgId').val(), $('#wsAddress').val(), true, true);
    });
	
	$('#wsConfigTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
});


</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'>	

   <!-- datagrid -->
   <table id='wsConfigTable'></table>

   <!-- 交互服务地址配置窗口 -->
   <div id="frFlowWin" name="frFlowWin" style='border-bottom:1px solid #cccccc;overflow:hidden;text-align:center;'>
        <form id="addWebAddress">
            <table class="ListTable" align="center" style='table-layout:fixed;'>
                <tr>
                   <td class="EditHead"  nowrap="nowrap" style='width:300px;'><font color=red>*</font>审计单位</td>
                   <td class="editTd" style='min-width:50%;'><input type="text"   name="wsconfig.orgName"  id='wsOrgName' class="noborder" style='width:60%;' readonly/>
                       <input type="hidden" name="wsconfig.orgId"  id="wsOrgId" />
                       <a class="easyui-linkbutton"  iconCls="icon-search"
                           onclick="showSysTree(this,{
                                title:'请选择-审计单位',
                                defaultDeptId:'${user.fdepid}',
                                defaultUserId:'${user.floginname}',
                                param:{
                                  'rootParentId':'0',
                                  'beanName':'UOrganizationTree',
                                  'treeId'  :'fid',
                                  'treeText':'fname',
                                  'treeParentId':'fpid',
                                  'treeOrder':'fcode'
                               },
                               onTreeClick:function(node){
                               		$('#wsDpmNodeName').val(node.text ? node.text.replace('审计处','') : '');
                               		$('#wsAddress').focus();
                               }                                  
                           })"></a>
                	</td>
                </tr>
                <tr>
                    <td class="EditHead"  nowrap="nowrap"><font color=red>*</font>系统部署节点</td>
                    <td class="editTd" >
                    	<input name="wsconfig.dpmNodeName" id="wsDpmNodeName" value="" class="noborder" style='width:60%;' />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="EditHead"  nowrap="nowrap"><font color=red>*</font>交互服务地址(例如：127.0.0.1:8090)</td>
                    <td class="editTd" >
                    	<input name="wsconfig.address" id="wsAddress" value="http://" class="noborder" 
                    	style='width:60%;' title="例如：127.0.0.1:8090"/>&nbsp;
                    	<a  id='testWsbtn' class="easyui-linkbutton"  iconCls="icon-statistic">测试</a>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead"  nowrap="nowrap">保存前测试服务</td>
                    <td class="editTd" >
                    	<input type='checkbox'  id="checkWsBeforeSave"  value="1"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>