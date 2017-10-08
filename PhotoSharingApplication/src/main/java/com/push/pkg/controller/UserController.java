package com.push.pkg.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.push.pkg.pojo.Photo;
import com.push.pkg.pojo.User;
import com.push.pkg.exception.UserException;
import com.push.pkg.dao.UserDAO;
import com.push.pkg.validator.UserValidator;

@Controller
public class UserController {

	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;

	@Autowired
	@Qualifier("userValidator")
	UserValidator validator;

	@InitBinder
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(validator);
	}

	// to redirect to registration page

	@RequestMapping(value = "/user/register", method = RequestMethod.GET)
	protected ModelAndView registerUser() throws Exception {
		System.out.print("redirectToRegister");

		return new ModelAndView("register-user", "user", new User());

	}

	// to redirect to login page (replaced by modal)

	@RequestMapping(value = "/user/login", method = RequestMethod.GET)
	protected ModelAndView redirectUserPage(HttpServletRequest request) throws Exception {
		System.out.print("redirectToLogin");
		
		HttpSession session = request.getSession();
		
		User u = (User) session.getAttribute("user");
		
		if(u == null){
			return new ModelAndView("error");
		}else{
			List<User> following = new ArrayList<User>();

			List<Photo> feedlist = null;
			following = formFollowingList(u);
			following.add(u);
			feedlist = new ArrayList<Photo>();
			for (User user : following) {
				for (Photo pic : user.getPhoto()) {
					feedlist.add(pic);
				}
			}

			Collections.sort(feedlist, new Comparator<Photo>() {
				public int compare(Photo p1, Photo p2) {
					return p2.getUploadDate().compareTo(p1.getUploadDate());
				}
			});

			return new ModelAndView("user-home", "feeds", feedlist);

		}
			

	}

	// to redirect to register/login page

	@RequestMapping(value = "/", method = RequestMethod.GET)
	protected String goToUserHome() throws Exception {
		System.out.print("homePageLoaded");
		return "index";
	}

	// to login existing user and redirect to home page

	@RequestMapping(value = "/user/login", method = RequestMethod.POST)
	protected ModelAndView loginUser(HttpServletRequest request) throws Exception {

		HttpSession session = (HttpSession) request.getSession();

		try {

			System.out.print("loginUser");

			User u = userDao.get(request.getParameter("username"), request.getParameter("password"));

			if (u == null) {
				System.out.println("UserName/Password does not exist");
				session.setAttribute("errorMessage", "UserName/Password does not exist");
				return new ModelAndView("error");
			}

			session.setAttribute("user", u);
			List<User> following = new ArrayList<User>();

			List<Photo> feedlist = null;
			following = formFollowingList(u);
			following.add(u);
			feedlist = new ArrayList<Photo>();
			for (User user : following) {
				for (Photo pic : user.getPhoto()) {
					feedlist.add(pic);
				}
			}

			Collections.sort(feedlist, new Comparator<Photo>() {
				public int compare(Photo p1, Photo p2) {
					return p2.getUploadDate().compareTo(p1.getUploadDate());
				}
			});

			return new ModelAndView("user-home", "feeds", feedlist);

		} catch (UserException e) {
			System.out.println("Exception: " + e.getMessage());
			session.setAttribute("errorMessage", "error while login");
			return new ModelAndView("error");
		}

	}

	// to register new user and redirect to feeds page

	@RequestMapping(value = "/user/register", method = RequestMethod.POST)
	protected ModelAndView registerNewUser(HttpServletRequest request, @ModelAttribute("user") User user,
			BindingResult result) throws Exception {

		validator.validate(user, result);

		if (result.hasErrors()) {
			return new ModelAndView("register-user", "user", user);
		}

		try {

			System.out.print("registerNewUser");

			User u = userDao.register(user);

			request.getSession().setAttribute("user", u);

			return new ModelAndView("user-home", "user", u);

		} catch (UserException e) {
			System.out.println("Exception: " + e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}
	}

	// to retrieve all users

	@RequestMapping(value = "/user/available", method = RequestMethod.GET)
	protected ModelAndView retrieveAllUsers(HttpServletRequest request) throws Exception {

		try {
			List<Boolean> checker = new ArrayList<Boolean>();
			List<User> userList = null;
			Map<String, Object> model = new HashMap<String, Object>();
			HttpSession session = request.getSession();
			User u = (User) session.getAttribute("user");
			System.out.println("retriving the list of users");
			userList = userDao.retrieveUserList();
			for (User user : userList) {
				if (isPresent(user, u)) {
					checker.add(false);
				} else {
					checker.add(true);
				}
			}
			model.put("userlist", userList);
			model.put("checklist", checker);
			return new ModelAndView("user-list", "model", model);

		} catch (

		UserException e) {
			System.out.println("Exception:" + e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while retrieving the list");
		}
	}

	// to edit user

	// to logout a user

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	protected String returnToIndex(HttpServletRequest request) throws Exception {
		HttpSession session = (HttpSession) request.getSession();
		session.invalidate();
		return "index";

	}

	// to form following list

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

	// check if already follows

	public boolean isPresent(User followee, User follower) throws UserException {
		boolean flag = false;
		for (User f : followee.getFollowers()) {
			if (f.getPersonID() == follower.getPersonID()) {
				flag = true;
				break;
			} else {
				flag = false;
			}
		}

		return flag;
	}

	// to redirect interceptor to error page

	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String errorcall() {
		return "error";
	}
}