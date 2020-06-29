<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title></title>
		<link rel="stylesheet" href="${contextPath}/gantt/css/style.css"/>
		<link rel="stylesheet" href="${contextPath}/gantt/css/bootstrap.min.css"/>
		<script src="${contextPath}/gantt/js/jquery-2.1.4.min.js"></script>
		<script src="${contextPath}/gantt/js/bootstrap.min.js"></script>
		<script src="${contextPath}/gantt/js/jquery.fn.gantt.js"></script>
<%--		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>--%>
	</head>
	<style>
		body{
			font-family: "Microsoft YaHei", 微软雅黑, "MicrosoftJhengHei", 华文细黑, "SimSun", 宋体;
		}
	</style>
	<script>
		$(function () {
			var ganttHeight = window.parent.document.getElementById("centerDiv").style.height;
			if (ganttHeight) {
				$("#ganttDiv").css("height", ganttHeight);
			}
		})
	</script>
	<body style="overflow: hidden;">
		<div id="ganttDiv" class="gantt" style="overflow: hidden;"></div>
		<script>
			$(function () {
				"use strict";
				//初始化gantt
				$(".gantt").gantt({
					source: ${ganttData},
					caption: '${year}' + '年度审计计划',
					year: ${year},
					nameCaption: '项目名称',
					statusCaption: '排程状态',
					descCaption: '提示',
					navigate: 'scroll',//buttons  scroll
					scale: "${ganttScale}",// months  weeks days  hours
					maxScale: "weeks",
					minScale: "days",
					itemsPerPage: 100,
					//onItemClick: function (data) {
					//    alert("Item clicked - show some details");
					//},
					//onAddClick: function (dt, rowId) {
					//    alert("Empty space clicked - add an item!");
					//},
					onRender: function () {
						if (window.console && typeof console.log === "function") {
							console.log("chart rendered");
						}
						var namecells = $(".leftPanel .name .fn-label, .leftPanel .desc .fn-label");
						namecells.mouseenter(function(e){
							var hintText = $(this).html();
							var hint = $('<div class="fn-gantt-cellname-hint" style="background-color: #EFF5FF; opacity: 1;"/>').html(hintText);
							$("body").append(hint);
							hint.css("left", e.pageX);
							hint.css("top", e.pageY);
							hint.show();
						})
						.mouseleave(function () {
							$(".fn-gantt-cellname-hint").remove();
						})
						.mousemove(function (e) {
							$(".fn-gantt-cellname-hint").css("left", e.pageX);
							$(".fn-gantt-cellname-hint").css("top", e.pageY + 10);
						});
					}
				});
			});

			function planName(id){
				var viewUrl = "${contextPath}/plan/detail/view.action?crudId="+id;
				aud$openNewTab("项目信息", viewUrl, true);
			}
		</script>
	</body>
</html>
