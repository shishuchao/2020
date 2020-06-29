<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>选择需要导出的列</title>
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/portal/ext-all.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/extjs23/ext-base.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/extjs23/ext-all.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/extjs23/DDView.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/extjs23/ItemSelector.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/extjs23/MultiSelect.js"></script>
    <script type="text/javascript" src="columnSelector.js"></script>
    <style>
        .demo-ct .x-panel-btns-ct {
            border-left: 1px solid #99BBE8;
            border-bottom: 1px solid #99BBE8;
            border-right: 1px solid #99BBE8;
            background: #DFE8F6;
            text-align: center;
        }
        .ux-mselect{
		    overflow:auto;
		    background:white;
		    position:relative; /* for calculating scroll offsets */
		    zoom:1;
		    overflow:auto;	
		}
		.ux-mselect-item{
		    font:normal 12px tahoma, arial, helvetica, sans-serif;
		    padding:2px;
		    border:1px solid #fff;
		    white-space: nowrap;
		    cursor:pointer;
		}
		.ux-mselect-selected{
			border:1px dotted #a3bae9 !important;
		    background:#DFE8F6;
		    cursor:pointer;
		}
		
		.x-view-drag-insert-above { 
		    border-top:1px dotted #3366cc; 
		} 
		.x-view-drag-insert-below { 
		    border-bottom:1px dotted #3366cc; 
		} 
    </style>
</head>
<body>
    <div id="itemselector" class="demo-ct"></div>
</body>
</html>