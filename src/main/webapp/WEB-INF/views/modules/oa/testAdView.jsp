<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oa/testAd/">审批列表</a></li>
		<li class="active"><a href="${ctx}/oa/testAd/form/?procInsId=${testAd.procInsId}">审批详情</a></li>
	</ul>
	<form:form class="form-horizontal">
		<sys:message content="${message}"/>
		<fieldset>
			<legend>审批详情</legend>
			<table class="table-form">
				<tr>
					<td class="tit">客户名称</td>
					<td>
						${testAd.customer}
					</td>
					<td class="tit">合同号</td>
					<td>
						${testAd.customer}
					</td>
				</tr>
				<tr>
					<td class="tit">业务联系人</td>
					<td>
						${testAd.linkman}
					</td>
					<td class="tit">业务联系人电话</td>
					<td>
						${testAd.linkmanPhone}
					</td>
				</tr>
				<tr>
					<td class="tit">行业类型</td>
					<td>
						${testAd.industryTyp}
					</td>
					<td class="tit">类别</td>
					<td>
						${testAd.typ}
					</td>
				</tr>
				<tr>
					<td class="tit">播出内容</td>
					<td>
						${testAd.playContent}
					</td>
					<td class="tit">播出要求</td>
					<td>
						${testAd.playRequire}
					</td>
				</tr>
				<tr>
					<td class="tit">播出日期</td>
					<td >
						${testAd.playDay}
					</td>
					<td class="tit">播出时间</td>
					<td>
						${testAd.playTime}
					</td>
				</tr>
				<tr>
					<td class="tit">播出时段</td>
					<td colspan="5">
						${testAd.playBetween}
					</td>
				</td>
				</tr>
				<tr>
					<td class="tit">备注</td>
					<td colspan="5">
						${testAd.memo}
					</td>
				</tr>
				<tr>
					<td class="tit">广告部副总签字</td>
					<td colspan="5">
						${testAd.approveLeader}
					</td>
				</tr>
				<tr>
					<td class="tit">制作部负责人签字</td>
					<td colspan="5">
						${testAd.approveResponser}
					</td>
				</tr>
				<tr>
					<td class="tit">上单人员签字</td>
					<td colspan="5">
						${testAd.approveOperator}
					</td>
				</tr>
			</table>
		</fieldset>
		<act:histoicFlow procInsId="${testAd.act.procInsId}" />
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
