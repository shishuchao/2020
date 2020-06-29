<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>确定评价范围列表</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var parentTabId = "${parentTabId}";
	var projectId =  "${projectId}";
	var editUrl = '${contextPath}/intctet/prepare/assessScheme/editAssessfw.action?view=${view}&parentTabId='+parentTabId+'&projectId='+projectId;
	var tabTitle = isView ? "查看" : "编辑";
	
	var addBtn = {   
            text:'新增',
            iconCls:'icon-add',
            handler:function(){
            	$('#selectOrgWin').trigger('click');
            	return;
        		new aud$createTopDialog({
        			title:'新增评价范围',
        			url:editUrl,
        			width:400,
        			height:400
        		}).open()
            }
        };  

	var cusToolbar = [];	
	if(!isView){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}
	var gridTableId = "surefwList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SureassessScope',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        order :'desc',
        sort  :'scopecode,createTime desc',
		winWidth:800,
	    winHeight:250,
	    myToolbar:['delete', 'export', 'reload'],
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		return true;
    	},
		//删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject)
		afterRemoveRowsFn:function(rows, gridObject){
			parent.$('#sureContent').data('isload', false);
			parent.$('#sureTeam').data('isload', false);
			try{
				var orgIdsArr = [];
				//alert(rows.length)
				if(rows && rows.length){
					$.each(rows, function(i, row){
						//alert(row['auditCode'])
						orgIdsArr.push(row['auditCode'])
					});
				}
				//alert(orgIdsArr)
				//删除被评价单位对应的项目控制点
				if(orgIdsArr && orgIdsArr.length){				
					$.ajax({
						url:"${contextPath}/commonPlug/deleteBeans.action",
						dataType:'json',
						type: "post",
						data: {
							"beanName":"ProjectControlPoint",
							"query_eq_projectId":"${projectId}",
							"query_in_evaluatedUnitId":orgIdsArr.join(",")
						},
						success: function(data){
						},
						error:function(data){
							top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
						}
					});
					$.ajax({
						url:"${contextPath}/commonPlug/deleteBeans.action",
						dataType:'json',
						type: "post",
						data: {
							"beanName":"InterMemberGroup",
							"query_eq_projectFormId":"${projectId}",
							"query_in_belongToUnitId":orgIdsArr.join(",")
						},
						success: function(data){
						},
						error:function(data){
							top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
						}
					});
				}
			}catch(e){
				//alert(e.message)
			}
		},
		whereSql:"interProId = '${projectId}' ",
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:cusToolbar,
            onLoadSuccess:function(data){
            	
                setTimeout(function(){    	
            	    if(isView){
            	    	$('.datagrid-cell-check, .datagrid-header-check').parent().remove();
            	    }
                }, 0);
            	
            	if(data && data.rows && data.rows.length){
        			parent.$('#qtab').tabs('enableTab',2);
        			//parent.$('#qtab').tabs('select',2);
            	}
            },
            columns:[[           	
                {field:'formId',title:'选择', checkbox:true,  align:'center', halign:'center', hidden:isView,  show:'false'},
                {field:'scopecode',title:'编号',     width:'15%',align:'center', halign:'center',  sortable:true, oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                },
                {field:'auditName',title:'被评价单位', width:'20%',align:'left',   halign:'center',  sortable:true,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                },
                {field:'cityName', title:'所在城市', width:'80px',align:'center', halign:'center',  sortable:true, oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                },
                {field:'tradePlateName',title:'所属板块', width:'20%',align:'center', halign:'center',  sortable:true, show:false, oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                },
                {field:'levelName',  title:'机构级次', width:'10%',align:'center', halign:'center',  sortable:true, show:false, oper:'like',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                }
          ]]
        }
    });
    
    window.surefwList = g1;
    
 	//编辑状态，启用确定评价内容
	$('#sscope_formId').val() ? parent.$('#qtab').tabs('enableTab',2) : null;
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    // 删除按钮权限
    isView? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
 
	
    function formatterClick(value){
    	return  ["<label title='单击"+tabTitle+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
	
});

//更新父页面确定评价内容iframe请求url的参数
function aud$setDatumParam(isload){
	//parent.$('#audDatumParam').val("formId="+$('#ap_formId').val());
	parent.$('#sureContent').data('isload',isload);
}
//根据被评价单位选择带出所在城市和所属板块
function getCityPlate(){
	var auditCode = document.getElementById('sscope_auditCode').value;
	if (auditCode != ''){
		var result = "";
		$.ajax({
			url:'${contextPath}/intctet/prepare/assessScheme/getcityPlate.action?auditCode='+auditCode,
			//async:false,
			type:'POST',
			success:function(data){
				if(data['success']!=null){
					var text = data['success'];
					var value = text.split("#");
					$("#sscope_cityName").val(value[0]);
					$("#sscope_cityCode").val(value[1]);
		    		$("#sscope_tradePlateCode").val(value[2]);
		    		$("#sscope_levelCode").val(value[3]);
		    		$("#sscope_levelName").val(value[4]);
		    		$("#sscope_tradePlateName").val(value[5]);
				}
			}
		});
		return result;
	}
}

function aud$saveSureScope(orgIdStr){
	$.ajax({
		url : "${contextPath}/intctet/prepare/assessScheme/saveSureScope.action",
		dataType:'json',
		type: "post",
		data: {
			'orgIdStr':orgIdStr.join(","),
			'projectId':"${projectId}"
		},
		beforeSend:function(){
			aud$loadOpen();
			return true;
		},
		success: function(data){
			data.msg ? top.$.messager.alert("提示信息", data.msg, data.type) : null;
			if(data.type != "error"){
				surefwList.refresh();
				parent.$('#sureContent').data('isload', false);
			}
			aud$loadClose(); 
		},
		error:function(data){
			aud$loadClose();
			top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
		}
	});
}

</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='surefwList'></table>
	<div id='listWin' name='listWin' style='display:none;'>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
   
   
   <div style='display:none;'>
		<input type='text' id='sscope_auditName'  readonly/>
		<input type="hidden" id='sscope_auditId'/>
		<a  id="selectOrgWin" onclick="showSysTree(this,{
                title:'被评价单位选择',
                checkbox:true,
			    param:{
			  	   'rootParentId':'0',
                   'beanName':'UOrganizationTree',
                   'treeId'  :'fid',
                   'treeText':'fname',
                   'treeParentId':'fpid',
                   'treeOrder':'fcode',
                 },
                 onAfterSure:function(dms, mcs){
                	$('#sscope_auditName, #sscope_auditId').val('');
                	if(dms){
	                	aud$saveSureScope(dms);               		
                	}
                 }
		})"></a>
   </div>
   
</body>
</html>