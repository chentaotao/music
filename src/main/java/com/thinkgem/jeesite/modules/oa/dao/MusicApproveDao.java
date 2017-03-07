/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.oa.entity.MusicApprove;

/**
 * 审批DAO接口
 * @author thinkgem
 * @version 2014-05-16
 */
@MyBatisDao
public interface MusicApproveDao extends CrudDao<MusicApprove> {

	public MusicApprove getByProcInsId(String procInsId);
	
	public int updateInsId(MusicApprove MusicApprove);


    void updateLeaderText(MusicApprove musicApprove);

	void updateResponserText(MusicApprove musicApprove);

	void updateOperatorText(MusicApprove musicApprove);
}
