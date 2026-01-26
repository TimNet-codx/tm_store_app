// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tm_store_app/controllers/auth_controller.dart';
// import 'package:tm_store_app/utils/constants/sizes.dart';
// import 'package:tm_store_app/utils/constants/text_strings.dart';
// import 'package:tm_store_app/utils/styles/spacing_styles.dart';
// import 'package:tm_store_app/veiws/screens/authentication_screens/register_screen.dart';

// // ignore: must_be_immutable
// class LoginScreen extends StatefulWidget {
//     const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     final AuthController _authController = AuthController();
//     late String email, password;
//     bool isLoading = false;

//   loginUser() async{
//       setState(() {
//         isLoading = true;
//       });
//       await _authController
//       .signInUsers(context: context, email: email, password: password)
//       .whenComplete(() {
//     _formKey.currentState!.reset();
//         setState(() {
//           isLoading = false;
//         });
//       });
     
//     }

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
//                    Text(TTexts.loginTitle, style: GoogleFonts.getFont('Lato', color: Color(0xFF0d120E),  fontWeight: FontWeight.bold, letterSpacing: 0.2, fontSize: 23)                ),
//                     Text(TTexts.loginSubTitle, style: GoogleFonts.getFont('Lato', color: Color(0xFF0d120E),  fontWeight: FontWeight.bold, letterSpacing: 0.2, fontSize: 13) ),
//                     Image.asset('assets/images/Illustration.png', width: 150, height: 150,),
                         
//                     // TextFormField(
//                     //       decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right,), labelText: TTexts.email),
//                     //     ),
//                     // Email TextField
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
//                          onChanged: (value){
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
//                           onChanged: (value){
//                           password = value;
//                           },
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
//                    // Remember Me & Forgot Password
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Remember Me
//                   Row(children: [
//                     Checkbox(value: true, onChanged: (value) {}, activeColor: Color(0xFF103DE5), ),
//                     const Text(TTexts.rememberMe,  style: TextStyle(color: Color(0xFF103DE5)),)       
//                   ],),
//                   // Forgot Password
//                   TextButton(onPressed: () => {}, child: const Text(TTexts.forgetPassword, style: TextStyle(color: Color(0xFF103DE5)),)),
//                 ],),
//                 const SizedBox(height: TSizes.spaceBtwSections,),
              
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
//                     loginUser();
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
//                            isLoading? const CircularProgressIndicator(color: Colors.white,) : Text(TTexts.signIn, style:  GoogleFonts.getFont('Lato', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
//                           ],
//                         ),
//                     ),
//                   ),
//                 ),
//               const SizedBox(height: TSizes.spaceBtwInputFields,),
              
//                         // Create Account Button
//                         Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(TTexts.needAccount, style: GoogleFonts.roboto(fontWeight: FontWeight.w500, letterSpacing: 1), ),
//                 InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return RegisterScreen();}) );},
//                  child: Text(TTexts.signUp, style: GoogleFonts.roboto(color: Color(0xFF103DE5), fontWeight: FontWeight.bold),))
              
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
import 'package:tm_store_app/veiws/screens/authentication_screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> loginUser(BuildContext context) async {
    isLoading.value = true;

    await _authController.signInUsers(
      context: context,
      email: emailController.text.trim(),
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
                  TTexts.loginTitle,
                  style: GoogleFonts.lato(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  TTexts.loginSubTitle,
                  style: GoogleFonts.lato(fontSize: 13),
                ),

                Image.asset(
                  'assets/images/Illustration.png',
                  width: 150,
                  height: 150,
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

                /// REMEMBER ME
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Checkbox(
                          value: true,
                          onChanged: null,
                          activeColor: Color(0xFF103DE5),
                        ),
                        Text(
                          TTexts.rememberMe,
                          style: TextStyle(color: Color(0xFF103DE5)),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        TTexts.forgetPassword,
                        style: TextStyle(color: Color(0xFF103DE5)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwSections),

                /// LOGIN BUTTON
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
                                  loginUser(context);
                                }
                              },
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                TTexts.signIn,
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

                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// REGISTER NAVIGATION
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TTexts.needAccount),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        TTexts.signUp,
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
