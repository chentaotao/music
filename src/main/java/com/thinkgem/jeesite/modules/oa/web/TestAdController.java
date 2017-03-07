/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.oa.entity.TestAd;
import com.thinkgem.jeesite.modules.oa.service.TestAdService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 审批Controller
 * @author thinkgem
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/testAd")
public class TestAdController extends BaseController {

	@Autowired
	private TestAdService testAdService;
	
	@ModelAttribute
	public TestAd get(@RequestParam(required=false) String id){//, 
//			@RequestParam(value="act.procInsId", required=false) String procInsId) {
		TestAd testAd = null;
		if (StringUtils.isNotBlank(id)){
			testAd = testAdService.get(id);
//		}else if (StringUtils.isNotBlank(procInsId)){
//			testAd = testAdService.getByProcInsId(procInsId);
		}
		if (testAd == null){
			testAd = new TestAd();
		}
		return testAd;
	}
	
	@RequiresPermissions("oa:testAd:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestAd testAd, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			testAd.setCreateBy(user);
		}
        Page<TestAd> page = testAdService.findPage(new Page<TestAd>(request, response), testAd); 
        model.addAttribute("page", page);
		return "modules/oa/testAdList";
	}
	
	/**
	 * 申请单填写
	 * @param testAd
	 * @param model
	 * @return
	 */
	@RequiresPermissions("oa:testAd:view")
	@RequestMapping(value = "form")
	public String form(TestAd testAd, Model model) {
		
		String view = "testAdForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(testAd.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = testAd.getAct().getTaskDefKey();
			
			// 查看工单
			if(testAd.getAct().isFinishTask()){
				view = "testAdView";
			}
			// 修改环节
			else if ("modify".equals(taskDefKey)){
				view = "testAdForm";
			}
			// 审核环节
			else if ("ad".equals(taskDefKey)){
				view = "testAdAd";
//				String formKey = "/oa/testAd";
//				return "redirect:" + ActUtils.getFormUrl(formKey, testAd.getAct());
			}
			// 审核环节2
			else if ("ad2".equals(taskDefKey)){
				view = "testAdAd";
			}
			// 审核环节3
			else if ("ad3".equals(taskDefKey)){
				view = "testAdAd";
			}
			// 审核环节4
			else if ("ad4".equals(taskDefKey)){
				view = "testAdAd";
			}
			// 兑现环节
			else if ("apply_end".equals(taskDefKey)){
				view = "testAdAd";
			}
		}

		model.addAttribute("testAd", testAd);
		return "modules/oa/" + view;
	}
	
	/**
	 * 申请单保存/修改
	 * @param testAd
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("oa:testAd:edit")
	@RequestMapping(value = "save")
	public String save(TestAd testAd, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testAd)){
			return form(testAd, model);
		}
		testAdService.save(testAd);
		addMessage(redirectAttributes, "提交审批'" + testAd.getContractNo() + "'成功");
		return "redirect:" + adminPath + "/act/task/todo/";
	}

	/**
	 * 工单执行（完成任务）
	 * @param testAd
	 * @param model
	 * @return
	 */
	@RequiresPermissions("oa:testAd:edit")
	@RequestMapping(value = "saveAd")
	public String saveAd(TestAd testAd, Model model) {
		if (StringUtils.isBlank(testAd.getAct().getFlag())
				|| StringUtils.isBlank(testAd.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(testAd, model);
		}
		testAdService.adSave(testAd);
		return "redirect:" + adminPath + "/act/task/todo/";
	}
	
	/**
	 * 删除工单
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("oa:testAd:edit")
	@RequestMapping(value = "delete")
	public String delete(TestAd testAd, RedirectAttributes redirectAttributes) {
		testAdService.delete(testAd);
		addMessage(redirectAttributes, "删除审批成功");
		return "redirect:" + adminPath + "/oa/testAd/?repage";
	}

}
