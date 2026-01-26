// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/controllers/auth_controller.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/constants/text_strings.dart';
// import 'package:tm_store_app/utils/styles/spacing_styles.dart';
// import 'package:tm_store_app/veiws/screens/authentication_screens/login_screen.dart';

// // ignore: must_be_immutable
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key}); 
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//  // Or Remove this constructor because is not passing any thing
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final AuthController _authController = AuthController();
//   late String fullName, email, password;
//   bool isLoading = false;


//   registerUser() async{
//     setState(() {
//     isLoading = true;
      
//     });
//    await _authController
//    .signUpUsers(context: context, email: email, fullName: fullName, password: password)
//    .whenComplete(() {
//     _formKey.currentState!.reset();
//         setState(() {
//           isLoading = false;
//         });
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body: SingleChildScrollView(
//          child: Padding(
//           padding: TSpacingStyles.paddingWithAppBarHeight,
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                    Text(TTexts.signupTitle, style: GoogleFonts.getFont('Lato', color: Color(0xFF0d120E),  fontWeight: FontWeight.bold, letterSpacing: 0.2, fontSize: 23)),
//                   Image.asset('assets/images/Illustration.png', width: 100, height: 100,),
                         
//                     // TextFormField(
//                     //       decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right,), labelText: TTexts.email),
//                     //     ),
              
//                     // Email Full Name
//                   const SizedBox(height: TSizes.spaceBtwItems,),
              
//                       Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                       child:  TextFormField(
//                         onChanged: (value){
//                          fullName = value;
//                         },
//                         validator: (value) {
//                           if(value!.isEmpty){
//                             return 'Enter your full name';
//                           }else {
//                             return null;
//                           }
//                         },
//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(Iconsax.user_edit),
//                         labelText: TTexts.fullName
//                       ),
//                     ),
//                     ),
//                   const SizedBox(height: TSizes.spaceBtwInputFields,),
              
//                   // Email TextField
//                       Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                       child:  TextFormField(
//                         onChanged: (value){
//                          email = value;
//                         },
//                          validator: (value) {
//                           if(value!.isEmpty){
//                             return 'Enter your Email';
//                           }else {
//                             return null;
//                           }
//                         },
//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(Iconsax.direct_right,),
//                         labelText: TTexts.email
//                       ),
//                     ),
//                     ),
//                   const SizedBox(height: TSizes.spaceBtwInputFields,),
                       
                       
//                     // TextFormField(
//                     //     decoration: const InputDecoration(prefixIcon: Icon(Iconsax.password_check,),labelText: TTexts.password, suffixIcon: Icon(Iconsax.eye_slash)),
//                     //   ),
//                // password TextField
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                       child: TextFormField(
//                         onChanged: (value){
//                          password = value;
//                         },
//                          validator: (value) {
//                           if(value!.isEmpty){
//                             return 'Enter your Password';
//                           }else {
//                             return null;
//                           }
//                         },
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Iconsax.password_check,),
//                           labelText: TTexts.password,
//                           suffixIcon: Icon(Iconsax.eye_slash),
//                         ),
//                       ),
//                     ),
//                   const SizedBox(height: TSizes.spaceBtwInputFields,),
//                    //confirm password TextField
//                   //   Container(
//                   //     decoration: BoxDecoration(
//                   //         color: Colors.white,
//                   //         borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//                   //         boxShadow: [
//                   //           BoxShadow(
//                   //             color: Colors.black.withOpacity(0.1),
//                   //             blurRadius: 10,
//                   //             offset: const Offset(0, 4),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     child: TextFormField(
//                   //       onChanged: (value){
//                   //        password = value;
//                   //       },
//                   //        validator: (value) {
//                   //         if(value!.isEmpty){
//                   //           return 'Enter your Confirm Pasword';
//                   //         }else {
//                   //           return null;
//                   //         }
//                   //       },
//                   //       decoration: const InputDecoration(
//                   //         prefixIcon: Icon(Iconsax.password_check,),
//                   //         labelText: TTexts.confirmPassword,
//                   //         suffixIcon: Icon(Iconsax.eye_slash),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // const SizedBox(height: TSizes.spaceBtwInputFields,),
              
//                         // Sign In Button
//                         SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xFF102DE1),
//                       Color(0xCC0D6EFF),   
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//               ),
//               child: ElevatedButton(
//                 onPressed: () {
//                   if(_formKey.currentState!.validate()){
//                     registerUser();
//                   } else{
//                     print("Failed");
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   shadowColor: Colors.transparent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
//                   ),
//                 ),
//               child: Stack(
//                       children: [
//                         Positioned(
//                           left: 278,
//                           top: 19,
//                           child: Opacity(
//                             opacity: 0.5,
//                             child: Container(
//                               width: 60,
//                               height: 60,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 border: Border.all(width: 12, color: Color(0xFF103DE5)),
//                                 borderRadius: BorderRadius.circular(300)
//                               ),
//                             )
//                             ) ,
//                           ),
//                           Positioned(
//                           left: 260,
//                           top: 29,
//                           child: Opacity(
//                             opacity: 0.5,
//                             child: Container(
//                               width: 10,
//                               height: 10,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 border: Border.all(width: 3, color: Color(0xFF103DE5)),
//                                 borderRadius: BorderRadius.circular(5)
//                               ),
//                             )
//                             ) ,
//                           ),
//                           Positioned(
//                           left: 311,
//                           top: 36,
//                           child: Opacity(
//                             opacity: 0.3,
//                             child: Container(
//                               width: 5,
//                               height: 5,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(3)
//                               ),
//                             )
//                             ) ,
//                           ),
//                           Positioned(
//                           left: 281,
//                           top: -10,
//                           child: Opacity(
//                             opacity: 0.3,
//                             child: Container(
//                               width: 20,
//                               height: 20,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10)
//                               ),
//                             )
//                             ) ,
//                           ),
//                            isLoading? const CircularProgressIndicator(color: Colors.white,) : Text(TTexts.signUp, style:  GoogleFonts.getFont('Lato', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
//                           ],
//                         ),
//                     ),
//                   ),
//                 ),
//               const SizedBox(height: TSizes.spaceBtwItems,),
              
//                         // have Account Button
//                         Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(TTexts.haveAccount, style: GoogleFonts.roboto(fontWeight: FontWeight.w500, letterSpacing: 1), ),
//                 InkWell(
//                   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}) );},
//                   child: Text(TTexts.signIn, style: GoogleFonts.roboto(color: Color(0xFF103DE5), fontWeight: FontWeight.bold),))
              
//               ],)
                
//                 ],),
//             ) ,
            
//          ),
//        )
//     );
//   }
// } 

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/controllers/auth_controller.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/styles/spacing_styles.dart';
import 'package:tm_store_app/veiws/screens/authentication_screens/form_widget.dart';
import 'package:tm_store_app/veiws/screens/authentication_screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> registerUser(BuildContext context) async {
    isLoading.value = true;

    await _authController.signUpUsers(
      context: context,
      email: emailController.text.trim(),
      fullName: fullNameController.text.trim(),
      password: passwordController.text.trim(),
    );

    _formKey.currentState!.reset();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  TTexts.signupTitle,
                  style: GoogleFonts.lato(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Image.asset(
                  'assets/images/Illustration.png',
                  width: 100,
                  height: 100,
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// FULL NAME
                FormWidget(
                  controller: fullNameController,
                  label: TTexts.fullName,
                  icon: Iconsax.user_edit,
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your full name' : null,
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// EMAIL
                FormWidget(
                  controller: emailController,
                  label: TTexts.email,
                  icon: Iconsax.direct_right,
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your email' : null,
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// PASSWORD
                FormWidget(
                  controller: passwordController,
                  label: TTexts.password,
                  icon: Iconsax.password_check,
                  isPassword: true,
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your password' : null,
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// SIGN UP BUTTON
                ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, loading, _) {
                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  registerUser(context);
                                }
                              },
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                TTexts.signUp,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// LOGIN NAVIGATION
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TTexts.haveAccount),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        TTexts.signIn,
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF103DE5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// REUSABLE INPUT FIELD
  // Widget _buildInputField({
  //   required TextEditingController controller,
  //   required String label,
  //   required IconData icon,
  //   required String? Function(String?) validator,
  //   bool isPassword = false,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: TextFormField(
  //       controller: controller,
  //       obscureText: isPassword,
  //       validator: validator,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(icon),
  //         labelText: label,
  //         suffixIcon: isPassword ? const Icon(Iconsax.eye_slash) : null,
  //       ),
  //     ),
  //   );
  // }

  
}
