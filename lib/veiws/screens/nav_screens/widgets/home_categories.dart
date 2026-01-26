// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tm_store_app/controllers/category_controller.dart';

// class THomeCategories extends StatelessWidget {
//   const THomeCategories({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // final categoryController = Get.put(CategoryController());
//   final CategoryController categoryController = CategoryController();

    

//     return Obx(() {
//       // if(categoryController.isLoading.value) return const TCategoryShimmer();

//       if(categoryController.getCategory().isEmpty){
//         return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white), ),);
//       }
//        return  SizedBox(
//        height: 80,
//         child: ListView.builder(
//          shrinkWrap: true,
//          itemCount: categoryController.getCategory().length,
//          scrollDirection: Axis.horizontal,
//          itemBuilder: (_, index){
//           final category = categoryController.getCategory[index];
//          // return TVerticalImageText(image: category.image, title: category.name, onTap: () => Get.to(() => const SubCategoriesScreen()),);
//         }),
//       );
//     }
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_store_app/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:tm_store_app/controllers/category_controller.dart';
import 'package:tm_store_app/veiws/screens/details/screens/inner_category_screen.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {

    final CategoryController categoryController = Get.put(CategoryController());

    return Obx(() {

      if (categoryController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (categoryController.categories.isEmpty) {
        return Center(
          child: Text(
            'No Categories Found!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.categories[index];
            return InkWell(child: TVerticalImageText(image: category.image, title: category.name, onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InnerCategoryScreen(category: category,),))
            },));

            // return Padding(
            //   padding: const EdgeInsets.only(left: TSizes.defaultSpace),
            //   child: Column(
            //     // children: [
            //     //   CircleAvatar(
            //     //     backgroundImage: NetworkImage(category.image),
            //     //     radius: 25,
            //     //   ),
            //     //   const SizedBox(height: 5),
            //     //   Text(
            //     //     category.name,
            //     //     style: const TextStyle(color: Colors.white, fontSize: 12),
            //     //   ),
            //     // ],
            //       children: [
            //         TVerticalImageText(image: category.image, title: category.name, onTap: () => {},)
            //       ],

            //   ),
            // );
          },
        ),
      );
    });
  }
}
