import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/feastures/shop/models/subCategory_model.dart';
import 'package:tm_store_app/service/global_variables.dart';


class SubCategoryController extends GetxController {
  final subCategories = <SubCategoryMode>[].obs;
  final isLoading = false.obs;
  var pageIndex = 0.obs; 


  // ✅ Add this to track selection
  final selectedSubCategoryId = ''.obs;

  void selectSubCategory(String id, ) {
    selectedSubCategoryId.value = id;
    //selectedSubCategoryId.value = subCategoryName;

    // print("Tapped on ${subCategories.firstWhere((subCategory) => subCategory.id == id)}");
    print("Tapped on $id");
   // print("Tapped on $subCategoryName");

  }

  // Observable index for the bottom bar

  void changePage(int index) {
    pageIndex.value = index;
  }



  Future<List<SubCategoryMode>> fetchProductsByCategoriesName(String categoryName) async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse("$uri/api/category/$categoryName/subcategories"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        
        // Map the data to your model
        final List<SubCategoryMode> fetchedList = data.map((e) => SubCategoryMode.fromJson(e)).toList();
        
        // Update the observable list so the UI reacts
        subCategories.assignAll(fetchedList);
        
        return fetchedList;
      } else {
        // Handle 404 and other status codes
        print('Error: ${response.statusCode} - ${response.body}');
        subCategories.clear();
        return [];
      }
    } catch (e) {
      print('Error loading subcategories: $e');
      subCategories.clear();
      return [];
    } finally {
      isLoading.value = false;
    }
  }
}