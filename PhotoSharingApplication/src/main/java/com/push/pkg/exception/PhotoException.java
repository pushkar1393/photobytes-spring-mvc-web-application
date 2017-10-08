package com.push.pkg.exception;

public class PhotoException extends Exception{

	
	 public PhotoException(String message)
	    {
	        super("PhotoException-"+message);
	    }
	    
	    public PhotoException(String message, Throwable cause)
	    {
	        super("PhotoException-"+message,cause);
	    }

}
