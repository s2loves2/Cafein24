package com.LCY.myapp.model.dao;

import com.LCY.myapp.model.dto.User;

public interface UserMapper {
	public void insertUser(User user);
	public User searchUser(User user);
	public int userIdCheck(String user_id);
	public int userNickNameCheck(String user_nickName);
	public void updateUser(User user);
}
