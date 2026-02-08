
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tm_store_app/feastures/personalization/models/user.dart';


class UserProvider extends StateNotifier<User?>{
  // Constructor initializing with default User object
  // Purpose: Manage the state of the user object allowing update
  UserProvider() : super(User(
    id: '',
    fullName: '',
    email: '',
    state: '',
    city: '',
    locality: '',
    password: '',
    token: ''));

    // Getter Method to Extract value from an User Object
    User? get getUser => state;

    // Method to set user state from Json
    // Purpose: Update the user state base on Json String respresentation of user object

    void setUser(String userJson){
      state = User.formJson(userJson);
    }

    // Method to Clear user State
    void signOut(){
      state = null;
    }

}


    // Make The data Accessible within the Application 
    // final userProvider = StateNotifierProvider<UserProvider, User?>((ref) {
    //   return UserProvider();
    // });
     final userProvider = StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());