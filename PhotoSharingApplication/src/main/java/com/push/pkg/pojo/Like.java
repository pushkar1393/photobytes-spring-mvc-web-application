package com.push.pkg.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="like_table")
public class Like {
	
	
	public Like(){}
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "likeID", unique=true, nullable = false)
	private long likeID;
	
	
	@ManyToOne
	@JoinColumn(name="photoID")
	private Photo likePhoto;
	
	@OneToOne
	@JoinColumn(name="personID")
	private User user;

	public long getLikeID() {
		return likeID;
	}

	public void setLikeID(long likeID) {
		this.likeID = likeID;
	}


	public Photo getLikePhoto() {
		return likePhoto;
	}

	public void setLikePhoto(Photo likePhoto) {
		this.likePhoto = likePhoto;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	
	
}
