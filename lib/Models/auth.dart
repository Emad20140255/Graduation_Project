import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'http_exceptio.dart';

class Authentication with ChangeNotifier{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  

  Future <void> sigup(String email, String password)async{
    try{

    
    final url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAhFGzhM1cfm7Gz1pINi4pU-6kGcCEUMH4");
     
    final response = await http.post(url,body: json.encode(
    
      {
     // 'username' : username,
      'email' : email,
      'password' : password,
      'returnSecureToken' : true,
      }
    ));

    final responseData = json.decode(response.body);
    if(responseData['error'] !=null){
      throw HttpException(responseData['error']['message']);
    }
    //print(responseData);
    }catch (error){
      throw error;


    }
  }


  Future <void> login(String email, String password)async{
    var url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key= AIzaSyAJtWYsuLShgxqQ8kn_fjiSoiNlEch3ZVI");
     try{
    final response = await http.post(url,body: json.encode(

      {
     // 'username' : username,
      'email' : email,
      'password' : password,
      'returnSecureToken' : true,
      }
    ));

    final responseData = json.decode(response.body);
    if(responseData['error'] !=null){
      throw HttpException(responseData['error']['message']);
    }

    //print(responseData);
    
     }catch(error){
       throw error;
     }
  }

  

  


}
