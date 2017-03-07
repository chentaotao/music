<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<form:form class="form-horizontal">
		<fieldset>
			<legend>审批详情</legend>
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
								<label class="control-label">备注</label>
								<div class="controls">
									<div class="textarea">
										${musicApprove.memo}
									</div>
								</div>
							</div>
							<c:forEach items="${musicCommentList}" var="musicComment">
								<br/>
							<div name="musicComment">
								<label class="control-label">播出内容 [${musicApprove.contractNo}]</label>
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
	</form:form>
</body>
</html>
