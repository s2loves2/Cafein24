package com.LCY.myapp.model.dao;

import java.util.List;

import com.LCY.myapp.model.dto.Order;

public interface OrderMapper {
	public List<Order> orderAll();
	public List<Order> orderList(String user_id);
	public void insertOrderList(Order order);
}
