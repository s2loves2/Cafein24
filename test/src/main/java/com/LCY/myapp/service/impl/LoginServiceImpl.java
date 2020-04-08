package com.LCY.myapp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.LCY.myapp.model.dao.UserMapper;
import com.LCY.myapp.model.dto.User;
import com.LCY.myapp.service.LoginService;

public class LoginServiceImpl implements LoginService {
	@Autowired
	private UserMapper userMapper;

	@Override
	public void insertUser(User user) {
		// TODO Auto-generated method stub
		userMapper.insertUser(user);
	}

	@Override
	public User searchUser(User user) {
		// TODO Auto-generated method stub
		return userMapper.searchUser(user);
	}
	
}
