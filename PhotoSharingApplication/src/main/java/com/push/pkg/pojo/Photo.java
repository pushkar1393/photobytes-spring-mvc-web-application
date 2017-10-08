package com.push.pkg.pojo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Entity
@Table(name = "photo_table")
public class Photo {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "photoID", unique=true, nullable = false)
	private long photoID;
	
	@Column(name="likeCount")
	private long likesCount;
	
	@Transient
	private CommonsMultipartFile pic;
	
	@Column(name="fileName")
	private String fileName;
	
	
	@Column(name="uploadDate")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date uploadDate;
	
	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public Set<Like> getLikes() {
		return likes;
	}

	public void setLikes(Set<Like> likes) {
		this.likes = likes;
	}

	public Set<Comment> getComments() {
		return comments;
	}

	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}

	@ManyToOne
	@JoinColumn(name="personID")
	private User user;
	
	
	@OneToMany(mappedBy="likePhoto")
	private Set<Like> likes = new HashSet<Like>();
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy="commentPhoto")
	private Set<Comment> comments = new HashSet<Comment>();
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public long getPhotoID() {
		return photoID;
	}

	public void setPhotoID(long photoID) {
		this.photoID = photoID;
	}

	public long getLikesCount() {
		return likesCount;
	}

	public void setLikesCount(long likesCount) {
		this.likesCount = likesCount;
	}

	public CommonsMultipartFile getPic() {
		return pic;
	}

	public void setPic(CommonsMultipartFile pic) {
		this.pic = pic;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	

}
