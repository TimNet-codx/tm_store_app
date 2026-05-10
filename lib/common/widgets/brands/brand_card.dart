import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/common/widgets/images/t_circular_image.dart';
import 'package:tm_store_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/enums.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key, this.showBorder = true, this.onTap,
  });
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // Icon
            Flexible(
              child: TCircularImage(
                isNetworkImage: false,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? TColors.white : TColors.black,
                ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2,),
      
            // Text
             Expanded(
               child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(title: 'Nike', brandTextSize: TextSizes.large),
                  Text('256 products', overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge,)
                  ],
              ),
             )
          ],
        ),
      ),
    );
  }
}