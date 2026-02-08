import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/search_container.dart';
import 'package:tm_store_app/feastures/shop/controllers/subCategory_controller.dart';
import 'package:tm_store_app/feastures/shop/models/category_model.dart';
import 'package:tm_store_app/feastures/shop/views/category/widget/inner_banner_widget.dart';
import 'package:tm_store_app/feastures/shop/views/category/widget/subCategory_tileWidget.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

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


