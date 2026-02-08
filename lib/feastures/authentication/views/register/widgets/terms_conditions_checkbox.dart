import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tm_store_app/feastures/authentication/controllers/registerUser_controller.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class TTermsAndConditionChckbox extends StatelessWidget {
  const TTermsAndConditionChckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegisterUserController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    
    return Row(children: [
      SizedBox(child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
      const SizedBox(width: 1,),
      Text.rich(
        TextSpan(children:[
          TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
          TextSpan(text: '${TTexts.privacyPolicy} ', style: Theme.of(context).textTheme.bodyMedium!.apply(
            color: dark ? Colors.white : TColors.primary,
            decoration: TextDecoration.underline,
          ) ),
          TextSpan(text: '${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
           TextSpan(text: TTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
            color: dark ? Colors.white : TColors.primary,
            decoration: TextDecoration.underline,
          ) ),
        ] )
      )
    ],);
  }
}