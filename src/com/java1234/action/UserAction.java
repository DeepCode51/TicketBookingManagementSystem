package com.java1234.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.stereotype.Controller;

import com.java1234.entity.PageBean;
import com.java1234.entity.User;
import com.java1234.service.TicketService;
import com.java1234.service.UserService;
import com.java1234.util.ResponseUtil;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 旅客Action处理类
 * @author Administrator
 *
 */
@Controller
public class UserAction extends ActionSupport implements ServletRequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Resource
	private UserService userService;
	
	@Resource
	private TicketService ticketService;
	
	private HttpServletRequest request;
	
	private User user;
	
	private String mainPage;
	
	private User s_user;
	
	private String page;
	private String rows;
	
	private String ids;
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public String getMainPage() {
		return mainPage;
	}

	public void setMainPage(String mainPage) {
		this.mainPage = mainPage;
	}
	
	

	public User getS_user() {
		return s_user;
	}

	public void setS_user(User s_user) {
		this.s_user = s_user;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}
	
	

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	/**
	 * 用户登录
	 * @return
	 * @throws Exception
	 */
	public String login()throws Exception{
		HttpSession session=request.getSession();
		User currentUser=userService.login(user);
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
	 * 安全退出
	 * @return
	 * @throws Exception
	 */
	public String logout()throws Exception{
		request.getSession().invalidate();
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 用户注册
	 * @return
	 * @throws Exception
	 */
	public String register()throws Exception{
		JSONObject result=new JSONObject();
		if(userService.existUserWithUserName(user.getUserName())){
			result.put("error", "用户名已存在，请更换！");
		}else{
			userService.saveUser(user);
			result.put("success", true);
		}
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 用户修改
	 * @return
	 * @throws Exception
	 */
	public String save()throws Exception{
		HttpSession session=request.getSession();
		JSONObject result=new JSONObject();
		userService.saveUser(user);
		result.put("success", true);
		session.setAttribute("currentUser", user);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 显示用户信息
	 * @return
	 * @throws Exception
	 */
	public String showUserInfo()throws Exception{
		mainPage="userCenter/userInfo.jsp";
		return "userCenter";
	}
	
	/**
	 * 分页条件查询用户
	 * @return
	 * @throws Exception
	 */
	public String list()throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<User> userList=userService.findUserList(s_user, pageBean);
		long total=userService.getUserCount(s_user);
		JsonConfig jsonConfig=new JsonConfig();
		JSONArray rows=JSONArray.fromObject(userList, jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", rows);
		result.put("total", total);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	public String deleteUser()throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		boolean flag=true;
		for(int i=0;i<idsStr.length;i++){
			if(ticketService.existTicketOrderWithUserId(Integer.parseInt(idsStr[i]))){
				flag=false;
			}else{
				User u=userService.getUserById(Integer.parseInt(idsStr[i]));	
				userService.delete(u);
			}
		}
		result.put("success", flag);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	

	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

	
}
