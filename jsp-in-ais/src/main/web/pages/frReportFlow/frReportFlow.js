var frflow = {
    // 工作流是否为最后一步
    isFlowLastStep:function(){
        try{
            var nodeObj = $("select[name='formInfo.toNodeId']");
            if(nodeObj && nodeObj.length){
                var nodename = nodeObj.val();
                if(nodename && 
                    (nodename.indexOf("结束") != -1 ||nodename.indexOf('完成') != -1)){
                     return true;
                }
            }
            return false;
        }catch(e){
            alert('isFlowLastStep:\n'+e.message);
        }
    },
    
    // 生成年份下拉选择
    genYearSelectOption:function(selectObjId, curYear, offsetYear){
        try{
            var selectObj = $('#'+selectObjId);
            if(curYear && selectObj && selectObj.length){
                curYear = parseInt(curYear);
                offsetYear = parseInt(offsetYear);
                selectObj.append("<option value=''>请选择</option>");
                for(var i=curYear-offsetYear; i<curYear+offsetYear+1; i++){
                    selectObj.append("<option value='"+i+"'>"+i+"</option>");
                }
                selectObj.val(curYear);
            }
        }catch(e){
            alert('genSelectOption:\n'+e.message);
        }
    },
    // 生成状态下拉选择
    genStatusSelectOption:function (selectObjId, statusArr){
        try{
            var selectObj = $('#'+selectObjId);
            if(selectObj && selectObj.length && statusArr && statusArr.length){
                selectObj.append("<option value=''>请选择</option>");
                for(var i=0; i<statusArr.length; i++){
                    var a = statusArr[i].split('=');
                    selectObj.append("<option value='"+$.trim(a[0])+"'>"+$.trim(a[1])+"</option>");
                }
            }
        }catch(e){
            alert('genSelectOption:\n'+e.message);
        }
    },
    // 获得预览报表模板url
    getFrViewTemplateUrl:function (url, nopaging){
        try{
            if(url){
                var index = url.indexOf('.cpt');
                var arr = [];
                arr.push(url.substr(0,index));
                arr.push('_view');
                arr.push(url.substr(index));
                var reportUrl = arr.join('');
                return  nopaging ? frflow.urlNoPaging(reportUrl) : reportUrl;  
            }
            return url;
        }catch(e){
            alert('getFrViewTemplateUrl:\n'+e.message);
        }
    },
    urlNoPaging:function(reportUrl){
    	if(reportUrl){
            var rpsArr = ["&op=write","&op=view","&__bypagesize__=false"];
            for(var rps in rpsArr){
            	var i = reportUrl.lastIndexOf("&");
                if(i && reportUrl.substr(i) == rps){
                	reportUrl = reportUrl.substr(0,i);
                }
            }
    	}
    	return reportUrl+"&__bypagesize__=false";
    },
    // 报表预览-模板预览
    viewFrTemplate:function(row, isUseTemplate){
        try{
            if(row){              
                if(isUseTemplate){
                    var reportUrl = row.reportUrl;                         
                    var templateFileName = row.templateFileName;
                    var cindex = templateFileName.indexOf('.cpt');
                    var arr = [];
                    arr.push(templateFileName.substr(0,cindex));
                    arr.push('_view');
                    arr.push(templateFileName.substr(cindex));
                    templateFileName = arr.join('');
                    if(reportUrl){
                        var viewReportUrl = frflow.getFrViewTemplateUrl(reportUrl,true);
                        $.post('/ais/commonPlug/isHaveTemplate.action','templateFileName='+templateFileName, 
                            function(data){
                                if(data.type == 'error'){
                                	top.$.messager.alert('警告',data.msg,'error');
                                }else{
                                    frflow.openFrViewWindow(viewReportUrl);
                                }
                            }
                       );
                    } 
                }else{
                    var reportContent = row.reportContent;
                    if(reportContent){
                        var cellList = eval(reportContent);
                        var maxTr = 0;
                        for(var i=0; i<cellList.length; i++){
                            var rowIndex = cellList[i].rowIndex;
                            if(rowIndex > maxTr){
                                maxTr = rowIndex;
                            }
                        }
                        var rows = [];
                        for(var i=0; i<maxTr+1; i++){
                            var row = [];
                            $.each(cellList, function(k, cell){
                                var rowIndex = cell.rowIndex;
                                if(i == rowIndex){
                                    row[cell.colIndex] = cell;
                                }
                            });
                            rows.push(row);
                        }
                        var html = [];
                        html.push("<table style='text-align:center;border-width:0px; border-collapse:collapse;'>");
                        $.each(rows, function(i, row){
                            html.push("<tr>");
                            $.each(row, function(j, col){
                            	html.push("<td style='");
                            	if(i>1){
                            		html.push("border:1px solid #cccccc;");
                            	}else{
                            		if(i == 0) html.push("font-weight:bold;font-size:18px;");
                            		if(i == 1) html.push("font-size:13px;");
                            	}
                            	html.push("text-align:center;white-space:nowrap;' ");
                                html.push("rowSpan='");
                                html.push(col.rowSpan);
                                html.push("' colSpan='");
                                html.push(col.colSpan);
                                html.push("'>");
                                html.push(col.value);
                                html.push("</td>");
                            });
                            html.push("</tr>");
                        });

                        html.push("<table>");
                        //alert(html.join(''))
                        return html.join('');
                    }
                }
            }
        }catch(e){
            alert("viewFrTemplate:\n"+e.message);
        }
        return null;
    },
    
    // 报表预览-快照预览
    viewFrSnapshot:function(row){
        var rows = row ? [row] : null;
        if(rows == null || rows.length == 0){
        	top.$.messager.alert('警告','请选择预览记录','error');
            return;
        }						
        if(rows && rows.length > 1){
        	top.$.messager.alert('提示','预览时只能选择一条记录！','error');
        }else{
            var row = rows[0];
            var reportContent = row.reportContent;
            //alert('reportContent:\n'+reportContent);
            if(reportContent){          
                var rpwin = frflow.openFrViewWindow(null);        
                if(rpwin){
                    //reportContent = decode64(reportContent);
                    //alert(reportContent)
                    //rpwin.document.write(reportContent);
                   rpwin.document.write(reportContent);
                   frflow.setReportReadOnly(rpwin);
                }           
            }else{
            	top.$.messager.alert('提示','没有预览内容！','error');
            }
        }				    	
    },

    // 根据url全屏打开一个窗口
    openFrViewWindow:function(url){
        try{
           var w = $(top).width();
           var h = $(top).height();
           var rpwin = window.open (url ? url : "/ais/pages/frReportFlow/frViewTemplate.jsp",'报表预览','height='+h+',width='+w+',top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yew,location=no, status=no');       
           return rpwin;
        }catch(e){
            alert("openFrViewWindow:\n"+e.message);
        }
    },


    // 把报表页面设置为只读
    setReportReadOnly:function (win){
        var classname = "x-table";
        if(win){
            var doc = win.document;
            if(doc){
                var content = $(doc).find('.'+classname);
                var clen = content.length;
                var maxtry = 30;
                var offset = 200;
                var w = $(doc).width();
                var h = $(doc).height()*0.95;
                var interval = window.setInterval(function(){
                    if(clen || maxtry == 0){
                        $(doc).find('.x-toolbar').width(w);
                        $(doc).find('.content-container, .reportPane').css({'width':w,'height':h});
                        frflow.genReportMask(content,win);
                        interval ? window.clearInterval(interval) : null;
                    }else{
                        content = $(doc).find('.'+classname);
                        clen = content.length;
                        maxtry--;
                    }
                }, offset);
            }
        }   
    },



    genReportMask:function(content,win){
        try{
            var doc = win.document;
            var cpst = content.position();
            if(content.length){
                var mask = doc.createElement("div");
                var w = content.width();
                var h = content.height();
                //alert(w+' '+h)
                //alert(cpst.top+' '+cpst.left)
                $(mask).attr('id','reportFlowMask').css({
                    'display':'inline',
                    'overflow':'hidden',
                    'position':'absolute',
                    'top':cpst.top,
                    'left':cpst.left,
                    'width':w,
                    'height':h,
                    'background-color':'white',
                    'filter':"alpha(opacity=1)"
                });
                $(content).parent().append(mask);
            } 
        }catch(e){
            alert('genReportMask:\n'+e.message);
        }
    },
    //设置快照
    setFrSnapshot:function(win, rpcontentId){
        try{
            var classname = "x-table";
            if(win && win.document){
                var content = $(win.document).find('.'+classname);
                var clen = content.length;
                var maxtry = 50;
                var offset = 200;
                var interval = window.setInterval(function(){
                    if(clen || maxtry == 0){
                       interval ? window.clearInterval(interval) : null;
                       $('#submitBtn').show();
                       /*
                       var ctobj = $('#'+rpcontentId);
                       var snapshot = ctobj.val();
                       if(!snapshot){
                           snapshot = $(win.document).find('html').html();
                           ctobj.val(snapshot);
                       }
                       content.find("tr[tridx]:visible:eq(2)").children('td:visible').each(function(i){
                           var td = $(this);
                           alert("i="+i+","+td.text()+", rowSpan="+td.attr('rowSpan'));
                       });
                       */
                    }else{
                        content = $(win.document).find('.'+classname);
                        clen = content.length;
                        maxtry--;
                    }
                }, offset);
            }  
        }catch(e){
            alert("setFrSnapshot:\n"+e.message);
        } 
    },
    // 获得报表结构化数据，返回一个数组[{},{}]字符串,每个数组元素为一个json对象字符串
    getFrTableCellData:function(win, formId){
    	try{
    		var rtjson = {};
            if(win && win.document){
               var classname = "x-table";
               var data = [];
               var content = $(win.document).find('.'+classname);
               var trs = content.find("tr[tridx]:visible");
               // 最大行数，最大列数
               var maxTd = 0;
               var maxTr = trs.length;          
               var span = [];
               for(var i=0; i<maxTr; i++){                  
            	   var tds = $(trs.get(i)).children('td:visible');
            	   var tdlen = tds.length;
            	   maxTd = tdlen > maxTd ? tdlen : maxTd;
                   // 当前列所处的列号
                   var col = 0;
            	   for(var j=0; j<tdlen; j++){                      
            		   var value = "";
            		   var td = $(tds.get(j));  
                       
            		   var rowSpan = td.attr('rowSpan');
                       rowSpan = rowSpan ? rowSpan : 1;                    
                       var colSpan = td.attr('colSpan');
                       colSpan = colSpan ? colSpan : 1;
                       
                       // 遍历由于跨行导致列下标变化的坐标数字，改变当前列的坐标
                       for(var r=0; r<span.length; r++){ 
                            if(col == span[r][0] && i == span[r][1]){
                                ++col; 
                            } 
                       } 
                       
                       if(rowSpan > 1){
                           // 把跨行的列影响的列坐标保存，供下一次遍历列，查询是否影响下面的列，从而改变列下标
                           for(var x=col; x<col+colSpan; x++){
                               for(var y=i+1; y<i+rowSpan; y++){
                                   span.push([x,y]);
                               }  
                           }
                       }
                                    
            		   var beginRowIndex = i;
            		   var endRowIndex = beginRowIndex + rowSpan - 1;           		   
                                           
            		   var beginColIndex = col;
            		   var endColIndex = beginColIndex + colSpan - 1;                   
            		   col = endColIndex + 1;
                       
            		   var headTd = td.find('td:visible[hv=true]');
            		   if(headTd.length){
            			   value = headTd.text();
            		   }else{
            			   value = td.text();
            		   }
            		   
            		   var cell = [];
            		   cell.push("{");
                       cell.push("'formId':'");
                       cell.push(formId);
                       cell.push("',");
                       cell.push("'rowIndex':'");
                       cell.push(i);
                       cell.push("',");
                       cell.push("'rowSpan':'");
                       cell.push(rowSpan);
                       cell.push("',");
                       cell.push("'colIndex':'");
                       cell.push(j);
                       cell.push("',");
                       cell.push("'colSpan':'");
                       cell.push(colSpan);
                       cell.push("',");
                       cell.push("'value':'");
                       cell.push(value);
                       cell.push("',");                    
                       cell.push("'beginRowIndex':'");
                       cell.push(beginRowIndex);
                       cell.push("',");                     
                       cell.push("'endRowIndex':'");
                       cell.push(endRowIndex);
                       cell.push("',");
                       cell.push("'beginColIndex':'");
                       cell.push(beginColIndex);
                       cell.push("',");                      
                       cell.push("'endColIndex':'");
                       cell.push(endColIndex);
            		   cell.push("'}");
            		   data.push(cell.join(''));
            	   }
               }
               rtjson = {
            	  'formId':formId,
            	  'maxTr':maxTr,
            	  'maxTd':maxTd,
            	  'tableData':"["+data.join(",")+"]"
               };
            }
            return rtjson;
    	}catch(e){
    		alert("getFrTableCellData:\n"+e.message);
    	}
    } 
}











