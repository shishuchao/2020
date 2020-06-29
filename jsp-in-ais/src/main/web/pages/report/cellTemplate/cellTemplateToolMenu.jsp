<%@ page language="java" contentType="text/html;charset=utf-8"%>
<TABLE class="cbToolbar" id="idTBGeneral" style="display: 'none'" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<TD NOWRAP><A class=tbButton id=cmdFileNew title=新建 href="javascript:;" name=cbButton><IMG align="middle"  src="<%=request.getContextPath()%>/resources/cell/general/new.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFileOpen title=打开远程文档 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/openweb.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFileSave title=保存 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/save.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFilePrint title=打印 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/print.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdFilePrintPreview title=打印预览 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/printpreview.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEditCut title=剪切 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/cut.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEditCopy title=复制 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/copy.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEditPaste title=粘贴 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/paste.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdEditFind title=查找 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/find.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEditUndo title=撤消 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/undo.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdEditRedo title=重做 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/redo.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdViewFreeze title=不滚动区域 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/freeze.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFormatPainter title=格式刷 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/painter.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdSortAscending title=升序排列 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/sorta.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdSortDescending title=降序排列 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/sortd.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFormulaInput title=输入公式 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/formula.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdFormulaSerial title=填充单元公式序列 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/formulaS.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFormulaSumH title=水平求和 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/sumh.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdFormulaSumV title=垂直求和 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/sumv.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdFormulaSumHV title=双向求和 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/sum.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdChartWzd title=图表向导 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/chartw.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdInsertPic title=插入图片 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/insertpic.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdHyperlink title=超级链接 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/hyperlink.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdWzdBarcode title=条形码向导 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/barcode.gif" width="16" height="16"></A></TD>

	<TD class="tbDivider" NOWRAP id="cmdViewScale" Title="显示比例">
		<SELECT name="viewScaleSelect" style="WIDTH: 59px; HEIGHT: 23px" onChange="changeViewScale(viewScaleSelect.value)" ACCESSKEY="v" size="1">
          <option value="200">200%</option>
          <option value="150">150%</option>
          <option value="120">120%</option>
          <option value="110">110%</option>
          <option selected value="100">100%</option>
          <option value="90">90%</option>
          <option value="80">80%</option>
          <option value="70">70%</option>
          <option value="50">50%</option>
          <option value="30">30%</option>
          <option value="20">20%</option>
          <option value="15">15%</option>
          <option value="10">10%</option>
          <option value="5">5%</option>
          <option value="3">3%</option>
          <option value="1">1%</option>
        </SELECT>
	</TD>


	<TD NOWRAP><A class=tbButton id=cmdShowGridline title=显示/隐藏背景网格线 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/gridline.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdVPagebreak title=垂直分隔线 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/vpagebreak.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdHPagebreak title=水平分隔线 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/hpagebreak.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdShowPagebreak title=显示/隐藏分隔线 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/pagebreak.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdAbout title=关于华表插件 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/general/about.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="100%"></TD>
	</TR>
</TABLE>
<TABLE class="cbToolbar" id="idTBFormat" style="display: 'none'" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<TD NOWRAP id="cmdFontName" Title="字体">
		<SELECT name="FontNameSelect" style="WIDTH: 200px; HEIGHT: 23px" onChange="changeFontName(FontNameSelect.value)" ACCESSKEY="v" size="1">
        &nbsp; </SELECT>
	</TD>
	<TD NOWRAP class="tbDivider" id="cmdFontSize" Title="字号">
		<SELECT name="FontSizeSelect" style="WIDTH: 40px; HEIGHT: 23px" onChange="changeFontSize(FontSizeSelect.value)" ACCESSKEY="v" size="1">
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option selected value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
          <option value="14">14</option>
          <option value="16">16</option>
          <option value="18">18</option>
          <option value="20">20</option>
          <option value="22">22</option>
          <option value="24">24</option>
          <option value="26">26</option>
          <option value="28">28</option>
          <option value="30">30</option>
          <option value="36">36</option>
          <option value="42">42</option>
          <option value="48">48</option>
          <option value="72">72</option>
          <option value="100">100</option>
          <option value="150">150</option>
          <option value="300">300</option>
          <option value="500">500</option>
          <option value="800">800</option>
          <option value="1200">1200</option>
          <option value="2000">2000</option>
        </SELECT>
	</TD>

	<TD NOWRAP><A class=tbButton id=cmdBold title=粗体 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/bold.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdItalic title=斜体 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/italic.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdUnderline title=下划线 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/underline.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdBackColor title=背景色 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/backcolor.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdForeColor title=前景色 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/forecolor.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdWordWrap title=自动折行 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/wordwrap.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignLeft title=居左对齐 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/alignleft.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignCenter title=居中对齐 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/aligncenter.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignRight title=居右对齐 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/alignright.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignTop title=居上对齐 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/aligntop.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdAlignMiddle title=垂直居中 href="javascript:;" name=cbButton  sticky="true"><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/alignmiddle.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdAlignBottom title=居下对齐 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/alignbottom.gif" width="16" height="16"></A></TD>
	<TD NOWRAP id="cmdBoderType" Title="边框类型">
		<SELECT name="BorderTypeSelect" style="WIDTH: 70px; HEIGHT: 23px" ACCESSKEY="v" size="1" 
     >
          <option value="2" selected>细线</option>
          <option value="3">中线</option>
          <option value="4">粗线</option>
          <option value="5">划线</option>
          <option value="6">点线</option>
          <option value="7">点划线</option>
          <option value="8">点点划线</option>
          <option value="9">粗划线</option>
          <option value="10">粗点线</option>
          <option value="11">粗点划线</option>
          <option value="12">粗点点划线</option>
          
        </SELECT>
	</TD>
	<TD NOWRAP><A class=tbButton id=cmdDrawBorder title=画边框线 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/border.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdEraseBorder title=抹边框线 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/erase.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdCurrency title=货币符号 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/currency.gif" width="16" height="16"></A></TD>
	<TD NOWRAP><A class=tbButton id=cmdPercent title=百分号 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/percent.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP><A class=tbButton id=cmdThousand title=千分位 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/format/thousand.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="100%"></TD>
	</TR>
</TABLE>
<TABLE class="cbToolbar" id="idTBDesign" style="display: 'none'" cellpadding='0' cellspacing='0' width="100%">
	<TR>
	<TD NOWRAP width="21"><A class=tbButton id=cmdInsertCol title=插入列 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/insertcol.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdInsertRow title=插入行 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/insertrow.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdAppendCol title=追加列 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/appendcol.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdAppendRow title=追加行 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/appendrow.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdDeleteCol title=删除列 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/deletecol.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdDeleteRow title=删除行 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/deleterow.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdSheetSize title=表页尺寸 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/sheetsize.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdMergeCell title=组合单元格 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/mergecell.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdUnMergeCell title=取消单元格组合 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/unmergecell.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdMergeRow title=行组合 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/mergerows.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdMergeCol title=列组合 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/mergecols.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdReCalcAll title=重算全表 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/calculateall.gif" width="16" height="16"></A></TD>
	<TD NOWRAP width="21"><A class=tbButton id=cmdFormulaSum3D title=设置汇总公式 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/sum3d.gif" width="16" height="16"></A></TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdReadOnly title=单元格只读 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/readonly.gif" width="16" height="16"></A></TD>
	<TD NOWRAP id="cmdFillType" Title="填充方式">
		<SELECT name="FillTypeSelect" style="WIDTH: 80px; HEIGHT: 23px" onChange="changeFillType(FillTypeSelect.value)" ACCESSKEY="v" size="1">
          <option value="1" selected 
       >向下填充</option>
          <option value="2">向右填充</option>
          <option value="4">向上填充</option>
          <option value="8">向左填充</option>
          <option value="16">重复填充</option>
          <option value="32">等差填充</option>
          <option value="64">等比填充</option>
        </SELECT>
	</TD>
	<TD class="tbDivider" NOWRAP width="21"><A class=tbButton id=cmdFillSerial title=序列填充 href="javascript:;" name=cbButton><IMG align="middle" src="<%=request.getContextPath()%>/resources/cell/design/fillserial.gif" width="16" height="16"></A></TD>
	
	<TD NOWRAP id="cmdDateType" Title="日期类型">
		<SELECT name="DateTypeSelect" style="WIDTH: 130px; HEIGHT: 23px" onChange="changeDateType(DateTypeSelect.value)" ACCESSKEY="v" size="1">
          <option value="1" selected>1997-3-4</option>
          <option value="2">1997-03-04 13:30:12</option>
          <option value="3">1997-3-4 1:30 PM</option>
          <option value="4">1997-3-4 13:30</option>
          <option value="5">97-3-4</option>
          <option value="6">3-4-97</option>
          <option value="7">03-04-97</option>
          <option value="8">3-4</option>
          <option value="9">一九九七年三月四日</option>
          <option value="10">一九九七年三月</option>
          <option value="11">三月四日</option>
          <option value="12">1997年3月4日</option>
          <option value="13">1997年3月</option>
          <option value="14">3月4日</option>
          <option value="15">星期二</option>
          <option value="16">二</option>
          <option value="17">4-Mar</option>
          <option value="18">4-Mar-97</option>
          <option value="19">04-Mar-97</option>
          <option value="20">Mar-97</option>
          <option value="21">March-97</option>
	  	  <option value="22">1997-03-04</option>
        </SELECT>
	</TD>
	<TD class="tbDivider" NOWRAP id="cmdTimeType" Title="时间类型">
		<SELECT name="TimeTypeSelect" style="WIDTH: 110px; HEIGHT: 23px" onChange="changeTimeType(TimeTypeSelect.value)" ACCESSKEY="v" size="1">
          <option value="1" selected>1:30</option>
          <option value="2">1:30 PM</option>
          <option value="3">13:30:00</option>
          <option value="4">1:30:00 PM</option>
          <option value="5">13时30分</option>
          <option value="6">13时30分00秒</option>
          <option value="7">下午1时30分</option>
          <option value="8">下午1时30分00秒</option>
          <option value="9">十三时三十分</option>
          <option value="10">下午一时三十分</option>
        </SELECT>
	</TD>
	<TD width="100%">
	</TD>
	</TR>
</TABLE>