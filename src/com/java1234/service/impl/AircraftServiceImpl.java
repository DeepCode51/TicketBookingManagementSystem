package com.java1234.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java1234.dao.BaseDAO;
import com.java1234.entity.Aircraft;
import com.java1234.entity.PageBean;
import com.java1234.service.AircraftService;
import com.java1234.util.StringUtil;

/**
 * 客机Service实现类
 * @author Administrator
 *
 */
@Service("aircraftService")
public class AircraftServiceImpl implements AircraftService{

	@Resource
	private BaseDAO<Aircraft> baseDAO;
	
	public void saveAircraft(Aircraft aircraft) {
		baseDAO.merge(aircraft);
	}

	public List<Aircraft> findAircraftList(Aircraft s_aircraft,
			PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Aircraft");
		if(s_aircraft!=null){
			if(StringUtil.isNotEmpty(s_aircraft.getName())){
				hql.append(" and name like ? ");
				param.add("%"+s_aircraft.getName()+"%");
			}
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param);			
		}
	}

	public Long getAircraftCount(Aircraft s_aircraft) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Aircraft");
		if(s_aircraft!=null){
			if(StringUtil.isNotEmpty(s_aircraft.getName())){
				hql.append(" and name like ? ");
				param.add("%"+s_aircraft.getName()+"%");
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	public void delete(Aircraft aircraft) {
		baseDAO.delete(aircraft);
	}

	public Aircraft getAircraftById(int id) {
		return baseDAO.get(Aircraft.class, id);
	}

}
