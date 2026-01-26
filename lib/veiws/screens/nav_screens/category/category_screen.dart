import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/controllers/category_controller.dart';
import 'package:tm_store_app/controllers/subCategory_controller.dart';


// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CategoryController categoryController = Get.put(CategoryController());
    
//     final _selectedCategory = categoryController;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
//         child: const TAppBar(),
//       ),
//       body: Row(
//         children: [
//           // Left side - Display Categories
//           Expanded(
//             flex: 2,
//             child: Container(
//               color: Colors.grey.shade200,
//               child: Obx(() {
//                 if (categoryController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 else if (categoryController.categories.isEmpty) {
//                   return const Center(child: Text("No categories found"));
//                 } else{
//                   // return ListView.builder(
//                   //   itemCount: categoryController.categories.length,
//                   //   itemBuilder: (context, index) {
//                   //     final category = categoryController.categories[index];
//                   //     return ListTile(
//                   //       title: Text(category.name),
//                   //       onTap: () {
//                   //         categoryController.selectCategory(category.id);
//                   //       },
//                   //       selected: categoryController.selectedCategoryId.value == category.id,
//                   //     );
//                   //   },
//                   // );
//                   return ListView.builder(
//                   itemCount: categoryController.categories.length,
//                   itemBuilder: (context, index) {
//                     final category = categoryController.categories[index];
//                     return ListTile(
//                       onTap: () {
//                         // categoryController.selectCategory(category.id);
//                         setSate(() {
//                           _selectedCategory = category;
//                         });
//                       },
//                       title: Text(category.name,
//                       style: GoogleFonts.quicksand(
//                         fontSize: 15, fontWeight: FontWeight.bold,
//                         color: _selectedCategory == category ? Colors.blue : Colors.black,
//                         ),                  
//                       ),
                     
//                     );
//                   },
//                 );
//                 }

               
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CategoryController categoryController = Get.find<CategoryController>(); // must already be put in binding/init

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize:
//             Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
//         child: const TAppBar(),
//       ),
//       body: Row(
//         children: [
//           // LEFT: Categories
//           Expanded(
//             flex: 2,
//             child: Container(
//               color: Colors.grey.shade200,
//               child: Obx(() {
//                 if (categoryController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (categoryController.categories.isEmpty) {
//                   return const Center(child: Text("No categories found"));
//                 }

//                 return ListView.builder(
//                   itemCount: categoryController.categories.length,
//                   itemBuilder: (context, index) {
//                     final category = categoryController.categories[index];
//                     final isSelected =
//                         categoryController.selectedCategoryId.value ==
//                             category.id;

//                     return InkWell(
//                       onTap: () {
//                         categoryController.selectCategory(category.id);
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         color: isSelected
//                             ? Colors.blue.withOpacity(0.15)
//                             : Colors.transparent,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 14, horizontal: 10),
//                         child: Text(
//                           category.name,
//                           style: TextStyle(
//                             color:
//                                 isSelected ? Colors.blue : Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ),

//           // RIGHT: Products by Category (optional – when ready)
//           /*
//           Expanded(
//             flex: 5,
//             child: Obx(() {
//               final selectedId =
//                   categoryController.selectedCategoryId.value;
//               if (selectedId == null) {
//                 return const Center(child: Text("Select a category"));
//               }
//               return ProductGrid(categoryId: selectedId);
//             }),
//           ),
//           */
//         ],
//       ),
//     );
//   }
// }


// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Ensure the controller is put into memory (usually via Get.put() in a binding)
//     final CategoryController categoryController = Get.find<CategoryController>();
//     final SubCategoryController subCategoryController = Get.put(SubCategoryController());
    
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
//         child: const TAppBar(), // Ensure TAppBar is defined in your project
//       ),
//       body: Row(
//         children: [
//           // LEFT SIDEBAR: Categories
//           Expanded(
//             flex: 2,
//             child: Container(
//               color: Colors.grey.shade100,
//               child: Obx(() {
//                 if (categoryController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (categoryController.categories.isEmpty) {
//                   return const Center(child: Text("No categories"));
//                 }

//                 return ListView.builder(
//                   itemCount: categoryController.categories.length,
//                   itemBuilder: (context, index) {
//                     final category = categoryController.categories[index];
                    
//                     // ✅ This reactive check updates the UI on click
//                     return Obx(() {
//                       final isSelected = categoryController.selectedCategoryId.value == category.id;

//                       return InkWell(
//                         onTap: () => categoryController.selectCategory(category, category.id, category.name, category.banner),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: isSelected ? Colors.white : Colors.transparent,
//                             border: Border(
//                               left: BorderSide(
//                                 color: isSelected ? Colors.blue : Colors.transparent,
//                                 width: 4,
//                               ),
//                             ),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
//                           child: Text(
//                             category.name,
//                             style: TextStyle(
//                               color: isSelected ? Colors.blue : Colors.black87,
//                               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       );
//                     });
//                   },
//                 );
//               }),
//             ),
//           ),

//           // RIGHT CONTENT: Products
//           // Expanded(
//           //   flex: 5,
//           //   child: Container(
//           //     color: Colors.white,
//           //     child: Obx(() {
//           //       final selectedName = categoryController.selectedCategoryName.value;
//           //       final selectedBanner = categoryController.selectedCategoryBanner.value;
//           //       if (selectedName == null) {
//           //         return const Center(child: Text("Select a category"));
//           //       } 
//           //       // Return your grid here
//           //       return Column(
//           //         crossAxisAlignment: CrossAxisAlignment.start,
//           //         children: [
//           //           Padding(
//           //             padding: const EdgeInsets.all(8.0),
//           //              child: Text(
//           //               selectedName,
//           //               style: GoogleFonts.quicksand(
//           //                 fontSize: 16,
//           //                 fontWeight: FontWeight.bold,
//           //                 letterSpacing: 1.7
//           //               )
//           //              )
//           //             ),
//           //             Padding(
//           //               padding: const EdgeInsets.all(8.0),
//           //               child: Container(
//           //                 width: double.infinity,
//           //                 height: 150,
//           //                 decoration: BoxDecoration(
//           //                   image: DecorationImage(image: NetworkImage(selectedBanner),
//           //                   fit: BoxFit.cover,
//           //                   )
//           //                 ),
//           //               ),
//           //             )


//           //         ],
//           //       );
//           //     }),
//           //   ),
//           // ),


//           Expanded(
//             flex: 5,
//             child: Container(
//               color: Colors.white,
//               child: Obx(() {
//                 final selectedName = categoryController.selectedCategoryName.value;
//                 final selectedBanner = categoryController.selectedCategoryBanner.value;
//                 final isLoading = categoryController.isCategoryDetailsLoading.value;
//                 if (selectedName.isEmpty) {
//                   return const Center(child: Text("Select a category"));
//                 }
//                 if (isLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         selectedName,
//                         style: GoogleFonts.quicksand(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1.7,
//                         ),
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: double.infinity,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           image: selectedBanner.isNotEmpty
//                               ? DecorationImage(
//                                   image: NetworkImage(selectedBanner),
//                                   fit: BoxFit.cover,
//                                 )
//                               : null,
//                           color: Colors.grey.shade300,
//                         ),
//                         child: selectedBanner.isEmpty
//                             ? const Center(child: Text("No banner"))
//                             : null,
//                       ),
//                     ),

//                     //SubCategory Grid can go here next
//                     // Obx(() {
//                     //   if (subCategoryController.isLoading.value) {
//                     //     return const Center(child: CircularProgressIndicator());
//                     //   }
//                     //   return Expanded(
//                     //     child: GridView.builder(
//                     //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     //         crossAxisCount: 2,
//                     //         childAspectRatio: 1.0,
//                     //       ),
//                     //       itemCount: subCategoryController.subCategories.length,
//                     //       itemBuilder: (context, index) {
//                     //         final subCategory = subCategoryController.subCategories[index];
//                     //         return GestureDetector(
//                     //           onTap: () {
//                     //             // Handle subcategory tap
//                     //           },
//                     //           child: Card(
//                     //             child: Column(
//                     //               children: [
//                     //                 Expanded(
//                     //                   child: Image.network(
//                     //                     subCategory.image,
//                     //                     fit: BoxFit.cover,
//                     //                   ),
//                     //                 ),
//                     //                 Padding(
//                     //                   padding: const EdgeInsets.all(8.0),
//                     //                   child: Text(
//                     //                     subCategory.categoryName,
//                     //                     style: GoogleFonts.quicksand(
//                     //                       fontSize: 14,
//                     //                       fontWeight: FontWeight.bold,
//                     //                     ),
//                     //                   ),
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //           ),
//                     //         );
//                     //       },
//                     //     ),
//                     //   );
//                     // }),
                    

//                     // Inside your Row -> Expanded (flex: 5)
//                     Obx(() {
//                       final subController = Get.find<SubCategoryController>();

//                       if (subController.isLoading.value) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       if (subController.subCategories.isEmpty) {
//                         return const Center(child: Text("No items found"));
//                       }

//                       return GridView.builder(
//                         padding: const EdgeInsets.all(10),
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           mainAxisSpacing: 10,
//                           crossAxisSpacing: 10,
//                           childAspectRatio: 0.8,
//                         ),
//                         itemCount: subController.subCategories.length,
//                         itemBuilder: (context, index) {
//                           final subItem = subController.subCategories[index];
                          
//                           return Column(
//                             children: [
//                               // SubCategory Image
//                               Expanded(
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     subItem.image,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) => 
//                                         const Icon(Icons.image_not_supported),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               // Using your model's field: subCategoryName
//                               Text(
//                                 subItem.subCategoryName,
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     })
//                   ],
//                 );
//               }),
//             ),
//           ),

//         ],
//       ),
//     );
//   }
// }

class CategoryScreen extends StatelessWidget {
  // final CategoryMode category;

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final CategoryController categoryController = Get.find();
     final CategoryController categoryController = Get.find<CategoryController>();

    // final SubCategoryController subCategoryController = Get.find();
    final SubCategoryController subCategoryController = Get.put(SubCategoryController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child:  TAppBar(
          title: Text(
           "Categories",
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white60),
        ),
        ),
      ),
      body: Row(
        children: [
          // ================= LEFT: CATEGORIES =================
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade100,
              child: Obx(() {
                if (categoryController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (categoryController.categories.isEmpty) {
                  return const Center(child: Text("No categories"));
                }
                return ListView.builder(
                  itemCount: categoryController.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryController.categories[index];
                    final isSelected =
                        categoryController.selectedCategoryId.value == category.id;

                    return InkWell(
                      onTap: () {
                        categoryController.selectCategory(
                          category,
                          category.id,
                          category.name,
                          category.banner,
                        );

                        // ✅ LOAD SUBCATEGORIES
                        subCategoryController
                            .fetchProductsByCategoriesName(category.name);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          border: Border(
                            left: BorderSide(
                              color: isSelected ? Colors.blue : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black87,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),

          // ================= RIGHT: SUBCATEGORIES =================
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Obx(() {
                final selectedName =
                    categoryController.selectedCategoryName.value;
                final selectedBanner =
                    categoryController.selectedCategoryBanner.value;
                final isLoading =
                    categoryController.isCategoryDetailsLoading.value;

                if (selectedName.isEmpty) {
                  return const Center(child: Text("Select a category"));
                }

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ===== CATEGORY NAME =====
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedName,
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),

                    // ===== BANNER =====
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          image: selectedBanner.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(selectedBanner),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey.shade300,
                        ),
                        child: selectedBanner.isEmpty
                            ? const Center(child: Text("No banner"))
                            : null,
                      ),
                    ),

                    // ===== SUBCATEGORY GRID =====
                    Expanded(
                      child: Obx(() {
                        if (subCategoryController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (subCategoryController.subCategories.isEmpty) {
                          return const Center(child: Text("No items found"));
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount:
                              subCategoryController.subCategories.length,
                          itemBuilder: (context, index) {
                            final subItem =
                                subCategoryController.subCategories[index];

                            return Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      subItem.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.image_not_supported),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  subItem.subCategoryName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

