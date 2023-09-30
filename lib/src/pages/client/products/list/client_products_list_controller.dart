import 'package:delivery_app/src/environment/environment.dart';
import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:delivery_app/src/providers/categories_provider.dart';
import 'package:delivery_app/src/providers/products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
class ClientProductsListController extends GetxController {
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;

  ClientProductsListController() {
    getCategories();
  }
  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String id_category) async {
    return await productsProvider.findByCategory(id_category);
  }

  void goToOrderCreate() {
    Get.toNamed('client/orders/create');
  }

  void openBottomSheet(BuildContext context, Product product) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductDetailPage(product: product)
    );
  }
}