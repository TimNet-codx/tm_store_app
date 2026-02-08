import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/feastures/authentication/controllers/logInUser_controller.dart';
import 'package:tm_store_app/feastures/authentication/views/forgotPassword/forgotPassword.dart';
import 'package:tm_store_app/feastures/authentication/views/register/register.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/validators/validation.dart';

class TSignInForm extends StatelessWidget {
  const TSignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginUserController());

    return Form(
      key: controller.signInFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email Field
            TextFormField(
             controller: controller.email,
             validator: (value) => TValidator.validateEmail(value),
             decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right,), labelText: TTexts.email),
                  ),
           const SizedBox(height: TSizes.spaceBtwInputFields,),
            // Password Field
           Obx(
           () => TextFormField(
           controller: controller.password,
           obscureText: controller.hidePassword.value,
           validator: (value) => TValidator.validateEmptyText('Password',value),
           decoration: InputDecoration(labelText: TTexts.password,
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon:  IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))),
              ),
         ),
         const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            // Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Remember Me
              Row(children: [
                Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                const Text(TTexts.rememberMe)       
              ],),
              // Forgot Password
              TextButton(onPressed: () => Get.to(() => const ForgotPasswordScreen()), child: const Text(TTexts.forgetPassword)),
            ],),
            const SizedBox(height: TSizes.spaceBtwSections,),

          // Sign In Button
            SizedBox(
              width: double.infinity, 
              height: 50,
                child: ElevatedButton(
                  onPressed: () => controller.signInUser(context: context, email: controller.email.text.trim(), password: controller.password.text.trim()),
                  style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                          ),
                        ),
                  child: const Text(TTexts.signIn),
             ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems,),
            // Create Account Button
            SizedBox(
              width: double.infinity, 
              height: 50,
             child: OutlinedButton(
                 onPressed: () => Get.to(() => const SignUpScreen()),
                  style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                          ),
                        ),
                  child: const Text(TTexts.createAccount),
             ),
            ),
            
          ],
        ),
      )
    
    );
  }
}