import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/global_variables.dart';
import 'package:tm_store_app/models/user.dart';
import 'package:tm_store_app/service/manage_http_response.dart';
import 'package:tm_store_app/veiws/screens/authentication_screens/login_screen.dart';
import 'package:tm_store_app/veiws/screens/main_screen.dart';

class AuthController {
  
  // SignUp Users Function
  Future<void> signUpUsers({required context, required String email, required String fullName, required String password }) async{
    
    try {
      User user = User(id: '', fullName: fullName, email: email, state: '', city: '', locality: '', password: password, token: ''); 
      http.Response response = await http.post(Uri.parse('$uri/api/signup'), 
      body: user.toJson(),  // Convert the user Object to JSon for the request body
      headers: <String, String>{ // Set the Headers for the request
        'Content-Type': 'application/json; charset=UTF-8', // Specify the content type as JSON
      });

      // Create a  veriable to store the response
      manageHttpResponse(
        response: response, 
        context: context, 
        onSuccess: (){ 
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
          showSnackBar(context, 'Account has been Created Successfully ');});

    } catch (e) {
      print("Error: $e"); 
    }
  }

  // SignIn Users Function
  Future<void> signInUsers({required context, required String email, required String password}) async{
    try {
      // JsonEncode is useed to convert the data to json format
      http.Response response = await http.post(Uri.parse("$uri/api/signin"),
        body: jsonEncode({'email': email, 'password': password},), 
        headers: <String, String>{ // Set the Headers for the request
        'Content-Type': 'application/json; charset=UTF-8', // Specify the content type as JSON
      }); 

      // Handle the response using the manageHttpResponse
      manageHttpResponse(
        response: response, 
        context: context, 
        onSuccess: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainScreen()), (route)=> false);
          showSnackBar(context, 'Login Successful');});
    } catch (e) {
      print("Error: $e"); 
    }
  }
  

}