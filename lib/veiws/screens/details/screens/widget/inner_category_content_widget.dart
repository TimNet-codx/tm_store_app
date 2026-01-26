import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/search_container.dart';
import 'package:tm_store_app/controllers/subCategory_controller.dart';
import 'package:tm_store_app/models/category_model.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';
import 'package:tm_store_app/veiws/screens/details/screens/widget/inner_banner_widget.dart';
import 'package:tm_store_app/veiws/screens/details/screens/widget/subCategory_tileWidget.dart';



// class InnerCategoryScreen extends StatelessWidget {
//   final CategoryMode category;
//   const InnerCategoryScreen({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     // Note: You don't necessarily need the controller here 
//     // because the 'category' object already has the data.

//     final CategoryController categoryController = Get.find<CategoryController>();

//     final SubCategoryController subCategoryController = Get.put(SubCategoryController());

//     return Scaffold(
//       appBar: TAppBar(
//         title: Text(
//           category.name, 
//           style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black),
//         ),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView( // Added scrollview to prevent overflow
//         child: Column(
//           children: [
//             const SizedBox(height: TSizes.spaceBtwSections),   
//             // Searchbar
//             const TSearchContainer(text: 'Search in Store'),
//             const SizedBox(height: TSizes.spaceBtwItems),
//             // Banner: Pass the banner string directly from the model
//             InnerBannerWidget(banner: category.banner),
            
//             // You can add your SubCategory grid below this
//             const SizedBox(height: TSizes.spaceBtwItems),

//             Center(
//             child: Text(
//               'Shop By SubCategories:',
//               style: GoogleFonts.quicksand(
//                 textStyle: Theme.of(context).textTheme.bodyMedium,
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.7,
//                 color: Colors.grey,
//               ),
//             ),
//           ),

//             Expanded(
//                      Obx(() {
//                           if (categoryController.isLoading.value) {
//                             return const Center(child: CircularProgressIndicator());
//                           }

//                           if (categoryController.categories.isEmpty) {
//                             return Center(
//                               child: Text(
//                                 'No Categories Found!',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .apply(color: Colors.white),
//                               ),
//                             );
//                           }

//                           return SizedBox(
//                             height: 80,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: categoryController.categories.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (_, index) {
//                                 final category = categoryController.categories[index];
//                                 return InkWell(child: TVerticalImageText(image: category.image, title: category.name, onTap: () => {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => InnerCategoryScreen(category: category,),))
//                                 },));

//             // return Padding(
//             //   padding: const EdgeInsets.only(left: TSizes.defaultSpace),
//             //   child: Column(
//             //     // children: [
//             //     //   CircleAvatar(
//             //     //     backgroundImage: NetworkImage(category.image),
//             //     //     radius: 25,
//             //     //   ),
//             //     //   const SizedBox(height: 5),
//             //     //   Text(
//             //     //     category.name,
//             //     //     style: const TextStyle(color: Colors.white, fontSize: 12),
//             //     //   ),
//             //     // ],
//             //       children: [
//             //         TVerticalImageText(image: category.image, title: category.name, onTap: () => {},)
//             //       ],

//             //   ),
//             // );
//           },
//         ),
//       );
//     })
//                     ),

//           ],
//         ),
//       ),
//     );
//   }
// }


// class InnerCategoryScreen extends StatelessWidget {
//   final CategoryMode category;
//   const InnerCategoryScreen({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     // 1. Initialize SubCategoryController and trigger fetch immediately
//     final subCategoryController = Get.put(SubCategoryController());
    
//     // Fetch subcategories for THIS specific category name
//     subCategoryController.fetchProductsByCategoriesName(category.name);

//     return Scaffold(
//       appBar: TAppBar(
//         title: Text(
//           category.name,
//           style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black),
//         ),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: TSizes.spaceBtwSections),
//             // Searchbar
//             const TSearchContainer(text: 'Search in Store'),
//             const SizedBox(height: TSizes.spaceBtwItems),
            
//             // Banner
//             InnerBannerWidget(banner: category.banner),
//             const SizedBox(height: TSizes.spaceBtwItems),

//             Center(
//               child: Text(
//                 'Shop By SubCategories:',
//                 style: GoogleFonts.quicksand(
//                   textStyle: Theme.of(context).textTheme.bodyMedium,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.7,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems),

//             // 2. Use Obx to watch the SubCategoryController
//             Obx(() {
//               if (subCategoryController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (subCategoryController.subCategories.isEmpty) {
//                 return const Center(child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 20),
//                   child: Text('No SubCategories Found!'),
//                 ));
//               }

//               // Use a fixed height for the horizontal list instead of Expanded
//               return SizedBox(
//                 height: 120, // Adjusted height to fit text and image
//                 child: ListView.builder(
//                   padding: const EdgeInsets.only(left: TSizes.defaultSpace),
//                   shrinkWrap: true,
//                   itemCount: subCategoryController.subCategories.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (_, index) {
//                     final sub = subCategoryController.subCategories[index];
//                     return TVerticalImageText(
//                       image: sub.image,
//                       title: sub.subCategoryName, // Use subCategoryName from your model
//                       onTap: () {
//                         // Navigate to specific subcategory products if needed
//                         print("Tapped on ${sub.subCategoryName}");
//                       },
//                     );
//                   },
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

class InnerCategoryContentWidget extends StatelessWidget {
  final CategoryMode category;
  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // 1. Initialize SubCategoryController and trigger fetch immediately
    final subCategoryController = Get.put(SubCategoryController());
    
    // Fetch subcategories for THIS specific category name
    subCategoryController.fetchProductsByCategoriesName(category.name);

    return Scaffold(
      // appBar: TAppBar(
      //   title: Text(
      //     category.name,
      //     style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black),
      //   ),
      //   showBackArrow: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwSections),
            // Searchbar
            const TSearchContainer(text: 'Search in Store'),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            // Banner
            InnerBannerWidget(banner: category.banner),
            const SizedBox(height: TSizes.spaceBtwItems),

            Center(
              child: Text(
                'Shop By SubCategories:',
                style: GoogleFonts.quicksand(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // 2. Use Obx to watch the SubCategoryController
           Obx(() {
                if (subCategoryController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (subCategoryController.subCategories.isEmpty) {
                  return const Center(child: Text('No SubCategories Found!'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: subCategoryController.subCategories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (_, index) {
                    final sub = subCategoryController.subCategories[index];
                    
                    // ✅ Wrap in Obx so the specific item updates its color when selected
                    return Obx(() {
                      final isSelected = subCategoryController.selectedSubCategoryId.value == sub.id;

                      return InkWell(
                        onTap: () => subCategoryController.selectSubCategory(sub.id),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // ✅ Background color changes if selected
                            color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: SubcategoryTilewidget(image: sub.image, name: sub.subCategoryName),
                        ),
                      );
                    });
                  },
                );
              })
                          
            // Add extra space at the bottom for better scrollin
          ],
        ),
      ),
    );
  }
}


// class InnerCategoryScreen extends StatelessWidget {
//   final CategoryMode category;
//   const InnerCategoryScreen({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     // 1. Initialize SubCategoryController
//     final subCategoryController = Get.put(SubCategoryController());
    
//     // Fetch subcategories for this specific category
//     subCategoryController.fetchProductsByCategoriesName(category.name);

//     return Scaffold(
//       appBar: TAppBar(
//         title: Text(
//           category.name,
//           style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black),
//         ),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: TSizes.spaceBtwSections),
//             const TSearchContainer(text: 'Search in Store'),
//             const SizedBox(height: TSizes.spaceBtwItems),
            
//             InnerBannerWidget(banner: category.banner),
//             const SizedBox(height: TSizes.spaceBtwItems),

//             Center(
//               child: Text(
//                 'Shop By SubCategories:',
//                 style: GoogleFonts.quicksand(
//                   textStyle: Theme.of(context).textTheme.bodyMedium,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.7,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems),

//             // 2. Multi-row Horizontal Scroll Logic
//             Obx(() {
//               if (subCategoryController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (subCategoryController.subCategories.isEmpty) {
//                 return const Center(child: Text('No SubCategories Found!'));
//               }

//               final allItems = subCategoryController.subCategories;
//               const int itemsPerRow = 4; // Number of items per horizontal row

//               return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(
//                     (allItems.length / itemsPerRow).ceil(),
//                     (setIndex) {
//                       // Calculate start and end indices for the current row
//                       final start = setIndex * itemsPerRow;
//                       int end = (setIndex + 1) * itemsPerRow;
//                       if (end > allItems.length) end = allItems.length;

//                       // Create a sublist for this row
//                       final rowItems = allItems.sublist(start, end);

//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Row(
//                           children: rowItems.map((item) {
//                             return SubcategoryTilewidget(
//                               image: item.image,
//                               name: item.subCategoryName,
//                             );
//                           }).toList(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             }),
            
//             const SizedBox(height: TSizes.spaceBtwSections),
//           ],
//         ),
//       ),
//     );
//   }
// }