/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.service;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.act.utils.ActUtils;
import com.thinkgem.jeesite.modules.oa.dao.TestAdDao;
import com.thinkgem.jeesite.modules.oa.entity.TestAd;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 审批Service
 * @author thinkgem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class TestAdService extends CrudService<TestAdDao, TestAd> {

	@Autowired
	private ActTaskService actTaskService;
	
	public TestAd getByProcInsId(String procInsId) {
		return dao.getByProcInsId(procInsId);
	}
	
	public Page<TestAd> findPage(Page<TestAd> page, TestAd testAd) {
		testAd.setPage(page);
		page.setList(dao.findList(testAd));
		return page;
	}
	
	/**
	 * 审核新增或编辑
	 * @param testAd
	 */
	@Transactional(readOnly = false)
	public void save(TestAd testAd) {
		
		// 申请发起
		if (StringUtils.isBlank(testAd.getId())){
			testAd.preInsert();
			dao.insert(testAd);
			
			// 启动流程
			actTaskService.startProcess(ActUtils.PD_TEST_AD[0], ActUtils.PD_TEST_AD[1], testAd.getId(), testAd.getContractNo());
			
		}
		
		// 重新编辑申请		
		else{
			testAd.preUpdate();
			dao.update(testAd);

			testAd.getAct().setComment(("yes".equals(testAd.getAct().getFlag())?"[重申] ":"[销毁] "));//+testAd.getAct().getComment());

			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			vars.put("pass", "yes".equals(testAd.getAct().getFlag())? "1" : "0");
			actTaskService.complete(testAd.getAct().getTaskId(), testAd.getAct().getProcInsId(), testAd.getAct().getComment(), testAd.getContractNo(), vars);
		}
	}

	/**
	 * 审核审批保存
	 * @param testAd
	 */
	@Transactional(readOnly = false)
	public void adSave(TestAd testAd) {
		
		// 设置意见
		testAd.getAct().setComment(("yes".equals(testAd.getAct().getFlag())?"[同意] ":"[驳回] ")+testAd.getAct().getComment());
		
		testAd.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = testAd.getAct().getTaskDefKey();

		// 审核环节
		if ("ad".equals(taskDefKey)){
			testAd.setApproveLeader(testAd.getAct().getComment());
			dao.updateLeaderText(testAd);
		}
		else if ("ad2".equals(taskDefKey)){
			testAd.setApproveResponser(testAd.getAct().getComment());
			dao.updateResponserText(testAd);
		}
		else if ("ad3".equals(taskDefKey)){
			testAd.setApproveOperator(testAd.getAct().getComment());
			dao.updateOperatorText(testAd);
		}
		else if ("apply_end".equals(taskDefKey)){
			
		}
		
		// 未知环节，直接返回
		else{
			return;
		}
		
		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "yes".equals(testAd.getAct().getFlag())? "1" : "0");
		actTaskService.complete(testAd.getAct().getTaskId(), testAd.getAct().getProcInsId(), testAd.getAct().getComment(), vars);

//		vars.put("var_test", "yes_no_test2");
//		actTaskService.getProcessEngine().getTaskService().addComment(testAd.getAct().getTaskId(), testAd.getAct().getProcInsId(), testAd.getAct().getComment());
//		actTaskService.jumpTask(testAd.getAct().getProcInsId(), testAd.getAct().getTaskId(), "ad2", vars);
	}
	
}
