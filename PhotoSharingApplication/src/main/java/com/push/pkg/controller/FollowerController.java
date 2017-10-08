package com.push.pkg.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.push.pkg.dao.FollowerDAO;
import com.push.pkg.dao.UserDAO;
import com.push.pkg.exception.FollowerException;
import com.push.pkg.exception.UserException;
import com.push.pkg.pojo.User;

@Controller
@RequestMapping("/follow/**/")
public class FollowerController {

	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;

	@Autowired
	@Qualifier("followerDao")
	FollowerDAO followerDao;

	// ajax function to follow and unfollow someone from user-list

	@RequestMapping(value = "/follow/add", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean switchFollower(HttpServletRequest request, @RequestParam String followeeID) throws Exception {
		System.out.println("reached controller");
		boolean flag = false;
		int id = Integer.parseInt(followeeID);
		HttpSession session = request.getSession();
		User follower = (User) session.getAttribute("user");
		try {
			User followee = (User) followerDao.get(id);
			if (isPresent(followee, follower)) {
				//System.out.println("before" +followee.getFollowers().size());
			followee.getFollowers().remove(follower);
				//System.out.println("after" + followee.getFollowers().size());
				System.out.println("removed");
				flag = followerDao.removeFollower(followee);

			} else {
				followee.getFollowers().add(follower);
				System.out.println("added");
				flag = followerDao.addFollower(followee);

			}

		} catch (FollowerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;

	}

	// check if already follows
	
	public boolean isPresent(User followee, User follower) throws UserException {
		boolean flag = false;
		for (User f : followee.getFollowers()) {
			if (f.getPersonID() == follower.getPersonID()) {
				flag = true;
				break;
			}else {
				flag = false;
			}
		}

		return flag;
	}

	// to retrieve list of followers

	@RequestMapping(value = "/follow/followers", method = RequestMethod.GET)
	protected ModelAndView retrieveFollowers(HttpServletRequest request) throws Exception {

		List<User> followerlist = null;
		HttpSession session = request.getSession();
		User u = (User) session.getAttribute("user");

		followerlist = new ArrayList<User>(u.getFollowers());

		return new ModelAndView("follower-list", "followerlist", followerlist);
	}

	// to retrieve list of following
	
	@RequestMapping(value = "/follow/following", method = RequestMethod.GET)
	protected ModelAndView retrieveFollowing(HttpServletRequest request) throws Exception {
		List<User> following = new ArrayList<User>();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		following = formFollowingList(user);

		return new ModelAndView("following-list", "followinglist", following);
	}

	// to redirect to view profile page
	@RequestMapping(value = "/follow/view/{id}", method = RequestMethod.GET)
	protected ModelAndView viewProfile(HttpServletRequest request, @PathVariable("id") String id) throws Exception {
		boolean flag = false;
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		List<User> followingList = new ArrayList<User>();
		Map<String, Object> model = new HashMap<String, Object>();
		int followerID = Integer.parseInt(id);
		User follower = followerDao.get(followerID);
		followingList = formFollowingList(follower);
		for (User u : follower.getFollowers()) {
			if (u.getPersonID() == currentUser.getPersonID())
				flag = true;
		}
		model.put("follower", follower);
		model.put("follows", flag);
		model.put("followinglist", followingList);
		System.out.print(flag);
		return new ModelAndView("view-profile", "model", model);
	}

	// retrieve list of following for the user
	public List<User> formFollowingList(User user) throws UserException {
		List<User> following = new ArrayList<User>();
		for (User u : userDao.retrieveUserList()) {
			for (User f : u.getFollowers()) {
				if (f.getPersonID() == user.getPersonID())
					following.add(u);
			}
		}
		return following;
	}
}
