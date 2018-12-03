package movietheater;

import java.util.ArrayList;

public class TheaterBean {
	private int theater_id;
	private String theater_name;
	private ArrayList<SeatBean> seatBean;
	
	public int getTheater_id() {
		return theater_id;
	}
	public void setTheater_id(int theater_id) {
		this.theater_id = theater_id;
	}
	public String getTheater_name() {
		return theater_name;
	}
	public void setTheater_name(String theater_name) {
		this.theater_name = theater_name;
	}
	public ArrayList<SeatBean> getSeatBean() {
		return seatBean;
	}
	public void setSeatBean(ArrayList<SeatBean> seatBean) {
		this.seatBean = seatBean;
	}
	
}
