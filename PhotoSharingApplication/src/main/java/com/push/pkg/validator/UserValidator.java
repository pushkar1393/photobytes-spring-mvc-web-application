package com.push.pkg.validator;

import java.util.Date;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.push.pkg.dao.UserDAO;
import com.push.pkg.pojo.User;
@Component
public class UserValidator implements Validator {
	
	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;
	
	public boolean supports(Class aClass) {
		return aClass.equals(User.class);
	}

	public void validate(Object obj, Errors errors) {
		User user = (User) obj;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "error.invalid.user", "First Name Required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "error.invalid.user", "Last Name Required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "error.invalid.user", "User Name Required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "error.invalid.password", "Password Required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "error.invalid.user", "Email Required");

		// check if user exists
		
		
		Pattern name = Pattern.compile("[^a-zA-Z' ']");
		Pattern username = Pattern.compile("[^a-zA-Z0-9]");
		

		if (name.matcher(user.getFirstName()).find()) {
			errors.rejectValue("firstName", "firstName-invalid", "Please enter valid Name");
		}
		
		if (name.matcher(user.getLastName()).find()) {
			errors.rejectValue("lastName", "lastName-invalid", "Please enter valid Name");
		}
		
		if (username.matcher(user.getUsername()).find()) {
			errors.rejectValue("username", "username-invalid", "Please enter valid Username");
		}
		
		boolean flag = userDao.checkUsernameExists(user.getUsername());
		
		if(flag){
			errors.rejectValue("username", "error.invalid.username", "Username already exists!!");
		}
		
		Date today = new Date();
		if(user.getDateOfBirth().after(today)){
			errors.rejectValue("dateOfBirth", "error.invalid.dateOfBirth", "Enter a valid date!!");
		}

	}

}
