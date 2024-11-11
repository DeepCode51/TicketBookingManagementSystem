package com.java1234.service;

import com.java1234.entity.Manager;

/**
 * 管理员Service接口
 * @author Administrator
 *
 */
public interface ManagerService {

	/**
	 * 管理员登录验证
	 * @param manager
	 * @return
	 */
	public Manager login(Manager manager);
	
	/**
	 * 通过ID获取管理员实体
	 * @param id
	 * @return
	 */
	public Manager getManagerById(int id);
	
	/**
	 * 保存管理员
	 * @param manager
	 */
	public void saveManager(Manager manager);
	
	
}
