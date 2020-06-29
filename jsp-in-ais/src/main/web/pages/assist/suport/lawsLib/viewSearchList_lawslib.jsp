<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>法律法规</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>

	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>

	<SCRIPT type="text/javascript">
        function downloadF(){
            if(mydelCheck()){
                $.messager.confirm('确认','确认下载吗？',function(r){
                    if (r){
                        myform.action="downloadFlfg.action";
                        myform.submit();
                    }else{
                        return false;
                    }
                });
            }else{
                return false;
            }
        }

        function downloadFlfgSort(){
            $.messager.confirm('确认','确认下载吗？',function(r){
                if (r){
                    myform.action="downloadLawSortView.action";
                    myform.submit();
                }else{
                    return false;
                }
            });
        }

        function mydelCheck(){
            var rows=$('#objectList').datagrid('getSelections');
            var j=0;
            var ids="";
            for(var i=0,size=rows.length;i<size;i++){
                ids = ids + rows[i].id+",";
                j=j+1;
            }
            if(j<1){
                $.messager.show({title:'消息',msg:'请先选中记录再进行操作！'});
                return  false;
            }
            document.getElementById("ids").value=ids;
            return true;
        }
        function freshGrid(){
            $('#dlgSearch').dialog('open');
        }
        var searchParam = '';
        function doSearch(){
            searchParam = $("#searchParam").val();
            $('#objectList').datagrid({
                queryParams:form2Json('myform')
            });
            $('#dlgSearch').dialog('close');

        }
        function doCancel(){
            $('#dlgSearch').dialog('close');
        }
        function getItem(url,title,width,height){
    		generateWin('subwindow');
    		$('#item_ifr').attr('src',url);
    		openWin('subwindow',title,width,height);
    	}
        function saveF(){
    		var ayy = $('#item_ifr')[0].contentWindow.saveF();
    		/*var res = ayy[0].split(',');
    		var name = ayy[1].split(',');*/
       			document.all('pro_type_name').value=ayy;
       		closeWin()
    	}
    	function cleanF(){
    		document.all('pro_type_name').value='';
       		closeWin();
    	}
    	function closeWin(){
    		$('#subwindow').window('close');
    	}
        function setNull(name){document.getElementsByName(name)[0].value="";}
        function reset2(){
            setNull("assistSuportLawslib.title");
            setNull("assistSuportLawslib.codification");
            setNull("assistSuportLawslib.promulgationDate");
            setNull("assistSuportLawslib.effctiveDate");
            setNull("assistSuportLawslib.invalidationDate");
            setNull("assistSuportLawslib.promulgationDept");
            setNull("assistSuportLawslib.effective");
            setNull("assistSuportLawslib.content");
        }
        function restal(){
            //reset2();
            resetForm('myform');
        }
	</SCRIPT>
	<style type="text/css">
		div.datagrid-cell {
			text-overflow:ellipsis;
		}

		.datagrid-header-rownumber,.datagrid-cell-rownumber{
			width:30px;
		}
	</style>
</head>
<body class="easyui-layout" style="overflow:hidden;" fit="true" border='0'>
<div id="dlgSearch" class="searchWindow">
	<div class="search_head">
		<s:form action="search" method="post"   id="myform" namespace="/pages/assist/suport/lawsLib">
			<s:hidden name="nodeid"></s:hidden>
			<s:hidden name="ids" id="ids"></s:hidden>
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead" sytle="width:15%">
						法规名称
					</td>
					<td class="editTd" sytle="width:35%">
						<s:textfield cssClass="noborder" name="assistSuportLawslib.title" cssStyle="width:160px;" />
					</td>

					<td class="EditHead" sytle="width:15%">
						文号
					</td>
					<td class="editTd" sytle="width:35%">
						<s:textfield cssClass="noborder" name="assistSuportLawslib.codification"
									 cssStyle="width:160px;" />
					</td>
				</tr>

				<tr >
					<td class="EditHead" sytle="width:15%">
						正文
					</td>
					<td class="editTd" sytle="width:35%">
						<s:textfield id="searchParam" cssClass="noborder" name="assistSuportLawslib.content"
									 cssStyle="width:160px;" />
					</td>
					<td class="EditHead">
						类别
					</td>
					<td class="editTd">
						<div>
							<s:textfield cssClass="noborder" readonly="true" name="assistSuportLawslib.category"  id="pro_type_name" cssStyle="width:150px" />
							<img style="cursor:hand;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								 onclick="getItem('/ais/pages/assist/suport/lawsLib/searchdate_flfg.jsp','选择类别',500,400)"></img>
						</div>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						发文单位
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" cssStyle="width:160px;"
									 name="assistSuportLawslib.promulgationDept" />
					</td>
					<td class="EditHead">
						发文时间
					</td>
					<td class="editTd">
							<%-- <input type="text" editable="false" Class="easyui-datebox noborder"  value="${assistSuportLawslib.promulgationDate}"  name="assistSuportLawslib.promulgationDate"  title="单击选择日期"  Style="width:160px;"/> --%>
						<input name="assistSuportLawslib.promulgationDateStart"
							   type="text" editable="false" class="easyui-datebox" style="width: 110px"/>到
						<input name="assistSuportLawslib.promulgationDateEnd"
							   type="text" editable="false" class="easyui-datebox" style="width: 110px"	/>
					</td>
				</tr>
				<tr >
					<td class="EditHead">
						效力级别
					</td>
					<td class="editTd">
						<select class="easyui-combobox" editable="false" name="assistSuportLawslib.summary" style="width:80%;"  data-options="panelHeight:75">
							<option value="">&nbsp;</option>
							<s:iterator value="basicUtil.effectiveLevelList" id="entry">
								<s:if test="${assistSuportLawslib.summary==code}">
									<option selected="selected" value="${code }">${name}</option>
								</s:if>
								<s:else>
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:else>
							</s:iterator>
						</select>
					</td>
					<td class="EditHead">
						时效性
					</td>
					<td class="editTd">
						<select class="easyui-combobox" editable="false" name="assistSuportLawslib.effective" style="width:80%;" editable="false" data-options="panelHeight:75">
							<option value="">&nbsp;</option>
							<s:iterator value="#@java.util.LinkedHashMap@{'有效':'有效','无效':'无效'}" id="entry">
								<option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select>
					</td>
				</tr>
				<s:if test="m_view!=null&&m_view=='view'">
					<input type="hidden" name="assistSuportLawslib.pub_state" value="Y">
				</s:if>
				<s:hidden name="assistSuportLawslib.categoryFk"></s:hidden>
			</table>
			<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
			<s:hidden name="m_view" value="view"></s:hidden>
		</s:form>
	</div>
	<div class="serch_foot">
		<div class="search_btn">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
		</div>
	</div>
</div>
<div region="center" border='0'>
	<table id="objectList"></table>
</div>
<script type="text/javascript">

    function viewInfo(curId){
        var myurl = '${contextPath}/pages/assist/suport/lawsLib/edit.action?m_view=true&assistSuportLawslib.id='+curId+'&nodeid=${nodeid}&m_str=${m_str}&marked=0'
        $("#myFrame").attr("src",myurl);
        $('#objectList').datagrid("reload");
        $('#myView').window('open');
    }
    function viewContext (curId){
        var keywords = $("#fulltext1").val();//全文检索关键字
        var url = '${contextPath}/pages/assist/suport/lawsLib/viewContext.action?id='+curId+'&content='+encodeURI(searchParam)+'&keywords='+encodeURI(keywords)+'';
        $("#contextFrame").attr("src",url);
        $("#viewContext").window('open');
    }
    var nodeid=$("input[name=nodeid]").val();
    $(function(){
        showWin('dlgSearch');
        var bodyW = $('body').width();
        $('#objectList').datagrid({
            url : "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?querySource=grid&mCodeType=${mCodeType}&fristType=${fristType}&m_view=view&nodeid="+nodeid,
            method:'post',
            showFooter:false,
            rownumbers:true,
            pagination:true,
            striped:true,
            autoRowHeight:false,
            fit: true,
            fitColumns:false,
            idField:'id',
            border:false,
            singleSelect:false,
            pageSize:50,
			pageList:[50,100,150,200],
            remoteSort: false,
			onLoadSuccess: function() {
				var value = $('#fullText').val();
				if(typeof(value) == 'undefined') {
					$("<table><tr><td style='padding:0 8px'><label>全文检索:</label></td><td><input id='fullText' name='fullText'></td></tr></table>").prependTo($(this).datagrid('getPanel').find(".datagrid-toolbar"));
					$('#fullText').searchbox({
						width : 180,
						searcher : fulltextSearch,
						prompt : '请输入内容'
					});
					$('#objectList').datagrid('reload');
				}
				var fulltext = $('#fulltext1').val();
				$('#fullText').searchbox('setValue',fulltext);

				var options = $(this).datagrid('options');
				var maxRowNumber = options.pageSize * options.pageNumber;
				$($(this).datagrid('getPanel')).find('.datagrid-header-rownumber,.datagrid-cell-rownumber').width(maxRowNumber.length() * 8 + 30);
			},
			 toolbar:[
				 /*
                {
                     id:'search',
                     text:'查询',
                     iconCls:'icon-search',
                     handler:function(){
                         searchWindShow('dlgSearch',750);
                     }
                 }
                 ,
                 {
                     id:'toZip',
                     text:'下载',
                     iconCls:'icon-download',
                     handler:function(){
                         downloadF();
                     }
                 },
                 {
                     id:'toDownloadFTP',
                     text:'下载全部法规',
                     iconCls:'icon-download',
                     handler:function(){
                         downloadZIP();
                     }
                 }*/
			 ],
            frozenColumns:[[
                {field:'id',width:'50px', hidden:true, align:'center'},
                {field:'title',title:'名称',width:bodyW*0.15+'px',halign:'center',align:'left',sortable:true,
                    formatter:function(value,row,rowIndex){
                        return '<a href=\"javascript:void(0)\" onclick=\"viewContext(\''+row.id+'\');\">'+row.title+'</a>';
                    }
                },
                {field:'codification',
                    width:bodyW*0.12+'px',
                    title:'文号',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    formatter:function(value,row,index){
                        return row.codification;
                    }
                },
                {field:'category',
                    width:bodyW*0.12+'px',
                    title:'类别',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    formatter:function(value,row,index){
                        return row.category;
                    }
                }

            ]],
            columns:[[
                {field:'promulgationDept',
                    title:'发文单位',
                    width:bodyW*0.1+'px',
                    halign:'center',
                    align:'left',
                    sortable:true,
                    formatter:function(value,row,rowIndex){
                        return row.promulgationDept;
                    }
                },

                {field:'promulgationDate',
                    title:'发文时间',
                    width:bodyW*0.1+'px',
                    sortable:true,
                    halign:'center',
                    align:'center',
                    formatter:function(value,row,rowIndex){
                        if(row.promulgationDate!=null){
                            return row.promulgationDate.substring(0, 10);
                        }
                    }
                },
                {field:'effctiveDate',
                    title:'实施日期',
                    width:bodyW*0.1+'px',
                    sortable:true,
                    halign:'center',
                    align:'center',
                    formatter:function(value,row,rowIndex){
                        if(row.effctiveDate!=null){
                            return row.effctiveDate.substring(0, 10);
                        }
                    }
                },
                {field:'effective',title:'时效性',width:bodyW*0.1+'px',sortable:true,align:'center',
                    formatter:function(value,row,index){
                        return row.effective;
                    }
                },
                {field:'summary',title:'效力级别',width:bodyW*0.1+'px',sortable:true,align:'center',
                    formatter:function(value,row,index){
                        return row.summary;
                    }
                },


                /*{field:'effctiveDate',
                     title:'生效日期',
                     width:80,
                     halign:'center',
                     align:'right',
                     sortable:true,
                     formatter:function(value,row,rowIndex){
                        if(row.effctiveDate!=null){
                            return row.effctiveDate.substring(0, 10);
                        }
                }
                },*/
                {field:'sundept',
                    title:'创建单位',
                    width:bodyW*0.1+'px',
                    halign:'center',
                    align:'right',
                    sortable:true,
                    formatter:function(value,row,index){
                        return row.sundept;
                    }
                },
                {field:'createDate',
                    title:'创建时间',
                    width:bodyW*0.1+'px',
                    halign:'center',
                    align:'center',
                    sortable:true,
                    formatter:function(value,row,index){
                        if(row.createDate!=null){
                            return row.createDate.substring(0, 10);
                        }
                    }
                }

                /*	{field:'hitCount',
                         title:'点击次数',
                         width:80,
                         halign:'center',
                         align:'right',
                         sortable:true
                    },
                    {field:'operate',
                         title:'操作',
                         width:80,
                         align:'center',
                         sortable:false,
                         formatter:function(value,row,index){
                             return  '<a href=\"javascript:void(0)\" onclick=\"viewInfo(\''+row.id+'\');\">详细内容</a>'
                         }
                    }*/
            ]]
        });

		$('#objectList').datagrid('doCellTip', {
			onlyShowInterrupt: true,
			position: 'bottom',
			maxWidth: '200px',
			tipStyler: {
				'backgroundColor': '#EFF5FF',
				borderColor: '#95B8E7',
				boxShadow: '1px 1px 3px #292929'
			}
		});
        //初始化增加窗口
        var tempWidth = document.body.clientWidth;
        var tempHeight = document.body.clientHeight;
        $('#myView').window({
            width:tempWidth,
            height:tempHeight,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            resizable:true,
            maximized:true,
            closed:true
        });
        $('#viewContext').window({
            width:tempWidth,
            height:tempHeight,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            resizable:true,
            maximized:true,
            closed:true
        });
        $('#indexView').window({
            modal:true,
            fit:true,
            collapsible:false,
            maximizable:true,
            minimizable:false,
            resizable:true,
            closed:true
        });
    });

    function downloadZIP(){
        $.messager.confirm('确认','下载需要较长时间，可能会影响系统的使用，建议在非使用高峰期下载，是否继续？',function(r){
            if (r){
                var url = '${zipURL}';
                var name;                           //网页名称，可为空;
                var iWidth = '500';                          //弹出窗口的宽度;
                var iHeight = '500';                        //弹出窗口的高度;
                var iTop = (window.screen.availHeight-iHeight)/2;       //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth-iWidth)/2;           //获得窗口的水平位置;
                window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=yes,location=no,status=no');
            }else{
                return false;
            }
        });
    }

    function fulltextSearch(){
		var fulltext = $("#fullText").val();
		$('#fulltext1').val(fulltext);
		$('#objectList').datagrid({
			queryParams:form2Json('fulltextForm')
		});
    }
</script>
<div id="qwjs" style="display: none">
	<table>
		<tr>
			全文检索&nbsp;&nbsp;&nbsp;
			<s:form action="search" namespace="/pages/assist/suport/lawsLib" method="post" id="fulltextForm">
				<s:hidden name="fulltext" id="fulltext1"></s:hidden>
				<s:hidden name="querySource" value="grid"></s:hidden>
				<s:hidden name="m_view" value="edit"></s:hidden>
				<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
				<s:hidden name="marked" value="0"></s:hidden>
				<s:if test="m_view!=null&&m_view=='view'">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'"  name="assistSuportLawslib.pub_state" >Y</a>
				</s:if>
			</s:form>
		</tr>
	</table>	
</div>
<div id="myView" title="法律法规信息查看" style='overflow:hidden;margin:0px;padding:0px;'>
	<iframe id="myFrame" name="myFrame" title="法律法规信息查看" src="" width="100%" height="100%" frameborder="0"></iframe>
</div>
<div id="indexView" title="法律法规正文查询" style='overflow:hidden;margin:0px;padding:0px;'>
	<iframe id="indexFrame" name="indexFrame" title="法律法规正文查询结果" src="" width="100%" height="100%" frameborder="0"></iframe>
</div>
<div id="viewContext" title="查看" style='overflow:hidden;margin:0px;padding:0px;'>
	<iframe id="contextFrame" name="contextFrame" title="法律法规查看" src="" width="100%" height="100%" frameborder="0"></iframe>
</div>
<div id="subwindow" class="easyui-window" title="类别" style="width:500px;height:500px;padding:5px;" closed="true">
			<div class="easyui-layout" fit="true" border="false" style="overflow:hidden;">
				<div region="center" border="false" style="overflow:hidden;">
					<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
				</div>
				<div region="south" border="false" style="text-align:right;padding:5px 0;">
				    <div style="display: inline;" align="right">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"   onclick="saveF()">确定</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-tip'"  onclick="cleanF()">清空</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"   onclick="closeWin()">关闭</a>
				    </div>
				</div>
			</div>
</div>
</body>
</html>