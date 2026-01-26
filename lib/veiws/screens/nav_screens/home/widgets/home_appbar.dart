import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/cart/cart_menu_icon.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey ),),
            Text(TTexts.homeAppbarSubTitle, style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white ),)
          ],
      ),
      actions: [

        TCartCounterIcon(onPressed: () {}, iconColor: TColors.white,),
        TCartCounterIcon(onPressed: () {}, iconColor: TColors.white,)

      ],
    );
  }
}
