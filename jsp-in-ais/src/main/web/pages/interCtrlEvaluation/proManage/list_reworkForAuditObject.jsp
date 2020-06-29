<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>被评价单位整改反馈列表</title>
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
            //生成datagrid
            var gridTableId = "accountabilityUnitList";
            var g1 = new createQDatagrid({
                // 表格dom对象，必填
                gridObject:$('#'+gridTableId)[0],
                // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
                boName:'EvaluationPlan',
                // 对象主键,删除数据时使用-默认为“id”；必填
                pkName:'formId',
                order :'desc',
                sort  :'createTime',
                whereSql:" formId in (select proId from InterCtrlProblem where accountabilityUnitCode='${deptId}')",
                winWidth:800,
                winHeight:250,
                // 删除前的校验，如果返回true可以删除，否则为false
                beforeRemoveRowsFn:function(rows, datagridObj){
                    return true;
                },
                // 表格控件dataGrid配置参数; 必填
                gridJson:{
                    frozenColumns:[[
                        {field:'epName',title:'项目名称',width:220,halign:'center',align:'left',sortable:true},
                        {field:'proCode',title:'项目编号',width:150,sortable:true,halign:'center',align:'center'},
                    ]],
                    columns:[[
                        {field:'epYear',title:'项目年度',width:100,sortable:true,halign:'center',align:'center',show:false},
                        {field:'proCategory',title:'项目类别',width:150,sortable:true,halign:'center',align:'center',show:false},
                        {field:'principal',title:'评价专岗负责人',width:150,sortable:true,halign:'center',align:'center',show:false},
                        {field:'evaOrgan',title:'内控评价组织者',width:150,sortable:true,halign:'center',align:'center',show:false},
                        {field:'defectAmount',title:'缺陷数量',width:100,sortable:true,halign:'center',align:'center',show:false},
                        {field:'lastFeedbackDate',
                            title:'最近反馈时间',
                            width:150,
                            halign:'center',
                            align:'center',
                            show:false,
                            sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(value!=null){
                                    return value.substring(0,10);
                                }
                            }
                        },
                        {field:'operate',
                            title:'操作',
                            halign:'center',
                            align:'center',
                            show:false,
                            sortable:false,
                            formatter:function(value,row,index){
                                var param = [row.formId,row.status_name];
                                var btn2 = "处理,updateRework,"+param.join(',');
                                return ganerateBtn(btn2);
                            }
                        }
                    ]]
                }
            });

            window.evaluationPlanList = g1;
            // 删除按钮权限
            g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]);
            //导出按钮权限
            g1.batchSetBtn([ {'id':gridTableId+'_export','remove':true} ]);
        });
        function updateRework(id,status){
            window.location.href="/ais/intctet/proManage/auditDeptTabFile.action?project_id="+id+"&wpd_stagecode=rework"
        }
	</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
<table id='accountabilityUnitList'></table>

<!-- 引入公共文件 -->
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>