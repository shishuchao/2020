function frmCheck(frmName, tblName, parentmsg) {
    var frm_name = frmName.name;
    var frm_obj = eval("document." + frm_name);
    var tbl_obj = eval(tblName);
    var kj_obj = null;
    var intCell = 0;
    var strDisc = null;
    var strKj = null;
    var msgobj = null;
    if (parentmsg) {
        if (parent.$ && parent.$.messager) {
            msgobj = window.parent.$.messager;
        }

    } else {
        if ($.messager) {
            msgobj = $.messager;
        }

    }
    var cells;
    try {
        cells = tbl_obj.cells;
    } catch (e) {
        cells = tbl_obj.rows[0].cells;
    }
    if (cells != null) {
        for (var i = 0; i <= parseInt(cells.length) - 1; i++) {
            strKj = cells[i].innerHTML;
            if (strKj.indexOf("<") != -1 && strKj.indexOf("<FONT color=red>*</FONT>") == -1 && (strKj.toLowerCase().indexOf("input") != -1 || strKj.toLowerCase().indexOf("select") != -1 || strKj.toLowerCase().indexOf("textarea") != -1)) {
                strDisc = cells[parseInt(i) - 1].innerText;
                strKj = cells[i].children.item(0).id;
                nodeName = cells[i].children.item(0).nodeName;
                className = cells[i].children.item(0).className;
                //alert(className);
                if ((nodeName == 'SELECT' || nodeName == 'INPUT' || nodeName == 'TEXTAREA') && strKj) {
                    if (className == 'noborder' || className == '') {
                        kj_obj = eval("document." + frm_name + "." + strKj);
                        if (strDisc.indexOf("*") != -1) {
                            if (trim(kj_obj.value) == "") {
                                if (msgobj) {
                                    top.$.messager.show({
                                        title: "我的消息",
                                        msg: strDisc.replace("*", "") + "不能为空!",
                                        timeout: 5000,
                                        showType: 'slide'
                                    });
                                } else {
                                    alert(strDisc.replace("*", "") + "不能为空!");
                                }
                                kj_obj.focus();
                                return false;
                            }
                        }
                    } else if (className == 'easyui-combobox combobox-f combo-f textbox-f') {
                        kj_obj = $('#' + strKj);
                        if (strDisc.indexOf("*") != -1) {
                            if (trim(kj_obj.combobox('getValue')) == "") {
                                if (msgobj) {
                                    top.$.messager.show({
                                        title: "我的消息",
                                        msg: strDisc.replace("*", "") + "不能为空!",
                                        timeout: 5000,
                                        showType: 'slide'
                                    });
                                } else {
                                    alert(strDisc.replace("*", "") + "不能为空!");
                                }

                                kj_obj.focus();
                                return false;
                            }
                        }
                    } else if (className == 'easyui-datebox datebox-f combo-f textbox-f') {
                        kj_obj = $('#' + strKj);
                        if (strDisc.indexOf("*") != -1) {
                            if (trim(kj_obj.datebox('getValue')) == "") {
                                if (msgobj) {
                                    top.$.messager.show({
                                        title: "我的消息",
                                        msg: strDisc.replace("*", "") + "不能为空!",
                                        timeout: 5000,
                                        showType: 'slide'
                                    });
                                } else {
                                    alert(strDisc.replace("*", "") + "不能为空!");
                                }
                                kj_obj.focus();
                                return false;
                            }
                        }
                    }
                }
            }
        }
    }

    return true;
}

function frmCheckMoney(frmName, tblName, parentmsg) {
    var frm_name = frmName.name;
    var frm_obj = eval("document." + frm_name);
    var tbl_obj = eval(tblName);
    var kj_obj = null;
    var intCell = 0;
    var strDisc = null;
    var strKj = null;
    var msgobj = null;
    if (parentmsg) {
        if (parent.$ && parent.$.messager)
            msgobj = window.parent.$.messager;
    } else {
        if ($.messager)
            msgobj = $.messager;
    }
    for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
        strKj = tbl_obj.cells(i).innerHTML;

        if (strKj.indexOf("<") != -1 && strKj.indexOf("<FONT color=red>*</FONT>") == -1 && (strKj.toLowerCase().indexOf("input") != -1 || strKj.toLowerCase().indexOf("select") != -1 || strKj.toLowerCase().indexOf("textarea") != -1)) {
            strDisc = tbl_obj.cells(parseInt(i) - 1).innerText;
            strKj = tbl_obj.cells(i).children.item(0).id;
            if (strKj) {
                kj_obj = eval("document." + frm_name + "." + strKj);
                if (strDisc.indexOf("*") != -1) {
                    if (trim(kj_obj.value) == "") {
                        if (msgobj)
                            msgobj.show({title: '消息', msg: strDisc.replace("*", "").replace("￥", "") + "不能为空!"});
                        else
                            alert(strDisc.replace("*", "").replace("￥", "") + "不能为空!");
                        kj_obj.focus();
                        return false;
                    }
                }
                if (strDisc.indexOf("￥") != -1) {
                    if (trim(kj_obj.value) == "" || (!isMoneyNum(kj_obj.value) || !isPlus(kj_obj.value))) {
                        if (msgobj)
                            msgobj.show({title: '消息', msg: strDisc.replace("￥", "").replace("*", "") + "输入有误！"});
                        else
                            alert(strDisc.replace("￥", "").replace("*", "") + "输入有误！");
                        kj_obj.focus();
                        return false;
                    }
                }
                if (strDisc.indexOf("$") != -1) {
                    if (trim(kj_obj.value) == "" || (!isMoneyNum(kj_obj.value))) {
                        if (msgobj)
                            msgobj.show({title: '消息', msg: strDisc.replace("$", "").replace("*", "") + "输入有误！"});
                        else
                            alert(strDisc.replace("$", "").replace("*", "") + "输入有误！");
                        kj_obj.focus();
                        return false;
                    }
                }

            }
        }
    }
    return true;
}

function trim(inputString) {
    try {
        var strValue = inputString;
        var ch = strValue.substring(0, 1);
        while (ch == " ") {
            strValue = strValue.substring(1, strValue.length);
            ch = strValue.substring(0, 1);
        }
        ch = strValue.substring(strValue.length - 1, strValue.length);
        while (ch == " ") {
            strValue = strValue.substring(0, strValue.length - 1);
            ch = strValue.substring(strValue.length - 1, strValue.length);
        }
        return strValue;
    } catch (e) {
    }
}

function isMStartyNum(str) {
    return (new RegExp(/(^-?(?:(?:\d{0,3}(?:,\d{3})*)|\d*))(\.\d{1,2})?$/).test(str));
}

function isPlus(str) {
    return (new RegExp(/(^\+?|^\d?)\d*\.?\d+$/).test(str));
}

function compareDate(DateStart, DateEnd) {
    var EndMonth = DateEnd.substring(5, DateEnd.lastIndexOf("-"));
    var EndDay = DateEnd.substring(DateEnd.length, DateEnd.lastIndexOf("-") + 1);
    var EndYear = DateEnd.substring(0, DateEnd.indexOf("-"));

    var StartMonth = DateStart.substring(5, DateStart.lastIndexOf("-"));
    var StartDay = DateStart.substring(DateStart.length, DateStart.lastIndexOf("-") + 1);
    var StartYear = DateStart.substring(0, DateStart.indexOf("-"));

    if (Date.parse(EndMonth + "/" + EndDay + "/" + EndYear) > Date.parse(StartMonth + "/" + StartDay + "/" + StartYear)) {
        return true;
    } else {
        return false;
    }
}

/*
 * validate email format  
 * author: zhangxingli
 */
function emailValidate(inputEmail) {
    var Email = document.getElementById(inputEmail);

    if (Email != null && Email.value != '') {
        var reEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;  //邮箱检测
        var b_email = reEmail.test(Email.value);
        if (!b_email) {
            top.$.messager.show({
                title: "我的消息",
                msg: "邮箱格式不正确！",
                timeout: 5000,
                showType: 'slide'
            });
            Email.focus();
            return false;
        }
        return true;
    } else {
        return true;
    }
}

/*
 * validate email format  
 * author: zhangxingli
 */
function inputemailValidate(email) {
    var Email = document.getElementById(email);
    var emailarr = new Array();
    emailarr = (Email.value).split(";");
    for (i = 0; i < emailarr.length; i++) {
        var ml = emailarr[i];
        if (ml != null && ml != '') {
            var reEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;  //邮箱检测
            var b_email = reEmail.test(ml);
            if (!b_email) {
                window.parent.$.messager.show({
                    title: "我的消息",
                    msg: "邮箱格式不正确！",
                    timeout: 5000,
                    showType: 'slide'
                });
                Email.focus();
                return false;
            }
            return true;
        } else {
            return true;
        }
    }
}


/*
 *validate telephone 
 *author:zhangxingli
 */
function telephoneValidate(inputTelephone) {
    var tele = document.getElementById(inputTelephone);
    if (tele != null && tele.value != '') {
        var len = tele.value.length;
        var reg = /^(\d{3,4})-(\d{7,8})-(\d{3,})/;
        var re = (tele.value).match(reg);
        var reg2 = /^(\d{3,4})-(\d{7,8})/;
        var re2 = (tele.value).match(reg2);
        if ((!re || (re && len > 17)) && (!re2 || (re2 && len > 13))) {
            alert("电话格式不正确！");
            tele.focus();
            return false;
        }
        return true;
    } else {
        return true;
    }
}

//校验普通电话、传真号码：可以“+”开头，除数字外，可含有“-”
function isTel(object) {
    //国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)"

    var s = document.getElementById(object.id).value;
    var pattern = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
    //var pattern =/(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/;
    if (s != "") {
        if (!pattern.exec(s)) {
            alert('请输入正确的电话号码:电话号码格式为国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)!');
            object.value = "";
            object.focus();
        }
    }
}

/*
 * 校验(国内)邮政编码
 */
function isPostalCode(inputPostal) {
    var s = document.getElementById(inputPostal).value;
    var pattern = /^[0-9]{6}$/;
    if (s != "") {
        if (!pattern.exec(s)) {
            alert('请输入正确的邮政编码!');
            document.getElementById(inputPostal).focus();
            return false;
        }
    }
    return true;
}

/*
 *validate phone
 *author:zhangxingli
 */
function phoneValidate(inputMobile) {
    var Mobile = document.getElementById(inputMobile);
    if (Mobile != null && Mobile.value != '') {
        var Pho = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/;         //手机号码检测
        var b_Phone = Pho.test(Mobile.value);
        if (!b_Phone) {
            alert("手机号码格式不正确！");
            Mobile.focus();
            return false;
        }
        return true;
    } else {
        return true;
    }
}

/*
 *validate ID card
 *（简单的身份证验证(JS),只验证位数合法性(15位,18位,及最后的X)不验证生日及最后4位以及前缀合法性）
 *author:zhangxingli
 */
function IDcardValidte(inputIDcard) {
    var IDCard = document.getElementById(inputIDcard);
    if (IDCard.value != null && IDCard.value != '') {
        if (!inValidateIDcard(IDCard.value)) {
            IDCard.focus();
            alert("身份证输入错误!");
            return false;
        } else {
            return true;
        }
    } else {
        return true;
    }
}

/*
 * validate IDcard (simple method)
 * author:zhangxingli
 */
function inValidateIDcard(IDCard) {

    var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
    var varArray = new Array();
    var intValue;
    var lngProduct = 0;
    var intCheckDigit;
    var intStrLen = IDCard.length;
    var idNumber = IDCard;
    //  判断身份证的长度
    if ((intStrLen != 15) && (intStrLen != 18)) {
        return false;
    }

    for (i = 0; i < intStrLen; i++) {
        varArray[i] = idNumber.charAt(i);
        if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
            return false;
        } else if (i < 17) {
            varArray[i] = varArray[i] * factorArr[i];
        }

    }
    if (intStrLen == 18) {
        // 判断6到14位的日期格式是否正确
        var date8 = idNumber.substring(6, 14);
        if (checkDate(date8) == false) {
            return false;
        }
        //  计算出身份证的总值
        for (i = 0; i < 17; i++) {
            lngProductlngProduct = lngProduct + varArray[i];
        }
        //  算出身份证最后一位的值
        intCheckDigit = 12 - lngProduct % 11;
        switch (intCheckDigit) {
            case 10:
                intCheckDigit = 'X';
                break;
            case 11:
                intCheckDigit = 0;
                break;
            case 12:
                intCheckDigit = 1;
                break;
        }
        // 判断身份证最后一位 (有问题)
        //if (varArray[17].toUpperCase() != intCheckDigit) {
        //	alert(varArray[17].toUpperCase() + 'ffffddd' +intCheckDigit);
        // 	return false;
        // }
        var v17 = varArray[17].toUpperCase();
        if ('0,1,2,3,4,5,6,7,8,9,x,X'.indexOf(v17) == -1) {
            //alert('最后一位错误！');
            return false;
        }
    } else { // 若身份证长度是15位的
        var date6 = idNumber.substring(6, 12);
        if (checkDate(date6) == false) {
            return false;
        }
    }
    return true;
}

function checkDate(date) {
    return true;
}

// 统一社会信用代码校验
function isSocialCreditCode(code) {
    var patrn = /^[0-9A-Z]+$/;
    //18位校验及大写校验
    if ((code.length != 18) || (patrn.test(code) == false)) {
        return false;
    }

    var Ancode;//统一社会信用代码的每一个值
    var Ancodevalue;//统一社会信用代码每一个值的权重
    var total = 0;
    var weightedfactors = [1, 3, 9, 27, 19, 26, 16, 17, 20, 29, 25, 13, 8, 24, 10, 30, 28];//加权因子
    var str = '0123456789ABCDEFGHJKLMNPQRTUWXY';
    //不用I、O、S、V、Z
    for (var i = 0; i < code.length - 1; i++) {
        Ancode = code.substring(i, i + 1);
        Ancodevalue = str.indexOf(Ancode);
        total = total + Ancodevalue * weightedfactors[i];
        //权重与加权因子相乘之和
    }
    var logiccheckcode = 31 - total % 31;
    if (logiccheckcode == 31) {
        logiccheckcode = 0;
    }
    var Str = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,T,U,W,X,Y";
    var Array_Str = Str.split(',');
    logiccheckcode = Array_Str[logiccheckcode];

    var checkcode = code.substring(17, 18);
    if (logiccheckcode != checkcode) {
        return false;
    }
    return true;
}