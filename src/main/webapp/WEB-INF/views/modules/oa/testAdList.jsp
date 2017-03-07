<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/testAd/">审批列表</a></li>
		<shiro:hasPermission name="oa:testAd:edit"><li><a href="${ctx}/oa/testAd/form">审批申请流程</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testAd" action="${ctx}/oa/testAd/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>客户名称：</label><form:input path="customer" htmlEscape="false" maxlength="64"/>
		&nbsp;合同号：</label><form:input path="contractNo" htmlEscape="false" maxlength="64"/>
		&nbsp;播出日期：</label><form:input path="playDay" htmlEscape="false" maxlength="64"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>客户名称</th><th>合同号</th><th>业务联系人</th><th>类别</th><th>播出内容</th><th>播出时间</th><th>申请时间</th><shiro:hasPermission name="oa:testAd:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="testAd">
			<tr>
				<td><a href="${ctx}/oa/testAd/form?id=${testAd.id}">${testAd.customer}</a></td>
				<td>${testAd.contractNo}</td>
				<td>${testAd.linkman} / ${testAd.linkmanPhone}</td>
				<td>${testAd.typ}</td>
				<td>${testAd.playContent}</td>
				<td>${testAd.playDay}</td>
				<td><fmt:formatDate value="${testAd.createDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="oa:testAd:edit"><td>
    				<a href="${ctx}/oa/testAd/form?id=${testAd.id}">详情</a>
					<a href="${ctx}/oa/testAd/delete?id=${testAd.id}" onclick="return confirmx('确认要删除该审批吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
