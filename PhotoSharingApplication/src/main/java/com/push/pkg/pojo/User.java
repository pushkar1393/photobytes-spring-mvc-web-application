package com.push.pkg.pojo;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
//import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
//import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "user_table")
@PrimaryKeyJoinColumn(name = "personID")
public class User extends Person {

	@Column(name = "userName")
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "email")
	private String email;

	@Column(name = "bio")
	private String bio;

	@ManyToMany(cascade = { CascadeType.ALL })
	@JoinTable(name = "user_follower_table", joinColumns = { @JoinColumn(name = "personID") }, inverseJoinColumns = {
			@JoinColumn(name = "followerID") })
	private Set<User> followers = new HashSet<User>();

	public Set<User> getFollowers() {
		return followers;
	}

	public void setFollowers(Set<User> followers) {
		this.followers = followers;
	}

	public Set<Photo> getPhoto() {
		return photo;
	}

	public void setPhoto(Set<Photo> photo) {
		this.photo = photo;
	}

	@OneToMany(mappedBy = "user")
	private Set<Photo> photo = new HashSet<Photo>();

	public User() {

	}

	public User(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}
	
	/*@Override
	public int hashCode() {
		
	    return (int)getPersonID();
	}
	
	@Override
	public boolean equals(Object args){
		
		User u = (User)args;
		
		if(this.getUsername().equals(u.getUsername())){
			return true;
		}
		return false;
	}
*/
}
