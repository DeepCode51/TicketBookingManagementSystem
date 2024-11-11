package com.java1234.action;

import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.java1234.entity.PageBean;
import com.java1234.entity.Aircraft;
import com.java1234.service.AircraftService;
import com.java1234.util.ResponseUtil;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 客机Action处理类
 * @author Administrator
 *
 */
@Controller
public class AircraftAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Resource
	private AircraftService aircraftService;

	private Aircraft aircraft;
	
	private String mainPage;
	
	private Aircraft s_aircraft;
	
	private String page;
	private String rows;
	
	private String ids;

	public Aircraft getAircraft() {
		return aircraft;
	}

	public void setAircraft(Aircraft aircraft) {
		this.aircraft = aircraft;
	}

	public String getMainPage() {
		return mainPage;
	}

	public void setMainPage(String mainPage) {
		this.mainPage = mainPage;
	}

	public Aircraft getS_aircraft() {
		return s_aircraft;
	}

	public void setS_aircraft(Aircraft s_aircraft) {
		this.s_aircraft = s_aircraft;
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
	 * 客机修改
	 * @return
	 * @throws Exception
	 */
	public String save()throws Exception{
		JSONObject result=new JSONObject();
		aircraftService.saveAircraft(aircraft);
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 分页条件查询客机
	 * @return
	 * @throws Exception
	 */
	public String list()throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<Aircraft> aircraftList=aircraftService.findAircraftList(s_aircraft, pageBean);
		long total=aircraftService.getAircraftCount(s_aircraft);
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray rows=JSONArray.fromObject(aircraftList, jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", rows);
		result.put("total", total);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 删除客机
	 * @return
	 * @throws Exception
	 */
	public String deleteAircraft()throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			Aircraft u=aircraftService.getAircraftById(Integer.parseInt(idsStr[i]));	
			aircraftService.delete(u);
		}
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 下拉框使用，获取所有客机
	 * @return
	 * @throws Exception
	 */
	public String comboList()throws Exception{
		JSONArray jsonArray=new JSONArray();
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("id", "");
		jsonObject.put("name", "请选择...");
		jsonArray.add(jsonObject);
		List<Aircraft> aircraftList=aircraftService.findAircraftList(null, null);
		JsonConfig jsonConfig=new JsonConfig();
		JSONArray rows=JSONArray.fromObject(aircraftList, jsonConfig);
		jsonArray.addAll(rows);
		ResponseUtil.write(ServletActionContext.getResponse(), jsonArray);
		return null;
	}

}
