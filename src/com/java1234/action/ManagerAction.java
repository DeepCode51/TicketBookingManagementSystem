package com.java1234.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.stereotype.Controller;

import com.java1234.entity.Manager;
import com.java1234.entity.User;
import com.java1234.service.ManagerService;
import com.java1234.util.ResponseUtil;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 管理员Action处理类
 * @author Administrator
 *
 */
@Controller
public class ManagerAction extends ActionSupport implements ServletRequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private HttpServletRequest request;
	
	private Manager manager;
	
	@Resource
	private ManagerService managerService;

	public Manager getManager() {
		return manager;
	}

	public void setManager(Manager manager) {
		this.manager = manager;
	}


	/**
	 * 用户登录
	 * @return
	 * @throws Exception
	 */
	public String login()throws Exception{
		HttpSession session=request.getSession();
		Manager currentUser=managerService.login(manager);
		boolean flag=false;
		if(currentUser==null){
			flag=false; 
		}else{
			session.setAttribute("currentUser", currentUser);
			flag=true;
		}
		JSONObject result=new JSONObject();
		result.put("success", flag);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 修改密码
	 * @return
	 * @throws Exception
	 */
	public String modifyPassword()throws Exception{
		Manager m=managerService.getManagerById(manager.getId());
		m.setPassword(manager.getPassword());
		managerService.saveManager(m);
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}

	/**
	 * 注销
	 * @return
	 * @throws Exception
	 */
	public String logout()throws Exception{
		request.getSession().invalidate();
		return "logout";
	}
	
	
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	

}
