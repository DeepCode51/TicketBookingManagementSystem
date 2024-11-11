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

import com.java1234.entity.Aircraft;
import com.java1234.entity.Flight;
import com.java1234.entity.PageBean;
import com.java1234.entity.User;
import com.java1234.service.FlightService;
import com.java1234.util.PageUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 航班Action处理类
 * @author Administrator
 *
 */
@Controller
public class FlightAction extends ActionSupport implements ServletRequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Resource
	private FlightService flightService;
	
	private HttpServletRequest request;
	
	private List<Flight> flightList;
	private List<Flight> flightList1; // 国内航班
	private List<Flight> flightList2; // 国际航班
	private Flight s_flight;
	private String mainPage;
	private String page;
	private String rows;
	
	private Flight flight;
	
	private String ids;
	
	String pageCode;

	public Flight getS_flight() {
		return s_flight;
	}

	public void setS_flight(Flight s_flight) {
		this.s_flight = s_flight;
	}

	public String getMainPage() {
		return mainPage;
	}

	public void setMainPage(String mainPage) {
		this.mainPage = mainPage;
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

	public List<Flight> getFlightList() {
		return flightList;
	}

	public void setFlightList(List<Flight> flightList) {
		this.flightList = flightList;
	}
	
	
	
	public List<Flight> getFlightList1() {
		return flightList1;
	}

	public void setFlightList1(List<Flight> flightList1) {
		this.flightList1 = flightList1;
	}

	public List<Flight> getFlightList2() {
		return flightList2;
	}

	public void setFlightList2(List<Flight> flightList2) {
		this.flightList2 = flightList2;
	}
	
	

	public String getPageCode() {
		return pageCode;
	}

	public void setPageCode(String pageCode) {
		this.pageCode = pageCode;
	}
	
	

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}
	
	

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	/**
	 * 首页-查询航班
	 * @return
	 * @throws Exception
	 */
	public String indexList()throws Exception{
		PageBean pageBean=new PageBean(1,5);
		s_flight=new Flight();
		s_flight.setFlightType("国内航班");
		flightList1=flightService.findFlightList(s_flight, pageBean);
		s_flight.setFlightType("国际航班");
		flightList2=flightService.findFlightList(s_flight, pageBean);
		return SUCCESS;
	}
	
	/**
	 * 航班查询
	 * @return
	 * @throws Exception
	 */
	public String list()throws Exception{
		HttpSession session=request.getSession();
		if(StringUtil.isEmpty(page)){
			page="1";
		}
		if(s_flight==null){
			Object o=session.getAttribute("s_flight");
			if(o!=null){
				s_flight=(Flight)o;
			}else{
				s_flight=new Flight();				
			}
		}else{
			session.setAttribute("s_flight", s_flight);
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),10);
		flightList=flightService.findFlightList(s_flight, pageBean);
		long total=flightService.getFlightCount(s_flight);
		pageCode=PageUtil.genPaginationNoParam(request.getContextPath()+"/flight_list.action", total, Integer.parseInt(page), 10);
		mainPage="flight/flightList.jsp";
		return SUCCESS;
	}
	
	/**
	 * 航班查询-用户机票改签
	 * @return
	 * @throws Exception
	 */
	public String list2()throws Exception{
		HttpSession session=request.getSession();
		if(StringUtil.isEmpty(page)){
			page="1";
		}
		if(s_flight==null){
			Object o=session.getAttribute("s_flight");
			if(o!=null){
				s_flight=(Flight)o;
			}else{
				s_flight=new Flight();				
			}
		}else{
			session.setAttribute("s_flight", s_flight);
		}
		flightList=flightService.findFlightList(s_flight, null);
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		jsonConfig.setExcludes(new String[]{"aircraft"});
		JSONArray rows=JSONArray.fromObject(flightList, jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", rows);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 分页条件查询用户-后台管理
	 * @return
	 * @throws Exception
	 */
	public String list3()throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<Flight> flightList=flightService.findFlightList(s_flight, pageBean);
		long total=flightService.getFlightCount(s_flight);
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		jsonConfig.registerJsonValueProcessor(Aircraft.class,new ObjectJsonValueProcessor(new String[]{"id","name"}, Aircraft.class));
		JSONArray rows=JSONArray.fromObject(flightList, jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", rows);
		result.put("total", total);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	
	/**
	 * 航班修改
	 * @return
	 * @throws Exception
	 */
	public String save()throws Exception{
		JSONObject result=new JSONObject();
		flight.setEcTicketRemain(flight.getEcTicketTotal());
		flight.setFcTicketRemain(flight.getFcTicketTotal());
		flightService.saveFlight(flight);
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	public String deleteFlight()throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		boolean flag=true;
		for(int i=0;i<idsStr.length;i++){
				Flight f=flightService.getFlightById(Integer.parseInt(idsStr[i]));
				flightService.delete(f);
		}
		result.put("success", flag);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

}
