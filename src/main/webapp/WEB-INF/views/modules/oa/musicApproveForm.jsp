<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.blur {
			border: 1px solid red;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#btnSubmit").click(function(){
			    var flag = true;
				var customer = $("[name='customer']").val();
				if(customer==""){
                    $("[name='customer']").addClass("blur");
                    $("[name='customer']").parent().parent().find(".help-block").css("display","block");
					flag = false;
				}
                var contractNo = $("[name='contractNo']").val();
                if(customer==""){
                    $("[name='contractNo']").parent().parent().find(".help-block").css("display","block");
                    flag = false;
                }
                var linkman = $("[name='linkman']").val();
                if(customer==""){
                    $("[name='linkman']").parent().parent().find(".help-block").css("display","block");
                    flag = false;
                }
                var linkmanPhone = $("[name='linkmanPhone']").val();
                var memo = $("[name='memo']").val();
                var industryTyp = "";
				$("[name='industryTyp']").each(function(){
					if($(this).val()==""){
                        $(this).addClass("blur");
                        flag = false;
					}
					industryTyp = industryTyp+$(this).val()+";";
				})
                var typ = "";
                $("[name='typ']").each(function(){
                    if($(this).val()==""){
                        $(this).parent().parent().find(".help-block").css("display","block");
                        flag = false;
                    }
                    typ = typ+$(this).val()+";";
                })
                var playContent = "";
                $("[name='playContent']").each(function(){
                    if($(this).val()==""){
                        $(this).parent().parent().find(".help-block").css("display","block");
                        flag = false;
                    }
                    playContent = playContent+$(this).val()+";";
                })
                var playRequire = "";
                $("[name='playRequire']").each(function(){
                    if($(this).val()==""){
                        $(this).parent().parent().find(".help-block").css("display","block");
                        flag = false;
                    }
                    playRequire = playRequire+$(this).val()+";";
                })
                var playDay = "";
                $("[name='playDay']").each(function(){
                    if($(this).val()==""){
                        $(this).parent().parent().find(".help-block").css("display","block");
                        flag = false;
                    }
                    playDay = playDay+$(this).val()+";";
                })
                var playTime = "";
                $("[name='playTime']").each(function(){
                    if($(this).val()==""){
                        $(this).parent().parent().find(".help-block").css("display","block");
                        flag = false;
                    }
                    playTime = playTime+$(this).val()+";";
                })
                var playBetween = "";
                $("[name='playBetween']").each(function(){
                    console.log($(this).html());
                    if($(this).val()==""){
                        $(this).parent().parent().find(".help-block").css("display","block");
                        flag = false;
                    }
                    playBetween = playBetween+$(this).val()+";";
                })
				console.log("customer :"+customer);
                console.log("contractNo :"+contractNo);
                console.log("linkman :"+linkman);
                console.log("linkmanPhone :"+linkmanPhone);
                console.log("memo :"+memo);
                console.log("industryTyp :"+industryTyp);
                console.log("typ :"+typ);
                console.log("playContent :"+playContent);
                console.log("playRequire :"+playRequire);
                console.log("playDay :"+playDay);
                console.log("playTime :"+playTime);
                console.log("playBetween :"+playBetween);
				if(flag){
				    console.log("提交申请");
                    $("#inputForm").submit();
				}else{
				    console.log("请填写相应内容");
				    return false;
				}

			});
			$("[name='addDivWithMusicComment']").click(function () {
				console.log("ctt");
				var divTest = $(this).parent();
				var newDiv = divTest.clone(true);
				divTest.after(newDiv);
				newDiv.find("[name='industryTyp']").val("");
                newDiv.find("[name='typ']").val("");
                newDiv.find("[name='playContent']").val("");
                newDiv.find("[name='playRequire']").val("");
                newDiv.find("[name='playDay']").val("");
                newDiv.find("[name='playTime']").val("");
                newDiv.find("[name='playBetween']").val("");
            })
            $("[name='delDivWithMusicComment']").click(function () {
                console.log("ctt del");
                var length = $(".mcCss").length;
                if(length<=1){
                    alert("播出内容至少有一个");
                    return false;
				}else{
                    $(this).parent().remove();
				}

            })
		});

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oa/musicApprove/">审批列表</a></li>
		<li class="active"><a href="${ctx}/oa/musicApprove/form?id=${musicApprove.id}"><shiro:hasPermission name="oa:musicApprove:edit">审批${not empty musicApprove.id?'修改':'申请'}流程</shiro:hasPermission><shiro:lacksPermission name="oa:musicApprove:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form id="inputForm" modelAttribute="musicApprove" action="${ctx}/oa/musicApprove/save" method="post" class="form-horizontal" enctype="multipart/form-data">
		<sys:message content="${message}"/>
		<fieldset>
			<legend>审批申请</legend>
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<fieldset>
							<c:if test="${not empty musicApprove.id}">
								<input type="hidden" name="musicApproveId" value="${musicApprove.id}"/>
								<input type="hidden" name="actTaskId" value="${musicApprove.act.taskId}"/>
								<input type="hidden" name="actTaskName" value="${musicApprove.act.taskName}"/>
								<input type="hidden" name="actTaskDefKey" value="${musicApprove.act.taskDefKey}"/>
								<input type="hidden" name="actProcInsId" value="${musicApprove.act.procInsId}"/>
								<input type="hidden" name="actProcDefId" value="${musicApprove.act.procDefId}"/>
								<input type="hidden" name="actFlag" id="flag" value="${musicApprove.act.flag}"/>
							</c:if>
							<div class="control-group">
								<label class="control-label" >客户名称</label>
								<div class="controls">
									<input type="text" placeholder="请填写客户名称" name="customer" id="customer" class="input-xlarge" value="${musicApprove.customer}">
									<p class="help-block" style="display: none;color:red;">请填写客户名称</p>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" >合同号</label>
								<div class="controls">
									<input type="text" placeholder="请填写合同号" name="contractNo" id="contractNo" class="input-xlarge"  value="${musicApprove.contractNo}">
									<p class="help-block" style="display: none;color:red;">请填写合同号</p>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" >业务联系人</label>
								<div class="controls">
									<input type="text" placeholder="请填写业务联系人"  name="linkman" id="linkman" class="input-xlarge" value="${musicApprove.linkman}">
									<p class="help-block" style="display: none;color:red;">请填写业务联系人</p>
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" >业务联系人电话</label>
								<div class="controls">
									<input type="text" placeholder="请填写业务联系人电话"  name="linkmanPhone" id="linkmanPhone" class="input-xlarge" value="${musicApprove.linkmanPhone}" onkeyup="this.value=this.value.replace(/\D/g,'')">
									<p class="help-block" style="display: none;color:red;">请填写业务联系人电话</p>
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">附件</label>
								<div class="controls">
									<input class="input-file" id="fileInput"  name="file" type="file" >
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">备注</label>
								<div class="controls">
									<div class="textarea">
										<textarea  name="memo" id="memo" rows="5" maxlength="200" cssStyle="width:500px" style="margin: 0px;  width: 836px;height: 100px;"> ${musicApprove.memo}</textarea>
									</div>
								</div>
							</div>
							<br/>
							<c:if test="${not empty musicApprove.id}">
								<c:forEach items="${musicCommentList}" var="musicComment">
									<div name="musicComment">
										<input type="hidden" name="musicCommentId" value="${musicComment.id}"/>
										<label class="control-label">播出内容</label>
										<table class="table">
											<tbody>
											<tr>
												<td><label class="control-label" >行业类型</label></td>
												<td><input type="text" placeholder="请填写行业类型" name="industryTyp"  class="input-xlarge" value="${musicComment.industryTyp}">
												</td>
												<td><label class="control-label" >类别</label></td>
												<td><input type="text" placeholder="请填写类别" name="typ"  class="input-xlarge" value="${musicComment.typ}">
												</td>
											</tr>
											<tr>
												<td><label class="control-label" >播出内容</label></td>
												<td><input type="text" placeholder="请填写播出内容"  name="playContent"  class="input-xlarge" value="${musicComment.playContent}">
												</td>
												<td><label class="control-label" >播出要求</label></td>
												<td><input type="text" placeholder="请填写播出要求"  name="playRequire"  class="input-xlarge" value="${musicComment.playRequire}">
												</td>
											</tr>
											<tr>
												<td><label class="control-label" >播出日期</label></td>
												<td><input type="text" placeholder="请填写播出日期"  name="playDay"  class="input-xlarge" value="${musicComment.playDay}">
												</td>
												<td><label class="control-label" >播出时间</label></td>
												<td><input type="text" placeholder="请填写播出时间"  name="playTime" class="input-xlarge" value="${musicComment.playTime}">
												</td>
											</tr>
											<tr>
												<td><label class="control-label" >播出时段</label></td>
												<td colspan="3">
													<textarea class="form-control"  name="playBetween"  rows="2" maxlength="200" style="margin: 0px; height: 40px; width: 822px;" >${musicComment.playBetween}</textarea>
												</td>
											</tr>
											</tbody>
										</table>
									</div>
								</c:forEach>
							</c:if>
							<c:if test="${empty musicApprove.id}">
								<div name="musicComment" class="mcCss">
									<label class="control-label">播出内容</label>&nbsp;&nbsp;&nbsp;&nbsp;[<a href="javascript:void(0)" name="addDivWithMusicComment">添加</a>]&nbsp;&nbsp;[<a href="javascript:void(0)" name="delDivWithMusicComment">删除</a>]
									<table class="table">
										<tbody>
										<tr>
											<td><label class="control-label" >行业类型</label></td>
											<td><input type="text" placeholder="请填写行业类型" name="industryTyp"  class="input-xlarge"></td>
											<td><label class="control-label" >类别</label></td>
											<td><input type="text" placeholder="请填写类别" name="typ"  class="input-xlarge"></td>
										</tr>
										<tr>
											<td><label class="control-label" >播出内容</label></td>
											<td><input type="text" placeholder="请填写播出内容"  name="playContent"  class="input-xlarge"></td>
											<td><label class="control-label" >播出要求</label></td>
											<td><input type="text" placeholder="请填写播出要求"  name="playRequire"  class="input-xlarge"></td>
										</tr>
										<tr>
											<td><label class="control-label" >播出日期</label></td>
											<td><input type="text" placeholder="请填写播出日期"  name="playDay"  class="input-xlarge"></td>
											<td><label class="control-label" >播出时间</label></td>
											<td><input type="text" placeholder="请填写播出时间"  name="playTime" class="input-xlarge"></td>
										</tr>
										<tr>
											<td><label class="control-label" >播出时段</label></td>
											<td colspan="3">
												<textarea class="form-control"  name="playBetween"  rows="2" maxlength="200" style="margin: 0px; height: 40px; width: 822px;"></textarea>
											</td>
										</tr>
										</tbody>
									</table>
								</div>
							</c:if>
						</fieldset>
					</div>
				</div>
			</div>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="oa:musicApprove:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${not empty musicApprove.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<c:if test="${not empty musicApprove.id}">
			<act:histoicFlow procInsId="${musicApprove.act.procInsId}" />
		</c:if>
	</form>

</body>
</html>
