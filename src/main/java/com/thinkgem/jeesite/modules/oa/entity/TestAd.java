/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.entity;

import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Value;

/**
 * 审批Entity
 * @author thinkgem
 * @version 2014-05-16
 */
public class TestAd extends ActEntity<TestAd> {

	private static final long serialVersionUID = 1L;
	private String customer;			// 客户名称
	private String contractNo;		// 合同号
	private String linkman;			// 业务联系人
	private String linkmanPhone;		// 业务联系人电话
	private String industryTyp;		//行业类型
	private String typ;				// 类别
	private String playContent;		// 播出内容
	private String playRequire;		// 播出要求
	private String playTime;		// 播出时间
	private String playBetween;		// 播出时段
	private String playDay;		// 播出日期
	private String memo;			//备注
	private String approveLeader;	// 广告部副总签字
	private String approveResponser;		// 制作部负责人签字
	private String approveOperator;		// 上单人员签字上单


	public TestAd() {
		super();
	}

	public TestAd(String id){
		super(id);
	}
	@Length(min=0, max=64, message="客户名称长度必须介于 0 和 64 之间")
	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	@Length(min=0, max=64, message="合同号长度必须介于 0 和 64 之间")
	@Value("")
	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	@Length(min=0, max=255, message="业务联系人长度必须介于 0 和 255 之间")
	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	@Length(min=0, max=11, message="业务联系人电话长度必须介于 0 和 11 之间")
	public String getLinkmanPhone() {
		return linkmanPhone;
	}

	public void setLinkmanPhone(String linkmanPhone) {
		this.linkmanPhone = linkmanPhone;
	}

	@Length(min=0, max=255, message="类别长度必须介于 0 和 255 之间")
	public String getIndustryTyp() {
		return industryTyp;
	}

	public void setIndustryTyp(String industryTyp) {
		this.industryTyp = industryTyp;
	}

	@Length(min=0, max=255, message="类别长度必须介于 0 和 255 之间")
	public String getTyp() {
		return typ;
	}

	public void setTyp(String typ) {
		this.typ = typ;
	}

	@Length(min=0, max=255, message="播出内容长度必须介于 0 和 255 之间")
	public String getPlayContent() {
		return playContent;
	}

	public void setPlayContent(String playContent) {
		this.playContent = playContent;
	}

	@Length(min=0, max=255, message="播出要求长度必须介于 0 和 255 之间")
	public String getPlayRequire() {
		return playRequire;
	}

	public void setPlayRequire(String playRequire) {
		this.playRequire = playRequire;
	}

	@Length(min=0, max=255, message="播出时间长度必须介于 0 和 255 之间")
	public String getPlayTime() {
		return playTime;
	}

	public void setPlayTime(String playTime) {
		this.playTime = playTime;
	}

	@Length(min=0, max=1024, message="播出时段长度必须介于 0 和 1024 之间")
	public String getPlayBetween() {
		return playBetween;
	}

	public void setPlayBetween(String playBetween) {
		this.playBetween = playBetween;
	}

	@Length(min=0, max=255, message="播出日期长度必须介于 0 和 255 之间")
	public String getPlayDay() {
		return playDay;
	}

	public void setPlayDay(String playDay) {
		this.playDay = playDay;
	}

	@Length(min=0, max=255, message="长度必须介于 0 和 255 之间")
	public String getApproveLeader() {
		return approveLeader;
	}

	public void setApproveLeader(String approveLeader) {
		this.approveLeader = approveLeader;
	}
	@Length(min=0, max=255, message="长度必须介于 0 和 255 之间")
	public String getApproveResponser() {
		return approveResponser;
	}

	public void setApproveResponser(String approveResponser) {
		this.approveResponser = approveResponser;
	}
	@Length(min=0, max=255, message="长度必须介于 0 和 255 之间")
	public String getApproveOperator() {
		return approveOperator;
	}

	public void setApproveOperator(String approveOperator) {
		this.approveOperator = approveOperator;
	}

	@Length(min=0, max=255, message="备注长度必须介于 0 和 255 之间")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

}


