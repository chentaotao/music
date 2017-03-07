/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.oa.entity.TestAd;

/**
 * 审批DAO接口
 * @author thinkgem
 * @version 2014-05-16
 */
@MyBatisDao
public interface TestAdDao extends CrudDao<TestAd> {

	public TestAd getByProcInsId(String procInsId);
	
	public int updateInsId(TestAd TestAd);


    void updateLeaderText(TestAd testAd);

	void updateResponserText(TestAd testAd);

	void updateOperatorText(TestAd testAd);
}
