/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Files_Utils_DG;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.act.entity.Act;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.oa.entity.MusicApprove;
import com.thinkgem.jeesite.modules.oa.entity.MusicComment;
import com.thinkgem.jeesite.modules.oa.service.MusicApproveService;
import com.thinkgem.jeesite.modules.oa.service.MusicCommentService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 审批Controller
 * @author thinkgem
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/musicApprove")
public class MusicApproveController extends BaseController {

	@Autowired
	private MusicApproveService musicApproveService;
	@Autowired
	private MusicCommentService musicCommentService;
	@Autowired
	private ActTaskService actTaskService;
	
	@ModelAttribute
	public MusicApprove get(@RequestParam(required=false) String id){//, 
//			@RequestParam(value="act.procInsId", required=false) String procInsId) {
		MusicApprove musicApprove = null;
		if (StringUtils.isNotBlank(id)){
			musicApprove = musicApproveService.get(id);
//		}else if (StringUtils.isNotBlank(procInsId)){
//			musicApprove = musicApproveService.getByProcInsId(procInsId);
		}
		if (musicApprove == null){
			musicApprove = new MusicApprove();
		}
		return musicApprove;
	}
	
	@RequiresPermissions("oa:musicApprove:view")
	@RequestMapping(value = {"list", ""})
	public String list(MusicApprove musicApprove, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			musicApprove.setCreateBy(user);
		}
        Page<MusicApprove> page = musicApproveService.findPage(new Page<MusicApprove>(request, response), musicApprove); 
        model.addAttribute("page", page);
		return "modules/oa/musicApproveList";
	}
	
	/**
	 * 申请单填写
	 * @param musicApprove
	 * @param model
	 * @return
	 */
	@RequiresPermissions("oa:musicApprove:view")
	@RequestMapping(value = "form")
	public String form(MusicApprove musicApprove, Model model) {
		
		String view = "musicApproveForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(musicApprove.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = musicApprove.getAct().getTaskDefKey();
			
			// 查看工单
			if(musicApprove.getAct().isFinishTask()){

				view = "musicApproveView";
			}
			// 修改环节
			else if ("modify".equals(taskDefKey)){
				view = "musicApproveForm";
			}
			// 审核环节
			else if ("approve".equals(taskDefKey)){
				view = "musicApproveAd";
//				String formKey = "/oa/musicApprove";
//				return "redirect:" + ActUtils.getFormUrl(formKey, musicApprove.getAct());
			}
			// 审核环节2
			else if ("approve2".equals(taskDefKey)){
				view = "musicApproveAd";
			}
			// 审核环节3
			else if ("approve3".equals(taskDefKey)){
				view = "musicApproveAd";
			}
			// 兑现环节
			else if ("end".equals(taskDefKey)){
				view = "musicApproveAd";
			}
		}

		model.addAttribute("musicApprove", musicApprove);
		List<MusicComment> musicCommentList = musicCommentService.findListByMusicApproveId(musicApprove.getId());
		model.addAttribute("musicCommentList", musicCommentList);
		return "modules/oa/" + view;
	}

	/**
	 * 打印当前页
	 * @param musicApprove
	 * @param model
	 * @return
	 */
	@RequiresPermissions("oa:musicApprove:view")
	@RequestMapping(value = "printCurr")
	public String printCurr(MusicApprove musicApprove, Model model) {
		String view = "musicApprovePrint";
		model.addAttribute("musicApprove", musicApprove);
		List<MusicComment> musicCommentList = musicCommentService.findListByMusicApproveId(musicApprove.getId());
		model.addAttribute("musicCommentList", musicCommentList);
		return "modules/oa/" + view;
	}


	/**
	 * 申请单保存/修改
	 * @param request
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("oa:musicApprove:edit")
	@RequestMapping(value = "save")
	public String save(HttpServletRequest request, Model model, MultipartFile file, RedirectAttributes redirectAttributes) {
		String musicApproveId = request.getParameter("musicApproveId");
		String actTaskId = request.getParameter("actTaskId");
		String actTaskName = request.getParameter("actTaskName");
		String actTaskDefKey = request.getParameter("actTaskDefKey");
		String actProcInsId = request.getParameter("actProcInsId");
		String actProcDefId = request.getParameter("actProcDefId");
		String actFlag = request.getParameter("actFlag");
		String customer = request.getParameter("customer");
		String contractNo = request.getParameter("contractNo");
		String linkman = request.getParameter("linkman");
		String linkmanPhone = request.getParameter("linkmanPhone");

		String memo = request.getParameter("memo");
		String[] industryTyp = request.getParameterValues("industryTyp");
		String[] typ = request.getParameterValues("typ");
		String[] playContent = request.getParameterValues("playContent");
		String[] playRequire = request.getParameterValues("playRequire");
		String[] playDay = request.getParameterValues("playDay");
		String[] playTime = request.getParameterValues("playTime");
		String[] playBetween = request.getParameterValues("playBetween");
		String[] musicCommentId = request.getParameterValues("musicCommentId");
		MusicApprove musicApprove = new MusicApprove();
		if(StringUtils.isNotBlank(musicApproveId)) {
			musicApprove = musicApproveService.get(musicApproveId);
			musicApprove.getAct().setTaskId(actTaskId);
			musicApprove.getAct().setTaskName(actTaskName);
			musicApprove.getAct().setTaskDefKey(actTaskDefKey);
			musicApprove.getAct().setProcInsId(actProcInsId);
			musicApprove.getAct().setProcDefId(actProcDefId);
			musicApprove.getAct().setFlag(actFlag);
		}
		musicApprove.setCustomer(customer);
		musicApprove.setContractNo(contractNo);
		musicApprove.setLinkman(linkman);
		musicApprove.setLinkmanPhone(linkmanPhone);
		musicApprove.setMemo(memo);
		String filePath = Files_Utils_DG.FilesUpload_transferTo_spring(request, file, "/filesOut/Upload");
		musicApprove.setUploadFile(filePath);
		musicApproveService.save(musicApprove);
		if(industryTyp!=null&&industryTyp.length>0) {
			for (int i = 0; i < industryTyp.length; i++) {
				MusicComment mc = new MusicComment();
				if (musicCommentId != null && StringUtils.isNotBlank(musicCommentId[i])) {
					mc = musicCommentService.get(musicCommentId[i]);
				}
				mc.setIndustryTyp(industryTyp[i]);
				mc.setTyp(typ[i]);
				mc.setPlayContent(playContent[i]);
				mc.setPlayRequire(playRequire[i]);
				mc.setPlayDay(playDay[i]);
				mc.setPlayTime(playTime[i]);
				mc.setPlayBetween(playBetween[i]);
				mc.setMusicApproveId(musicApprove.getId());
				musicCommentService.save(mc);
			}
		}
		addMessage(redirectAttributes, "提交审批'" + musicApprove.getContractNo() + "'成功");
		return "redirect:" + adminPath + "/act/task/todo/";
	}
	/**
   * 文件下载
   *
   * @param response
   */
     @RequestMapping(value = "fileDownload")
     public void fileDownload(HttpServletRequest request, HttpServletResponse response) {
     	 String filePath = request.getParameter("filePath");
     	 filePath  = filePath.replace("\\","/");
		 Files_Utils_DG.FilesDownload_stream(request,response,filePath);//"/files/download/mst.txt"
	 }
	/**
	 * 工单执行（完成任务）
	 * @param musicApprove
	 * @param model
	 * @return
	 */
	@RequiresPermissions("oa:musicApprove:edit")
	@RequestMapping(value = "saveAd")
	public String saveAd(MusicApprove musicApprove, Model model) {
		if (StringUtils.isBlank(musicApprove.getAct().getFlag())
				|| StringUtils.isBlank(musicApprove.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(musicApprove, model);
		}
		musicApproveService.adSave(musicApprove);
		return "redirect:" + adminPath + "/act/task/todo/";
	}
	
	/**
	 * 删除工单
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("oa:musicApprove:edit")
	@RequestMapping(value = "delete")
	public String delete(MusicApprove musicApprove, RedirectAttributes redirectAttributes) {
		musicApproveService.delete(musicApprove);
		addMessage(redirectAttributes, "删除审批成功");
		return "redirect:" + adminPath + "/oa/musicApprove/?repage";
	}

}
