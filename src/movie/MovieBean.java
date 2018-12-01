package movie;

public class MovieBean {
	private int movie_id;
	private String title;
	private String director;
	private String rating;
	private String key_information;
	private String[] actor;
	
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getKey_information() {
		return key_information;
	}
	public void setKey_information(String key_information) {
		this.key_information = key_information;
	}
	public String[] getActor() {
		return actor;
	}
	public void setActor(String[] actor) {
		this.actor = actor;
	}
}


