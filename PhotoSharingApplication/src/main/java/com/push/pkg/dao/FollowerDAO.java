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
			/*Query q = getSession().createSQLQuery("insert into picsharedb.user_follower_table (personID, followerID) values (:personID,:followerID)");
			q.setLong("personID", followee.getPersonID());
			q.setLong("followerID", follower.getPersonID());
			int u = q.executeUpdate();
			if(u ==1){
			System.out.print("inside dao");*/
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
			/*Query q = getSession()
					.createSQLQuery(
							"DELETE FROM picsharedb.user_follower_table WHERE personID= :personID and followerID= :followerID")
					.setParameter("personID", followee.getPersonID())
					.setParameter("followerID", follower.getPersonID());
			int up = q.executeUpdate();
			//if(up >=1){
			System.out.println("updat"); */
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
