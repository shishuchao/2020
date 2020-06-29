<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>送审项目</title>
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
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var apStatusCode = "${apStatusCode}";
	var deptId = "${deptId}";
	var floginname = "${floginname}";
	var apIdStr = "${apIdStr}";
	var isSearch = "${isSearch}" == "true" || "${isSearch}" == true ? true : false;;
	var editUrl = '${contextPath}/ea/dvAudProject/showFrame.action?view=${view}&apStatusCode='+apStatusCode;
	var tabTitle = isView ? "查看" : "编辑";
	var postBtn = {
		text: apStatusCode == '2' ? '受理' : apStatusCode == '3' ? '完成' : '送审',
		id:'dvPost',
        iconCls:'icon-ok',
        handler:function(){
        	postAp(parseInt(apStatusCode) + 1);
        }
    };
	var retrunBtn = {   
        text:'退回',
        id:'dvRetreat',
        iconCls:'icon-return',
        handler:function(){
        	postAp("1");
        }
    };
	var addBtn = {   
        text:'添加',
        iconCls:'icon-add',
        id:'dvAdd',
        handler:function(){
        	aud$openNewTab('送审项目添加', editUrl, true);
        }
    }
	var cusToolbar = [];

	if(apStatusCode == '1'){
		cusToolbar.push(addBtn);
		cusToolbar.push('-');
	}/*else if(apStatusCode == '2'){
		cusToolbar.push(retrunBtn);
		cusToolbar.push('-');
	}else if(apStatusCode == '3'){
		cusToolbar.push(postBtn);
		cusToolbar.push('-');
		}*/
	
	if(isView){
		cusToolbar = [];
	}
	//首页我的项目-更多
	var isFromMyProject = '${myProject}' == 'true' ? true : false;
	var projectWhere = [];
	if(!isSearch && (isFromMyProject || isView)){
		projectWhere.push("exists (");
		projectWhere.push("select 1 from DvAudProject dp,AudBusRelation ar where a.apId = dp.apId and dp.apId = ar.bid and dp.apStatusCode != '4' and (");
		projectWhere.push("(dp.apStatusCode = '1' and dp.creatorId='${user.floginname}') ");
		projectWhere.push("or (dp.apStatusCode = '2' and ar.attrName='ea_dvap_audObject' and ar.itemCode='${deptId}') ");
		projectWhere.push("or (dp.apStatusCode > 2 and (dp.proHeaderId='${user.floginname}'  or (ar.attrName='ea_dvap_projectMember' and ar.itemCode='${user.floginname}'))) ");
		projectWhere.push("or (dp.apStatusCode > 2 and ar.attrName='ea_dvap_agency_member' and ar.itemCode='${user.floginname}')");
		projectWhere.push("))");
	}else if(isSearch){
		
	}else if(apStatusCode){
		//alert(apStatusCode)
		projectWhere.push("apStatusCode='${apStatusCode}' ");
		if(apStatusCode == "1"){
			projectWhere.push(" and creatorId='${user.floginname}' ");
		}else if(apStatusCode == "2"){			
			projectWhere.push("and exists (select 1 from DvAudProject dp,AudBusRelation ar "); 
			projectWhere.push("where a.apId=dp.apId and dp.apId=ar.bid and dp.apStatusCode='2' ");
			projectWhere.push("and ar.attrName='ea_dvap_audObject' and ar.itemCode='${deptId}') ");			
		}else if(apStatusCode == "3" || apStatusCode == "4"){
			projectWhere.push("and exists (");
			projectWhere.push("select 1 from DvAudProject dp,AudBusRelation ar where a.apId = dp.apId and dp.apId = ar.bid and  (");
			projectWhere.push("dp.proHeaderId='${user.floginname}'  or (ar.attrName='ea_dvap_projectMember' and ar.itemCode='${user.floginname}') ");
			projectWhere.push("or (ar.attrName='ea_dvap_agency_member' and ar.itemCode='${user.floginname}')");
			projectWhere.push(")) ");
		}
	}

	var gridTableId = "dvAudProjectList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'DvAudProject',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'apId',
        order :'desc',
        sort  :'createTime',
		winWidth:880,
	    winHeight:230,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:isView ? ['search', 'export', 'reload'] : isFromMyProject ? ['search', 'export', 'reload'] : ['delete', 'search', 'export', 'reload'],
	    associate:true,
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		return true;
    	},
	    whereSql:projectWhere.length ? projectWhere.join("") : "",
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'audProjectName'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$openNewTab(apStatusCode=='1'?"("+row['audProjectName']+")项目送审": apStatusCode=='2'?"("+row['audProjectName']+")项目受理":apStatusCode=='3'?"("+row['audProjectName']+")项目实施":"("+row['audProjectName']+")项目"+ tabTitle, editUrl + "&apId=" + row['apId'] + "&view=${view}", true);
                }else if(field == 'eaProjectName'){
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    var projectFrameUrl = '${contextPath}/ea/project/showFrame.action';
                	aud$openNewTab("工程项目信息查看", projectFrameUrl+"?pid="+row['proId']+ "&view=true", true);
                }
            },	
            onCheck:function(index, row){
            	if(apStatusCode != '1' && !row.proHeaderId){
            		//$('#'+gridTableId).datagrid("uncheckRow", index);
            		showMessage1("【"+row.audProjectName + "】数据不完整，请单击项目名称完善项目信息！");
            	}
            	if(apStatusCode == '3'){
            		var rt = isComplete([row['apId']]);
            		!rt.isComplete ? showMessage1(rt.errMsg) : null;
            	}
            },
            frozenColumns:[[           	
                {field:'apId',  title:'选择', width:'10px', checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'apStatus',title:'项目状态', width:'65px',align:'center',   halign:'center',  sortable:true,
                    type:'custom', target:$('#queryCond0')[0]},
                {field:'audProjectName',title:'审计项目名称', width:'180px',align:'left', halign:'center',  sortable:true,
					oper:'like', formatter:formatterClick},
                {field:'eaProjectName',title:'工程项目名称', width:'150px',align:'left', halign:'center',  sortable:true, oper:'like',
					formatter:function(value){
						return ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('');
					}
                }
            ]],
    		columns:[[
                {field:'audType',title:'审计类型', width:'100px',align:'center',   halign:'center',  sortable:true,
					type:'custom', target:$('#queryCond1')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}	
                },
                {field:'approvalCost',title:'项目批复金额（元）', width:'165px',align:'right',   halign:'center',  sortable:true, exportType:"AMOUNT",
                    type:'custom', target:$('#queryCond3')[0], formatter:aud$gridFormatMoney},
                {field:'audCost',title:'送审金额（元）', width:'165px',align:'right', halign:'center',  sortable:true, exportType:"AMOUNT",
					type:'custom', target:$('#queryCond2')[0], formatter:aud$gridFormatMoney},
                {field:'audDate',title:'送审时间', width:'100px',align:'center',   halign:'center',  sortable:true,
                	type:'custom', target:$('#queryCond4')[0]},
                {field:'audUnit',title:'送审单位', width:'25%',align:'left',   halign:'center',  sortable:true,
                	type:'custom', target:$('#queryCond5')[0],
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                },
                {field:'audObjectNames',title:'审计单位', width:'25%',align:'left',   halign:'center',  sortable:true, show:'false',
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                },
                {field:'agencyNames',title:'中介机构', width:'30%',align:'left',   halign:'center',  sortable:true, show:'false',hidden:!isSearch,
					formatter:function(value,row,index){
						return value ? "<label title='"+value+"'>"+value+"</label>" : "";
					}
                }
          ]]
        }
    });
    
    window.dvAudProjectList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
    isView || apStatusCode > 1 ? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
    
    function formatterTime2Date(value){
    	var rt = value;
    	if(value && value.length > 10){
    		rt = value.substr(0,10);
    	}	
    	return rt;
    }
    
    function formatterClick(value){
    	var t = tabTitle || "查看";
    	return  ["<label title='单击"+t+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }

    // 响应提交按钮
    function postAp(paramStatusCode){
    	try{
    		//alert('paramStatusCode='+paramStatusCode)
    		var isPostOrRetreat = paramStatusCode == '1' || paramStatusCode == '2' ? true : false;
    		var checkFields = isPostOrRetreat ? ['apId','proId'] : ['apId','proId','proHeaderId'];
    		var datajson = aud$getCheckRowData(gridTableId, checkFields);
    		if(!datajson) return ;
    		if(!isPostOrRetreat && datajson.apId.length != datajson.proHeaderId.length){    			
	    		showMessage1("部分项目数据不完整，请单击项目名称完善项目信息！");
	    		$('#'+gridTableId).datagrid("uncheckAll");
	    		return;
    		}
    		var idArr = datajson ? datajson.apId : null;
    		var proIdArr = datajson ? datajson.proId : null;
    		/* 只对项目实施完成阶段进行台账和审计结论校验 */
    		if(paramStatusCode == '4') {
    			var rtData = isComplete(idArr);
				var confirmMsg = rtData.isComplete ? '项目完成后，项目台账和审计结论将不能再录入！' : '【'+rtData.audProjectName+'】项目台账或审计结论信息不完整，确认要完成吗？';
				top.$.messager.confirm('确认', confirmMsg, function(r){
					r ? submitAp(idArr, proIdArr, paramStatusCode) : null;
				});
    		}else {
    			submitAp(idArr, proIdArr, paramStatusCode);
    		}
    	}catch(e){
    		alert('postAp:'+e.message);
    	}
    }
    
    //项目是否可以“完成”，检查项目的完整性，台账和结论是否填写
    function isComplete(idArr){
    	var rt = {};
    	if(idArr == null || idArr.length == 0){
    		rt.errMsg = "请选择记录";
    		rt.isComplete = false;
    	}else{   		
			$.ajax({
				url:"${contextPath}/ea/dvAudProject/validatePro.action",
				type:"post",
				data: {
					'apIds' :idArr.join(",")
				},
				async: false,
				dataType:"json",
				beforeSend:function(){
					if(idArr && idArr.length){
						aud$loadOpen();
						return true;
					}else{
						showMessage1('请选择要提交的记录！');
						return false;
					}
				},
				success: function(data){
					aud$loadClose();
					rt = data;
				},
				error:function(data){
					aud$loadClose();
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
    	}
		return rt;
    }
    
    function aud$getCheckRowData(gridId, attrArr){
    	if(!gridId || !attrArr) return null;
    	var rtjson = {};
    	var attrArrlen = attrArr.length;
    	for(var n=0; n<attrArrlen; n++){
    		rtjson[attrArr[n]] = [];
    	}
    	var rows = $('#'+gridId).datagrid('getChecked');
    	if(rows && rows.length > 0){
			var rowlen = rows.length;
			
            for(var i=0; i<rows.length; i++){
                var rowData = rows[i];
                for(var j=0; j<attrArrlen; j++){
                	var attr = attrArr[j];
                	var value = rowData[attr];
                	if(value){
						rtjson[attr].push(value);
                	}else{
                		showMessage1(rowData.audProjectName + "数据不完整，请单击项目名称完善项目信息！");
        	    		$('#'+gridTableId).datagrid("uncheckAll");
        	    		var rowIndex = $('#'+gridTableId).datagrid("getRowIndex", rowData);
        	    		$('#'+gridTableId).datagrid("selectRow", rowIndex);
        	    		return;
                	}
                }
            }
    	}
    	return rtjson;
    }

});
    //项目提交/受理/完成
    function submitAp(idArr,proIdArr,paramStatusCode){
    	$.ajax({
			url : "${contextPath}/ea/dvAudProject/postAp.action",
			type: "post",
			data: {
				'apIds' :idArr.join(","),
				'proIds':proIdArr.join(","),
				'apStatusCode':paramStatusCode
			},
			dataType:'json',	
			beforeSend:function(){
				if(idArr && idArr.length){
					aud$loadOpen();
					return true;
				}else{
					showMessage1('请选择要提交的记录！');
					return false;
				}
			},
			success: function(data){
				data.msg ? showMessage1(data.msg) : null;	
				if(data.type == 'info'){
					try{						
						//刷新我的项目
						var homeIfm = aud$getTabIframByTabId('home');
						if(homeIfm && homeIfm.projectAuditFirstPage){
	   						homeIfm.projectAuditFirstPage.myProjectTable();
						}
					}catch(e){
						//alert(e.message);
					}
					window.dvAudProjectList.refresh();					
				}
				aud$loadClose();;        
			},
			error:function(data){
				aud$loadClose();;
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
    }
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='dvAudProjectList'></table>
	
   <!-- 自定义查询条件  -- 审计类型 -->
   <div id='queryCond0'>
		<select name='query_eq_apStatusCode' style='background: transparent;border: 1px solid #ccc;' 
			panelHeight="120px" editable=false class="easyui-combobox">
			<option value='' selected>全部</option>
			<option value='1'>草稿</option>
			<option value='2'>已送审</option>
			<option value='3'>已受理</option>
			<option value='4'>已完成</option>
		</select>
   </div>
   <div id='queryCond1'>
		<input type='text' class="noborder clear" readonly/>
		<input type='hidden'  name='query_eq_audTypeCode' class="noborder clear" readonly/>
		<a  class="easyui-linkbutton" iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
				  title:'审计类型选择',
                  onlyLeafClick:true,
				  param:{
					'plugId':'6001',
				    'whereHql':'type=\'6001\'',
				    'customRoot':'审计类型',
				  	'rootParentId':'0',
                    'beanName':'CodeName',
                    'treeId'  :'id',
                    'treeText':'name',
                    'treeParentId':'pid',
                    'treeOrder':'name'
                  }
		})"></a>
   </div>
   <div id='queryCond2'>
 		<input type='text'  name='query_mtq_audCost' class="noborder clear" style='width:90px;'/> 至 
 		<input type='text'  name='query_ltq_audCost' class="noborder clear" style='width:90px;'/>
   </div>
   <div id='queryCond3'>
 		<input type='text'  name='query_mtq_approvalCost' class="noborder clear"  style='width:90px;'/> 至 
 		<input type='text'  name='query_ltq_approvalCost' class="noborder clear"  style='width:90px;'/>
   </div> 
   <div id='queryCond4'>
 		<input type='text'  name='query_mtq_audDate' class="easyui-datebox noborder clear" editable="false" style='width:100px;'/> 至 
 		<input type='text'  name='query_ltq_audDate' class="easyui-datebox noborder clear" editable="false" style='width:100px;'/>
   </div>
   <div id='queryCond5'>
		<input type='text' class="noborder" readonly/>
		<input type='hidden'  name='query_in_audUnitId'  class="noborder" readonly/>
		<a class="easyui-linkbutton" iconCls="icon-search" style='border-width:0px;'
			  onclick="showSysTree(this,{
                 title:'送审单位选择',
                 checkbox:true,
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
   <!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>