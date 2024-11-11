package com.java1234.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java1234.dao.BaseDAO;
import com.java1234.entity.Manager;
import com.java1234.service.ManagerService;

/**
 * 管理员Service实现类
 * @author Administrator
 *
 */
@Service("managerService")
public class ManagerServiceImpl implements ManagerService {

	@Resource
	private BaseDAO<Manager> baseDAO;
	
	public Manager login(Manager manager) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Manager m where m.userName=? and m.password=?");
		param.add(manager.getUserName());
		param.add(manager.getPassword());
		return baseDAO.get(hql.toString(), param);
	}

	public Manager getManagerById(int id) {
		return baseDAO.get(Manager.class, id);
	}

	public void saveManager(Manager manager) {
		baseDAO.merge(manager);
	}

}
