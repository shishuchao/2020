/**
 * 通用组件：通用树形、通用表格，基于jquery-easyui的tree、datagrid，和审计管理系统业务结合，做到通用化
 * 根据后台的hibernate bean信息来配置树形、表格，后台代码基本不用写，页面简单配置即可。
    *******************************************************************************************************************
    * 版本信息
    * @Version: 2.2.7.8
    * @Date   : 2015.04.28
    * @Author : qfucee
    *******************************************************************************************************************
    修改历史
    1. 2013.2.27，qfucee
      a.解决左侧树形拖动调整宽度或者窗口调整宽度时，右侧表格不能随着改变宽度（layout resize）。
      b.调整左侧树形的宽度（变小），增大右侧表格的宽度
      
    2. 2013.3.7,qfucee
      a.修改onAfterSure，当为左右结构时，传入右侧人员姓名name、系统账号sysCount、员工编号personCode,company,companyCode
        onAfterSure:function(dms,mcs,personnelCode,company,companyCode){
            // some code
        }
      b.解决某些情况，编辑时已选tab页不能列出已选人员问题(isCRUR设置问题)。
      c.人员表格单选时，清除缓存中已选择的记录，使已选择表格始终只有一条记录。
      d.解决当cache为false，如果没有选择人员，单击确定后多次弹出提示信息的问题。
      e.去掉当打击左侧树形，右侧没有查询出数据的提示。
 
    @version:v1.1
    1. 2013.3.11,qfucee
      a.添加选择本级和本上级的功能。     
    2. 2013.3.22,qfucee
      扩展type属性的范围，type='treeAndUnEmployee' 人员选择从系统人员中选中非审计人员；    
    3. 2013.3.25
      扩展type属性的范围，type='treeAndUser' 人员范围限定为系统人员中；

    @Version: 1.2
    @Date   : 2013.12.23
    @Author : qfucee
    1.去掉树形的双滚动条。
    2.增加窗口的宽度，调整table的各列的宽度。
    
    @Version: 1.3
    @Date   : 2014.01.16
    @Author : qfucee
    1.左侧树添加树形节点查询功能。
      a.输入框支持模糊查询，加入回车查询功能（光标在输入框中时生效）。
      b.搜索顺序为：
        .局部搜索已经加载的数据节点，找到第一个后停止搜索，匹配节点选中并且他上级节点展开，其它已打开的节点关闭；
        .局部搜索完毕，提示是否进行全局搜索。确定则按照关键字搜索数据库中（url为jsp页面中tree的加载url），
         把查询结果单独放在一个tab页中（搜索节点）匹配关键字底色加重。
    2.调整输入框的样式，输入值垂直居中，左侧留空，边框颜色变为浅灰;
    3.窗口打开时，焦点默认定位到查询输入框;
    4.右侧表格添加模糊查询功能，支持查询 经济责任人、被审计人员、登陆人员中选中非审计人员、系统人员；
      同样支持两级查询，本地结果集和数据库，本地没有匹配记录则转向数据库查询（查询条件与单击左侧树形节点一致）;
    5.输入框（包括输入input和清空的X）和按钮（搜索和刷新）单独写成一个方法，左侧树和右侧表格调用一致;
    6.根据指定的defaultDeptId和defaultUserId，初始化是定位defaultDeptId所在节点并加载此节点下的user，根据defaultUserId并定位;
    7.如果第一次初始化时只有一个根节点，根据配置参数(expandFirstRoot, true:展开)决定是否展开;
    8.添加查询树形节点定位功能，查询或者初始化节点时，自动定位匹配节点到窗口的上半部（适用于有滚动条时，匹配节点被窗口隐藏）;
    9.添加输入框组件输入内容提示prompt功能。 
    10.添加自定义树节点单击事件 onTreeClick:function(node,treeDom), 返回值boolean  true：继续执行下面code；false：停止执行；
    11.模糊查询时，如果查询结果集只有一条，则自动定位到局部加载树形中；如果有多条记录，则双击查询结果记录，自动定位到局部加载树形中；
    12.添加自定义属性组件，通过配置jsp页面，自动创建逐级加载或者全部加载树形，以及附属的节点搜索定位功能。
    eg：
			// 自定义 - 被审计单位树
			showSysTree(obj,{
				// 页面中容纳树形的元素对象，此处为一个div对象（<div id='auditObjectTreeId'></div>）
				container:obj,
				defaultDeptId:dpetId,
				param:{
					// application-xx.xml中配置的bean
                    'beanName':'AuditingObjectTree',
                    // BO对象中对应tree的id的属性，一般为id, 必须有
                    'treeId'  :'id',
                    // BO对象中对应tree的text的属性，一般为name, 必须有
                    'treeText':'name',
                    // BO对象中对应tree的parentId的属性，一般为parentId, 必须有
                    'treeParentId':'parentId',
                 	// 默认为true，大数据量是逐级加载；如果数据量很少时，可以选择false；可选
                    'lazy':true,
                    // 查询节点结果集按此字段排序, 可选
                    'treeOrder':'code'
                    
                },
                // 单击节点时，触发的方法
				onTreeClick:function(node, treeDom){	
					$('#childBasefrm').attr('src', frmUrl+node.id);
				}
			});
            
    2014.3.11,qfucee,
    1.解决树形节点搜索时，多个根节点搜索不到记录的问题。 
    2.添加自定表格，以及对表格的相关操作，如果：导出、搜索、删除、按钮名称样式状态的控制，和左侧树形的关联互动等
    
    2014.7.9, qfucee
    1.解决jquery easyui 1.3.6 按钮兼容问题。 原来的button换成<a>
    
    2014.7.28,qfucee
    1.解决导出时，如果有id复选框，也导出选择复选框的问题；
    
    2014.8.25
    1.根据关键字定位树形节点时，如果数组中最后一个节点（即树形的根节点）和树形root不一样，则下一个节点id出栈
    
    2014.12.1（国税项目修改）
    1.树形嵌入式时，外围div去掉滚动条。
    2.所有按钮改成button形式（原来为<a></a>)。
    3.修改查询框样式，去掉margin-bottom。
    4.如果是被审计单位树，定位树形节点时查询本级本上级节点id的url默认为组织机构树形，根据treeOption.url判断
      是否"/mng/audobj/object/getAuditedDeptChildByDeptId"包含，自动设置treeOption.priorUrl = "getPriorAud"被审计单位查询本基本上节点id；

    ************************************************************************************  

    @Version: 2.0
    @Date   : 2014.12.31
    @Author : qfucee
    @Desc   : 国投项目
    1.修改jsp嵌入式树形所在tabs宽度不能随外边布局panel拖动而改变宽度问题；
      主要原因是：
      	a.搜索框不在tabs中而是在tabs外边，现在放到tabs中
        b.jsp中设置嵌入式插件container， <div  region='west'>里面不能包含任何对象，否者宽度不能随外边容器改变而改变
    	  现在折中办法，不对jsp进行修改，在js中统一判断，如果 <div  region='west'>下面包含div或者其它的容器，删除，把容器设置
    	  为 <div  region='west'>，并设置最小宽度
          
    ************************************************************************************
          
    @Version: 2.1
    @Date   : 2015.01.6
    @Author : qfucee
    @Desc   : 国投项目
    1.节点查询定位时，后台节点都查到了，但是无法定位到指定节点。
      原因：expandPriorNodeByIds方法中setInterval设置的时间如果太小就会由此问题，还有就是当前树形节点层次太多，如果一个
            节点还没有展开，就要定位其下面的节点，就会出问题。解决方法是等到节点展开完毕，才去定位器下面的节点。
    2.解决根据关键字查询时，定位后滚动条滚到指定到节点后又回到最上。（原因：查询关键字input光标focus造成）
    3.调整选人表格列的宽度。
    4.弹出控件查询按钮响应回车事件错误，即使输入查询关键字，总是提示“请输入查询关键字”
    
    @Version: 2.2
    @Date   : 2015.01.8
    @Author : qfucee
    1.对已经加载的节点进行关键字查询时，循环查询，如果节点循环到数组末尾，检查已经打开的节点是否有匹配的节点，如果有继续定位。
    2.调整表格的高度，使之显示10条记录而不显示滚动条。添加表格的margin=0（和ais.css冲突）
 
    @Version: 2.2.1
    @Date   : 2015.01.9
    @Author : qfucee
    1.调整查询框按钮的样式。
    
    @Version: 2.2.2
    @Date   : 2015.01.13
    @Author : qfucee
    1.添加查询‘第一个’“前一个” “下一个”‘最后一个’的节点分页按钮。
    2.解决加重关键字不能全部清除问题（原因：换成时有时把已经加重的节点重复缓存了，导致还原时是加重的节点）。

    @Version: 2.2.7
    @Date   : 2015.01.21
    @Author : qfucee
    1.把缓存查询和数据库查询分开，通过按钮切换。
    2.添加查询分页按钮。
    3.优化节点和查询定位，结合节点分页。已经定位的节点，把节点已经查询的本级本上级节点id以定位节点id为key缓存到
      当前树形对象中，每次定位时先从缓存查询，如果没有再从数据库中查询并缓存。
    
    @Version: 2.2.7.1
    @Date   : 2015.03.25
    @Author : qfucee
    1.Gatagrid控件添加Pagesize参数，设置分页条数。
    2.树形节点定位，去掉查询关键字queryKey为必填，可以根据节点id直接定位；如果querykey不为空，则选中节点加重显示关键字；
      否则不现实；添加定位提示开关变量，默认为提示，可以取消定位失败时弹出信息；
    3.树形多选时，选中根节点，下次再打开根节点没哟选中。
    4.表格导出时，如果参数有分号，如：id='11122' and ....  可能导致查询错误，导出全部记录；

    @Version: 2.2.7.3
    @Date   : 2015.03.27
    @Author : qfucee
    1.加入gridParam， treeParam json对象参数，用来为表格grid和树形提供参数；（人员选择时就可以根据角色flevel去过滤了）
    2.表格查询加入回车查询事件，默认为本地缓存查询，如果有记录就不在弹出提示，可以手动选择数据库查询；
    3.提炼Qutil公共方法：initDatagridCheckCache，缓存传入的ids，names到表格对象datagridObj中，用来对记录进行初始化check/uncheck
    
    @Version: 2.2.7.4
    @Date   : 2015.03.31
    @Author : qfucee
    1.树形可以使用原有easy-tree的所有方法。
    2.表格导出到excel表头中文乱码，把用来导出的form（原来没有method默认为get提交）该post提交，解决问题；
    
    @Version: 2.2.7.5
    @Date   : 2015.04.02
    @Author : qfucee
    1.在QUtil添加string2json，object2string方法。
    2.添加展开/合并所有树形节点的方法 expandOrCollapseAllNodes:function(treeObj, node, action, maxTreeLevel, level),
      可以指定展开的层数
    3.添加选择本上本下级树形节点功能。
        checkPriorNodes(treeObj, node, checked)，
        checkSubNodes(treeObj, node, checked)
        
    @Version: 2.2.7.6
    @Date   : 2015.04.08
    @Author : qfucee   
    1.表格form表单查询时，如果有数据，就关闭查询窗口；没有数据就清空查询条件；
        
    @Version: 2.2.7.7
    @Date   : 2015.04.15
    @Author : qfucee   
    1.公共方法中添加如下方法（QUtil）
        formBeforeSendCheck:表单检查, 检查formid下的class=required的所有input select textarea是否为空，并进行提示
        clearForm:清空表单,把class=clear的input select textarea清空
        setEasyuiBtn:设置easyui按钮的状态,显示或者隐藏
        textFormatter:格式化datagrid的value，当字数太多用textarea显示
        checkDateAfterDate:检查日期前后管理，后一个参数id的日期值应大于第一个日期的值
        getType:判断对象类型，能判断出Array对象，参数可以是一个对象或者数组
        string2json:string转化成json , IE6不支持JSON.parse(str); 
        travelObject:遍历Object的内容
        getObj:获得easyui对象
        scrollDown:滚动条滚动到最下
    2.对String，Number等基本类，加入trim，rlength,lpad,rpad方法进行扩充；
    3.对于数据表格分页datagrid，每页显示的记录数：rows，pageSize两个参数通用；
    4.表格搜索窗口由window换成dialog，按钮放到最上面；添加查询查询并导出按钮，导出结果集按钮form查询条件；
      表格中的导出到excel则不包括查询form中的参数，默认导出全部的数据    
    5.表格刷新按钮：分页处的刷新只重新加载当前查询条件的结果集（包括树形参数，查询form等参数）
                    表格上面按钮的刷新，只刷新根据basicgridParam为参数结果集，不包括查询form的参数；
   
    @Version: 2.2.7.8
    @Date   : 2015.04.28
    @Author : qfucee   
    1.局部加载树Tab页，加入刷新按钮。
    2.对于树形控件，加入"queryBox(对两个都起作用),treeQueryBox(树形),gridQueryBox(右侧表格)" 属性，决定是否显示查询框， 默认为true，显示查询框。
     .queryBox, 是否显示查询框，treeQueryBox和gridQueryBox没有时(如果有则按各自的属性)，使用这个属性值       

     树形控件加入属性：
       queryBox：决定是否显示查询框， 默认为true，显示查询框；
       treeQueryBox(树形)：决定是否显示查询框， 默认为true，显示查询框；
       gridQueryBox(右侧表格)：决定是否显示查询框， 默认为true，显示查询框；
       treeTabTitle1：树形tab的title，没有指定则使用默认值
                      treeTabTitle1:optionJson.treeTabTitle1 ? optionJson.treeTabTitle1 : '逐级加载树'；
       treeTabTitle2：树形搜索结果tab的title，没有指定则使用默认值   
                      treeTabTitle2:optionJson.treeTabTitle2 ? optionJson.treeTabTitle2 : '搜索结果'；                     
       onlyLeafClick: true：只能选择末级节点； false：父节点/叶子节点都可以选择； 默认值：false（都可以选择）；     
       cascadePrior:  true: 选择节点的本级和上级，默认为false；
       cascadeJunior: true: 选择节点的本级和下级，默认为false；
       cascadeExpand: true: 展开当前节点下的所有节点（为了性能默认展开节点不超过4层）, 默认：false
    3.expandOrCollapseAllNodes:展开节点，timeout时间根据当前节点node的children数目来觉得，子节点越多加载时间延迟越长，
      最小延迟为50ms，最大为550ms；    
    4.树形控件，加入"isLeaf"条件属性，用来判断是节点是否为叶子节点，如果没有次属性，则用sql查询当前节点下的子节点个数来判断是否为
      叶子节点。
    
    @Version: 2.2.7.9
    @Date   : 2015.09.22
    @Author : qfucee 
    1.弹出窗口始终在窗口的正中（解决有滚动条滚动时，窗口位置偏上的问题）
    
    @Version: 2.2.8.0
    @Date   : 2015.09.29
    @Author : qfucee 
    1.把表格右侧表格对象和已选择对象加入到this.option, 把winJson返回
      createOrgTree对象即为winJson.win
    
    @Version: 2.2.8.1
    @Date   : 2015.10.6
    @Author : qfucee 
    1.单独一棵树时，如果树container没有layout或者container的父级或者父级的父级没有layout时会造成死循环，
	  现在修改为如果父级为body且没有layout就跳出循环
	  
	 
	注：3.0版本针对 大于jquery-easyui 1.4版本进行适应性优化， 3.0以下的为使用easyui 1.3版本  
    @Version: 3.1
    @Date   : 2016.03.21
    @Author : qfucee 
	1.判断layout west, east的宽度是不是占据了整个页面宽度，自动调整他们的宽度.
	2.弹出窗口自动判断页面横向、纵向滚动条 滚动距离，使控件弹出窗口始终保持在页面的正中间。
	3.查询窗口样式修改，去掉重复清空按钮（高版本的浏览器已经有此功能），修改input提示prompt的样式，单击时宽度不会发生变化。
	4.解决查询框，树形错位，查询没有反应；
	  树形节点查询时，先从缓存查询，如果没有解决，不再提示，直接查询数据库。
	5.所有方法中的try catch异常全部用isdebug参数进行控制是否alert。
	6.datagrid显示内容超长时，用...代替，鼠标放在上面提示全称。
	7.修复树形查询框查询时，如果有多个匹配节点，分页按钮不能显示, 分页到最后或者最前，按钮没有变灰问题。
	 .datagrid查询框放到表格的tab的右侧
	8.人员查询时，如果缓存中没有，则不提示直接从数据库查询。
    9.左树右表时，修改以前的查询方法，使用datagird queryParams查询。
    10.去掉tab，layout嵌套间的border（border:false)
    11.优化tree和datagrid的高度，更紧凑
    12.统一修改按钮样式icon。
    
    V3.1.2
    1.解决datagrid分页时，第一次没有反应的问题（1.3.6分页要自己实现，现在1.4只要有pagination：true就可以自动分页了）
    
    @Version: 3.1.3
    @Date   : 2016.05.5
    @Author : qfucee
    1.<!DOCTYPE HTML>下对padding margin 等的值要加上“px“
    2.所有的datagrid的列标题都居中，列内容不受影响。
    3.去掉所有弹出窗口的shadow，有些时候拖拽时，shadow不动。
    4.优化计算弹出窗口位置的方法，使之适应<!DOCTYPE HTML>
    
    @Version:3.1.4
    @Date   :2016.5.14
    @Author :qfucee
    1.树形控件，刷新按钮增加提示，鼠标改成手型
    2.所有easyui的alert提示全部放到最外曾提示，top.$.messager.alert()
    3.增加noMsg属性，为true时， 如果点击节点，下面没有数据，不进行提示
    
    @Version:3.1.5
    @Date   :2016.5.31
    @Author :qfucee
    1.优化checkbox选择和取消的速度，已经加载的节点，oncheck时，取消timer延时。
    2.树形tab添加公用menubutton，集成“全部展开、展开选中、全部折叠、折叠选中、重新加载、级联选择、取消级联”按钮
      通过树形参数：checkbox来控制“级联选择、取消级联”是否显示。默认false
      通过树形参数：showTabTools来控制menubutton是否显示。默认true 显示
    3.alert，confirm，show的titile有‘提示’改为‘提示信息’
    
    @Version:3.1.6
    @Date   :2016.6.3
    @Author :qfucee
    1.优化树形搜索工具栏的样式，嵌入是树形，搜索栏放到右上角，由menubutton触发。
    2.优化树形:去掉多选时，右上角的’全选‘和’取消‘按钮，把两个功能放到右上角menubutton里面。
    
    @Version:3.1.7
    @Date   :2016.6.4
    @Author :qfucee
    1.树形tree,'getChildren'有时候调用的时候$(treeObj).tree('getChildren', node.target)会报错（null引用length属性），
    导致后面的代码没法运行，解决办法是：把这段代码try..catch自己处理异常，然后判断是否为null。
    
    2016.6.13
    1.增加属性: customRoot 用于定义树形的根节点。eg:customRoot:'小组成员'
    2.增加属性: allleaf  true:根据查询条件查出的全部作为叶子节点(如小组成员的选择等业务场景)
    
    2016.7.13
    1.优化：自定义树形时，根据beanName自动确定树形的名字，如：UOrganization 为组织机构树.
    2.优化：右侧表格列的宽度，表上右上查询框的位置。
    3.优化：表格选人后，清空按钮响应清空选择人员表格选择或者选中checkbox。
    4.优化：选人控件原来只有在第一次时才会用页面input数据初始化两个datagrid设置选中或者取消，打开后如果修改了选中记录，
      又没有确定进行回填页面，下次打开时就没有开始的初始化数据了。
      
    2016.7.23
    1.优化:datagrid对toolbar按钮隐藏时,去掉按钮旁边的分隔符.
    2.部分alert改成showMessage1.
    
    2016.8.23
    1. 解决cache = false不能每次重新加载问题。  
    
    2016.8.25
    1.解决：不管树形是否加载完毕，每次打开树形界面都要根据页面input的节点id来初始化树形的选中情况。
    
    2016.8.31
    1.如果不是调用commonplug的方法加载的树形，不进行提示“数据(树节点)是否已经加载完毕”。
    
    2016.9.18
    1.解决:createQDatagrid分页时，行序号不变。表单保存后refresh刷新时，不能返回到当前页， 不能按所选页数分页（始终按10条每页分页）。
    
    2016.9.23
    1.解决：createQDatagrid如果排序后，调用refresh()，结果没有按照排序字段和排序顺序查询。
      目前在onSortColunm时，把sort、order数据缓存到datagrid对象data中，refresh()时，把这两个参数合并到查询参数中。
      
    @Version:3.1.8
    @Date   :2017.02.08
    @Author :qfucee  
    1.后台加入缓存机制，根据树形beanName把树形节点缓存到一个nodeMap中，nodeMap的key为节点的id，value为此节点的孩子节点list，
      每次单击树形节点时，先从缓存中，根据boName查询出nodeMap，如果有值，则根据treeClickId查询此节点的孩子节点list，如果没有
      则把查询的节点缓存到nodeMap中。这样的话，页面中不同的树，只要beanName相同，一棵树加载过了，另外一棵树读取速度会明显加快。
    2.在treeParam中添加参数serverCache：布尔值 true/false, true:加载时读取后台缓存； false：每次都是重新加载；
      默认值：true
    3.组件排序字段，支持字符串类型转成number，方便字符串排序, eg: order: number(id)
    
    @Version:3.1.8.1
    @Date   :2017.02.16
    @Author :qfucee  
    1.在treeParam中添加参数isOracle，布尔值true/false， 默认为true
     true ：后台判断是否为oracle数据库, 如果是则使用oracle特性生成树形结构数据
     false：使用通用的方式加载树形
    2.在treeParam中添加参数plugId, 用于区别请求的组件。如果没有plugId，则默认使用beanName，
      如果页面两个组件的beanName一样，但是有where条件，条件不一样，说明这是不同的两棵树，则需要设置plugId；
      如果所有的条件都一样，那么就不用设置plugId。
      
    @Version:3.1.8.2
    @Date   :2017.02.18
    @Author :qfucee  
    1.修改参数传入字符串类型的布尔值转换问题，以前传入字符串的true/false, Boolean(xx)后都是true，
      现在修改为 1,-1,'true' = > true,  0, 'false' = > false,  
      添加方法：QUtil.string2boolean(treeOption.cache, true)
    2.修改部分为布尔类型的参数， 使用QUtil.string2boolean方法来处理传入的参数。
	  
    @Version:3.1.8.3
    @Date   :2017.02.19
    @Author :qfucee  
    1.添加“已选择”页签，当树形为复现时，显示此页签，把以选择的节点列在里面的列表中，此列表数据的删除和树形
      选择同步；如果页面初始化数据有数据，同样也会显示在此列表中。
    
    @Version:3.1.8.4
    @Date   :2017.02.21
    @Author :qfucee    
    1.完善和有优化通用表格自动查询表单，表单两列查询条件，表单窗口居中放置。
    
    @Version:3.1.8.5
    @Date   :2017.02.24
    @Author :qfucee   
    1.通用表格createQDatagrid
		.添加标注：attachmentId, 附件Id, 如果bean有此标注，标识用来记录bean关联的附件
		通用表格删除记录时，会检查此bean的属性是否有这个标注，有则一并删除关联的附件。
		
		
    @Version:3.1.8.6
    @Date   :2017.02.28
    @Author :qfucee   
    1.通用表格createQDatagrid
    	添加属性:myToolbar
		上面的按钮 删除、导出、查询、刷新按钮，根据参数自动生成，如果没有配置此参数，则全部显示
		例如: myToolbar:['delete', 'export', 'search', 'reload'];
	2.完善setGridBtn, 添加id，remove两个属性，用来控制datagrid的toolbar的权限控制
		'id':'btnAdd',//如果有按钮的id，则index失效
		'remove':true/false //把按钮对象整个从dom中移除
	3.刷新时，如果没有查询到数据，用空的rows数组刷新列表，清空查询前的数据
	
	@Version:3.1.8.7
    @Date   :2017.03.1
    @Author :qfucee   
    1.通用表格createQDatagrid
    .修复查询按钮不能remove，查询按钮的ID写错了
	
	@Version:3.1.8.9
    @Date   :2017.03.17
    @Author :qfucee   
    1.通用表格createQDatagrid
    .删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject) 

	@Version:3.1.9
    @Date   :2017.03.22
    @Author :qfucee   
    1.通用表格createQDatagrid
    .添加属性treeGrid， 默认为false，为true时，表格为树形表格展示数据，否则为datagrid 
	树形表格时，需要另外配置属性：idField:'nodeCode',treeField:'nodeName',parentIdCol:'parentCode'
	指定树形的id和显示text， 树形的json数据格式多了一个_parentId用来记录上下级关系
	{total:10, rows:[{ 'id': 'M22-S79-S82','nodeName': '风险点2', '_parentId': 'M22-S79'}]}
	业务bean需要继承BaseEntity基类（里面定义一个_parentId属性，但是不作为物理表属性）
	parentIdCol表格树时，记录业务对象中表示父节点Id的属性
	
	var g1 = new createQDatagrid({
		//表格树
		treeGrid:true,
		//查询关联表
		associate:true,
		//表格树时，记录业务对象中表示父节点Id的属性
		parentIdCol:'parentCode',
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MainProcess',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'nodeId',
        order :'asc',
        sort  :'nodeCode',
        gridJson:{
			idField:'nodeCode',
			treeField:'nodeName',
			columns:[[..]]
		}
	});
	2.通用表格createQDatagrid导出到excel时，导出字段包括frozenColumns和columns的字段，而不是仅仅时columns。
      	
   	@Version:3.1.9.3
    @Date   :2017.03.25
    @Author :qfucee    
    1.修复通用表格createQDatagrid, 选择分页条数时，不起作用  	
    如果页面pagesize发生编码，刷新（调用refresh）、排序等都使用最新的pagesize
    2.datagrid删除数据时，实时刷新表格数据。
    删除前的校验beforeRemoveRowsFn方法在confirm前执行
    
   	@Version:3.1.9.4
    @Date   :2017.04.06
    @Author :qfucee  
    1.清除缓存时，是根据plugId为key清除的，如果没有命名plugId，则使用beanName
    
   	@Version:3.1.9.5
    @Date   :2017.04.15
    @Author :qfucee  
    1.解决Qdatagrid生成查询条件时，表格table不能居中
    
   	@Version:3.1.9.6
    @Date   :2017.04.17
    @Author :qfucee 
    1.Qdatagrid列添加属性：queryText（如果没有默认取title），queryKey（如果没有默认却field）
    
   	@Version:3.1.9.7
    @Date   :2017.04.20
    @Author :qfucee 
    1.树形节点关键字查询时，如果有多个匹配结果，以前是只把第一个节点关键字加重并选中，现在改为把所有匹配节点关键字加重，选中第一个节点
 
   	@Version:3.1.9.8
    @Date   :2017.04.28
    @Author :qfucee 
	1.级联选择默认改为false
	
   	@Version:3.1.9.9
    @Date   :2017.05.4
    @Author :qfucee 
	1.优化createQDatagrid， 按钮支持自定义顺序（预制按钮和自定义的按钮）
		myToolbar: [],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar: isView ? ['search', 'export', 'reload'] : ['query','-',{   
	                text:'添加',
	                iconCls:'icon-add',
	                handler:function(){
                    	aud$openNewTab('材料价格添加', editUrl, true);
	                }
	            },'-','delete','-',{   
	                text:'下载模版',
	                iconCls:'icon-download',
	                handler:function(){
	                	$('#parseExcelContainer').parseExcel('downloadTemplate');
	                }
	            },'-',{   
	                text:'导入文件',
	                iconCls:'icon-upload',
	                id:'mpImportExcelBtn'
	            },'-','export','-','reload','-'
	        ],
	
	@Version:3.1.2
    @Date   :2017.05.11
    @Author :qfucee 
	1.优化createQDatagrid，添加delWhere属性，在删除数据时，作为where条件的一部分
	如：		//删除时的where
		delWhere:" manuStatusCode='-1' and creatorId='fanwen'",
		
	@Version:3.1.3
    @Date   :2017.05.16
    @Author :qfucee 	
    1.onAfterSure的上下文为修改为当前的控件的上下文，tree控件：this指向树形的dom，树和表格：this指向表格控件
    2.onBeforeSure:添加确定前的回调函数，控件单击确定前执行，如果返回true的话，回填数据； false：不进行回填数据，
    用于校验选中的数据

    2017.5.17
    1.createQDatagrid.prototype.refresh = function(cusParam)   
    添加自定义查询参数cusParam，json类型，格式为{
    	'query_eq_groupId',xx
    }查询参数只作为单次查询条件，不作为表格固定查询条件
    2.添加属性：delRefresh:true/false   删除记录后，是否刷新列表, 默认true
    
   	5.19
   	1.Qdatagrid添加方法：removeFilter(data)用于过滤选中记录，哪些记录符合删除要求
    
 */
//------------------------------------- 基本类的扩充 ------------------------------------------
// 去除字符串两边的空格
String.prototype.trim = function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

// 去除字符串左边的空格
String.prototype.ltrim = function(){
    return this.replace(/(^\s*)/g, "");
}

// 去除字符串右边的空格
String.prototype.rtrim = function(){
    return this.replace(/(\s*$)/g, "");
}

// 去掉字符串中的所有空格
String.prototype.trimAll = function(){
    return this.replace(/(\s*)/g, "");
}

// 把字符串中的所有oldchar替换为newchar
String.prototype.replaceAll = function(oldchar,newchar) {
	 var reg = new RegExp(oldchar,"gi");
	 return this.replace(reg,newchar);
}

/*
 字符串左填充
 num     :填充后字符的长度
 fillchar:准备被填充的字符串；填充字符串，是个可选参数，这个字符串是要粘贴到string的左边，
   		  如果这个参数未写，lpad函数将会在string的左边粘贴空格。 
   		  注意：如果在html中显示，空格要用"&nbsp;"否则没有效果
*/
String.prototype.lpad = function(num,fillchar){
   try{
		var str = this;
		// 字符串的实际长度
		var len = str.rlength();
		// num要大于字符串的长度
		if(num && parseInt(num) > len){
			fillchar    = fillchar ? fillchar : ' ';
			// 最终长度和初始字符串的差值，即填充字符的个数
			var differ  = parseInt(num) - len;
			var fillArr = new Array();
			// 填充differ个fillchar
			for(var i=0; i<differ; i++){
				fillArr.push(fillchar);
			}
			fillArr.push(str);
			return fillArr.join("");
		}else{
			return str;
		}
	}catch(e){
		isdebug ? alert("String.prototype.lpad:\n"+e.message) : null;
	}
}

/*
 字符串右填充
 num     :填充后字符的长度
 fillchar:准备被填充的字符串；填充字符串，是个可选参数，这个字符串是要粘贴到string的左边，
   		  如果这个参数未写，lpad函数将会在string的右边粘贴空格。 
   		  注意：如果在html中显示，空格要用"&nbsp;"否则没有效果
*/
String.prototype.rpad = function(num,fillchar){
   try{
		var str = this;
		// 字符串的实际长度
		var len = str.rlength();
		// num要大于字符串的长度
		if(num && parseInt(num) > len){
			fillchar    = fillchar ? fillchar : ' ';
			// 最终长度和初始字符串的差值，即填充字符的个数
			var differ  = parseInt(num) - len;
			var fillArr = new Array();
			fillArr.push(str);
			// 填充differ个fillchar
			for(var i=0; i<differ; i++){
				fillArr.push(fillchar);
			}
			return fillArr.join("");
		}else{
			return str;
		}
	}catch(e){
		isdebug ? alert("String.prototype.rpad:\n"+e.message) : null;
	}
}

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
		isdebug ? alert("String.prototype.rlength:\n"+e.message) : null;
	}
}

// 数字的长度
// 计算字符串的长度reallength，汉字为2，其它字符为1
Number.prototype.length = function(){
	try{
		return String(this).length;
	}catch(e){
		isdebug ? alert("Number.prototype.length:\n"+e.message) : null;
	}
}

Number.prototype.lpad = function(num,fillchar){
	try{
		return String(this).lpad(num,fillchar);
	}catch(e){
		isdebug ? alert("Number.prototype.lpad:\n"+e.message) : null;
	}
}

Number.prototype.rpad = function(num,fillchar){
	try{
		return String(this).rpad(num,fillchar);
	}catch(e){
		isdebug ? alert("Number.prototype.rpad:\n"+e.message) : null;
	}
}
 
//*******************************************// 

// 缓存窗体的数组
window.jqWinArr  = [];
window.jqWinCach = 0;
//是否启用调试
window.isdebug = false
// 添加窗体
function createOrgTree(optionJson){
    var contextRoot = optionJson.contextRoot ? optionJson.contextRoot : 'ais';
    // 随机数，用来表示id
    var ranNum = QUtil.ran(6);
    // queryBox, 是否显示查询框，treeQueryBox和gridQueryBox没有时(如果有则按各自的属性)，使用这个属性值
    var userQueryBox = optionJson.queryBox == undefined ? true : optionJson.queryBox ? Boolean(optionJson.queryBox) : false;
    //optionJson.treeQueryBox = false;
    // 初始化参数
    this.option = {

        // 树形tab，搜索结果tab的title，没有指定则使用默认值
        treeTabTitle1:optionJson.treeTabTitle1 ? optionJson.treeTabTitle1 : '逐级加载',
        treeTabTitle2:optionJson.treeTabTitle2 ? optionJson.treeTabTitle2 : '搜索结果',
		treeTabTitle3:optionJson.treeTabTitle3 ? optionJson.treeTabTitle3 : '已选择',

        //树形控件加入属性：onlyLeafClick，true：只能选择末级节点； false：父节点/叶子节点都可以选择； 默认值：false（都可以选择）
        onlyLeafClick:optionJson.onlyLeafClick == undefined ? false : optionJson.onlyLeafClick ? Boolean(optionJson.onlyLeafClick) : false,
        // 是否显示树形查询框,默认为true：显示
        treeQueryBox:optionJson.treeQueryBox == undefined ? userQueryBox ? true : false : optionJson.treeQueryBox ? Boolean(optionJson.treeQueryBox) : false,
        // 是否显示右侧表格查询框,默认为true：显示
        gridQueryBox:optionJson.gridQueryBox == undefined ? userQueryBox ? true : false : optionJson.gridQueryBox ? Boolean(optionJson.gridQueryBox) : false,
        // 表格分页每页10条记录
        pageSize:optionJson.pageSize ? optionJson.pageSize : 10,
        treeUrl:optionJson.treeUrl,
        // 树形是否逐级加载, false:一次性全部加载
        lazy:optionJson.lazy,
        treeParam:optionJson.treeParam,
        gridParam:optionJson.gridParam,
        treeCheckbox:optionJson.treeCheckbox,
        showTabTools:optionJson.showTabTools,
        title :'表单窗口',
        style1:'overflow:hidden;padding:0px;margin:0px; ',
        style2:"overflow:hidden;border-bottom:1px solid #cccccc;width:100%",
        style3:'padding:3px 4px 2px 4px; float:right;height:20px;',
        style4:'padding:2px; float:left; height:20px; ',
        winWrapId : 'winWrap_'+ranNum,
        treeWrapId: 'treeWrap_'+ranNum,  
        btnWrapId : 'btnWrap_'+ranNum,
        jqTreeId  : optionJson.jqTreeId ? optionJson.jqTreeId : 'jqTree_'+ranNum,
        jqTreeQueryId: 'jqTreeQuery_'+ranNum,
        tableInfoWrapId:'tableInfoWrap_'+ranNum,
        queryDivId  :'queryDivId'+ranNum,
        queryInputId:'queryInputId_'+ranNum,
        queryBtnId  :'queryBtnId_'+ranNum,
        // 右侧表格查询框和按钮所在div的id
        tableQueryDivId:'tableQueryDivId_'+ranNum,
        tableQueryInutId:'tableQueryInutId'+ranNum,
        tableQueryBtnId :'tableQueryBtnId'+ranNum,
        type:optionJson.type ? optionJson.type : 'tree',
        'defaultDeptId':optionJson.defaultDeptId,
        'defaultUserId':optionJson.defaultUserId,
        // 是否为弹出窗口插件
        'isWinPlug'    :optionJson.container ? false : true,
        // 容纳插件的容器
        'container':optionJson.container ? optionJson.container : $('body')[0],
        // 是否单选
        'isEmployeeRadio':optionJson.isEmployeeRadio ? true : false,
        'idsInput'    :optionJson.idsInput,
        'namesInput'  :optionJson.namesInput,
        'onAfterSure' :optionJson.onAfterSure,
		'onBeforeSure':optionJson.onBeforeSure,
        'onBeforeLoad':optionJson.onBeforeLoad,
        'onInit':optionJson.onInit,
		// 清空服务器树形缓存
		'clearTreeCache':"/"+contextRoot+"/commonPlug/clearTreeCache.action",
        // 自定义树形url
        'getDefaultTreeUrl':"/"+contextRoot+"/commonPlug/getCustomTree.action",
        // 获得被审计人员
        'getEmployee':"/"+contextRoot+"/mng/employee/getEmployeeListByAsyn.action",
        // 获得经济责任人
        'getEconomyDuty':"/"+contextRoot+"/mng/employee/getEconomyDutyPersonByAsyn.action",
        // 人员选择从登陆人员中选中非审计人员
        'getUnEmployee':"/"+contextRoot+"/mng/employee/getUnEmployeeByAsyn.action",
        // 获得系统人员
        'getUser'      :"/"+contextRoot+"/mng/employee/getUnEmployeeByAsyn.action?flag=1",
        // 组织机构：根据dpetId一直向上 找到本上级直到根节点
        'getPriorDept' :"/"+contextRoot+"/mng/employee/getPriorDeptByDeptId.action",
        // 被审计单位：根据指定id逐级搜索本上级
        'getPriorAud'  :"/"+contextRoot+"/mng/audobj/object/getPriorAudIdsById.action",
        // 默认的Tree中的逐级搜索url，
        'getPriorDefault':"/"+contextRoot+"/commonPlug/getPriorNodeIdsById.action",
        'priorUrl'     :optionJson.priorUrl,
        'employeeColumns':[  
            {field:'id'  ,          title:'选择',       width:'1px',  checkbox:true, halign:'center',align:'center'},
            {field:'name',          title:'姓名',       width:'100px', halign:'center',align:'center', sortable:false},
            {field:'sysAccounts',   title:'系统账号',   width:'100px',  halign:'center',align:'center', sortable:false},                    
            {field:'company',       title:'所在部门',   width:'180px', halign:'center',align:'center', sortable:false,
                formatter:QUtil.getShortCol
            },
            {field:'rolestyle',     title:'角色类型',   width:'70px',  align:'left', halign:'center', sortable:false, hidden:true},
            {field:'state',         title:'状态',       width:'50px',  align:'left', halign:'center', sortable:true, hidden:true}
        ],
        'employeeSelectedColumns':[  
            {field:'id'  ,           title:'选择',     width:'10px',  halign:'center',align:'center', checkbox:true},
            {field:'name',           title:'姓名',     width:'70px',  halign:'center',align:'left'},
            {field:'sysAccounts',    title:'系统账号', width:'80px',  halign:'center',align:'left'},
            {field:'personnelCode',  title:'人员编号', width:'80px',  halign:'center',align:'left'},
            {field:'company',        title:'所在部门', width:'180px', halign:'center',align:'left'}
        ],
        'economyDutyColumns':[  
            {field:'id'  ,          title:'选择',       width:'10px',  checkbox:true, halign:'center',align:'center'},
            {field:'name',          title:'姓名',       width:'70px',  halign:'center',align:'left',  sortable:true},
            {field:'sysAccounts',   title:'系统账号',   width:'80px',  halign:'center',align:'left',  sortable:false, hidden:true},                    
            {field:'personnelCode', title:'员工编号',   width:'80px',  halign:'center',align:'left',  sortable:false},
            {field:'company',       title:'所在部门',   width:'230px', halign:'center',align:'left',  sortable:false}
        ],
        'economyDutySelectedColumns':[  
            {field:'id'  ,          title:'选择',       width:'10px',  checkbox:true, halign:'center', align:'center'},
            {field:'name',          title:'姓名',       width:'240px',  halign:'center', align:'left'},
            {field:'company',       title:'所在部门',   width:'300px',  halign:'center', align:'left',  sortable:false,hidden:true}
        ],
		'treeNodeSelectedColumns':[  
            {field:'id'  ,          title:'选择',       width:'10px',  checkbox:true, halign:'center', align:'center'},
            {field:'name',          title:'名称',       width:'240px',  halign:'center', align:'left', 
			formatter:function(value,row,index){
				return  ["<label title='单击定位到树形' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
			}}
        ]
    };
    this.storeData = null;
    this.param = this.createWin();
}
// 只在第一次调用时执行一次
createOrgTree.prototype.createWin = function(){
    try{
        // 组件初始化:树形和表格都没有初始化前执行，可以用来给控件准备一些必要的参数
        this.option.onInit ? this.option.onInit(this) : null;
        var othis = this;
        // 容纳插件的容器对象
        var container = othis.option.container;   
        // 是否为窗口型插件
        var isWinPlug = othis.option.isWinPlug;
        // 布局
        var layoutWrap = null;            
        var winWrap  = document.createElement('div');
        var headWrap = document.createElement('div');

        // 树形tab和树形查询tab
        var treeWrap = othis.treeWrap = document.createElement('div');          
        var jqtree   = othis.jqtree   = document.createElement('ul');
        // 查询结果以列表树形展现
        var jqtreeQuery    = document.createElement('ul');
        var checkbtnWrap   = document.createElement('div'); 
        var jqtreeTab      = document.createElement('div');
        var jqtreeQueryTab = document.createElement('div');
		// tab页签 - 多选时，放置已经选择的树节点
		var jqtreeSelectTab = document.createElement('div');
		// 多选时，表格显示已经选择的树节点
		var jqtreeSelectGrid = document.createElement('table');
		othis.jqtreeSelectTab = jqtreeSelectTab;
		othis.jqtreeSelectGrid = jqtreeSelectGrid;
		
        var btnWrap  = document.createElement('div');
        var addbtn   = document.createElement('button');
        var clearbtn = document.createElement('button');
        var exitbtn  = document.createElement('button');
        $(addbtn).html('确定');
        $(clearbtn).html('清空');
        $(exitbtn).attr('title','关闭窗口').html('关闭');
            
        // 表格查询部分创建对象Json
        var tableQueryDivJson = {};
        // 底部按钮所在div
        var queryInputWidth = 130;
        if(!isWinPlug){
            $(container).parent().css('overflow','hidden')
            var containerW = $(container).css('overflow','hidden').width();
            var queryBtnWOffset = 105;
            //alert(containerW);
            queryInputWidth = containerW && (containerW - queryBtnWOffset)<=135 ? containerW - queryBtnWOffset : 135;
            //alert(queryInputWidth);
        }
        var divJson = !othis.option.treeQueryBox ? {} : QUtil.createQueryInputAndBtn(othis.option.queryDivId,othis.option.queryInputId, othis.option.queryBtnId, othis.option.style4, '模糊节点查询', queryInputWidth, !isWinPlug);
        // 最外层包装的div
        var footBtnWrap = divJson.queryDivWrap;
        if(!othis.option.treeQueryBox){
            footBtnWrap = document.createElement('div');
            $(footBtnWrap).attr({'id':othis.option.queryDivId});
        }
        // 查询按钮和输入框
        var queryWrap  = divJson.queryWrap;
        var queryInput = divJson.queryInput;
        var querybtn   = divJson.querybtn;
        var resizequerybtn     = divJson.resizequerybtn;
        var queryPagingWrap    = divJson.queryPagingWrap;
        var queryInputFirst    = divJson.queryInputFirst;
        var queryInputPrevious = divJson.queryInputPrevious;
        var queryInputNext  = divJson.queryInputNext;
        var queryInputLast  = divJson.queryInputLast;
        var queryInputClear = divJson.queryInputClear;
        $(resizequerybtn).hide();
        
        // 左侧树形tabs页
        $(jqtreeTab).attr({
            'title':this.option.treeTabTitle1,
            'style':'padding:5px;',
            'data-options':"iconCls:'icon-reload'"
        });
        $(jqtreeQueryTab).attr({
            'title':this.option.treeTabTitle2,
            'style':'padding:5px;'
        });
		
		$(jqtreeSelectTab).attr({
            'title':this.option.treeTabTitle3,
            'style':'padding:5px;'
        });
        
        // 创建窗体div，树形div，按钮button所在div
        $(winWrap).attr({
            'title':othis.option.title,
            'style':othis.option.style1,
            'id'   :othis.option.winWrapId
        });
        $(treeWrap).attr({
            'id'   :othis.option.treeWrapId,
            'style':othis.option.style2
        });

        $(btnWrap).attr({
            'id'   :othis.option.btnWrapId,
            'style':othis.option.style3
        });
        

        
        $(jqtree).addClass('easyui-tree').attr({'id':othis.option.jqTreeId}).css({
            'float':'left',
            'both':'right'
        });
        $(jqtreeTab).append(jqtree);    
        
        $(btnWrap).append(addbtn).append("&nbsp;").append(clearbtn).append("&nbsp;").append(exitbtn);
        
        // 树形和搜索结果放到两个tab页中
        $(treeWrap).append(jqtreeTab);
        
        if(othis.option.treeQueryBox){
            $(jqtreeQuery).addClass('easyui-tree').attr('id',othis.option.jqTreeQueryId);
            $(jqtreeQueryTab).append(jqtreeQuery);
            $(treeWrap).append(jqtreeQueryTab); 
        }
		
		if(othis.option.treeCheckbox){			
			$(jqtreeSelectTab).append(jqtreeSelectGrid);
			$(treeWrap).append(jqtreeSelectTab);
			// 初始化表格-已经选的树节点
			$(jqtreeSelectGrid).datagrid({
				fit : true,
				rownumbers:true,
				striped:true,
				nowrap :true,
				border :false,
				collapsible:false,
				pagination:false,
				checkOnSelect:false,
				selectOnCheck:false,
				onLoadSuccess:function(data){
					$('.datagrid-btable').css({
						'margin':'0px',
						'font-size':'12px'
					});
				},
				onClickCell:function(rowIndex, field, value){
					if(field == 'name'){
						var rows = $(jqtreeSelectGrid).datagrid('getRows');
						var row = rows[rowIndex];
						//alert(row)
						//alert(row.id)
						//alert(othis.option.finalPriorUrl)
						QUtil.expandPriorNodeByIds(row.id,  othis.option.finalPriorUrl, jqtree, "");
						// 选中第一个tab页
                        $(treeWrap).tabs('select', 0);
					}
				},
				toolbar:[{
					text:'删除',
					iconCls:'icon-delete',
					handler:function(){
						var rows = $(jqtreeSelectGrid).datagrid('getChecked');
						if(rows && rows.length > 0){
							top.$.messager.confirm('提示信息','确认删除选中的记录吗？', function(r){
								if(r){
									var len = rows.length;
									for(var i=len-1; i>-1;i--){
										var row = rows[i];
										var nodeId = row.id;
										var index = $(jqtreeSelectGrid).datagrid('getRowIndex', row);
										//alert('len='+len+',i='+i+',index='+index); 
										$(jqtreeSelectGrid).datagrid('deleteRow', index);
										if(nodeId){
											var nodeTarget = ($(jqtree).tree('find', nodeId)).target;
											$(jqtree).tree('uncheck', nodeTarget);
										}
									}
								}
							});
						}else{
							var noRecInfo = '请选择要删除的记录！';
							top.$.messager.alert('提示信息',noRecInfo, 'error');
							//showMessage1(noRecInfo);
						}
					}
				},'-'],
				columns:[this.option.treeNodeSelectedColumns]	
			});
			
			
            
		}
        
        if(othis.option.type === 'tree'){// 只有树形的情况
            if(isWinPlug){// 默认容器的情况，一般插件为弹出窗口
                $(headWrap).attr({
                   'style':'height:300px;width:746px;',
                   'fit'  :'true'
                }).addClass('easyui-layout');
                $(headWrap).append(treeWrap); 
                $(footBtnWrap).append(btnWrap);
                //$(winWrap).append(checkbtnWrap);                    
                $(winWrap).append(headWrap);
                $(winWrap).append(footBtnWrap);
                $(container).append(winWrap);
            }else{// 指定装载容器的情况，一般为插件嵌入到页面
                $(queryWrap).css({
                    'padding':'0px',
                    'margin-top':'-5px'
                });
                $(footBtnWrap).css({
                    'position':'absolute',
                    'right':'0px'
                }).hide();
                $(jqtreeTab).prepend(footBtnWrap); 

                $(container).append(treeWrap);
                
                // resize重新调整整体布局，使嵌入式树形能有滚动条
                var mainlayout = $(container).parent();
                while(mainlayout != null && !mainlayout.hasClass('easyui-layout')){
                	if(mainlayout[0].nodeName == 'BODY') break;
                    mainlayout = mainlayout.parent();
                }
                if(mainlayout && mainlayout.hasClass('easyui-layout')){
                    mainlayout.layout('resize');
                }else{
                    $(container).css('height',$(mainlayout).height()-40);
                }               
            }
        }else{
            layoutWrap = othis.getTreeAndEmployeeLayout(winWrap,headWrap,queryWrap,btnWrap,treeWrap);
            // 添加右侧table表格查询div, 创建输入框和查询按钮
            if(othis.option.gridQueryBox){
                tableQueryDivJson = QUtil.createQueryInputAndBtn(
                    othis.option.tableQueryDivId,
                    othis.option.tableQueryInutId, 
                    othis.option.tableQueryBtnId, 
                    othis.option.style4, '模糊查询人员姓名',140);
                
                $(tableQueryDivJson.resizequerybtn).hide();
                $(tableQueryDivJson.queryPagingWrap).hide();
                $(tableQueryDivJson.querybtnDb).hide();
                //$(tableQueryDivJson.queryInputSerachType).hide();
                $(layoutWrap).find("div[selectTab='selectPerson']").append(tableQueryDivJson.queryDivWrap);
                //alert(container.nodeName)
                $(tableQueryDivJson.queryDivWrap).css({
                    'position':'absolute',
                    'top':'-2px',
                    'right':'-2px',
                    'zIndex':'999999'
                });
            }           
        }
        
        // 初始化按钮样式
        $(addbtn).linkbutton({
            'iconCls':'icon-ok'
        });

        $(clearbtn).linkbutton({
            'iconCls':'icon-empty'
        });
        $(exitbtn).linkbutton({
            'iconCls':'icon-cancel'
        });
            
        // 初始化窗体样式
        if(isWinPlug){
            $(winWrap).window({      
                collapsible:true,
                maximizable:false,
                minimizable:false,
                shadow     :false,
                resizable  :true,
                closed     :true,
                modal      :true,
                onBeforeOpen:function(){
                    var fn = othis.option.onBeforeLoad;
                    if(fn){
                        return fn.call(othis, othis.option);
                    }
                    return true;
                },
                onResize:function(width,height){
                    // layoutWrap 添加了fit属性， 此处不用resize了
                    //alert(width + ' '+height);  
                    //$(layoutWrap).layout('resize');
                }
            });
        }
        if(othis.option.showTabTools){
            //alert(othis.option.treeCheckbox)
            var tabToolsId = "tab-tools_"+QUtil.ran(6);
            var tabToolsMenuId = "tab-tools-menuList_"+QUtil.ran(6);    
            var menuList = $("<div  id=\""+tabToolsMenuId+"\"></div>").appendTo($('body')[0]); 
            if(othis.option.type === 'tree' && !isWinPlug && othis.option.treeQueryBox){
                $("<div data-options=\"iconCls:'icon-search'\">节点搜索</div> ").appendTo(menuList).bind('click', function(){
                    $(footBtnWrap).show();
                });  
                $("<div class='menu-sep'></div>").appendTo(menuList); 
            }
            $("<div data-options=\"iconCls:'icon-expand'\">展开全部</div> ").appendTo(menuList).bind('click', function(){
                QUtil.expandOrCollapseAllNodes(jqtree,$(jqtree).tree('getRoot'));
            });   
            $("<div data-options=\"iconCls:'icon-arrow-down'\">展开选中</div> ").appendTo(menuList).bind('click', function(){
                QUtil.expandOrCollapseAllNodes(jqtree);
            });       
            $("<div class='menu-sep'></div>").appendTo(menuList);
            $("<div data-options=\"iconCls:'icon-collapse2'\">折叠全部</div> ").appendTo(menuList).bind('click', function(){
                QUtil.expandOrCollapseAllNodes(jqtree,$(jqtree).tree('getRoot'),'collapse');
            });   
            $("<div data-options=\"iconCls:'icon-arrow-up'\">折叠选中</div> ").appendTo(menuList).bind('click', function(){
                QUtil.expandOrCollapseAllNodes(jqtree, $(jqtree).tree('getSelected'), 'collapse');
            });    
            $("<div class='menu-sep'></div>").appendTo(menuList);
            $("<div data-options=\"iconCls:'icon-reload'\">重新加载</div> ").appendTo(menuList).bind('click', function(){
                $(jqtree).tree('reload');
            }); 
            
            /*

            $("<div data-options=\"iconCls:'icon-allToMe'\" style='font-weight:bold;'>启用缓存</div> ").appendTo(menuList).bind('click', function(){
                //$(jqtree).tree('options').serverCache = true;
				$(this).find('div:first').css("font-weight","bold");
				$(this).next().find('div:first').css("font-weight","normal");
            }); 
			
            $("<div data-options=\"iconCls:'icon-cancel'\">禁用缓存</div> ").appendTo(menuList).bind('click', function(){
                //$(jqtree).tree('options').serverCache = false;
				$(this).find('div:first').css("font-weight","bold");
				$(this).prev().find('div:first').css("font-weight","normal");
            }); 
			*/
			
            $("<div data-options=\"iconCls:'icon-clean'\">清空缓存</div> ").appendTo(menuList).bind('click', function(){
				var treePlugId = othis.option.treeParam.plugId || othis.option.treeParam.beanName;
                QUtil.clearTreeCache(othis.option.clearTreeCache, treePlugId);
            }); 
			
            if(othis.option.treeCheckbox){ 
                $("<div class='menu-sep'></div>").appendTo(menuList); 
                $("<div data-options=\"iconCls:'icon-cascadeOpen'\" >级联选择</div> ").appendTo(menuList).bind('click', function(){
                    $(jqtree).tree('options').cuscascade = true;
					$(jqtree).tree('options').cascadeJunior = true;
                    $(this).find('div:first').css("font-weight","bold");
                    $(this).next().find('div:first').css("font-weight","normal");
                });   
                $("<div data-options=\"iconCls:'icon-cascadeCancel'\" style='font-weight:bold;'>单级选择</div> ").appendTo(menuList).bind('click', function(){
                    $(jqtree).tree('options').cuscascade = false;
					$(jqtree).tree('options').cascadeJunior = false;
                    $(this).find('div:first').css("font-weight","bold");
                    $(this).prev().find('div:first').css("font-weight","normal");
                });          
                $("<div class='menu-sep'></div>").appendTo(menuList); 
                $("<div data-options=\"iconCls:'icon-checkbox1'\">全部选中</div> ").appendTo(menuList).bind('click', function(){
                    checkAllOrCancel(jqtree, true);
                }); 
                $("<div data-options=\"iconCls:'icon-checkbox0'\">取消选中</div> ").appendTo(menuList).bind('click', function(){
                    checkAllOrCancel(jqtree, false);
                }); 
                
                function checkAllOrCancel(jqtree, checked){
                    var roots = $(jqtree).tree('getRoots');
                    if(roots && roots.length){
                        $.each(roots, function(i, root){
                            $(jqtree).tree(checked ? 'check' : 'uncheck', root.target);
                        });
                    }
                }
            }
            // tab tools
            var tabTools = $("<div  id=\""+tabToolsId+"\"></div>").appendTo($('body')[0]);
            var item = document.createElement('a');
            tabTools.append(item);
            $(item).menubutton({    
                iconCls: 'icon-menu',    
                menu: '#'+tabToolsMenuId   
            });
  
        }
        
        // 初始化左侧树形tab
        $(treeWrap).tabs({
            border:false,
            fit:true,
            onSelect:function(title,index){
				//alert(title + "\n" +index);
				var isCheckNodeChanged = $(othis.jqtree).data('isCheckNodeChanged');
				if(othis.option.treeCheckbox && isCheckNodeChanged && title == othis.option.treeTabTitle3){
					var selectNodes = $(othis.jqtree).tree('getChecked');
					//alert(selectNodes)
					var jqtreeSelectGridJsonData = {
							total:0,
							intPage:1,
							intPageSize:20,
							rows:[]
						}
					if(selectNodes != null && selectNodes.length){
						jqtreeSelectGridJsonData.total = selectNodes.length;
						$.each(selectNodes, function(i, selectNode){
							jqtreeSelectGridJsonData.rows.push({
								'id'  :selectNode.id,
								'name':selectNode.text
							});
						});
					}
					//alert(jqtreeSelectGridJsonData.rows)
					$(othis.jqtreeSelectGrid).datagrid('loadData', jqtreeSelectGridJsonData);
					$(othis.jqtree).data('isCheckNodeChanged', false);
				}
			},
            tools:tabToolsId ? "#"+tabToolsId : ''
        });
        $(treeWrap).find('ul').filter('.tabs').find('.icon-reload').css('cursor','pointer').attr('title','单击-刷新树').click(function(){
            $(jqtree).tree('reload');
        });
        

        //alert(this.option.priorUrl ? this.option[this.option.priorUrl] : this.option.getPriorDept);
        //alert(this.option.priorUrl +'\n'+ this.option[this.option.priorUrl] +'\n'+ this.option.getPriorDept);
        var treeParam = othis.option.treeParam;
        var treeUrl   = othis.option.treeUrl;
        if(!treeUrl){
            treeUrl = othis.option.getDefaultTreeUrl;
        }
        var finalPriorUrl = null;
        if(treeUrl && treeUrl.indexOf('commonPlug') != -1){
            finalPriorUrl = othis.option.getPriorDefault;
        }else{
            finalPriorUrl = othis.option.priorUrl ? othis.option[othis.option.priorUrl] : othis.option.getPriorDept;
        }
		
        //alert(finalPriorUrl);
        if(treeParam && finalPriorUrl){
            var tmp = [];                  
            // url中没有问号
            if(finalPriorUrl.indexOf('?') == '-1'){
                tmp.push("?1=1");
            }else{
                tmp.push("&1=1");
            }
            for(var p in treeParam){
                tmp.push('&');
                tmp.push(p);
                tmp.push('=');
                tmp.push(treeParam[p]);
            }
            finalPriorUrl += tmp.join('');
       }
	   othis.option.finalPriorUrl = finalPriorUrl;
        return {
           'tableType':othis.option.type,
           'tableUrl' :othis.option.tableUrl,
           'winWrap' :winWrap,
           'treeWrap':treeWrap,
           'btnWrap' :btnWrap,
           'jqtree'  :jqtree,
           'jqtreeTab':jqtreeTab,
           'jqtreeQuery':jqtreeQuery,
           'jqtreeQueryTab':jqtreeQueryTab,
           'addbtn'  :addbtn,
           'clearbtn':clearbtn,
           'exitbtn' :exitbtn,
           'queryInput': queryInput,
           'resizequerybtn':resizequerybtn,
           'queryPagingWrap'   :queryPagingWrap,
           'queryInputFirst'   :queryInputFirst,
           'queryInputPrevious':queryInputPrevious,
           'queryInputNext'    :queryInputNext,
           'queryInputLast'    :queryInputLast,
           'queryInputClear':queryInputClear,
           'queryInputSerachWrap':divJson.queryInputSerachWrap,
           'querybtn'  : querybtn, 
           'querybtnDb': divJson.querybtnDb, 
           
           'tableQueryWrap' :tableQueryDivJson.queryWrap,
           'tableQueryInput':tableQueryDivJson.queryInput,
           'tableQueryInputSerachWrap':tableQueryDivJson.queryInputSerachWrap,
           'tableQuerybtn'  :tableQueryDivJson.querybtn,
           'tableQuerybtnDb'  :tableQueryDivJson.querybtnDb,
           'tableResizequerybtn' :tableQueryDivJson.resizequerybtn,
           'tableQueryPagingWrap':tableQueryDivJson.queryPagingWrap,
           'tableQueryInputFirst'  :tableQueryDivJson.queryInputFirst,
           'tableQueryInputPrevious':tableQueryDivJson.queryInputPrevious,
           'tableQueryInputNext'    :tableQueryDivJson.queryInputNext,
           'tableQueryInputLast'  :tableQueryDivJson.queryInputLast,
           'tableQueryInputClear':tableQueryDivJson.queryInputClear,
           'tableQueryDivWrap'   :tableQueryDivJson.queryDivWrap,           
           'layout'   :layoutWrap,
           'tableInfo':this.tableInfoWrap,
           'tableSelectedInfoWrap':this.tableSelectedInfoWrap,
           'showSelectDataWrap':this.showSelectDataWrap,
           'waitingSelectTab':this.waitingSelectTab,
           'selectedTab' :this.selectedTab,
           'getPriorDept':this.option.getPriorDept,
           'getPriorAud' :this.option.getPriorAud,
           'getPriorDefault':this.option.getPriorDefault,
           'getPriorUrl' :finalPriorUrl,
           'getDefaultTreeUrl':this.option.getDefaultTreeUrl,
           'treeParam':othis.option.treeParam,
           'lazy':othis.option.lazy,
		   'jqtreeSelectTab' :jqtreeSelectTab,
		   'jqtreeSelectGrid':jqtreeSelectGrid
        };
    }catch(e){
        isdebug ? alert("createOrgTree.prototype.createWin:\n"+e.message) : null;
    }
}

createOrgTree.prototype.getTreeAndEmployeeLayout = function(winWrap,headWrap,queryWrap,btnWrap,treeWrap){
    try{
        var othis = this;
        // 默认 加载被审计人员
        var waitingSelectColumns = othis.option.employeeColumns;
        var selectedColumns      = othis.option.employeeSelectedColumns;
        var waitingSelectUrl     = othis.option.getEmployee;
        var type = othis.option.type;
        if(type){
            if(type === 'economyDuty'){
                waitingSelectColumns = othis.option.economyDutyColumns;
                selectedColumns      = othis.option.economyDutySelectedColumns;
                waitingSelectUrl     = othis.option.getEconomyDuty;
            }else if(type === 'treeAndUnEmployee'){
                waitingSelectColumns = othis.option.economyDutyColumns;
                selectedColumns      = othis.option.economyDutySelectedColumns;
                waitingSelectUrl     = othis.option.getUnEmployee;
            }else if(type === 'treeAndUser'){
                //waitingSelectColumns = othis.option.economyDutyColumns;
                selectedColumns      = othis.option.economyDutySelectedColumns;
                waitingSelectUrl     = othis.option.getUser;
            }
        }
        othis.option.tableUrl = waitingSelectUrl;
        var idsInput   = othis.option.idsInput;
        var namesInput = othis.option.namesInput;            
        othis.tableInfoWrap = othis.option.tableInfoWrap = document.createElement('table');
        var layoutWrap  = document.createElement('div'); 
        this.showSelectDataWrap = document.createElement('div');
        var showSelectedDataWrap = document.createElement('div');
        var selected_tableinfoWrap = document.createElement('table');
        othis.tableSelectedInfoWrap = othis.option.tableSelectedInfoWrap = selected_tableinfoWrap;
        var panelLeftWrap  = document.createElement('div'); 
        var panelRightWrap = document.createElement('div'); 
        var panelBottomWrap = document.createElement('div'); 
        
        var tab1 = document.createElement('div');
        var tab2 = document.createElement('div');
        this.waitingSelectTab = tab1;
        this.selectedTab = tab2;
        this.showSelectedDataWrap = showSelectedDataWrap;
        
        $(othis.tableInfoWrap).attr({
            //'style':'width:auto;height:auto;margin:0px;'
        });
        $(selected_tableinfoWrap).attr({
            'style':'width:auto;height:auto;margin:0px;'
        });
        
        // tabs页
        $(tab1).attr({
            'selectTab':'selectPerson',
            'title':'待选择人员'
        });
        $(tab2).attr({
            'title':'已选择人员'
        });
        $(layoutWrap).attr({
           style:'height:363px',    
           fit:true
        }).addClass('easyui-layout');
       
        
        $(panelLeftWrap).attr({
            'region':'west',
            'split' :'true',
            border:false,
            //'collapsible':'true',
            //'title' :'Lazy-loading Tree',
            'id'    :'QPlus_leftTreeId',
            'style' :'width:260px;overflow:hidden;'
        });
        $(panelRightWrap).attr({
            'region':'center',
            border:false,
            'style' :'overflow:hidden;'
        });
        $(panelBottomWrap).attr({
            'region':'south',
            //border:false,
            'style' :'height:33px;overflow:hidden;'
        });
        
        $(panelBottomWrap).append(queryWrap).append(btnWrap);
        $(panelLeftWrap).append(treeWrap);
        $(tab1).append(this.tableInfoWrap);
        $(tab2).append(selected_tableinfoWrap);
        $(this.showSelectDataWrap).append(tab1).append(tab2);
        $(panelRightWrap).append(this.showSelectDataWrap);
        $(layoutWrap).append(panelLeftWrap).append(panelRightWrap).append(panelBottomWrap);

        $(headWrap).append(layoutWrap);     
        $(winWrap).append(headWrap);
        $(othis.option.container ? othis.option.container : 'body').append(winWrap);
        
        // 初始化布局
        $(layoutWrap).layout({});   
        $(layoutWrap).layout('panel','west').panel({
            iconCls:'icon-tip'
        });

        $(othis.tableInfoWrap).data('isCRUD',false); 
        
        // 编辑模式时，把页面隐藏域中的ids names初始化后放到cache中,以便在表格中标记处已选的记录（此段只在初始化时执行一次）
        //alert(idsInput.value + namesInput.value);
        QUtil.initDatagridCheckCache(othis.tableInfoWrap,idsInput,namesInput);
        
        //alert(othis.option.isEmployeeRadio)
        // 初始化表格-待选择
        othis.option.defaultUserId ? $(othis.tableInfoWrap).data('defaultUserId',othis.option.defaultUserId) : null;
        // 把要更新的参数放到extend的第二参数位置，防止被已有参数给覆盖
        var queryParamsJson = jQuery.extend({},othis.option.gridParam,{'p_deptid':othis.option.defaultDeptId});
        // 缓存查询参数
        $(othis.tableInfoWrap).data('queryParamsJson',queryParamsJson);
        $(othis.tableInfoWrap).datagrid({
            url : waitingSelectUrl,
            queryParams:jQuery.extend({}, queryParamsJson),
            fit : true,
            singleSelect:othis.option.isEmployeeRadio,
            rownumbers:true,
            pagination:true,
            striped:true,
            loadMsg:'表格数据加载中，请稍后......',
            nowrap : true,
            border : false,
            collapsible : false,	
           // toolbar:"'#"+othis.option.tableQueryDivId+"'",
            onLoadSuccess:function(data){
                //alert('onLoadSuccess over '+data.rows.length);
                // 根据缓存中的已选择的记录，初始化当前页面(待选择tab)的checkbox
                if(data && data.rows.length > 0){
                    QUtil.initPageCheckboxByCach(othis.tableInfoWrap);
                }
                $('.datagrid-btable').css({
                    'margin':'0px',
                    'font-size':'12px'
                });
                $('.datagrid-pager,.pagination').find('table').css({
                    'margin':'0px',
                    'background-color':'rgb(239, 239, 239)'
                });
            },
            onSortColumn:function(sortName,sortOrder){
                var queryparams = $(othis.tableInfoWrap).datagrid('options').queryParams;  
                queryparams['sortOrder'] = sortOrder;
                
                // 读取缓存中的查询参数
                var gridQueryParamJson = $(othis.tableInfoWrap).data('queryParamsJson');
                gridQueryParamJson = gridQueryParamJson ? gridQueryParamJson : {};
                // 读取分页信息
                var pager = $(othis.tableInfoWrap).datagrid('getPager');
                var pt = $(pager).pagination('options')
                $(othis.tableInfoWrap).datagrid('options').queryParams = $.extend(gridQueryParamJson,{
                    'page':pt.pagetNumber,
                    'rows':othis.option.pageSize ? othis.option.pageSize: pt.pageSize,
                    'sort':sortName, 
                    'order':sortOrder});                     
            },
            onSelectAll:function(rows){
                QUtil.addSelections(othis.tableInfoWrap,rows,othis.option.isEmployeeRadio);
            },
            onUncheckAll:function(rows){
                QUtil.clearAll(othis.tableInfoWrap,rows);
            },
            onCheck:function(rowIndex, rowData){
                var rows = [];
                rows.push(rowData);
                QUtil.addSelections(othis.tableInfoWrap,rows,othis.option.isEmployeeRadio);
            },
            onUncheck:function(rowIndex, rowData){
                QUtil.removeUnSelected(othis.tableInfoWrap,rowData);
            },
            /*
            onSelect:function(rowIndex, rowData){
                //alert(othis.option.isEmployeeRadio);
                // true ： 单选
                if(othis.option.isEmployeeRadio){
                    var rows = $(othis.tableInfoWrap).datagrid('getChecked');
                    if(rows.length>0){
                        $.each(rows,function(i,row){
                            var index = $(othis.tableInfoWrap).datagrid('getRowIndex',row);
                            //alert(index);
                            if(index == rowIndex) return true; 
                            $(othis.tableInfoWrap).datagrid('uncheckRow',index);
                            //$(othis.tableInfoWrap).datagrid('unselectRow',index);
                        });
                    }
                }
            },
            */
            columns:[waitingSelectColumns]	
        });       
        //设置分页控件  
        /*
        var pager = $(othis.tableInfoWrap).datagrid('getPager');
        $(pager).pagination({
            onSelectPage:function(pageNumber,pageSize){
                othis.option.pageSize = pageSize;
                var selectedNode = null;
                if(othis.jqtree){
                    selectedNode = $(othis.jqtree).tree('getSelected');
                }
                var queryParamsJson = $(othis.tableInfoWrap).data('queryParamsJson');
                var pagerParamsJson = {
                    'page':pageNumber,
                    'rows':pageSize
                };
                var params = jQuery.extend(queryParamsJson,pagerParamsJson);
                QUtil.loadWaitingTabByTreeId({
                    url :othis.option.tableUrl,
                    data:params,
                    datagridTable:othis.tableInfoWrap
                });
            },
            showRefresh:true,
            showPageList:true,
            pageSize : othis.option.pageSize ? othis.option.pageSize :10,//每页显示的记录条数，默认为10  
            pageList : [ 5, 10, 15, 20,25,30,50 ],//可以设置每页记录条数的列表  
            beforePageText : '第',//页数文本框前显示的汉字  
            afterPageText  : '页  共{pages}页',
            displayMsg     : '显示[{from}-{to}]条, 共{total}条'
        });*/

        // 初始化表格-已经选的选择
        $(selected_tableinfoWrap).datagrid({
            fit : true,
            rownumbers:true,
            striped:true,
            nowrap :true,
            border :false,
            collapsible:false,
            pagination:false,
            onLoadSuccess:function(data){
                $('.datagrid-btable').css({
                    'margin':'0px',
                    'font-size':'12px'
                });
            },
            toolbar:[{
                text:'删除',
                iconCls:'icon-delete',
                handler:function(){
                    var rows = $(selected_tableinfoWrap).datagrid('getChecked');
                    //QUtil.clearAll(othis.tableInfoWrap,rows);
                    // 选择tab页是否有数据变更（比较重新选择了记录，已选的变为不选），没有的情况下则不进行已选择tab页的操作
                    var isCRUD = true; //$(othis.tableInfoWrap).data('isCRUD');
                    if(rows && rows.length > 0 && isCRUD){
                        var len = rows.length;
                        for(var i=len-1; i>-1;i--){
                            var row = rows[i];
                            var index = $(selected_tableinfoWrap).datagrid('getRowIndex', row);
                            //alert('len='+len+',i='+i+',index='+index); 
                            $(selected_tableinfoWrap).datagrid('deleteRow', index);
                        }
                        // 从缓存中清除
                        $.each(rows,function(i,row){
                            QUtil.removeUnSelected(othis.tableInfoWrap,row);
                        });
                        
                        //$.messager.alert('提示信息','成功删除【'+len+'】条记录！', 'info');
                    }else{
                        //top.$.messager.alert('提示信息','请选择要删除的记录！', 'error');
                        showMessage1('请选择要删除的记录！');
                    }
                }
            },'-'],
            columns:[selectedColumns]	
        });
        //设置分页控件  
        /*
        var p2 = $(selected_tableinfoWrap).datagrid('getPager');
        $(p2).pagination({
            showRefresh:false,
            showPageList:true,
            pageSize : 20,//每页显示的记录条数，默认为10  
            pageList : [ 10, 15, 20 ],//可以设置每页记录条数的列表  
            beforePageText : '第',//页数文本框前显示的汉字  
            afterPageText  : '页    共 {pages} 页',
            displayMsg     : ''
        });*/
        
        // 设置pageList所在input的长度
        //$('.pagination-page-list').css('width','40px');     
        
        // 初始化tabs，当单击"已选择"tab时，加载已选择的人员
        $(this.showSelectDataWrap).tabs({
            fit:true,
            border:false,
            onSelect:function(title,index){            
                if(index === 1){
                    //alert('isCRUD='+$(othis.tableInfoWrap).data('isCRUD'));
                    // 加载缓存中的已经选择的审计人员
                    QUtil.loadSelectedRows(othis.tableInfoWrap,selected_tableinfoWrap);
                }else if(index === 0){ 
                    //alert('tab 0 select')                     
                    // 根据缓存中的已选择的记录，初始化当前页面(带选择tab)的checkbox
                    QUtil.initPageCheckboxByCach(othis.tableInfoWrap);
                }
            }
        });
        return layoutWrap;
    }catch(e){
        isdebug ? alert('getTreeAndEmployeeLayout:\n'+e.message) : null;
    }
};

// 公共组件类
var QUtil = {
	// 清空服务器树形缓存
	clearTreeCache:function(clearTreeCacheUrl, plugId){
		try{
			$.ajax({
				url : clearTreeCacheUrl,
				async:false,
				data: {'plugId':plugId},
				type: 'post',
				dataType:'json',
				success: function(data){
					//top.$.messager.alert('提示信息', data.msg, data.type);
					top.$.messager.show({
						title:'提示信息',
						msg:data.msg,
						timeout:5000,
						showType:'slide'
					});
				},
				error:function(data){
					top.$.messager.alert('提示信息','请求失败！请检查网络连接或者与管理员联系！','error');
				}
			}); 
		}catch(e){
			isdebug ? alert('clearTreeCache:\n'+e.message) : null;
		}
	},	
    // 设置datagrid 列的short短长度显示
    getShortCol: function(value,rowData,rowIndex){
        var rtval = "", n1=4, n2=6;
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
    },
    // 判断对象类型，能判断出Array对象，参数可以是一个对象或者数组
    getType: function(){
        try {
            var typeArr = [];
            var len = arguments.length;
            for (var i = 0; i < len; i++) {
                var object = arguments[i];
                if (object != null) {
                    var t = Object.prototype.toString.call(object).slice(8, -1);
                    //alert(i+","+object+","+t+","+typeof object)
                    t = t ? t.toLowerCase() : object;
                    //var s = t.replace("[","").replace("]","").split(" ")[1];
                    if (len == 1) {
                        return t;
                    }
                    typeArr.push(t);
                }else{
                    typeArr.push(String(object))
                }
            }
            if (typeArr.length > 1) {
                
            }else{
                return typeArr.join('');
            }
        } catch (e) {
            isdebug ? alert("getType:\n"+e.message) : null;
        }
    },
    // string转化成json , IE6不支持JSON.parse(str); 
    string2json: function(data){
        try {
            if ($.type(data) === "string") {
                return (new Function("return " + data.trim()))();
            }else if (QUtil.getType(data) === "object") {
            	return data;
            } else {
                return null;
            }
        } catch (e) {
            isdebug ? alert("string2json:\n"+e.message) : null;
        }
    },
    // 遍历Object的内容
    travelObject: function(json){
        try {
            var strArr = [];
            if (json && typeof(json) == "object") {
                for (var p in json) {
                    strArr.push(p);
                    strArr.push(" = ");
                    strArr.push(json[p]);
                    strArr.push("\n ");
                }
            }
            return strArr.join("");
        } catch (e) {
            isdebug ? alert("travelObject:\n"+e.message) : null;
        }
    },
    // 获得easyui对象
    getObj:function(id){
        try{
            return $(jQuery.type(id) == 'string' ? '#'+id : id);
        }catch(e){
            isdebug ? alert("getObj:\n"+e.message) : null;
        }
    },
    // 滚动条滚动到最下
    scrollDown:function(id){
        try{
              var target = QUtil.getObj(id);
              target.length ? target.scrollTop(target[0].scrollHeight - target.height()) : null;
        }catch(e){
            isdebug ? alert("scrollDown:\n"+e.message) : null;
        }
    },
    // 检查日期前后管理，后一个参数id的日期值应大于第一个日期的值
    checkDateAfterDate:function(target, id1, id2, mtq){
        if(target && ($(target).attr('id') == id1 || $(target).attr('id') == id2)){
            var obj1 = $('#'+id1);
            var obj2 = $('#'+id2);
            var startTime0 = obj1.val();
            var endTime0   = obj2.val();
            if(startTime0 && endTime0){
                var startTime = startTime0.split('-');
                var endTime   = endTime0.split('-');
                var error = false;
                if(mtq){// 大于等于
                    error = endTime <  startTime ? true : false;
                }else{
                    error = endTime <= startTime ? true : false;
                }
                if(error){
                    top.$.messager.alert('提示信息',obj2.attr('title')+'['+endTime0+']</br>应大于</br>'+obj1.attr('title')+'['+startTime0+']','error',function(){
                        $(target).val('').focus();
                    });
                }
                return !error;
            }
        }
    },
    // 表单检查, 检查formid下的class=required的所有input select textarea是否为空，并进行提示
    formBeforeSendCheck:function (formId){
        var rt = true;
        try{
            if(formId){
                var form = $(jQuery.type(formId) == 'string' ? '#'+formId : formId);
                var elements = form.find('.required');
                // 检查非空
                if(elements.length){
                    $.each(elements, function(i,ele){
                        var nodeName = ele.nodeName;
                        if(!$(ele).val() && (nodeName == 'INPUT' || nodeName == 'SELECT' || nodeName == 'TEXTAREA')){
                           rt = false;
                           top.$.messager.alert('提示信息','['+$(ele).attr('title')+']不能为空!','error',function(){
                               $(ele).focus();
                           });
                           return false;
                        }
                    });
                }
                
                // 检查字数最大值
                var texts = form.find('[max_length]');
                if(rt && texts.length){
                    $.each(texts, function(i,ele){
                        rt = QUtil.checkMaxInputLen([ele]);
                        if(!rt) return false;
                    });
                }
            }
                   
        }catch(e){
            isdebug ? alert("formBeforeSendCheck:\n"+e.message) : null;
        }
        return rt;
    },
    // 检查form表单输入框的最大字符数
    checkMaxInputLen:function (idsArr){
        var rt = true;
        try{
            if(idsArr && $.type(idsArr) == 'array'){
                $.each(idsArr, function(i, id){
                    var obj = $(jQuery.type(idsArr) == 'string' ? '#'+id : id);
                    if(obj){
                        var content = obj.val();
                        var maxLen = obj.attr('max_length');
                        var len = content.rlength();
                        if(len > maxLen){
                               rt = false;
                               top.$.messager.alert('提示信息','['+obj.attr('title')+']超过最大['+maxLen+']字限制，当前字数为['+len+']个','error',function(){
                                   obj.focus();
                               });
                        }
                    }
                });
            }
        }catch(e){
            isdebug ? alert("checkMaxInputLen:\n"+e.message) : null;
        }
        return rt;
    },
    // 清空表单,把class=clear的input select textarea清空
    clearForm:function(formId){
        try{
            if(formId){
                var elements = $('#'+formId).find('.clear');
                if(elements.length){
                    $.each(elements, function(i,ele){
                        var nodeName = ele.nodeName;
                        //alert(nodeName+'\n'+ele.id)
                        if(nodeName == 'INPUT' || nodeName == 'SELECT' || nodeName == 'TEXTAREA'){
                            $(ele).val('');
                        }else{
                            $(ele).html('');
                        }
                    });
                }
            }
        }catch(e){
            isdebug ? alert("clearForm:\n"+e.message) : null;
        }
    },
    // 设置easyui按钮的状态,显示或者隐藏
    setEasyuiBtn:function(ids,isHidden){
        try{
            $.each(ids, function(i,id){
                var obj = jQuery.type(id) === "string" ? $('#'+id) : $(id);
                var separator = $('#'+id+' ~ .dialog-tool-separator');
                if(isHidden){
                    obj.hide();
                    separator.length ? separator.eq(0).hide() : null;
                }else{
                    obj.show();
                    separator.length ? separator.eq(0).show() : null;
                }
            });
        }catch(e){
            isdebug ? alert("setEasyuiBtn:\n"+e.message) : null;
        }
    },
    // 格式化datagrid的value，当字数太多用textarea显示
    textFormatter:function(value,rowData,rowIndex,width,maxHeight){
        var maxHeight = maxHeight ? maxHeight : 100;
        var maxlen = width/7;
        var len = value.rlength();
        var h = len/maxlen+1;
        var height = h*14;
        height = height > maxHeight ? maxHeight :height;
        if(len > maxlen){
            width = width ? width+'px' : '100%';
            var v2 = value && len > maxlen ? value.substr(0,maxlen)+'...' : (value ? value : "");
            return  value ? "<textarea style='overflow:hidden;word-wrap:break-word;border:0px;width:"+width+";height:"+height+"px;padding:0px;margin:0px;'readonly title='"+v2+"'>"+value+"</textarea>" : "";
        }
        return value;
    },  
    // 选择本上级
    checkPriorNodes:function(treeObj, node, checked){
        try{
            if(treeObj && node){
                var jtree =  $(treeObj);
                var parentNode = jtree.tree('getParent', node.target);
                if(parentNode){// root节点不执行下面的操作
                     var count = jtree.data(parentNode.id);
                     count = count ? count : 0;                 
                     if(checked){
                         jtree.tree('check', parentNode.target);
                         jtree.data(parentNode.id, ++count);  
                         //alert(parentNode.text+', checked, '+count)   
                     }else if(!checked){
                        if(--count <= 0){
                            count = 0;
                            jtree.tree('uncheck', parentNode.target);
                            //alert(parentNode.text+', unchecked ')  
                        }
                        //alert(parentNode.text+', unchecked, '+count)   
                        jtree.data(parentNode.id, count)                     
                     }
                     QUtil.checkPriorNodes(treeObj, parentNode, checked);
                }
            }
        }catch(e){
            isdebug ? alert("checkPriorNodes:\n"+e.message) : null;
        }
    },
    // 选择本下级
    checkSubNodes:function(treeObj, node, checked){
        try{
            //alert(treeObj+','+node+','+checked)
            if(treeObj && node ){
                var jtree =  $(treeObj);
                var isLeaf = jtree.tree('isLeaf',node.target);
                if(isLeaf) return;
                var childrenNodes = jtree.tree('getChildren',node.target);
                if(!childrenNodes.length) return;
                $.each(childrenNodes, function(index, childrenNode){
                    var count = jtree.data(node.id);
                    count = count ? count : 0;
                    if(checked){
                         jtree.tree('check', childrenNode.target);
                         jtree.data(node.id, ++count);   
                         //alert(node.text+",check:"+count);
                    }else if(!checked){
                        if(--count <= 0){
                            count = 0;
                        }
                        jtree.tree('uncheck', childrenNode.target);
                        jtree.data(node.id, count);  
                        //alert(node.text+",uncheck:"+count);                        
                    }
                    QUtil.checkSubNodes(treeObj, childrenNode, checked);
                });
            }
        }catch(e){
           isdebug ? alert("checkSubNodes:\n"+e.message) : null;
        }
    },
    /**
     * 全部展开/折叠(如果没有选中节点，则展开/折叠全部；如果有，则展开/折叠选中节点下面的所有节点)    
     * maxlevel当前节点能展开的最大层数，如果层级太多会影响性能，所以在此做一定的限制
     */
    expandOrCollapseAllNodes:function(treeObj, node, action, maxTreeLevel, level){
        try{
            var maxlevel = maxTreeLevel ? maxTreeLevel : 10;
            action = action ? action : 'expand'
            if(jQuery.type(treeObj) === "string"){
                treeObj = $('#'+treeObj);
            }
            if(treeObj){
                level = level ? level : 1;
                var jtree = $(treeObj);
                node = node ? node : jtree.tree('getSelected') || jtree.tree('getRoot');
                if(node && !jtree.tree('isLeaf',node.target)){
                    jtree.tree(action, node.target);
                    $(node).data('isLoaded', true); 
                    var interval = window.setInterval(function(){
                        try{
                            var childrenNodes = jtree.tree('getChildren', node.target);
                            if(childrenNodes && childrenNodes.length > 0){
                                if(level >= maxlevel){
                                    interval ? window.clearInterval(interval) : null;
                                }else{
                                    ++level;
                                    $.each(childrenNodes, function(i, children){
                                        if(children && !jtree.tree('isLeaf',children.target)){
                                            QUtil.expandOrCollapseAllNodes(treeObj, children, action, maxTreeLevel, level);
                                        }
                                        $(children).data('isLoaded', true); 
                                    }); 
                                }
                                interval ? window.clearInterval(interval) : null;
                            }else{
                                interval ? window.clearInterval(interval) : null;
                            }
                        }catch(e){ }
                    },0);
                }
            }           
        }catch(e){
            isdebug ? alert("expandAllNodes:\n"+e.message) : null;
        }
    },
    // string转化成json , IE6不支持JSON.parse(str); 
    string2json: function(data){
        try {
            if (jQuery.type(data) === "string") {
                return (new Function("return " + data.trim()))();
            }else if (jQuery.type(data) === "object") {
            	return data;
            } else {
                return null;
            }
        } catch (e) {
            isdebug ? alert("string2json:\n"+e.message) : null;
        }
    }, 
    stringToJson: function(obj){
        return eval('(' + obj + ')');
    }, 
    // 遍历json的内容
    travelJson: function(json){
        try {
            var strArr = [];
            if (json && typeof(json) == "object") {
                for (var p in json) {
                    strArr.push(p);
                    strArr.push(" = ");
                    strArr.push(json[p]);
                    strArr.push("\n ");
                }
            }
            return strArr.join("");
        } catch (e) {
            isdebug ? alert("travelJson:\n"+e.message) : null;
        }
    },    
    /*
     * 缓存传入的ids，names到表格对象datagridObj中，用来对记录进行初始化check/uncheck
     */
    initDatagridCheckCache:function(datagridObj,idsInput,namesInput){
        try{
            if(datagridObj && idsInput && namesInput){
                var initDms = $(idsInput).val()   ? $(idsInput).val().split(',')   : [];
                var initMcs = $(namesInput).val() ? $(namesInput).val().split(',') : [];
                var initPersonnelCode = $(idsInput).attr('personnelCode');
                var initCompany       = $(idsInput).attr('company');
                var initCompanyCode   = $(idsInput).attr('companyCode');
                if(!initPersonnelCode){
                    initPersonnelCode = [];
                    initCompany =  [];
                    initCompanyCode = [];
                    $.each(initDms,function(i,dm){
                        initPersonnelCode.push(' ');
                        initCompany.push(' ');
                        initCompanyCode.push(' ');
                    });     
                }else{
                    initPersonnelCode = initPersonnelCode.split(',');
                    initCompany       = initCompany.split(',');
                    initCompanyCode   = initCompanyCode.split(',');
                }
                if(initDms && initDms.length > 0){
                    $(datagridObj).data('dms',initDms)
                                          .data('mcs',initMcs)
                                          .data('personnelCode',initPersonnelCode)
                                          .data('company',initCompany)
                                          .data('companyCode',initCompanyCode)
                                          .data('isCRUD',true);
                } 
            }
        }catch(e){
            isdebug ? alert('initDatagridCheckCache:\n'+e.message) : null;
        }
    },
    // 设置查询分页按钮的样式
    setQuerypagingCss:function(winOption, rtArr, rtIndex){
        try{
            var pagingWidth = $(winOption.queryPagingWrap).width() + 4;
            var queryInputWrap = $(winOption.queryPagingWrap).parent();
            if(winOption && rtArr && rtArr.length > 1){
                var a1 = 100;
                if(rtIndex <= 0){
                    a1 = 30;
                }
                var a2 = 100;
                if(rtIndex >= rtArr.length-1){
                    a2 = 30;
                }
                //alert('rIndex='+rtIndex+",a1="+a1+",a2="+a2);
                if($(winOption.queryPagingWrap).css('display') == 'none'){
                    //alert('pagingWidth='+pagingWidth);
                    $(queryInputWrap).width($(queryInputWrap).width() + pagingWidth);
                    $(winOption.queryPagingWrap).show();
                }
                // 为了适应不同版本的浏览器，高版本的IE,如果11，filter不起作用
                var css1 = {
                  'opacity':a1/100,
                  'filter':"alpha(opacity="+a1+"))"                 
                };
                var css2 = {
                  'opacity':a2/100,
                  'filter':"alpha(opacity="+a2+"))"
                  
                };
                $(winOption.queryInputFirst).css(css1);
                $(winOption.queryInputPrevious).css(css1);
                $(winOption.queryInputNext).css(css2);
                $(winOption.queryInputLast).css(css2);
            }else{               
                //alert('setQuerypagingCss queryPagingWrap:'+$(winOption.queryPagingWrap).css('display'));
                if($(winOption.queryPagingWrap).css('display') != 'none'){
                    $(queryInputWrap).width($(queryInputWrap).width() - pagingWidth);
                    $(winOption.queryPagingWrap).hide();
                }
            }
        }catch(e){
            isdebug ? alert('setQuerypagingCss:\n'+e.message) : null;
        }
    },
    // 创建输入框和查询按钮
    createQueryInputAndBtn:function(tableQueryDivId, queryInputId, queryBtnId, wrapStyle, queryPromptText, inputWidth, isClose){
        //alert(inputWidth);
        // 输入框的宽度
        var inputWidth = inputWidth > 0 ? inputWidth : 130;
        // 查询按钮和输入框
        var queryDivWrap = document.createElement('div');
        // 查询按钮和输入框
        var queryWrap  = document.createElement('div');
        var queryInput = document.createElement('input');
        var querybtn   = document.createElement('button');
        var resizequerybtn = document.createElement('button');
        queryPromptText = queryPromptText ? queryPromptText : '请输入关键字';
        $(resizequerybtn).html('刷新');
        $(querybtn).html('查询');
        $(resizequerybtn).linkbutton({
            'iconCls':'icon-reload'
        });
        $(querybtn).linkbutton({
            'iconCls':'icon-search'
        });
        $(queryInput).data('queryPromptText', queryPromptText).attr({
            'id':queryInputId,
            'type':'text',
            'placeholder':queryPromptText,
            'maxlength':'30',
            'style':'float:left;width:'+inputWidth+'px;height:22px;padding:1px 2px 0px 2px;margin-right:2px;margin-top:2px;border-width:0px;'
        });   
        var queryInputWrap = document.createElement('span');         
        var queryInputClear = document.createElement('img');
        $(queryInputClear).tooltip({
            'content':'清空'
        }).attr({
            'class':'pagination-load',
            'style':'vertical-align:baseline;margin-left:5px;height:22px;background-position-y:6px;width:16px;cursor:pointer;opacity:1;filter:alpha(opacity=100);'});

        var queryInputFirst = document.createElement('img');
        $(queryInputFirst).tooltip({
            'content':'第一个'
        }).attr({
            'class':'pagination-first',
            'style':'vertical-align:baseline;height:22px;background-position-y:5px;width:16px;cursor:pointer;opacity:0.3;filter:alpha(opacity=30);'});
        
        var queryInputPrevious = document.createElement('img');
        $(queryInputPrevious).tooltip({
            'content':'上一个'
        }).attr({
            'class':'pagination-prev',
            'style':'vertical-align:baseline;height:22px;background-position-y:5px;width:16px;cursor:pointer;opacity:0.3;filter:alpha(opacity=30);'});
            
        var queryInputNext = document.createElement('img');
        $(queryInputNext).tooltip({
            'content':'下一个'
        }).attr({
            'class':'pagination-next',
            'style':'vertical-align:baseline;height:22px;background-position-y:5px;width:16px;cursor:pointer;opacity:0.3;filter:alpha(opacity=30);'});
            
        var queryInputLast = document.createElement('img');
        $(queryInputLast).tooltip({
            'content':'最后一个'
        }).attr({
            'class':'pagination-last',
            'style':'vertical-align:baseline;height:22px;vertical-align:top;background-position-y:5px;width:16px;cursor:pointer;opacity:0.3;filter:alpha(opacity=30);'});

        // 数据分页
        var queryPagingWrap = document.createElement('span');   
        $(queryPagingWrap).append(queryInputFirst)
            .append(queryInputPrevious)
            .append(queryInputNext)
            .append(queryInputLast).hide();

        var queryInputSerach = document.createElement('img');
        $(queryInputSerach).tooltip({
            'content':'(回车)缓存查询'
        }).attr({
            'class':'searchbox-button',
            'style':'vertical-align:baseline;height:20px;width:25px;background-position-y:3px;cursor:pointer;opacity:1;filter:alpha(opacity=100);'});
            
        var queryInputSerachDb = document.createElement('img');
        $(queryInputSerachDb).tooltip({
            'content':'数据库查询'
        }).attr({
            'class':'searchbox-db-button',
            'style':'text-align:center;vertical-align:baseline;height:20px;width:25px;background-position-x:5px;background-position-y:7px;background-position-y:2px;cursor:pointer;opacity:1;filter:alpha(opacity=100);'}).hide();

        var queryInputSerachType = document.createElement('label');
        /**/
        $(queryInputSerachType).attr({
            'class':'combo-arrow',
            'style':'vertical-align:baseline;margin-left:2px;width:25px;background-color:transparent;background-position-x:2px;background-position-y:4px;'})
            .bind('mouseover',function(){
                $(this).addClass('combo-arrow-hover');
            }).bind('mouseout',function(){
                $(this).removeClass('combo-arrow-hover').addClass('combo-arrow');
            }).bind('click',function(){
                $(queryInputSerach).toggle();
                $(queryInputSerachDb).toggle();
                $(queryInput).select().focus();
            }).tooltip({
                'content':'查询方式切换:</br>1.缓存查询：速度较快，从已加载的数据中查询匹配节点;</br>2.数据库查询：查询准确，数据量较大，速度相对较慢；'
            });
            
        var queryInputSerachWrap = document.createElement('span');   
        $(queryInputSerachWrap).append(queryInputSerach).append(queryInputSerachDb);
           
        $(queryInputWrap).append(queryInput)
            .append(queryPagingWrap)
            .append(queryInputClear)
            .append(queryInputSerachWrap)
            .append(queryInputSerachType);
        if(isClose){
            var queryBarClose = document.createElement('img');
            $(queryBarClose).tooltip({
                'content':'关闭查询'
            }).bind('click', function(){
                $(queryDivWrap).hide();
            }).attr({
                'class':'bar-close',
                'style':'cursor:pointer;margin-left:2px;height:20px;background-position-y:70%;background-color:transparent;'});
            $(queryInputWrap).append(queryBarClose);
        } 
        $(queryInputWrap).css({
            'float':'left',
            'background-color':'rgb(239, 239, 239)',
            'border':'1px solid #cccccc',
            'padding':'0px 1px 0px 1px'
        });
        
        $(queryWrap).attr({
                'id':queryBtnId,
                'style': wrapStyle ? wrapStyle :"display:inline-block;padding:6px 5px 8px 3px; float:left;height:20px;"
            }).append(queryInputWrap);
            
        $(queryDivWrap).attr({'id':tableQueryDivId}).append(queryWrap);

        $(queryInputClear).bind('click',function(){
           if($(queryPagingWrap).css('display') != 'none'){
                $(queryInputWrap).width($(queryInputWrap).width() - $(queryPagingWrap).width() - 4);
                $(queryPagingWrap).hide();
           }         
           var cssopacity = {
               'opacity':0.5,
               'filter':'alpha(opacity=50)'
           }
           $(queryInputFirst).css(cssopacity);
           $(queryInputPrevious).css(cssopacity);
           $(queryInputNext).css(cssopacity);
           $(queryInputLast).css(cssopacity);
           $(queryInput).focus();
        });

        return {
            'queryWrap'  :queryWrap,
            'queryInput' :queryInput,
            'resizequerybtn':resizequerybtn,
            'queryPagingWrap':queryPagingWrap,
            'queryInputFirst'   :queryInputFirst,
            'queryInputPrevious':queryInputPrevious,
            'queryInputNext'    :queryInputNext,
            'queryInputLast'    :queryInputLast,
            'queryInputClear'   :queryInputClear,
            'queryInputSerachWrap':queryInputSerachWrap,
            'queryInputSerach':queryInputSerach,
            'querybtn'        :queryInputSerach,//querybtn,
            'querybtnDb'      :queryInputSerachDb,
            'queryInputSerachType':queryInputSerachType,
            'queryDivWrap'    :queryDivWrap
        };
    },
    // 克隆一个数组Array
    cloneArray:function(source){
        try{
            if(source && jQuery.type(source) === 'array' && source.length > 0){
                return source.slice(0);
            }else{
                return [];
            }
        }catch(e){
            isdebug ? alert('cloneArray:\n'+e.message) : null;
        }
    },
    // 根据树形的id，查询人员，初始化待选择人员tab页
    loadWaitingTabByTreeId:function(json){
        //alert('loadWaitingTabByTreeId');
        
        $(json.datagridTable).datagrid({
            queryParams:json.data
        });
        
        /*
        if(json.url){
            $.ajax({
                dataType:'json',
                url : json.url,
                data: json.data,
                type: "POST",
                beforeSend: function(){ },
                success: function(data){
                    if(data && data.total == 0){
                        //$.messager.alert('提示信息','没有符合条件的数据！','error');
                    }else{
                        // 把参数加入到datagrid的queryParams中，以便分页和排序使用
                        var queryparams = $(json.datagridTable).datagrid('options').queryParams; 
                        jQuery.extend(queryparams,json);
                    }
                    // 加载返回的数据，生成table, 即使没有查询出数据，也要执行一次，把上次查询的数据情况。					
                    $(json.datagridTable).datagrid('loadData',data);	
                },
                error:function(data){
                    top.$.messager.alert('提示信息','请求失败！请检查网络连接或者与管理员联系','error');
                }
            });  
        }*/
    },
    // 根据缓存中的已选择的记录，初始化当前页面(待选择tab)的checkbox
    initPageCheckboxByCach:function(tableInfoWrap){           
        var allrows = $(tableInfoWrap).datagrid('getRows');
        var dms = $(tableInfoWrap).data('dms');

        var defaultUserId = $(tableInfoWrap).data('defaultUserId');
        //alert('defaultUserId='+defaultUserId + '\ndms='+dms)
        //alert('initPageCheckboxByCach:\ndms='+dms)
        //alert(allrows +' '+ allrows.length)
        if((!dms || dms.length == 0) && defaultUserId){
            dms = [defaultUserId];
        }
        
        if(allrows.length>0 && dms){
            //alert(dms);               
            $.each(allrows,function(i,row){
                var flag = true;
                $.each(dms,function(j,dm){
                    if(row.sysAccounts === dm){
                        $(tableInfoWrap).datagrid('selectRow',i);
                        flag = false;
                        return false;
                    }
                });
                if(flag){
                    $(tableInfoWrap).datagrid('unselectRow',i);
                }
            });
        }
    },
    // 在'已选择'tab页中，加载缓存中的已经选择的审计人员
    loadSelectedRows:function(tableInfoWrap,selected_tableinfoWrap){
        // 是否有数据变更，true - 有数据的增删
        var flag = $(tableInfoWrap).data('isCRUD');
        //alert('isCRUD='+flag+' '+selected_tableinfoWrap);
        if(flag && selected_tableinfoWrap){
            var dms = $(tableInfoWrap).data('dms');
            var mcs = $(tableInfoWrap).data('mcs'); 
            //alert('dms:'+dms+"\nmcs:"+mcs);
            var personnelCode = $(tableInfoWrap).data('personnelCode'); 
            var company = $(tableInfoWrap).data('company'); 
            var companyCode = $(tableInfoWrap).data('companyCode');
            var dataJson = {
                total:dms.length,
                intPage:1,
                intPageSize:20,
                rows:[]
            }; 
            //alert(dms+' '+mcs)
            $.each(dms,function(i,dm){
                // 对于值为空的记录跳过
                if(dm){
                    dataJson.rows.push({
                        'sysAccounts':dm,
                        'name':mcs[i],
                        'personnelCode':personnelCode[i],
                        'company':company[i],
                        'companyCode':companyCode[i]
                    });
                }
            });
            //alert(QUtil.object2string(dataJson))
            $(selected_tableinfoWrap).datagrid('loadData', dataJson);
            $(tableInfoWrap).data('isCRUD',false);
        }
    },
    // 把表格中selected选中的数据添加到cache数组,作为已选择datagrid的数据
    addSelections:function(tableInfoWrap,rows,singleSelect){
        // 人员系统账号和名称
        var dms   = $(tableInfoWrap).data('dms');
        var mcs   = $(tableInfoWrap).data('mcs');
        // 人员编号，所在部门，部门编号
        var personnelCode = $(tableInfoWrap).data('personnelCode'); 
        var company = $(tableInfoWrap).data('company'); 
        var companyCode = $(tableInfoWrap).data('companyCode'); 
        //alert('addSelections:\nmcs='+mcs);         
        if(tableInfoWrap && rows && rows.length > 0){ 
            dms   = dms ? dms : [];
            mcs   = mcs ? mcs : [];
            personnelCode = personnelCode ? personnelCode : [];
            company = company ? company : [];
            companyCode = companyCode ? companyCode : [];
            // 克隆一个数组
            var cloneDms = QUtil.cloneArray(dms);
            // 如果为单选，要清空cache
            if(singleSelect){
                dms   = [];
                mcs   = [];
                personnelCode = [];
                company = [];
                companyCode = [];
            }
            //alert(jQuery.type(dms)+' '+jQuery.type(cloneDms)); 
            $.each(rows, function(i,row){
                // 剔除已经添加的选项
                var flag = true;
                for(var j=0; j<cloneDms.length; j++){
                    var dm = cloneDms[j];
                    if(dm === row['sysAccounts']){
                        flag = false;
                        break;
                    }
                }
                if(flag){
                    dms.push(row['sysAccounts']);
                    mcs.push(row['name']);
                    personnelCode.push(row['personnelCode']);
                    company.push(row['company']);
                    companyCode.push(row['companyCode']);
                }
            });
            //alert(jQuery.type(company)); 
            //alert(dms+' '+personnelCode.length+' '+company.length);
            $(tableInfoWrap).data('dms',dms)
                            .data('mcs',mcs)
                            .data('personnelCode',personnelCode)
                            .data('company',company)
                            .data('companyCode',companyCode)
                            .data('isCRUD',true); 
        } 
    },
    // 把表格中unselected的row移除数组,适用于单行，rowData是以一个包括行cell的json，不是数组
    removeUnSelected:function(tableInfoWrap,rowData){ 
        var dms   = $(tableInfoWrap).data('dms');
        var mcs   = $(tableInfoWrap).data('mcs');  
        var personnelCode = $(tableInfoWrap).data('personnelCode'); 
        var company       = $(tableInfoWrap).data('company'); 
        var companyCode   = $(tableInfoWrap).data('companyCode');
        
        if(tableInfoWrap && rowData && jQuery.type(dms) === 'array' && dms.length>0){
            dms   = dms ? dms : [];
            mcs   = mcs ? mcs : [];
            personnelCode = personnelCode ? personnelCode : [];
            company       = company       ? company       : [];
            companyCode   = companyCode   ? companyCode   : [];  
            
            var delIndexs = [];
            $.each(dms, function(i,dm){
                if(dm === rowData['sysAccounts']){
                    delIndexs.push(i);
                }
            });
            if(delIndexs.length>0){
                $.each(delIndexs,function(j,index){
                    dms.splice(index,1);
                    mcs.splice(index,1);
                    personnelCode.splice(index,1);
                    company.splice(index,1);
                    companyCode.splice(index,1);
                });
                $(tableInfoWrap).data('dms',dms)
                    .data('mcs',mcs)
                    .data('personnelCode',personnelCode)
                    .data('company',company)
                    .data('companyCode',companyCode)
                    .data('isCRUD',true); 
            }
        }
    },
    // 根据给定的rows，清除缓存中的待选数据
    clearAll:function(tableInfoWrap,rows){ 
        //alert('待删除的 rows = '+rows.length);
        var newDms =[],newMcs=[],newNames=[],newPersonnelCode=[],newCompany = [],newCompanyCode=[];
        if(tableInfoWrap && rows && jQuery.type(rows) === 'array' && rows.length>0){
            var dms   = $(tableInfoWrap).data('dms');
            var mcs   = $(tableInfoWrap).data('mcs');
            var personnelCode = $(tableInfoWrap).data('personnelCode'); 
            var company       = $(tableInfoWrap).data('company'); 
            var companyCode   = $(tableInfoWrap).data('companyCode');
            dms   = dms ? dms : [];
            mcs   = mcs ? mcs : [];
            personnelCode = personnelCode ? personnelCode : [];
            company       = company ? company : [];
            companyCode   = companyCode ? companyCode : [];  
            var flag = false;
            $.each(rows,function(i,row){
                for(var j=0; j<dms.length; j++ ){
                    var dm = dms[j];
                    if(dm === row['sysAccounts']){
                        flag = true;
                        delete dms[j]; // 删除的数组元素为undefind，数组长度不变
                        break;
                    }
                } 
            });
            //alert('flag='+flag+'\nmcs.length='+mcs.length+'\nmcs='+mcs);
            // 删除数组的元素
            if(flag){
                $.each(dms,function(j,dm){
                    if(dm){
                        newDms.push(dms[j]);
                        newMcs.push(mcs[j]);
                        newPersonnelCode.push(personnelCode[j]);
                        newCompany.push(company[j]);
                        newCompanyCode.push(companyCode[j]);
                    }
                }); 
                $(tableInfoWrap).data('dms',newDms)
                    .data('mcs',newMcs)
                    .data('personnelCode',newPersonnelCode)
                    .data('company',newCompany)
                    .data('companyCode',newCompanyCode)
                    .data('isCRUD',true); 
            }
        }
    },
    // 得到用来最终存储节点id和name名称的input对象
    getRealInputAndHiddenInput:function(targetElement){
        try{
            if(targetElement){
                var json = {
                    idsInput  :'',
                    namesInput:'',
                    assId     :''
                };
                var preObj = targetElement//.previousSibling;           
                while(preObj && preObj.nodeName != 'BODY'){
                    if(preObj.nodeType == 1 && preObj.nodeName === 'INPUT'){
                        //alert('cacheId='+$(preObj).attr('cacheId'))
                        if($(preObj).attr('cacheId') == 'jqtreeNode_ids' || ($(preObj).attr('type')==='hidden' && $(preObj).attr('cacheId') != 'jqtreeNode_names')){
                            //alert('is jqtreeNode_ids')
                            json.idsInput = preObj;
                            json.assId = $(json.idsInput).attr('assId');
                        }else if($(preObj).attr('cacheId') == 'jqtreeNode_names' || $(preObj).attr('type')==='text'){
                            //alert('is jqtreeNode_names')
                            json.namesInput = preObj;
                            break;
                        }
                    }
                    preObj = preObj.previousSibling;
                }
                // 如果没有存储id和name的input，则创建
                if(!json.idsInput){
                    var assId = 'assId_'+QUtil.ran(5);
                    var idsInput = document.createElement('input');
                    $(idsInput).attr('id','custom_idsInput').attr('assId',assId);
                    $(targetElement).insertBefore(idsInput);
                    json.assId = assId;
                    json.idsInput = idsInput;
                }
                if(!json.namesInput){
                    var namesInput = document.createElement('input');
                    $(namesInput).attr('id','custom_namesInput');
                    $(targetElement).insertBefore(namesInput);
                    json.namesInput = namesInput;
                }
                return json;
            }
        }catch(e){
            isdebug ? alert('getRealInputAndHiddenInput \n'+e.message) : null;
        }
    },
    // 响应左侧树形节点单击事件
    treeNodeClick:function(treeObject, node, type, winJson, winOption, treeDom){
        // 只能选择末级节点！
        if(!winOption.checkbox && winOption.onlyLeafClick){
            var snode = $(treeObject).tree('getSelected');
            if(snode && snode.target && !$(treeObject).tree('isLeaf',snode.target)){
                top.$.messager.alert('提示信息','只能选择末级节点！','error');
                return false;
            }
        }
        // 响应自定义树形节点单击事件
        var treeClick = winOption.onTreeClick;
        if(treeClick){
            var flag = treeClick(node, treeDom);
            if(!flag) return false;
        } 
        //$(treeObject).tree('toggle', node.target);
        // 当左侧为树，右侧为根据树的id选人时
        if(type && type != 'tree'){
            var url = '';
            if(type === 'economyDuty'){// 加载经济责人
                 url = winJson.win.option.getEconomyDuty;
            }else if(type === 'treeAndEmployee'){// 加载被审计人员
                 url = winJson.win.option.getEmployee;
            }else if(type === 'treeAndUnEmployee'){//加载非经济责任人的系统用户
                 url = winJson.win.option.getUnEmployee;
            }else if(type === 'treeAndUser'){//加载系统用户
                 url = winJson.win.option.getUser;
            }
            //alert(winJson.win.option.style1)
            var dataJson = jQuery.extend($(winOption.tableInfo).data('queryParamsJson'),{'p_deptid':node.id})
            // 更新表格查询条件
            $(winOption.tableInfo).data('queryParamsJson',dataJson);
            dataJson.page = 1;
            //alert('dataJson queryKey ='+dataJson.queryKey)
            QUtil.loadWaitingTabByTreeId({
                url :url,
                data:dataJson,
                datagridTable:winOption.tableInfo
            });
            winOption.tableUrl  = url;
            winOption.tableType = type;
            // 根据树形节点查询人员时，清空表格以前的查询缓存
            if(winOption.tableInfo){
                $(winOption.tableInfo).removeData('oldWsTableData');
            }
        }
    },
    // 根据dpetId一直向上 找到本上级直到根节点
    getPriorNodeIds:function(nodeid,url){
        try{
            var nodeIdArr = [];
            if(nodeid && url){
                dataJson = {'nodeid':QUtil.trimAll(nodeid)};
                $.ajax({
                    url : url,
                    async:false,
                    data: dataJson,
                    type: 'post',
                    dataType:'json',
                    success: function(data){
                        //alert(data.nodeIds);
                        if(data.type == 'success' && data.nodeIds){                           
                            nodeIdArr = data.nodeIds;   
                        }
                        //alert('getPriorNodeIds from Db\nnodeIdArr.length='+nodeIdArr.length+'\nnodeIdArr='+nodeIdArr);
                    },
                    error:function(data){
                        findRecs = false;
                        top.$.messager.alert('提示信息','请求失败！请检查网络连接或者与管理员联系！','error');
                    }
                });  
            }
            return nodeIdArr;
        }catch(e){
            isdebug ? alert('getPriorNodeIds:\n'+e.message) : null;
        }
    },
    /*
     注意：此方法适用于定位未加载或者已加载的节点。
     根据指定id，展开的node所有上级节点，关闭其它打开节点，并选中指定节点
     参数：
     targetNodeId:要选定的节点id
     url:根据targetNodeId查找它的本级和本上级node的id，返回一个id数组
     jqtreeObject:jquery easy tree的dom对象， eg: $(jqtreeObject).tree('find',nodeid);
     queryKey:加重的关键字
    */
    expandPriorNodeByIds:function(targetNodeId, url, jqtreeObject, queryKey, showMsg){
        try{
            if(showMsg == 'undefined'){
                showMsg = true;
            }
            // targetNodeId目标node的id，查询树形中有没有和targetNodeId匹配的node
            if(targetNodeId && url){
                var intervtime = 100;
                /*
                 idArr数组存放节点的本级和本上级的id
                 以目标targetNodeId为key，以它的本级本上级的nodeids为value进行缓存
                */
                var idArr = $(jqtreeObject).data(targetNodeId);// 利用缓存机制，url只执行一次
                var idArrClone = [];
                //alert('查询缓存的本上级ids：\nkey='+targetNodeId+'\nidArr='+idArr);
                if(!idArr || idArr.length == 0){
                    idArr = QUtil.getPriorNodeIds(targetNodeId, url);
                    if(idArr && idArr.length > 0){
                         //alert('from db 后缓存本上级ids：\nkey='+targetNodeId+'\nidArr='+idArr);
                         idArrClone = idArr.slice(0);
                         $(jqtreeObject).data(targetNodeId, idArrClone);
                    }else{
                        idArr = [];
                    }
                }
                // 复制数组，原数组的修改不会影响到返回值
                idArrClone = idArr.slice(0);
                
                //alert('idArr='+idArr+','+queryKey);
                // 由于节点展开需要时间，利用interval每隔固定时间检查节点是否已经加载完毕
                if(idArr && idArr.length>0){ 
                    var nodeid = idArr.pop();
                    // true: 当前节点正在展开中, false:没有展开或者展开完毕
                    var isExpanding = false;                  
                    // 使用setInterval加载、展开、定位树形节点
                    var nodeInterval = window.setInterval(function(){ 
                        // 关闭
                        if(nodeInterval && !nodeid){
                            clearInterval(nodeInterval);
                        }                    
                        // 当前定位节点（selectedSpecifiedNode此方法中还会把没有打开的上级节点打开）
                        var node = $(jqtreeObject).tree('find', nodeid);   
                        //alert(nodeid +"\n"+ targetNodeId)
                        if(node && nodeid == targetNodeId){
                            QUtil.selectedSpecifiedNode(jqtreeObject, node, queryKey); 
                            nodeInterval ? clearInterval(nodeInterval) : null;
                        }else{// 展开节点           
                            // 加载完毕后，展开节点，如果已经展开则跳过
                            if(!isExpanding && node && node.state == 'closed'){
                                isExpanding = true;
                                $(jqtreeObject).tree('expand', node.target);
                            }                           
                            if(node && node.state != 'closed'){
                                isExpanding = false;
                                // 判断节点是否为选定节点id
                                if(nodeid == targetNodeId){
                                    QUtil.selectedSpecifiedNode(jqtreeObject, node, queryKey);
                                    clearInterval(nodeInterval);
                                }else{                                 
                                    /*数组（可以看做一个栈结构，pop()出栈-先进后出，push/shift队列结构用到方法）循环完毕，
                                      结束interval
                                    */
                                    nodeid = idArr.pop();
                                }        
                           }
                        }
                    }, intervtime);
                }else{
                    if((!idArr || idArr.length == 0) && showMsg){
                        top.$.messager.alert('提示信息','没有符合要求的节点。','error');
                    }
                    return [];
                }
                return idArrClone;
            }
        }catch(e){
            isdebug ? alert('QUtil.expandPriorNodeByIds \n'+e.message) : null;
        }
    },
    // 响应左侧树形节点加载成功事件
    treeNodeLoadSuccess:function(node,data,cache,treeOption,winOption,treeParam,idsInput){
        //alert(data+'\n'+data.length);
        //alert(treeOption.noMsg +","+winOption.noMsg)
        var jqtree = $(winOption.jqtree);
        // node：当前单击的节点对象； data：node下加载的节点数组                   
        if(data.length == 0){
            cache ? null : $(winOption.clearbtn).trigger('click');
            treeOption.noMsg ? null : top.$.messager.alert('提示信息','没有查询到数据！','error');
        }else if(data && data.length == 1){// 如果第一次初始化时只有一个根节点，根据配置参数决定是否展开
            if(winOption.expandFirstRoot){
                var root = jqtree.tree('getRoot');
                if(root && root.state == 'closed'){
                    jqtree.tree('expand',root.target);
                }
            }
            // 根据初始化id打开本级和本上级节点
            var ff = $(jqtree).data('expandDefaultNode');
            if(!ff){
                var url = winOption.getPriorUrl;
                var defaultDeptId = winOption.defaultDeptId;
                //alert(url+'\n'+defaultDeptId);
                QUtil.expandPriorNodeByIds(defaultDeptId, url, winOption.jqtree);
                $(jqtree).data('expandDefaultNode','1');
            }
        }
        
        // 页面隐藏域保存的节点的id
        var ids =  $(idsInput).val() ? $(idsInput).val().split(',') : [] ;
        if(ids){
            // 指定节点id查询被审计单位时，当前节点的儿子节点如果在指定节点范围，则为选中状态
            if(treeParam){
                var audIds = treeParam.auditedOrgIds ? treeParam.auditedOrgIds.split(',') : [];
                //alert(ids.concat(audIds))
                ids = ids.concat(audIds);
            }
            
            // 编辑时，把添加时已经选中的节点默认选中   
            var roots = $(winOption.jqtree).tree('getRoots');
            var children = [];
            if(roots && roots.length){
                $.each(roots, function(a, root){
                    var tmp_children = [];
                    try{
                        tmp_children = $(winOption.jqtree).tree('getChildren', root.target);
                    }catch(e){}
                    if(tmp_children && tmp_children.length){
                        children = children.concat(tmp_children);
                    }
                    children.push(root);
                });
            }
            var action = treeOption.checkbox ? 'check' : 'select';
            if(action === 'check'){
                $.each(children,function(i, node){
                    $(winOption.jqtree).tree("un"+action, node.target);
                }); 
            }
            
            if(ids.length){
                $.each(children,function(i, node){             
                    $.each(ids,function(j,nodeId){
                        if(node.id == nodeId){
                            $(winOption.jqtree).tree(action, node.target);
                        }
                    });             		
                }); 
            } 
        }
        // true ：只有第一次加载时重新初始化
        // false：每次打开窗口都初始化，tree要重新查询，上次选择的节点的状态没有保存
        $(winOption.jqtree).data('treeInit', cache);
    },
    /*
        根据查询结果生成表格, 
        param:
        baseObj:表格依附的父对象，表格要放到父对象下
        dataArr:传入一个数组，每个数组元素为一个json（treeNode对象）
        queryKey:查询关键字
    */
    generateResultTable:function(baseObj, dataArr, queryKey){
        //$(baseObj).first().remove();
        $(rtTable).attr({
            'style':'float:left;width:'+$(baseObj).width()*0.97+';overflow:hidden;'
        });
        $(rtBody).attr({
            'style':'float:left;padding:5px;margin:0px;overflow:auto;'
        });
        if(baseObj && dataArr && jQuery.type(dataArr) === 'array'){     
            var rowcount  = len = dataArr.length;
            if(rowcount > 0){
                $(rtFoot).attr({ 
                    'style':'float:left;padding:5px;margin:0px;overflow:hidden;height:30px;'
                });
                // 页数设置
                var perpagecount = 10;
                var tmpc = rowcount/perpagecount;
                var curpage = 1;
                var pagecount = tmpc == 0 ? tmpc : Math.floor(tmpc)+1;
                var rtTable = document.createElement('div');
                var rtBody  = document.createElement('div');
                var rtFoot  = document.createElement('div');
                var reg = new RegExp(queryKey,"gi");
                var queryKeyFormat = "<label style='background-color:yellow;'>"+queryKey+"</label>"
                $.each(dataArr,function(index, treeNode){
                    var row = document.createElement('div');
                    $(row).attr({
                        'style':"float:left;width:100%;border-bottom:1px dashed #e6e6e6;padding:5px;margin:0px;"
                    }).append("<label style='width:30px;float:left;'>"+(index+1)+".</label>")
                      .append("<a href='javascript:void(0);' style='float:left;padding-left:5px;' >"+treeNode.text.replace(reg,queryKeyFormat)+"</a>");
                    $(rtBody).append(row);
                });
            }else{
                var row = document.createElement('div');
                $(row).attr({
                    'style':"float:left;width:100%;border-bottom:1px dashed #e6e6e6;padding:5px;margin:0px;"
                }).append("<label style='width:30px;text-align:center;'>没有查询到数据！</label>");
                $(rtBody).append(row);
            }
        }else{
            throw new Error("generateResultTable-构造查询结果表格出错！");
        }
        $(rtTable).append(rtBody).append(rtFoot);
        $(baseObj).append(rtTable);
    },
    getWin:function(json){
        try{
            //alert(json.container);
            var assId    = json.assId;
            var idsInput = json.idsInput;
            var namesInput = json.namesInput;
            var type     = json.type;
            // 先从缓存查找，没有的话新建一个窗口，并缓存
            //alert("jqWinArr.length="+jqWinArr.length)
            if(jqWinArr && jQuery.type(jqWinArr) === 'array'){
                var winJson = null;
                for(var i=0; i<jqWinArr.length; i++){
                    winJson = jqWinArr[i];
                    if(assId && winJson.id === assId){
                        break;
                    }else if(!winJson.use){
                        $(idsInput).attr('assId',winJson.id);
                        winJson.use = true;
                        break;
                    }else{
                        winJson = null;
                    }                          
                }
                
                if(winJson){
                    //alert(idsInput.value + namesInput.value);
                    // 人员待选择tabs对象
                    var tableInfoWrap      = winJson.win.param.tableInfo;
                    var showSelectDataWrap = winJson.win.param.showSelectDataWrap;
                    var initDms = $(idsInput).val()   ?  $(idsInput).val().split(',')   : [];
                    var initMcs = $(namesInput).val() ?  $(namesInput).val().split(',') : [];
                    
                    var initPersonnelCode = $(idsInput).attr('personnelCode');
                    var initCompany       = $(idsInput).attr('company');
                    var initCompanyCode   = $(idsInput).attr('companyCode');
                    if(!initPersonnelCode){
                        initPersonnelCode = [];
                        initCompany =  [];
                        initCompanyCode = [];
                        $.each(initDms,function(i,dm){
                            initPersonnelCode.push(' ');
                            initCompany.push(' ');
                            initCompanyCode.push(' ');
                        });
                    }else{
                        initPersonnelCode = initPersonnelCode.split(',');
                        initCompany       = initCompany.split(',');
                        initCompanyCode   = initCompanyCode.split(',');
                    }
                    
                    // 页面编辑时，把页面隐藏域中的ids names初始化后放到cache中
                    if(initDms && initMcs && tableInfoWrap){
                        $(tableInfoWrap).data('dms',initDms)
                                        .data('mcs',initMcs)
                                        .data('personnelCode',initPersonnelCode)
                                        .data('company',initCompany)
                                        .data('companyCode',initCompanyCode)
                                        .data('isCRUD',true);
                        // 每次窗口打开时，总是打开tabs页的第一个tab页（每次打开时都要从cache中初始化数据，只有打开win时第一个tab页为打开才能正确初始化）
                        $(showSelectDataWrap).tabs('select',0);
                    }
                    //alert('get a winJson from cache');
                    return winJson;
                }
                //alert("prepare add a new addWinJson");
                return QUtil.addWinJson(json);
            }
        }catch(e){
            isdebug ? alert('getWin:\n'+e.message) : null;
        }
    },
    addWinJson:function(json){
        var idsInput = json.idsInput;
        var type     = json.type;
        var win = new createOrgTree(json);
        var winJson = {
            'id' :'id_'+QUtil.ran(5),
            'win':win,
            'use':true};
        $(idsInput).attr('assId',winJson.id);
        jqWinArr.push(winJson);
        //alert('create a new winJson')
        return winJson;
    },
    // 获得当前选中的tab中的tree对象
    getSelectTreeObj:function(winOption){
        var selectedTab = $(winOption.treeWrap).tabs('getSelected');
        var selectedTabIndex = $(winOption.treeWrap).tabs('getTabIndex',selectedTab);
        return selectedTabIndex == 0 ? winOption.jqtree : winOption.jqtreeQuery;
   },
    // 注册事件
    handleEvents:function(winOption,idsInput,namesInput){
        try {
			
            var winWrap = winOption.winWrap;
            var type = winOption.type;
            //alert(type + winOption.tableInfo + winOption.tableSelectedInfoWrap);
            // 待选择的表格table
            var tableInfoWrap = winOption.tableInfo;
            // 已选择的表格table
            var tableSelectedInfo = winOption.tableSelectedInfoWrap;  
            // 选择的左侧树形节点的id，name
            var treeNodeId = "";
            var treeNodeName = "";
            // 响应确定按钮
            $(winOption.addbtn).unbind('click');
            $(winOption.addbtn).bind('click',function(){
				//alert(winOption.treeWrap)
				// 选中第一个tab页
				var curContext = this;
                $(winOption.treeWrap).tabs('select', 0);
                var jqtree = QUtil.getSelectTreeObj(winOption);
                var dms = [];
                var mcs = [];
                var personnelCode = []; 
                var company = []; 
                var companyCode = [];
                // 仅有树形机构，没有根据机构选人的窗口
                if(type === 'tree'){
					curContext = jqtree;
                    var options = $(jqtree).tree('options');
                    //for(var p in options) alert(p+'='+options[p])
                    var isCheckbox = options.checkbox;
                    //alert(winOption.checkbox)
                    var onlyLeafClick = winOption.onlyLeafClick;
                    //alert(onlyLeafClick +' '+isCheckbox)
                    if(onlyLeafClick && !isCheckbox){
                        var snode = $(jqtree).tree('getSelected');
                        if(snode && snode.target && !$(jqtree).tree('isLeaf',snode.target)){
                            top.$.messager.alert('提示信息','只能选择末级节点！','error');
                            return;
                        }
                    }
                    
                    var nodes = new Array();
                    isCheckbox ? nodes = $(jqtree).tree('getChecked') : $(jqtree).tree('getSelected') ? nodes.push($(jqtree).tree('getSelected')) : null;
                    if(nodes && nodes.length == 0){
                        top.$.messager.alert('提示信息','请选择树形节点！'+(onlyLeafClick ? '只能选择末级节点！' : ''),'error');
                        return;
                    }
                    $.each(nodes, function(i,node){
                        if(onlyLeafClick && !$(jqtree).tree('isLeaf',node.target)){
                            return true; 
                        }
                        dms.push(node.id);
                        mcs.push(node.text);
                    }); 
                }else{// 既有机构又有选人的情况
					curContext = tableInfoWrap;
                    dms = $(tableInfoWrap).data('dms'); 
                    mcs = $(tableInfoWrap).data('mcs');  
                    personnelCode = $(tableInfoWrap).data('personnelCode'); 
                    company       = $(tableInfoWrap).data('company'); 
                    companyCode   = $(tableInfoWrap).data('companyCode');
                    if(!dms || dms.length == 0){
                        top.$.messager.alert('提示信息','请选择表格中的人员！','error');
                        return;
                    }
                }
				//alert(winOption.onBeforeSure)
				var isCheckOk = true;
				if(winOption.onBeforeSure){
					//winOption.onBeforeSure.call(curContext, dms,mcs);
					isCheckOk = winOption.onBeforeSure(curContext, dms, mcs);
				}
				if(isCheckOk){
					//alert(mcs+'\n'+dms+'\n'+mcs.length +' '+dms.length)
					$(idsInput).val(dms.join(','));
					$(idsInput).attr({
						'personnelCode':personnelCode,
						'company'      :company,
						'companyCode'  :companyCode
					});
					$(namesInput).val(mcs.join(','));
					$(winWrap).window('close');
					QUtil.clearQueryTreeNodeCacheAndCss(jqtree);
					// 当为左右结构时，传入人员姓名name、系统账号sysCount、员工编号personCode,company,companyCode
					winOption.onAfterSure ? winOption.onAfterSure.call(curContext, dms,mcs,personnelCode,company,companyCode) : null;
				}

            });
            
            // 响应清空按钮
            $(winOption.clearbtn).unbind('click');
            $(winOption.clearbtn).bind('click',function(){
				var curContext = this;
                if(type === 'tree'){
                    var jqtree = QUtil.getSelectTreeObj(winOption);
					curContext = jqtree;
                    var options = $(jqtree).tree('options');
                    var isCheckbox = options.checkbox;
                    if(isCheckbox){
                        var nodes = $(jqtree).tree('getChecked');
                        $.each(nodes, function(i,node){
                            $(jqtree).tree('uncheck',node.target);
                        });
                    }
                }else{
                    /*
                    $(tableInfoWrap).removeData('dms')
                                    .removeData('mcs')
                                    .removeData('personnelCode')
                                    .removeData('company')
                                    .removeData('companyCode');*/
                     // 清空选择人员表格选择或者选中checkbox
                     if(winOption.tableInfo){
                         $(winOption.tableInfo).datagrid('unselectAll');
                         $(winOption.tableInfo).datagrid('uncheckAll');
                     }
                     if(winOption.tableSelectedInfoWrap){
                         $(winOption.tableSelectedInfoWrap).datagrid('loadData', {'total':'0', 'rows':[]});
                     }
                     $(tableInfoWrap).data('isCRUD',true); 
					 curContext = tableInfoWrap;
                }
                $(idsInput).val('');
                $(idsInput).attr({
                    'personnelCode':'',
                    'company':'',
                    'companyCode':''
                });
                $(namesInput).val('');
                $(winWrap).window('close');              
                winOption.onAfterSure ? winOption.onAfterSure.call(curContext, winOption) : null;
            });

            
            // 响应关闭机构树选择按钮
            $(winOption.exitbtn).unbind('click');
            $(winOption.exitbtn).bind('click',function(){
                $(winWrap).window('close');
            });
            
            // 响应 左侧树形查询输入框关键字改变事件
            //$(winOption.queryInput).unbind('keyup');
            $(winOption.queryInput).bind('keyup',function(){
                // 清除上次查询的缓存
                QUtil.clearQueryTreeNodeCacheAndCss(winOption.jqtree);
                
            });
            
            // 响应分页查询
            function locationPreviousOrNextNode(winOption, flag, isFirst, isLast){
                try{
                    var jqTreeObject = winOption.jqtree;
                    // 从缓存查询匹配节点，如果没有, 则按搜索顺序搜索并缓存起来，供下次使用
                    var rtArr = $(jqTreeObject).data('queryRtTreeNodeArr');
                    var rtIndex = 0;
                    if(rtArr && rtArr.length > 0){
                        rtIndex = $(jqTreeObject).data('queryRtTreeNodeArrIndex');                   

                        // 适用于定位已经加载的节点
                        var queryKey = $.trim($(winOption.queryInput).val());
                       
                        if(isFirst){
                            rtIndex = 0;
                        }else if(isLast){
                            rtIndex = rtArr.length - 1 ;
                        }else{
                            rtIndex = flag ? ++rtIndex : --rtIndex;
                        }      

                        if(rtIndex<0 || rtIndex == undefined){
                            rtIndex = 0;
                        }                   
                        if(rtIndex >= rtArr.length){
                            rtIndex = rtArr.length - 1 ;
                        }
                        
                        //alert('locationPreviousOrNextNode:\nrtArr.length='+rtArr.length+'\nrtIndex='+rtIndex+'\nnode='+rtArr[rtIndex]);
                        var node = rtArr[rtIndex];
                        // 把加载好的node替换rtArr中对应的node
                        var node_tmp = $(winOption.jqtree).tree('find',node.id);
                        if(node_tmp){
                           node = node_tmp; 
                           rtArr[rtIndex] = node;
                        }
                        /*
                        rtArr里面的node可能有两种类型：
                        1.根据nodeId能从tree find的,有target属性; 
                        2.从数据库中查出的node,没有target属性,这种情况只能从Db查询后定位;
                        */
                        //alert('Paging nodes:\nrtIndex='+rtIndex+'\nnode.text='+node.text+'\nnode.target='+node.target);
                        //alert('priorIds='+$(window).data(node.id));
                        QUtil.expandPriorNodeByIds(node.id,  
                            winOption.getPriorUrl,
                            winOption.jqtree, 
                            queryKey);
                        QUtil.setQuerypagingCss(winOption, rtArr, rtIndex);
                        $(jqTreeObject).data('queryRtTreeNodeArrIndex', rtIndex);
                    }
                }catch(e){
                    isdebug ? alert('locationPreviousOrNextNode:\n'+e.message) : null;
                }
            }
            
            // 响应查询第一条记录
            $(winOption.queryInputFirst).bind('click',function(){
                locationPreviousOrNextNode(winOption, false, true, false);
            }); 
            
            // 响应查询上一条记录
            $(winOption.queryInputPrevious).bind('click',function(){
                locationPreviousOrNextNode(winOption, false, false, false);
            });
            
            // 响应查询下一条记录
            $(winOption.queryInputNext).bind('click',function(){
                locationPreviousOrNextNode(winOption, true, false, false);
            });
            
            // 响应查询最后一条记录
            $(winOption.queryInputLast).bind('click',function(){
                locationPreviousOrNextNode(winOption, false, false, true);
            });
            
            // 响应树形节点查询
            function treeNodeQuery(winOption, type){
                try{
                    var jquery_queryInput = $(winOption.queryInput);
                    var queryKey = jquery_queryInput.val();
                    var jqTreeObject = winOption.jqtree;
                    if(!queryKey){
                        top.$.messager.alert('提示信息', '请输入查询关键字', 'error', function(){
                            jquery_queryInput.select().focus();
                        });
                    }else{
                        if(type && type == 'cache'){// 从已经加载的树形节点搜索
                            // 从缓存查询匹配节点，如果没有, 则按搜索顺序搜索并缓存起来，供下次使用
                            var rtArr = $(jqTreeObject).data('queryRtTreeNodeArr');
                            // 当前节点所在数组的下标
                            var rtIndex = 0;
                            
                            if(rtArr && rtArr.length > 0){
                                rtIndex = $(jqTreeObject).data('queryRtTreeNodeArrIndex');
                                if(rtIndex<0 || rtIndex == undefined){
                                    rtIndex = 0;
                                }
                                //alert("From cache array：\n"+'rtArr.length='+rtArr.length+'\nrtIndex='+rtIndex);
                            }else{
                                rtArr = [];
                                // 根据查询关键字首先匹配已经加载的树形节点，查看是否有符合要求的
                                QUtil.findJqTreeNodeByQueryKeyFromCache(queryKey, winOption.jqtree, null, rtArr);
                                // 缓存起来
                                if(rtArr && rtArr.length > 0){
                                    $(jqTreeObject).data('queryRtTreeNodeArr', rtArr);
                                    $(jqTreeObject).data('queryRtTreeNodeArrIndex', rtIndex);
                                }
                                //alert("cache array is null, From loaded tree and cached them\n"+'rtArr.length='+rtArr.length+'\nrtIndex='+rtIndex);
                            }
                            
                            //alert('query from cache: rtArr='+rtArr)
                            
                            // 依次从缓存中取node，并设置样式
                            if(rtArr && rtArr.length > 0){// 缓存查询   
								
								$.each(rtArr, function(n, rt){
									var tnode = $(winOption.jqtree).tree('find', rt.id); 
									QUtil.selectedSpecifiedNode(winOption.jqtree, tnode, queryKey, true);
								});


							
                                // 光标定位到输入框并移动末尾
                                QUtil.focusMoveEnd(winOption.queryInput);                                               
                                if(rtIndex >= rtArr.length - 1){
                                    var tmpArr = [];
                                    // 重新查询看是否有新的数据（可能有新打开的节点有符合要求的）
                                    QUtil.findJqTreeNodeByQueryKeyFromCache(queryKey, winOption.jqtree, null, tmpArr);
                                    //alert("Cache重新查询看是否有新的数据（可能有新打开的节点有符合要求的）:\ntmpArr.len="+tmpArr.length+'\nrtArr.length='+rtArr.length);
                                    if(tmpArr.length > rtArr.length){
                                        // 新数据缓存起来
                                        $(winOption.jqtree).removeData('queryRtTreeNodeArr');
                                        $(winOption.jqtree).data('queryRtTreeNodeArr', rtArr);
                                        rtArr = tmpArr;
                                        ++rtIndex;
                                    }else{
                                        rtIndex = 0;
                                    }
                                    //alert('Cache rtIndex='+rtIndex);
                                }  
                                               
                                /*
                                    定位目标节点node，并打开节点的本上级，
                                    适用于缓存搜索定位或者数据库查询定位（第二次定位时使用缓存）
                                */
                                QUtil.expandPriorNodeByIds(rtArr[rtIndex].id,  
                                    winOption.getPriorUrl,
                                    jqTreeObject, 
                                    $.trim($(winOption.queryInput).val()));
                                // 设置节点分页
                                QUtil.setQuerypagingCss(winOption, rtArr, rtIndex);                                 
                                // 缓存当前节点所在数组的下标
                                $(jqTreeObject).data('queryRtTreeNodeArrIndex', rtIndex);
                                // 选中树形tab页，并清空搜索节点tab页
                                $(winOption.treeWrap).tabs('select', 0);
                                // 加载搜索结果树形
                                //$(winOption.jqtreeQuery).tree('loadData', rtArr);
                            }else{
                                /*
                                top.$.messager.confirm('提示','缓存中没有查询到匹配数据，是否进行数据库查询(速度慢)？',function(flag){
                                    flag ? treeNodeQuery(winOption, 'db') : null;
                                });
                                */
                                treeNodeQuery(winOption, 'db');
                            }
                        }else if(type && type == 'db'){// 从数据库中查询
                             //alert('query from db')
                             if(winOption.lazy){
                                // 数据库查询, 只有逐级加载时（数据加载部分），才进行数据库查询
                                QUtil.findJqTreeNodeByQueryKeyFromDb(winOption);
                                $(winOption.queryInput).select().focus();
                                // 光标定位到输入框并移动末尾
                                QUtil.focusMoveEnd(winOption.queryInput);
                            }
                        }
                    }
                }catch(e){
                    isdebug ? alert('treeNodeQuery:\n'+e.message) : null;
                }
            }
            
            // 响应树形缓存查询
            $(winOption.querybtn).bind('click', function(){
                treeNodeQuery(winOption, 'cache')
            });
            
            // 响应树形数据库查询
            $(winOption.querybtnDb).bind('click', function(){
                treeNodeQuery(winOption, 'db')
            });
            
            // 为左侧树形和右侧表格查询关键字输入框注册回车事件
            function enterHandler(e){
                // 获得焦点的元素对象
                var oActiveObj = document.activeElement;
                if(oActiveObj == null){
                    return;
                }
                var oActiveObjId = oActiveObj.getAttribute("id");
                // 事件对象 
                var oEvent = window.event || e;
                if(oEvent){// for IE
                    // 回车键对应的代码值13 
                    if(oEvent.keyCode == "13"){
                        // 执行此id对应的处理函数
                        //alert(oActiveObjId)
                        oActiveObjId.indexOf('queryInputId_') !=-1 ? $(winOption.querybtn).trigger('click') : null;
                        oActiveObjId.indexOf('tableQuery') !=-1 ? $(winOption.tableQuerybtn).trigger('click') : null;                     
                    }
                }
            }
            $(winOption.queryInput).bind('keyup', enterHandler);
            $(winOption.tableQueryInput).bind('keyup', enterHandler);
            
            
            // 重置左侧树形查询条件resizequerybtn
            //$(winOption.resizequerybtn).unbind('click');
            //$(winOption.queryInputClear).unbind('click');
            $(winOption.resizequerybtn).bind('click',function(){
                try{
                    var jquery_queryInput = $(winOption.queryInput);
                    jquery_queryInput.val('').focus();
                    $(winOption.jqtreeQuery).tree('loadData',[]);
                    QUtil.clearQueryTreeNodeCacheAndCss(winOption.jqtree);
                }catch(e){
                    isdebug ? alert('resizequerybtn click \n '+e.message) : null;
                }
            });
            
            $(winOption.queryInputClear).bind('click', function(){
                $(winOption.resizequerybtn).trigger('click');
            });
            
            // 响应右侧表格查询按钮
            //$(winOption.tableQuerybtn).unbind('click');
            // 表格数据库查询
            $(winOption.tableQuerybtnDb).bind('click',function(){
                gridQueryByQueryKey(winOption, "db");
            });
             // 表格缓存查询
            $(winOption.tableQuerybtn).bind('click',function(){
                gridQueryByQueryKey(winOption, "cache");
            });
           function gridQueryByQueryKey(winOption, type){         
                try{
                    var tableUrl  = winOption.tableUrl;
                    var tableType = winOption.tableType;
                    //alert(tableUrl + '\n\n'+tableType)
                    // 待选择表格对象
                    var tableInfo = winOption.tableInfo;
                    var jtable = $(tableInfo);
                    var tableQueryInput = winOption.tableQueryInput;
                    var queryKey = $(tableQueryInput).val();
                    
                    // 查询经济责任人时单独处理
                    var auditObjectId = "";
                    if(tableType && tableType == 'economyDuty'){
                        var leftTree = winOption.jqtree;
                        var selectedTreeNode = $(leftTree).tree('getSelected');
                        if(selectedTreeNode){
                            auditObjectId = selectedTreeNode.id;
                        }else{
                            top.$.messager.alert('提示信息','请在左侧选择经济责任人所属的被审计单位！','error');
                            return;
                        }
                        //alert('auditObjectId='+auditObjectId);
                    }
                    
                    if(!queryKey){
                        top.$.messager.alert('提示信息','请输入搜索关键字','warning', function(){
                            $(tableQueryInput).focus();
                        });
                    }else{
                        // 是否恢复查询前的结果集
                        var isRecoverDataSet = true;
                        var rtData = {};
                        // 从当前表格中查找匹配记录, 历史数据应该始终为最开始的结果集，而不是每次查询后的结果集
                        var oldData = jtable.data('oldWsTableData');
                        var tableData = oldData ? oldData : jtable.datagrid('getData');
                       
                        if(type == 'cache' && tableData && tableData.rows){// 页面有数据时，既可以从结果集查询也也可以从db查询
                            var rows = tableData.rows;
                            //alert('tableData.rows = '+rows.length)
                            var newRows = [];
                            var total = 0;
                            $.each(rows, function(index,row){
                                if(row.name.indexOf(queryKey) != -1){
                                    //alert(row.name);
                                    newRows.push(row);
                                    total++;
                                }
                            });
     
                            if(newRows.length>0){//结果集查询
                                //for(var p in tableData) alert(p+'='+tableData[p])
                                isRecoverDataSet = false;
                                rtData = {
                                    'rows':newRows,
                                    'total':total,
                                    'intPage':tableData.intPage,
                                    'intPageSize':tableData.intPageSize,
                                    'type':tableData.type
                                }
                                jtable.datagrid('loadData', rtData);
                                // 把原始数据缓存起来
                                jtable.data('oldWsTableData',tableData);
                            }else{
                               // top.$.messager.alert('提示信息','缓存中没有查询到匹配数据，自动转到数据库查询！', 'error',function(){
                                    //结果集没有数据， 从数据库中查询匹配记录
                                    isRecoverDataSet = !QUtil.findJqTableRowByQueryKeyFromDb({
                                        'tableUrl':tableUrl,
                                        'tableType':tableType,
                                        'jtable':jtable,
                                        'queryInput':tableQueryInput,
                                        'queryKey':queryKey,
                                        'auditObjectId':auditObjectId
                                    });     
                                    //alert('isRecoverDataSet='+isRecoverDataSet);
                                    // 还原查询前的结果集
                                    if(isRecoverDataSet){
                                        $(tableQueryInput).select().focus(); 
                                        // 如果原始数据已经缓存，说明不是第一次查询，如果没有匹配记录，则恢复原来的结果集
                                        if(jtable.data('oldWsTableData')){
                                            //jtable.datagrid('loadData', tableData); 
                                        }
                                    }
                                //});
                            }
                            
                            //var dataJson = jtable.data('queryParamsJson');
                            //alert('GridCache queryKey ='+dataJson.queryKey)
                            
                        }else if(type == 'db'){// 当前页面没有加载数据的时从db查询
                            //alert('query db')
                            var dataJson = jtable.data('queryParamsJson');
                            //alert('GridDb queryKey ='+dataJson.queryKey)
                            // 从数据库中查询匹配记录
                            QUtil.findJqTableRowByQueryKeyFromDb({
                                'tableUrl':tableUrl,
                                'tableType':tableType,
                                'jtable':jtable,
                                'queryInput':tableQueryInput,
                                'queryKey':queryKey,
                                'auditObjectId':auditObjectId
                            });
                            //alert('GridDb queryKey ='+dataJson.queryKey)
                        }
                        //alert('oldWsTableData='+jtable.data('oldWsTableData'));
                    }
                }catch(e){
                    isdebug ? alert('gridQueryByQueryKey:\n'+e.message) : null;
                }
            };
            // 响应右侧表格清空按钮
            //$(winOption.tableQueryInputClear).unbind('click');
            $(winOption.tableQueryInputClear).bind('click', function(){
                $(winOption.tableQueryInput).val('').focus();
                var jtable = $(winOption.tableInfo);
                //alert(jtable.data('oldWsTableData'))
                // 情况查询条件
                var queryParamsJson = jtable.data('queryParamsJson');
                queryParamsJson.queryKey = "";
                if(jtable.data('oldWsTableData')){
                    jtable.datagrid('loadData', jtable.data('oldWsTableData')); 
                }
            });
            // 响应右侧表格刷新按钮
            //$(winOption.tableResizequerybtn).unbind('click');
            $(winOption.tableResizequerybtn).bind('click', function(){
                // 待选择表格对象
                var tableInfo = winOption.tableInfo;
                var jtable = $(tableInfo);
                // 重新加载查询前的数据
                jtable.datagrid('loadData', jtable.data('oldWsTableData'));
            });
        } catch (e) {
            /// ignore some exception 
        }
    },
    // 从数据库中根据关键字查询匹配人员
    findJqTableRowByQueryKeyFromDb:function(paramJson){
        // 是否查询到记录，默认为true - 查询到记录
        var findRecs = true;
        try{
            var type = paramJson.tableType;
            var url  = paramJson.tableUrl;
            //alert(type +'\n' +url);
            var jtable = paramJson.jtable;
            var queryKey = $.trim(paramJson.queryKey);
            var queryInput = paramJson.queryInput;
            
            var dataJson = { 'queryKey':queryKey,'fromcomponent':1};
            if(type === 'economyDuty'){// 加载经济责人
                dataJson = jQuery.extend(dataJson, {'p_deptid':paramJson.auditObjectId});
                //for(var p in dataJson) alert(p);
            }
            // 根据表格缓存的查询条件查询
            var queryParamsJson = $(jtable).data('queryParamsJson');
            queryParamsJson = queryParamsJson ? queryParamsJson : {};
            // jQuery.extend使用时，最好把所有的参数都归结到一个空json对象中，否则会改变像这个$(jtable).data('queryParamsJson')的参数集合的值
            dataJson = jQuery.extend({},queryParamsJson, dataJson, {'page':'1'});
            //for(var p in dataJson)alert(p+'='+dataJson[p]);
            //alert('queryKey='+dataJson.queryKey+','+queryParamsJson.queryKey);
            //alert($(jtable).data('queryParamsJson').queryKey)
            if(url){
                $.ajax({
                    url : url,
                    async:false,
                    data: dataJson,
                    type: 'post',
                    dataType:'json',
                    success: function(data){
                        //alert('findJqTableRowByQueryKeyFromDb data = '+data)
                        if(data && data.rows && data.rows.length){                           
                            jtable.datagrid('loadData',data);
                            findRecs = true;
                        }else{
                            findRecs = false;
                            top.$.messager.alert('Window','没有匹配结果，请尝试更换查询关键字','error', function(){
                                $(queryInput).select().focus();
                            });
                        }
                    },
                    error:function(data){
                         findRecs = false;
                        top.$.messager.alert('提示信息','请求失败！检查网络连接或者与管理员联系！','error');
                    }
                });
            }
        }catch(e){
            isdebug ? alert('findJqTableRowByQueryKeyFromDb:\n '+e.message) : null;
        }
        //alert('findRecs='+findRecs);
        return findRecs;
    },
    // 清空树形查询缓存和加重节点样式
    clearQueryTreeNodeCacheAndCss:function(jqTreeObject){
        try{
            if(jqTreeObject){
                // 清空查询缓存
                $(jqTreeObject).removeData('queryRtTreeNodeArr');
                $(jqTreeObject).removeData('queryRtTreeNodeArrIndex');
                QUtil.recoverAllJqTreeNodeBgColor(jqTreeObject);
            }
        }catch(e){
            isdebug ? alert('clearQueryTreeNodeCacheAndCss\n'+e.message) : null;
        }
    },
    // 根据指定node选择jquery tree的孩子节点, 返回一个数组，每个元素为为一个node
    // 注意；jqtree自带的getChildren会选择所有后代节点，而不是子节点
    getJqtreeChildren:function(jqtreeObject, rootNode){
        var nodes = [];
        if(jqtreeObject && rootNode){
            // childNodes为li标签的dom集合
            var childNodes = $(rootNode.target).siblings('ul').children();
            if(childNodes && childNodes.length>0){
                var len = childNodes.length;
                $.each(childNodes, function(index, nodetarget){
                    // nodetarget 为dom对象
                    var nodeid = $(nodetarget).find('div').attr('node-id');
                    var node = $(jqtreeObject).tree('find', nodeid);
                    nodes.push(node);
                });
            }
        }
        return nodes;
    },
    getNodeTarget:function(jqTreeObject, node){
        try{
            if(jqTreeObject && node){
                var target = node.target; 
                //alert('target='+target);
                if(!target){
                    //alert('node='+node.id+','+node.text);
                    var tmp2 = $(jqTreeObject).tree('find', node.id);
                    //alert('tmp2='+tmp2);
                    target = tmp2.target;
                }
                //alert('target='+target);
                return target;
            }
            return null;
        }catch(e){
            isdebug ? alert('getNodeTarget:\n'+e.message) : null;
        }
    },
    /*注意：适用于节点已经加载完毕的情况。
      关闭jquery tree所有打开节点;
      打开指定节点的所有上级节点，并选中此节点;
      移动滚动条，使选中节点显示在窗口内；
      参数：jqTreeObject：树形tree对象，node:要选中的节点node
    */
    selectedSpecifiedNode:function(jqTreeObject, node, queryKey, noSelectScroll){             
        try{
             //alert(node.id+"\n"+node.text)
             if(node){
                var target = QUtil.getNodeTarget(jqTreeObject, node);
                var root = $(jqTreeObject).tree('getRoot');
                // 展开选中节点的所有上级节点(适用于节点已经加载完毕的树形)
                if(node && root && node.id != root.id){
                    // 关闭所有打开节点
                    //$(jqTreeObject).tree('collapseAll');
                    var treeId = jqTreeObject.id;
                    var parentNode = $(jqTreeObject).tree('getParent', target);
                    //var p2 = $(jqTreeObject).tree('getParent', node.target);
                    //var p3 = $(jqTreeObject).tree('getParent', node);
                    //var p4 = $('#'+treeId).tree('getParent', node.target);
                    //alert(parentNode+"\np2="+p2+"\np4="+p4);
                    while(parentNode){
                        //alert(parentNode.id+"\n"+parentNode.text);
                        var p_target = QUtil.getNodeTarget(jqTreeObject, parentNode);
                        if(parentNode.state != 'open'){
                            $(jqTreeObject).tree('expand', p_target);
                        }else{
                            parentNode = $(jqTreeObject).tree('getParent', p_target);
                        }
                    }
                }
				
				if(noSelectScroll){
					// 关键字底色加重
					QUtil.changeJqTreeNodeBgColor(target, queryKey);
				}else{
					// 匹配节点选中
					$(jqTreeObject).tree('select', target);
					// 关键字底色加重
					QUtil.changeJqTreeNodeBgColor(target, queryKey);
					// 滚动滚动条，定位匹配节点
					QUtil.scrollBarToShowNode(jqTreeObject, node);
				}
            }
        }catch(e){
            isdebug ? alert('selectedSpecifiedNode :\n'+e.message) : null;
        }       
    },
    // 根据查询关键字，模糊查找指定jquery tree的匹配节点，选中并展开; 匹配的节点保存在rtArr数组中
    findJqTreeNodeByQueryKeyFromCache2:function(queryKey, jqTreeObject, rootNode, rtArr){
        if(queryKey && jqTreeObject){
            if(!rtArr){
                rtArr = [];
            }
            queryKey = QUtil.trimAll(queryKey);   
            // 根据查询关键字首先匹配已经加载的树形节点，查看是否有符合要求的
            if(!rootNode){
                rootNode = $(jqTreeObject).tree('getRoot');
                // 根节点进行匹配搜索
                if(rootNode.text.indexOf(queryKey)!=-1){
                    rtArr.push(rootNode);
                    return;
                }
            }
            // 注意；getChildren会选择所有后代节点，而不是子节点
            var childNodes = QUtil.getJqtreeChildren(jqTreeObject, rootNode);
            //alert(childNodes.length);
            if(childNodes&&childNodes.length > 0){
                var len = childNodes.length;
                for(var i=0; i<len; i++){
                    var node = childNodes[i];
                    var subChild = $(jqTreeObject).tree('getChildren', node.target);
                    //alert(node.text)
                    if(node.text.indexOf(queryKey)!=-1){
                        rtArr.push(node);
                        //alert(node.id+' '+node.text+' len='+rtArr.length)
                        //alert('匹配成功, len/index='+len+'/'+i+', rtArr.length='+rtArr.length);
                    }
                    if(subChild && subChild.length > 0){// 深层次搜索匹配节点
                        //alert('匹配下一级');
                        // 递归匹配节点
                        QUtil.findJqTreeNodeByQueryKeyFromCache(queryKey, jqTreeObject, node, rtArr);
                    }
                }
            }       
        }
    },
    // 根据查询关键字，模糊查找指定jquery tree的匹配节点保存在rtArr数组中
    findJqTreeNodeByQueryKeyFromCache:function(queryKey, jqTreeObject, rootNode, rtArr){
        if(queryKey && jqTreeObject){
            if(!rtArr){
                rtArr = [];
            }
            //alert('findJqTreeNodeByQueryKeyFromCache:\n开始时缓存数组len='+rtArr.length);
            queryKey = QUtil.trimAll(queryKey);   
            var multiRoot = [];
            // 根据查询关键字首先匹配已经加载的树形节点，查看是否有符合要求的
            if(!rootNode){
                // 先判断根节点可能有多个的情况
                var roots = $(jqTreeObject).tree('getRoots');
                if(roots && roots.length > 0){// 多个根节点的情况时，对多个根节点进行搜索
                    for(var r=0; r<roots.length; r++){
                        var tmpRoot = roots[r];
                        // 根节点进行匹配搜索
                        if(tmpRoot.text.indexOf(queryKey) != -1){
                            rtArr.push(tmpRoot);
                            multiRoot.push(tmpRoot);
                        }
                    }
                    // 当只有一个根节点的情况
                    if(roots.length == 1){
                        multiRoot = [];
                        multiRoot.push(roots[0]);
                    }
                }
            }
            //alert('findJqTreeNodeByQueryKeyFromCache:\nrtArr='+rtArr.length+'\nmultiRoot='+multiRoot.length);
            // 对根节点进行循环遍历
            if(multiRoot && multiRoot.length > 0){
                for(var t=0; t<multiRoot.length; t++){
                    var mr = multiRoot[t];
                    // 注意；getChildren会选择所有后代节点，而不是子节点
                    var childNodes = $(jqTreeObject).tree('getChildren', mr.target);
                    if(childNodes && childNodes.length > 0){
                        var len = childNodes.length;
                        //alert('findJqTreeNodeByQueryKeyFromCache:\nroot='+mr.text+'\nchildNodes.length='+len);
                        for(var i=0; i<len; i++){
                            var node = childNodes[i];
                            if(node.text.indexOf(queryKey) != -1){
                                rtArr.push(node);
                            }
                            /*
                            if(subChild && subChild.length > 0){// 深层次搜索匹配节点
                                //alert('匹配下一级');
                                // 递归匹配节点
                                QUtil.findJqTreeNodeByQueryKeyFromCache(queryKey, jqTreeObject, node, rtArr);
                            }
                            */
                        }
                    } 
                }  
            }
            //alert('findJqTreeNodeByQueryKeyFromCache:\n符合关键字【'+queryKey+'】的节点有rtArr.length='+rtArr.length);
        }
    },
    // 根据关键字从数据库查询匹配节点
    findJqTreeNodeByQueryKeyFromDb:function(winOption){
        try{
            // 如果已经加载节点没有匹配节点，则到数据库中去查询
            //alert(winOption.treeUrl);
            queryKey = $.trim($(winOption.queryInput).val());
            //alert(winOption.treeUrl +'\n'+ queryKey)
            $.ajax({
                url : winOption.treeUrl,
                data: {'queryKey':queryKey},
                type: 'post',
                dataType:'json',
                success : function(data){
                    //alert(data);
                    //alert(data.length);
                    if(data.length){                            
                        //alert(winOption.treeWrap)
                        //QUtil.generateResultTable(winOption.treeWrap, data, queryKey);
                        // 加载树形，并改变关键字底色
                        $(winOption.jqtreeQuery).tree('loadData', data);
                        QUtil.changeAllJqTreeNodeBgColor(winOption.jqtreeQuery, queryKey);
                        // 查询db完毕后，清空页面结果集查询缓存
                        QUtil.clearQueryTreeNodeCacheAndCss(winOption.jqtree);
                        $(winOption.jqtree).data('queryRtTreeNodeArr', data);
                        $(winOption.jqtree).data('queryRtTreeNodeArrIndex', 0);
                        if(data.length > 1){
                            //for(var p in data[0]) alert(p+'='+data[0][p])
                            $(winOption.treeWrap).tabs('select',1);
                        }else{
                            var node = $(winOption.jqtreeQuery).tree('find', data[0].id);
                            if(node){
                                // 定位节点，并打开本级本上级
                                if(QUtil.expandPriorNodeByIds(node.id, winOption.getPriorUrl, winOption.jqtree, queryKey)){
                                    $(winOption.treeWrap).tabs('select',0);
                                }
                            }else{
                                $(winOption.treeWrap).tabs('select',1);
                            }
                        }
                    }else{
                        $(winOption.jqtreeQuery).tree('loadData',[]);
                        top.$.messager.alert('提示信息','没有匹配结果，请尝试更换查询关键字','error', function(){
                            $(winOption.queryInput).select().focus();
                        });
                       
                    }
                },
                error:function(data){
                    $.messager.alert('提示','请求失败！检查网络连接或者与管理员联系！','error');
                }
            });
        }catch(e){
            isdebug ? alert('findJqTreeNodeByQueryKeyFromDb:\n '+e.message) : null;
        }
    },
    // 改变树形节点底色
    changeJqTreeNodeBgColor:function(treeNodeDom, queryKey, color){
        try{
            if(treeNodeDom){
                color = color ? color : 'yellow';
                $(treeNodeDom).find('.tree-title').each(function(index, node){
                    var text = $(node).html();
                    if(!$(node).attr('oldText')){
                        $(node).attr('oldText',text);
                    }
                    if(queryKey){
                        $(node).html(QUtil.replaceAll(text,queryKey,"<strong><font color='red'><label style='background-color:"+color+";'>"+queryKey+"</label></font></strong>"));
                    }else{
                        //$(node).html("<label style='background-color:"+color+";'>"+text+"</label>");
                    }
                });
            }
        }catch(e){
            isdebug ? alert('changeJqTreeNodeBgColor \n'+e.message) : null;
        }
    },
    // 改变所有树形节点底色
    changeAllJqTreeNodeBgColor:function(jqTreeObjectDom, queryKey, color){
        try{
            if(jqTreeObjectDom){
                color = color ? color : 'yellow';
                $(jqTreeObjectDom).find('.tree-title').each(function(index, node){
                    var text = $(node).html();
                    if(!$(node).attr('oldText')){
                        $(node).attr('oldText',text);
                    }
                    if(queryKey){
                        $(node).html(QUtil.replaceAll(text,queryKey,"<strong><font color='red'><label style='background-color:"+color+";'>"+queryKey+"</label></font></strong>"));
                    }else{
                        $(node).html("<label style='background-color:"+color+";'>"+text+"</label>");
                    }
                });
            }
        }catch(e){
            isdebug ? alert('changeAllJqTreeNodeBgColor:\n'+e.message) : null;
        }
    },
    // 还原树形节点底色
    recoverJqTreeNodeBgColor:function(treeNodeDom, queryKey){
        try{
            if(treeNodeDom){
                $(treeNodeDom).find('.tree-title').each(function(index, node){
                    var oldText = $(node).attr('oldText');
                    if(oldText){                       
                        $(node).html(oldText);
                        $(node).removeAttr('oldText');
                    }
                });
            }
        }catch(e){
            isdebug ? alert('recoverJqTreeNodeBgColor:\n'+e.message) : null;
        }
    },
    // 还原所有树形节点底色
    recoverAllJqTreeNodeBgColor:function(jqTreeObjectDom){
        try{
            if(jqTreeObjectDom){
                $(jqTreeObjectDom).find('.tree-title').each(function(index, node){
                    var oldText = $(node).attr('oldText');
                    if(oldText){                       
                        $(node).html(oldText);   
                        $(node).removeAttr('oldText');                       
                    }
                });
            }
        }catch(e){
            isdebug ? alert('recoverAllJqTreeNodeBgColor:\n'+e.message) : null;
        }
    },
    // 去掉字符串中的所有空格
    trimAll:function(s){
        return s.replace(/(\s*)/g, "");
    },
    // 把字符串中的所有oldchar替换为newchar
    replaceAll:function(s,oldchar,newchar) {
         var reg = new RegExp(oldchar,"gi");
         return s.replace(reg,newchar);
    },
    // 获得随机数, 参数：随机数的位数
    ran:function(len){
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
            isdebug ? alert("Q.util.ran:\n"+e.message) : null;
        }
    },
    // 光标移动到文本的末尾
    focusMoveEnd:function(obj, pos){
        try{
            if(!obj) return;
            $(obj).focus();
            var len = pos ? parseInt(pos) : obj.value.length;
            if (document.selection){
                var sel = obj.createTextRange();
                sel.moveStart('character',len);
                sel.collapse();
                sel.select();
            } else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
                obj.selectionStart = obj.selectionEnd = len;
            }
        }catch(e){
            isdebug ? alert('focusMoveEnd:\n'+e.message) : null;
        }
    },    
    // json 转化成 string 递归对象的各个属性，形成string串
    object2string:function(o){
         try {
             var r = [];
             // 如果为字符串string，则返回
             if (typeof o == "string" || o == null) {
                 var tmpArr = new Array();
                 tmpArr.push("'");
                 tmpArr.push(o);
                 tmpArr.push("'");
                 return tmpArr.join("");
             }else if (typeof o == "number" || typeof o == "boolean" || typeof o == "function" || o == null) {
                 var tmpArr = new Array();
                 tmpArr.push(o);
                 return tmpArr.join("");
             }
             //如果对object对象，则遍历object的元素
             if (o) {
                 var objType = jQuery.type(o);
                 if (objType === "object") {
                     r[0] = "{";
                     for (var i in o) {
                         r[r.length] = i;
                         r[r.length] = ":";
                         r[r.length] = QUtil.object2string(o[i]);
                         r[r.length] = ",";
                     }
                     r[r.length - 1] = "}";
                 } else if (objType === "array") {
                     r[0] = "[";
                     for (var i = 0; i < o.length; i++) {
                         r[r.length] = QUtil.object2string(o[i]);
                         r[r.length] = ",";
                     }
                     r[r.length - 1] = "]";
                 }
                 return r.join("");
             }
             return o.toString();
         } catch (e) {
             isdebug ? alert("object2string:\n"+e.message) : null;
         }
    },
    // 滚动滚动条，使指定jqtree 节点显示在界面窗口的上半部，处于显示位置
    scrollBarToShowNode:function(jqTreeObject, node){
        try{
            if(jqTreeObject && node){
                var offset = $(jqTreeObject).data('treeScrollOffset');
                if(!offset){
                    var root = $(jqTreeObject).tree('getRoot');
                    offset = QUtil.getElementPos(root.target).y;
                    $(jqTreeObject).data('treeScrollOffset',offset);
                }
                QUtil.locationNode(node, jqTreeObject.parentNode, offset);
            }
        }catch(e){
            isdebug ? alert('scrollBarToShowNode:\n '+e.message) : null;
        }
    },
    // 定位node所在坐标，使node不被隐藏
    locationNode:function(node, containObj, offset){
        //alert(node +' '+ containObj);
        if(node && containObj){
            var top = QUtil.getElementPos(node.target).y;
            //alert(containObj.nodeName);
            if(!offset){
                offset = 0;
            }else{
                offset+=50;
            }
            //alert(top+'\n'+offset);
            containObj.scrollTop = top - offset;
        }
    },
    // 获得el的left和top
    getElementPos:function(el){
        var el = QUtil.getItself(el);
        var _x = 0, _y = 0;
        do {
            _x += el.offsetLeft;
            _y += el.offsetTop;
        } while (el = el.offsetParent);
        return {
            x: _x,
            y: _y
        };
    },
    getItself:function(id){
        return "string" == typeof id ? document.getElementById(id) : id;
    },
    // 加载数据表格
    /**
	//$('#childBasefrm').attr('src', frmUrl+node.id);
	QUtil.loadGrid({
        // 请求的url, 可选如果没有，则使用表格默认的url； 可选
        url:xx,
        // 传入的查询参数； 可选
        param:{},
        // 请求类型post or get， 默认为post请求; 可选
        type:'post',
        // 表格对象
        gridObject:$('#testTable')[0],
        // 查询前和加载后执行的function
        beforeSend:function(){},
        afterSuccess:function(){}
    }
    */
    loadGrid:function(paramJson){
        try{
            var othis = this;
            if($.ajax){

                var gridObject = paramJson.gridObject;
                if(!gridObject){
                    top.$.messager.alert('提示信息','无法获得表格对象gridObject','error');
                    return;
                }
                
                // 表格的请求的url，可以自己指定；如果没有默认读取表格初始化时的url
                var furl = paramJson.url ? paramJson.url : $(gridObject).datagrid('options').url;
                
                // 从缓存中读取记录bo，请求的类和方法等基本信息,json格式
                var basicGridParam = $(gridObject).data('basicGridParam');
                
                //for(var p in basicGridParam) alert('loadGrid-basicGridParam:\n'+p+'='+basicGridParam[p]);
                
                // 方法传入的用户自定义的参数; 最终fparam由三部分组成：basicGridParam，pageParam， paramJson.param
                var fparam = paramJson.param ? paramJson.param : {};
                
                // 读取分页信息
                var pageOption = $(gridObject).datagrid('getPager').pagination('options');
                var pageParam = pageOption ? {'page':pageOption.pageNumber,'rows':pageOption.pageSize} : {'page':1};
                
                // 继承表格的基础参数
                if(basicGridParam){
                    // 复制一个json，防止对basicGridParam的修改
                    fparam = $.extend(pageParam, basicGridParam, fparam); 
                }
                //for(var p in fparam) alert('loadGrid:\n'+p+'='+fparam[p]);  

                var type = paramJson.type ? paramJson.type : 'post';
                var beforeSendFn = paramJson.beforeSend&&jQuery.type(paramJson.beforeSend) == "function" ? paramJson.beforeSend : null;
                
                $.ajax({
                    dataType:'json',
                    url : furl,
                    data: fparam,
                    type: type,
                    beforeSend:beforeSendFn,
                    success: function(data){
                        //alert('paramJson.callbackFn:\n'+paramJson.callbackFn)
                        // 加载返回的数据，生成table
                        //alert('paramJson.showMsg='+paramJson.showMsg+'\ndata.rows='+data.rows)
                        if(data.rows && data.rows.length>0){
                            $(gridObject).datagrid('loadData',data);
                        }else{
                        	$(gridObject).datagrid('loadData', {'total':'0', 'rows':[]});
                        	paramJson.showMsg ? top.$.messager.alert('提示信息',"数据表格没有查询到数据", 'warning') : null;
                        }
                        if(data.type == 'success'){
                            //paramJson.afterSuccess&&jQuery.type(paramJson.afterSuccess) == "function" ? paramJson.afterSuccess(data, gridObject) : null;
                        }else{
                            data.msg && paramJson.showMsg ? top.$.messager.alert('提示信息',data.msg, 'info') : null;
                        }	
                        // 回调函数，任何情况下都执行
                        paramJson.callbackFn&&jQuery.type(paramJson.callbackFn) == "function" ? paramJson.callbackFn(data, gridObject) : null;
                    },
                    error:function(data){
                        top.$.messager.alert('提示信息','请求失败！请检查网络是否通畅!','error');
                    }
                });
            }else{
                throw new Error("当前环境不支持$.ajax，请引入jquery相关包");
            }
        }catch(e){
            isdebug ? alert('QUtil(loadGrid) :\n'+e.message) : null;
        }
    },
    // 获得datagrid列属性Array,返回[{text:xxx, name:xxxx, id:xxx, operator:xxx},....]
    getDatagridColunmFormArr:function(gridcolumns, tdomId){
        try{
            if(gridcolumns){
                var formAttr = [];
                var columns = gridcolumns;
                if(columns){
                    for(var i=0; i<columns.length; i++){
                        var c1 = columns[i];
                        //alert(c1.field);
                        if(c1.show == false || c1.show == 'false') continue;
                        var operator = c1.oper ? c1.oper : 'eq';
                        var type = c1.type ? c1.type : 'text';
                        // 是否必填
                        var request = c1.request || c1.required ? c1.request : false;
						var queryKey = c1.queryKey ? c1.queryKey : c1.field;
                        formAttr.push({
                            'text':c1.queryText ? c1.queryText : c1.title,
                            'name':'query_'+operator+'_'+queryKey,
                            'id'  :queryKey+'_'+tdomId,
                            'operator':operator,
                            'type':type,
                            'request':request,
                            'target' :c1.target ? c1.target : null
                        });
                    }
                }
                return formAttr;
            }       
        }catch(e){
            isdebug ? alert("QUtil(getDatagridColunmFormArr):\n "+e.message) : null;
        }
        return null;
    },
    // url(a=1&b=2 => {a:1, b:2})形式的字符串转换成json格式
    url2json:function(url){
        try{
            var tmp = [];
            tmp.push("{");
            if(url && jQuery.type(url) === "string"){
                var arr = decodeURI(url).split('&');
                if(arr && jQuery.type(arr) === "array" && arr.length > 0){
                    $.each(arr,function(i,ele){
                        var arr2 = ele.split('=');
                        if(arr2 && jQuery.type(arr2) === "array" && arr2.length == 2){
                            var key   = jQuery.trim(arr2[0]);
                            var value = jQuery.trim(arr2[1]);
                            tmp.push("'");
                            tmp.push(key);
                            tmp.push("'");
                            tmp.push(":");
                            tmp.push("'");
                            tmp.push(value);
                            tmp.push("'");
                            if(i < arr.length-1){
                                tmp.push(",");
                            }
                        }
                    });
                }
            }
            tmp.push("}");
            var str = tmp.join('');
            return (new Function("return " + str))();
        }catch(e){
            isdebug ? alert('QUtil(url2json) :\n '+e.message) : null;
        }
    },
    // json({a:1, b:2} => a=1&b=2 )形式转换成url字符串
    json2url:function(json){
        var arr = [];
        try{
            if(json && jQuery.type(json) === "object"){
                for(var p in json){
                    arr.push(p);
                    arr.push('=');
                    arr.push(json[p]);
                    arr.push('&');
                }
            }
        }catch(e){
            isdebug ? alert('QUtil(json2url) :\n'+e.message) : null;
        }
        return arr.json('');
    },
    // 导出结果集到exccel
    exportDataSetToExcel:function(json, tdomId){
        try{
            QUtil.startProgressbar();
        	window.setTimeout(function(){
                /*
			                导出文件需要建立一个form，把参数放到input中，input设置name、value的值.
			                为避免多次点击，多次创建form，需要判断是否已经创建了form。方法为：为form添加唯一性的id
                */ 	
                var formId = "export_table_"+tdomId;
                var form  = $('#'+formId);
                if(form && form.length>0){// 已经创建过导出参数form
                    //alert("已经创建过导出参数form");
                    form = $('#'+formId)[0];
                }else{// 为第一次导出,创建导出参数form
                    var iframeId = 'iframe_'+formId;
                    form = document.createElement('form');
                    var url = json.url ? json.url : "/ais/commonPlug/exportDataSetToExcel.action";              
                    $(form).attr({
                        'action':url,
                        'id'    :formId,
                        'method':'post',//默认为get请求，如果有中文字段就会出现乱码，最好用post
                        'target':'iframe_'+formId
                    });
                    /** 
                     * name属性不能动态修改，所以js创建时name不会改变；jquery创建input时name变成submitName
                     * 创建ifame时，如果动态创建就会没有name，而是submitName，导致每次都是新打开一个窗口；
                     * 用html创建解决此问题。
                     * 用iframe可以在文件上传下载等无法使用ajax时，模仿ajax那种局部刷新的机制；
                     */
                    $(document.body).append("<iframe id='"+iframeId+"' name='"+iframeId+"' style='display:none;'></iframe>")
                                    .append(form);
                }
                // 情况表单输入框
                $(form).html('');
                // 每次导出的条件可能不一样，每次重新创建input参数
                var data = json.data;
                if(data){
                    for(var p in data){
                        $(form).append("<input id=\""+p+"\" name=\""+p+"\" value=\""+data[p]+"\" />");
                    }
                }
                $(form).submit();
                $('#qpbar').progressbar('setValue', 100);
                QUtil.stopProgressbar();
            },100);
        }catch(e){
            isdebug ? alert("exportDataSetToExcel \n"+e.message) : null;
        }
    },
    // 设置进度条
    setProgressbar:function(vl){
        try{
            var value = $('#qpbar').progressbar('getValue');
            if(value >= 100){
                $('#qpwin').window('close');
                window.pbarInterval ? clearInterval(window.pbarInterval) : null;            
            }else if (value <= 100){   
                 value += vl;   
                 $('#qpbar').progressbar('setValue', value);   
           } 
       }catch(e){
           setProgressbar ? alert("setProgressbar:\n"+e.message) : null;
       }
    },
    startProgressbar:function(){
        $('#qpwin').window('open');
        $('#qpbar').progressbar('setValue', 0);
        window.pbarInterval = window.setInterval(function(){QUtil.setProgressbar(1)}, 50);
    },
    stopProgressbar:function(){
        $('#qpwin').window('close'); 
        window.pbarInterval ? clearInterval(window.pbarInterval) : null;
        $('#qpbar').progressbar('setValue', 0);
    },
    // 从界面删除复选框选中的datagrid的rows,注意：只是界面删除，不是db中删除，适用于db中删除成功后对界面的修改；
    removeViewRows:function(rows, gridObj){
        try{
            if(rows && gridObj && rows.length >0){
                 for(var i=rows.length-1; i>=0; i--){
                     var row = rows[i];
                     var index = $(gridObj).datagrid('getRowIndex',row);
                     $(gridObj).datagrid('deleteRow',index);
                 }
            }
        }catch(e){
            isdebug ? alert("removeViewRows:\n "+e.message) : null;
        }
    },
    // 响应单击删除表格数据
    removeDatagridRows:function(paramJson){
        try{
            var gridObj = $(paramJson.gridObject);
            var rows = gridObj.datagrid('getChecked');
            if(!rows || rows.length == 0){
                //top.$.messager.alert('提示信息','请选择要删除的数据！','error');
                showMessage1('请选择要删除的记录！');
                return;
            }			
			// 删除前校验
			var fn = paramJson.beforeRemoveRowsFn;
			if(fn && jQuery.type(fn) == "function" && !fn(rows, paramJson.gridObject)){
				return;
			}		
            top.$.messager.confirm('提示信息','您选择了【'+rows.length+'】条记录，是否删除?<br>单击【确定】删除记录',function(flag){
                if(flag){
                    var url = paramJson.url ? paramJson.url : '/ais/commonPlug/removeDatagridRows.action';
                    var pkName = paramJson.pkName ? paramJson.pkName : 'id';
                    var delIdArr = [];
                    //alert(paramJson.removeFilter)
					if(paramJson.removeFilter){
						delIdArr = paramJson.removeFilter(rows);
					}else{
						$.each(rows, function(i, row){
							delIdArr.push(row[pkName]);
						});	
					}
					if(!delIdArr || delIdArr.length == 0) return;
                    //alert(paramJson.delWhere)
                    var dataJson = {
                        'boName':paramJson.boName,
                        'pkName':pkName,
                        'ids'   :delIdArr.join(','),
						'delWhere':paramJson.delWhere
                    };
                    $.ajax({
                        url:url,
                        dataType:'json',
                        data: dataJson,
                        type: "POST",
                        beforeSend: function(){
                            // 删除前校验
							/*
                            var fn = paramJson.beforeRemoveRowsFn;
                            if(fn && jQuery.type(fn) == "function"){
                                return fn(rows, paramJson.gridObject);
                            }*/
                            return true;
                        },
                        success: function(data){
                            if(data.msg){
                                //top.$.messager.alert('提示信息',data.msg,data.type);
                                showMessage1(data.msg);
                            }
                            if(data.type != 'error'){
								if(paramJson.delRefresh != false){
									var plugObj = $(gridObj).data('plugObj');
									plugObj.refresh();
								}
								//删除成功后调用的方法
								var afterFn = paramJson.afterRemoveRowsFn;
								if(afterFn && jQuery.type(afterFn) == "function"){
									afterFn(rows, paramJson.gridObject);
								}
                            }
                        },
                        error:function(data){
                            top.$.messager.alert('提示信息','请求失败！检查网络连接或者与管理员联系！','error');
                        }
                    });
                }
            });
        }catch(e){
            isdebug ? alert("removeDatagridRows:\n"+e.message) : null;
        }
    },
    /**
        设置表格按钮的名字或者状态
        参数：gridObject　-　domObject, 表格dom对象
              btnArr      -  [], 按钮数组，每个一个元素为一个json对象，
              包括如下信息[{
				'id':'btnAdd',//如果有按钮的id，则index失效
				'remove':true/false //把按钮对象整个从dom中移除
                'index':1, // 按钮的下标从1开始，如果超过实际按钮数组的最大长度，则默认为指向最后一个按钮
                'name' :'newName',//指定按钮的新名字
                'display':true/false, // 按钮的状态，true：显示 or  false：隐藏
                'icon':'cut', // 按钮样式，eg：’cut，save， add '等
                'disabled':'tue/false', // 按钮是否可用
				
				
              },{}]
    */
    setGridBtn:function(gridObject, btnArr){
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
            // 按钮wrap对象
            var btnPlain = toolbar.find('.l-btn-plain');
            if(btnPlain.length>0){
                var len = btnPlain.length;
                if(btnArr && btnArr.length>0){
                    for(var i=0; i<btnArr.length; i++){
                        var btnJson = btnArr[i];
                        var index   = btnJson.index;
                        var newName = btnJson.name;
                        var display = btnJson.display;
                        var disabled = btnJson.disabled;
                        var icon  = btnJson.icon;
						// 如果有按钮的id，则index失效
						var btnId = btnJson.id;
						// 移除
						var remove = btnJson.remove;
                        
						var wrap = null;
						var separator = null;
						if(btnId){
							wrap = toolbar.find('#'+btnId);
						}else{
							if(index < 0){
								index = 1;
							}
							if(index > len){
								index = len;
							}
							wrap = btnPlain[index-1]; 
						}
						if(!wrap) continue;
						separator = $(wrap).parent('td').next('td').find('.datagrid-btn-separator');
						
                        if(remove == true || remove == 'true'){
                            $(wrap).parent().remove();
                            $(separator).parent().remove();
							continue;
                        }
						
                        if(display == true || display == 'true'){
                            $(wrap).show();
                            separator&&separator.length>0 ? separator.show() : null;
                        }else if(display == false || display == 'false'){
                            $(wrap).hide();
                            separator&&separator.length>0 ? separator.hide() : null;
                        }
                        
                        if(disabled == true || disabled == 'true'){
                            $(wrap).attr({'disabled':true});//alert(1)
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
                }else{
                	return false;
                }
            }else{
            	return false;
            }
            return true;
        }catch(e){
            isdebug ? alert('setGridBtn:\n '+e.message) : null;
        }
    },
    /**
     * 把字符串类型，正确的转换成boolean值，0，'false', undefined, false => false
     * 1,-1,true,'true','abc' => true
     */
    string2boolean:function(str, defaultBoolean){
    	try{
    		var ptype = jQuery.type(str);
    		if(ptype == 'boolean'){
    			return str;
    		}
    		if(str != null){
    			str = str.toLowerCase();
    			str = $.trim(str);
    			if(str == 'false' || str == "" || str == "0" || str == undefined || str == "undefined"){
    				return false;
    			}else if(str == 'true' || str == "-1" || str == "1" || str.length > 1){
    				return true;
    			}
    		}else{
    			return defaultBoolean != null ? defaultBoolean : false;
    		}
        }catch(e){
            isdebug ? alert('string2boolean:\n '+e.message) : null;
        }
    }
};

/**
   @author:qfucee, 2014.1.27
   @desc  :根据Jquery easyui datagrid控件（数据表格），编写的辅助类
           后台的查询和前台的展现已经写好，只需配置即可
           
   eg:
        $(function(){
			new createQDatagrid({
				// 表格dom对象，必填
			    gridObject:$('#testTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'UOrganization',
		        // 自己指定服务类，不指定默认为ICommonPlugService接口的实现类的名称，即：commonPlugService；可选
		        'serviceInstance':'commonPlugService',
		        // 自己指定服务类时，还要指定执行的方法， 不指定默认为getCustomDatagrid；可选
		        'serviceMethod':'getCustomDatagrid',
			    // 表格加载前执行，做一些校验工作；可选
			    beforeSendFn:function(){},
			    // 表格加载后执行，一般做些和表格相关的工作；可选
			    afterSuccessFn:function(data, gridObject){},
			    // 表格控件dataGrid配置对象; 必填
			    gridJson:{
					queryParams:{},
					title:'对象详细信息',
					columns:[[ 
						{field:'fname',   title:'单位名称',width:'200px',align:'left',   sortable:true},
						{field:'cityName',title:'城市名称',width:'100px',align:'center', sortable:true},
						{field:'cityCode',title:'城市代码',width:'100px',align:'center', sortable:true}]]
			    }
			}); 
			var obj = $('#auditObjectTreeId')[0];
			var dpetId = '${user.fdepid}';
			var frmUrl = '${contextPath}/mng/audobj/object/${status}.action?superiorCode=${currentCode}&status=${status}&auditingObject.id=';

			// 自定义 - 组织机构树
			showSysTree(obj,{
				container:obj,
				defaultDeptId:dpetId,
				param:{
                    'beanName':'UOrganizationTree',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode'
                },
				onTreeClick:function(node, treeDom){	
					//$('#childBasefrm').attr('src', frmUrl+node.id);
					QUtil.loadGrid({
				        // 请求的url, 可选如果没有，则使用表格默认的url； 可选
				        url:xx,
				        // 传入的查询参数； 可选
				        param:{'query_eq_fpid':node.id,'sort':'cityName'},
				        // 请求类型post or get， 默认为post请求; 可选
				        type:'post',
				        // 表格对象
				        gridObject:$('#testTable')[0],
				        // 查询前和加载后执行的function
				        beforeSend:function(){},
				        afterSuccess:function(){}
					});
				}
			}); 
		});
*/
function createQDatagrid(paramJson){
    var othis = this;
    // 传入的参数对象json
    this.customParamJson = paramJson;
	this.isTreeGrid = paramJson.treeGrid ? true : false;
    this.container = $(document.body)[0];
    var pageSize = paramJson.pageSize ? paramJson.pageSize : 10;
    var basicGridParam = {
		//是否关联查询
		'associate':paramJson.associate ? true : false,
		//是否为树形表格
		'treeGrid':this.isTreeGrid,
		//表格树时，记录业务对象中表示父节点Id的属性
		'parentIdCol':paramJson.parentIdCol ? paramJson.parentIdCol : '',
        // 要进行检索的表对象(hibernate bean)名称，进行拼接hql时使用
        'boName':paramJson.boName,
        // 查询sql的where条件，可选
        'whereSql':paramJson.whereSql,
        // 自己指定服务类，不指定默认为ICommonPlugService接口的实现类的名称，即：commonPlugService；可选
        'serviceInstance':paramJson.serviceInstance,
        // 自己指定服务类时，还要指定执行的方法， 不指定默认为getCustomDatagrid；可选
        'serviceMethod':paramJson.serviceMethod,
        'rows':pageSize,
        'sort':paramJson.sort ? paramJson.sort : '',
        'order':paramJson.order ? paramJson.order : ''
    }
    this.defaultPageSize = basicGridParam.pageSize;
    var gridObject = this.gridObject = paramJson.gridObject;
    $(gridObject).data('basicGridParam',basicGridParam);
    $(gridObject).data('paramJson',paramJson).data('plugObj', this);
    
    // 单独复制一个查询json，防止grid初始化的参数覆盖basicGridParam
    var defaultGridQueryParams = jQuery.extend({},basicGridParam);
    
    // 把查询条件缓存起来，供分页或者刷新等按钮使用
    var tmpJson = jQuery.extend({}, basicGridParam, paramJson.gridJson.queryParams);
    $(gridObject).data('gridQueryParamJson',tmpJson);
    //for(var p in tmpJson) alert(p+'='+tmpJson[p]);
    
    var tdomId = $(gridObject).attr('id'); 
    tdomId = tdomId ? tdomId : 'QgirdId'+QUtil.ran(6);
    $(gridObject).attr('id',tdomId);
    
    var defaultGridinitJson = jQuery.extend(true, {
        url : "/ais/commonPlug/getCustomDatagrid.action",
        queryParams:defaultGridQueryParams,
        fit : true,
        rownumbers:true,
        pagination:true,
        striped:true,
        loadMsg:'表格数据加载中，请稍后......',
        nowrap : true,
        border : false,
        collapsible : false,
		onSortColumn:function(sort,order){
            $(gridObject).data('qSort', sort);
            $(gridObject).data('qOrder', order);
            // 读取缓存中的查询参数
            var gridQueryParamJson = $(gridObject).data('gridQueryParamJson');
            gridQueryParamJson = gridQueryParamJson ? gridQueryParamJson : {};
            // 读取分页信息
            var pt = othis.getPageOption();
			var qoptions = othis.isTreeGrid ? $(gridObject).treegrid('options') : $(gridObject).datagrid('options');
			//alert(gridQueryParamJson.pageSize +"\n"+ pt.pageSize)
			var pageSize = gridQueryParamJson.pageSize ? gridQueryParamJson.pageSize: pt.pageSize;
            qoptions.queryParams = $.extend(gridQueryParamJson,{
                'page':pt.pagetNumber,
                'rows':pageSize,
                'sort':sort, 
                'order':order});
        },
        toolbar:[]
    },paramJson.gridJson);
    // toolbar 单独继承页面自定义的按钮
    var customToolbar = defaultGridinitJson.toolbar;
    //alert(customToolbar);
	
	//定义页面按钮
	var barbtnJson = {
		'delete':{
            text:'删除',
            iconCls:'icon-delete',
            id     :tdomId+'_remove',
            handler:function(){
                return QUtil.removeDatagridRows(paramJson);
            }
        }, 
		'export':{
            text:'导出到Excel',
            iconCls:'icon-export',
            id     :tdomId+'_export',
            handler:function(){
                othis.export2Excel(paramJson);
            }     
        }, 
		'search':{
            text:'查询',
            iconCls:'icon-search',
            id     :tdomId+'_search',
            handler:function(){
                $(othis.winDiv).window('open');
            }
        }, 
		'query':{
            text:'查询',
            iconCls:'icon-search',
            id     :tdomId+'_search',
            handler:function(){
                $(othis.winDiv).window('open');
            }
        },
		'reload':{
            text:'刷新',
            iconCls:'icon-reload',
            id     :tdomId+'_reload',
            handler:function(){
                othis.refresh();
            }
        },
		'refresh':{
            text:'刷新',
            iconCls:'icon-reload',
            id     :tdomId+'_reload',
            handler:function(){
                othis.refresh();
            }
        }
	};

	/*
	    myToolbar: [],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar: isView ? ['export', 'search', 'reload'] : ['query','-',{   
	                text:'添加',
	                iconCls:'icon-add',
	                handler:function(){
                    	aud$openNewTab('材料价格添加', editUrl, true);
	                }
	            },'-','delete','-',{   
	                text:'下载模版',
	                iconCls:'icon-download',
	                handler:function(){
	                	$('#parseExcelContainer').parseExcel('downloadTemplate');
	                }
	            },'-',{   
	                text:'导入文件',
	                iconCls:'icon-upload',
	                id:'mpImportExcelBtn'
	            },'-','export','-','reload','-'
	        ],
	
	*/
	var d2 = [];
	//自定按钮的顺序
	$.each(customToolbar, function(m, csObj){
		if($.type(csObj) == 'string' && csObj != "-"){
			customToolbar[m] = barbtnJson[csObj];
			d2.push(csObj);
		}
	});
	
	// 页面传入参数，决定默认的按钮哪些需要显示
	var myToolbar = paramJson.myToolbar ? paramJson.myToolbar : ['delete', 'search', 'export', 'reload'];
	if(myToolbar != null && myToolbar.length){
		var d2Str = d2.join(",");
		$.each(myToolbar, function(n, btnName){
			if(d2.length && d2Str.indexOf(btnName) != -1) return true;
			customToolbar.push(barbtnJson[btnName]);
			customToolbar.push('-');
		});
	}

    // 初始化datagrid
    this.initGrid(gridObject, defaultGridinitJson, paramJson.beforeSendFn, paramJson.afterSuccessFn);
    // 创建查询form表单
    this.createSerachForm(paramJson, tdomId);
    
}

createQDatagrid.prototype.export2Excel = function(paramJson,typeAction){
    try{
        var othis = this;
        var gridObject = paramJson.gridObject;
        var basicGridParam = $(gridObject).data('basicGridParam');
        var tdomId = $(gridObject).attr('id');
        
		var frozenTs = paramJson.gridJson.frozenColumns;
		var frozenCols = frozenTs && frozenTs.length  ? frozenTs[0] : [];
        var fixCols = (paramJson.gridJson.columns)[0];
		var arr = (frozenCols && frozenCols.length ? frozenCols : []).concat(fixCols);
        
        var names = [];
        var colums = [];
        for(var i=0; i<arr.length; i++){
            var obj = arr[i];
            if(obj.hidden || obj.show) continue;
            if(!obj.hidden){
                names.push(obj.title);
                colums.push(obj.field);
            }
        }
        // excel表格的抬头和对应的数据库表字段
        var data = {
            'colNames':names.join(','),
            'colatrrs':colums.join(',')
        };
        // 查询表单输入input值序列化
        var paramStr = "";
         var formInputJson = {};
        if(typeAction == 'searchAndExport'){
            paramStr = $(othis.searchForm).serialize();
            // 字符串转换成json对象
            formInputJson = QUtil.url2json(paramStr);
        }

        // 把搜索查询条件加入到参数，使导出的结果和查询的结果一致，而不是导出全部的数据
        $.extend(true, data, formInputJson);
        // 合并查询参数，一起合并表格初始化的部分参数，如果boName，url
        $.extend(true, data, basicGridParam);
        //for(var p in data) alert(p+'='+data[p]);
        QUtil.exportDataSetToExcel({'data':data,url:null}, tdomId);
    }catch(e){
        isdebug ? alert('export2Excel:\n'+e.message) : null;
    }
}

// 创建自定义数据表格
createQDatagrid.prototype.initGrid = function(gridObject, initGridParamJson, beforeSendFn, afterSuccessFn){
    try{
        var othis = this;
        if(gridObject){
			if(this.isTreeGrid){
				$(gridObject).treegrid(initGridParamJson); 
			}else{
				$(gridObject).datagrid(initGridParamJson); 
			}
            //设置分页控件  
            var p = this.isTreeGrid ? $(gridObject).treegrid('getPager') :$(gridObject).datagrid('getPager');
            $(p).pagination({
                onChangePageSize:function(pageNumber, pageSize){
					//如果页面改变了默认的每页显示条数，不会自动更新basicGridParam里面的参数，所以需要手动更新
					var basicGridParam = $(gridObject).data('basicGridParam');
					basicGridParam = basicGridParam ? basicGridParam : {};
					basicGridParam.pageSize = basicGridParam.rows = pageSize;
					$(gridObject).data('basicGridParam', basicGridParam);
                    // 读取缓存中的查询参数
                    var gridQueryParamJson = $(gridObject).data('gridQueryParamJson');
                    gridQueryParamJson = gridQueryParamJson ? gridQueryParamJson : {};
                    gridQueryParamJson.rows = gridQueryParamJson.pageSize = pageSize;
					$(gridObject).data('gridQueryParamJson', gridQueryParamJson);
                },
                showRefresh:true,
                showPageList:true,
                pageSize : othis.defaultPageSize,//每页显示的记录条数，默认为10  
                pageList : [ 5, 10, 20,50,100,150,200 ],//可以设置每页记录条数的列表  
                beforePageText : '第',//页数文本框前显示的汉字  
                afterPageText  : '页  共{pages}页',
                displayMsg     : '当前显示[{from}-{to}]条记录  共{total}条记录'
            });
            
        }
    }catch(e){
        isdebug ? alert('createQDatagrid(initGrid):\n'+e.message) : null;
    }   
}

// 创建自定数据表格 - 查询window
createQDatagrid.prototype.createSerachWindow = function(gridObject, wincloseFn, winopenFn, winW, winH, tdomId, fnJson){
    try{
        var othis = this;
        // 查询窗口关闭按钮单击前执行,返回true时，默认的关闭方法会继续执行 or 只执行这个方法；可选
        var winBeforeClickCloseBtnFn = fnJson.winBeforeClickCloseBtnFn;
        
        // 查询窗口搜索按钮单击前执行，返回true继续 or 停止；可选
        var winBeforeClickSearchBtnFn = fnJson.winBeforeClickSearchBtnFn;
        // 查询窗口搜索按钮单击时执行，返回true时，默认的搜索方法会继续执行 or 只执行这个方法；可选
        var winWhenClickSearchBtnFn   = fnJson.winWhenClickSearchBtnFn;
        // 编辑窗口保存按钮单击前执行，返回true继续 or 停止；可选
        var winBeforeClickSaveBtnFn   = fnJson.winBeforeClickSaveBtnFn;
        // 编辑窗口保存按钮单击时执行；可选
        var winWhenClickSaveBtnFn     = fnJson.winWhenClickSaveBtnFn; 
        
        var winWidth  = winW ? winW : $('body')[0].clientWidth;
        var winHeight = winH ? winH : $('body')[0].clientHeight;
        var btnBarHeight = 30;
        if(!this.winDiv){
           var winDiv = document.createElement('div'); 
           this.winDiv = winDiv;
           $(this.container).append(winDiv);               
           var searchForm = this.searchForm = document.createElement('form');
           var winBtnDiv  = this.winBtnDiv  = document.createElement('div');
           var searchBtn = document.createElement('button');
           var clearBtn  = document.createElement('button');
           $(searchBtn).html('查询').linkbutton({
                'iconCls':'icon-search'
           }).bind('click',queryForm);
           
           function queryForm(actionType){
                // 查询窗口搜索按钮单击前执行，返回true继续 or 停止；
                if(winBeforeClickSearchBtnFn && jQuery.type(winBeforeClickSearchBtnFn) == "function" && !winBeforeClickSearchBtnFn()){
                    return;
                }
                // 查询窗口搜索按钮单击时执行，返回true时，默认的搜索方法会继续执行 or 只执行这个方法
                var continueSearch = true;
                if(winWhenClickSearchBtnFn && jQuery.type(winWhenClickSearchBtnFn) == "function"){
                    continueSearch = winWhenClickSearchBtnFn();
                }
                //alert("continueSearch="+continueSearch);
                // 返回true时，默认的搜索方法会继续执行 or 只执行这个方法
                if(continueSearch){
                    var requestInputObjArr = $(othis.searchForm).find('[request=true]');
                    if(requestInputObjArr && requestInputObjArr.length>0){
                        for(var i=0; i<requestInputObjArr.length; i++){
                            var obj = requestInputObjArr[i];
                            if(!$(obj).val()){
                                alert("["+$(obj).attr('title')+"]为必填项，不能为空");
                                $(obj).focus();
                                return;
                            }
                        }
                    }
                    var paramStr = $(othis.searchForm).serialize();
                    var paramJson = QUtil.url2json(paramStr);
                    // 把查询条件缓存起来，供分页或者刷新等按钮使用
                    var gridQueryParamJson = $(gridObject).data('gridQueryParamJson');
                    $.extend(gridQueryParamJson, paramJson);
                    //for(var p in paramJson) alert(p+'='+paramJson[p]); 
                    /*
                    paramJson = jQuery.extend(paramJson,{
                        showMsg:true,
                        callbackFn:function(a,b,c){
                            alert('callbackFn\na='+a+'\nb='+b+'\nc='+c);
                            $(winDiv).window('close');  
                        },
                        afterSuccess:function(a,b,c){
                            alert('afterSuccess\na='+a+'\nb='+b+'\nc='+c)
                        }
                    });
                    */
                    QUtil.loadGrid({
                        // 传入的查询参数； 可选
                        param:paramJson,
                        // 表格对象
                        gridObject:gridObject,
                        showMsg:true,
                        callbackFn:function(data){
                            if(data && data.rows && data.rows.length==0){
                               $(clearBtn).trigger('click')
                            }else{
                                $(winDiv).window('close'); 
                                // searchAndExport
                                if(actionType == 'searchAndExport'){
                                    //alert(othis.customParamJson)
                                    othis.export2Excel(othis.customParamJson, 'searchAndExport');
                                }
                            }
                        }
                    });
                    //$(winDiv).window('close');  
                }
            }
           $(clearBtn).html('清空').linkbutton({
                'iconCls':'icon-empty'
           }).bind('click',function(){
                $(othis.searchForm).find('input').val('');
                $(othis.searchForm).find('select').val('');
                $(othis.searchForm).find('textarea').val('');
                //$(searchBtn).trigger('click')
            });
            var closeWinBtn = document.createElement('button');
            $(closeWinBtn).html('关闭').linkbutton({
                'iconCls':'icon-cancel'
            }).bind('click',function(){
                $(winDiv).window('close');              
            });
           //$(winBtnDiv).attr({'style':'height:'+btnBarHeight+'px;padding:10px;text-align:center;'
           //}).append(searchBtn).append('&nbsp;&nbsp;').append(clearBtn).append('&nbsp;&nbsp;').append(closeWinBtn);
          
          $(winDiv).attr({
                'id':tdomId+'_serachWin',  
                'border':'0px',
                'style':'overflow:hidden;padding:0px;margin:0px;'
           }).append(searchForm).append(winBtnDiv);
        }
        
        $(this.winDiv).dialog({
            title:'查询',
            width :winWidth,   
            height:winHeight - 15,   
            modal:true,
            shadow:false,
            resizable:true,
            collapsible:false,
            maximizable:true,
            minimizable:false,
            border:false,
            closed:true,
            buttons:[{
                text:"查询",
                iconCls:'icon-search',
                id:tdomId+'_query_searchBtn',
                handler:queryForm
            },{
                text:"查询并导出",
                iconCls:'icon-export',
                id:tdomId+'_query_searchAndExportBtn',
                handler:function(){
                    queryForm('searchAndExport');
                }
            },{
                text:"清空",
                iconCls:'icon-empty',
                id:tdomId+'_query_clearBtn',
                handler:function(){
                    $(othis.searchForm).find('input').val('');
                    $(othis.searchForm).find('select').val('');
                    $(othis.searchForm).find('textarea').val('');
                }
            },{
                text:"关闭",
                iconCls:'icon-cancel',
                id:tdomId+'_query_cancelBtn',
                handler:function(){
                    $(winDiv).window('close'); 
                }
            }],
            onBeforeClose:function(){
                // 查询窗口关闭按钮单击前执行,返回true时，默认的关闭方法会继续执行 or 只执行这个方法；可选
                return winBeforeClickCloseBtnFn && jQuery.type(winBeforeClickCloseBtnFn) == "function" ? winBeforeClickCloseBtnFn() : true;
            },
            onClose:function(){
                if(wincloseFn && jQuery.type(wincloseFn) == "function"){
                    wincloseFn();
                }             
            },
            onOpen :function(){

                if(winopenFn && jQuery.type(winopenFn) == "function"){
                    winopenFn();
                }             
            }
        });  
        //alert($(this.winDiv).width()+'\n'+$(this.winDiv).height()+'\n'+$(winBtnDiv).height()); 
        $(searchForm).attr({
            'style':'overflow:auto;height:'+($(this.winDiv).height()-$(winBtnDiv).height()-16)+'px;width:'+($(this.winDiv).width()-2)+'px;padding:0px;margin:0px;border:0px solid #cccccc;'
        });        
    }catch(e){ 
        isdebug ? alert('createQDatagrid(createSerachWindow):\n'+e.message) : null;
    }   
}

// 创建自定数据表格 - 查询form表单 
createQDatagrid.prototype.createSerachForm = function(paramJson, tdomId){
    try{
        var othis = this;
        var gridObject = paramJson.gridObject;
        var gridJson   = paramJson.gridJson;
        // 查询窗口关闭时执行；可选
        var wincloseFn = paramJson.wincloseFn;
        // 查询窗口打开时执行；可选
        var winopenFn  = paramJson.winopenFn;              
        var winW = paramJson.winWidth;
        var winH = paramJson.winHeight;
        // 表格查询列
		
		var frozenTs = paramJson.gridJson.frozenColumns;
		var frozenCols = frozenTs && frozenTs.length  ? frozenTs[0] : [];
        var fixCols = gridJson.columns[0];
		var qCols = (frozenCols && frozenCols.length ? frozenCols : []).concat(fixCols);
		
        var queryColumn = paramJson.queryColumn ? paramJson.queryColumn : qCols;
        if(gridObject){     
            this.createSerachWindow(gridObject, wincloseFn, winopenFn, winW, winH, tdomId, paramJson)
            var formArr = QUtil.getDatagridColunmFormArr(queryColumn, tdomId);
            var table = document.createElement('table');
            $(table).addClass("ListTable").attr('align','center').css('border','0');
             var winWidth = $(this.winDiv).width();
             var colw = 350;
             var colcount = 2;
            // 根据窗口的宽度计算一行放几列
            //alert(Math.floor(winWidth/colw));
            if(winWidth){
                // 返回小于等于数字参数的最大整数，对数字进行下舍入, Math.floor(5.99) => 5
                colcount = Math.floor(winWidth/colw);
                //alert(winWidth+','+colw+'\n'+colcount)
            }         
			
            $(this.searchForm).append(table);
			$(table).css("width", $(this.searchForm).width()-30);
            if(formArr && formArr.length > 0){
                var curTr = null;
                $.each(formArr,function(i, json){
                    //alert(i%2+'\n'+json.type+'\n'+json.text+'='+json.name);
                    //alert(othis.searchForm.innerHTML)
                    var type = json.type;
                    if(i%colcount == 0){
                        curTr = document.createElement('tr');
                        $(table).append(curTr);
                    }
                    if(json.request){
                        $(curTr).append("<td class='EditHead' nowrap>"+json.text+"<font color='red'>*</font></td>");
                    }else{
                        $(curTr).append("<td class='EditHead' nowrap >"+json.text+"</td>");
                    }
                    var td = document.createElement('td');
                    $(curTr).append(td);
                    var inputObj = document.createElement('input');
                    $(td).attr('class','editTd');
                    if(type){
                        type = type.toLowerCase();
                        if(type == 'date'){
                             //$(inputObj).bind('click', calendar);
                        }else if(type == 'custom' && json.target){
                            // 自定输入列 
                            inputObj = json.target;
                        }
                    }
                    $(td).append(inputObj);
                    if(json.target){
                        // 自定义的输入框，name自己指定，不能用默认的name
                        var tinputObj = $(json.target).find('input')[0];
                        $(tinputObj).attr({
                            'title':json.text,
                            'request':json.request
                        }); 
                    }else{
                        $(inputObj).addClass('noborder').attr({
                            'id'  :json.id,
                            'name':json.name,
                            'title':json.text,
                            'request':json.request
                        }); 
                    }                   
                });
            }
        }
    }catch(e){
        isdebug ? alert('createQDatagrid(createSerachForm):\n'+e.message) : null;
    }   
}

// 根据查询条件，刷新表格
createQDatagrid.prototype.refresh = function(cusParam){
    try{
        var gridObject = this.gridObject;
        if(!gridObject) return;
        // 读取前一次查询时的参数。如果：上次单击树形是的nodeId；或者上次form查询时的表单数据
        //var refreshPJson = $(gridObject).data('gridQueryParamJson');
        // 此处刷新为加载basicGridParam为参数的结果集，分页的刷新包括查询form中的数据
        var basicGridParam = $(gridObject).data('basicGridParam');
        
        // 加入列排序字段
        var sort = $(gridObject).data('qSort');
        var order = $(gridObject).data('qOrder');
        var sortJson = sort && order ? { 'sort':sort, 'order':order} : {};
        basicGridParam =basicGridParam ? basicGridParam: {};
        //for(var p in refreshPJson) alert(p+'='+refreshPJson[p]);
		cusParam = cusParam ? cusParam : {};
        $(gridObject).datagrid('load', jQuery.extend({},basicGridParam, sortJson, cusParam));
        return;
        
        QUtil.loadGrid({
            // 传入的查询参数； 可选
            param:jQuery.extend({},basicGridParam, sortJson, cusParam),
            // 表格对象
            gridObject:gridObject
        });
    }catch(e){
        isdebug ? alert('createQDatagrid.refresh:\n'+e.message) : null;
    }
}

createQDatagrid.prototype.getGridObj = function(){
    try{
        return this.gridOjbect;
    }catch(e){
        isdebug ? alert('getGridObj:\n '+e.message) : null;
    }
}

// 获得当前datagrid的pageNumber,pageSize
createQDatagrid.prototype.getPageOption = function(){
    try{
        //设置分页控件  
        var p = this.isTreeGrid ? $(this.gridObject).treegrid('getPager') : $(this.gridObject).datagrid('getPager');
        return $(p).pagination('options');
    }catch(e){
        isdebug ? alert('getPageOption:\n '+e.message) : null;
    }
}

// 设置表格的查询参数
createQDatagrid.prototype.setGridQueryParams = function(gridQueryParamJson){
    try{ 	
        var gridObject = this.gridObject;
        if(gridObject && gridQueryParamJson){
            // 从缓存中读取记录bo，请求的类和方法等基本信息,json格式
            var basicGridParam = $(gridObject).data('basicGridParam');
	        gridQueryParamJson = jQuery.extend(basicGridParam,(gridQueryParamJson ? gridQueryParamJson : {}));
	        $(gridObject).data('gridQueryParamJson',gridQueryParamJson);
			var gridOptions = this.isTreeGrid ? $(gridObject).treegrid('options') : $(gridObject).datagrid('options');
	        gridOptions.queryParams = gridQueryParamJson;
        }
    }catch(e){
        //alert('setGridQueryParams - '+e.message);
    }
}

// 设置表格基础查询参数basicGridParam
createQDatagrid.prototype.setBasicGridParams = function(paramJson){
    try{ 	
        var gridObject = this.gridObject;
        if(gridObject && paramJson){
            // 从缓存中读取记录bo，请求的类和方法等基本信息,json格式
            var basicGridParam = $(gridObject).data('basicGridParam');
	        var tmpJson = jQuery.extend(basicGridParam,(paramJson ? paramJson : {}));
	        $(gridObject).data('basicGridParam',tmpJson);
            $(gridObject).data('gridQueryParamJson',tmpJson);
			var gridOptions = this.isTreeGrid ? $(gridObject).treegrid('options') : $(gridObject).datagrid('options');
	        gridOptions.queryParams = tmpJson;
            //for(var p in tmpJson) alert("setBasicGridParams:\n"+p+'='+tmpJson[p])
        }
    }catch(e){
        isdebug ? alert('setGridQueryParams:\n'+e.message) : null;
    }
}

// 设置表格上方按钮名称 index为按钮的下标从1开始；newName按钮的新name；
createQDatagrid.prototype.setBtnName = function(index, newName){
    return QUtil.setGridBtn(this.gridObject, [{
                'index':index,
                'name':newName
            }]);
}

// 设置表格上方按钮图标样式 index为按钮的下标从1开始；icon为按钮样式 eg：add, remove, edit,cut, cancel, ok；
createQDatagrid.prototype.setBtnIcon = function(index, icon){
    return QUtil.setGridBtn(this.gridObject, [{
                'index':index,
                'icon':icon
            }]);
}

// 设置表格上方按钮状态，隐藏或者显示  index为按钮的下标从1开始；flag=true:显示， false：隐藏
createQDatagrid.prototype.setBtnDisplay = function(index, flag){
    return QUtil.setGridBtn(this.gridObject, [{
                'index':index,
                'display':flag
            }]);
}

createQDatagrid.prototype.setBtnDisabled = function(index, flag){
    return QUtil.setGridBtn(this.gridObject, [{
                'index':index,
                'disabled':flag
            }]);
}

createQDatagrid.prototype.batchSetBtn = function(arr){
    return QUtil.setGridBtn(this.gridObject,arr);
}


// 入口 : 创建树  初始化  注册事件
function showSysTree(targetElement, treeOption){
    // 获得hidde input 和 显示input，分别用来存放树形的ids(dms)，和names(mcs)
    //if(targetElement && targetElement.nodeName === 'IMG'){
    if(targetElement){
        
    	/*设置嵌入式插件container， <div  region='west'>里面不能包含任何对象，否者宽度不能随外边容器改变而改变
    	 * 现在折中办法，不对jsp进行修改，在js中统一判断，如果 <div  region='west'>下面包含div或者其它的容器，删除，把容器设置
    	 * 为 <div  region='west'>，并设置最小宽度
        <div  region='west' split="true" style="overflow:auto;width:280px;height:450px;">	
			<div id='orgTree'></div>
		</div>  
		*/
        if($(treeOption.container).parent().attr('region')){
            treeOption.jqTreeId = $(treeOption.container).attr('id');
            treeOption.container = $(treeOption.container).parent()[0];
            $(treeOption.container).empty();
        }
        
        // qfucee, 2016.3.21, 判断layout west, east的宽度是不是占据了整个页面宽度，自动调整他们的宽度    
        if(treeOption.container){
            var bodyW = $('body').width();
            var curLTWidth = $(treeOption.container).width();
            var layoutObj = $(treeOption.container).parents('.easyui-layout');
            if(layoutObj && layoutObj.length){
                // 大于页面宽度的90%就调整其宽度
                if(curLTWidth > bodyW * 0.9){           
                    var leftTreeWidth = 300;
                    var offsetWidth = leftTreeWidth * 0.1;
                    var leftTreeWidthMax = bodyW * 0.25;
                    leftTreeWidthMax = leftTreeWidthMax > leftTreeWidth ? leftTreeWidth + offsetWidth: leftTreeWidthMax;
                    var treeRegionWith = curLTWidth > leftTreeWidthMax ? leftTreeWidthMax : (curLTWidth < leftTreeWidth ?  leftTreeWidth : curLTWidth);
                    var treeRegion = $(treeOption.container).attr('region');
                    layoutObj.layout('panel', treeRegion).panel('resize',{
                        width:treeRegionWith
                    });
                }
                var eastRegion = layoutObj.find("[region='east']");
                if(eastRegion && eastRegion.length == 1 && eastRegion.width() > bodyW * 0.9){
                    layoutObj.layout('panel', "east").panel('resize',{
                        width:bodyW * 0.25
                    });                       
                }                          
            }
        }

        // 树节点单击时执行
        var onTreeClick = jQuery.type(treeOption.onTreeClick)  == "function" ? treeOption.onTreeClick : null;
        // 单击”确定“按钮前执行的方法
        var onBeforeSure = jQuery.type(treeOption.onBeforeSure)  == "function" ? treeOption.onBeforeSure : null;
        // 单击”确定“按钮后执行的方法
        var onAfterSure  = jQuery.type(treeOption.onAfterSure)  == "function" ? treeOption.onAfterSure : null;
        // 窗口打开前执行
        var onBeforeLoad = jQuery.type(treeOption.onBeforeLoad) == "function" ? treeOption.onBeforeLoad: null;
        // 控件点开后第一次调用的方法
        var onInit = jQuery.type(treeOption.onInit) == "function" ? treeOption.onInit: null;
        // 控件每次点开在tree和grid都没哟初始化前调用，每次点开都要调用
        jQuery.type(treeOption.onPerOpen) == "function" ? onPerOpen() : null;
        
        // 窗口的标题
        var title  = treeOption.title ;     
        // 窗口的高度和宽度
        var height = treeOption.height ? treeOption.height > 420 ? 420 : treeOption.height : 370;
        var width  = treeOption.width  ? treeOption.widht  : 760;      	
        // 判断是仅是机构树形还是树形+人员列表
        var type   = treeOption.type  ? treeOption.type  : 'tree';
        type === 'tree' ? null : height = 405;
        var treeHeight = type === 'tree' ? height - 71 : height;
        ///alert(height);
        // 得到用来最终存储节点id和name名称的input对象
        var inputObj   = QUtil.getRealInputAndHiddenInput(targetElement);
        var idsInput   = inputObj.idsInput;
        var namesInput = inputObj.namesInput;
        var assId = inputObj.assId;
        
        // 是否缓存
        //var cache = jQuery.type(treeOption.cache)=='boolean' ? treeOption.cache: true;
        var cache = QUtil.string2boolean(treeOption.cache, true);
        
        //alert(idsInput.value+'\n '+namesInput.value);
        //alert(idsInput.id+' -- '+namesInput.id +' -- assId:'+assId)
        // 如果有选人界面是，表格是否为单选
        treeOption.isEmployeeRadio = treeOption.singleSelect ?  true : false;
        // 左侧树形的数据集
        var treeData = treeOption.treeData ? treeOption.treeData : null;
        // 树形url后的参数
        var treeParam = treeOption.param ? treeOption.param : (treeOption.treeParam ? treeOption.treeParam : {});
        // 右侧grid传入的参数
        var gridParam =  treeOption.gridParam ? treeOption.gridParam : {};
        // 仅限于组织机构树和登陆人员表格
        var defaultDeptId = null, defaultUserId = null;
        // 树形节点是否逐级加载，默认为true， 如果为false则一次性全部加载完毕
        var lazyBool = true;
        if(treeParam){
            var lazy = treeParam.lazy ;  
            if(lazy == null || lazy == undefined){
                lazyBool = true;
            }else if(lazy == false || lazy == 'false' || lazy == '0'){
                lazyBool = false;
            }
			
			/*
			* add by qfucee,  2017.2.9, 是否使用服务器缓存, 默认值true
			*/
			var serverCache = treeParam.serverCache;
			//serverCache = serverCache == undefined ? true : serverCache ? Boolean(serverCache) : false;
			serverCache = QUtil.string2boolean(serverCache, true);
			treeParam.serverCache = serverCache;
			
			/*
			* add by qfucee,  2017.2.16, 是否使用oracle数据库的特性来加快树形节点加载, 默认值true
			*/
			var isOracle = treeParam.isOracle;
			//isOracle = isOracle == undefined ? true : isOracle ? Boolean(isOracle) : false;
			isOracle = QUtil.string2boolean(isOracle, true);
			treeParam.isOracle = isOracle;
			
			var plugId = treeParam.plugId;
			treeParam.plugId = plugId ? plugId : treeParam.beanName;
			
            var beanName = treeParam.beanName;
            if(beanName && !treeOption.treeTabTitle1){
                var tabTitle = "";
                beanName = beanName.toLowerCase();
                if(beanName.indexOf('auditingobject') != -1){
                    tabTitle = '被审计单位';
                }else if(beanName.indexOf('organization') != -1){
                    tabTitle = '组织机构';
                }else if(beanName.indexOf('audTask') != -1){
                    tabTitle = '审计事项';
                }else if(beanName.indexOf('ledgertemplate') != -1){
                    tabTitle = '审计问题';
                }else if(beanName.indexOf('assistsuportLaws') != -1){
                    tabTitle = '法律法规';
                }else if(beanName.indexOf('codeandname') != -1){
                    tabTitle = '系统码表';
                }else if(beanName.indexOf('assistsuportLaws') != -1){
                    tabTitle = '法律法规';
                }else if(beanName.indexOf('promember') != -1){
                    tabTitle = '项目组成员';
                }
                treeOption.treeTabTitle1 = tabTitle;
            }
        }
        if(type != 'economyDuty'){
            //defaultDeptId = "90FFDA39-AE83-65DA-CB05-E5C3B31942AF";//海淀
            //defaultUserId = "testk";
            defaultDeptId = treeOption.defaultDeptId ? treeOption.defaultDeptId : "";
            defaultUserId = treeOption.defaultUserId ? treeOption.defaultUserId : "";
        }
        treeOption.treeTabTitle1 = type != 'tree' && !treeOption.treeTabTitle1 ? '组织机构' : treeOption.treeTabTitle1;
        // 默认为机构树；如果是被审计单位树，定位树形节点时查询本级本上级节点id的url；
        //alert(treeOption.priorUrl+'\n'+treeOption.url+'\n'+treeOption.url.indexOf("/mng/audobj/object/getAuditedDeptChildByDeptId"))
        if(!treeOption.priorUrl 
            &&  treeOption.url 
            && treeOption.url.indexOf("/mng/audobj/object/getAuditedDeptChildByDeptId") != -1){
            treeOption.priorUrl = "getPriorAud";
        }
        //var allleaf = (treeOption.allleaf != null || treeOption.allleaf != undefined) ? treeOption.allleaf : false;
        
        var allleaf = QUtil.string2boolean(treeOption.allleaf, false);
        
        treeOption.onlyLeafClick = allleaf ? true : QUtil.string2boolean(treeOption.onlyLeafClick, false);
        
        // 根据分配的assId从缓存中拿出一个预制窗口对象
        var winJson = QUtil.getWin({ 
            'customRoot':treeOption.customRoot ? treeOption.customRoot : "",
            'allleaf':allleaf,
            'treeUrl':treeOption.url,
            'treeParam':treeParam,
            'gridParam':gridParam,
            'lazy':lazyBool,
            'assId':assId,
            'type' :type,
            // 根据指定id，获得本级和本上级节点的id的url
            'priorUrl'  :treeOption.priorUrl,
            'treeCheckbox':treeOption.checkbox,
            'showTabTools':treeOption.showTabTools == undefined ? true : treeOption.showTabTools,
            'container' :treeOption.container,
            'jqTreeId' :treeOption.jqTreeId,
            'treeTabTitle1':treeOption.treeTabTitle1,
            'treeTabTitle2':treeOption.treeTabTitle2,
            'onlyLeafClick':treeOption.onlyLeafClick,
            'queryBox':treeOption.queryBox,
            'treeQueryBox':treeOption.treeQueryBox,
            'gridQueryBox':treeOption.gridQueryBox,
            'idsInput'  :idsInput,
            'namesInput':namesInput,
            'defaultDeptId'  :defaultDeptId,
            'defaultUserId'  :defaultUserId,
            'isEmployeeRadio':treeOption.isEmployeeRadio,
            'onAfterSure' :onAfterSure,
			'onBeforeSure':onBeforeSure,
            'onBeforeLoad':onBeforeLoad,
            'onInit':onInit
        });
        
        if(winJson){     
            $(idsInput).data('target',winJson);
            var winOption = winJson.win.param;
			var jqtreeSelectGrid = winOption.jqtreeSelectGrid;
            winOption.checkbox = treeOption.checkbox;
            winOption.onlyLeafClick = treeOption.onlyLeafClick;
            winOption.msgPrompt = treeOption.msgPrompt;
            winOption.type = type;
            winOption.defaultDeptId = defaultDeptId;
            winOption.defaultUserId = defaultUserId;
            // 是否展开第一级根节点
            winOption.expandFirstRoot = QUtil.string2boolean(treeOption.expandFirstRoot, true);
            // treeOption.expandFirstRoot == undefined ? true : treeOption.expandFirstRoot ? Boolean(treeOption.expandFirstRoot) : false;
            winOption.onAfterSure  = onAfterSure;
			winOption.onBeforeSure = onBeforeSure;
            winOption.onBeforeLoad = onBeforeLoad;
            winOption.onTreeClick  = onTreeClick;
            //alert(onAfterSure +' '+onBeforeLoad +' '+ winOption);
            //alert(winOption.onAfterSure +' '+winOption.onBeforeLoad);
            // 打开窗口,resize窗口
            if(!treeOption.container){
                $(winOption.winWrap).window('open');
                $(winOption.queryInput).focus();
                title ? $(winOption.winWrap).window('setTitle',title) : null;
                //alert($(document.body).height() +','+$(document.body)[0].clientHeight)
                var isFixed = $(winOption.winWrap).parent("div[class*='window']").css('position') == 'fixed' ? true :  false;
                $(winOption.winWrap).window('resize',{
                    'width' :width,
                    'height':height,
                    'left'  :(document.body.clientWidth  || document.documentElement.clientWidth  )/2 - width/2    + (isFixed ? 0 : $(document.body || document.documentElement).scrollLeft()),
                    'top'   :(document.body.clientHeight || document.documentElement.clientHeight )/2 - height/2   + (isFixed ? 0 : $(document.body || document.documentElement).scrollTop())
                });
                $(winOption.treeWrap).css('height',treeHeight);
                //$(winOption.layout).layout('resize');
            }
            //alert(winOption.getDefaultTreeUrl);
            // 第一次初始化时，初始化加载树形
            var treeInit = $(winOption.jqtree).data('treeInit') || $(targetElement).attr('isLoaded');
            //alert('treeInit:'+treeInit)
            if(!treeInit  || !cache){// true: 说明控件已经加载过了
               // 被审计单位代码,当处在编辑模式时，根据给定的机构代码，初始化树形控件
               var treeUrlParamStr = '';
               var treeUrl =  treeOption.url ? treeOption.url : winOption.getDefaultTreeUrl;
               //alert(treeUrl)
               if(treeParam){
                    var tmp = [];                  
                    // url中没有问号
                    if(treeUrl.indexOf('?') == '-1'){
                        tmp.push("?1=1");
                    }else{
                        tmp.push("&1=1");
                    }
                    // departmentId,auditedOrgIds
                    for(var p in treeParam){
                        if(p == 'auditedOrgIds'){
                            var adms = treeParam[p] ? treeParam[p].split(',') : [];
                            var finalAdm = [];
                            // 给每个被审计单位代码加上引号
                            $.each(adms,function(i, id){
                                var t = [];
                                t.push("'");
                                t.push(id);
                                t.push("'");
                                finalAdm.push(t.join(''));
                            });
                            if(finalAdm && finalAdm.length > 0){
                                tmp.push('&auditedOrgIds=');
                                tmp.push(finalAdm.join(','));
                            }
                        }else{
                            tmp.push('&');
                            tmp.push(p);
                            tmp.push('=');
                            tmp.push(treeParam[p]);
                        }
                    }
                    treeUrlParamStr = tmp.join('');
                    //alert(treeUrlParamStr)
               }
                // 如果指定了结果集，则不请求url
                treeUrl =  treeData ?  '' : treeUrl+treeUrlParamStr;
                //alert(treeUrl);
                // 树形是否可以选择本上级,如果为true，那么tree一定是多选的 
                var cascadePrior = treeOption.cascadePrior ? true : false;
				treeOption.cascadePrior = cascadePrior;
                // 选择属性的本级和下级
                var cascadeJunior  = treeOption.cascadeJunior ? true : false;
				treeOption.cascadeJunior = cascadeJunior;
                //cascadeExpand: true: 展开当前节点下的所有节点（为了性能默认展开节点不超过4层）, 默认：false
                var cascadeExpand = treeOption.cascadeExpand ? treeOption.cascadeExpand : false;
				//alert(cascadePrior +','+ cascadeJunior)
                if(cascadePrior || cascadeJunior){
                    treeOption.checkbox = true;
                    treeOption.cascadeCheck = false;
                    treeOption.cuscascade = true;
                }else{
					treeOption.cuscascade = false;
				}

                //alert(encodeURI(encodeURI(treeUrl)))
                winOption.treeUrl  = treeUrl;
                winOption.treeData = treeData;
                $(winOption.jqtree).tree({
                    url     : encodeURI(encodeURI(treeUrl)),
                    loadFilter:function(data,parent){
                        //alert(data);
                        // 对返回的节点进行二次过滤
                        if(jQuery.type(treeOption.onTreeLoadFilter) == "function"){
                            return treeOption.onTreeLoadFilter(data,parent);
                        }else{
                            return data;
                        }
                    },
                    // 是否显示复选框
                    checkbox:treeOption.checkbox ? treeOption.checkbox : false,
                    // 是否动画形式展开
                    animate :treeOption.animate  ? treeOption.animate  : false,
                    // 是否级联复选
                    cascadeCheck:treeOption.cascadeCheck ? treeOption.cascadeCheck : false,
                    // 是否只有子节点可以复选，onlyLeafCheck
                    onlyLeafCheck:treeOption.onlyLeafCheck ? treeOption.onlyLeafCheck : false,
                    // 节点层级连接线
                    lines   :true,
                    dnd:treeOption.dnd ? treeOption.dnd : false,
                    cuscascade:treeOption.cuscascade,
                    onLoadSuccess:function(node,data){
                       //alert(node ? node.text : 'node is null when loadSuccess')
                       QUtil.treeNodeLoadSuccess(node,data,cache,treeOption,winOption,treeParam,idsInput);
                       jQuery.type(treeOption.onTreeLoadSuccess) == "function" ? treeOption.onTreeLoadSuccess(node,data): null;
                       $(targetElement).attr('isLoaded', true);
                    },
                    onClick:function(node){  
                        cascadeExpand ? QUtil.expandOrCollapseAllNodes(winOption.jqtree, node) : null;
                        QUtil.treeNodeClick(this, node, type, winJson, winOption, winOption.jqtree);                        
                    },
                    // 当单击复选框时触发 选择本级和本上级
                    onCheck:function(node,checked){
                        try{
							$(winOption.jqtree).data('isCheckNodeChanged', true);
                            var cuscascade = $(winOption.jqtree).tree('options').cuscascade;
                            if(!cuscascade) return;
                            var jqtree = winOption.jqtree;
                            // 标记是否选中本级，本上级，本下级
							var cascadePrior  = $(winOption.jqtree).tree('options').cascadePrior;
							var cascadeJunior = $(winOption.jqtree).tree('options').cascadeJunior;
                            //alert("cuscascade="+cuscascade+"\ncascadePrior="+cascadePrior +'\ncascadeJunior='+ cascadeJunior);
							//return;
                            if(cascadePrior || cascadeJunior){
                                var nodeId = node.id;
                                var curNodeId = $(jqtree).data('myCheckNodeId'); 
                                !curNodeId ? ($(jqtree).data('myCheckNodeId', nodeId),curNodeId = nodeId) : null;
                                /* 
                                避免循环递归（每次parentNode checked都会执行oncheck方法），只在当前单击节点执行下面的循环
                                即：checkbox选中，只会在节点单击后（单击后会自动展开下面所有节点），延迟一段事件后，
                                    选中或者取消节点
                                */
                                //alert(nodeId +"\n"+ curNodeId)
                                if(nodeId == curNodeId){
                                    var timer = 200;
                                    // 节点已经加载过了，延时timer就可以为0，否则默认延迟
                                    var isLoaded = $(node).data('isLoaded');
                                    //alert('isLoaded1='+isLoaded)
                                    var nodelazy = $(winOption.jqtree).data('nodelazy');
                                    //alert('nodelazy1='+nodelazy)
                                    if(nodelazy == null || nodelazy == undefined || nodelazy == ""){
                                        var nodeAttr = node.attributes;
                                        //alert('nodeAttr='+nodeAttr)
                                        if(nodeAttr){
                                            try{
                                                var attrJson = $.parseJSON(nodeAttr);
                                                nodelazy = attrJson.lazy;
                                                //alert('nodelazy='+nodelazy)
                                                if(!(nodelazy == null || nodelazy == undefined || nodelazy == "")){
                                                    $(winOption.jqtree).data('nodelazy', nodelazy);

                                                }
                                            }catch(e){
                                                //alert('parse tree attribute:\n'+e.message);
                                            }
                                        }  
                                    }

                                    timer = nodelazy == false || nodelazy == "false" ? 0 : timer;
                                    isLoaded = timer == 0 ? true : false;
                                    $(node).data('isLoaded', true);
                                    
                                    // 复选时, 展开选中节点下的所有节点；
                                    if(checked){
                                        QUtil.expandOrCollapseAllNodes(jqtree, node);
                                    }
                                    //alert('isLoaded='+isLoaded)
                                    if(isLoaded || $(jqtree).tree('isLeaf', node.target)){// 加载过直接check or uncheck
                                        setNodeCheck(0);
                                    }else{// 延迟加载的给出提示
                                        if(treeUrl.indexOf('/commonPlug') > 0){
                                            /*top.$.messager.confirm('确认', '数据(树节点)是否已经加载完毕？',function(r){
                                                r ? setNodeCheck(0) : null;
                                            }); 
                                        }else{*/
                                            setNodeCheck(0)
                                        }
                                        
                                    }
                                    function setNodeCheck(timer){
                                        //alert(timer)
                                        var timeout =  window.setTimeout(function(){
                                            // 清除缓存变量
                                            $(jqtree).removeData('myCheckNodeId'); 
                                            // 如果为叶子节点则退出
                                            var childrenNodes = null;
                                            try{
                                                childrenNodes = $(jqtree).tree('getChildren',node.target);
                                            }catch(e){}
                                            if(!childrenNodes || (childrenNodes && childrenNodes.length == 0)){
                                                timeout ? window.clearTimeout(timeout) : null;
                                                return;
                                            }
                                            // 选择本下级
                                            cascadeJunior ? QUtil.checkSubNodes(jqtree, node, checked) : null;
                                            // 选择本上级
                                            cascadePrior  ? QUtil.checkPriorNodes(jqtree, node, checked) : null;
                                            timeout ? window.clearTimeout(timeout) : null;
                                        },timer); 
                                    }                                
                                } 
                            }
                        }catch(e){
                            //alert(e.message)
                        }
                        jQuery.type(treeOption.onTreeCheck) == "function" ? treeOption.onTreeCheck(node,checked): null;
                    },                           
                    onDblClick:function(node){                   	
                        // some code, 如果为单选时，双击节点可以选中并关闭选择窗口
                        if(type && type === 'tree'){
                            !treeOption.checkbox ? $(winOption.addbtn).trigger('click') : null;
                        }
                        jQuery.type(treeOption.onTreeDblClick) == "function" ? treeOption.onTreeDblClick(node): null;
                    },
                    onBeforeLoad:function(node,param){
                        jQuery.type(treeOption.onTreeBeforeLoad) == "function" ? treeOption.onTreeBeforeLoad(node,param): null;
                    },
                    onLoadError:function(arguments){
                        jQuery.type(treeOption.onTreeLoadError) == "function" ? treeOption.onTreeLoadError(arguments): null;
                    },
                    onBeforeExpand:function(node){
                        jQuery.type(treeOption.onTreeBeforeExpand) == "function" ? treeOption.onTreeBeforeExpand(node): null;
                    },
                    onExpand:function(node){
                        jQuery.type(treeOption.onTreeExpand) == "function" ? treeOption.onTreeExpand(node): null;
                    },
                    onBeforeCollapse:function(node){
                        jQuery.type(treeOption.onTreeBeforeCollapse) == "function" ? treeOption.onTreeBeforeCollapse(node): null;
                    },
                    onCollapse:function(node){
                        jQuery.type(treeOption.onTreeCollapse) == "function" ? treeOption.onTreeCollapse(node): null;
                    },
                    onBeforeCheck:function(node){
                        jQuery.type(treeOption.onTreeBeforeCheck) == "function" ? treeOption.onTreeBeforeCheck(node): null;
                    },
                    onBeforeSelect:function(node){
                        jQuery.type(treeOption.onTreeBeforeSelect) == "function" ? treeOption.onTreeBeforeSelect(node): null;
                    },
                    onSelect:function(node){
                        jQuery.type(treeOption.onTreeSelect) == "function" ? treeOption.onTreeSelect(node): null;
                    },
                    onContextMenu:function(e, node){
                        jQuery.type(treeOption.onTreeContextMenu) == "function" ? treeOption.onTreeContextMenu(e, node): null;
                    },
                    onBeforeEdit:function(node){
                        jQuery.type(treeOption.onTreeBeforeEdit) == "function" ? treeOption.onTreeBeforeEdit(node): null;
                    },
                    onAfterEdit:function(node){
                        jQuery.type(treeOption.onTreeAfterEdit) == "function" ? treeOption.onTreeAfterEdit(node): null;
                    },
                    onBeforeDrag:function(node){
                        jQuery.type(treeOption.onBeforeDrag) == "function" ? treeOption.onBeforeDrag(node): null;
                    },
                    onCancelEdit:function(node){
                        jQuery.type(treeOption.onTreeCancelEdit) == "function" ? treeOption.onTreeCancelEdit(node): null;
                    },
                    onDragLeave:function(target,source){
                        return jQuery.type(treeOption.onDragLeave) == "function" ? treeOption.onDragLeave(target,source): null;
                    },
                    onBeforeDrop:function(target,source,point){
                        return jQuery.type(treeOption.onBeforeDrop) == "function" ? treeOption.onBeforeDrop(target,source,point): null;
                    },
                    onDrop:function(target,source,point){
                        jQuery.type(treeOption.onDrop) == "function" ? treeOption.onDrop(target,source,point): null;
                    },
                    onDragEnter:function(target,source){
                        return jQuery.type(treeOption.onDragEnter) == "function" ? treeOption.onDragEnter(target,source): null;
                    },
                    onDragOver:function(target,source){
                        return jQuery.type(treeOption.onDragOver) == "function" ? treeOption.onDragOver(target,source): null;
                    }
                }); 
                // 根据treeData数据集初始化树形
                if(treeData){
                    var dms = treeData.dms;
                    var mcs = treeData.mcs;
                    var data = [];
                    // 拼接tree所需的数据格式
                    $.each(dms, function(i,dm){
                        var json = {
                            'id'  :dm,
                            'text':mcs[i]
                        };
                        data.push(json);
                    });
                    data.length > 0 ? $(winOption.jqtree).tree('loadData', data) : null;
                }
                
                // 初始化搜索结果树形
                $(winOption.jqtreeQuery).tree({
                    // 是否显示复选框
                    checkbox:treeOption.checkbox ? treeOption.checkbox : false,
                    // 是否动画形式展开
                    animate :treeOption.animate  ? treeOption.animate  : false,
                    // 是否级联复选
                    cascadeCheck:treeOption.cascadeCheck ? treeOption.cascadeCheck : false,
                    // 是否只有子节点可以复选，onlyLeafCheck
                    onlyLeafCheck:treeOption.onlyLeafCheck ? treeOption.onlyLeafCheck : false,
                    // 节点层级连接线
                    lines   :true,
                    onLoadSuccess:function(node,data){
                        //QUtil.treeNodeLoadSuccess(node,data,cache,treeOption,winOption,treeParam,idsInput);
                    },
                    onClick:function(node){
                        //QUtil.treeNodeClick(this, node, type, winJson, winOption, winOption.jqtreeQuery);
                    },
                    onDblClick:function(node){// 双击节点，根据id在左侧tab中展现并选中节点
                        var queryKey = $.trim($(winOption.queryInput).val());
                        if(QUtil.expandPriorNodeByIds(node.id,  winOption.getPriorUrl, winOption.jqtree, queryKey)){
                            // 选中第一个tab页
                            $(winOption.treeWrap).tabs('select', 0);
                            // 设置上一个 下一个状态
                            var rtArr = $(winOption.jqtree).data('queryRtTreeNodeArr');
                            if(rtArr && rtArr.length > 0){
                                var rtIndex = $(winOption.jqtree).data('queryRtTreeNodeArrIndex');
                                for(var i=0; i<rtArr.length; i++){
                                    var n = rtArr[i];
                                    if(n.id == node.id){
                                        if(rtIndex != i){
                                            rtIndex = i;
                                            $(winOption.jqtree).data('queryRtTreeNodeArrIndex', rtIndex);
                                        }                                       
                                        break;
                                    }
                                }
                                QUtil.setQuerypagingCss(winOption, rtArr, rtIndex);
                            }
                        }
                    }
                });
                
                //alert(winOption.tableInfo)
                // 按钮注册事件
                QUtil.handleEvents(winOption,idsInput,namesInput);
                //alert(winOption.tableInfo)
                // 清空表格数据
                //$(winOption.tableInfo).datagrid('loadData',{'total':0,'rows':[]});
            }else{
                // winOption 等于 winJson.win.param
                if($(winOption.tableInfo).data('isCRUD')){
                    // 选中第一个tab页, 用来触发根据页面input的值选中或者取消datagrid的记录
                    $(winOption.showSelectDataWrap).tabs('select', 1);
                    $(winOption.showSelectDataWrap).tabs('select', 0);
                }
                /*
                  2016.8.25, tree加载完毕后，第二次打开就是第一次操作的界面，如果第一次选了节点，而又没有确定更新jsp的input，
			                以后打开的树形选中的节点，就和input的值不对应了；
			                解决：不管树形是否加载完毕，每次打开树形界面都要根据页面input的节点id来初始化树形的选中情况。
                */
                var mytree = $(winOption.jqtree);
                var roots = mytree.tree("getRoots");
                if(roots != null &&  roots.length){
                    var root = roots[0];
                    var mytreeData = mytree.tree("getChildren", root.target);
                    //for(var p in mytreeData)  alert(p+"="+mytreeData[p])
                    //alert(cache+","+treeOption+","+winOption+","+treeParam+","+idsInput)
                    QUtil.treeNodeLoadSuccess(root, mytreeData, cache, treeOption, winOption, treeParam,idsInput);
                }
                
                
            } 
        }  
        return winJson;
    }
}

/*
* 创建一个显示进度条

$(function(){
    var pwin = document.createElement('div');
    var pbar = document.createElement('div');
    $(pbar).attr({
        'id':'qpbar',
        'class':'easyui-progressbar',
        'style':'width:520px;'
    });
    $(pwin).append(pbar).attr({
        'id':'qpwin',
        'title':'进度显示',
        'style':'text-align:center;padding:5px;overflow:hidden;'
    });
    $(document.body).append(pwin);
    $(pbar).progressbar({});
    $(pwin).window({
        collapsible:false,
        maximizable:false,
        minimizable:false,
        resizable  :false,
        closable   :true,
        closed     :true,
        modal      :true,
        width      :550,
        height     :65
    });
});
*/ 