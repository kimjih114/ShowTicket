package com.kh.showticket.phone;

import java.io.IOException;

import com.kh.showticket.phone.model.request.Message;
import com.kh.showticket.phone.model.response.MessageModel;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class UtilSms {

	public static void sendMessage(Message message) {
		
	       Call<MessageModel> api = APIInit.getAPI().sendMessage(APIInit.getHeaders(), message);
	       api.enqueue(new Callback<MessageModel>() {
	           @Override
	           public void onResponse(Call<MessageModel> call, Response<MessageModel> response) {
	               // 성공 시 200이 출력됩니다.
	               if (response.isSuccessful()) {
	            	   MessageModel body = response.body();
	            	   System.out.println("휴대폰 인증 성공해라ㅠㅠ");
	            	   System.out.println("to : " + body.getTo());
	                   System.out.println("from : " + body.getFrom());
	                   
	               } else {
	                   
	                   try {
	                       System.out.println(response.errorBody().string());
	                   } catch (IOException e) {
	                       e.printStackTrace();
	                   }
	               }
	           }
	           @Override
	           public void onFailure(Call<MessageModel> call, Throwable throwable) {
	               throwable.printStackTrace();
	           }
	       });
	   }
}
