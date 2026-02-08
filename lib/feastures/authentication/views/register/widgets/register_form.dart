import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/feastures/authentication/controllers/registerUser_controller.dart';
import 'package:tm_store_app/feastures/authentication/views/register/widgets/terms_conditions_checkbox.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/validators/validation.dart';


class TSignUpForm extends StatelessWidget {
  const TSignUpForm({super.key});
  @override
  Widget build(BuildContext context) {
  // final dark = THelperFunctions.isDarkMode(context);

  final controller = Get.put(RegisterUserController());

    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
     
          //Full Name  
         TextFormField(
         controller: controller.fullName,
         validator: (value) => TValidator.validateEmptyText('Full Name', value),
         decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user_edit), labelText: TTexts.fullName,),
            ),  
         const SizedBox(height: TSizes.spaceBtwInputFields,),
          // Email  
         TextFormField(
         controller: controller.email,
         validator: (value) => TValidator.validateEmail(value),
         decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct), labelText: TTexts.email,),
            ), 
         const SizedBox(height: TSizes.spaceBtwInputFields,),
  
          // Password
         Obx(
           () => TextFormField(
           controller: controller.password,
           obscureText: controller.hidePassword.value,
           validator: (value) => TValidator.validatePassword(value),
           decoration: InputDecoration(labelText: TTexts.password,
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon:  IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))),
              ),
         ),
         const SizedBox(height: TSizes.spaceBtwInputFields,),
          // Confirm Password
         Obx(
          () => TextFormField(
           controller: controller.password,
           obscureText: controller.hidePassword.value,
           validator: (value) => TValidator.validatePassword(value),
           decoration: InputDecoration(labelText: TTexts.confirmPassword,
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon:  IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))),
              ),
         ),

          // Terms & conditions
          const  TTermsAndConditionChckbox(),
          const SizedBox(height: TSizes.spaceBtwSections,),
            // Signup Button & Create Account Button
          //SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(TTexts.createAccount),),), 
          SizedBox(
          width: double.infinity,
          height: 50,
          //child: ElevatedButton( child: const Text(TTexts.signIn),),
          child: ElevatedButton(
            onPressed: () => controller.signUpUser(context: context, fullName: controller.fullName.text.trim(), email: controller.email.text.trim(), password: controller.password.text.trim()),
              style: ElevatedButton.styleFrom(
                      // backgroundColor:  TColors.buttonPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                      ),
                    ),
              child: const Text(TTexts.createAccount),
        ),
        ),       
    
        ]
      ));
  }
}

