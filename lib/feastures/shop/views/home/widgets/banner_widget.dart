import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/circular_container.dart';
import 'package:tm_store_app/common/widgets/images/t_rounded_image.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/feastures/shop/controllers/banner_controller.dart';
import 'package:tm_store_app/utils/constants/colors.dart';


// class BannerWidget extends StatelessWidget {
//   const BannerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//   final BannerController bannerController = BannerController();

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 170,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: Color(0xFFE5E5E5),
//           borderRadius: BorderRadius.circular(4)
//         ),
//         child: FutureBuilder(
//           future: bannerController.loadBanners(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text("No Banners Found"));
//             } else {
//               List<BannerModel> banners = snapshot.data!;
//               // return PageView.builder(
//               //   scrollDirection: Axis.horizontal,
//               //   itemCount: banners.length,
//               //   itemBuilder: (context, index) {
//               //     BannerModel banner = banners[index];
//               //     return Container(
//               //       height: 170,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //         image: DecorationImage(
//               //           image: NetworkImage(banner.image),
//               //           fit: BoxFit.cover
//               //         ),
//               //         borderRadius: BorderRadius.circular(4)
//               //       ),
//               //     );
//               //   },
//               // );
//               return PageView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: banners.length,
//               itemBuilder: (context, index) {
//                 BannerModel banner = banners[index];

//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(4),
//                   child: Image.network(
//                     banner.image,
//                     width: MediaQuery.of(context).size.width,
//                     height: 170,
//                     fit: BoxFit.cover,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return const Center(child: CircularProgressIndicator());
//                     },
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Center(
//                         child: Icon(Icons.broken_image, size: 40),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );

//             } 
//           },
//         ),
//       ),
//     );
//   }
// }




class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 170,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.banners.isEmpty) {
        return const SizedBox(
          height: 170,
          child: Center(child: Text("No Banners Found!")),
        );
      }

      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 170,
              viewportFraction: 1,
              autoPlay: true,
              onPageChanged: (index, _) =>
                  controller.updateIndex(index),
            ),
            // items: controller.banners.map((banner) {
            //   return ClipRRect(
            //     borderRadius: BorderRadius.circular(4),
            //     child: Image.network(
            //       banner.image,
            //       width: double.infinity,
            //       fit: BoxFit.cover,
            //       errorBuilder: (_, __, ___) =>
            //           const Icon(Icons.broken_image, size: 40),
            //     ),
            //   );
            // }).toList(),

            //items: controller.banners.map((banner) => TRoundedImage(imageUrl: banner.image,)).toList(),
            items: controller.banners.map((banner) => TRoundedImage(imageUrl: banner.image,
                    isNetWorkImage: true,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 170,
                    borderRadius: 4,
                  )).toList(),
                  ),
          const SizedBox(height: 8),
          ///  Indicator Dots
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     controller.banners.length,
          //     (i) => Obx(() => Container(
          //           width: controller.carouselIndex.value == i ? 20 : 8,
          //           height: 4,
          //           margin: const EdgeInsets.only(right: 6),
          //           decoration: BoxDecoration(
          //             color: controller.carouselIndex.value == i
          //                 ? Colors.blue
          //                 : Colors.grey,
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //         )),
          //   ),
          // )
          Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // for(int i = 0; i < 3; i++)
                for(int i = 0; i < controller.banners.length; i++)
                TCirularContainer(
                  width: 20,
                  height: 4,
                  margin: EdgeInsets.only(right: 10),
                  backgroundColor: controller.carouselIndex.value == i ? TColors.primary : TColors.grey,
                )
              ],
            ),
          ),
        )
        ],
      );
    });
  }
}
