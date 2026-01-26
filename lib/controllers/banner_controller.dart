
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:tm_store_app/global_variables.dart';
import 'package:tm_store_app/models/banner_model.dart';

// class BannerController {

//   Future<List<BannerModel>> loadBanners() async {
//     try {
//          http.Response response = await http.get(Uri.parse("$uri/api/banners"),
//           headers: <String, String>{
//         "Content-Type": 'application/json; charset=UTF-8'
//        });
//       //  print(response.body);
//        if (response.statusCode == 200){
//           List<dynamic> bannerList = jsonDecode(response.body);
//           List<BannerModel> banners = bannerList.map((banner) => BannerModel.fromJson(banner)).toList();
//           return banners;
//        } else {
//         throw Exception('Failed to load Banners');
//        }
//     } catch (e) {
//       throw Exception('Error loading Banners: $e');
//     }
//   } 
// }
class BannerController extends GetxController {
  final isLoading = true.obs;
  final banners = <BannerModel>[].obs;
  final carouselIndex = 0.obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updateIndex(int index) {
    carouselIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse("$uri/api/banners"));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        List<dynamic> list =
            decoded is List ? decoded : decoded['banners'];

        final result =
            list.map((e) => BannerModel.fromJson(e)).toList();

        banners.assignAll(result);
      }
    } catch (e) {
      print("Banner Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}


