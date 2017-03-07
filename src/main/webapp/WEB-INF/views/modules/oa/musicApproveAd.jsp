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
		<li><a href="${ctx}/oa/musicApprove/">审批列表</a></li>
		<li class="active"><a href="#"><shiro:hasPermission name="oa:musicApprove:edit">${musicApprove.act.taskName}</shiro:hasPermission><shiro:lacksPermission name="oa:musicApprove:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="musicApprove" action="${ctx}/oa/musicApprove/saveAd" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<fieldset>
			<legend>${musicApprove.act.taskName}</legend>
			<div class="control-group">
				<label class="control-label" >客户名称</label>
				<div class="controls">
						${musicApprove.customer}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" >合同号</label>
				<div class="controls">
						${musicApprove.contractNo}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" >业务联系人</label>
				<div class="controls">
						${musicApprove.linkman}
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" >业务联系人电话</label>
				<div class="controls">
						${musicApprove.linkmanPhone}
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">附件</label>
				<div class="controls">
					<a href="${ctx}/oa/musicApprove/fileDownload?filePath=${musicApprove.uploadFile}">下载附件</a>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">备注</label>
				<div class="controls">
					${musicApprove.memo}
				</div>
			</div>
			<c:forEach items="${musicCommentList}" var="musicComment">
				<div name="musicComment">
					<label class="control-label">播出内容</label>
					<table class="table-form">
						<tbody>
						<tr>
							<td class="tit" style="width:20%">行业类型</td>
							<td style="width:30%">${musicComment.industryTyp}</td>
							<td class="tit" style="width:20%">类别</td>
							<td style="width:30%">${musicComment.typ}</td>
						</tr>
						<tr>
							<td class="tit" style="width:20%">播出内容</td>
							<td style="width:30%">${musicComment.playContent}</td>
							<td class="tit" style="width:20%">播出要求</td>
							<td style="width:30%">${musicComment.playRequire}</td>
						</tr>
						<tr>
							<td class="tit" style="width:20%">播出日期</td>
							<td style="width:30%">${musicComment.playDay}</td>
							<td class="tit" style="width:20%">播出时间</td>
							<td style="width:30%">${musicComment.playTime}</td>
						</tr>
						<tr>
							<td class="tit" style="width:20%">播出时段</td>
							<td colspan="3" style="width:80%">${musicComment.playBetween}</td>
						</tr>
						</tbody>
					</table>
				</div>
				<br/>
			</c:forEach>
			<div class="control-group">
				<label class="control-label">广告部副总签字</label>
				<div class="controls">
						${musicApprove.approveLeader}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">制作部负责人签字</label>
				<div class="controls">
						${musicApprove.approveOperator}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">上单人员签字</label>
				<div class="controls">
						${musicApprove.approveOperator}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">您的意见</label>
				<div class="controls">
					<form:textarea path="act.comment" class="required" rows="5" maxlength="20" cssStyle="width:500px"/>
				</div>
			</div>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="oa:musicApprove:edit">
				<c:if test="${musicApprove.act.taskDefKey eq 'apply_end'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="完 成" onclick="$('#flag').val('yes')"/>&nbsp;
				</c:if>
				<c:if test="${musicApprove.act.taskDefKey ne 'apply_end'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
					<c:if test="${musicApprove.act.taskDefKey ne 'approve3'}">
						<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
					</c:if>
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<act:histoicFlow procInsId="${musicApprove.act.procInsId}"/>
	</form:form>
</body>
</html>
