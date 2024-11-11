package com.java1234.service;

import java.util.List;

import com.java1234.entity.PageBean;
import com.java1234.entity.User;

/**
 * 旅客Service接口
 * @author Administrator
 *
 */
public interface UserService {

	/**
	 * 登录验证
	 * @param user
	 * @return
	 */
	public User login(User user);
	
	/**
	 * 保存用户
	 * @param user
	 */
	public void saveUser(User user);
	
	/**
	 * 判断用户名是否存在
	 * @param userName
	 * @return
	 */
	public boolean existUserWithUserName(String userName);
	
	/**
	 * 分页条件查询用户信息
	 * @param s_user
	 * @param pageBean
	 * @return
	 */
	public List<User> findUserList(User s_user,PageBean pageBean);
	
	/**
	 * 获取用户数量
	 * @param s_user
	 * @return
	 */
	public Long getUserCount(User s_user);
	
	/**
	 * 删除用户
	 * @param user
	 */
	public void delete(User user);
	
	/**
	 * 通过ID获取用户实体
	 * @param id
	 * @return
	 */
	public User getUserById(int id);
}
