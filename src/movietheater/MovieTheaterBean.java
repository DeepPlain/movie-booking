package movietheater;

import java.util.ArrayList;

public class MovieTheaterBean {
	private String movie_theater_name;
	private String address;
	private String telephone_number;
	private int theater_num;
	private int seat_num;
	private ArrayList<TheaterBean> theaterBean;
	
	public String getMovie_theater_name() {
		return movie_theater_name;
	}
	public void setMovie_theater_name(String movie_theater_name) {
		this.movie_theater_name = movie_theater_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTelephone_number() {
		return telephone_number;
	}
	public void setTelephone_number(String telephone_number) {
		this.telephone_number = telephone_number;
	}
	public int getTheater_num() {
		return theater_num;
	}
	public void setTheater_num(int theater_num) {
		this.theater_num = theater_num;
	}
	public int getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(int seat_num) {
		this.seat_num = seat_num;
	}
	public ArrayList<TheaterBean> getTheaterBean() {
		return theaterBean;
	}
	public void setTheaterBean(ArrayList<TheaterBean> theaterBean) {
		this.theaterBean = theaterBean;
	}
	
}
