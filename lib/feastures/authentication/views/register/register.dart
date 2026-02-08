import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/login_signup/form_divider.dart';
import 'package:tm_store_app/common/widgets/login_signup/social_buttons.dart';
import 'package:tm_store_app/feastures/authentication/views/register/widgets/register_form.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: TAppBar(
        showBackArrow: true,
       ),
       body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Signup Title
            Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections,),

            // Signup Form
            const TSignUpForm(),
              const SizedBox(height: TSizes.spaceBtwSections,),
              // Divider
            TFormDivider( dividerText: TTexts.orSignUpWith.capitalize!,),
               const  SizedBox(height: TSizes.spaceBtwSections,),

               // Footer With Social Media Icons
            const TSocialButtons()
          ],)
          ),
       ) ,
    );
  }
}