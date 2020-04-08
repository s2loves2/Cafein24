package com.LCY.myapp.model.dao;

import java.util.List;

import com.LCY.myapp.model.dto.Wish;

public interface WishMapper {
	public int wishListInsert(Wish wish);
	public void wishListDelete(Wish wish);
	public void delete(int wish_num);
	public List<Wish> WishListAll();
	public List<Wish> searchWishListByUser(String user_id);
	public boolean searchWishListByUserAndCafeCode(Wish wish);
}
