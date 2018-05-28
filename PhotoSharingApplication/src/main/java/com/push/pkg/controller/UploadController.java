package com.push.pkg.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.push.pkg.dao.UploadDAO;
import com.push.pkg.dao.UserDAO;
import com.push.pkg.exception.PhotoException;
import com.push.pkg.exception.UserException;
import com.push.pkg.pojo.Comment;
import com.push.pkg.pojo.Like;
import com.push.pkg.pojo.Photo;
import com.push.pkg.pojo.User;
import com.push.pkg.utils.JsonUtils;

@Controller
@RequestMapping("/photo/**/")
public class UploadController {

	@Autowired
	@Qualifier("uploadDao")
	UploadDAO uploadDao;

	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;

	@Autowired
	ServletContext servletContext;

	// to redirect to page to upload picture

	@RequestMapping(value = "/photo/upload", method = RequestMethod.GET)
	public String showForm(ModelMap model) {
		Photo photo = new Photo(); // should be AutoWired

		// command object
		model.addAttribute("photo", photo);

		// return form view
		return "photo-upload";

	}

	// ajax function to like/unlike

	@RequestMapping(value = "/photo/hit", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public String likeUnlike(HttpServletRequest request, @RequestParam String photoID) throws Exception {
		boolean flag;
		HttpSession session = request.getSession();
		long id = Long.parseLong(photoID);
		User u = (User) session.getAttribute("user");
		Photo p = uploadDao.getPhoto(id);
		Like l = uploadDao.doesLikes(u, p);
		if (l == null) {
			Like like = new Like();
			like.setLikePhoto(p);
			like.setUser(u);
			uploadDao.registerLike(like);
			flag = true;
		} else {
			uploadDao.removeLike(l);
			flag = false;
		}
		String result = "{" + JsonUtils.toJsonField("flag", String.valueOf(flag))
				+ (", " + JsonUtils.toJsonField("count", String.valueOf(p.getLikes().size()))) + "}";
		return result;
	}

	// to redirect to view post page

	@RequestMapping(value = "/photo/comment/{id}", method = RequestMethod.GET)
	protected ModelAndView viewPost(HttpServletRequest request, @PathVariable("id") String id) throws Exception {
		long photoID = Long.parseLong(id);
		boolean flag;
		Map<String, Object> map = new HashMap<String, Object>();
		Photo photo = uploadDao.getPhoto(photoID);
		HttpSession session = request.getSession();
		User u = (User) session.getAttribute("user");
		Like l = uploadDao.doesLikes(u, photo);
		if (l != null)
			flag = true;
		else
			flag = false;
		map.put("flag", flag);
		map.put("photo", photo);
		map.put("count", photo.getLikes().size());
		return new ModelAndView("view-post", "map", map);
	}

	// ajax function to add comment

	@RequestMapping(value = "/photo/comment/add", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public String addComment(HttpServletRequest request, @RequestParam String comText, @RequestParam String photoID)
			throws Exception {
		long picID = Long.parseLong(photoID);
		Photo photo = uploadDao.getPhoto(picID);
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		Comment com = new Comment();
		com.setUser(user);
		com.setCommentContent(comText);
		com.setCommentPhoto(photo);
		com.setCommentTime(new Date());

		uploadDao.addComment(com);
		System.out.println("added comment");
		String result = "{" + JsonUtils.toJsonField("user", com.getUser().getUsername())
				+ (", " + JsonUtils.toJsonField("comment", com.getCommentContent())) + "}";
		return result;

	}


	// to retrieve the file path of picture and store it and redirect to gallery

	@RequestMapping(value = "/photo/upload", method = RequestMethod.POST)
	public ModelAndView handleUpload(@ModelAttribute("photo") Photo photo, HttpServletRequest request) {
		ModelAndView mv = null;
		try {

			HttpSession session = (HttpSession) request.getSession();
			User u = (User) session.getAttribute("user");
			String dir = "user_images_" + u.getPersonID();

			File directory;

			String path = getPath();
			System.out.println(path);
			path += dir;
			directory = new File(path);
			boolean temp = directory.exists();
			if (!temp) {
				temp = directory.mkdirs();
			}
			if (temp) {
				CommonsMultipartFile photoInMemory = photo.getPic();
				String fileName = photoInMemory.getOriginalFilename();

				File localFile = new File(directory.getPath(), fileName);
				photoInMemory.transferTo(localFile);
				
				String fName = File.separatorChar+ "pkg" + localFile.getPath().split("/pkg")[1];
				photo.setFileName(fName);
				System.out.println("File is stored at" + localFile.getPath());
				photo.setUser(u);
				photo.setUploadDate(new Date());
				Photo p = uploadDao.upload(photo);
				mv = retrieveGallery(request);

			} else {
				System.out.println("Failed to create directory!");
				mv = new ModelAndView("error");
			}

		} catch (IllegalStateException e) {
			System.out.println("*** IllegalStateException: " + e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("*** IOException: " + e.getMessage());
		} catch (PhotoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

	// to retrieve pictures of a user and display

	@RequestMapping(value = "/photo/gallery", method = RequestMethod.GET)
	public ModelAndView retrieveGallery(HttpServletRequest request) {
		Map<String, Object> model = new HashMap<String, Object>();
		List<Photo> photo_list = null;
		List<User> following = null;
		HttpSession session = request.getSession();
		User u = (User) session.getAttribute("user");
		try {
			following = formFollowingList(u);
			photo_list = uploadDao.get(u);
		} catch (PhotoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.put("photo_list", photo_list);
		model.put("following", following);
		return new ModelAndView("photo-gallery", "model", model);

	}

	// to increase like counter using ajax call

	@RequestMapping(value = "/photo/like", method = RequestMethod.POST)
	@ResponseBody
	public long likeCounter(HttpServletRequest request, @RequestParam String photoID) {
		System.out.println("reached");
		long count = 0;
		try {
			count = uploadDao.increment(photoID);
		} catch (PhotoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return count;
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
	
	
	public String getPath() throws UnsupportedEncodingException {
		String path = this.getClass().getClassLoader().getResource("").getPath();
		String fullPath = URLDecoder.decode(path, "UTF-8");
		String pathArr[] = fullPath.split("/WEB-INF/classes/");
		
		fullPath = pathArr[0];
		System.out.println(fullPath);
		String reponsePath = "";
		reponsePath = new File(fullPath).getPath() + File.separatorChar +"resources"+File.separatorChar + "images"+File.separatorChar;
		return reponsePath;
		}
}
