import 'dart:convert';

class UserModel{
  final String id;
  final String fullName;
  final String email; 
  final String country;
  final String state;
  final String city; 
  final String street;
  final String phoneNumber;
  final String postalCode;
  final String password;
  final String token;

  UserModel({required this.id, required this.fullName, required this.email, required this.postalCode, required this.phoneNumber, required this.country, required this.state, required this.city, required this.street, required this.password, required this.token});
  
  // Serialiation: Convert  User Object to a Map
  // MAP: A Map is a collection of key-value pairs
  // Why: Converting to a map is an intermediate step that makes it easier to serialize the data into JSON format.
  // the object to formates like JSON, for storage or transmission.

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
        "id": id,
        "fullName": fullName,
        "email": email,
        "country": country,
        "state": state,
        "city": city,
        "street": street,
        "postalCode": postalCode,
        "phoneNumber": phoneNumber,
        "password": password,
        "token": token,
    };
  }

  // Serialization: Convert a Map to a Json String
  // This method directly encodes the data from the map into a JSON String.

  // The json.encode() function convert a Dart object (such as Map Or List) 
  // into a JSon String representation, Making it suitable for communication  between different systems.
  String toJson() => json.encode(toMap());


  // Deserialization: This will Convert a MAp to a user object
  // Purpose - Mainpulate and User : Once the data is converted a to a user object
  // It can be easily manipulated, and use within the application. For Example 
  // I might want to display the User's fullName or email etc on th UI. or i might want t save  the data locally.

   
   // The factory constructor takes a Map (Usually obtained from a JSON object)
   // And convert it into a user Object. if a field is not presend in the it  defaults to an empty String

   // fromMap: This constructor take a Map<String, dynamic> and convert into a User Object
   // its usefull when you already have the data in a Map format
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      // id: map['_id'] ?? "",
      id: map['_id'] ?? map['id'] ?? "",
      // id: map['_id']?.toString() ?? map['id']?.toString() ?? "",
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      country: map["country"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      postalCode: map["postalCode"] as String? ?? "",
      street: map["street"] as String? ?? "",
      password: map["password"] as String? ?? "",
      token: map["token"] as String? ?? "",
      phoneNumber: map["phoneNumber"] as String? ?? "",
      
        
    );  
  }

   // fromJson: This factory constructor takes Json String, and decodes into a Map<String, Dynamic>
   // and then use formMap to convert that Map into a User Object

   factory UserModel.formJson (String source) => UserModel.fromMap(json.decode(source)  as Map<String, dynamic>);

}