import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/login_signup/form_divider.dart';
import 'package:tm_store_app/common/widgets/login_signup/social_buttons.dart';
import 'package:tm_store_app/feastures/authentication/views/login/widgets/login_form.dart';
import 'package:tm_store_app/feastures/authentication/views/login/widgets/login_header.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/styles/spacing_styles.dart';


class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              //Header
              TSignInHeader(),
              // Form
              TSignInForm(),
               
               // Divider
               TFormDivider( dividerText: TTexts.orSignInWith.capitalize!,),
               const  SizedBox(height: TSizes.spaceBtwSections,),

               // Footer With Social Media Icons
               TSocialButtons()
            ],
            ),
          
        ),
      ),
    );
  }
}