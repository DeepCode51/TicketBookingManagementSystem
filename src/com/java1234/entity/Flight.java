package com.java1234.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 航班实体
 * @author Administrator
 *
 */
@Entity
@Table(name="t_flight")
public class Flight {

	private Integer id; // 编号
	private String name; // 航班名称
	private String fromCity; // 出发城市
	private String toCity; // 目的城市
	private Date fromTime; // 出发时间
	private Date toTime; // 到点时间
	private int ecPrice; // 经济舱票价
	private int fcPrice; // 头等舱票价 
	private int ecTicketTotal; // 经济舱总票数
	private int fcTicketTotal; // 头等舱总票数
	private int ecTicketRemain; // 经济舱剩余票数
	private int fcTicketRemain; // 头等舱剩余票数
	
	private Aircraft aircraft; // 使用的客机
	private String flightType; // 航班类型 国内航班/ 国际航班
	
	@Id
	@GeneratedValue(generator="_native")
	@GenericGenerator(name="_native",strategy="native")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(length=20)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(length=20)
	public String getFromCity() {
		return fromCity;
	}
	public void setFromCity(String fromCity) {
		this.fromCity = fromCity;
	}
	
	@Column(length=20)
	public String getToCity() {
		return toCity;
	}
	public void setToCity(String toCity) {
		this.toCity = toCity;
	}
	
	public Date getFromTime() {
		return fromTime;
	}
	public void setFromTime(Date fromTime) {
		this.fromTime = fromTime;
	}
	public Date getToTime() {
		return toTime;
	}
	public void setToTime(Date toTime) {
		this.toTime = toTime;
	}
	public int getEcPrice() {
		return ecPrice;
	}
	public void setEcPrice(int ecPrice) {
		this.ecPrice = ecPrice;
	}
	public int getFcPrice() {
		return fcPrice;
	}
	public void setFcPrice(int fcPrice) {
		this.fcPrice = fcPrice;
	}
	public int getEcTicketTotal() {
		return ecTicketTotal;
	}
	public void setEcTicketTotal(int ecTicketTotal) {
		this.ecTicketTotal = ecTicketTotal;
	}
	public int getFcTicketTotal() {
		return fcTicketTotal;
	}
	public void setFcTicketTotal(int fcTicketTotal) {
		this.fcTicketTotal = fcTicketTotal;
	}
	public int getEcTicketRemain() {
		return ecTicketRemain;
	}
	public void setEcTicketRemain(int ecTicketRemain) {
		this.ecTicketRemain = ecTicketRemain;
	}
	public int getFcTicketRemain() {
		return fcTicketRemain;
	}
	public void setFcTicketRemain(int fcTicketRemain) {
		this.fcTicketRemain = fcTicketRemain;
	}
	
	@ManyToOne
	@JoinColumn(name="aircraftId",updatable=false)
	public Aircraft getAircraft() {
		return aircraft;
	}
	public void setAircraft(Aircraft aircraft) {
		this.aircraft = aircraft;
	}
	
	@Column(length=20)
	public String getFlightType() {
		return flightType;
	}
	public void setFlightType(String flightType) {
		this.flightType = flightType;
	}
	
	
	
}
