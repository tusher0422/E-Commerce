import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProductList();
    super.onInit();
  }

  void fetchProductList() async {
    try {
      isLoading(true);
      var result = await ApiService.fetchProducts();
      products.assignAll(result);
    } catch (e) {
      print('Product fetch failed: $e');
    } finally {
      isLoading(false);
    }
  }
}
