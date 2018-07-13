package com.push.pkg.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;

import com.push.pkg.exception.FollowerException;
import com.push.pkg.exception.UserException;
import com.push.pkg.pojo.User;

public class FollowerDAO extends DAO {

	public FollowerDAO() {
	}

	public List<User> retrieveFollowers(User u) throws FollowerException {

		try {
			List<User> followerList = null;
			begin();

			commit();
			return followerList;
		} catch (HibernateException e) {
			rollback();
			throw new FollowerException("Exception while retrieving follower list" + e.getMessage());
		}
	}

	public User get(int userId) throws UserException {
		try {
			begin();
			Query q = getSession().createQuery("from User where personID= :personID");
			q.setInteger("personID", userId);
			User user = (User) q.uniqueResult();
			commit();
			return user;
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Could not get user " + userId, e);
		}
	}

	public boolean addFollower(User followee) throws FollowerException {
		boolean flag = false;
		try {
			begin();
			getSession().merge(followee);
			commit();
			flag = true;
			//}
		} catch (HibernateException e) {
			rollback();
			throw new FollowerException("cannot add follower" + e.getMessage());

		}
		return flag;
	}

	public boolean removeFollower(User followee) throws FollowerException {
		boolean flag = true;
		try {
			begin();
			getSession().merge(followee);
			commit();
			//}
			System.out.println("commited");
			flag = false;
		} catch (HibernateException e) {
			rollback();
			throw new FollowerException("cannot remove follower" + e.getMessage());
		}
		return flag;
	}

}
