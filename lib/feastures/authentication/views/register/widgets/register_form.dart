import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/feastures/authentication/controllers/registerUser_controller.dart';
import 'package:tm_store_app/feastures/authentication/views/register/widgets/terms_conditions_checkbox.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/validators/validation.dart';

class TSignUpForm extends StatelessWidget {
  TSignUpForm({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(RegisterUserController());

    return Form(
      key: _formKey,
      child: Column(
        children: [
          //Full Name
          TextFormField(controller: controller.fullName, validator: (value) => TValidator.validateEmptyText('Full Name', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user_edit), labelText: TTexts.fullName)),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Phone Number
          TextFormField(controller: controller.phoneNumber, validator: (value) => TValidator.validatePhoneNumber(value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.call), labelText: TTexts.phoneNo)),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Email
          TextFormField(controller: controller.email, validator: (value) => TValidator.validateEmail(value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct), labelText: TTexts.email)),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          Obx(() => TextFormField(controller: controller.password, obscureText: controller.hidePassword.value, validator: (value) => TValidator.validatePassword(value), decoration: InputDecoration(labelText: TTexts.password, prefixIcon: Icon(Iconsax.password_check), suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))))),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Confirm Password
          Obx(() => TextFormField(controller: controller.password, obscureText: controller.hidePassword.value, validator: (value) => TValidator.validatePassword(value), decoration: InputDecoration(labelText: TTexts.confirmPassword, prefixIcon: Icon(Iconsax.password_check), suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))))),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: TextFormField(controller: controller.street, validator: (value) => TValidator.validateEmptyText('Street', value), decoration: const InputDecoration(prefixIcon: Icon(Icons.home_outlined), labelText: TTexts.street)),

                // child: _buildTextField(Icons.home_outlined, 'Street', isUpdate ? '15 Mark' : '')
              ),
              const SizedBox(width: 16),
              Expanded(child: TextFormField(controller: controller.postalCode, validator: (value) => TValidator.validateEmptyText('Postal Code', value), decoration: const InputDecoration(prefixIcon: Icon(Icons.qr_code_scanner), labelText: TTexts.postalCode))),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Row(children: [Expanded(child: TextFormField(controller: controller.city, validator: (value) => TValidator.validateEmptyText('City', value), decoration: const InputDecoration(prefixIcon: Icon(Icons.location_city_outlined), labelText: TTexts.city))), const SizedBox(width: 16), Expanded(child: TextFormField(controller: controller.state, validator: (value) => TValidator.validateEmptyText('State', value), decoration: const InputDecoration(prefixIcon: Icon(Icons.timeline_outlined), labelText: TTexts.state)))]),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(controller: controller.country, validator: (value) => TValidator.validateEmptyText('Country', value), decoration: const InputDecoration(prefixIcon: Icon(Icons.public), labelText: TTexts.country)),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Terms & conditions
          const TTermsAndConditionChckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Signup Button & Create Account Button
          //SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(TTexts.createAccount),),),
          SizedBox(
            width: double.infinity,
            height: 54,
            //child: ElevatedButton( child: const Text(TTexts.signIn),),
            child: ElevatedButton(
              onPressed: () => controller.signUpUser(context: context, fullName: controller.fullName.text.trim(), email: controller.email.text.trim(), password: controller.password.text.trim(), phoneNumber: controller.phoneNumber.text.trim(), country: controller.country.text.trim(), street: controller.street.text.trim(), city: controller.city.text.trim(), state: controller.state.text.trim(), postalCode: controller.postalCode.text.trim()),
              style: ElevatedButton.styleFrom(
                // backgroundColor:  TColors.buttonPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
              ),

              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
