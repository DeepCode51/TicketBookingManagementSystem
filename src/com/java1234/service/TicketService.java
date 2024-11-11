package com.java1234.service;

import java.util.List;

import com.java1234.entity.PageBean;
import com.java1234.entity.TicketOrder;
import com.java1234.entity.User;


/**
 * 机票Service接口
 * @author Administrator
 *
 */
public interface TicketService {

	/**
	 * 保存机票订单
	 * @param ticketOrder
	 */
	public void saveTicket(TicketOrder ticketOrder);
	
	/**
	 * 分页条件查询航班订票
	 * @param s_ticketOrder
	 * @param pageBean
	 * @return
	 */
	public List<TicketOrder> findTicketOrderList(TicketOrder s_ticketOrder,PageBean pageBean);
	
	/**
	 * 条件查询航班订票数
	 * @param s_ticketOrder
	 * @return
	 */
	public Long getTicketOrderCount(TicketOrder s_ticketOrder);
	
	/**
	 * 退票
	 * @param id
	 */
	public void deleteTicketOrder(Integer id);
	
	/**
	 * 改签
	 * @param id 原来的机票Id
	 * @param newFlightId 改签的新的航班Id
	 */
	public void saveMeal(Integer id,Integer newFlightId,User currentUser)throws Exception;
	
	/**
	 * 是否存在指定用户的订单
	 * @param userId
	 */
	public boolean existTicketOrderWithUserId(Integer userId);
	
	/**
	 * 通过ID获取订单信息
	 * @param id
	 * @return
	 */
	public TicketOrder getTicketOrderById(int id);
	
	/**
	 * 删除订单
	 * @param ticketOrder
	 */
	public void delete(TicketOrder ticketOrder);
	
}
