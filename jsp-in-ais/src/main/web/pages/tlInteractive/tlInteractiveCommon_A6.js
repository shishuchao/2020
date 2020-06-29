/*
创建人：qfucee
V1.1
1.audEvd$validateform对数据范围进行判断时，把value转成数字parseInt再进行比较，如果不转 如a=112，b=1112，会出现b小于a的情况

V1.2
1.增加对commbobox表单提交时的校验（非JS初始化commbobox，js初始化的没有问题）；
2.自定义commbobox下拉，增加options

V1.2.1, 2018.8.7
aud$refreshHomeList添加type参数，通过type=sa对国审模块首页进行刷新，
优化对父页面、父窗口的判断，不管是单独打开一个窗口，或者一个tab，都可以刷新首页面

V1.2.2, 2018.8.13
 添加aud$resetGridRowHeight方法，解决资料清单、国审结论资料datagrid行多个附件上传，导致行高和序号高度错位。

V1.2.3, 2018.8.21
1.aud$createTopDialog默认显示加载内容进度条。

V1.2.4, 2018.8.24
1.audEvd$validateform检查表单合法性是，databox如果不符合要求，则打开日期下拉框。
*/

function audEvd$resizeWin(winId){
    var posJson = computeBodySize();
    $('#'+winId).dialog('resize',{
        width :posJson.width,
        heigth:posJson.height
    });
}

function aud$confirmSaveForm(formId, formUrl, callbackFn, isAsync, confirmMsg){
    if(audEvd$validateform(formId)){
        top.$.messager.confirm("提示信息", confirmMsg, function(r){
            if(r){
                aud$saveForm(formId, formUrl, callbackFn, isAsync, true);
            }
        });
    }
}

function aud$saveForm(formId, formUrl, callbackFn, isAsync, noCheck){
    try{
        if(formId && formUrl){
            var sendData = "";
            formId = $.trim(formId);
            if(formId.indexOf(",") != -1){
                var dataArr = [];
                $.each(formId.split(","), function(i, fid){
                    dataArr.push('#'+$.trim(fid));
                });
                sendData = $(dataArr.join(",")).serialize();
            }else{
                sendData = $('#'+formId).serialize();
            }
            var  ac = isAsync == null || isAsync == undefined || isAsync == "" || isAsync == true || isAsync == "true" ? true :  false;
            $.ajax({
                url : formUrl,
                dataType:'json',
                type: "post",
                async:true,
                data: sendData,
                beforeSend:function(){
                    var check = noCheck ? true : audEvd$validateform(formId);
                    check ? aud$loadOpen() : null;
                    return check;
                },
                success: function(data){
                    aud$loadClose();
                    callbackFn && $.type(callbackFn) === "function" ? callbackFn(data) : null;
                },
                error:function(data){
                    aud$loadClose();
                    top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
                }
            });
        }else{
            throw new Error("formId or formUrl is null.");
        }
    }catch(e){
        isdebug ? alert('aud$saveForm:\n'+e.message) : null;
    }
}

function aud$editRow(row, formId, winId, prefix){
    try{
        if(row && formId && winId){
            $('#'+winId).dialog('open');
            var form = $('#'+formId);
            for(var p in row){
                var value = row[p];
                value = value ? value : '';

                //alert(prefix+p+", "+p+'='+value)
                var jObj = form.find('#'+prefix+'_'+p);
                value = aud$handleDataType(jObj, value);
                if($(jObj).hasClass("easyui-datebox")){
                    $(jObj).datebox('setValue', value);
                }else{
                    jObj.val(value);
                    jObj.text(value);
                }
            }
        }
    }catch(e){
        isdebug ? alert('aud$editRow:\n'+e.message) : null;
    }
}

function aud$handleDataType(target, value){
    try{
        if(target && value){
            var datatype = $(target).attr('datatype');
            if(datatype == 'date'){
                if(value && value.length > 10){
                    value = value.substr(0,10);
                }
            }
        }
        return value;
    }catch(e){
        isdebug ? alert('aud$handleDataType:\n'+e.message) : null;
    }
}

function aud$viewRow(row, formId, winId, prefix){
    try{
        if(row && formId && winId){
            $('#'+winId).dialog('open');
            var form = $('#'+formId);
            for(var p in row){
                var value = row[p];
                //alert(p+"\n"+value)
                var target = form.find('#'+prefix+'_'+p);
                value = aud$handleDataType(target, value);
                value = value ? new String(value).replace(/\|/g,"</br>") : ''
                target.html(value);
                target.val(value);
                target.text(value);
            }
        }
    }catch(e){
        isdebug ? alert('aud$viewRow:\n'+e.message) : null;
    }
}

// 计算body的高度和宽度
function computeBodySize(){
    try{
        return {
            width : document.body.clientWidth  || document.documentElement.clientWidth,
            height: document.body.clientHeight || document.documentElement.clientHeight
        };
    }catch(e){
        isdebug ? alert('computeBodySize:\n'+e.message) : null;
    }
}

// 检查表单下的必填项是否已经填写，true：已经填写，false：有未填写
function audEvd$validateform(formId){
    try{
        if(formId){
            var maxMsgcount = 5;//一次最多显示错误提示条数
            var msgArr = [];
            var firstEle = null;
            formId = $.trim(formId);
            var finalFormId = "";
            if(formId.indexOf(",") != -1){
                var dataArr = [];
                $.each(formId.split(","), function(i, fid){
                    dataArr.push('#'+$.trim(fid));
                });
                finalFormId = dataArr.join(",");
            }else{
                finalFormId = "#"+formId;
            }

            $(finalFormId).find('.editElement').each(function(i){
                if(msgArr.length >= maxMsgcount) return true;


                var target = this;
                var eleName = this.nodeName;

                if(eleName == 'SPAN' || eleName == 'DIV' || eleName == 'LABEL' ){
                    target = $(this).find('input').get(0);
                }

                var val = "";
                var title = $(target).attr('title') || $(target).parents('td').prev('td').html();

                //alert('title='+title)
                if($(target).hasClass("easyui-datebox") || $(target).hasClass("easyui-combobox")
                    || $(target).hasClass("combobox-f")){
                    val = $(target).datebox('getValue');
                }else{
                    val = $(target).val();
                }

                var isNotBlank = aud$isNotBlank(val);

                if($(target).hasClass("required") && !isNotBlank){
                    firstEle = !firstEle ? $(target) : firstEle;
                    msgArr.push("【"+title+"】为空");
                    return true;
                }

                //字符长度
                var lenJson = aud$getSepcialClass(target, 'len');
                if(lenJson && isNotBlank){
                    if(val.length > lenJson.length){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】字符长度超过限定超过【"+lenJson.length+"】");
                        return true;
                    }
                }

                //数字类型
                if($(target).hasClass("number") && isNotBlank){
                    if(!aud$checkNumber(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】非整数");
                        return true;
                    }
                }

                //自然数
                if($(target).hasClass("naturalNumber") && isNotBlank){
                    if(!aud$checkNaturalNumber(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】不是自然数");
                        return true;
                    }
                }

                //金额判断，浮点型判断
                if($(target).hasClass("money") && isNotBlank){
                    if(!aud$checkDouble(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】金额非法");
                        return true;
                    }
                }

                if($(target).hasClass("double") && isNotBlank){
                    if(!aud$checkDouble(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】格式非法，非浮点型");
                        return true;
                    }
                }

                //座机判断
                if($(target).hasClass("phone") && isNotBlank){
                    if(!aud$checkPhone(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】座机格式非法");
                        return true;
                    }
                }

                //手机判断
                if($(target).hasClass("mobile") && isNotBlank){
                    if(!aud$checkMobile(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】手机格式非法");
                        return true;
                    }
                }

                //身份证判断
                if($(target).hasClass("idcard") && isNotBlank){
                    if(!aud$checkIdcard(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】身份证格式非法");
                        return true;
                    }
                }

                //IP地址判断
                if($(target).hasClass("ip") && isNotBlank){
                    if(!aud$checkIp(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】IP格式非法");
                        return true;
                    }
                }

                //email地址判断
                if($(target).hasClass("email") && isNotBlank){
                    if(!aud$checkEmail(val)){
                        firstEle = !firstEle ? $(target) : firstEle;
                        msgArr.push("【"+title+"】邮箱格式非法");
                        return true;
                    }
                }

                //判断值大小
                if($(target).attr('compareval')  && isNotBlank){
                    var compareval = $(target).attr('compareval');
                    var valArr = compareval.split('&');
                    if(valArr != null && valArr.length == 2){
                        var oper = valArr[0];
                        var cpId = valArr[1];
                        //alert(oper+"\n"+cpId);
                        var cpval = null;
                        if($("#"+cpId).hasClass("easyui-datebox") || $("#"+cpId).hasClass("easyui-combobox")){
                            cpval = $("#"+cpId).datebox('getValue');
                        }else{
                            cpval = $("#"+cpId).val();
                        }
                        //alert(val+"\n"+cpval)
                        val = val.replace(/(\s*)/g, "").replace(/-|:/g,"");
                        cpval = cpval.replace(/(\s*)/g, "").replace(/-|:/g,"");
                        //alert(val+"\n"+cpval)
                        //alert(val < cpval)
                        val = parseInt(val);
                        cpval = parseInt(cpval);
                        var s = "";
                        var errObj = $(target);
                        if(oper == "lt" && val > cpval){
                            s = "小于";
                        }else if(oper == "lte" && val > cpval){
                            s = "小于等于";
                        }else if(oper == "gt" && val < cpval){
                            s = "大于";
                        }else if(oper == "gte" && val < cpval){
                            s = "大于等于";
                        }else if(oper == "eq" && val < cpval){
                            s = "等于";
                        }else if(oper == "neq" && val < cpval){
                            s = "不等于";
                        }

                        firstEle = !firstEle ? $(target) : firstEle;
                        if(s){
                            msgArr.push("【"+title+"】应"+s+"【"+$("#"+cpId).attr('title')+"】");
                            if(errObj){
                                $(errObj).datebox('showPanel');
                            }
                        }
                        return true;
                    }
                }

            });
            if(msgArr.length > 0){
                top.$.messager.alert('提示信息', msgArr.join('</br>'),'warning',function(){
                    firstEle.focus();
                });
                return false;
            }else{
                return true;
            }
        }
    }catch(e){
        isdebug ? alert('audEvd$validateform:\n'+e.message) : null;
    }
    return false;
}

// 非空判断
function aud$isNotBlank(val){
    try{
        return val != null && val != "" && val != undefined && val != "undefined" && val != "null" && val.length > 0;
    }catch(e){
        isdebug ? alert('aud$isNotBlank:\n'+e.message) : null;
    }
}

// 从给出对象的class中找出以preifx开头的class
function aud$getSepcialClass(target, prefix){
    try{
        if(target && prefix){
            var classStr = $(target).attr('class');
            if(classStr){
                classStr = $.trim(classStr);
                var arr = classStr.split(" ");
                var plen = prefix.length;
                for(var i=0; i<arr.length; i++){
                    var s = arr[i].replace(/(\s*)/g, "");
                    if(s.length && s.indexOf(prefix) != -1){
                        return {
                            'name':s,
                            'length':s.substr(plen)
                        }
                    }
                }
            }
        }
        return null;
    }catch(e){
        isdebug ? alert('aud$getSepcialClass:\n'+e.message) : null;
    }
}

// 检查浮点型
function aud$checkDouble(num){
    try{
        if(!num) return false;
        var exp = /^([1-9][\d]{0,20}|0)(\.[\d]{1,2})?$/;
        return exp.test(num);
    }catch(e){
        isdebug ? alert('aud$checkDouble:\n'+e.message) : null;
    }
}

//检查座机（匹配形式如 0511-4405222 或 021-87888822）
function aud$checkPhone(num){
    try{
        if(!num) return false;
        var exp = /\d{3}-\d{8}|\d{4}-\d{7}/;
        return exp.test(num);
    }catch(e){
        isdebug ? alert('aud$checkPhone:\n'+e.message) : null;
    }
}
//检查手机
function aud$checkMobile(num){
    try{
        if(!num) return false;
        var exp = /^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$/;
        return exp.test(num);
    }catch(e){
        isdebug ? alert('aud$checkMobile:\n'+e.message) : null;
    }
}

//身份证判断
function aud$checkIdcard(num){
    try{
        if(!num) return false;
        var exp = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
        var exp2 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
        return exp.test(num) || exp2.test(num);
    }catch(e){
        isdebug ? alert('aud$checkIdcard:\n'+e.message) : null;
    }
}

//ip \d+\.\d+\.\d+\.\d+
function aud$checkIp(num){
    try{
        if(!num) return false;
        var exp = /\d+\.\d+\.\d+\.\d+/;
        return exp.test(num);
    }catch(e){
        isdebug ? alert('aud$checkIp:\n'+e.message) : null;
    }
}

//邮箱判断
function aud$checkEmail(num){
    try{
        if(!num) return false;
        var exp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
        return exp.test(num);
    }catch(e){
        isdebug ? alert('aud$checkEmail:\n'+e.message) : null;
    }
}


// 匹配整数
function aud$checkNumber(num){
    try{
        if(!num) return false;
        var exp = /^-?[1-9]\d*$/;
        return exp.test(num);
    }catch(e){
        //isdebug ? alert('aud$checkMondy:\n'+e.message) : null;
    }
}

//匹配自然数
function aud$checkNaturalNumber(num){
    try{
        if(!num) return false;
        var exp = /^\d{1,}$/;
        return exp.test(num);
    }catch(e){
        //isdebug ? alert('aud$checkMondy:\n'+e.message) : null;
    }
}

// 清空表单
function audEvd$clearform(formId){
    try{
        if(formId){
            $('#'+formId).find('.clear').each(function(i){
                if($(this).hasClass("easyui-datebox")){
                    $(this).datebox('setValue','');
                }else{
                    $(this).val('');
                    $(this).text('');

                }
            });
        }
    }catch(e){
        //isdebug ? alert('audEvd$clearform:\n'+e.message) : null;
    }
    return false;
}



// 生成模板执行sql
function aud$genTemplateSql(node){
    try{
        if(node.attributes){
            var json = $.parseJSON(node.attributes);
            $('#tlInterTp_targetTableName').val(json.targetTableName);
            $('#tlInterTp_targetTableNameDesc').val(json.targetTableNameDesc);
        }
        $.ajax({
            url : "/ais/tlInteractive/genDefaultTemplateInfo.action",
            dataType:'json',
            type: "post",
            data: {
                'tableName':node.id,
                'tableDesc':node.text,
                'tableAlias':'t'
            },
            beforeSend:function(){
                var check = node != null;
                check ? aud$loadOpen() : null;
                return check;
            },
            success: function(data){
                aud$loadClose();
                if(data){
                    data.msg ? showMessage1(data.msg) : null;
                    if(data.type == 'info'){
                        var templateInfo = data.templateInfo;
                        if(templateInfo){
                            for(var p in templateInfo){
                                if(p == 'tlInterTp_templateName'){
                                    var tpname = $('#'+p).val();
                                    if(tpname){
                                        var index = tpname.indexOf("[");
                                        $('#'+p).val(tpname.substr(0, index) + templateInfo[p]);
                                    }else{
                                        $('#'+p).val(templateInfo[p]);
                                    }
                                }else{
                                    if($('#'+p).is('select')){
                                        $('#'+p).combobox('setValue', templateInfo[p]);
                                    }else{

                                        $('#'+p).val(templateInfo[p]);
                                    }

                                }
                            }
                        }
                    }
                }
            },
            error:function(data){
                aud$loadClose();
                top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
            }
        });
    }catch(e){
        //isdebug ? alert('aud$genTemplateSql:\n'+e.message) : null;
    }
}


// 根据tabId获得对应页面的iframe对象
function aud$getTabIframByTabId(tabId){
    try{
        if(tabId){
            if(tabId.substr(0, 4) != 'tab_'){
                tabId = 'tab_' + tabId;
            }
            var t = top.Addtabs.options.obj.children(".tab-content");
            var tabIfm = t.find('#'+tabId).find('.iframeClass');
            var ifmWin = tabIfm.get(0).contentWindow;
            return ifmWin;
        }
    }catch(e){
        //alert('aud$getTabIframByTabId:'+e.message);
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

//获得激活页签的ID，用于查找此页签的iframe
function aud$getActiveTabId(){
    try{
        return aud$getActiveTab().attr('id');
    }catch(e){
        //alert('aud$getActiveTabId:'+e.message);
    }
}

// 根据tabId关闭页签
function aud$closeTab(tabId, parentTabId){
    try{
        var topDialogTargetId = aud$getActiveDialogTargetId();
        if(topDialogTargetId){
            aud$closeTopDialog(topDialogTargetId);
        }else{
            parentTabId ? aud$activeTab(parentTabId) : null;
            var tabId = tabId ? tabId : aud$getActiveTabId();
            top.Addtabs.close(tabId);
        }

    }catch(e){
        //alert('aud$closeTab(id1,id2):'+e.message);
    }
}

function aud$closeTopDialog(targetId){
    try{
        targetId = targetId ? targetId : aud$getActiveDialogTargetId()
        if(targetId){
            var topJq = top.$ ? top.$ : $;
            topJq('#'+targetId).dialog("close");
        }
    }catch(e){
        //alert('aud$closeTopDialog():'+e.message);
    }
}

// 激活一个页签
function aud$activeTab(tabId){
    try{
        tabId ? top.Addtabs.active(tabId) : null;
    }catch(e){
        //alert('aud$activeTab:'+e.message);
    }
}

// add by sunny
var __valid_title_re = /<label.*?>.*?<\/label>/ig;
function validTitle(title) {
    return title.replace(__valid_title_re, "").replace("&nbsp;", "");
}
// add end.

// 创建并打开一个tab页签
function aud$openNewTab(title, url, isDialog, isShowProgress){

    // fixed by sunny
    // IE8 标题带有<i>或者标签会造成Tab标题折行显示
    title = validTitle(title);
    // fixed end
    var activeTabId = aud$getActiveTabId();
    var isHaveParam = url.indexOf("?") != -1;
    url = url + (isHaveParam ? "&" : "?") + 'activeTabId=' + activeTabId;
    //alert(url)
    var pbar = false;
    if(isShowProgress == null || isShowProgress == undefined || isShowProgress == ""
        || isShowProgress == true || isShowProgress == 'true'){
        pbar = true
    }
    //debugger;
    if(isDialog){//使用最外层窗口
        var topDialog = new aud$createTopDialog({
            title:title,
            url:url,
            showProgress:pbar
        });
        topDialog.open();
        return topDialog;
    }else{//使用新tab页签
        var ranNum = String(Math.floor(Math.random() * 10000));
        //调用父页面新建一个tab
        var tabId = 'customTab' + ranNum;
        top.Addtabs.add({
            id:tabId,
            title:title ? title: '新标签',
            url:url,
            close:true,
            refresh:true
        });
        return tabId;
    }

}


// 根据iframe id获得里面页面window对象
function aud$getIframeWin(ifrmId){
    try{
        var win = null;
        if(ifrmId){
            return $('#'+ifrmId).get(0).contentWindow;
        }
        return win;
    }catch(e){
        //alert('getIframeWin:'+e.message);
    }
}

//处理double金额显示的科学计数法
function aud$handleMoneyEFormat(prefix, attrArr, isView){
    try{
        var fattrArr = [];
        if(jQuery.type(attrArr) != "array"){
            fattrArr.push(attrArr);
        }else{
            fattrArr = attrArr;
        }
        $.each(fattrArr, function(i, attr){
            var editId = prefix ? prefix+"_"+attr : attr;
            var viewId = "view_"+attr;
            var val = isView ? $('#'+viewId).text() : $('#'+editId).val();
            if(val){
                var s3 = aud$handleMoneyE(val);
                isView ? $('#'+viewId).text(aud$formatMoney(s3)) : $('#'+editId).val(s3);
            }else{
                return val;
            }
        });
    }catch(e){
        //alert('aud$handleMoneyEFormat:'+e.message);
    }
}

//去掉科学计数法，转成正常显示金额
function aud$handleMoneyE(val, n){
    try{
        var s3 = "0.00";
        if(val){
            var s1 = val.indexOf('E');
            if(s1 > 0){
                var count = val.substr(s1+1);
                var n = [];
                for(i=0;i<count;i++){
                    n.push(0);
                }
                var s2 = val.substr(0, s1);
                s3 = (s2 * parseFloat(1+n.join(''))).toFixed(2);
            }else{
                s3 = val;
            }
        }
        return s3;
    }catch(e){
        //alert('aud$handleMoneyE:'+e.message);
    }
}

//金额转换成千分位格式，并四舍五入保留小数点n位
function aud$formatMoney(moneyNum, n){
    try{
        if(moneyNum){
            var moneyStr = aud$handleMoneyE(moneyNum+"");
            n = n && n > 0 && n <= 20 ? n : 2;
            var floatS = parseFloat((moneyStr + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
            var intPart = floatS.split(".")[0].split("").reverse();
            var intArr = [];
            var intLen = intPart.length;
            for(var i = 0; i < intLen; i ++ ){
                intArr.push(intPart[i]);
                if((i + 1) % 3 == 0 && (i + 1) != intLen){
                    intArr.push(",");
                }
            }
            var decimalPart = floatS.split(".")[1];
            return intArr.reverse().join("") + "." + decimalPart;
        }else{
            return "0.00";
        }
    }catch(e){
        //alert("aud$formatMoney:\n"+e.message);
    }
}

function aud$gridFormatMoney(value, row, index){
    var rtval = aud$formatMoney(value);
    return rtval ? "<label title='"+rtval+"'>"+rtval+"</label>" : "";
}


/* 把datagrid数据表格row转换成json格式对象，如：｛
	mtList[0].name:'fanwen',
	mtList[0].code:'xx',
	mtList[1].name:'admin',
	mtList[1].code:'xx'
	...｝
*/
function aud$rows2Json(prefix, rows){
    try{
        var sendData = null;
        if(rows && rows.length){
            prefix = prefix ? prefix : "";
            sendData = {};
            //构造传入参数
            $.each(rows, function(i, row){
                for(var p in row){
                    var val = row[p];
                    if(val != "null" && val != null && val != "undefined" && val != undefined){
                        sendData[prefix+"["+i+"]."+p] = row[p];
                    }
                }
            });
            //for(var p in sendData) alert(p+'='+sendData[p])
        }
        return sendData;
    }catch(e){
        //alert('aud$rows2Json:'+e.message);
    }

}

function aud$loadOpen(){
    try{
        top.frloadOpen ? top.frloadOpen() : frloadOpen();
    }catch(e){
        //alert("aud$loadOpen:"+e.message);
    }
}

function aud$loadClose(){
    try{
        var doc = top.frloadClose ? top : window;
        //top.frloadClose ? top.frloadClose() : frloadClose();
        if(doc.frloadClose){
            doc.frloadClose();
            var p = doc.passtimecount;
            var max = 20;
            var count = 0;
            var interval = setInterval(function(){
                if(p > 1 && count <= max){
                    try{
                        p = doc.passtimecount;
                        doc.frloadClose();
                    }catch(e){}
                }else{
                    clearInterval(interval);
                }
                count++;
            }, 150);
        }
    }catch(e){
        setTimeout(function(){
            top.frloadClose ? top.frloadClose() : frloadClose();
        },100);
    }
}


//通用最外层创建窗口
function aud$createTopDialog(options){
    try{
        var showProgress = options.showProgress;
        options.showProgress = showProgress == null || showProgress == 'null'
        || showProgress == undefined || showProgress == 'undefined' || showProgress == ""
        || showProgress == "true" || showProgress == true ? true : false;
        var activeDialogTargetId = aud$getActiveDialogTargetId();
        var activeTabId = aud$getActiveTabId();
        //alert('activeTabId='+activeTabId+"\nactiveDialogTargetId="+activeDialogTargetId)
        var parentDialogId = this.parentDialogId = options.parentDialogId ? options.parentDialogId :(activeDialogTargetId ? activeDialogTargetId: activeTabId);
        var zIndex = options.zIndex ? options.zIndex : 9010;
        this.zIndex = zIndex;
        var swidth  = top.document.body.clientWidth || top.document.documentElement.clientWidth;
        var sheight = top.document.body.clientHeight|| top.document.documentElement.clientHeight;
        var offsetW = 0.96;
        var offsetH = 0.98;
        var targetId = "topDialogId_"+String(new Date().getTime());
        var topWin = options.topWin != null ? options.topWin : true;
        // alert('topWin='+topWin)
        var topJq = topWin ? top.$ : $;
        this.topJq = topJq;
        this.targetId = targetId;
        var title  = options.title ? options.title : "窗口";
        var width  = options.width  ? options.width  : swidth  * offsetW;
        var height = options.height ? options.height : sheight * offsetH;
        width  = new String(width).indexOf("%") != -1 ? swidth  * (width.replace("%","")/100)  : width;
        height = new String(height).indexOf("%")!= -1 ? sheight * (height.replace("%","")/100) : height;
        var url = options.url;
        var content = options.content;
        // fixed by sunny
        // 这里将最大支持限制在 1920*1080 在一些使用IE早期版本（会错误将多个iframe高度累加，不管是否hide），且是小分辨率的情况下会出现弹出窗口太大而无法浏览，关闭的bug
        // 这里将限制设置为屏幕实际分辨率
        // width = width > 1920 ? 1920 : width;
        // height = height > 1080 ? 1080 : height;
        var screenwidth = screen.width - 50;
        var screenheight = screen.height - 160;
        //alert(Math.round(width)+"\n"+Math.round(height))
        width = width > screenwidth ? screenwidth : width;
        height = height > screenheight ? screenheight : height;
        // fixed end.
        //alert(Math.round(width)+"\n"+Math.round(height))
        var activeTabId = aud$getActiveTabId();
        var isHaveParam = url ? url.indexOf("?") != -1 : false;
        url = url + (isHaveParam ? "&" : "?") + 'activeTabId=' + activeTabId;
        var ct = topJq("<div id='"+targetId+"' style='overflow:hidden;'></div>").appendTo(topJq('body').get(0));
        var cifm = topJq("<iframe width='100%' height='100%' marginheight='0'  marginwidth='0'  frameborder='0' scrolling='hidden' src=''></iframe>").appendTo(ct.get(0));
        this.dialogIframe = cifm;
        cifm.unbind().bind('load', iframeOnload);

        var dialogParam = {
            title: "&nbsp;"+title,
            width:  Math.round(width),
            height: Math.round(height),
            closed: true,
            cache:  false,
            shadow: false,
            modal: true,
            resizable:true,
            minimizable:false,
            maximizable:true,
            iconCls:'icon-viewList',
            loadingMessage:"正在加载，请稍后...",
            onClose:function(){
               //top.$('body').css('overflow','auto');
                options.onClose ? options.onClose() : null;
                topJq('#'+targetId).parent().next('.window-mask').remove();
                topJq('#'+targetId).parent().remove();

            },
            onBeforeOpen:function(){
                //如果在上面iframe添加的时候设置src，则url会把请求三次，在这里则只请求一次
                if(url){
                    window.setTimeout(function(){
                        cifm.attr('src', url);
                    },0);
                }
            },
            onOpen:function(){
                //top.$('body').css('overflow','hidden');
                if(options.showProgress){
                    try{
                        aud$loadOpen();
                    }catch(e){}
                    setTimeout(iframeOnload, 5000);
                }
            }
        }

        if(content){
            dialogParam.content = content;
        }

        topJq('#'+targetId).dialog(dialogParam);

        var checkCount = 40;
        function iframeOnload(){
            var dialogWin = cifm.get(0).contentWindow;
            var data = null;
            try{
                var body = dialogWin.$('body');
                data = body.length;
                //alert('iframeOnload-data='+data+"\ncheckCount="+checkCount);
                if(data == null){
                    if(--checkCount > 0){
                        setTimeout(iframeOnload, 50);
                        return;
                    }
                }
                //alert(dialogWin.$('body').length);
                //alert('targetId='+targetId+"\nparentDialogId="+parentDialogId)
                dialogWin.$('body').attr("topDialogTargetId", targetId);
                dialogWin.$('body').attr("parentDialogId",    parentDialogId);
                aud$loadClose();
                options.onOpen ? options.onOpen() : null;
                checkCount = 20;
            }catch(e){
                //alert("iframeOnload:\n"+e.message);
            }
        }
    }catch(e){
        alert('aud$createTopDialog:\n'+e.message);
        aud$loadClose()
    }
}

aud$createTopDialog.prototype.open = function(){
    try{
        this.topJq('#'+this.targetId).dialog("open").dialog('resize');
        this.topJq('#'+this.targetId).parent().css('z-index', this.zIndex);
        this.topJq('#'+this.targetId).parent().nextAll('.window-mask').css('z-index', this.zIndex - 1);
    }catch(e){
        //alert('aud$createTopDialog.prototype.open:\n'+e.message);
    }
}

aud$createTopDialog.prototype.close = function(){
    try{
        this.topJq('#'+this.targetId).dialog("close");
    }catch(e){
        //alert('aud$createTopDialog.prototype.close:\n'+e.message);
    }
}

aud$createTopDialog.prototype.getJqDialogObj = function(){
    try{
        return this.topJq('#'+this.targetId);
    }catch(e){
        //alert('aud$createTopDialog.prototype.getJqDialogObj:\n'+e.message);
    }
}

aud$createTopDialog.prototype.getTargetId = function(){
    try{
        return this.targetId;
    }catch(e){
        //alert('aud$createTopDialog.prototype.getTargetId:\n'+e.message);
    }
}

aud$createTopDialog.prototype.getParentDialogId = function(){
    try{
        return this.parentDialogId;
    }catch(e){
        //alert('aud$createTopDialog.prototype.getParentDialogId:\n'+e.message);
    }
}

function aud$getActiveDialogTargetId(count){
    try{
        return $('body').attr("topDialogTargetId");

        if(count == null) count = 10;
        var topDialogTargetId =  $('body').attr("topDialogTargetId");
        if(!topDialogTargetId && --count > 0){
            setTimeout(function(){
                aud$getActiveDialogTargetId(count);
            }, 100);
            return;
        }
        return $('body').attr("topDialogTargetId");
    }catch(e){
        //alert('aud$getActiveDialogTargetId:\n'+e.message);
    }
}

function aud$closeParentDialog(){
    try{
        var parentDialogId = $('body').attr("parentDialogId");
        //alert('parentDialogId='+parentDialogId)
        if(parentDialogId){
            var topJq = top.$ ? top.$ : $;
            topJq('#'+parentDialogId).dialog("close");
        }
    }catch(e){
        //alert('aud$closeParentDialog:\n'+e.message);
    }
}

function aud$parentDialogWin(count){
    try{
        if(count == null) count = 10;
        var parentDialogId =  $('body').attr("parentDialogId");
        //alert('count='+count+"\nparentDialogId="+parentDialogId);
        if(!parentDialogId && --count > 0){
            setTimeout(function(){
                aud$parentDialogWin(count);
            }, 100);
            return;
        }
        //alert("parentDialogWin-parentDialogId="+parentDialogId)
        if(parentDialogId){
            var topJq = top.$ ? top.$ : $;
            var topwinifram = topJq('#'+parentDialogId).find('iframe');
            if(topwinifram.length){
                return topwinifram.get(0).contentWindow;
            }else{
                return null;
            }

        }
        return null;
    }catch(e){
        //alert('aud$parentDialogWin:\n'+e.message);
    }
}

//处理groupId为多个的情况
function aud$genGroupWhere(groupId){
    if(groupId){
        var groupIdArr = groupId.split(",");
        if(groupIdArr != null && groupIdArr.length){
            groupId = "'"+groupIdArr.join("','")+"'";
            return "groupId in ("+groupId+")";
        }else{
            return "groupId="+groupId;
        }
    }else{
        return "";
    }
}

$.fn.window.defaults.zIndex = 9010;


$.extend($.fn.validatebox.defaults.rules, {
    idcard: {// 验证身份证
        validator: function (value) {
            return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
        },
        message: '身份证号码格式不正确'
    },
    minLength: {
        validator: function (value, param) {
            return value.length >= param[0];
        },
        message: '请输入至少（2）个字符.'
    },
    length: {
        validator: function (value, param) {
            var len = $.trim(value).length;
            return len >= param[0] && len <= param[1];
        },
        message: "输入内容长度必须介于{0}和{1}之间."
    },
    phone: {// 验证电话号码
        validator: function (value) {
            return /^((\d{2,3})|(\d{3}\-))?(0\d{2,3}|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
        },
        message: '格式不正确,请使用下面格式:020-88888888'
    },
    mobile: {// 验证手机号码
        validator: function (value) {
            return /^(13|15|18)\d{9}$/i.test(value);
        },
        message: '手机号码格式不正确'
    },
    intOrFloat: {// 验证整数或小数
        validator: function (value) {
            return /^\d+(\.\d+)?$/i.test(value);
        },
        message: '请输入数字，并确保格式正确'
    },
    currency: {// 验证货币
        validator: function (value) {
            return /^\d+(\.\d+)?$/i.test(value);
        },
        message: '货币格式不正确'
    },
    qq: {// 验证QQ,从10000开始
        validator: function (value) {
            return /^[1-9]\d{4,9}$/i.test(value);
        },
        message: 'QQ号码格式不正确'
    },
    integer: {// 验证整数 可正负数
        validator: function (value) {
            //return /^[+]?[1-9]+\d*$/i.test(value);

            return /^([+]?[0-9])|([-]?[0-9])+\d*$/i.test(value);
        },
        message: '请输入整数'
    },
    positive: {// 验证正整数
        validator: function (value) {
            return /^([+]?[0-9])\d*$/i.test(value);
        },
        message: '请输入正整数'
    },
    percentage: {// 验证1-100的正整数
        validator: function (value) {
            return /^([+]?[1-9])\d{0,1}$|100/i.test(value);
        },
        message: '请输入1-100的正整数'
    },
    age: {// 验证年龄
        validator: function (value) {
            return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
        },
        message: '年龄必须是0到120之间的整数'
    },

    chinese: {// 验证中文
        validator: function (value) {
            return /^[\Α-\￥]+$/i.test(value);
        },
        message: '请输入中文'
    },
    english: {// 验证英语
        validator: function (value) {
            return /^[A-Za-z]+$/i.test(value);
        },
        message: '请输入英文'
    },
    unnormal: {// 验证是否包含空格和非法字符
        validator: function (value) {
            return /.+/i.test(value);
        },
        message: '输入值不能为空和包含其他非法字符'
    },
    username: {// 验证用户名
        validator: function (value) {
            return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
        },
        message: '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
    },
    faxno: {// 验证传真
        validator: function (value) {
            //            return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/i.test(value);
            return /^((\d{2,3})|(\d{3}\-))?(0\d{2,3}|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
        },
        message: '传真号码不正确'
    },
    zip: {// 验证邮政编码
        validator: function (value) {
            return /^[1-9]\d{5}$/i.test(value);
        },
        message: '邮政编码格式不正确'
    },
    ip: {// 验证IP地址
        validator: function (value) {
            return /d+.d+.d+.d+/i.test(value);
        },
        message: 'IP地址格式不正确'
    },
    name: {// 验证姓名，可以是中文或英文
        validator: function (value) {
            return /^[\Α-\￥]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);
        },
        message: '请输入姓名'
    },
    date: {// 验证姓名，可以是中文或英文
        validator: function (value) {
            //格式yyyy-MM-dd或yyyy-M-d
            return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value);
        },
        message: '请输入合适的日期格式'
    },
    msn: {
        validator: function (value) {
            return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value);
        },
        message: '请输入有效的msn账号(例：abc@hotnail(msn/live).com)'
    },
    same: {
        validator: function (value, param) {
            if ($("#" + param[0]).val() != "" && value != "") {
                return $("#" + param[0]).val() == value;
            } else {
                return true;
            }
        },
        message: '两次输入的密码不一致！'
    }
});

$(function(){
    var fobj = $('body').find("table input:text:visible:enabled:eq(0)");
    if(fobj.length){
        fobj.focus()
    }else{
        $('body').find("table textarea:visible:enabled[readonly!='readonly']:eq(0)").focus();
    }
});


// 合并datagrid的单元格
function aud$mergeDataGridCells(gridId, fieldsName){
    try{
        if(gridId && fieldsName && fieldsName.length){
            var data = $('#'+gridId).datagrid('getData');
            if(!data || data.rows.length == 0) return;
            var rows = data.rows;
            if(rows && rows.length){
                var len = rows.length;
                $.each(fieldsName, function(i, field){
                    var preVal = "";
                    var samecount = 1;
                    var beginIndex = 0;
                    var isStart = true;
                    $.each(rows, function(j, row){
                        var val = row[field];
                        if(isStart){
                            preVal = val;
                            isStart = false;
                            return true;
                        }else if(val == preVal){
                            samecount++;
                            preVal = val;
                        }
                        if((val != preVal || j == len - 1) && samecount){
                            $('#'+gridId).datagrid('mergeCells',{
                                index  : beginIndex,
                                field  : field,
                                rowspan: samecount,
                                colspan: 1
                            });
                            beginIndex = j;
                            samecount = 1;
                            preVal= val;
                        }
                    })
                });
            }
        }
    }catch(e){
        //alert('aud$mergeGridCells:\n'+e.message);
    }
}


function aud$isBlank(s){
    return s == "" || s == null || s == "null" || s == "NULL"
        || s == undefined || s == "undefined";
}

function aud$isNotBlank(s){
    return !aud$isBlank(s);
}


// datagrid合并指定列的相同项
function aud$mergeDatagridCols(gridId, fieldsName){
    try{
        if(gridId && fieldsName && fieldsName.length){
            var data = $('#'+gridId).datagrid('getData');
            if(!data || data.rows.length == 0) return;
            var rows = data.rows;
            if(rows && rows.length){
                var len = rows.length;
                $.each(fieldsName, function(i, field){
                    var preVal = "";
                    var samecount = 1;
                    var beginIndex = 0;
                    var isStart = true;
                    var sumRow = [];
                    $.each(rows, function(j, row){
                        sumRow.push(row);
                        var preRow = rows[j - 1];
                        var val = row[field];
                        if(isStart){
                            preVal = val;
                            isStart = false;
                            return true;
                        }else if(val == preVal){
                            samecount++;
                            preVal = val;
                        }

                        if((val != preVal || j == len - 1) && samecount){
                            $('#'+gridId).datagrid('mergeCells',{
                                index  : beginIndex,
                                field  : field,
                                rowspan: samecount,
                                colspan: 1
                            });
                            beginIndex = j ;
                            samecount = 1;
                            preVal= val;
                        }
                    })
                });
            }
        }
    }catch(e){
        //alert('aud$mergeGridCells:\n'+e.message);
    }
}

/**
 * 刷新首页的待办、我的项目、整改反馈(当前window或者上一个window)
 * eg:传入字符串名称或者数组
 * 	aud$refreshHomeList();//刷新待办
 *  aud$refreshHomeList('todoTaskTable');//刷新待办
 *  aud$refreshHomeList(['todoTaskTable','myProjectTable']);//刷新待办、我的项目
 */
function aud$refreshHomeList(listNameArr, type){
    try{
        var arr = null;
        if(listNameArr){
            if(jQuery.type(listNameArr) === "string"){
                arr = [];
                arr.push(listNameArr);
            }else if(jQuery.type(listNameArr) === "array"){
                arr = listNameArr;
            }
        }else{
            arr = [];
            arr.push('todoTaskTable');
        }
        if(arr != null && arr.length){
            var homeIfm = aud$getTabIframByTabId('home') || top.opener;
            var firstPageObj = type == 'sa' ? "aud$StateAuditFirstPage" : "projectAuditFirstPage" ;
            if(!homeIfm || (homeIfm && !homeIfm[firstPageObj])){
                homeIfm = top.opener
            }
            if(homeIfm && homeIfm[firstPageObj]){
                $.each(arr, function(i, name){
                    try{
                        homeIfm[firstPageObj][name]();
                    }catch(e){}
                });
            }
        }
    }catch(e){}
}


// 生成下拉选择
function aud$genSelectOption(selectObjId, arr, defaultVal, options){
    try{
        options = options ? options : {};
        var selectObj = $('#'+selectObjId);
        if(selectObj && selectObj.length && arr && arr.length){
            options.multiple ? null : selectObj.append("<option value=''>&nbsp;</option>");
            for(var i=0; i<arr.length; i++){
                var  ele = arr[i];
                //alert(ele)
                if(defaultVal != null && defaultVal == ele.code){
                    selectObj.append("<option value='"+ele.code+"' selected>"+ele.name+"</option>");
                }else{
                    selectObj.append("<option value='"+ele.code+"'>"+ele.name+"</option>");
                }

            }
        }
        selectObj.combobox($.extend({},{
            'panelHeight':'auto',
            'editable':false
        }, options));
        if(defaultVal){
            setTimeout(function(){
                selectObj.combobox('setValue', defaultVal);
            }, 10);
        }

    }catch(e){
        alert('aud$genSelectOption:\n'+e.message);
    }
}

// 解决：datagrid有多个上传附件时，文件上传后，行高和序号高度错位
function aud$resetGridRowHeight(gridId, timeoutTime){
    try{
        setTimeout(function(){
            $('#'+gridId).datagrid("fixRowHeight");
        }, timeoutTime ? timeoutTime : 10);
    }catch(e){

    }
}

