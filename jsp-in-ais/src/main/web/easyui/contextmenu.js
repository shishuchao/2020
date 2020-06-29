/**
 *
 * @requires jQuery,EasyUI
 *
 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中
 */
var createGridHeaderContextMenu = function(e, field) {
	e.preventDefault();
	var grid = $(this);/* grid本身 */
	var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	if (!headerContextMenu) {

		// 根据数据库保存的表格列设置，初始化grid的列；
		var gridId = grid.attr('id');
		audGcs$init(gridId);
		var gridColSet = $('#'+gridId).data('gridColSet');
		var isHaveColSet = gridColSet != null;

		var tmenu = $('<div style="width:180px;"></div>').appendTo('body');
		var fields = grid.datagrid('getColumnFields');
		for (var i = 0; i < fields.length; i++) {
			var curField = fields[i];
			var fildOption = grid.datagrid('getColumnOption', fields[i]);
			// 复选框和操作列跳过
			if(!fildOption.title || fildOption.checkbox || fildOption.operate || fildOption.field == 'operate'){
				continue;
			}

			var iconCls = "icon-ok";
			if(isHaveColSet && gridColSet[curField]){
				var colSet = gridColSet[curField];
				iconCls = colSet && colSet.status == '1' ? 'icon-ok' : 'icon-empty';
			}else{
				if(fildOption.hidden){
					iconCls = "icon-empty";
				}
			}
			$('<div iconCls="'+iconCls+'" field="' + curField + '"/>')
				.html(fildOption.title).appendTo(tmenu);
		}
		//$('<div iconCls="icon-cancel" field="menuClose"/>').html('关闭').appendTo(tmenu);

		headerContextMenu = this.headerContextMenu = tmenu.menu({
			onClick : function(item) {
				var status = "1";
				var field = $(item.target).attr('field');
				if (item.iconCls == 'icon-ok') {
					grid.datagrid('hideColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-empty'
					});
					status = "0";
				} else {
					grid.datagrid('showColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-ok'
					});
					status = "1";
				}

				if(field != "menuClose"){
					var eX = headerContextMenu.data("menuEx");
					var eY = headerContextMenu.data("menuEy");
					headerContextMenu.menu('show', {
						left: eX ? eX : e.pageX,
						top : eY ? eY : e.pageY
					});

					try{
						// 保存列设置
						var colWidth = audGcs$getColWidth(gridId, field);
						colWidth = new String(colWidth).replace("px","");
						colWidth = parseFloat(colWidth).toFixed(2);
						audGcs$saveGridSet($(grid).attr('id'), field, status, colWidth);
					}catch(e){
						alert("onContextMenu:\n"+e.message);
					}

				}
			}
		});
	}

	var eX = e.pageX;
	var eY = e.pageY;
	headerContextMenu.data("menuEx",eX);
	headerContextMenu.data("menuEy",eY);
	headerContextMenu.menu('show', {
		left: eX,
		top : eY
	});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.datagrid.defaults.onRowContextMenu = createGridHeaderContextMenu;

//将表单数据转为json
function form2Json(id) {

	var arr = $("#" + id).serializeArray();
	var jsonStr = "";

	jsonStr += '{';
	for (var i = 0; i < arr.length; i++) {
		jsonStr += '"' + arr[i].name + '":"' + arr[i].value + '",'
	}
	jsonStr = jsonStr.substring(0, (jsonStr.length - 1));
	jsonStr += '}';

	var json = eval("("+jsonStr+")");
	return json;
}
//重置表单
function resetForm(formId){
	$("#" + formId + " input").each(function () {
		if(($(this).attr('reload')!='false') && ($(this).attr('disabled')!='disabled'))
			$(this).val('');
	});
	$("#" + formId + " select").each(function () {
		if (!$(this).combobox('options').readonly && !$(this).combobox('options').disabled)
			$(this).combobox('setValue', '');
	});
}

$.extend($.fn.datagrid.methods, {
	/**
	 * 开打提示功能（基于1.3.3+版本）
	 * @param {} jq
	 * @param {} params 提示消息框的样式
	 * @return {}
	 */
	doCellTip:function (jq, params) {
		function showTip(showParams, td, e, dg) {
			//无文本，不提示。
			if ($(td).text() == "") return;
			params = params || {};
			var options = dg.data('datagrid');
			var styler = 'style="';
			if(showParams.width){
				styler = styler + "width:" + showParams.width + ";";
			}
			if(showParams.maxWidth){
				styler = styler + "max-width:" + showParams.maxWidth + ";";
			}
			if(showParams.minWidth){
				styler = styler + "min-width:" + showParams.minWidth + ";";
			}
			styler = styler + '"';
			showParams.content = '<div class="tipcontent" ' + styler + '>' + showParams.content + '</div>';
			$(td).tooltip({
				content:showParams.content,
				trackMouse:true,
				position:params.position,
				onHide:function () {
					$(this).tooltip('destroy');
				},
				onShow:function () {
					var tip = $(this).tooltip('tip');
					if(showParams.tipStyler){
						tip.css(showParams.tipStyler);
					}
					if(showParams.contentStyler){
						tip.find('div.tipcontent').css(showParams.contentStyler);
					}
				}
			}).tooltip('show');
		};
		return jq.each(function () {
			var grid = $(this);
			var options = $(this).data('datagrid');
			if (!options.tooltip) {
				var panel = grid.datagrid('getPanel').panel('panel');
				panel.find('.datagrid-body').each(function () {
					var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
					$(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td[field]', {
						'mouseover':function (e) {
							//if($(this).attr('field')===undefined) return;
							var that = this;
							var setField = null;
							if(params.specialShowFields && params.specialShowFields.sort){
								for(var i=0; i<params.specialShowFields.length; i++){
									if(params.specialShowFields[i].field == $(this).attr('field')){
										setField = params.specialShowFields[i];
									}
								}
							}
							if(setField==null){
								options.factContent = $(this).find('>div').clone().css({'margin-left':'-50000px', 'width':'auto', 'display':'inline', 'position':'absolute'}).appendTo('body');
								var factContentWidth = options.factContent.width();
								params.content = $(this).text();
								if (params.onlyShowInterrupt) {
									if (factContentWidth > $(this).width()) {
										showTip(params, this, e, grid);
									}
								} else {
									showTip(params, this, e, grid);
								}
							}else{
								panel.find('.datagrid-body').each(function(){
									var trs = $(this).find('tr[datagrid-row-index="' + $(that).parent().attr('datagrid-row-index') + '"]');
									trs.each(function(){
										var td = $(this).find('> td[field="' + setField.showField + '"]');
										if(td.length){
											params.content = td.text();
										}
									});
								});
								showTip(params, this, e, grid);
							}
						},
						'mouseout':function (e) {
							if (options.factContent) {
								options.factContent.remove();
								options.factContent = null;
							}
						}
					});
				});
			}
		});
	},
	/**
	 * 关闭消息提示功能（基于1.3.3版本）
	 * @param {} jq
	 * @return {}
	 */
	cancelCellTip:function (jq) {
		return jq.each(function () {
			var data = $(this).data('datagrid');
			if (data.factContent) {
				data.factContent.remove();
				data.factContent = null;
			}
			var panel = $(this).datagrid('getPanel').panel('panel');
			panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')
		});
	}
});




// ************************************************************************************************

// 获得当前grid的唯一标识
function audGcs$genGridFlag(gridId){
	var gridFlag = null;
	try{
		var pageUrl = window.location.href;
		//alert(pageUrl)
		var index = pageUrl.indexOf("?");
		if(index != -1){
			pageUrl = pageUrl.substr(0, index);
		}
		//alert(pageUrl)
		if(top.encode64 && top.$.md5){
			var curUrl = top.encode64(pageUrl + "@" + gridId + "@");
			gridFlag = top.$.md5(curUrl);
		}
	}catch(e){
		alert("audGcs$genGridFlag:\n"+e.message);
	}
	return gridFlag;
}

// 保存表格列设置
function audGcs$saveGridSet(gridId, col, status, width){
	try{
		var gridFlag = audGcs$genGridFlag(gridId);
		if(gridFlag){
			$.ajax({
				url : "/ais/commonPlug/saveGridCoSet.action",
				dataType:'json',
				type: "post",
				async:false,
				data: {
					'grid.gridFlag':gridFlag,
					'grid.col':col,
					'grid.status':status,
					'grid.width':width
				},
				beforeSend:function(){
					return true;
				},
				success: function(data){
					if(data && data.type == 'info'){

					}
				},
				error:function(data){
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
		}
	}catch(e){
		alert("audGcs$saveGridSet:\n"+e.message);
	}
}

// 查询表格的列
function audGcs$getGridSet(gridId){
	var json = null;
	try{
		var gridFlag = audGcs$genGridFlag(gridId);
		if(gridFlag){
			$.ajax({
				url : "/ais/commonPlug/queryGridCoSet.action",
				dataType:'json',
				type: "post",
				async:false,
				data: {
					'gridFlag':gridFlag
				},
				beforeSend:function(){
					return true;
				},
				success: function(data){
					if(data && data.type == 'info'){
						var colStr = data.colStr;
						var statusStr = data.statusStr;
						var widthStr = data.widthStr;
						if(colStr && statusStr && widthStr){
							var colArr = $.trim(colStr).split(",");
							var statusArr = $.trim(statusStr).split(",");
							var widthArr = $.trim(widthStr).split(",");
							json = {};
							$.each(colArr, function(i, col){
								json[col] = {
									'status':statusArr[i],
									'width':widthArr[i]
								}
							});
							$('#'+gridId).data('gridColSet', json);
						}
					}
				},
				error:function(data){
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
		}
	}catch(e){
		alert("audGcs$getGridSet:\n"+e.message);
	}
	return json;
}

// 设置grid的列的宽度
function audGcs$setColWidth(gridId, fieldName, colWidth){
	try{
		var gridView = $('#'+gridId).parent().find("div[class^='datagrid-view']");
		//alert(fieldName +"="+ colWidth)
		if(fieldName && colWidth && gridView && gridView.length){
			setTimeout(function(){
				if(colWidth.indexOf('px') == -1){
					colWidth = colWidth + "px";
				}
				//alert(fieldName +":colWidth:"+colWidth)
				gridView.find(".datagrid-header td[field= '"+fieldName+"'] div.datagrid-cell").css('width', colWidth);
				gridView.find(".datagrid-body td[field= '"+fieldName+"'] div.datagrid-cell").css('width', colWidth);
			}, 0);
		}
	}catch(e){
		alert("audGcs$setColWidth:\n"+e.message);
	}
}

// 获得grid的列的宽度
function audGcs$getColWidth(gridId, fieldName){
	var w = 150;
	try{
		var gridView = $('#'+gridId).parent().find("div[class^='datagrid-view']");
		if(fieldName && gridView && gridView.length){
			w = gridView.find(".datagrid-header td[field= '"+fieldName+"'] div.datagrid-cell").width();
		}
	}catch(e){
		alert("audGcs$getColWidth:\n"+e.message);
	}
	return w;
}


//表格的列属性初始化
function audGcs$init(gridId){
	try{
		var gridColSet = $('#'+gridId).data('gridColSet');
		if(!gridColSet){
			gridColSet = audGcs$getGridSet(gridId);
		}
		if(gridColSet){
			var gridObj = $('#'+gridId);
			for(var field in gridColSet){
				var colSet = gridColSet[field];
				if(colSet){
					var action = colSet.status == '1' ? "showColumn" : "hideColumn";
					try{

						gridObj.datagrid(action, field);
						// 设置grid的列的宽度
						audGcs$setColWidth(gridId, field, colSet.width);
					}catch(e){

					}
				}
			}
			gridObj.datagrid('resize', {
				'fit':true
			});
		}
	}catch(e){
		alert("audGcs$init:\n"+e.message);
	}
}

$.extend($.fn.datagrid.defaults, {
	onInitFieldSet:function(){
		var gridId = $(this).attr('id');
		audGcs$init(gridId);
		//alert('onInitFieldSet')
	},
	onSortForSetColum:function(){
		var gridId = $(this).attr('id');
		var gridResizeColumn = $(this).attr('gridResizeColumn');
		if(gridResizeColumn){
			//alert('onSortForSetColum, grid:'+gridId)
			$('#'+gridId).removeData('gridColSet');
			$(this).removeAttr('gridResizeColumn');
		}
	},
	onResizeColumn:function(field, width){
		var gridId = $(this).attr('id');
		setTimeout(function(){
			var gridView = $('#'+gridId).parent().find("div[class^='datagrid-view']");
			var headCol = gridView.find(".datagrid-header td[field= '"+field+"'] div.datagrid-cell");
			width = headCol.width();
			gridView.find(".datagrid-body td[field= '"+field+"'] div.datagrid-cell").css('width', width+"px");
			var showFlag = headCol[0].innerText.indexOf('fixHidden')!=-1?"0":"1";
			audGcs$saveGridSet(gridId, field, showFlag, width);
		}, 0)
		$(this).attr('gridResizeColumn', true);
	}
});
//****************************************************************************************************************

$(function(){
});
