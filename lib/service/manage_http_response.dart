import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({ 
  required http.Response response, // The Http response  from the API Or Server request
  required BuildContext context, // The context is to show the snackbar widget
  required VoidCallback onSuccess, // the callbck function to be executed when the responsee is successful
  }){
     
     // Switch statement to handle different http status code
    switch(response.statusCode){
      case 200: // status code 200 indicate a successful response
        onSuccess();
        break;
      case 400:  // status code 400 indicate a bad request
         showSnackBar(context, json.decode(response.body)['msg']);
         break;
      case 500: // status code 500 indicate a server error
         showSnackBar(context, json.decode(response.body)['error']);
         break;
      case 201:  // status code 201 indicate a resource created successfuly
       onSuccess();
         break;
      default: 
        showSnackBar(context, 'Unexpected error occured. Please try again later.');
        break;
    }
}

void showSnackBar(BuildContext context, String title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}