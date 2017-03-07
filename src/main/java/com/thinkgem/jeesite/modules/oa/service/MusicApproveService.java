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
import com.thinkgem.jeesite.modules.oa.dao.MusicApproveDao;
import com.thinkgem.jeesite.modules.oa.entity.MusicApprove;
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
public class MusicApproveService extends CrudService<MusicApproveDao, MusicApprove> {

	@Autowired
	private ActTaskService actTaskService;
	
	public MusicApprove getByProcInsId(String procInsId) {
		return dao.getByProcInsId(procInsId);
	}
	
	public Page<MusicApprove> findPage(Page<MusicApprove> page, MusicApprove musicApprove) {
		musicApprove.setPage(page);
		page.setList(dao.findList(musicApprove));
		return page;
	}
	
	/**
	 * 审核新增或编辑
	 * @param musicApprove
	 */
	@Transactional(readOnly = false)
	public void save(MusicApprove musicApprove) {
		
		// 申请发起
		if (StringUtils.isBlank(musicApprove.getId())){
			musicApprove.preInsert();
			dao.insert(musicApprove);
			
			// 启动流程
			actTaskService.startProcess(ActUtils.PD_MUSIC_APPROVE[0], ActUtils.PD_MUSIC_APPROVE[1], musicApprove.getId(), musicApprove.getContractNo());
			
		}
		
		// 重新编辑申请		
		else{
			musicApprove.preUpdate();
			dao.update(musicApprove);

			musicApprove.getAct().setComment(("yes".equals(musicApprove.getAct().getFlag())?"[重申] ":"[销毁] "));//+musicApprove.getAct().getComment());

			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			vars.put("pass", "yes".equals(musicApprove.getAct().getFlag())? "1" : "0");
			actTaskService.complete(musicApprove.getAct().getTaskId(), musicApprove.getAct().getProcInsId(), musicApprove.getAct().getComment(), musicApprove.getContractNo(), vars);
		}
	}

	/**
	 * 审核审批保存
	 * @param musicApprove
	 */
	@Transactional(readOnly = false)
	public void adSave(MusicApprove musicApprove) {
		
		// 设置意见
		musicApprove.getAct().setComment(("yes".equals(musicApprove.getAct().getFlag())?"[同意] ":"[驳回] ")+musicApprove.getAct().getComment());
		
		musicApprove.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = musicApprove.getAct().getTaskDefKey();

		// 审核环节
		if ("approve".equals(taskDefKey)){
			musicApprove.setApproveLeader(musicApprove.getAct().getComment());
			dao.updateLeaderText(musicApprove);
		}
		else if ("approve2".equals(taskDefKey)){
			musicApprove.setApproveResponser(musicApprove.getAct().getComment());
			dao.updateResponserText(musicApprove);
		}
		else if ("approve3".equals(taskDefKey)){
			musicApprove.setApproveOperator(musicApprove.getAct().getComment());
			dao.updateOperatorText(musicApprove);
		}
		else if ("apply_end".equals(taskDefKey)){
			
		}
		
		// 未知环节，直接返回
		else{
			return;
		}
		
		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "yes".equals(musicApprove.getAct().getFlag())? "1" : "0");
		actTaskService.complete(musicApprove.getAct().getTaskId(), musicApprove.getAct().getProcInsId(), musicApprove.getAct().getComment(), vars);

//		vars.put("var_test", "yes_no_test2");
//		actTaskService.getProcessEngine().getTaskService().addComment(musicApprove.getAct().getTaskId(), musicApprove.getAct().getProcInsId(), musicApprove.getAct().getComment());
//		actTaskService.jumpTask(musicApprove.getAct().getProcInsId(), musicApprove.getAct().getTaskId(), "ad2", vars);
	}
	
}
