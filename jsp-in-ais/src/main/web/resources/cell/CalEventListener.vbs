Option Explicit

'Public Const CAF_qcye = "qcye" ' �ڳ����
'Public Const CAF_qmye = "qmye" ' ��ĩ���
'Public Const CAF_fse = "fse"   ' ������
'Public Const CAF_bn = "bn"     ' ����
'Public Const CAF_qn = "qn"     ' ȥ��
'Public Const CAF_by = 0        ' ����

Const delimiter = "&dlmt"
Function commonFun(sCode,qstring)
    commonFun = Broker(sCode,qstring)
End Function



