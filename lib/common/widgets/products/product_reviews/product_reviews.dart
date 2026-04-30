import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/common/widgets/products/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:tm_store_app/common/widgets/products/product_reviews/widgets/user_review_card.dart';
import 'package:tm_store_app/common/widgets/products/ratings/rating_indicator.dart';
import 'package:tm_store_app/utils/constants/image_strings.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';


class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true,),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ratings and reviews are verified and are from people who use the same  type of device that you use.'),
              SizedBox(height: TSizes.spaceBtwItems),

              // Overall Product Rating
               TOverallProductRating(),
               TRatingBarIndicator(rating: 3.5,),
               Text("12,459", style: Theme.of(context).textTheme.bodySmall,),
               const SizedBox(height: TSizes.spaceBtwSections),

               // User Reviews List
              const UserReviewCard(
                userName: 'Rose Smith',
                 comnayName:"Tim's Store",
                  userDate: '20 Jun, 2025',
                  companyDate: '20 Jun, 2025',
                   userImage: TImages.google,
                    userText: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                     companyText: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                      userRating: 3,),
              const UserReviewCard(
                userName: 'Tim Mark',
                 comnayName:"Tim's Store",
                  userDate: '25 Jun, 2025',
                  companyDate: '25 Jun, 2025',
                   userImage: TImages.google,
                    userText: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                     companyText: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                      userRating: 3,),
               const UserReviewCard(
                userName: 'John Zech',
                 comnayName:"Tim's Store",
                  userDate: '30 Jun, 2025',
                  companyDate: '30 Jun, 2025',
                   userImage: TImages.google,
                    userText: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                     companyText: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                      userRating: 3,),
                     
              

            ],
          ),

        ),
      ),


    );
  }
}




