Option Explicit

'Public Const CAF_qcye = "qcye" ' 期初余额
'Public Const CAF_qmye = "qmye" ' 期末余额
'Public Const CAF_fse = "fse"   ' 发生额
'Public Const CAF_bn = "bn"     ' 本年
'Public Const CAF_qn = "qn"     ' 去年
'Public Const CAF_by = 0        ' 本月

Const delimiter = "&dlmt"
Function commonFun(sCode,qstring)
    commonFun = Broker(sCode,qstring)
End Function



