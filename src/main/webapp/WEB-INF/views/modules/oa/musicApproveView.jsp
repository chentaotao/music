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
		<li><a href="${ctx}/oa/musicApprove/">审批列表</a> </li>
		<li class="active"><a href="${ctx}/oa/musicApprove/form/?procInsId=${musicApprove.procInsId}">审批详情</a></li>
	</ul>
	<form:form class="form-horizontal">
		<sys:message content="${message}"/>
		<fieldset>
			<legend>审批详情 &nbsp;&nbsp;<a href="${ctx}/oa/musicApprove/printCurr?id=${musicApprove.id}" target="_blank" style="float:right;">打印当前页</a></legend>
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<fieldset>
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
									<div class="textarea">
										${musicApprove.memo}
									</div>
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
							</c:forEach>
							<br/>
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
						</fieldset>
					</div>
				</div>
			</div>
		</fieldset>
		<act:histoicFlow procInsId="${musicApprove.act.procInsId}" />
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
