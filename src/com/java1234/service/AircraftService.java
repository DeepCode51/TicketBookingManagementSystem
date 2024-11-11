package com.java1234.service;

import java.util.List;

import com.java1234.entity.PageBean;
import com.java1234.entity.Aircraft;

/**
 * 客机Service接口
 * @author Administrator
 *
 */
public interface AircraftService {

	
	/**
	 * 保存客机
	 * @param aircraft
	 */
	public void saveAircraft(Aircraft aircraft);
	
	/**
	 * 分页条件查询客机信息
	 * @param s_aircraft
	 * @param pageBean
	 * @return
	 */
	public List<Aircraft> findAircraftList(Aircraft s_aircraft,PageBean pageBean);
	
	/**
	 * 获取客机数量
	 * @param s_aircraft
	 * @return
	 */
	public Long getAircraftCount(Aircraft s_aircraft);
	
	/**
	 * 删除客机
	 * @param aircraft
	 */
	public void delete(Aircraft aircraft);
	
	/**
	 * 通过ID获取客机实体
	 * @param id
	 * @return
	 */
	public Aircraft getAircraftById(int id);
}
