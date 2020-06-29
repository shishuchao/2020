<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>被审计单位资料维护</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<STYLE type="text/css">
			.datagrid-cell-rownumber {
				height:28px;
			}
		</STYLE>
	</head>
	<script type="text/javascript">
        var isView = "${view}" == true || "${view}" == "true" ? true : false;
        var gridTableId = "templates";
        var editIndex = undefined;
        var categoryId = '${category.categoryId}';
        var categoryCode = '${category.categoryCode}';
        var categoryCNName = '${category.categoryCNName}';
		$(function () {
			//设置编辑或者查看
            isView ?  $('.editElement').remove() : $('.viewElement').remove();

            // 结束编辑
            function endEditing(){
                if(editIndex == undefined){return true}
                if($('#'+gridTableId).datagrid('validateRow', editIndex)){
                    $('#'+gridTableId).datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                }else{
                    return false;
                }
            }

            //曾删行保存时校验数据是否完整
            function aud$validRows(gridId){
                var rt = true;
                if(gridId){
                    var rows = $('#'+gridId).datagrid('getRows');
                    var rowLen = rows.length;
                    for(var i = 0; i < rowLen; i++){
                        var ed = $('#'+gridId).datagrid('selectRow', i).datagrid('beginEdit', i);
                        if(ed){
                            $(ed.target).select().focus();
                        }
                        if(!$('#'+gridId).datagrid('validateRow', i)){
                            editIndex = i;
                            rt = false;
                            break;
                        }
                        $('#'+gridId).datagrid('endEdit', i);
                    }
                }
                return rt;
            }

            //编辑and选中
            function editAndSelect(index, field){
                try{

                    $('#'+gridTableId).datagrid('selectRow', index).datagrid('beginEdit', index);

                    var ed = $('#'+gridTableId).datagrid('getEditor', {index:index,field:field});
                    if(ed){
                        $(ed.target).select().focus();
                    }
                    //记录上一次的编辑的行，用于endEditing点击一个新行时，结束上次行的编辑
                    editIndex = index;
                }catch(e){
                    alert('editAndSelect:\n'+e.message);
                }
            }

            function addRows(){
                if(categoryId == ''){
                    showMessage1('请先保存资料分类再增加资料模板！');
                }else {
                    var uuids = [];
                    $.ajax({
						url:'${contextPath}/auditobject/material/generateUUID.action',
						async:false,
						type:'post',
						data:{
						    'count':2
						},
						dataType:'json',
						success:function (ret) {
						    if(ret && ret.uuids){
						        uuids = ret.uuids;
                            }
                        }
					});
                    var row = {
                        'categoryCNName':categoryCNName,
                        'categoryCode':categoryCode,
						'status':0,
						'cnTemplate':uuids[0],
						'enTemplate':uuids[1]
                    };
                    $('#'+gridTableId).datagrid('appendRow',row);
                }
            }
            //保存修改数据
            function updateRow(rows){
                var sendData = aud$rows2Json("updateRow", rows);
                $.ajax({
                    url : "${contextPath}/auditobject/material/saveMaterialTemplates.action",
                    dataType:'json',
                    type: "post",
                    data: sendData,
                    cache:false,
                    beforeSend:function(){
                        var check = sendData != null ? true : false;
                        if(!check){
                            showMessage1("没有数据发生变化，不需保存");
                        }
                        return check;
                    },
                    success: function(data){
                        data.msg ? showMessage1(data.msg) : null;
                        if(data.type = 'info'){
                            scGridObj.refresh();
                        }
                    },
                    error:function(data){
                        top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
                    }
                });
            }

            function saveTemplates(noMsg){
                if(aud$validRows(gridTableId) && endEditing()){
                    var rows = $('#'+gridTableId).datagrid('getChanges','inserted');
                    var updatedRows = $('#'+gridTableId).datagrid('getChanges','updated');
                    if((rows && rows.length)||(updatedRows && updatedRows.length)){
                        if(updatedRows && updatedRows.length){
                            if(rows && rows.length){
                                rows.concat(updatedRows);
                            }else{
                                rows = updatedRows;
                            }
                        }
                        updateRow(rows);
                        $('#'+gridTableId).datagrid('acceptChanges');
                    }else{
                        noMsg ? "" : showMessage1("数据没有改变！不需保存！");
                    }
                    return true;
                }else{
                    $('#'+gridTableId).datagrid('selectRow', editIndex);
                    showMessage1('表格数据校验未通过', function(){
                        var gridY = QUtil.getElementPos($('#'+gridTableId).parent().get(0)).y;
                        if(gridY){
                            $('#layoutCenter').scrollTop(gridY - 150);
                        }
                    });
                    return false;
                }
            }

            function delTemplates() {
                var rows = $('#' + gridTableId).datagrid('getChecked');
                if(rows && rows.length){
                    top.$.messager.confirm('确认','确定要删除所选的资料模板吗？',function (r) {
                        if(r){
                            var templateIds = [];
                            for(var i = 0;i < rows.length;i++){
                                var row = rows[i];
                                if(row['mid'] != null&&row['mid'] != ''){
                                    templateIds.push(row['mid']);
                                }else{
                                    var rowIndex = $('#' + gridTableId).datagrid('getRowIndex',row);
                                    $('#' + gridTableId).datagrid('deleteRow',rowIndex);
                                }
                            }
                            if(templateIds.length > 0){
                                $.ajax({
                                    url:'${contextPath}/auditobject/material/deleteMaterialTemplates.action',
                                    type:'post',
                                    cache:false,
                                    dataType:'json',
                                    data:{
                                        'templateIds':templateIds.join(',')
                                    },
                                    success:function(data){
                                        showMessage1(data.msg);
                                        scGridObj.refresh();
                                    }
                                });
                            }
                        }
                    });
                }else{
                    showMessage1('请选择要删除的资料模板！');
                }
            }

            var addBtn = {
                text:'新增',
                iconCls:'icon-add',
                handler:function(){
                    addRows();
                }
            };

            var saveBtn = {
                text:'保存',
                iconCls:'icon-save',
                handler:function(){
                    saveTemplates(false);
                }
            };

            var delBtn = {
                text:'删除',
                iconCls:'icon-delete',
                handler:function(){
                    delTemplates();
                }
            };

            if(categoryId != '0'){
				var cusToolbar = isView ? [] : [addBtn,'-',saveBtn,'-',delBtn];
				window.scGridObj = new createQDatagrid({
					// 表格dom对象，必填
					gridObject:$('#'+gridTableId)[0],
					// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
					boName:'AuditObjectMaterialTemplate',
					// 对象主键,删除数据时使用-默认为“id”；必填
					pkName:'mid',
					order :'asc',
					sort  :'createTime',
					winWidth:500,
					winHeight:250,
					myToolbar:[],
					associate:true,
					//定制查询
					whereSql: " categoryCode='${category.categoryCode}'",
					gridJson:{
						title:'资料清单',
						pageSize:10,
						singleSelect:true,
						checkOnSelect:false,
						selectOnCheck:false,
						border:0,
						fit:true,
						toolbar:cusToolbar,
						onClickCell:function(index, field){
                            if(!isView && (field != 'mid')){
                                if(endEditing()){
                                    editAndSelect(index, field);
                                }else{
                                    $('#'+gridTableId).datagrid('selectRow', editIndex);
                                }
                            }
						},
/*						frozenColumns:[[
                            {field:'mid',    	   title:"选择",     width:'5px', align:'center', halign:'center', checkbox:true, show:'false', hidden:isView},
                            {field:'categoryCNName',    title:"所属资料类别",  width:'100px', align:'center', halign:'center',sortable:true}
						]],*/
						columns:[[
							{field:'mid',    	   title:"选择",     width:'5px', align:'center', halign:'center', checkbox:true, show:'false', hidden:isView},
							{field:'categoryCNName',    title:"所属资料类别",  width:'100px', align:'center', halign:'center',sortable:true},
							{field:'cnName',   title:"资料中文名称",  width:'150px', align:'left', halign:'center',sortable:true,
								editor:{type:'validatebox', options:{required:true, validType:'length[1,100]'}} },
							{field:'enName', title:"资料英文名称",  width:'150px', align:'center', halign:'center',
                                editor:{type:'validatebox', options:{validType:'length[1,100]'}}},
							{field:'cnTemplate', title:'参考模板（中文）', width:'200px',align:'left', halign:'center',  sortable:true, show:'false',
								formatter:function(value,row,index){
									return "<div id='fileCNItem"+index+"'></div>";
								}
							},
							{field:'cnOper', title:'参考模板（中文）操作', width:'200px',align:'center',halign:'center',  sortable:true, show:'false',
								hidden:isView,
								formatter:function(value,row,index){
									window.setTimeout(function(){
										$('#triggerCN'+index).linkbutton({
											iconCls: 'icon-upload',
											text:'上传附件'
										});
										initFileUploadPlug('fileCNItem',index, row['cnTemplate'],'triggerCN');
									},50)
									return "<span id='triggerCN"+index+"' style='border-width:0px;'></span>";
								}
							},
                            {field:'enTemplate', title:'参考模板（英文）', width:'200px',align:'left', halign:'center',  sortable:true, show:'false',
                                formatter:function(value,row,index){
                                    return "<div id='fileENItem"+index+"'></div>";
                                }
                            },
                            {field:'enOper', title:'参考模板（英文）操作', width:'200px',align:'center',halign:'center',  sortable:true, show:'false',
                                hidden:isView,
                                formatter:function(value,row,index){
                                    window.setTimeout(function(){
                                        $('#triggerEN'+index).linkbutton({
                                            iconCls: 'icon-upload',
                                            text:'上传附件'
                                        });
                                        initFileUploadPlug('fileENItem',index, row['enTemplate'],'triggerEN');
                                    },50)
                                    return "<span id='triggerEN"+index+"' style='border-width:0px;'></span>";
                                }
                            },
                            {field:'status', title:"状态",  width:'100px', align:'center', halign:'center',
                                editor:{type:'combobox', options:{
                                    	data:${statusJson},
										valueField:'status',
										textField:'statusName',
										editable:false,
										panelHeight:'auto'
									}
                            	},
                                formatter:function(value,row,index){
                                    if(value == 0){
                                        return '启用';
                                    }else if(value == 1){
                                        return '停用';
                                    }
                                }
                            }
						]]
					}
				});
				//初始化上传文件控件
                function initFileUploadPlug(prefix,index, attachmentId,triggerPrefix){
                    $('#'+prefix+index).fileUpload({
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
                        triggerId:triggerPrefix+index,
                        isDel:!isView,
                        isEdit:!isView
                    });
                }
			}

        });


        function editMaterialCategory(){
		    if('${category.categoryId}' != 0){
                var rows = $('#templates').datagrid('getRows');
                if(rows && rows.length){
                    showMessage1('存在资料模板的分类不可增加下级分类！');
                    return;
                }else{
                    window.location.href = '${contextPath}/auditobject/material/editMaterialCategory.action?parentId=${category.categoryId}&parentCode=${category.categoryCode}';
                }
            }else{
                window.location.href = '${contextPath}/auditobject/material/editMaterialCategory.action?parentId=${category.categoryId}&parentCode=${category.categoryCode}';
            }

        }
        
        function delMaterialCategory() {
			top.$.messager.confirm('确认','删除分类将删除其下所有资料模板，确认删除吗？',function (r) {
				if(r){
				    $.ajax({
						url:'${contextPath}/auditobject/material/deleteMaterialCategory.action',
						type:'post',
						data:{
						    'categoryId':'${category.categoryId}',
						    'categoryCode':'${category.categoryCode}'
						},
						dataType:'json',
						success:function (ret) {
                            showMessage1(ret.msg)
							if(ret.type == 'info'){
							    parent.location.reload();
                            }
                        }
					})
				}
            });
        }

        function saveCategory(){
            aud$saveForm("myform",'${contextPath}/auditobject/material/saveMaterialCategory.action',function (data) {
                if(data.type == 'info'){
                    showMessage1(data.msg);
                    parent.aud$locationLeftTreeNode(data['categoryId']);
                    window.location.href = '${contextPath}/auditobject/material/editMaterialCategory.action?category.categoryId='+data['categoryId'];
                }else{
                    showMessage1(data.msg);
                }
            });
        }
	</script>
	<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border='false'>
		<div region="north" data-options="border:false,height:'80px',collapsible:false">
			<s:form id="myform" action="saveMaterialCategory" namespace="/auditobject/material">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width: 15%">
							<label style="color: red;">*</label>资料类别中文名称
						</td>
						<td class="editTd" style="width: 35%">
							<s:textfield  cssClass="noborder editElement required clear" id="category_categoryCNName"  name="category.categoryCNName" maxlength="100"></s:textfield>
							<span id='view_categoryCNName' class="noborder viewElement clear" >${category.categoryCNName}</span>
						</td>
						<td class="EditHead" style="width: 15%" nowrap="nowrap">
							资料类别英文名称
						</td>
						<td class="editTd" style="width: 35%">
							<s:textfield  cssClass="noborder editElement clear" id="category_categoryENName" name="category.categoryENName"></s:textfield>
							<span id='view_categoryENName' class="noborder viewElement clear" >${category.categoryENName}</span>
						</td>
					</tr>
					<s:hidden name="category.categoryId" id="category_categoryId"/>
					<s:hidden name="category.parentId" id="category_parentId"/>
					<s:hidden name="category.parentCode" id="category_parentCode"/>
				</table>
				<c:if test="${view ne 'true'}">
					<div style="text-align:right;padding:5px;">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-add'"  onclick="editMaterialCategory();" id="addBtn">新增分类</a>&nbsp;&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="saveCategory();">保存分类</a>&nbsp;&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-remove'"  onclick="delMaterialCategory();">删除分类</a>&nbsp;&nbsp;
					</div>
				</c:if>
			</s:form>
		</div>
		<div region="center" data-options="border:false">
			<table id="templates"></table>
		</div>
	</body>
</html>