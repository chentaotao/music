/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.entity;

import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Value;

/**
 * 审批Entity
 * @author thinkgem
 * @version 2014-05-16
 */
public class MusicComment extends DataEntity<MusicComment> {

	private static final long serialVersionUID = 1L;

	private String industryTyp;		//行业类型
	private String typ;				// 类别
	private String playContent;		// 播出内容
	private String playRequire;		// 播出要求
	private String playTime;		// 播出时间
	private String playBetween;		// 播出时段
	private String playDay;		// 播出日期
	private String uploadFile;	//文件
	private String memo;			//备注

	private String userId;			//用户id
	private String status;			//状态
	private String musicApproveId;	//绑定的审批单


	public MusicComment() {
		super();
	}

	public MusicComment(String id){
		super(id);
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

	public String getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}

	@Length(min=0, max=255, message="备注长度必须介于 0 和 255 之间")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMusicApproveId() {
		return musicApproveId;
	}

	public void setMusicApproveId(String musicApproveId) {
		this.musicApproveId = musicApproveId;
	}
}


