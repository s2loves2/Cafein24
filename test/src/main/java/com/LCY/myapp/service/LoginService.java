package com.LCY.myapp.service;

import com.LCY.myapp.model.dto.User;

public interface LoginService {
	public void insertUser(User user);
	public User searchUser(User user);
}
