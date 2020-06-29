                    /**
@名称：通用文件上传 jQuery-fileUpload.js
@开发: qfucee
@日期: 2016.4.12
@版本: v1.0
@描述：基于jquery，jquery-easyui的多文件上传组件（class="easyui-fileUpload"）
  1.支持上传多个文件，可以对文件的大小、类型、个数进行检查。
  2.模拟ajax方式上传，不刷新页面

@开发: qfucee
@日期: 2016.4.22
@版本: v1.1
@描述：
1.修复：
.后缀名检查不起作用；
.修复添加后不能刷新页面附件列表。
2.优化：
.修改JS计算上传文件的大小，使之使用IE，chrom等多个浏览器。
.打开时，清除上一次上传文件的记录。
.上传文件显示列表，修改为datagrid方式，jsp页面只要div设置class="easyui-fileUpload"就可以了，前后不需要太多的设置；
.编写删除附件方法，批量下载附件方法
.编写批量下载附件方法
.去掉组件间的边框
.对添加、删除、编辑、查看、下载等按钮通参数来分别控制是否显示
.图标隐藏时，同时去掉右侧分割线；
.添加上传文件金格控件的查看和编辑方法。
.修改easyui.css 中的.window .shadow样式的position修改未fixed，使窗口等不随滚动滚动，固定居中 

@开发: qfucee
@日期: 2016.4.27
@版本: v1.2
@描述：
1.修复：
.提示已存在的文件，上传时也上传了
.可以用金格控件打开的文件,提示不能打开
2.优化：
.默认打开input file的multiple属性，支持ctrl选择多个文件上传
.添加autoCloseOnEsc属性，true：esc关闭窗口
.修改部分提示信息样式，对里面的重要内容添加颜色以区分

@开发: qfucee
@日期: 2016.4.28
@版本: v1.3
@描述：
优化：
.已上传的文件，上传按钮禁用。
.如果文件后缀没有指定时，则可以选择任何文件。
.解决用JS初始化时，回显表格size无法铺满容器，高度无法显示所有记录，宽度不能到100%。
添加：
1.添加通过触发按钮弹出窗口（文件选择）。
2.上传文件回显可以自定义，由参数控制是否使用自动生成的datagrid显示。
3.添加方法：获得已经上传的文件信息[getUploadFiles]
4.添加方法：刷新文件回显表格[reloadFileGrid]
5.添加属性： echoType      
        文件上传后，回显方式选择， 默认：1
        1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
        2：以文件名列表形式展示，一个文件名称就是一行
        3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
6.添加属性：fileWrap
        echoType = 2, 文件是否换行， true：一个文件一行， false：都在一行
7.文件上传完毕后，回显方式增加以menuButton形式显示。

@开发: qfucee
@日期: 2016.5.3
@版本: v1.4
@描述：
添加功能：
1.添加属性：uploadFace 上传界面类型， 
  0：（默认）弹出dialog窗口和表格； 
  1：直接选择上传文件；
2.添加方法：刷新回显文件 - menubutton 形式 [reloadFileMenuBtn]
  参数：queryParams， json类型
3.添加方法：reloadFile，刷新回显文件，根据echoType的值，自动去判断回显方式[reloadFile]
  参数：queryParams， json类型 
4.menubutton形式的回显文件，删除时confirm确认后再删除。 
          
修复：
1.<!DOCTYPE HTML>下，offsetHeight = clientHeight = scrollHeight, 导致窗口位置异常。
2.简单文件上传时，一次新最大文件判断错误（第一次上传完后，没有清空缓存数组）。

@开发: qfucee
@日期: 2016.5.4
@版本: v1.5
@描述：
1.添加属性：
    draggable：窗口是否可以拖拽，默认：false, 
    zIndex   ：窗口层的zIndex，默认为9999999
2.添加属性：zipFile 下载时，是否压缩文件，仅限于下载单个文件时，多个文件下载，只能放在zip压缩包中。
    下载时文件默认为下载文件的名称，也可以通过控件属性指定（zipPackageName）
    true: 压缩文件；false:不压缩文件； 默认：false
3.添加属性：shadow
    弹出窗口 - 如果设置为true，在窗体显示的时候显示阴影
4.添加属性: msgAlign
    消息位置'top, bottom', 默认：'bottom' 
5.添加方法：设置控件的属性property
         参数：key ：可以为String， 或者json 对象
               value：String
         使用：
            1.$('#objId').fileUpload('property','fileGuid','-1');
            2.$('#objId').fileUpload('property',{
                'fileGuid':'-1',
                'msgAlign':'bottom'
            });
6.添加事件：onDeleteFile 删除文件前调用 
    参数：fileIdList   数组类型[], 里面为选择的文件fileId
    返回：boolean      true:执行删除， false：终止删除
    
7. onDeleteFileSuccess  删除成功后调用
    参数：
    data   json类型｛type:'info/error', msg:'删除成功！'｝, 
    fileIdList   数组类型[], 里面为选择的文件fileId

@开发: qfucee
@日期: 2016.5.5
@版本: v1.6
@描述：
优化：
1.编辑按钮显示时，查看按钮就默认隐藏掉。如果编辑按钮隐藏，则查看按钮根据配置是否隐藏。
修复：
1.isAdd属性无法控制添加按钮是否显示。    
2.控件多次调用时，只用第一次时初始化，以后都是更新配置参数。

@开发: qfucee
@日期: 2016.5.6
@版本: v1.6.1
优化：
1.根据“附件”td，回显表格所在td， 页面宽度，自动计算分配宽度，防止附件td被挤压；
2.添加属性: cbGridPrevTdWidth, 回显为grid表格时，附件所在td的前一个td的宽度, 单位可以是%或者px
  默认: cbGridPrevTdWidth:'15%'
  
@开发: qfucee
@日期: 2016.5.6
@版本: v1.6.1
1.修改附件图标为.icon-attachment 
2.调整预览文件列表列的宽度，使之不产生横向滚动条。 

@开发: qfucee
@日期: 2016.5.16
@版本: v1.6.2
1.添加方法:addmenutiem 
（echoType=2）回显为menubutton时，为menubutton添加自定义条目
 参数：itemArray 数组，里面的每个元素为一个json对象 ｛｝
 [{text:'发送消息',
   iconCls:'icon-msg',
   handler:function(fileId, fileName){//自定义响应函数}
 }]

@开发: qfucee
@日期: 2016.5.17
@版本: v1.6.3
1.优化office文件打开方法，使之适用IE8，打开后根据屏幕分辨率最大化.
 .优化文件上传时，文件大小计算方法，适合IE8 - 11，
  IE9以下版本，对于浏览器不能调用activex计算文件大小的，给出提示。
 .优化预览文件datagrid列宽，文件路径太长时使用省略号代替。
2.添加属性：loadtime  默认false, 显示控件加载时间(单位：秒，只有第一次加载时显示)
  添加属性：excludeSuffixs 不能上传的文件类型， excludeSuffixs不为空时，suffixs失效
  添加属性：forceCheck     强制上传文件大小检查，如果不符合则不能上传, 默认：false
  添加属性：spaceSumibtFiles  space空格键上传文件, 默认：true    
  
@开发: qfucee
@日期: 2016.5.17
@版本: v1.6.4
1.添加属性 localViewFile 预览界面的文件，是否可以调用本地office打开查看 true：可以打开
  对于IE浏览器不支持的设置，给出提示；

2016.5.23， qfucee
1.过滤掉上传文件大小为0K的文件。
  
@开发: qfucee
@日期: 2016.5.26
@版本: v1.6.5
1.优化：回显为menubutton时，如果文件不是配置支持的类型（参数：editFileType 可以编辑的类型），不显示编辑/查看button。
 .优化：回显为menubutton时，文件名如果太长，使用省略号代替。
 .优化：回显为menubutton时，为自定义添加的menuItem添加鼠标over，out事件（特效样式）。
 .优化：回显为menubutton时，新添加的文件也有自定义的menuItem， 而不是以前添加的有，添加方法执行一次，不管新添加和还是以前的文件。
 .优化：调整menuItem的显示顺序, 调整编辑和查看按钮的权限设置，可以编辑时，不显示查看	
 .优化：回显为menubutton时，删除文件后，原文件位置标签没有删除，位置被占用。	
2.添加属性：showShortFileName  类型boolean
    true : 回显为menubutton时, 文件名称以短文件名称显示
 .添加属性：shortFileNameSize  数字类型
    showShortFileName = true 时， 
    shortFileNameSize 为数字时，文件名称长度大于shortFileNameSize时， 以短文件名显示
    shortFileNameSize = auto时，根据文件名称长度和父容器的宽度，自动判断是否短文件名显示
 .添加属性: charPixel, 默认值15, 一个汉字占屏幕的像素数
  
2016.5.28， qfucee
1.解决 页面多个fileUpload时，fileGuid初始化时会都变成最后一个，原因时初始化时修改了deault默认值，导致以后的控件参数错误。

2016.6.3, qfucee
1.解决：空格上传文件成功后，再次空格上传报错误（其实已经没有可上传的文件了，此时文件判断有问题）；
2.优化：可以编辑（金格）的文件，用tooltip提示。

2016.6.6, qfucee
1.解决：检验不同的文件虽然提示了有问题，但是仍旧上传了。


@开发: qfucee
@日期: 2016.6.7
@版本: v1.7
1.实现属性“topWindow”的功能 ：是否把弹出窗口显示在最顶层window，如果多层嵌套时，操作区域会太小
    默认:true    
6.8
1.回显表格被layout布局包裹时，表格title添加折叠按钮。 

@开发: qfucee
@日期: 2016.6.12
@版本: v1.7.1
1.添加方法: setGridBtn(btnArr)用来设置回显表格按钮是否显示, btnArr是一个数组[{index:1, display:true/false}]
    index:按钮的下标（从1开始，按出现的顺序）
          从1开始，按照按钮出现的顺序；
    id:根据按钮的ID来定位按钮，和index互斥，二者只能有一个，表格的按钮对应(add,edit,view,delete,download)
    disabled:true/false,
    display:true/false
    name:按钮的新名称
    icon:按钮的新图标
2.解决：
.最外层弹出时，多文件上传，删除文件后，预览表格里面是删除了，但还是可以上传。
.最外层弹出时，空格和Esc事件失效。 
3.优化：
.空格上传时，如果上传界面没有打开，不进行上传， 没有消息提示没有文件上传。
.可编辑文件，前面添加编辑图标提示。 


@开发: qfucee
@日期: 2016.6 - 11
@版本: v1.7.1.5
6.13
1.解决：文件删除后（行删除按钮），再次添加提示文件已经存在。原因：topWin导致上传文混乱，删除时有些数据没删掉。
2.优化：选择多个文件时，预览表格只显示一个删除按钮

6.30
1.IE8文件计算大小时，如果IE设置无法使用文件计算，给出确切提示。
2.IE8按钮触发上传时，只有上传成功后，才添加到fileArr数组缓存。

7.19
1.回显表格折叠收缩后collapse，标题仍旧可以显示在panel上。

7.20
1.解决：按钮触发上传时，同名文件上传成功后，再删除，再上传刚才删除文件，没有反应（原因是上传后没有清空提交form中的input，
造成input value始终有上次的数据，删除后再上传同一个文件，input的value没有变化，无法触发change事件，所以无法上传）。

9.22
1.优化：页面附件显示列表，添加附件“大小”列，根据附件大小，自动判断是”K“，还是”M“

11.2
1.优化：上传文件类型判断时，不区分大小写。

@开发: qfucee
@日期: 2016.11.29
@版本: v1.7.1.5
1.优化：添加参数:checkSameFile 默认为true
  检查选择的文件是否已经上传 checkSameFile：true进行检查，否则不进行检查；
  用文件名称判断，如果重复给出提示，否则继续上传。
2.添加事件：onChange 
  参数如下：
  selectedFiles：已经选择的文件（数组），格式如下：
  	[{'path':'xxx',
	  'name':'xxx',
	  'size':'xxx',
	  'suffix':'xxx' },{..},{..}]
  uploadFiles：已经上传的文件数组，格式如下：
  	[{'fileId':'xxx',
	  'fileName':'xxx'},{..},{..}]
  定义：
  onChange: function(options, selectedFiles, uploadFiles){return true;},
  
@开发: qfucee
@日期: 2016.12.20
@版本: v1.7.1.6  
1.优化：添加属性checkSameFileConfirm
当checkSameFile == true时生效，checkSameFileConfirm == true:弹出confirm提示框决定是否上传重复文件；false：仅仅消息提示； 默认true 

@开发: qfucee
@日期: 2017.2.24
@版本: v1.7.1.7  
1.解决：回显为datagrid时（放在layout中），没有折叠按钮
 
@开发: qfucee
@日期: 2017.3.9
@版本: v1.7.1.8  
1.解决：上传文件达到最大上传数时，尽管已经提示，但是还是可以上传。
每次判断文件时，先检查isInputFileOk是否true，前一个检查是否通过，通过后才进行下一个检查。
2.添加属性：totalFileCount，上传文件的总数(包括已经上传的文件数)，默认50,
3.解决  extendOptions = $.extend(state.options, options) state无这个属性。
4.注释掉回显表格中的编辑、查看按钮，改用表格行中文件名超链接的形式打开（金格控件）

@开发: qfucee
@日期: 2017.3.10
@版本: v1.7.1.9
1.文件上传后表格回显时，非金格编辑的文件，单击不执行editFile方法（先判断是否可以编辑，而不是不能编辑后提示）
2.回显表格初始化时，如果没有传入fileGuid（没有值就不设置datagrid的url）则不进行后台查询。以前是给设置一个
  非法的fileGuid(如:0,-1甚至有的是空)，都要走后台一遍查询（其实没有数据）。所以现在控件初始化一个空的
  回显表格，直接<div id='xxFileupload' class="easyui-fileUpload"></div>，fileGuid不用指定，需要时，直接用
  js指定即可$('#ID').fileUpload({'fileGuid':'xxxx'});
3.property（key，value）方法完善：如果value没有，则返回options[key],如果有则：options[key] = value;
4.更新控件options时，重新加载附件list，
  例如：$('#upload02').fileUpload({'fileGuid':'F207C7EA-BC79-826B-BABF-6C8B26753E69'});会重新加载。
5.添加方法deleteAll：根据fileGuid删除已经上传的附件, 没有参数则默认为当前的表格fileGuid
  deleteAll:function(jqTarget, fileGuid)
6.完善参数解析：支持两种写法
<div class='easyui-fileUpload' data-options="singleSubmit:true"></div>
<div class='easyui-fileUpload' singleSubmit=true></div>

2017.3.16
1.fileGuid增加对null，undefined，'undefined'的判断，无效时给出提示。


@开发: qfucee
@日期: 2017.3.23
@版本: v1.7.2
1.添加属性：collapseList，true/false, 默认rue, 折叠回显列表
 echoType=2列表回显附件时，附件列表是否折叠（容器必须单独放在一个layout的region中，不能放在table的td中）
2.添加方法：
collapseList：折叠回显列表
expandList  ：展开回显列表

@开发: qfucee
@日期: 2017.4.12
@版本: v1.7.3
1.修复dialog的zIndex不起作用问题

@开发: qfucee
@日期: 2017.4.20
@版本: v1.7.4
1.短文件名显示时，尽管外层div宽度大于文件的名称的长度，但是还是以短文件名显示，完善文件名称和外层div长度的
计算，根据外层div的宽度和文件名称长度来决定是否短文件名显示。
2.优化menuItem显示，以及文件添加、删除、加载时文件记录缓存，以便正确计算已上传、以选择文件个数，便于控制上传文件个数。

@开发: qfucee
@日期: 2018.11.28
@版本: v1.7.4.1
1.上传文件类型增加pdf，txt，音频，视频等多种类型，大小限制为50M, 调整文件选择窗口高度，以便显示更多的上传说明;
2.文件上传进度改为ajaxloading的frloadOpen;

2019.6.13
1.附件回显datagrid，如果grid有附件，则不折叠，title显示附件数量和附件图标，附件添加或者删除后，更新title的附件数量；
如果没有附件，初始化时则折叠grid;

2020.2.28   BY ZXL
增加功能：文件mouseover时根据上传文件的提交状态（commit_status)控制显示菜单，如果已提交（commit_status='Y'）不显示编辑和删除
此需求来源：被审计单位反馈账号在做整改时，上传的文书在提交后不能编辑和修改
*/

(function($){ 
    // 是否调试
    var isdebug = true;
	// 组件名称
	var plugName = "fileUpload";
    var uploadObj = $.fn.fileUpload = function(options, params, params2){
		//alert('options='+options+"\n"+'params='+params);
		//alert('params='+params);
        if(options && $.type(options) === 'string'){//执行方法
            var method = uploadObj.methods[options]; 
			//alert('method='+method);
            if(method){//此处this为控件的jquery对象 （例如：<div class='easyui-fileUpload'></div>）
                return method(this, params, params2);
            }
        }
        // 此时的options为对象
        options = typeof options == "object" ? options : {};
		/*
		使用return 返回each，是为了方法链能够延续，如:$('#d1').fileUpload('options').attr('isUse') 
        把控件当成普通的jquery方法使用即可
		*/
        return this.each(function(i, ele){//此处的this为目标dom对象， this = ele
            options.target = this;
            var extendOptions = {};
			var plugObj = $.data(this, plugName); 
			//alert("plugObj="+plugObj);
            if(plugObj){//如果控件已经初始化过了，把新传入的控件配置合并到控件对象的options中
				extendOptions = plugObj.options;
				//alert("callbackGridParams:"+extendOptions.callbackGridParams);
                extendOptions = $.extend(extendOptions, options);
                isdebug = extendOptions.isdebug;
                extendOptions.fileListContainer = extendOptions.fileListContainer ? extendOptions.fileListContainer : $(this).attr('id');
				extendOptions.callbackGridParams.query_eq_guid = extendOptions.fileGuid;
                //增加查询过滤 zxl 2019-11-28
                extendOptions.callbackGridParams.whereSql = extendOptions.whereSql || '';
                //alert(extendOptions.callbackGridParams.query_eq_guid +"\n"+extendOptions.fileGuid);
                extendOptions.maxFileCount == 1 ? extendOptions.multiple = false : null; 
				//alert(extendOptions.callbackGridParams)
				// options发生变化时，重新刷新附件list
				uploadObj.methods["reloadFile"]($(this), extendOptions.callbackGridParams);				
            }else{
                // 解析控件初始化参数（包括页面和js指定的），最后合并这一起
                extendOptions = initUpload(this, options) || {};
                //alert(extendOptions.callbackGridParams)
                isdebug = extendOptions.isdebug;
                extendOptions.fileListContainer = extendOptions.fileListContainer ? extendOptions.fileListContainer : $(this).attr('id');
                extendOptions.callbackGridParams.query_eq_guid = extendOptions.fileGuid;
                //增加查询过滤 zxl 2019-11-28
                extendOptions.callbackGridParams.whereSql = extendOptions.whereSql || '';
                extendOptions.maxFileCount == 1 ? extendOptions.multiple = false : null;             
                // 创建文件下载form
                if(extendOptions.echoType == 1 || extendOptions.echoType == 2){
                    extendOptions.downloadFileForm = createFileDownForm();
                }
                if(extendOptions.echoType == 1){// datagrid回显文件
                    createCallbackDatagrid(this, extendOptions);
                }else if(extendOptions.echoType == 2){//menuButton回显文件
                    extendOptions.closeAfterUpload = true;
                    loadFileEchoRows(extendOptions);
                }
            }
            
        })
    }

	/*
	* 对容器里面的属性：data-options 或者老是写法的属性 进行解析，返回json格式的参数 
	*/
	uploadObj.parseOptions = function(target){
		/*
		把控件的默认属性名称，收集起来形成数组，放到parseOptions的解析参数中，
		这样在控件容器中就可以把控件属性作为容器属性
		eg: 标准的这样写，<div class='easyui-fileUpload' data-options="singleSubmit:true"></div>
		把properties进行解析后，就可以使用老式的写法
		<div class='easyui-fileUpload' singleSubmit=true></div>
		*/
		var dopt = uploadObj.defaults;
		var properties = [];
		for(var p in dopt){
			properties.push(p);
		}
		var attrOptions =  $.parser.parseOptions(target, properties);
		return $.extend({}, attrOptions);		
	};    
     
    //初始化
    function initUpload(target, options){
        try{
            $.data(target, 'fileUpload', {
                options: $.extend({}, uploadObj.defaults, uploadObj.parseOptions(target), options)
            });
            var extendOptions = $.data(target, 'fileUpload').options || {};
            var targetWin = extendOptions.topWindow ? window.top : window;
            extendOptions.targetWin = targetWin;
            var targetDoc = targetWin.document;
            extendOptions.targetDoc = targetDoc;
            var dialogContainer = targetDoc.body;
            extendOptions.dialogContainer = dialogContainer;
           
            //外部按钮打开文件上传界面
            if(extendOptions.triggerId){
                var uploadFace = extendOptions.uploadFace;
                if(uploadFace == 0){//（默认）弹出dialog窗口和表格
                    $('#'+extendOptions.triggerId).bind('click', function(){                      
                        openAddFileWindow(extendOptions); 
                    });
                }else if(uploadFace == 1){ //直接选择上传文件
                    extendOptions.submitFileForm = createUploadForm(extendOptions.targetDoc, extendOptions.targetWin, $('#'+extendOptions.triggerId)[0], extendOptions.submitFilesUrl, true);
                    addNewInputFile(extendOptions); 
                }
            }
            /* 每次控件初始化时，就会把default里的query_eq_guid值修改为当前值，导致页面多个控件时，文件要不无法上传回显，要不显示错乱
               目前可以确定的是，执行
                $.data(target, 'fileUpload', {
                    options: $.extend({}, uploadObj.defaults, uploadObj.parseOptions(target), options)
                });
                就会修改default, 在没有找到根儿的情况下，只能先重置一下default的callbackGridParams
            */
            uploadObj.defaults.callbackGridParams ={
                query_eq_guid:'',
                boName  :'FileBean',
                pkName  :'fileId'
            };
            return extendOptions;
        }catch(e){
            options.isdebug ? alert('fileUpload.initUpload:\n'+e.message) : null;
        }
    }
    
    // 打开上传文件easyui窗口
    function openAddFileWindow(options){
        try{
            // 最为层window显示弹出层, 文件选择窗口只在最外层创建一次
            if(options.topWindow){
                /*
                var fileDialogs = options.targetWin.$('.window').find(">div[name^='uploadFileDialog']");
                //alert(fileDialogs.length)
                if(fileDialogs.length){
                    options.fileDialog = fileDialogs[0];
                }else{
                    createUploadWin(options.target, options, true);
                }*/
                createUploadWin(options.target, options, true);
            }else{
                // 创建上传弹出窗口
                options.fileDialog ? options.targetWin.$(options.fileDialog).dialog("open") : createUploadWin(options.target, options, true); 
            }
        }catch(e){
            isdebug ? alert("fileUpload.openAddFileWindow:\n"+e.message) : null;
        }
    }
    
    // 创建eaasyui文件上传窗口
    function createUploadWin(target, options, isOpenDialog){
        try{
            var t1 = new Date().getTime();
            var targetWin = options.targetWin;
            var targetDoc = options.targetDoc ;
            var dialogContainer = options.dialogContainer;                      
            var fileDialog = targetDoc.createElement("div");
            options.fileDialog = fileDialog;
            targetWin.$(dialogContainer).append(fileDialog);
                        
            var winsize = getWinSize(options);
            var dgW = winsize.width  > 900 ? 900 : 600;
            var dgH = winsize.height > 600 ? 455 : 455;
            var uploadAddBtnId = "uploadFileBtn"+genRandNum();
            options.uploadAddBtnId = uploadAddBtnId;
            var fileDialogID = "uploadFileDialog_"+genRandNum();
            targetWin.$(fileDialog).attr({
                'name':fileDialogID,
                'id'  :fileDialogID
            }).dialog($.extend({}, {
                width :dgW,
                height:dgH,
                zIndex:options.zIndex,
                closed:isOpenDialog,
                draggable:options.draggable,
                shadow   :options.shadow,
                onBeforeOpen:function(){
                    // 如果是固定的，则不用计算滚动条滚动
                    var isFixed = targetWin.$(fileDialog).parent("div[class*='window']").css('position') == 'fixed' ? true :  false;
                    var sTop  = isFixed ? 0 : targetWin.$(targetDoc).scrollTop();
                    var sLeft = isFixed ? 0 : targetWin.$(targetDoc).scrollLeft();
                    //alert("sTop="+sTop+"\nsLeft="+sLeft);
                    var clientW = winsize.width;
                    var clientH = winsize.height;  
                    //alert("clientH="+clientH+"\ndgH="+dgH+"\nsTop="+sTop);
                    var winTop  = (clientH - dgH)/2 + sTop;
                    var winLeft = (clientW - dgW)/2 + sLeft;
                    //alert('winTop='+winTop+", winLeft="+winLeft);
                    targetWin.$(fileDialog).dialog('resize',{
                        top :winTop - 5,
                        left:winLeft
                    });

                    options.clearCache ? removeAllFile(options) : null;
                    return options.onBeforeOpen(options.target, options);
                },  
                onOpen:function(){

					targetWin.$(fileDialog).parent().css('z-index', options.zIndex);
					targetWin.$(fileDialog).parent().nextAll('.window-mask').css('z-index', options.zIndex - 1);
                    // 绑定响应键盘事件
                    setKeyupEvent(options);
                    targetWin.$(fileDialog).data('isOpen', true);
                    return options.onOpen(options.target, options);
                },     
                onBeforeClose:function(){
                    return options.onBeforeClose(options.target, options);
                }, 
                onClose:function(){
                    targetWin.$(fileDialog).data('isOpen', false);
                    if(options.topWindow){
                       options.targetWin.$(options.fileDialog).dialog('destroy');
                    }
                    return options.onClose(options.target, options);
                }
            }, options.dialogOptions));

            var layoutWrap = targetDoc.createElement("div");
            options.layoutWrap = layoutWrap;
            targetWin.$(fileDialog).attr({
                id:"fileUpload_dialog_"+genRandNum()
            }).css({
                padding:'0px',
                margin :'0px',
                overflow:'hidden'
            }).append(layoutWrap);
                      
            var northWrap = targetDoc.createElement("div");
            options.northWrap = northWrap;
            var centerWrap = targetDoc.createElement("div");
            options.centerWrap = centerWrap;
            var southWrap = targetDoc.createElement("div");
            options.southWrap = southWrap;

            targetWin.$(northWrap).attr({
                region:'north',
                border:false,
                style :'overflow:hidden;height:50px;'
            });
            targetWin.$(centerWrap).attr({
                region:'center',
                border:false,
                style :'overflow:hidden;height:320px;'
            });
            targetWin.$(southWrap).attr({
                region:'south',
                border:false,
                style :'overflow:hidden;height:65px;'
            });
            targetWin.$(layoutWrap).attr({
               fit:true,
               border:false,
               style :'overflow:hidden;'
            }).addClass('easyui-layout').append(northWrap).append(centerWrap).append(southWrap);
            //north  添加文件上传bar
            addInputFileBar(options); 
            //center 创建文件预览表格
            createViewFileTable(options);

            isOpenDialog ? targetWin.$(fileDialog).dialog("open") : null;
            //south  设置底部
            setBottom(options, southWrap);
            options.loadtime ? showMsg(options, "页面加载耗时：<font color='red'>"+(new Date().getTime() - t1)/1000+"s</font>") : null; 
        }catch(e){
            isdebug ? alert('fileUpload.createUploadWin:\n'+e.message) : null;
        }
    }
    
    // 添加文件上传栏
    function addInputFileBar(options){
        try{      
            var targetDoc  = options.targetDoc;
            var headerWrap = options.northWrap; 
            var targetWin  = options.targetWin;
            var leftTipDiv  = targetWin.$("<div>请选择上传文件</div>").appendTo(headerWrap);
            targetWin.$(leftTipDiv).css({
                'text-align':'center',
                'float':'left',
                'height':'50px',
                'font-size':'14px',
                'color':'gray',
                'width':'130px',
                'line-height':'50px',
                'border-width':'0px',
                'background-color':'#fafafa'
            });
            var leftInputWrap  = targetWin.$("<div></div>").appendTo(headerWrap).css({
                'float':'left',
                'height':'50px',
                'width':'320px',
                'line-height':'50px',
                'border-width':'0px'
            });          
            // 提交file用的form表单 
            options.submitFileForm = createUploadForm(targetDoc, targetWin, leftInputWrap, options.submitFilesUrl);          
            // 添加上传input file
            addNewInputFile(options);
            //alert($.browser.version )
            // 右侧按钮区域
            var rightBtns = targetWin.$("<div></div>").appendTo(headerWrap).css({
                'text-align':'right',
                'float':'right',
                'font-size':'14px',
                'color':'gray',
                'position':'relative',
                'top':'13px'
            });
            
            var clearFile = targetWin.$("<a href='javascript:void(0)' style='width:70px;'></a>").appendTo(rightBtns).linkbutton({    
                iconCls: 'icon-empty',
                text:'清空'
            }).bind('click', function(){
                removeAllFile(options);
            });
            var uploadFile = targetWin.$("<a href='javascript:void(0)' style='width:70px;'></a>").appendTo(rightBtns).linkbutton({    
                iconCls: 'icon-upload',
                text:'上传'
            }).bind('click',function(){   
                //alert('addInputFileBar fileCallbackDatagrid='+options.fileCallbackDatagrid)
                submitFiles(options);
            });
            options.uploadFileBtn = uploadFile;
            /*var uploadTip = targetWin.$("<a href='javascript:void(0)' style='width:70px;'></a>").appendTo(rightBtns).linkbutton({
                iconCls: 'icon-tip',
                text:'说明'
            }).bind('click',function(){
                showMsg(options, options.helpMsg);                 
            });*/
            
            var closeWin = targetWin.$("<a href='javascript:void(0)' style='width:70px;'></a>").appendTo(rightBtns).linkbutton({    
                iconCls: 'icon-cancel',
                text:'关闭'
            }).bind('click',function(){
                 options.targetWin.$(options.fileDialog).dialog('close');
            });
            targetWin.$(rightBtns).find("a").wrap("<span style='padding-right:10px;'></span>")
        }catch(e){
            isdebug ? alert("fileUpload.addInputFileBar:\n"+e.message) : null;
        }
    }
  
    // 文件预览表格
    function createViewFileTable(options){
        try {
            var targetWin = options.targetWin;
            var targetDoc = options.targetDoc;
            var fileDatagrid = targetDoc.createElement("table");
            options.fileDatagrid = fileDatagrid;
            //alert($(options.centerWrap).height());
            targetWin.$(options.centerWrap).append(fileDatagrid);            
            targetWin.$(fileDatagrid).attr('id', "fileUploadViewListTable_"+genRandNum()).datagrid({
                rownumbers:true,
                collapsible:false,
                striped:true,
                fit:true,
                border:0,
                fitColumns:true,
                singleSelect:true,
                selectOnCheck:false,
                checkOnSelect:false,
                showFooter:true,
                title:'文件列表',
                onClickCell:function(rowIndex, field, value){
                    if(field == "operation"){
                        targetWin.$(fileDatagrid).datagrid('selectRow', rowIndex);
                        var row = targetWin.$(fileDatagrid).datagrid('getSelected');
                        var isSubmit = row.fileStatus.indexOf('已上传') == -1 ? false : true;
                        row && !isSubmit ? removeFile(options, row.fileId) : null;
                    }else if(options.localViewFile && field == "fileName"){
                        targetWin.$(fileDatagrid).datagrid('selectRow', rowIndex);
                        var rowData = targetWin.$(fileDatagrid).datagrid('getSelected');
                        if(rowData && isEditFile(options.editFileType, rowData.fileType)){
                            top.$.messager.progress();
                            targetWin.$(fileDatagrid).datagrid('selectRow', rowIndex);                            
                            var suffix  = rowData.fileType;
                            var allpath = rowData.filePath+"\\"+rowData.fileName;
                            OpenFile(allpath, suffix);
                            top.$.messager.progress('close');
                        }
                    }
                },
                columns:[[   
                    {field:'fileInput', checkbox:true, hidden:true},
                    {field:'fileId',    hidden:true},
                    {field:'fileName', title:'文件名称',width:'38%', halign:'center',align:'left',
                        formatter:function(value, rowData, rowIndex){ 
                            //alert(value+"\n"+rowData.fileType +"\n"+ options.editFileType)
                            if(options.localViewFile && isEditFile(options.editFileType, rowData.fileType)){
                                return "<a href='javascript:void(0)' style='cursor:pointer;' title='调用本机office程序打开'>"+value+"</a>";
                            }else{
                                return "<label title='"+value+"'>"+value+"</label>";
                            }
                        }
                    },
                    {field:'filePath', title:'文件路径',width:'20%', halign:'center',align:'left',
                        formatter:getShortCol
                    },
                    {field:'fileStatus',title:'状态',  width:'60px', halign:'center', align:'center',hidden:true},
                    {field:'fileSize',  title:'大小',  width:'95px', halign:'center', align:'right' },
                    {field:'fileType',  title:'类型',  width:'85px', halign:'center', align:'center'},
                    {field:'operation', title:'操作',  width:'70px', halign:'center', align:'center',
                        formatter:function(value, rowData, rowIndex){
                             var isSubmit = rowData.fileStatus.indexOf('已上传') == -1 ? false : true;
                             var str = "";
                             if(!isSubmit){
                                 str = value;
                                 if(value == 'row'){
                                    str = "<div class='icon-delete' title='删除' style='width:100%;cursor:pointer;height:16px;'></div>";
                                 }else if(value == 'foot'){
                                    str = "";
                                 }
                             }
                             return str;
                        }
                    }
                ]]
            });
        } catch (e) {
            isdebug ? alert("fileUpload.createFileTable:\n"+e.message) : null;
        }
    }
      
    // 设置底部提示信息            
    function setBottom(options, bottomObj){
        try{
            var maxFileCount = options.maxFileCount;
            var maxSsize = options.maxSingleFileSize;
            var suffixs  = options.suffixs;
            var excludeSuffixs = options.excludeSuffixs;
            var str = [];
            str.push("<div style='word-wrap:break-word;height:80px;text-align:left;padding:2px 5px 2px 5px;background-color:#fafafa;'><input type='text' value='' style='width:0px;border-width:0px;' />");
            if(excludeSuffixs){
                str.push("禁止后缀:");
                str.push("[<font color='red'>");
                str.push(excludeSuffixs);
                str.push("</font>]");
            }else if(suffixs){
                str.push("允许后缀:");
                str.push("[<font color='red'>");
                str.push(suffixs);
                str.push("</font>]&nbsp;");
            }
            if(maxSsize){
                str.push("&nbsp;单个文件最大[<font color='red'>");
                str.push(formatFileSize(maxSsize));
                str.push("</font>]");
            }
            /*if(maxFileCount){
                str.push("&nbsp;单次上传最多[<font color='red'>");
                str.push(maxFileCount);
                str.push("</font>]个文件</div>")
            }*/
            options.targetWin.$(bottomObj).html(str.join(''));
            // 为了解决最外层弹出窗口时，焦点没有在最外层元素上，导致body的keyup事件无法执行。
            var myinput = options.targetWin.$(bottomObj).find('input')[0];
            myinput.focus();
            myinput.blur();
        }catch(e){
            isdebug ? alert("fileUpload.setBottom:\n"+e.message) : null;
        }
    }
    
    // 添加一个新Input file，每次添加完后，动态创建一个新的input，旧input向左平移，使新input正好在单击图标上面
    function addNewInputFile(options){
        try{
            var targetWin = options.targetWin;
            //alert('options.templateInput='+options.templateInput)
            targetWin.$(options.templateInput).off();
            var inputFId = "fileUpload_input_" + genRandNum();
            var inutHtml = "<input type='file' id='"+inputFId+"' name='"+inputFId+"'/>";
            var templateInput = targetWin.$(inutHtml).appendTo(options.submitFileForm).attr({
                hideFocus:"true"
            }).css({
                'margin-left':'-135px',
                'width' :'100px',
                'height':'35px',
                'float' : options.uploadFace == 1 ? 'none' : 'left',
                'cursor':'pointer',
                'fontSize':"35px",
                'opacity' :'0',
                'filter'  :"alpha(opacity=0))" ,
                'border-width':'0px'
            });
            options.templateInput = templateInput[0];
            options.templateInputId = inputFId;
            bindInputFileEvent(options);
            return options.templateInput;
        }catch(e){
            isdebug ? alert("fileUpload.addNewInputFile:\n"+e.message) : null;
        }
    }
    
    // 文件选择 绑定事件
    function bindInputFileEvent(options){
        try{
            var targetWin = options.targetWin;
            //alert('inputId='+options.templateInput.id)
            targetWin.$(options.templateInput).off().bind('click', function(){
            	$(this).blur(); 
            }).bind('change', function(){
                setFile(options.target, options);             
            }).addClass('icon-addFile').mouseover(function(){
                targetWin.$(options.leftInutImgDiv).css('background-position-y','-25px');
            }).mouseout(function(){
                targetWin.$(options.leftInutImgDiv).css('background-position-y','5px');
            });
            options.multiple ? targetWin.$(options.templateInput).attr({ multiple:"multiple" }): null;
            options.suffixs  ? targetWin.$(options.templateInput).attr({ accept  :"*."+options.suffixs.split(",").join(",*.") }): null;
        }catch(e){
           isdebug ? ("fileUpload.bindInputFileEvent:\n"+e.message) : null; 
        }
    }
    
    // 调用本地office打开文件
    function OpenFile(path, suffix){
        try{
            //alert(path+"\n"+suffix)
            if(path && suffix){
                if(path.indexOf('fakepath') != -1){
                    top.$.messager.alert('警告','当前浏览器安全设置不支持查看文件路径，具体设置请咨询管理员！','warning');
                    return;
                }
                var cmd = new ActiveXObject('WScript.Shell');
                switch(suffix.trim().toLowerCase()){
                    case "docx": 
                    case "doc" : 
                    case "ini" :
                    case "bat" :
                    case "txt" : cmd.Run("winword.exe  "+path+"");break;
                    case "xlsx": 
                    case "xls" : cmd.Run("excel.exe  "+path+"");break;
                }
            }
        }catch(e){
            top.$.messager.progress('close');
            top.$.messager.alert('警告','Automation 服务器不能创建对象！当前浏览器设置不支持查看文件，具体设置请咨询管理员！','warning');
        }

    }  

    // 创建上传文件form表单
    function createUploadForm(targetDoc, targetWin, container, submitFilesUrl, isSimpleUpload){
        try{
            var leftInutImgDiv = targetWin.$("<div></div>").appendTo(container);           
            targetWin.$(leftInutImgDiv).css({
                'margin':'6px 10px 5px 10px',
                'padding':'5px',
                'float':isSimpleUpload ? 'none' : 'left',
                'width':'100px',
                'height':'28px',
                'line-height':'28px',
                'cursor':'pointer',
                'background-position-x':'0px',
                'background-position-y':'5px',
                'background-repeat': 'no-repeat',
                'border':'0px solid red'
            }).addClass('icon-addFile').mouseover(function(){
                $(this).css('background-position-y','-25px');
            }).mouseout(function(){
               $(this).css('background-position-y','5px');
            });
            /*
            .tooltip({
                content:'单击选择上传文件，如果浏览器支持，可以多选'
            });
            */
            
            // 隐藏式iframe，用来模拟ajax提交文件         
            var filetargetifram = targetDoc.createElement("iframe");
            var submitIframId = 'fileUpload_iframe_'+genRandNum();
            targetWin.$(filetargetifram).attr({
                'id'   :submitIframId,
                'name' :submitIframId,
                'style':'display:none;'
            });
                       
            // 提交file用的form表单
            var submitFileForm = targetDoc.createElement("form");
            var submitFormId = 'fileUpload_form_'+genRandNum();
            
            targetWin.$(submitFileForm).attr({
                id     :submitFormId,
                name   :submitFormId,
                method :'post',
                enctype:'multipart/form-data',
                action :submitFilesUrl,
                target:submitIframId
            }).css({
                padding:0,
                margin:'0px 0px 0px 120px',
                display:'block',
                border:'0px',
                height:'50px'
            });  
            targetWin.$(leftInutImgDiv).append(filetargetifram);
            targetWin.$(leftInutImgDiv).append(submitFileForm);
            return submitFileForm;
        }catch(e){
             isdebug ? alert("fileUpload.createUploadForm:\n"+e.message) : null;
        }
    }
    
    // 响应文件input file change
    function setFile(target, options){
        try{
            var targetWin = options.targetWin;
            var fileArr = $(target).data('fileArr');
            fileArr = fileArr && fileArr.length ? fileArr : [];
            var templateInput = options.templateInput;
            var fileList = [];
            var ismulti = false;//浏览器是否支持多文件上传
            if(templateInput.files){// IE10,11 支持此属性
                fileList = templateInput.files;
                ismulti = true;
            }else{
                fileList.push(templateInput);
                ismulti = false;
            }
            
            var tmpFileArr = [];
            var isInputFileOk = true;
            
            // 上传文件数
            var filesLen = fileList.length;
            var value = $(templateInput).val();
            // 检查上传文件个数是否超过限定个数
			if(filesLen > options.maxFileCount){
                showMsg(options, '您选择了【<font color=red>'+filesLen+'</font>】个文件，</br>超过单次最大上传文件数【<font color=red>'+options.maxFileCount+'</font>】');
				isInputFileOk = false;
			}
			
            var fileInfoList = getFileInfo(fileList, value, ismulti); 
            
            // forceCheck 强制上传文件大小检查，如果不符合则不能上传
            if(isInputFileOk && !ismulti && options.forceCheck && !$('body').data('fileUpload_FSO')){
                top.$.messager.alert('警告','当前浏览器设置不支持计算文件大小，请设置后再上传文件！','error',function(){
                    options.uploadFileBtn ? targetWin.$(options.uploadFileBtn).hide() : null;
                    options.localViewFile = false;
                });
                isInputFileOk = false;
            }else{
                 options.uploadFileBtn ? targetWin.$(options.uploadFileBtn).show() : null;
            }
            
			// 已经上传的文件
			var uploadFiles = $(options.target).data('uploadFiles');
			uploadFiles = uploadFiles ? uploadFiles : [];
			//alert("uploadFiles_length="+uploadFiles.length);
			// 执行自定义的onchange事件， 在文件选择时执行
			var inputFileOnChangeFn = options.onChange;
			if(isInputFileOk && inputFileOnChangeFn && typeof inputFileOnChangeFn == 'function'){
				isInputFileOk = inputFileOnChangeFn.call(options.target, options, fileInfoList ? fileInfoList : [], uploadFiles);
			}
			
			// 检查选择的文件是否已经上传 checkSameFile：true进行检查，否则不进行检查
			var checkSameFile = options.checkSameFile;
			//alert('checkSameFile='+checkSameFile)
			// checkSameFile == true时生效，true:弹出confirm提示框决定是否上传重复文件；false：仅仅消息提示
			var checkSameFileConfirm = options.checkSameFileConfirm;
			//alert('checkSameFileConfirm='+checkSameFileConfirm)
			
            //alert('fileInfoList.length='+fileInfoList.length)
            if(isInputFileOk && fileInfoList && fileInfoList.length){
                var fileInfoListSize = fileInfoList.length;
				var uploadFilesLen = uploadFiles.length;
				var totalFileCount = options.totalFileCount;
				//alert('fileInfoListSize:'+fileInfoListSize + '\nuploadFilesLen:' + uploadFilesLen+"\ntotalFileCount="+totalFileCount)
				//alert(totalFileCount)
				if(totalFileCount && (fileInfoListSize + uploadFilesLen) > totalFileCount ){
					showMsg(options, "已选择文件【"+fileInfoListSize+"】个，已上传【"+uploadFilesLen+"】个，总数超过最大上传文件数【"+totalFileCount+"】");
					isInputFileOk = false;
				}else{
					for(var r = 0; isInputFileOk && r < fileInfoListSize; r++){
						var fileInfo = fileInfoList[r];
						
						// 检查选择的文件是否已经上传
						if(checkSameFile){
							for(var p = 0; p < uploadFilesLen; p++){
								var uploadFile = uploadFiles[p];
								if(uploadFile.fileName == fileInfo.name){
									if(checkSameFileConfirm){//confirm确定是否重复上传文件
										if(!window.confirm("["+fileInfo.name+'] 已经上传，是否重复上传?')){
											isInputFileOk = false;
										}
									}else{//msg提示重复文件，不上传重复文件
										showMsg(options, '[<font color=red>'+fileInfo.name+'</font>] 已经上传！');
										isInputFileOk = false;
									}
									break;
								}
							}
						}
						
						// 判断列表中是否已经存在
						var fileExistsIndex = fileExists(target, fileInfo.name);
						if(fileExistsIndex != -1){
							showMsg(options, '[<font color=red>'+fileInfo.name+'</font>]已经存在！', function(){
								targetWin.$(options.fileDatagrid).datagrid('selectRow', fileExistsIndex);
							});
							window.setTimeout(function(){
								targetWin.$(options.fileDatagrid).datagrid('clearSelections');
								targetWin.$(options.fileDatagrid).datagrid('clearChecked');
							},options.msgTimeout);
							isInputFileOk = false;
							break;
						}   
							   
						// 检查后缀名是否合法
						if(options.excludeSuffixs && !checkExcludeSuffix(options.excludeSuffixs, fileInfo.suffix)){
							showMsg(options, '[<font color=red>'+fileInfo.name+'</font>]文件类型非法！'); 
							isInputFileOk = false;                        
							break;   
						}else if(options.suffixs && !checkSuffix(options.suffixs, fileInfo.suffix)){
							showMsg(options, '[<font color=red>'+fileInfo.name+'</font>]文件类型非法！'); 
							isInputFileOk = false;                        
							break;     
						}
						// 计算文件大小
						var filesize = fileInfo.size;
						//alert(filesize) 
						// 检查单位文件大小
						if(filesize && filesize > options.maxSingleFileSize){
							showMsg(options, '[<font color=red>'+fileInfo.name+'</font>('+formatFileSize(filesize)+')]大小超过['+formatFileSize(options.maxSingleFileSize)+']！');
							isInputFileOk = false;
							break;
						}else if(options.forceCheck && filesize == 0){
							showMsg(options, '[<font color=red>'+fileInfo.name+'</font>('+formatFileSize(filesize)+')] 文件大小为0！');
							isInputFileOk = false;
							break;
						}
						
						// 单个file input 信息
						if(isInputFileOk){
							var isHaveDelBtn = true;
							if(fileInfoListSize > 1){
								isHaveDelBtn = r == fileInfoListSize - 1 ? true : false;
							}
							fileInfo = $.extend({}, {
							   target:templateInput,
							   fileId:options.templateInputId,
							   value :value,
							   submit:false,
							   isHaveDelBtn:isHaveDelBtn
							}, fileInfo);
							//alert('add file:'+fileInfo.name)
							tmpFileArr.push(fileInfo);
						}
					}
				}
				

            }else{
                //alert("没有监测到上传文件");
            }
            
            //alert('isInputFileOk='+isInputFileOk+"\ntmpFileArr="+tmpFileArr)
            //alert(tmpFileArr.length)
            // 全部校验通过后，缓存并添加行记录
            if(isInputFileOk && tmpFileArr.length){
                if(options.uploadFace == 0){
                    // 加入数组
                    fileArr = fileArr.concat(tmpFileArr);
                    // 缓存文件信息
                    $(target).data('fileArr', fileArr);
                    // 向表格添加一行数据
                    var beginIndex = fileArr.length;
                    $.each(tmpFileArr, function(h, tmpFileInfo){
                        insertNewRow(targetWin, options.fileDatagrid, tmpFileInfo, beginIndex + h); 
                    });  
                    //alert('fileArr.length='+fileArr.length);
                    updateDatagridFooter(fileArr, options.fileDatagrid, targetWin);
                    // form表单添加一个新input
                    addNewInputFile(options);   
                }else if(options.uploadFace == 1){
                    var oldFileArr = $(target).data('fileArr');
                    $(target).data('fileArr', tmpFileArr);
                    // 文件上传成功后，才被缓存起来
                    if(submitFiles(options)){
                        // 加入数组
                        oldFileArr = oldFileArr.concat(tmpFileArr);
                        // 缓存文件信息
                        $(target).data('fileArr', oldFileArr);  
                    }else{
                         $(target).data('fileArr', oldFileArr);
                    }
                }
            }else{
                clearInputFile(options);
            }
        }catch(e){
            isdebug ? alert("fileUpload.setFile:\n"+e.message) : null;
        }
    }
    
    // 清空input file文件上传路径
    function clearInputFile(options){
       try{
           var inputObj = options.templateInput;
           if(inputObj){              
               options.targetWin.$(options.submitFileForm).find(inputObj).remove();
               addNewInputFile(options);
           }
           return false;
       }catch(e){ 
           isdebug ? alert("fileUpload.clearInputFile:\n"+e.message) : null;
       }
    }
    
    // 向表格插入一条记录
    function insertNewRow(targetWin, fileDatagrid, fileInfo, index){
        try{
            targetWin.$(fileDatagrid).datagrid('insertRow',{
                index: index,	// 索引从0开始
                row  : {
                    fileId  : fileInfo.fileId,
                    fileName: fileInfo.name,
                    filePath: fileInfo.path,
                    fileStatus:!fileInfo.submit ? '<font color=red>未上传</font>' : '<font color=green>已上传</font>',
                    fileSize: formatFileSize(fileInfo.size),
                    fileType: fileInfo.suffix,
                    operation:fileInfo.isHaveDelBtn ? "row" : ""
                }
            });
        }catch(e){
            isdebug ? alert("fileUpload.insertNewRow:\n"+e.message) : null;
        }
    }
    
    // 更新表格统计行
    function updateDatagridFooter(fileArr, fileDatagrid, targetWin){
        try{
            targetWin = targetWin ? targetWin : window;
            var fileLen = fileArr.length;
            var fileSize = 0;
            $.each(fileArr, function(i, fileInfo){
                fileSize = parseFloat(fileSize) + parseFloat(fileInfo.size);
            });
            fileSize = formatFileSize(fileSize);
            targetWin.$(fileDatagrid).datagrid('reloadFooter',[{
                    fileId   :"",
                    fileInput:"",
                    fileName: '合计',
                    filePath: '文件数:'+fileLen,
                    fileStatus:'',
                    fileSize: fileSize,
                    fileType: "",
                    operation:"foot"
                }]);
        }catch(e){
            isdebug ? alert("fileUpload.updateDatagridFooter:\n"+e.message) : null;
        }
    }

    // 格式化
    function formatFileSize(fileSize){
        try{
            if(fileSize){
                if(fileSize > 1000){
                    fileSize = parseFloat(fileSize/1024).toFixed(1)+"M";
                }else{
                    fileSize = fileSize+"KB";
                }
            }else{
                fileSize = '--';
            }
            return fileSize;
        }catch(e){
            isdebug ? alert("fileUpload.formatFileSize:\n"+e.message) : null;
        }
    }
    
    // 检查后缀名是否合法, 符合返回：true， or false
    function checkSuffix(suffixs, suffix){
        try{
            if(suffixs && suffix){
                suffix = suffix.toLowerCase();
                //alert(suffixs +'\n'+ suffix+"\n"+(suffixs+",").indexOf(suffix+","))
                return (suffixs+",").indexOf(suffix+",") == -1 ? false : true;
            }
            // 如果没有限制，则可以选择所有文件
            return suffixs == null || (suffixs && suffixs.length == 0) ? true :  false;
        }catch(e){
            isdebug ? alert("fileUpload.checkSuffix:\n"+e.message) : null;
        }
    }
    
    // 检查后缀名是否合法, 符合返回：true， or false
    function checkExcludeSuffix(excludeSuffixs, suffix){
        try{
            if(excludeSuffixs && suffix){
                return (excludeSuffixs+",").indexOf(suffix+",") == -1 ? true : false;
            }
        }catch(e){
            isdebug ? alert("fileUpload.checkExcludeSuffix:\n"+e.message) : null;
        }
    }
    
    // 检查是否已经上传
    function fileExists(target, fileName){
        try{
            var fileArr = $(target).data('fileArr');  
            var fileExistsIndex = -1;
            if(fileArr && fileArr.length){
                $.each(fileArr, function(i, fileInfo){
                    //alert(fileInfo.name +"\n"+ fileName)
                    if(!fileInfo.submit && fileInfo.name == fileName){
                        fileExistsIndex = i;
                        return false;
                    }
                });
            }
            return fileExistsIndex;
        }catch(e){
            isdebug ? alert("fileUpload.fileExists:\n"+e.message) : null;
        }
    }
         
    // 获得文件的后缀名
    function getFileInfo(fileList, pathStr, ismulti, splitStr){
        try{
            var sp = splitStr || ".";                
            var fileInfoList = [];
            if(fileList && fileList.length && pathStr){ 
                // 高版本浏览器
                if(ismulti){
                    var pathArr = pathStr.split(",");
                    var pathStr = pathArr[pathArr.length - 1];
                    var path = pathStr.substr(0, pathStr.lastIndexOf("\\"));
                    //alert(pathStr+"\n"+path);
                    for(var i=0; i<fileList.length; i++){
                        var file = fileList[i];
                        //alert(file.name+"\n"+file.value);
                        var suffixArr = file.name.split(sp); 
                        fileInfoList.push({
                            'path':path,
                            'name':file.name,
                            'size':getFileSize(ismulti, fileList[i]),
                            'suffix':suffixArr[suffixArr.length-1]
                        });
                    }
                }else{
                    var spIndex = pathStr.lastIndexOf("\\");
                    var filePath = "";
                    var fileName = "";
                    var fileSize = getFileSize(ismulti, fileList[0]);
                    var fileSuffix = "";
                    if(spIndex != -1){
                        filePath = pathStr.substr(0, spIndex);
                        fileName = pathStr.substr(spIndex + 1);
                        if(fileName){
                            var suffixArr = fileName.split(sp); 
                            fileSuffix = suffixArr[suffixArr.length-1];  
                        }
                    }                   
                    fileInfoList.push({
                        'path':filePath,
                        'name':fileName,
                        'size':fileSize,
                        'suffix':fileSuffix
                    });
                    //var json = fileInfoList[0];
                    //for(var p in json) alert(p+'='+json[p])
                }
            }
            return fileInfoList;                  
        }catch(e){
            isdebug ? alert("fileUpload.getFileInfo:\n"+e.message) : null;
        }
    }
    
    // 计算单个文件大小,单位K
    function getFileSize(ismulti, fileObj){
        try{
            //alert(fileObj+"\n"+fileObj.size)
            if(fileObj){
                if(ismulti){
                    return parseFloat(fileObj.size/1024).toFixed(1);
                }else{
                    return getFileSizeByFso(fileObj.value);
                }
            }
        }catch(e){
            isdebug ? alert("fileUpload.getFileSize:\n"+e.message) : null;
        }
        return 0;
    }
    
    // 计算单个文件大小,单位K
    function getFileSizeByFso(filePathAndName){
        if(filePathAndName && filePathAndName.indexOf('fakepath') == 3){
            // IE 属性：将文件上载到服务器时包含本第目录路径，设置为启用
            top.$.messager.show({
                height:'auto',
                width:'400px',
                timeout:10000,
                title:'提示信息',
                msg  :'您的浏览器安全设置不支持显示文件路径，请将IE属性-安全[将文件上载到服务器时包含本第目录路径，设置为启用]，详细设置请咨询管理员！'
            });
            return 0;
        }
        
        
        var size = 0;
        var fso = $('body').data('fileUpload_FSO');
        if(!fso){
            try{
                fso = new ActiveXObject("Scripting.FileSystemObject"); 
                $('body').data('fileUpload_FSO', fso);
            }catch(e){
                top.$.messager.show({
                    height:'auto',
                    width:'400px',
                    timeout:10000,
                    title:'提示信息',
                    msg  :'您的浏览器安全设置不支持计算文件大小，请修改IE的安全设置，详细设置请咨询管理员！'
                });
            }
        }            
        if(fso && filePathAndName){
            // 计算上传文件大小
            var file = fso.GetFile(filePathAndName);
            size = parseFloat(file.size/1024).toFixed(1);
        }
        fso = null;
        return size;
    }
     
    function getFileRealPath(obj) {
        if(obj){  
            if(window.navigator.userAgent.indexOf("MSIE")>=1){
                obj.select();
                return document.selection.createRange().text;
            }else if(window.navigator.userAgent.indexOf("Firefox")>=1) {
                if(obj.files){
                    return obj.files.item(0).getAsDataURL();
                }
                return obj.value;
            }
            return obj.value;
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
            isdebug ? alert("fileUpload.genRandNum:\n"+e.message) : null;
        }
    }
    
    // 计算所在窗口的尺寸
    function getWinSize(options){
        try {
            var doc = options.targetDoc;
            return {
                width :doc.documentElement.clientWidth  || doc.body.clientWidth,
                height:doc.documentElement.clientHeight || doc.body.clientHeight
            }
        } catch (e) {
            isdebug ? alert("fileUpload.getWinSize:\n"+e.message) : null;
        }
    }
    
    // 消息显示方式 1:弹出， 2：窗口里面提示
    function showMsg(options, msg, callbackFn){
        try{
            var topW$ = window.top.$;
            var doc$ = topW$ ? topW$ : $;
            var msgShowType = options.msgShowType;
            var callbackFn = callbackFn ? callbackFn : function(){};
            // 弹出框
            if(msgShowType == '1' || msgShowType == '3'){
                doc$.messager.alert('提示信息', msg, 'warning', callbackFn);
            }
            // 窗口里面提示
            if(msgShowType == '2' || msgShowType == '3'){
                 var msgStyle = {};
                 if(options.msgAlign == 'top'){
                     msgStyle = {
                        width :550,
                        height:70,
                        border:0,
                        style:{
                            'text-align':'center',
                            'top':'0px' 
                        }
                     };
                 }else if(options.msgAlign == 'bottom'){
                     msgStyle = {
                        width :'350px',
                        height:'auto',
                        border:'0px',
                         title:'提示信息'
                     }
                 }
                 doc$.messager.show($.extend({}, {
                    msg:"<span style='font-weight:bold;text-align:center;padding:2px;font-size:15px;color:gray;'>"+msg+"</span>",
                    timeout: options.msgTimeout ? options.msgTimeout : 5000
                }, msgStyle));
                msgShowType == '2' && callbackFn ? callbackFn() : null;
            }
        }catch(e){
            isdebug ? alert("fileUpload.showMsg:\n"+e.message) : null;
        }
    } 
    
    // 清空
    function removeFile(options, delInputId){
        try{
            var targetWin = options.targetWin;
            var fileArr = $(options.target).data('fileArr'); 
            //alert('fileArr='+fileArr)
            //alert('before del : fileArr.length = '+fileArr.length);
            var fileDatagrid = options.fileDatagrid;
            var removeInputObj = null;
            var newFileArr = [];
            if(fileArr && fileArr.length){
                for(var n = 0; n < fileArr.length; n++){
                    var fileInfo = fileArr[n];
                    if(fileInfo.fileId != delInputId){
                        newFileArr.push(fileInfo);                       
                    }else{
                        removeInputObj = removeInputObj == null ? fileInfo.target : removeInputObj;
                    }
                }
            }
            var rows = targetWin.$(fileDatagrid).datagrid('getRows');
            if(rows && rows.length){
                var newRows = [];
                $.each(rows, function(i, row){
                    if(row.fileId != delInputId){
                        newRows.push(row);
                    }
                });
          
                targetWin.$(fileDatagrid).datagrid("loadData",{
                    'rows' :newRows,
                    'total':newRows.length
                });
            }
            updateDatagridFooter(newFileArr, fileDatagrid, targetWin);
            $(options.target).data('fileArr', newFileArr);
            targetWin.$(options.submitFileForm).find(removeInputObj).remove();
            //alert('after del : fileArr.length = '+newFileArr.length);
        }catch(e){
            isdebug ? alert("fileUpload.removeFile:\n"+e.message) : null;
        }
    }
    
    // 清空所有
    function removeAllFile(options){
        try{
            var targetWin = options.targetWin;
            $(options.target).data('fileArr',[]); 
            var fileDatagrid = options.fileDatagrid;
            if(fileDatagrid){
            	setTimeout(function(){            		
            		targetWin.$(fileDatagrid).datagrid("loadData",{
            			'rows' :[],
            			'total':0
            		});
            		updateDatagridFooter([], fileDatagrid, targetWin);
            	}, 100);
            }
            // 清空上传form中的所有input，并添加一个新的input
            targetWin.$(options.submitFileForm).empty();
            addNewInputFile(options);
        }catch(e){
            isdebug ? alert("fileUpload.removeAllFile:\n"+e.message) : null;
        }
    }

    // 判断是否有未上传的文件    
    function isHaveUnUploadFile(fileArr){
        try{
            var count = 0;
            if(fileArr && fileArr.length){
                $.each(fileArr,function(index, fileInfo){
                    //alert(fileInfo.submit)
                    !fileInfo.submit ? count++ : null;               
                });
            }
            return count ? true : false;
        }catch(e){
            isdebug ? alert("fileUpload.isHaveUnUploadFile:\n"+e.message) : null; 
        }
    }
        
    // 文件上传
    function submitFiles(options, tg){
        var rtflag = false;
        try{
            //alert('submitFiles fileCallbackDatagrid='+options.fileCallbackDatagrid)
            var targetWin = options.targetWin;
            var onFileSubmitSuccess = options.onFileSubmitSuccess;
            var onFileSubmit = options.onFileSubmit;
            var fileArr = $(options.target).data('fileArr'); 
            // 判断是否有未上传的文件
            if(!isHaveUnUploadFile(fileArr)){
                showMsg(options, "没有可上传的文件，请先添加文件，再上传！");
                return false;
            }
			//判断guid是否为空
			var fileGuid = options.fileGuid;
			if(fileGuid == null || fileGuid == undefined || fileGuid == "undefined" 
				|| fileGuid == "" || fileGuid == "-1" || fileGuid == "0"){
				showMsg(options, "fileGuid为空，不能保存附件！");
                return false;
			}
			//是否单独提交
			var singleSubmit = options.singleSubmit;
			//alert(options.submitFilesUrl+"?fileGuid="+fileGuid)
			if(targetWin.frloadOpen){				
				targetWin.frloadOpen();
			}else{				
				targetWin.$.messager.progress();
			}
			targetWin.$(options.submitFileForm).form('submit', {
				url:options.submitFilesUrl+"?fileGuid="+fileGuid,
				async:false,
				onSubmit: function(param){
					var rt = true;
					if(onFileSubmit && typeof onFileSubmit == 'function'){
						rt = onFileSubmit.call(options.target, options);
					}
					if(!rt){
						try{
							if(targetWin.frloadClose){
								targetWin.frloadClose()
							}
							targetWin.$.messager.progress('close');
						}catch(e){
							
						}
					}
					rtflag = rt;
					
					//更新回显表格的URL
					var cbDatagrid = options.fileCallbackDatagrid;
					if(cbDatagrid){
						var cbOptions = $(cbDatagrid).datagrid('options');
						if(cbOptions && !cbOptions.url){
							cbOptions.url = options.fileCallbackGridUrl;
						}
					}
					
					
					return rt;
				},
				success: function(data){
					try{
						if(targetWin.frloadClose){
							targetWin.frloadClose()
						}
						targetWin.$.messager.progress('close');
					}catch(e){
						
					}
					if(data){
						var json = (new Function("return " + data))();
						var type = json.type;
						var msg = json.msg;
						if(type == 'info'){
							afterUpload(options, json);
							if(onFileSubmitSuccess && typeof onFileSubmitSuccess == 'function'){
								onFileSubmitSuccess.call(options.target, json, options);
							}
							rtflag = true;
							//alert(json.fileName)
						}
						showMsg(options, msg ? msg : "发生未知错误，文件上传失败！");
						
					}
					//alert(options.closeAfterUpload)
					options.closeAfterUpload ? targetWin.$(options.fileDialog).dialog('close') : null;
				},
				onLoadError:function(){
					try{
						if(targetWin.frloadClose){
							targetWin.frloadClose()
						}
						targetWin.$.messager.progress('close');
					}catch(e){
						
					}
				}
			});
        }catch(e){
            isdebug ? alert("fileUpload.submitFiles:\n"+e.message) : null;
        }
        return rtflag;
    }
    
    // 文件上传成功后，设置表格等
    function afterUpload(options, rtData){
        try{
            var targetWin = options.targetWin;
            var echoType = options.echoType;
            if(echoType == 1){
                $(options.fileCallbackDatagrid).datagrid('reload')
            }else if(echoType == 2){
                createFileEchoRows(options, rtData.fileName, rtData.fileId);
            }
			
			// 把已经上传的文件名称换成起来
			if(rtData){
				//alert("rtData.fileName="+rtData.fileName)
				var fileIdArr = rtData.fileId.split(",");
				var fileNameArr = rtData.fileName.split(",");
				var uploadFiles = $(options.target).data('uploadFiles');
				uploadFiles = uploadFiles ? uploadFiles : [];
				$.each(fileNameArr, function(j, fileName){
					uploadFiles.push({
						'fileId':fileIdArr[j],
						'fileName':fileName
					});
				});
				//alert('afterUpload, uploadFiles_length='+uploadFiles.length);
				$(options.target).data('uploadFiles', uploadFiles);
			}
			
            var fileArr = $(options.target).data('fileArr');
            removeAllFile(options);
            //alert($(options.target).data('fileArr').length)
            var uploadFace = options.uploadFace;
            if(fileArr && fileArr.length){
                var tmpArr = [];
                $.each(fileArr,function(index, fileInfo){
                    fileInfo.submit = true;
                    tmpArr.push(fileInfo);
                    uploadFace == 0 ? insertNewRow(targetWin, options.fileDatagrid, fileInfo, index) : null;
                });
                uploadFace == 0 ? updateDatagridFooter(tmpArr, options.fileDatagrid, options.targetWin) : null;
                $(options.target).data('fileArr', tmpArr);
            }   
            //alert($(options.target).data('fileArr').length)
            if(uploadFace == 0){
				var viewAc = options.isEdit ? "编辑" : "查看";
                window.setTimeout(function(){
                  $('.datagrid-cell-c1-fileName').find("span[name='fileUpload_editable']").tooltip({
                       'content': '单击'+viewAc+'，可以浏览文件'
                  });             
               }, 3000); 
            }
        }catch(e){
            isdebug ? alert("fileUpload.afterUpload:\n"+e.message) : null;
        }
    }
    
    // 生成附件下载form
    function createFileDownForm(){
        try{
            // 附件下载使用的form表单
            var downloadFileForm = $("<form method='post'></form>").appendTo($('body').get(0)).attr({
                'id':'commonFileUpload_dlform'+genRandNum()
            });            
            var downloadFilesInputId = "commonFileUpload_fileIds";
            $("<input type='hidden' />").appendTo(downloadFileForm[0]).attr({
                'id'  :downloadFilesInputId,
                'name':downloadFilesInputId,
                'fileIds':'yes'
            });
            
            var downloadFilesZipFile = "commonFileUpload_zipFile";
            $("<input type='hidden' />").appendTo(downloadFileForm[0]).attr({
                'id'  :downloadFilesZipFile,
                'name':downloadFilesZipFile,
                'zipFile':'yes'
            });
            
            var downloadFilesPackageName = "commonFileUpload_packageName";
            $("<input type='hidden' />").appendTo(downloadFileForm[0]).attr({
                'id'  :downloadFilesPackageName,
                'name':downloadFilesPackageName,
                'packageName':'yes'
            });
            return downloadFileForm[0];
        }catch(e){
            isdebug ? alert("fileUpload.createFileDownForm:\n"+e.message) : null;
        }
    }
    
    // 生成附件页面回显表格
    function createCallbackDatagrid(target, options){
        try{           
            $(target).parent().css({
                //border:'1px solid red',
                margin:'0px',
                padding:'0px'
            });
            var ctHeight = $(target).css({
                //border:'1px solid red',
                margin:'0px',
                padding:'0px'
            }).height();

            var gridH = options.callbackGridHeight ? options.callbackGridHeight : ctHeight; 
            options.callbackGridHeight = gridH;         
            var gridW = target.offsetWidth;
            $(target).css({
            	'height':gridH
            });
            
            // 设置回显表格所在td的前一个td的宽度
            var ptd = $(target).parentsUntil('tr').filter('td').prev('td');
            if(ptd && ptd.length){
            	var ptdStyle = ptd.attr('style');
            	var curBodyW = document.documentElement.clientWidth || document.body.clientWidth;
            	var finalTdW = "";
            	var ptdWidth = options.cbGridPrevTdWidth;

            	if(ptdStyle){
            		var ptdStyleArr = $.trim(ptdStyle).split(";")
            		for(var a = 0; a < ptdStyleArr.length; a++){
            			var ptdStyle = ptdStyleArr[a];
            			var tmArr = $.trim(ptdStyle).split(":");
            			if(tmArr && tmArr.length == 2){
            				if(tmArr[0].toLowerCase() == 'width'){
            					ptdWidth = $.trim(tmArr[1]);
            				}
            			}
            		}
            	}
        		if(ptdWidth){
        			if(ptdWidth.lastIndexOf('px') != -1){
        				finalTdW = ptdWidth.replace('px','');
        			}else if(ptdWidth.lastIndexOf('%') != -1){
        				finalTdW = curBodyW * (ptdWidth.replace('%',''))/100;
        			}
        		}
        		//alert(finalTdW)
        		if(finalTdW){
        			ptd.css({
        				'min-width':finalTdW+"px",
        				'max-width':"250px"
        			});
        		}
            }
            var fileCallbackDatagrid = $("<table></table>").appendTo(target);
            options.fileCallbackDatagrid = fileCallbackDatagrid[0];   
            var gridTitle = options.fileGridTitle ? options.fileGridTitle : '';
            var btnNum = genRandNum();
			
			var query_eq_guid = options.callbackGridParams.query_eq_guid;
			//alert('query_eq_guid='+query_eq_guid)
			
			var datagridUrl = "";
			if(query_eq_guid && query_eq_guid != '-1' && query_eq_guid != '0'){
				datagridUrl = options.fileCallbackGridUrl;
			}
			
            $(fileCallbackDatagrid).data("gridBtns",{
                'add' :'gridBtn_add_'+btnNum,
                'edit':'gridBtn_edit_'+btnNum,
                'delete':'gridBtn_delete_'+btnNum,
                'view'  :'gridBtn_view_'+btnNum,
                'download':'gridBtn_download_'+btnNum
            }).attr('id', "filesCallbackTable_"+genRandNum()).datagrid({
				/*
				如果有url第一次初始化(添加)时，就会加载数据，而有时初始化只是需要初始化表格，不需要后台查询数据
				不设置url就不用去执行后台查询；如果是编辑页面，则设置URL的值
				*/
				url:datagridUrl,
                queryParams:options.callbackGridParams,
                method:'post',
                title : gridTitle, 
                rownumbers :true,
                collapsible:false,
                striped:true,
                border :options.gridBorder,
                singleSelect :true,
                selectOnCheck:false, 
                checkOnSelect:false,
                showFooter:false,
                pagination:true,
                //height:gridH,
                //width :gridW,
				//idField:'fileId',//加了以后，每次删除时，都会把上一次选中的包括进去，即前一次删除一条，这次选中一条，会提示选中两条（每次选中的累加）
                fitColumns:true,
                onLoadSuccess:function(data){
					var rows = [];
                    if(data && data.rows && data.rows.length){
						rows = data.rows;
					}
					$(options.target).data('uploadFiles', rows);

					//折叠或者展开回显datagrid列表					
					window.setTimeout(function(){
						var new_gridTitle = gridTitle;
						var rows = $(options.target).data('uploadFiles');
						if(rows == null || (rows && rows.length == 0)){
							options.collapseList ? uploadObj.methods.toggleListStatus(target, false) : null;
						}else if(rows && rows.length){
							new_gridTitle = gridTitle +"&nbsp;["+rows.length+"]&nbsp;<span class='l-btn-icon icon-attachment'></span>"							
						}
						$(fileCallbackDatagrid).datagrid('getPanel').panel('setTitle', new_gridTitle);
					}, 0);
                },
                fit:true,
                toolbar:[{
                    text:'添加',
                    id:'gridBtn_add_'+btnNum,
                    iconCls:'icon-add',
                    handler:function(){
                        openAddFileWindow(options);
                    }
                },'-',{
                    text:'删除',
                    id:'gridBtn_delete_'+btnNum,
                    iconCls:'icon-delete',
                    handler:function(){
                       deleteFiles(options, options.deleteFilesUrl, fileCallbackDatagrid);
                    }
                },/*'-',{
                    text:'编辑',
                    id:'gridBtn_edit_'+btnNum,
                    iconCls:'icon-edit',
                    handler:function(){
                        editFile(options, options.editFileUrl, fileCallbackDatagrid, false);
                    }
                },'-',{
                    text:'查看',
                    id:'gridBtn_view_'+btnNum,
                    iconCls:'icon-view',
                    handler:function(){
                        editFile(options, options.editFileUrl, fileCallbackDatagrid, true);
                    }
                },*/'-',{
                    text:'下载',
                    id:'gridBtn_download_'+btnNum,
                    iconCls:'icon-download',
                    handler:function(){
                        downloadFiles(options, options.downloadFilesUrl, fileCallbackDatagrid);
                    }
                },'-'],
				onClickCell:function(rowIndex, field, value){
					if(field == 'fileName'){		
						var rows = $(this).datagrid('getRows');
						var row = rows[rowIndex];
						
						if(isEditFile(options.editFileType, "", row.fileName)){
							editFile(options, options.editFileUrl, fileCallbackDatagrid, !options.isEdit, row);
							$(this).datagrid('unselectRow',rowIndex);
							$(this).datagrid('uncheckRow',rowIndex);							
						}
					}
				},	
                columns:[[   
                    {field:'fileId',        checkbox:true},
                    {field:'fileName',      title:'附件名称', width:'34%',   halign:'center',align:'left'  ,sortable:true,
                        formatter:function(value, currow, index){
                            //alert(currow.fileName +"\n"+ currow.fileType +"\n"+ options.editFileType);
                            if(isEditFile(options.editFileType, "", currow.fileName)){
                                value = "<span class='l-btn-left l-btn-icon-left'><span title='用金格控件打开' name='fileUpload_editable'  style='cursor:pointer;color:blue;' class='l-btn-text'>"+value+"</span><span class='l-btn-icon icon-mini-edit'>&nbsp;</span></span>";
                            }else{
                                value = "<label title='"+value+"'>"+value+"</label>";
                            }
                            return value;
                        }
                    },
                    {field:'fileSize',      title:'大小', width:'80px', halign:'center',align:'right',sortable:true, 
                        formatter:function(value, currow, index){
                            return value ? formatFileSize(parseFloat(value/1024).toFixed(1)) : value;
                        }
                    },
                    {field:'fileTime',      title:'上传时间', width:'165px', halign:'center',align:'center',sortable:true},
                    {field:'uploader_name', title:'上传人',   width:'75px',  halign:'center',align:'center',sortable:true},
                    {field:'fileEditTime',  title:'修改时间', width:'165px', halign:'center',align:'center',sortable:true},
                    {field:'remark_name',   title:'修改人',   width:'75px',  halign:'center',align:'center',sortable:true}
                ]]
            });
            var isAddFileBtn = options.isAdd;
            isAddFileBtn = options.triggerId ? false : isAddFileBtn;
            setGridBtn(fileCallbackDatagrid, [
                { id:'add',      display:isAddFileBtn},
                { id:'edit',     display:options.isEdit },
                { id:'delete',   display:options.isDel },
                { id:'view',     display:options.isEdit ?  false : options.isView }, 
                { id:'download', display:options.isDownload }
            ]);

            var gridPanel = $(fileCallbackDatagrid).datagrid("getPanel");
            //table中的场合，不现实折叠按钮
            var gridRegion = $(target).parent('[region]');
            var targetRegion = gridRegion.attr('region');			
            if(gridPanel&&targetRegion){
                gridPanel.panel({
                    tools: [{    
                        iconCls:'icon-expand', 
                        handler:function(){
                        	uploadObj.methods.toggleListStatus(target, false);
                        }    
                    }]                   
               });
            }
            
            // 调整表格宽度和高度
            /*
            var toutId = window.setTimeout(function(){
                $(fileCallbackDatagrid).datagrid("resize", {
                    width :target.offsetWidth,
                    height:options.callbackGridHeight
                });              
                $(target).find('.datagrid,.panel-header,.panel-body').css({
                    width:'100%'
                });
                toutId ? clearInterval(toutId) : null;
            }, 0);   */   
    
        }catch(e){
            isdebug ? alert('createCallbackDatagrid:\n'+e.message) : null;
        }
    }    

    // 编辑文件
    function editFile(options, editFileUrl, datagrid, isViewMode, myrow){
        try{
            var fileId =  "";
            var currow = myrow ? myrow : {};
            if(!myrow && datagrid){
                var checkedRows = $(datagrid).datagrid('getChecked');                         
                if(checkedRows){
                    if(checkedRows.length == 0){
                        var selectedRow = $(datagrid).datagrid('getSelected');
                        //alert(selectedRow +','+selectedRow.fileId)
                        if(selectedRow){
                            currow = selectedRow;
                        }else{
                            showMsg(options, '请勾选要编辑的文件！');
                            return; 
                        }
                    }else if(checkedRows.length > 1){
                        unselectAll(datagrid);
                        showMsg(options, '一次只能编辑一个文件！');
                        return;
                    }else{
                        currow = checkedRows[0];
                    }                   
                }else{
                    showMsg(options, '请勾选要编辑的文件！');
                    return;
                }             
            }
            fileId = currow.fileId; 
            if(fileId){
                if(isEditFile(options.editFileType, null, currow.fileName)){
                    var sizeJson = getWinSize(options);
                    editFileUrl = editFileUrl+fileId;
                    editFileUrl = isViewMode ? editFileUrl+"&r=t&u=0" : editFileUrl;
                    windowOpen(editFileUrl, sizeJson.width, sizeJson.height);
                }else{
                    showMsg(options, '['+currow.fileName+']不能用控件编辑！');
                }
            }
        }catch(e){
            isdebug ? alert("fileUpload.editFile:\n"+e.message) : null;
        }
    }
    
    // 判断文件是否可以用金格控件进行编辑（目前仅限于编辑office的 word excel）
    function isEditFile(editFileType, fileType, fileName){
        try{
            //alert(fileName +'\n'+ fileType +'\n'+ editFileType)
            var rt = false;           
            if(editFileType){
                if(!fileType && fileName){
                    var suffix = "";
                    var suffIndex = fileName.lastIndexOf('.'); 
                    if(suffIndex != -1){
                        suffix = fileName.substr(suffIndex + 1);
                    }
                    fileType = suffix; 
                }                
                if(fileType){
                    for(var i=0; i<editFileType.length; i++){
                        if(fileType == editFileType[i]){
                            rt = true;
                            break;
                        }
                    }
                }
            }
            return rt;
        }catch(e){
            isdebug ? alert("fileUpload.isEditFile:\n"+e.message) : null;
        }
    }
    
    function windowOpen(url, width, height){
        try{
            if(url){
                window.open(url,"", "width="+screen.availWidth +"px,height="+screen.availHeight +"px,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no");
            }
        }catch(e){
            isdebug ? alert("fileUpload.windowOpen:\n"+e.message) : null;
        }
    }
    
    function unselectAll(datagrid){
        try{
            if(datagrid){
                 $(datagrid).datagrid('uncheckAll');
                 $(datagrid).datagrid('unselectAll');   
            }
        }catch(e){
            isdebug ? alert("fileUpload.unselectAll:\n"+e.message) : null;
        }
    }
    
    /*删除选中的附件
	datagrid添加idField:'fileId'后，每次删除时，都会把上一次选中的包括进去，即前一次删除一条，这次选中一条，
	会提示选中两条（每次选中的累加）
	*/
    function deleteFiles(options, deleteFilesUrl, datagrid){
        try{           
            if(deleteFilesUrl && datagrid){               
                var topW$ = window.top.$;
                var doc$ = topW$ ? topW$ : $;
                
                var checkedRows = $(datagrid).datagrid('getChecked');
                var fileIds = [];
                if(checkedRows && checkedRows.length){
                    $.each(checkedRows, function(i, info){
						//alert(i+"\n"+info.fileId)
                        fileIds.push(info.fileId);
                    });
                    if(fileIds.length == 0){
                        showMsg(options, '无法获得要删除的行记录！');
                        //doc$.messager.alert('提示信息','无法获得要删除的行记录！', 'warning');
                        return;
                    }                   
                }else{
                    showMsg(options, '请勾选要删除的文件！');
                    //doc$.messager.alert('提示信息','请勾选要删除的文件！', 'warning');
                    return;
                }
				//alert("fileIds:"+fileIds)
                doc$.messager.confirm('提示','您选择了[<font color=red>'+fileIds.length+'</font>]条记录，确认删除吗？', function(r){
                    if(r){
                        deleteFilesAction(options, fileIds, function(){
                            $(datagrid).datagrid('reload');
                        });
                    }else{
                         unselectAll(datagrid);
                    }
                });
            }
        }catch(e){
            isdebug ? alert("fileUpload.deleteFiles:\n"+e.message) : null;
        }
    }
        
    // 设置datagrid 列的short短长度显示
    function getShortCol(value,rowData,rowIndex){
        var rtval = "", n1=13, n2=5;
        var rlen = value.rlength();
        var len = value.length;
        var maxlen = 20;
        if(rlen > maxlen){
            var arr = [];
            arr.push(value.substr(0,n1));
            arr.push("...");
            arr.push(value.substr(len-n2));
            rtval = arr.join('');
        }else{
            rtval = value;
        }
        return "<label href='javascript:void(0)' title='"+value+"'>"+rtval+"</label>";
    }
    
    // 删除文件动作ajax
    function deleteFilesAction(options, fileIds, callbackFn){
        try{
             var doc$ = options.targetWin.$;
             doc$.ajax({
                url :options.deleteFilesUrl,
                dataType:'json',
                data:{
                    'fileIds':fileIds.join(',')
                },
                type:"POST",
                beforeSend:function(){
                    if(options.onDeleteFile && typeof options.onDeleteFile == 'function'){
                        return options.onDeleteFile.call(options.target, fileIds, options);
                    }
                    return true;
                },
                success: function(data){
                    doc$.messager.progress('close');
                    if(data){
                        if(options.onDeleteFileSuccess && typeof options.onDeleteFileSuccess == 'function'){
                            var uploadFiles = $(options.target).data('uploadFiles');
                            var newFiles = [];
                            if(uploadFiles && uploadFiles.length > 0){

                                $.each(uploadFiles,function (i,f) {
                                    if(fileIds.indexOf(f.fileId) < 0){
                                        newFiles.push({
                                            'fileId':f.fileId,
                                            'fileName':f.fileName
                                        });
                                    }
                                });
                                $(options.target).data('uploadFiles', newFiles);
                            }
                            options.onDeleteFileSuccess.call(options.target, data, fileIds, options);
                        }
                        showMsg(options, data.msg, function(){
                            callbackFn ? callbackFn() : null; ;     
                        });
                    }                             
                },
                error:function(data){
                    doc$.messager.progress('close');
                    doc$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
        }catch(e){
            isdebug ? alert("fileUpload.deleteFilesAction:\n"+e.message) : null;
        }
    }
	
	//根据fileGuid删除全部附件
    function deleteAllFiles(options, fileGuid, callbackFn){
        try{
             var doc$ = options.targetWin.$;
             doc$.ajax({
                url :options.deleteFilesUrl,
                dataType:'json',
                data:{
                    'fileGuid':fileGuid
                },
                type:"POST",
                beforeSend:function(){
                    if(options.onDeleteFile && typeof options.onDeleteFile == 'function'){
                        return options.onDeleteFile.call(options.target, fileGuid, options);
                    }
                    return true;
                },
                success: function(data){
                    doc$.messager.progress('close');
                    if(data){
                        if(options.onDeleteFileSuccess && typeof options.onDeleteFileSuccess == 'function'){
                            options.onDeleteFileSuccess.call(options.target, data, fileGuid, options);
                        }
                        showMsg(options, data.msg, function(){
                            callbackFn ? callbackFn() : null; ;     
                        });
                    }                             
                },
                error:function(data){
                    doc$.messager.progress('close');
                    doc$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                }
            });
        }catch(e){
            isdebug ? alert("fileUpload.deleteAllFiles:\n"+e.message) : null;
        }
    }
    
    // 把附件打包
    function downloadFiles(options, downloadFilesUrl, datagrid, fileIds, zipPackageName){
        try{
            if(downloadFilesUrl){
                var topW$ = window.top.$;
                var doc$ = topW$ ? topW$ : $;
                fileIds = fileIds ? fileIds : [];
                
                if(datagrid){
                    var checkedRows = $(datagrid).datagrid('getChecked');            
                    if(checkedRows && checkedRows.length){
                        $.each(checkedRows, function(i, info){
                            fileIds.push(info.fileId);
                        });
                        if(fileIds.length == 0){
                            showMsg(options, '无法获得要下载的行记录！');
                            //doc$.messager.alert('提示','无法获得要下载的行记录！', 'warning');
                            return;
                        }else if(fileIds.length == 1){
                            zipPackageName = checkedRows[0].fileName;
                        }                   
                    }else{
                        showMsg(options, '请勾选要下载的文件！');
                        //doc$.messager.alert('提示信息','请勾选要下载的文件！', 'warning');
                        return;
                    } 
                }
                //alert($(options.downloadFileForm).length)
                //alert('downloadFiles='+fileIds)
                $(options.downloadFileForm).find("input[fileIds]").val(fileIds.join(','));
                $(options.downloadFileForm).find("input[zipFile]").val(options.zipFile);
                //alert('zipPackageName='+zipPackageName)
                $(options.downloadFileForm).find("input[packageName]").val(zipPackageName ? zipPackageName : options.zipPackageName);
                
                $(options.downloadFileForm).form('submit', {
                    url     :downloadFilesUrl,
                    onSubmit: function(param){
                        //alert('onSubmit')
                        doc$.messager.progress();
                        return true;
                    },
                    success: function(data){
                        //alert('success data='+data)
                        doc$.messager.progress('close');// 如果提交成功则隐藏进度条
                        if(data){
                            var json = (new Function("return " + data))();
                            var type = json.type;
                            var msg  = json.msg;
                            msg ? showMsg(options, msg) : null;
                        }
                    },
                    onLoadError:function(){
                        doc$.messager.progress('close');
                    }
                });
                doc$.messager.progress('close');// 如果提交成功则隐藏进度条
                $(options.downloadFileForm).find("input[fileIds]").val('');
                datagrid ? unselectAll(datagrid) : null;
            }
        }catch(e){
            isdebug ? alert("fileUpload.zipToTmpDisk:\n"+e.message) : null;
        }
    }

    // 加载回显文件-menubutton形式的
    function loadFileEchoRows(options, queryParams){
        try{
            var fileData = uploadObj.methods.getUploadFiles(options.target, queryParams ? queryParams : {});
            //alert('fileData='+fileData+"\nrows="+fileData.rows)
            if(fileData && fileData.rows){
                var fileRows = fileData.rows;
                var fileNameArr = [];
                var fileIdArr = [];
                var fileCommitStatusArr = [];
                $.each(fileRows, function(m, row){
                    fileNameArr.push(row.fileName);
                    fileIdArr.push(row.fileId);
                    fileCommitStatusArr.push(row.commit_status==null ? '' : row.commit_status);
                });
				//记录已经上传的文件
                $(options.target).data('uploadFiles', fileRows);
            }
            createFileEchoRows(options, fileNameArr, fileIdArr, true, fileCommitStatusArr);
        }catch(e){
            isdebug ? alert("fileUpload.loadFileEchoRows:\n"+e.message) : null;
        }
    }
   
    // menuButton 形式， 以文件名列表形式展示，一个文件名称就是一行
    function createFileEchoRows(options, fileNames, fileIds, refresh, fileCommitStatuss){
        try{
            if(fileNames && fileIds){
                var container = options.target;
                var fileMenuId = $(container).data("fileMenuId");
                if(refresh){
                   //fileMenuId ? $('#'+fileMenuId).remove() : "";
                   $(container).html('');
                }
                // menu菜单只能生成一个（条目都一样所以只生成一个），每个文件mouseover时把自己文件信息复制为menuItem
                if(fileMenuId == null || fileMenuId == undefined || fileMenuId == ""){
                    fileMenuId = "fileMenu_"+genRandNum();
                    options.fileMenuId = fileMenuId;
                    genFileMenuHtml(fileMenuId, options);
                    $(container).data("fileMenuId", fileMenuId);
                }
                var fileNameArr = $.type(fileNames) == "array" ? fileNames : fileNames.split(",");
                var fileIdArr   = $.type(fileIds)   == "array" ? fileIds   : fileIds.split(",");
                var fileCommitStatusArr = [];
                if (fileCommitStatuss){
                    fileCommitStatusArr = $.type(fileCommitStatuss) == "array" ? fileCommitStatuss : fileCommitStatuss.split(",");
                }else{
                    for(var i=0; i<fileIdArr.length; i++){
                        fileCommitStatusArr.push('');
                    }
                }
                $.each(fileNameArr, function(i, fileName){
                    var shortName = options.showShortFileName ? getFileShortName(fileName, options.shortFileNameSize, container, options.charPixel) : fileName;
                    var fileMenubtnId = 'fileMenuBtn_'+genRandNum();
                    var fileLink = [];
                    fileLink.push("<a ");
                    fileLink.push(options.fileWrap ? " style='display:block;float:left;clear:both;' " : " ");
                    fileLink.push(" title='");
                    fileLink.push(fileName);
                    fileLink.push("' href='javascript:void(0)' id='");
                    fileLink.push(fileMenubtnId);
                    fileLink.push("' >");
                    fileLink.push(shortName);
                    fileLink.push("</a>");
                    try{
                        //alert('fileMenuId='+fileMenuId)
                        //alert($('#'+fileMenuId).html());
                        var fileM = $(fileLink.join('')).data('fileId', fileIdArr[i]).appendTo(container).menubutton({    
                            iconCls: 'icon-attachment',    
                            menu   : '#'+fileMenuId
                        }).bind("mouseover", function(){
                            var commit_status = fileCommitStatusArr[i];

                            var isCanEdit = $(this).data('isCanEdit');
                            if(isCanEdit == undefined || isCanEdit == null || isCanEdit == ""){
                                isCanEdit = isEditFile(options.editFileType, "", fileName) && commit_status!='Y';
                                $(this).data('isCanEdit', isCanEdit);
                            }

                            $('#'+fileMenuId).find("div[item='true']").attr({
                                'fileName':fileName,
                                'fileId'  :fileIdArr[i],
                                'fileMenubtnId':fileMenubtnId
                            }).each(function(i, item){
                                var itemName = $(item).attr('name');
                                if(itemName && (itemName == 'fileEdit' || itemName == 'fileView')){
                                    $(item).css('display', isCanEdit ? 'block' : 'none');
                                }
                                if(itemName && itemName == 'fileDel'){
                                    $(item).css('display', commit_status!='Y' ? 'block' : 'none');
                                }
                            });
                        });  
                    }catch(e){
                        //alert(e.message)
                    }
                    fileLink = null;
                });
                $('#'+fileMenuId).menu({
                    onClick:function(item){
                        var name = item.name;
                        var fileId = $(item.target).attr('fileId');
                        //alert("menuItem click\nname="+name+"\nfileId="+fileId)
                        if(fileId && name){
                            var fileName = $(item.target).attr('fileName');
                            var fileMenubtnId = $(item.target).attr('fileMenubtnId');
                            var fileIds = [];
                            fileIds.push(fileId);
                            var myrow = {
                                'fileId':fileId,
                                'fileName':fileName,
                                'fileType':''
                            };
                            if(name == "fileAdd"){
                                openAddFileWindow(options);
                            }else if(name == "fileEdit"){
                                editFile(options, options.editFileUrl, null, false, myrow);
                            }else if(name == "fileDel"){
                                top.$.messager.confirm('提示信息','您确认删除【'+fileName+'】吗？', function(r){
                                    if(r){
                                        deleteFilesAction(options, fileIds, function(){
                                            $('#'+fileMenubtnId).remove();
											//删除后，更新缓存数组
											var tmpUploadFiles = [];
											var uploadFiles = $(options.target).data('uploadFiles');
											if(uploadFiles && uploadFiles.length){
												$.each(uploadFiles, function(i, row){
													if(row['fileId'] != fileIds){
														tmpUploadFiles.push(row);
													}
												});
												//alert('tmpUploadFiles:'+tmpUploadFiles);
												if(tmpUploadFiles && tmpUploadFiles.length){
													$(options.target).data('uploadFiles', tmpUploadFiles);
												}
											}
                                        });
                                    }
                                });
                            }else if(name == "fileView"){
                                editFile(options, options.editFileUrl, null, true, myrow);
                            }else if(name == "fileDownload"){
                                downloadFiles(options, options.downloadFilesUrl, null, fileIds, fileName);
                            } 
                        }
                    }
                })
            }
        }catch(e){
            isdebug ? alert("fileUpload.createFileEchoRows:\n"+e.message) : null;
        }
    }

    // 生成按钮菜单html
    function genFileMenuHtml(menuId, options){
        try{
            var arr = [];
            var menu = $("<div id='"+menuId+"'>").appendTo(options.target);
            if(options.isAdd && !options.triggerId){
               $("<div style='padding: 0px;' data-options=\"iconCls:'icon-add'\" name='fileAdd' item='true'>添加</div>").appendTo(menu);
            }
            if(options.isEdit){
               $("<div style='padding: 0px;' data-options=\"iconCls:'icon-edit'\" name='fileEdit' item='true'>编辑</div>").appendTo(menu);
            }else if(options.isView){
               $("<div style='padding: 0px;' data-options=\"iconCls:'icon-view'\" name='fileView' item='true'>查看</div>").appendTo(menu);
            }
            if(options.isDel){
               $("<div style='padding: 0px;' data-options=\"iconCls:'icon-delete'\" name='fileDel' item='true'>删除</div>").appendTo(menu);
            }
            if(options.isDownload){
               $("<div style='padding: 0px;' data-options=\"iconCls:'icon-export'\" name='fileDownload' item='true'>下载</div>").appendTo(menu);
            }
        }catch(e){
            isdebug ? alert("fileUpload.genFileMenuHtml:\n"+e.message) : null;
        }
    }
    
    // 获得短文件名称
    function getFileShortName(fileName, shortFileNameSize, container, charPixel){
        try{
            // 一个汉字占屏幕的像素数
            charPixel = charPixel ? charPixel : 8;
            var rtname = fileName;
            if(fileName && shortFileNameSize && container){
                var flen = fileName.rlength();
				//alert(fileName+"\n"+flen)
                var sindex = fileName.lastIndexOf(".");
                var suffix = fileName.substr(sindex+1);
                var fname = fileName.substr(0, sindex);
                var textsize = -1;
                if(shortFileNameSize == 'auto'){
                    var cwidth = $(container).width();
                    if(cwidth){
                        textsize = parseInt(cwidth/charPixel);
                    }
                }else if(isNumber(shortFileNameSize)){
                    textsize = parseInt(shortFileNameSize);
                }
                var beginOffset = parseInt(textsize/2);
                var endOffset = textsize - beginOffset;
				//alert('textsize='+textsize+'\nflen='+flen);
                if(textsize > 0 && flen > textsize){
                    var namearr = [];
                    namearr.push(fname.substr(0, beginOffset));
                    namearr.push("...");
                    namearr.push(fname.substr(flen - endOffset));
                    namearr.push(".");
                    namearr.push(suffix);
                    rtname = namearr.join('');
                    namearr = null;
                }
            }
            return rtname;
        }catch(e){
            isdebug ? alert("fileUpload.getFileShortName:\n"+e.message) : null;
        }
    }
    
    function isNumber(obj) {  
        return typeof obj === 'number' && !isNaN(obj)  
    }
       
    /**
        设置表格按钮的名字或者状态
        参数：gridObject　-　domObject, 表格dom对象
              btnArr      -  [], 按钮数组，每个一个元素为一个json对象，
              包括如下信息[{
                'index':1, // 按钮的下标从1开始，如果超过实际按钮数组的最大长度，则默认为指向最后一个按钮
                'name' :'newName',//指定按钮的新名字
                'display':true/false, // 按钮的状态，true：显示 or  false：隐藏
                'icon':'cut', // 按钮样式，eg：’cut，save， add '等
                'disabled':'tue/false' // 按钮是否可用
              },{}]
    */
    function setGridBtn(gridObject, btnArr){
        try{
            // 判断表格对象和数组
            if(!gridObject || !btnArr || jQuery.type(btnArr) != 'array' || btnArr.length == 0){
                throw new Error('参数错误！gridObject, btnArr或为null');
                return false;
            }
            // 获得按钮工具栏对象
            var toolbar = $(gridObject).parent('.datagrid-view').prev('.datagrid-toolbar');
            if(!toolbar || toolbar.length == 0) {
                throw new Error('找不到class为datagrid-toolbar的工具栏对象');
                return false;
            }          
            var gridBtns = $(gridObject).data('gridBtns');
            //for(var p in gridBtns) alert(p+"="+gridBtns[p])
            // 按钮wrap对象
            var btnPlain = toolbar.find('.l-btn-plain');
            if(btnPlain.length>0){
                var len = btnPlain.length;
                if(btnArr && btnArr.length>0){
                    for(var i=0; i<btnArr.length; i++){
                        var btnJson = btnArr[i];
                        var btnId = btnJson.id || btnJson.ID || btnJson.Id;
                        var icon  = btnJson.icon;                        
                        var newName = btnJson.name;
                        var index   = btnJson.index;
                        var display = btnJson.display;
                        var disabled = btnJson.disabled;
                        
                        var wrap = null;
                        if(btnId && gridBtns){// id来定位button
                            wrap = toolbar.find('#'+gridBtns[btnId]);
                        }else{// index 来定位button
                            if(index < 0){
                                index = 1;
                            }
                            if(index > len){
                                index = len;
                            }
                            wrap = btnPlain[index-1]; 
                        }
                        
                        if(wrap && wrap.length){
                            var separator = $(wrap).parent().next('td').find('.datagrid-btn-separator');
                            
                            if(display == true || display == 'true'){
                                $(wrap).show();
                                separator&&separator.length>0 ? separator.show() : null;
                            }else if(display == false || display == 'false'){
                                $(wrap).hide();
                                separator&&separator.length>0 ? separator.hide() : null;
                            }
                            
                            if(disabled == true || disabled == 'true'){
                                $(wrap).attr({'disabled':true, 'disabled':'disabled'});//alert(1)
                            }else if(disabled == false || disabled == 'false'){
                                $(wrap).removeAttr('disabled');//alert(2)
                            }
                            
                            var btnTxt = $(wrap).find('.l-btn-text');
                            if(newName){   
                                btnTxt && btnTxt.length>0 ? $(btnTxt).html(newName) : null;
                            }
                            if(icon){
                                btnTxt && btnTxt.length>0 ? $(btnTxt).removeClass().addClass('1-btn-text').addClass('icon-'+icon):null;
                            } 
                        }
                    }
                }else{
                	return false;
                }
            }else{
            	return false;
            }
            return true;
        }catch(e){
            isdebug ? alert("fileUpload.setGridBtn:\n"+e.message) : null;
        }
    }

    // 响应键盘事件
    function setKeyupEvent(options){
        try{
            var targetWin = options.targetWin;
            var  isSetFileUploadKeyupEvent = targetWin.$("body").data('isSetFileUploadKeyupEvent');
            //alert('isSetFileUploadKeyupEvent='+isSetFileUploadKeyupEvent)
            if(!isSetFileUploadKeyupEvent){
                //alert('setKeyup')
                targetWin.$("body").off('keyup', onFileUploadKeyUpEvent).on('keyup', onFileUploadKeyUpEvent); 
            }
            
            function onFileUploadKeyUpEvent(event){
                //alert(event.keyCode)
                targetWin.$("body").data('isSetFileUploadKeyupEvent', true);
                switch(event.keyCode) {
                    case 27://esc关闭窗口
                        //alert('close window')
                        options.autoCloseOnEsc ? targetWin.$(options.fileDialog).dialog('close') : null;
                        targetWin.$("body").data('isSetFileUploadKeyupEvent', false).off('keyup', onFileUploadKeyUpEvent);
                        break;
                    case 32://空格键上传文件
                        //alert('upload files and close window')
                        //var isOpen = targetWin.$(options.fileDialog).data('isOpen');
                        if(targetWin.$(options.fileDialog).data('isOpen') && options.spaceSumibtFiles){
                            if(submitFiles(options)){
                                options.closeAfterUpload ? targetWin.$(options.fileDialog).dialog('close') : null;
                                targetWin.$("body").data('isSetFileUploadKeyupEvent', false).off('keyup', onFileUploadKeyUpEvent);
                            }
                        }
                        break;
                }
            }
        }catch(e){
            isdebug ? alert("fileUpload.setEscEvent:\n"+e.message) : null;
        }
    }

    // 处理查询参数
    function getFileGridParams(defaultParams, queryParams){
        try{
            var params = queryParams;
            if(queryParams && $.type(queryParams) == 'object'){                
                params = $.extend({}, defaultParams, queryParams);
            }
            return params ? params : defaultParams;
        }catch(e){
           isdebug ? alert('fileUpload.getFileGridParams:\n'+e.message) : null; 
        }
    }
    
    // 判断浏览器版本，IE8加载上传界面是以后版本时间的两倍，IE8用时0.8，IE11用时0.4， chrom用时0.14s
    function getBrowserInfo(){
        try{
            var bro = $.browser;
            var binfo = "";
            var bname = "";
            var version = bro.version;
            if(bro.msie){ 
                bname = "IE";
                binfo = "Microsoft Internet Explorer " + version;
            }
            if(bro.mozilla) {
                bname = "Firefox";
                binfo = "Mozilla Firefox " + version;
            }
            if(bro.safari) {
                bname = "Safari";
                binfo = "Apple Safari " + version;
            }
            if(bro.opera) {
                bname = "Opera";
                binfo = "Opera " + version;
            }
            return {
                'version':version,
                'name':bname,
                'info':binfo
            };
        }catch(e){
            isdebug ? alert('fileUpload.getBrowserInfo:\n'+e.message) : null; 
        }
    }    
    
    // 方法
    uploadObj.methods = {
        options:function(jqTarget){
            try{
                return $(jqTarget).eq(0).data('fileUpload').options;
            }catch(e){
                isdebug ? alert('fileUpload.method.options:\n'+e.message) : null;
            }
        },
		/*
		* 根据fileGuid删除已经上传的附件, 没有参数则默认为当前的表格fileGuid
		*/
		deleteAll:function(jqTarget, fileGuid){
			try{
                var options = uploadObj.methods.options(jqTarget);
				fileGuid = fileGuid || options.fileGuid;
				deleteAllFiles(options, fileGuid, function(){
					uploadObj.methods.reloadFile(jqTarget);
				});
            }catch(e){
                isdebug ? alert('fileUpload.method.clear:\n'+e.message) : null;
            }
		},
		/*
		上传附件
		*/
		submitFiles:function(jqTarget){
			try{
                var options = uploadObj.methods.options(jqTarget);
				submitFiles(options);
            }catch(e){
                isdebug ? alert('fileUpload.submitFiles.clear:\n'+e.message) : null;
            }
		},
        /*
        （echoType=2）回显为menubutton时，为menubutton添加自定义条目
         参数：itemArray 数组，里面的每个元素为一个json对象 ｛｝
         eg: // 第一种写法, 添加多个menu条目
             $('#objId').fileUpload('addmenutiem',[{
                 text:'发送消息',
                 iconCls:'icon-msg',
                 handler:function( fileId, fileName){
                     // 自定义响应函数 fileId：选中文件ID，fileName：选中文件的名称
                }
             },{
                 text:'发送邮件',
                 iconCls:'icon-email',
                 handler:function(fileId, fileName){}
             }]);
             $('#objId').fileUpload('addmenutiem',{
                 text:'自定义按钮',
                 iconCls:'icon-ok',
                 handler:function(fileId, fileName){}
             });
             // 第二种写法, 添加单个menu条目
             $('#upload07').fileUpload('addmenutiem',{
                 handler:function(fileId, fileName){
                     alert("自定义\nfileId="+fileId+"\nfileName="+fileName);
                 }
             });
        */
        addmenutiem:function(jqTarget, itemArray){
            try{
                if(itemArray){
                    var myItems = [];
                    if($.type(itemArray) === "array"){
                        myItems = itemArray;
                    }else if(typeof itemArray == "object"){
                        myItems.push(itemArray);
                    }
                    var itemLen = myItems.length;
                    if(itemLen){
                        var options = $(jqTarget).eq(0).data('fileUpload').options;
                        if(options){
                            //alert(options.fileMenuId)
                            var menu = $('#'+options.fileMenuId)[0];
                            if(menu){
                                $.each(myItems, function(i, item){
                                    var iconCls = item.iconCls ? item.iconCls : "icon-ok";
                                    var itemId = item.id ? item.id : "fileUpload_menuItem_"+genRandNum();
                                    var tmp = [];
                                    tmp.push("<div class='menu-item' style='padding:0px;'");
                                    tmp.push("data-options = \"");
                                    tmp.push("iconCls = '");
                                    tmp.push(iconCls);
                                    tmp.push("' ");
                                    tmp.push("\" ");
                                    tmp.push("id='");
                                    tmp.push(itemId);
                                    tmp.push("' ");
                                    tmp.push("name='");
                                    tmp.push(itemId);
                                    tmp.push("' ");
                                    tmp.push("item = 'true'><div class='menu-text'>");
                                    tmp.push(item.text ? item.text : "自定义条目");
                                    tmp.push("</div><div class='menu-icon ");
                                    tmp.push(iconCls);
                                    tmp.push("'>");
                                    tmp.push("</div></div>");
                                    $(menu).append(tmp.join(''));
                                    tmp = null;
                                    // 注册事件
                                    if(item.handler && $.type(item.handler) === "function"){
                                        $(menu).find("#"+itemId).last().bind('click', function(e){
                                            var filename = $(this).attr('filename');
                                            var fileid = $(this).attr('fileid');
                                            //alert(filename+"\n"+fileid);
                                            //alert(item.handler)
                                            item.handler.call(this, fileid, filename);                                          
                                        }).bind('mouseover',function(){
                                            $(this).addClass('m-btn-plain-active');
                                        }).bind('mouseout',function(){
                                            $(this).removeClass('m-btn-plain-active');
                                        });
                                    }
                                });
                            }
                        }  
                    }              
                }
            }catch(e){
                isdebug ? alert('fileUpload.method.addmenutiem:\n'+e.message) : null;
            }
        },      
        /*
         设置控件的属性property
         参数：key ：可以为String， 或者json 对象
               value：String
         使用：
            1.$('#objId').fileUpload('property','fileGuid','-1');
            2.$('#objId').fileUpload('property',{
                'fileGuid':'-1',
                'msgAlign':'bottom'
            });
        */
        property:function(jqTarget, key, value){
            try{
                var options = $(jqTarget).eq(0).data('fileUpload').options;
                if(options && key){
					if(value){
						if($.type(value) === 'string'){
							options[key] = value;
						}else if(typeof value == "object"){
							options = $.extend(options, uploadObj.defaults, key);
						}
						options.callbackGridParams.query_eq_guid = options.fileGuid;
						options.maxFileCount == 1 ? options.multiple = false : null;
					}else{
						return options[key];
					}
                }
            }catch(e){
                isdebug ? alert('fileUpload.method.property:\n'+e.message) : null;
            }
        },
        /*
        获得已经上传的文件信息【getUploadFiles】
        参数:queryParams, json类型, 
            如果没有指定查询条件，则使用默认回显表格查询参数options.callbackGridParams，
            options.callbackGridParams:{
                query_eq_guid:'',
                boName  :'FileBean',
                pkName  :'fileId'
            }
            如果指定查询条件，则会用新的查询条件覆盖callbackGridParams（相同项覆盖extends）
            例如：
            $(fileUploadObj).fileUpload('getUploadFiles', {
                query_like_fileName:'法规' // 主要针对FileBean的属性进行查询
            });
        返回值：json类型
                {   total:2,
                    initPage:1,
                    initPageSize:10,
                    type:'success',
                    rows:[{
                       'fileId':uuid,
                       'fileName':'xxx.doc',
                       'fileTime':'2016-04-28 13:19:06',
                       'uploader_name':'管理员',
                       'fileEditTime' :'2016-04-28 13:19:06',
                       'remark_name':'管理员'     
                    },{....}]
                }
        
        */
        getUploadFiles:function(jqTarget, queryParams, isReloadFileGrid){
            try{
                //alert('getUploadFiles:\n'+jqTarget+"\n"+ queryParams)
                var rtData= {};
                var options   = uploadObj.methods.options(jqTarget);
                //alert('getUploadFiles options='+options)
                var pageSize  = options.maxQueryFiles;
                var targetWin = options.targetWin;
                var params = getFileGridParams($.extend({pageSize:pageSize}, options.callbackGridParams), queryParams);              
                //for(var p in params) alert(p+"="+params[p]);
                if(params){
                    $.ajax({
                        url :options.fileCallbackGridUrl,
                        dataType:'json',
                        data:params,
                        type:"POST",
                        async:false,
                        beforeSend:function(){
                            targetWin.$.messager.progress();
                            return true;
                        },
                        success: function(data){
                            targetWin.$.messager.progress('close');
                            if(data){
                               //alert('data='+data)
                               rtData = data; 
                               if(isReloadFileGrid){
                                   // 刷新回显文件表格
                                   var gridObj = options.fileCallbackDatagrid;
                                   if(gridObj){
                                       $(gridObj).datagrid("loadData", data);
                                   }
                               }
                            }                             
                        },
                        error:function(data){
                            targetWin.$.messager.progress('close');
                            targetWin.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                        }
                    });
                }else{
                    throw new Error("params is null in method of getUploadFiles!");
                }
                //for(var p in rtData) alert(p+"="+rtData[p]);
                return rtData;
            }catch(e){
                isdebug ? alert('fileUpload.method.getUploadFiles:\n'+e.message) : null;  
            }          
        },
        /*
            刷新文件回显表格[reloadFileGrid]
            参数：queryParams， json类型， 参见方法：getUploadFiles
        */
        reloadFileGrid:function(jqTarget, queryParams){
            try{
                return uploadObj.methods.getUploadFiles(jqTarget, queryParams ? queryParams : {}, true);
            }catch(e){
                isdebug ? alert('fileUpload.method.reloadFileGrid:\n'+e.message) : null;
            }
        },
        /**
          刷新回显文件 - menubutton 形式 [reloadFileMenuBtn]
          参数：queryParams， json类型
        */
        reloadFileMenuBtn:function(jqTarget, queryParams){
            try{
                var options   = uploadObj.methods.options(jqTarget);
                loadFileEchoRows(options, queryParams);
                //return uploadObj.methods.getUploadFiles(jqTarget, queryParams ? queryParams : {}, true);
            }catch(e){
                isdebug ? alert('fileUpload.method.reloadFileMenuBtn:\n'+e.message) : null;
            }
        },
        /**
          刷新回显文件，根据echoType的值，自动去判断回显方式[reloadFile]
          参数：queryParams， json类型
        */
        reloadFile:function(jqTarget, queryParams){
            try{
                var options  = uploadObj.methods.options(jqTarget);
                var echoType = options.echoType;
                if(echoType == 1){
                    return uploadObj.methods.getUploadFiles(jqTarget, queryParams ? queryParams : {}, true);
                }else if(echoType == 2){                   
                    loadFileEchoRows(options, queryParams);
                }
            }catch(e){
                isdebug ? alert('fileUpload.method.reloadFile:\n'+e.message) : null;
            }
        },
        /**
         * 设置grid按钮的状态(显示或者隐藏)
         * 参数：gridObj - 表格对象
         * 		btnArr  - 数组 
         *     例如：[{ index:1, display:true}] true:显示， false：隐藏
         */
        setGridBtn:function(jqTarget, btnArr){
        	try{
        		var options  = jqTarget ? uploadObj.methods.options(jqTarget) : null;
        		var gridObj = options ? options.fileCallbackDatagrid : null;
        		if(gridObj){
        			setGridBtn(gridObj, btnArr);
        		}
        	}catch(e){
        		isdebug ? alert('fileUpload.method.setGridBtn:\n'+e.message) : null;
        	}
        },
        /**
         * 当列表展现回显附件，设置列表折叠/展开
		 * isExpand:true 展开，false：折叠
         */
		toggleListStatus:function(jqTarget, isExpand){
        	try{
        		var options  = jqTarget ? uploadObj.methods.options(jqTarget) : null;
        		var gridObj = options ? options.fileCallbackDatagrid : null;
        		if(gridObj){
					// 获得回显表格所在的layout控件
					var gridRegion = $(jqTarget).parent('[region]');
					var targetRegion = gridRegion.attr('region');					
		            var gridParentlayout = gridRegion.parent();					
					while(gridParentlayout && gridParentlayout.length ){ 
						if(gridParentlayout.hasClass('easyui-layout') || gridParentlayout.get(0).nodeName == 'BODY'){
							break;
						}else{
							gridParentlayout = gridParentlayout.parent();
						}
					}
					//alert('isExpand='+isExpand)
					$(gridParentlayout).layout(isExpand ? 'expand' : 'collapse', targetRegion);
					var gridTitle = options.fileGridTitle ? options.fileGridTitle : '';
                    
	        		setTimeout(function(){        			
	        			var uploadFiles = $(options.target).data('uploadFiles');
	        			if(uploadFiles && uploadFiles.length){
	        				gridTitle = gridTitle +"&nbsp;["+uploadFiles.length+"]&nbsp;<span class='l-btn-icon icon-attachment'></span>"
	        			}
	        			$('.layout-expand-'+targetRegion).find('.panel-title').html(gridTitle);
	        		}, 0)
        		}
        	}catch(e){
        		isdebug ? alert('fileUpload.method.toggleListStatus:\n'+e.message) : null;
        	}
        },
        /**
         * 当列表展现回显附件，设置列表折叠
         * 
         */
		collapseList:function(jqTarget){
        	try{
        		uploadObj.methods.toggleListStatus(jqTarget, false);
        	}catch(e){
        		isdebug ? alert('fileUpload.method.collapse:\n'+e.message) : null;
        	}
        },
        /**
         * 当列表展现回显附件，设置列表展开
         * 
         */
		expandList:function(jqTarget){
        	try{
        		uploadObj.methods.toggleListStatus(jqTarget,true);
        	}catch(e){
        		isdebug ? alert('fileUpload.method.expand:\n'+e.message) : null;
        	}
        }
    }; 
    
    // 默认属性
    uploadObj.defaults = $.extend({}, uploadObj.defaults, {
        // 控件出错时是否输出调试信息
        isdebug:false,
		//属性singleSubmit：是否单独保存附件，true：上传后就保存到db；false：跟随主业务一并保存，默认true。
		singleSubmit:true,
        // 弹出窗口是否可以拖拽
        draggable:true,
        // 弹出窗口 - 如果设置为true，在窗体显示的时候显示阴影
        shadow:false,
        zIndex:9010,
        // 触发控件容器ID，会自动给它添加click事件，单击后会打开上传文件窗口
        triggerId:"",
        // 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
        uploadFace:0,
        /*
                     文件上传后，回显方式选择， 默认：1
        1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
        2：以文件名列表形式展示，一个文件名称就是一行
        3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
        */
        echoType:1,
		// echoType=2列表回显附件时，附件列表是否折叠（容器必须单独放在一个layout的region中，不能放在table的td中）
		collapseList:true,
        // echoType = 2, 文件是否换行， true：一个文件一行， false：都在一行
        fileWrap:true,
        //是否把弹出窗口显示在最顶层window，如果多层嵌套时，操作区域会太小
        topWindow:true,
        //esc关闭窗口
        autoCloseOnEsc:true,
        // space空格键上传文件
        spaceSumibtFiles:true,
        // 是否可以上传多个文件
        multiple:true, 
        // 上传文件类型
        suffixs:"pdf,wps,doc,docx,xls,xlsx,ppt,pptx,zip,rar,txt,png,gif,jpg,bmp,mp3,mp4,wma,wav,mov,flv,swf,rm,rmvb,midi,mid,avi,cd,ogg,3gp,asf,ape",
        // 不能上传的文件类型
        excludeSuffixs:"",
        // 每次最大上传文件个数， 默认：10个
        maxFileCount:10,
		// 上传文件的总数(包括已经上传的文件数)
		totalFileCount:50,
        // 单位文件最大size(单位K)，默认10M = 10240K
        maxSingleFileSize:51200,
        // 容纳弹出窗口的上下文document, 默认为当前页面的document
        targetWin:window,
        targetDoc:window.document,
        // 弹出窗口dom对象
        fileDialog:null,
        // 弹出窗口里文件列表对dom象（datagrid控件）
        fileDatagrid:null,
        // 提交file用的form表单
        submitFileForm:null,
        // 消息显示方式 1:弹出， 2：窗口里面提示， 3：1,2都有, 默认：2
        msgShowType:2,
        // 消息位置'top, bottom'
        msgAlign:'bottom',
        // 消息超时时间，单位毫秒，默认：5000，即：5s
        msgTimeout:5000,
        // 回显表格文件title
        fileGridTitle:'附件列表',
        // 文件上传保存对应的url
		submitFilesUrl: "/ais/commonPlug/commonUploadFiles.action",
        // 删除文件对应的URL
        deleteFilesUrl:"/ais/commonPlug/deleteFiles.action",
        // 下载文件对应的URL
        downloadFilesUrl:"/ais/commonPlug/downloadFiles.action",
        // 编辑文件对应的URL
        editFileUrl:"/ais/pages/commons/file/iweb.jsp?fileId=",
        // 查看文件对应的URL
        viewFileUrl:"/ais/pages/commons/file/iweb.jsp?view=view&fileId=",
        // 下载文件ZIP压缩包名称
        zipPackageName:"附件压缩包.zip",
        // 文件下载时，是否压缩，默认false不压缩
        zipFile:false,
        // 上传完毕后关闭窗口
        closeAfterUpload:true,
        // 打开时是否清空上次的上传记录
        clearCache:true,
        // 回显表格的高度
        callbackGridHeight:250,
        // 回显为grid表格时，附件所在td的前一个td的宽度, 单位可以是%或者px
        cbGridPrevTdWidth:'15%',
        // 弹出窗口默认参数
        dialogOptions:{
            title: "附件上传",
            resizable:true,
            collapsible:true,
            closed:true,
            modal:true,
            iconCls:'icon-import'
        },    
        // 文件上传说明-帮助说明
        helpMsg:"通用文件上传，支持对类型、大小、数量、重复文件的检查，支持多文件上传",       
        fileListContainer:'',
        // 具体业务对应附件的guid
        fileGuid:'',
        // 是否可以添加附件
        isAdd:true,
        // 是否可以编辑附件
        isEdit:true,
        // 是否可以删除附件
        isDel:true,
        // 是否可以查看附件
        isView:true,
        // 是否可以下载附件
        isDownload:true,
        // 回显表格查询URL
        fileCallbackGridUrl:"/ais/commonPlug/genUploadFileTable.action",
        // 是否显示加载所用时间，单位秒
        loadtime:false,
        // 强制上传文件大小检查，如果不符合则不能上传
        forceCheck:true,
		// 检查选择的文件是否已经上传 checkSameFile：true进行检查，否则不进行检查
		checkSameFile:true,
		// checkSameFile == true时生效，true:弹出confirm提示框决定是否上传重复文件；false：仅仅消息提示
		checkSameFileConfirm:true,
        // 预览界面的文件，是否可以调用本地office打开查看
        localViewFile:true,
        // 回显为menubutton时, 文件名称以短文件名称显示(showShortFileName = true)
        showShortFileName:false,
        /* showShortFileName = true 时， 
           shortFileNameSize 为数字时，文件名称长度大于shortFileNameSize时， 以短文件名显示
           shortFileNameSize = auto时，根据文件名称长度和父容器的宽度，自动判断是否短文件名显示
        */
        shortFileNameSize:'auto',
        // 一个汉字占屏幕的像素数
        charPixel:8,
        // 回显表格查询参数
        callbackGridParams:{
            query_eq_guid:'',
            boName  :'FileBean',
            pkName  :'fileId'
        }, 
        // 回显时，一次最大查询出的文件数
        maxQueryFiles:50,
        // grid border 表格边框，默认为true
        gridBorder:false,
        // 金格控件可以编辑的文件类型
        editFileType:[
            "application/vnd.ms-excel","xls",
            "application/msword","doc",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document","docx",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","xlsx",
            "application/vnd.ms-works","wps"
        ],
        onBeforeOpen:function(target, options){return true;},
        onOpen:function(target, options){return true;},
        onBeforeClose:function(target, options){return true;},
        onClose:function(target, options){return true;},
		// 已经选择的文件（数组），已经上传的文件数组
		onChange: function(options, selectedFiles, uploadFiles){
			//alert(selectedFiles.length +","+uploadFiles.length);
			return true;
		},
        //在提交之前触发，返回false可以终止提交
        onFileSubmit:function(options){return true;},
        //上传成功后回调函数
        onFileSubmitSuccess:function(data, options){},
        /*
        onDeleteFile 删除文件前调用 
	           参数：fileIdList   数组类型[], 里面为选择的文件fileId
	           返回：boolean      true:执行删除， false：终止删除
        */
        onDeleteFile:function(fileIdList){ return true;},
        /*
        onDeleteFileSuccess 删除成功后调用
	           参数：
        data   json类型｛type:'info/error', msg:'删除成功！'｝, 
        fileIdList   数组类型[], 里面为选择的文件fileId 
        */
        onDeleteFileSuccess:function(data, fileIdList, options){ return true; }
    });    
})(jQuery);

// 计算字符串的长度reallength，汉字为2，其它字符为1
String.prototype.rlength = function(){
	try{
		var str = this;
		var realLen = 0;
		for(var i=0; i<str.length; i++){
			var schar = str.charAt(i); 
		    if ( !schar.charCodeAt(0) || schar.charCodeAt(0) < 1328 ) {
				realLen += 1;
			}else{
				realLen += 2;
			}
		}
		return realLen;
	}catch(e){
		//isdebug ? alert("String.prototype.rlength:\n"+e.message) : null;
	}
}