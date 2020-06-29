/*
通用excel导入后，解析，校验后的保存到对应的数据表 
@Version:1.0
@Date   :2017.03.24
@Author :qfucee  
1.初始版本

@Version:1.2
@Date   :2017.03.27
@Author :qfucee  
1. 添加属性topWin： true/false, 默认true
是否把弹出窗口显示在最顶层window，如果多层嵌套时，操作区域会太小

@Version:1.3
@Date   :2017.03.28
@Author :qfucee
1.webapp_index引入ajaxloading.js，excel导入时（特别是文件比较大，导入时间比较长时），折叠导入选择窗口，显示进度条
成功后，关闭进度条.如果没有引进此文件，则使用其它提示语句。

*/

(function($){
	var isdebug = true; 
    var plugName = "parseExcel";
    var parseExcel = $.fn.parseExcel = function(options, param){
		if(typeof options == 'string'){
			return parseExcel.methods[options](this, param);
		}
        options = options || {};
        // 使用return 返回each，是为了方法链能够延续，如:$('#d1').parseExcel('options').attr('isUse') 
        // 把控件当成普通的jquery方法使用即可
        return this.each(function(){
            /*
             *each里面的this为dom对象，包容控件的容器，
             *如：<div id='p1' class='jquery-parseExcel'></div>, p1的dom对象就是this
		     *控件对象以容器dom为key，把控件对象保存到jQuery的上下文件中，这样每次操作时，只对dom对象对应的控件操作
		     *这样一个目标容器就只有一个控件对象，防止多个控件时，互相干扰
             */
             var plugObj = $.data(this, plugName);
             if(plugObj){//如果控件已经初始化过了，把控件配置合并到控件对象的options中
                $.extend(plugObj.options, options);
             }else{
                // 把js初始时的参数配置，容器data-options的配置，控件default的配置，合并在一起，最终已经js配置的优先
                var dataOptions = parseExcel.parseOptions(this);
                //alert(dataOptions.headstart)
				$.data(this, plugName, {//防止defaults被修改，使用一个空的{}对象来接收合并后的参数
					options: $.extend({}, parseExcel.defaults, dataOptions, options)
				});
             }
			 var extendOptions = $.data(this, plugName).options || {};
			 extendOptions.target = this;
			 //alert(extendOptions.triggerId)
			 if(extendOptions){
				isdebug = extendOptions.isdebug;
				// 初始化控件
				init(this, extendOptions);				
			 }
        });
    };
    
    // 对容器里面的属性：data-options 或者老写法的属性 进行解析，返回json格式的参数
	parseExcel.parseOptions = function(target){
		/*
		把控件的默认属性名称，收集起来形成数组，放到parseOptions的解析参数中，
		这样在控件容器中就可以把控件属性作为容器属性
		eg: 标准的这样写，<div class='easyui-fileUpload' data-options="singleSubmit:true"></div>
		把properties进行解析后，就可以使用老式的写法
		<div class='easyui-fileUpload' singleSubmit=true></div>
		*/
		var dopt = parseExcel.defaults;
		var properties = [];
		for(var p in dopt){
			properties.push(p);
		}
		var attrOptions = $.parser.parseOptions(target, properties);
		return $.extend({}, attrOptions);
	};
    
    // 初始化控件, target为一个dom对象
    function init(target, options){
		try{
			if(target && options){
				var targetWin = options.topWin ? window.top : window;
				options.targetWin = targetWin;
				var targetDoc = targetWin.document;
				options.targetDoc = targetDoc;
				// 当前激活的页签的tabId aud$getActiveTabId()
				options.data = options.data ? options.data : {};
				options.data.parentTabId = aud$getActiveTabId();
				options.data.topWin = options.topWin ? 'true' : 'false';
				if(!options.topWin){
					//创建一个弹出窗口，包含iframe和form
					createUploadWin(target, options, false);
				}
				//注册事件
				handleEvent(target, options);
			}
		}catch(e){
			isdebug ? alert(plugName+".init:\n"+e.message) : null;
		}
    }
    
    //初始注册方法
    function handleEvent(target, options){
		try{
			$('#'+options.triggerId).unbind('click').bind('click', function(){
				if(options.topWin){
					//创建一个弹出窗口，包含iframe和form
					createUploadWin(target, options, true);
				}else{
					options.targetWin.$(options.dialogContainer).dialog('open');
				}
			});
		}catch(e){
			isdebug ? alert(plugName+".handleEvent:\n"+e.message) : null;
		}
    }
    
    function createTemplateForm(options){
    	try{
			var targetWin = options.targetWin;
			var targetDoc = options.targetDoc;
			var formId = plugName+'_template_form_'+genRandNum();
            var templateForm = targetWin.$("<form method='post'></form>").attr({
                'id'	:formId,
				'name'  :formId,
				'action':options.templateDownloadUrl
            });  
            options.templateForm = templateForm;
            
			targetWin.$("<input type='hidden'></input>").attr({
				'name':'templateFilePath'
			}).val(options.templateFilePath).appendTo(templateForm[0]);
			
			targetWin.$("<input type='hidden'></input>").attr({
				'name':'templateFileName'
			}).val(options.templateFileName).appendTo(templateForm[0]);			
            return templateForm;
    	}catch(e){
    		isdebug ? alert(plugName+".createTemplateForm:\n"+e.message) : null;
    	}
    }
    
    // 创建一个弹出窗口，包含iframe和form, 用于excel的上传和结果的回显
    function createUploadWin(target, options, isOpen){
        try{
			options.isClear = false;
			var targetWin = options.targetWin;
			var targetDoc = options.targetDoc;
			var plugContainer = targetWin.$("<div></div>").appendTo(targetWin.$('body').get(0)).addClass('parseExcleContainer');
			options.plugContainer = plugContainer;
			var dialogContainerId = plugName+'_dialogContainer_'+genRandNum();
			var dialogContainer = targetWin.$("<div></div>").appendTo(plugContainer).attr({
				'id':dialogContainerId
			});
			var dialogContainerDom = dialogContainer.get(0);
			options.dialogContainer = dialogContainer;
			options.plugId = $(target).attr('id');
			
			//解析excel的结果写入这个隐藏的input中
			var parseResultInput = targetWin.$("<input type='hidden'></input>").attr({
				'id'  :'importExcelSuccess',
				'name':'importExcelSuccess'
			}).appendTo(dialogContainerDom);
			options.parseResultInput = parseResultInput;
			
			var iframeId = plugName+"_result_"+genRandNum();			
			var resultIframe = targetWin.$("<iframe></iframe>").appendTo(dialogContainerDom).attr({
				'id':iframeId,
				'name':iframeId
			}).hide();
			options.resultIframe = resultIframe;
			
			var formId = plugName+'_upload_form_'+genRandNum();
            var uploadFileForm = targetWin.$("<form method='post'></form>").appendTo(dialogContainerDom).attr({
                'id'	:formId,
				'name'  :formId,
				'target':iframeId,
				'action':options.submitUrl,
				'enctype':"multipart/form-data"
            });  
			var uploadFileFormDom = uploadFileForm.get(0);			
			options.uploadFileForm = uploadFileForm;
			
			//除了要导入的excel外，其它要提交的数据, json格式
			var jsonData = options.data;
			if(jsonData){
				for(var pd in jsonData){
					uploadFileForm.find("input[name="+pd+"]").remove();
					var dataInputObj = targetDoc.createElement('input');
					targetWin.$(dataInputObj).attr({
						'name':pd,
						'id'  :plugName+'_'+pd,
						'type':'hidden'
					}).val(jsonData[pd]).appendTo(uploadFileFormDom);
				}
			}
			// form下的表格 
            var table = targetDoc.createElement('table');
            targetWin.$(table).addClass("ListTable").attr({
				'align':'center',
				'style':'width:98%'
			}).css('border','0');
			uploadFileForm.append(table);
			//部分必填的input
			var inputNames = ['beanName','boPk','headColumIndex','rowDataStartIndex','plugId'];
			var inputTitle = ['业务对象','业务主键','Excel属性行下标','Excel数据行下标','组件ID'];
			var curTr = null;
			var colcount = 1;
			
			$.each(inputNames, function(i, inputName){
				if(i%colcount == 0){
					curTr = targetDoc.createElement('tr');
					options.showParam ? targetWin.$(curTr).show() : targetWin.$(curTr).hide();
					targetWin.$(table).append(curTr);					
				}
				targetWin.$(curTr).append("<td class='EditHead' nowrap style='width:15%;'>"+inputTitle[i]+"</td>");
				var td = targetDoc.createElement('td');
                targetWin.$(curTr).append(td);
				var inputObj = targetDoc.createElement('input');
				targetWin.$(inputObj).attr({
					'name':inputName,
					'class':'noborder editElement clear'
				}).val(options[inputName]);
				//alert(inputName+"="+options[inputName])
                targetWin.$(td).attr({
                	'class':'editTd',
                	'style':'width:70%;'
                }).append(inputObj);
			});
			
			curTr = targetDoc.createElement('tr');
			targetWin.$(table).append(curTr);	
			targetWin.$(curTr).append("<td class='EditHead' nowrap style='width:15%;'>选择(仅支持xlsx)</td>")
         	var uploadTd = targetDoc.createElement('td');
			targetWin.$(uploadTd).attr({
            	'class':'editTd',
            	'style':'width:70%;'
            });
			options.uploadTd = uploadTd;
			addFileInput(options);
			
            targetWin.$(curTr).append(uploadTd);
            
            var exportEorrExcelInput = targetWin.$("<input type='checkbox' />").appendTo(uploadFileFormDom).attr({
                'id'  :"exportEorrExcel",
                'name':"exportEorrExcel"
            }).tooltip({
				content:'勾选后，如果文件解析失败，会把有错误的数据标记并导出'
			});
			curTr = targetDoc.createElement('tr');
			targetWin.$(table).append(curTr);	
			targetWin.$(curTr).append("<td class='EditHead' nowrap style='width:15%;'>出错时导出</td>")
         	var uploadTd2 = targetDoc.createElement('td');
			targetWin.$(uploadTd2).attr({
            	'class':'editTd',
            	'style':'width:70%;'
            }).append(exportEorrExcelInput);
            targetWin.$(curTr).append(uploadTd2);
			
			curTr = targetDoc.createElement('tr');
			targetWin.$(table).append(curTr);	
			var pathTd = targetWin.$("<td class='editTd' nowrap colspan='2'></td>").appendTo(curTr);
			var pathDiv = targetWin.$("<div></div>").appendTo(pathTd);
            options.pathDiv = pathDiv;
			
			dialogContainer.dialog({
				title:options.title,
				width :options.winWidth,   
				height:options.winHeight - 15,   
				modal:true,
				shadow:false,
				resizable:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				border:false,
				closed:!isOpen,
				zIndex:99,
				buttons:[{
					text:options.downloadTemplateBtn ? options.downloadTemplateBtn : "下载模版",
					iconCls:'icon-download',
					id:'parse_downloadTemplate',
					handler:function(){ 
						(parseExcel.methods['downloadTemplate'])($(target));
					}
				},{
					text:options.importFileBtn ? options.importFileBtn : "导入文件",
					iconCls:'icon-upload',
					id:'parse_importFile',
					handler:function(){
						(parseExcel.methods['submit'])($(target));
					}
				},{
					text:"清空",
					iconCls:'icon-empty',
					id:'parse_clear',
					handler:function(){
						callFn(options, "onClear");
						clearFileUploadInput(options);
					}
				},{
					text:"关闭",
					iconCls:'icon-cancel',
					id:'parse_cancel',
					handler:function(){
						targetWin.$(dialogContainer).window('close'); 
					}
				}],
				onBeforeClose:function(){
					callFn(options, "onBeforeClose");
				},
				onClose:function(){
					callFn(options, "onClose");
					//清理创建dialog，form等
					aud$parseExcelClear(options);
				},
				onOpen :function(){
					clearFileUploadInput(options);
					callFn(options, "onOpen");
				}
			}); 
		}catch(e){
			isdebug ? alert(plugName+".createUploadWin:\n"+e.message) : null;
		}
    }
    
    function addFileInput(options){
    	try{
			var targetWin = options.targetWin;
			var targetDoc = options.targetDoc;
    		if(!options.uploadFileInput){
				
	    		var uploadFileInputId = plugName+'_upload_input_'+genRandNum();
	            var uploadFileInput = targetWin.$("<input type='file' />").attr({
	                'id'  :uploadFileInputId,
	                'name':uploadFileInputId,
					'hideFocus':"true"
	            }).css({
					'margin-left':'-5px',
					'width' :'100px',
					'height':'30px',
					'float' :'left',
					'cursor':'pointer',
					'fontSize':"25px",
					'opacity' :'0',
					'filter'  :"alpha(opacity=0))" ,
					'border-width':'0px'
				}).addClass('icon-addFile').mouseover(function(){
					targetWin.$(options.leftInutImgDiv).css('background-position-y','-28px');
				}).mouseout(function(){
					targetWin.$(options.leftInutImgDiv).css('background-position-y','4px');
				}).bind('change', function(){
	            	checkImportTempalteFile(options) ? callFn(options, "onFileChange") : null;
	            });
	            options.uploadFileInput = uploadFileInput;
	            $(options.uploadTd).append(uploadFileInput.get(0));
				
				var leftInutImgDiv = targetWin.$("<div></div>").appendTo($(options.uploadTd)[0]);           
				targetWin.$(leftInutImgDiv).css({
					'margin':'0px 0px 0px -90px',
					'padding':'5px',
					'float':'left',
					'width':'100px',
					'height':'28px',
					'line-height':'28px',
					'cursor':'pointer',
					'background-position-x':'0px',
					'background-position-y':'4px',
					'background-repeat': 'no-repeat',
					'border':'0px solid red'
				}).addClass('icon-addFile');
				options.leftInutImgDiv = leftInutImgDiv;
    		}else{
    			return options.uploadFileInput;
    		}
    	}catch(e){
    		isdebug ? alert(plugName+".addFileInput:\n"+e.message) : null;
    	}
    }
    
    function clearFileUploadInput(options){
    	try{		
    		if($(options.uploadFileInput).val()){
	    		options.uploadFileInput.remove();
				options.leftInutImgDiv.remove();
	    		options.uploadFileInput = null;
	    		options.parseResultInput.val('');
				$(options.pathDiv).html("");
	    		addFileInput(options);   
    		} 		
    	}catch(e){
    		isdebug ? alert(plugName+".clearFileUploadInput:\n"+e.message) : null;
    	}
    }    
    
    function callFn(options, fnName){
    	return options[fnName] ? options[fnName].call(this, options.target, options) : null;
    }
	
    function checkImportTempalteFile(options){
    	try{
			var targetWin = options.targetWin;
	    	var path = targetWin.$(options.uploadFileInput).val();
	    	if(!path){
	    		msg('请选择要导入的Excel文件！');
	    		return false;
	    	}else{          		
	        	var arr = path.split('.');
	        	var suffix = arr[arr.length - 1];
	        	//alert('suffix='+suffix)
	        	if(suffix && suffix.toLowerCase() != 'xlsx'){
	        		msg('导入文件后缀名错误，请导入 xlsx的Excel文件！');
	        		clearFileUploadInput(options);
	        		return false;
	        	}else{
					$(options.pathDiv).html("文件名："+getFileName(path));
	            	return true;
	        	}
	    	}   		
    	}catch(e){
    		isdebug ? alert(plugName+".checkImportTempalteFile:\n"+e.message) : null;
    	}
    }
	
	function getFileName(inputFileVal){
		try{
			var fileName = "";
			if(inputFileVal){
				var spIndex = inputFileVal.lastIndexOf("\\");
				if(spIndex != -1){
					fileName = inputFileVal.substr(spIndex + 1);
				} 
			}
			return fileName;
    	}catch(e){
    		isdebug ? alert(plugName+".getFileName:\n"+e.message) : null;
    	}
	}
    
    function msg(content, type, cbFn){
    	try{
    		showMessage1(content);
    	}catch(e){
    		top.$.messager.alert('提示信息', content, type ? type : 'info', function(){
    			cbFn ? cbFn() : null;
    		})
    	}
    }
    
    // 获得随机数, 参数：随机数的位数
    function genRandNum(len){
        try {
            len = !len ? 3 : len > 20 ? 20 : len;
            var num = 1;
            var arr = [];
            arr.push("1");
            for(var i=0; i<len-5; i++){
                arr.push("0");
            }
            num = parseInt(arr.join(""));
            var a1 = String(Math.floor(Math.random() * num));
            var d  = String(new Date().getTime());
            var a2 = d.substring(d.length-5);
            return a1+a2;
        } catch (e) {
            isdebug ? alert(plugName+".genRandNum:\n"+e.message) : null;
        }
    }
    
	// 暴露的方法
    parseExcel.methods = {
        options:function(jq){
            return $.data(jq.get(0), plugName).options;
        },
        //下载模版
        downloadTemplate:function(jq){
        	var options = $.data(jq.get(0), plugName).options;
			var targetWin = options.targetWin;
			//下载模版Form
			targetWin.$('body').append(createTemplateForm(options)[0]);
        	options.targetWin.$(options.templateForm).submit();
			window.setTimeout(function(){
				options.targetWin.$(options.templateForm).remove();
			}, 100)
        },
        //提交要解析的excel
        submit:function(jq){
        	var options = $.data(jq.get(0), plugName).options;
        	var targetWin = options.targetWin;
			if(checkImportTempalteFile(options) && callFn(options, "onBeforeImport")){							
				targetWin.$(options.uploadFileForm).submit();
				if(targetWin.frloadOpen){
					window.setTimeout(function(){
						targetWin.$(options.dialogContainer).dialog('collapse');			
						targetWin.frloadOpen();
					},0);
				}else{
					targetWin.$(options.pathDiv).html("<div style='text-align:center;widht:90%;heigh:25px;line-height:25px;padding:2px;'><strong><font color='red'>正在处理，请稍后...</font></strong></div>");
				}
			}
        }
    };
    
	//默认参数
    parseExcel.defaults = {
		// 控件出错时是否输出调试信息
        isdebug:true,
		//是否把弹出窗口显示在最顶层window，如果多层嵌套时，操作区域会太小
        topWin:true,
		//弹出窗口的title
		title:'Excel文件导入解析',
		//弹出窗口的宽度
		winWidth:500,
		//弹出窗口的高度
		winHeight:200,
		//除了要导入的excel外，其它要提交的数据, json格式
		data:{},
		//必填,触发弹出窗口的按钮ID
		triggerId:'',
		//必填：excel解析后，数据要保存进去的实体bean，beanName指定是spring的applicationContext-xx.xml中bean
		beanName:"",
		//必填：业务对象的主键
		boPk:"",
		//必填：excel中实体bean属性所在行，下标从0开始
        headColumIndex:0,
		//必填：excel中要导入数据的开始行，下标从0开始
        rowDataStartIndex:2,
        //弹出窗口：是否显示配置参数
        showParam:false,
		//文件提交解析的URL
		submitUrl:"/ais/commonPlug/importExcelToDB.action",
		//模版下载url
		templateDownloadUrl:'/ais/commonPlug/downloadExcleTemplate.action',
		//是否可以上传多个文件
        multiple:false, 
        //上传文件类型
        suffixs:"xlsx",
        //上传成功后，要刷新的datagrid id
        datagridId:'',
		//按钮名称
        downloadTemplateBtn:'下载模版',
        importFileBtn:'导入文件',
        //下载模版的名字
        templateFileName:'',
        //下载模版的路径
        templateFilePath:'',
        // 导入前调用, 返回boolean，可以用来导入前校验
        onBeforeImport:function(target, options){return true;},
        // 导入后调用
        onAfterImport:function(target, options){},
        // 清空
        onClear:function(target, options){},
        // 打开窗口时调用
        onOpen :function(target, options){},
        // 关闭时调用
        onClose:function(target, options){},
        // 选择文件改变时调用
        onFileChange:function(target, options){},
		//导入成功后调用
		onImportSuccess:function(target, options){}
    };
     
    //获得激活页签的ID，用于查找此页签的iframe
    function aud$getActiveTabId(){
    	try{
			return aud$getActiveTab().attr('id');
    	}catch(e){
    		//alert('aud$getActiveTabId:'+e.message);
    	}
    }
    
    //获得激活的tab页签
    function aud$getActiveTab(){
    	try{
			return top.Addtabs.options.obj.children(".tab-content").find('.active');
    	}catch(e){
    		//alert('aud$getActiveTab:'+e.message);
    	}
    }
    
})(jQuery);

//清理创建dialog，form等
function aud$parseExcelClear(options){
	try{		
		if(options && options.topWin && !options.isClear){
			//清理创建dialog，form等
			window.setTimeout(function(){
				//是否已经清空
				options.isClear = true;
				var targetWin = options.targetWin;
				targetWin.$(options.dialogContainer).parent().remove();
				targetWin.$(options.plugContainer).nextAll('.window-mask').remove();
				targetWin.$(options.plugContainer).remove();
				options.uploadFileInput = null;
			}, 100);
		}	
	}catch(e){
		isdebug ? alert('aud$parseExcelClear:\n'+e.message) : null;
	}
}

//导入后的回调函数
function aud$ImportExcelCallbackFn(importExcelSuccess, plugId){
	try{
		if(plugId){		
			var options = $('#'+plugId).parseExcel('options');
			if(options){
				var targetWin = options.targetWin;
				if(targetWin.frloadClose){
					window.setTimeout(function(){
						targetWin.frloadClose();
						targetWin.$(options.dialogContainer).dialog('expand');
					},0);
				}
				if(importExcelSuccess && importExcelSuccess == 'true'){
					var datagridId = options.datagridId;
					if(datagridId){
						var plugObj = $('#'+datagridId).data('plugObj');
						if(plugObj && plugObj.refresh){					
							plugObj.refresh();
						}else{
							$('#'+datagridId).datagrid('reload');
						}
					}				
					targetWin.$(options.dialogContainer).dialog('close');				
					//导入成功后调用
					options["onImportSuccess"] ? options["onImportSuccess"].call(this, options.target, options) : null;				
					//清理创建dialog，form等
					aud$parseExcelClear(options);		
				}else{
					targetWin.$(options.pathDiv).html("");
				}
			}
		}
	}catch(e){
		isdebug ? alert('aud$ImportExcelCallbackFn:\n'+e.message) : null;
	}
}