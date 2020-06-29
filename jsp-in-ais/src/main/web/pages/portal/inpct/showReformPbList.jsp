<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>整改跟踪信息</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	if("${errorMsg}"){
		top.$.messager.alert("提示信息","${errorMsg}", "warning", function(){			
			aud$closeTab();
		});
		setTimeout(aud$closeTab,0);
	}
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var gridTableId = "busTable";

	var gqueryParams = {
    	'query_eq_tableType':'1',
    	'query_eq_mend_state_code':'1',
		'query_eq_audit_dept':'isnotnull',
		'query_eq_audit_object':'isnotnull',
    	'query_eq_isNotMend':'是'
    	
	};

	if("${busJtbb}"){
    	gqueryParams.customParam = "(a.audit_dept in (select u.fid from UOrganization u where u.ftype='D' and u.fpid = '${busId}' or u.fid='${busId}'))";
    }else{
    	gqueryParams.customParam = "(a.audit_dept in (select u.fid from UOrganization u where u.fcode like '${busOrgFcode}%'))";
    }
	
	if('${busRstProjectId}'){
		gqueryParams.query_eq_project_id = '${busRstProjectId}';
	}
	
    var busGridObj = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MiddleLedgerProblem',
		winWidth:800,
	    winHeight:300,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
	    associate:true,
	    gqueryParams:gqueryParams,
        pkName:'id',
        sort  :'serial_num desc',
        gridJson:{
			rownumbers:true,
		    pageSize:20,
		    pagination:true,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		//自定义工具栏按钮
    		toolbar:['search','-','export','-','reload'],
    		onClickCell:function(index, field, value){
    			if(field == 'project_name'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	var winTitle = "项目信息查看";
	            	//var winUrl = "${contextPath}/plan/detail/view.action?crudId=${projectFormId}";
	               	//aud$openNewTab(winTitle, winUrl, true);
				}else if(field == 'serial_num'){
					var rows = $(this).datagrid('getRows');
	            	var row = rows[index];
	            	var winTitle = "审计问题信息";
	            	var winUrl = "${contextPath}/proledger/problem/viewMiddle.action?id="+row.id;
	               	aud$openNewTab(winTitle, winUrl, true, false);
				}
    		},
			columns:[[  
				{field:'project_name',title:'项目名称',width:'300px',halign:'center',align:'left', sortable:true, show:false,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"' style=''>"+value+"</label>" : "";
					}
				},
       			{field:'project_code',title:'项目编号',width:'220px',sortable:true,halign:'center',align:'left',show:'false',
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
       			},
       			{field:'serial_num', title:"问题编号", width:'130px',align:'center', halign:'center', sortable:true, oper:'like',
       				formatter:function(value,row,index){
       					return value ? "<label title='"+value+"' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
       				}
       			},
				{field:'problem_all_name', title:'问题类别',width:'180px',halign:'center',align:'left',sortable:true,
       			 	type:'custom', target:$('#queryCond0')[0],
       				formatter:function(value,row,index){
       					return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
       				}
				},				
				{field:'describe',title:'问题描述', width:'180px', halign:'center', align:'left',  sortable:false,
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
				{field:'problem_grade_name',title:'审计发现类型', width:'100px', halign:'center', align:'center', sortable:true,
					type:'custom', target:$('#queryCond1')[0],
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
				{field:'zeren_dept',title:'整改责任部门', width:'180px', halign:'center', align:'left', sortable:true,
					type:'custom', target:$('#queryCond2')[0],
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
				{field:'mend_term',title:'整改开始日期', width:'110px', halign:'center', align:'center', sortable:true,
					formatter:function(value,row,index){
						if(value){    						
							var t = value.indexOf("T");
							if(t != -1){
								value = value.substr(0, t);
							}
						}
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					},
					type:'datebt', queryKey:'-to_char-mend_term'
				},
				{field:'mend_term_enddate',title:'整改结束日期', width:'110px', halign:'center', align:'center', sortable:true,
					formatter:function(value,row,index){
						if(value){    						
							var t = value.indexOf("T");
							if(t != -1){
								value = value.substr(0, t);
							}
						}
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					},
					type:'datebt', queryKey:'-to_char-mend_term_enddate'
				},
				{field:'mend_state',title:'整改状态', width:'90px', halign:'center', align:'center', sortable:false,
					type:'custom', target:$('#queryCond3')[0],
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
				{field:'aud_mend_advice',title:'整改方案', width:'150px', halign:'center', align:'center', sortable:false, show:false,
					formatter:function(value,row,index){
						return value != null ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
				},
				{field:'operation1',title:'整改证据', width:'18%', halign:'center', align:'center', sortable:false, show:'false',
					formatter:function(value,row,index){
						return "<div id='fileItem"+index+"'></div>";
					}
				},
				{field:'operation2', title:'操作', width:'100px',align:'center',halign:'center',  sortable:true, show:'false',
                	hidden:true,
					formatter:function(value,row,index){
						window.setTimeout(function(){
							$('#fileTigger'+index).linkbutton({    
							    iconCls: 'icon-upload',
							    text:'上传附件'
							}); 
							initFileUploadPlug(index, row['reformFileGuid']);
						},0)
						return "<span id='fileTigger"+index+"' style='border-width:0px;'></span>";
					}
                }
			]]
        }
    });	
    
  	setTimeout(function(){
  		$('#'+gridTableId+'_query_searchAndExportBtn').remove();
  	}, 100)
  	
    //初始化上传文件控件
    function initFileUploadPlug(index, attachmentId){
        $('#fileItem'+index).fileUpload({
        	fileGuid:attachmentId,
            /*
           	文件上传后，回显方式选择， 默认：1
            1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
            2：以文件名列表形式展示，一个文件名称就是一行
            3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
            */
        	echoType:2,
        	// 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
        	//uploadFace:1,
            triggerId:'fileTigger'+index,
            isDel:false,
            isEdit:false
        })
    }
    
});
function treeAfterSure(){
	var snode = $(this).tree('getSelected');
	var idArr = QUtil.getPriorNodeIds(snode.id,
			"/ais/commonPlug/getPriorNodeIdsById.action?beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid");
    if(idArr && idArr.length > 2){   
		var sortC1 = "";
		var sortC2 = "";
		var sortC3 = "";
		var len = idArr.length;
		//alert(len)
		if(len == 4){
			sortC3 = idArr[0];
			sortC2 = idArr[1];
			sortC1 = idArr[2];
		}else if(len == 3){
			sortC2 = idArr[0];
			sortC1 = idArr[1];
		}else if(len == 2){;
			sortC1 = idArr[0];
		}
		//alert(sortC1+"\n"+sortC2+"\n"+sortC3)
		$('#sortC1').val(sortC1);
		$('#sortC2').val(sortC2);
		$('#sortC3').val(sortC3);
    }
}
</script>
</head>
<body style='padding:0px;margin:0px;' class="easyui-layout" fit="true" border="0">
	<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">	
		<table id="busTable"></table>
	</div>	
	<div id='queryCond0'>
        <input type='text' readonly class="noborder" />
        <input type='hidden' name='query_eq_sort_big_code' readonly   id="sortC1"/>
        <input type='hidden' name='query_eq_sort_small_code' readonly id="sortC2"/>
        <input type='hidden' name='query_eq_sort_three_code' readonly id="sortC3"/>
        <a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;' id='wtlbselect'
              onclick="showSysTree(this,{
              title:'问题类别选择',
              param:{
				'rootParentId':'0',
                'beanName':'LedgerTemplateNew',
                'treeId'  :'id',
                'treeText':'name',
                'treeParentId':'fid',
                'treeOrder':'orderNO'
             },
             onAfterSure:treeAfterSure
         })"></a>
	</div>
	<div id='queryCond1'>
		<select  class="easyui-combobox" name="query_eq_problem_grade_code" style="width:160px;" data-options="panelHeight:100" editable="false">
			<option value="">&nbsp;</option>
			<s:iterator value="basicUtil.problemMethodList" id="entry">
				<option value="<s:property value="code"/>"><s:property value="name"/></option>
			</s:iterator>
		</select>
	</div>
	<div id='queryCond2'>
        <input type='text' name='query_like_zeren_dept'  class="noborder" />
        <input type='hidden'  readonly />
        <a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
              onclick="showSysTree(this,{
              title:'整改责任部门选择',
              param:{
                 'rootParentId':'0',
                 'beanName':'UOrganizationTree',
                 'treeId'  :'fid',
                 'treeText':'fname',
                 'treeParentId':'fpid',
                 'treeOrder':'fcode'                     
             }                                 
         })"></a>
	</div>
	<div id='queryCond3'>
		<select id="mendMethod" class="easyui-combobox" name="query_eq_mend_state_code" editable="false" style="width:160px;" data-options="panelHeight:100" >
			<option value="">&nbsp;</option>
			<s:iterator value="basicUtil.fllowOpinionList" id="entry">
				<option value="<s:property value="code"/>"><s:property value="name"/></option>
			</s:iterator>
		</select>
	</div>
</body>
</html>