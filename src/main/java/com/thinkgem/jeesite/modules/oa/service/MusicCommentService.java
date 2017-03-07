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
import com.thinkgem.jeesite.modules.oa.dao.MusicCommentDao;
import com.thinkgem.jeesite.modules.oa.entity.MusicComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 审批Service
 * @author thinkgem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class MusicCommentService extends CrudService<MusicCommentDao, MusicComment> {

	/**
	 * 审核新增或编辑
	 * @param musicComment
	 */
	@Transactional(readOnly = false)
	public void save(MusicComment musicComment) {
		
		// 申请发起
		if (StringUtils.isBlank(musicComment.getId())){
			musicComment.preInsert();
			dao.insert(musicComment);
		}
		// 重新编辑申请
		else{
			musicComment.preUpdate();
			dao.update(musicComment);
		}
	}


    public List<MusicComment> findListByMusicApproveId(String mcId) {
    	return dao.findListByMusicApproveId(mcId);
	}
}
