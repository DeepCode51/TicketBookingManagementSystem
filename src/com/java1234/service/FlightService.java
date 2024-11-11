package com.java1234.service;

import java.util.List;

import com.java1234.entity.Flight;
import com.java1234.entity.PageBean;
import com.java1234.entity.User;

/**
 * 航班Service接口
 * @author Administrator
 *
 */
public interface FlightService {

	/**
	 * 分页查询航班信息
	 * @param s_flight
	 * @param pageBean
	 * @return
	 */
	public List<Flight> findFlightList(Flight s_flight,PageBean pageBean);
	
	/**
	 * 获取航班数量
	 * @param s_flight
	 * @return
	 */
	public Long getFlightCount(Flight s_flight);
	
	/**
	 * 通过ID查找航班信息
	 * @param id
	 * @return
	 */
	public Flight getFlightById(int id);
	
	/**
	 * 保存航班
	 * @param flight
	 */
	public void saveFlight(Flight flight);
	
	/**
	 * 删除航班
	 * @param user
	 */
	public void delete(Flight flight);
}
