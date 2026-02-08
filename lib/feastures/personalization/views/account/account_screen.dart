import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/feastures/authentication/controllers/logOutUser_controller.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
   final controller = Get.put(SignOutUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
               Text("Account"),
               ElevatedButton(onPressed: ()async{
                await controller.signOutUser(context: context);
               }, child: Text("SignOut")),
               ],)) ,),
    );
  }
}