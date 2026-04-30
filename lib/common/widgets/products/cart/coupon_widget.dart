import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({super.key,  });


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
     showBorder: true,
     backgroundColor: dark ? TColors.dark : TColors.white,
     padding: const EdgeInsets.only(top: TSizes.sm, bottom: TSizes.sm, left: TSizes.md, right: TSizes.sm),
     child: Row(
      children: [
        //TextField
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Have a Promo Code? Enter Here",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            )
          ),
          //Button
          SizedBox(
              width:80,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  foregroundColor: dark ? TColors.white.withOpacity(0.5) : TColors.dark.withOpacity(0.5),
                  // ignore: deprecated_member_use
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  // ignore: deprecated_member_use
                  side: BorderSide(color: Colors.grey.withOpacity(0.1))
                  ),
                child: Text('Apply'),
    
                ),
                ),
      ],
     ),
    );
  }
}