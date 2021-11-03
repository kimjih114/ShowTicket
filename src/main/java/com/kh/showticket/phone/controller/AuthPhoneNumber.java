package com.kh.showticket.phone.controller;

import java.util.Random;

public class AuthPhoneNumber{
	
    private int authPhoneLength = 6;
    
    public String excuteGenerate() {
        Random random = new Random(System.currentTimeMillis());
        
        int range = (int)Math.pow(10,authPhoneLength);
        int trim = (int)Math.pow(10, authPhoneLength-1);
        int result = random.nextInt(range)+trim;
         
        if(result>range){
            result = result - trim;
        }
        
        return String.valueOf(result);
    }

}