import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:tm_store_app/common/widgets/products/ratings/rating_indicator.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, required this.userName, required this.comnayName, required this.userDate, required this.userImage, required this.userText, required this.companyText, required this.userRating, required this.companyDate});
   
   final String userName, comnayName, userDate, userImage, userText, companyText, companyDate;
   final double userRating;


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [    
        Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(userImage),),
            const SizedBox(width: TSizes.spaceBtwItems,),
            // Text('Tim Mark', style: Theme.of(context).textTheme.titleLarge,),
            Text(userName, style: Theme.of(context).textTheme.titleLarge,),

          ],),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
       ),
       const SizedBox(height: TSizes.spaceBtwItems,),

       // Review
       Row(
        children: [
          const TRatingBarIndicator(rating: 4),
          const SizedBox(width: TSizes.spaceBtwItems),
          //Text('20 Jun, 2025', style: Theme.of(context).textTheme.bodyMedium,)
          Text(userDate, style: Theme.of(context).textTheme.bodyMedium,)

        ],
       ),

       const SizedBox(height: TSizes.spaceBtwItems,),
       ReadMoreText(
        //'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
        userText,
        trimLines: 1,
        trimMode: TrimMode.Line,
        trimExpandedText: ' Show Less',
        trimCollapsedText: ' Show More',
        moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
       ),
       const SizedBox(height: TSizes.spaceBtwItems,),

       // Company Review & Reply
       TRoundedContainer(
        backgroundColor: dark ? TColors.darkGrey : TColors.grey,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Text("Tim's Store", style: Theme.of(context).textTheme.titleMedium,),
                  Text(comnayName, style: Theme.of(context).textTheme.titleMedium,),
                  //Text('20 Jun, 2025', style: Theme.of(context).textTheme.bodyMedium,)
                  Text(companyDate, style: Theme.of(context).textTheme.bodyMedium,)

                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
                ReadMoreText(
                //'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                companyText,
                trimLines: 1,
                trimMode: TrimMode.Line,
                trimExpandedText: ' Show Less',
                trimCollapsedText: ' Show More',
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
              ),
            ],
          ),
          ),
       ),
       const SizedBox(height: TSizes.spaceBtwSections,)
      ],

    );
  }
}