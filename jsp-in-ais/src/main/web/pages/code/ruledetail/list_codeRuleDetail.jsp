<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<s:text id="title" name="'编号规则评细定义'"></s:text>
		<title><s:property value="#title" />规则详细定义页面</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<%--		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>--%>
		<script type="text/javascript">
			//HashMap对象定义
	        var hashMap = {  
		        Set : function(key,value){this[key] = value},  
		        Get : function(key){return this[key]?this[key]:null},  
		        Contains : function(key){return this.Get(key) == null?false:true},  
		        Remove : function(key){delete this[key]}  
	        }
        
        	function init(){
         		//var chk = document.getElementsByName("ids");
           		var chk=$("#its").datagrid("getRows");
         		for (i = 0; i < chk.length; i++) {
            		var formula= chk[i].d_field_name+"&"+chk[i].test_value;
            		var formulas= formula.split('&');
           			if(hashMap.Contains(formulas[0])){
              			hashMap.Remove(formulas[0]);
              			
            		}
           			hashMap.Set(formulas[0],formulas[1]);
           		}
        	}            
			function batch_submit(ids){
				var chk =$("#its").datagrid("getSelections");
	     		var a=1;
			     //公式显示名称
			    var f_name='';
			     //公式测试值
			    var f_value='';
			    for (i = 0; i < chk.length; i++) {
				    var formula=chk[i].d_field_name+"&"+chk[i].test_value;
				    var formulas= formula.split('&');
					    hashMap.Set(formulas[0],formulas[1]);
					    f_name+='<'+'%'+formulas[0]+'%'+'>';
					    f_value+=formulas[1];
						a=0;
			    }
	       		if( chk.length==0){
	         		showMessage1('请选择!');
	         		return false;
	       		}
	    		document.getElementsByName('codeRule.rule_formula')[0].value=f_name;
			}
	
	
			function testvule(){
				
				init();
				//var testStr=$("#its").datagrid("getSelections");
			  	var testStr= document.getElementsByName('codeRule.rule_formula')[0].value;
		      	var re = /[<]%([^%]*)%[>]/;    
		     	var r = "";    
		      	while(r = re.exec(testStr)) {
		          	var test= hashMap.Get(r[1]);  
			      	testStr = testStr.replace(r[0],test);
		         	} 
		      		showMessage1(testStr);
			}
	
			function cancel(){
			  	document.getElementsByName('codeRule.rule_formula')[0].value="";
			}
			//修改
			function editCodeRule(id){
				window.location.href='<%=request.getContextPath()%>/code/ruledetail/codeRuleDetail/edit.action?id='+id+'&rule_id=${rule_id}&isTZS=${isTZS}&isReadOnlyType=${isReadOnlyType}';
			}
			//删除
			function delCodeRule(ids){
				$.messager.confirm('提示信息', '您确定要删除吗?', function(isDel){
					if(isDel){
		    			window.location="/ais/code/ruledetail/codeRuleDetail/delete.action?ids="+ids+"&rule_id=${rule_id}";
		    		}
		    	});
			}
			function dosubmit(){
				document.getElementById("myform").action = "saveCodeRule.action?isTZS=${param.isTZS}&isReadOnlyType=${param.isReadOnlyType}";
				document.getElementById("myform").submit();
			}
		</script>
	</head>
	<body class="easyui-layout" >
	<div region="north" style="height:130px;">
			<s:form id="myform" action="saveCodeRule"
				namespace="/code/ruledetail/codeRuleDetail">
				<table cellpadding=1 cellspacing=1 border=1 align="center" class="ListTable">
					<tr>
						<td class="editTd" cssStyle="width:90%">
							<s:textarea cssClass="noborder" name="codeRule.rule_formula" cssStyle="width:600px;height:100px;"></s:textarea>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-cut'"  name="ass1" onclick="cancel();">清除</a>&nbsp;&nbsp;
							<s:if test="${param.isReadOnlyType ne true}">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  name="ass2" onclick="testvule();">测试</a>&nbsp;&nbsp;
							</s:if>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"  name="ass2" onclick="dosubmit();">保存</a>&nbsp;&nbsp;
							<s:hidden name="rule_id" value="${rule_id}"></s:hidden>
						</td>
					</tr>
				</table>
			</s:form>
		</div>
			
			
	<div region="center" >
		<table id="its"></table>
	</div>
			
		
		
		<script type="text/javascript">
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/code/ruledetail/codeRuleDetail/list.action?querySource=grid&rule_id=${rule_id}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
						id:'submitButton',
						text:'选择',
						iconCls:'icon-edit',
						handler:function(){
							batch_submit('ids');
						}
					}
					<s:if test="${param.isReadOnlyType ne true}">
					,'-',{
						id:'add',
						text:'添加',
						iconCls:'icon-add',
						handler:function(){
							window.location='<%=request.getContextPath()%>/code/ruledetail/codeRuleDetail/edit.action?id=0&rule_id=${rule_id}&isTZS=${isTZS}&isReadOnlyType=${isReadOnlyType}';
							}
					},'-',{
						id:'add',
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							var ids = new Array();
							var rows = $('#its').datagrid("getChecked");
							for(i in rows) {
								ids.push(rows[i].id);
							}
							if(ids.length > 0) {
								delCodeRule(ids.join(","));
							} else {
								showMessage1("请选择数据！");
							}
						}
					}
					</s:if>
					,'-',{
						id:'backList',
						text:'返回',
						iconCls:'icon-undo',
						handler:function(){
							<%--if(${rule_id=='1'}){--%>
							if(${param.isTZS=='false'}){
								window.location='<%=request.getContextPath()%>/code/rule/codeRule/listYear.action';
							}else{
								window.location='<%=request.getContextPath()%>/code/rule/codeRule/list.action';
							}
						}
					}
				],
				onClickCell:function(rowIndex, field, value) {
					if(field == 'd_field_name') {
						var rows = $('#its').datagrid('getRows');
						var row = rows[rowIndex];
						editCodeRule(row.id);
					}
				},
				frozenColumns:[[
				       			{field:'id',width:'50px', checkbox:true, halign:'center',align:'center',title:'主键'},
				       			{field:'d_field_name',title:'编码字段名',width:'80px',halign:'center',align:'left',sortable:true,
									formatter:function(value,rowData,rowIndex){
										var result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
										return result;
									}
								},
				       			{field:'d_field_value',title:'值',width:'130px',sortable:true,halign:'center',align:'left'}
				    		]],
				columns:[[  
					{field:'d_field_type',
							title:'编码类型',
							width:80,
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'d_table_name',
						title:'字段',
						width:130,
						halign:'center',
						sortable:true, 
						align:'left'
					}
					<s:if test="${param.isReadOnlyType ne true}">
					,{field:'d_function',
						 title:'函数',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true
					},
					{field:'d_comparesign',
						 title:'比较符',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true
					},
					{field:'d_compare_value',
						 title:'比较值',
						 width:100,
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},{field:'d_digit',
						 title:'位数',
						 width:100,
						 halign:'center', 
						 align:'right', 
						 sortable:true
					},{field:'test_value',
						 title:'测试值',
						 width:100,
						 halign:'center', 
						 align:'left', 
						 sortable:true
					}/*,
					{field:'operate',
						 title:'操作',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
							 //return '<a href="<%=request.getContextPath()%>/code/ruledetail/codeRuleDetail/edit.action?id='+row.id+'&rule_id=${rule_id}">修改</a>&nbsp&nbsp<a href="javascript:deleteById(\''+row.id+'\',\'${rule_id}\')">删除</a>&nbsp;&nbsp';
						 	var param = [row.id];
							var btn2 = "修改,editCodeRule,"+param.join(',')+"-btnrule-删除,delCodeRule,"+param.join(',');
							return ganerateBtn(btn2);
						 }
					}*/
					</s:if>
				]]   
			}); 
			init();
		});
	</script>	
	</body>
</html>
