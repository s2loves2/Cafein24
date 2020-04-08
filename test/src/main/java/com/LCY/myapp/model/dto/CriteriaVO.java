package com.LCY.myapp.model.dto;

public class CriteriaVO {
	private int page;
	private int perPageNum;
	private int pageStart;
	
	public CriteriaVO() {
		this.page = 1;
		this.perPageNum = 5;
	}
	
	public int getPage() {
		return this.page;
	}
	
	public void setPage(int page) {
		if(page <= 0) this.page = 1;
		else this.page = page;
	}
	
	public int getPerPageNum() {
		return perPageNum;
	}
	
	public void setPerPageNum(int pageCount) {
		int cnt = this.perPageNum;
		if(pageCount != cnt) this.perPageNum = cnt;
		else this.perPageNum = pageCount;
	}
	
	public int getPageStrat() {
		return this.pageStart = (this.page-1)*perPageNum;
	}
	
	
}
