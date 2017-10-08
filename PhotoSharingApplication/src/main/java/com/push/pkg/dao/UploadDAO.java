
package com.push.pkg.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

import com.push.pkg.exception.PhotoException;
import com.push.pkg.pojo.Comment;
import com.push.pkg.pojo.Like;
import com.push.pkg.pojo.Photo;
import com.push.pkg.pojo.User;

public class UploadDAO extends DAO {

	public UploadDAO() {

	}

	public List<Photo> get(User user) throws PhotoException {
		try {
			begin();
			String q = "";
			q = "from Photo where personID= :personID";
			Query q1 = getSession().createQuery(q);
			q1.setLong("personID", user.getPersonID());
			List<Photo> photo_list = q1.list();
			commit();
			return photo_list;
		} catch (HibernateException e) {
			rollback();
			throw new PhotoException("Could not get photos from " + user.getFirstName(), e);
		}
	}

	public Photo getPhoto(long photoID) throws PhotoException {
		try {
			begin();
			String q = "";
			q = "from Photo where photoID= :photoID";
			Query q1 = getSession().createQuery(q);
			q1.setLong("photoID", photoID);
			Photo post = (Photo) q1.uniqueResult();
			commit();
			return post;
		} catch (HibernateException e) {
			rollback();
			throw new PhotoException("could not find photo with id" + photoID);
		}
	}

	public Photo upload(Photo p) throws PhotoException {
		try {
			begin();
			System.out.println("inside DAO");
			getSession().save(p);
			commit();
			return p;

		} catch (HibernateException e) {
			rollback();
			throw new PhotoException("Exception while uploading photo: " + e.getMessage());
		}
	}

	public void delete(Photo p) throws PhotoException {
		try {
			begin();
			getSession().delete(p);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new PhotoException("Could not delete photo ");
		}
	}

	public long increment(String photoID) throws PhotoException {
		try {
			begin();
			System.out.println("like counter");
			long count = 0;
			long ID = Long.parseLong(photoID);
			String q = "";
			q = "from Photo where photoID= :photoID";
			Query q1 = getSession().createQuery(q);
			q1.setLong("photoID", ID);
			Photo pic = (Photo) q1.uniqueResult();
			count = pic.getLikesCount() + 1;
			pic.setLikesCount(count);
			getSession().update(pic);
			System.out.println("updated");
			commit();
			return count;
		} catch (HibernateException e) {
			rollback();
			throw new PhotoException("cannot like this pic");
		}
	}

	public Comment addComment(Comment c) throws PhotoException {
		try {
			begin();
			getSession().saveOrUpdate(c);
			System.out.println("in com dao");
			commit();
			return c;
		} catch (HibernateException e) {
			rollback();
			throw new PhotoException("Exception while adding comment");
		}
	}

	public Like doesLikes(User u, Photo p) throws PhotoException {
		try {
			//boolean flag = false;
			begin();
			/*String q = "";
			q = "from Like where likePhoto= :likePhoto and user= :user";
			Query q1 = getSession().createQuery(q);
			q1.setEntity("likePhoto", p);
			q1.setEntity("user", u);
			Like like = (Like) q1.uniqueResult();*/
			
			Criteria crit = getSession().createCriteria(Like.class);
			crit.add(Restrictions.eq("user", u));
			crit.add(Restrictions.eq("likePhoto",p));
			Like like = (Like)crit.uniqueResult();
			commit();
			return like;
		} catch (HibernateException e) {
			rollback();
			throw new PhotoException("Exception while checking like" + p.getPhotoID());
		}
	}

	public void registerLike(Like like) throws PhotoException {
		try {
			begin();
			getSession().saveOrUpdate(like);
			commit();
		} catch (HibernateException e) {
			throw new PhotoException("Exception while liking the photo");
		}

	}

	public void removeLike(Like l) throws PhotoException {
		try{
			begin();
			getSession().delete(l);
			commit();
		}catch(HibernateException e){
			throw new PhotoException("Exception while unliking");
		}
	}
}
