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
		<li class="active"><a href="${ctx}/oa/testAd/form?id=${testAd.id}"><shiro:hasPermission name="oa:testAd:edit">审批${not empty testAd.id?'修改':'申请'}流程</shiro:hasPermission><shiro:lacksPermission name="oa:testAd:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="testAd" action="${ctx}/oa/testAd/save" method="post" class="form-horizontal" enctype="multipart/form-data"  onsubmit="loading('正在创建，请稍等...');">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<fieldset>
			<legend>审批申请</legend>
			<table class="table-form">
				<tr>
					<td class="tit">客户名称</td>
					<td>
						<form:input path="customer" htmlEscape="false" maxlength="64" class="input-xlarge " />
					</td>
					<td class="tit">合同号</td>
					<td>
						<form:input path="contractNo" htmlEscape="false" maxlength="64" class="input-xlarge " />
					</td>
				</tr>
				<tr>
					<td class="tit">业务联系人</td>
					<td>
						<form:input path="linkman" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
					<td class="tit">业务联系人电话</td>
					<td>
						<form:input path="linkmanPhone" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
				</tr>
				<tr>
					<td class="tit">行业类型</td>
					<td>
						<form:input path="industryTyp" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
					<td class="tit">类别</td>
					<td>
						<form:input path="typ" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
				</tr>
				<tr>
					<td class="tit">播出内容</td>
					<td>
						<form:input path="playContent" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
					<td class="tit">播出要求</td>
					<td>
						<form:input path="playRequire" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
				</tr>
				<tr>
					<td class="tit">播出日期</td>
					<td>
						<form:input path="playDay" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
					<td class="tit">播出时间</td>
					<td>
						<form:input path="playTime" htmlEscape="false" maxlength="255" class="input-xlarge " />
					</td>
				</tr>
				<tr>
					<td class="tit">播出时段</td>
					<td colspan="5">
						<form:textarea path="playBetween" class="required" rows="5" maxlength="200" cssStyle="width:500px" />
					</td>
				</tr>
				<tr>
					<td class="tit">备注</td>
					<td colspan="5">
						<form:textarea path="memo"  rows="5" maxlength="200" cssStyle="width:500px" />
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="oa:testAd:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${not empty testAd.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<c:if test="${not empty testAd.id}">
			<act:histoicFlow procInsId="${testAd.act.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>
