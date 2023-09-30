import 'package:delivery_app/src/models/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientOrdersCreateController extends GetxController {
  List<Product> selectedProducts = <Product>[].obs;
  var total = 0.0.obs;

  ClientOrdersCreateController() {
    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Product>) {
        var result = GetStorage().read('shopping_bag');
        selectedProducts.addAll(result);
      }
      else {
        List<dynamic> myList = GetStorage().read('shopping_bag');
        selectedProducts = Product.fromJsonList(myList);
      }
    }
  }

  removeItem(Product product) {
    if (product.quantity! > 1) {
      int index = selectedProducts.indexWhere((element) => element.id == product.id);
      selectedProducts.remove(product);
      product.quantity = product.quantity! - 1;
      selectedProducts.insert(index, product);
      GetStorage().write('shopping_bag', selectedProducts);
    }
    else {
    }
  }

  addItem(Product product) {
    int index = selectedProducts.indexWhere((element) => element.id == product.id);
    selectedProducts.remove(product);
    product.quantity = product.quantity! + 1;
    selectedProducts.insert(index, product);
    GetStorage().write('shopping_bag', selectedProducts);
  }

  deleteItem(Product product) {
    selectedProducts.remove(product);
    GetStorage().write('shopping_bag', selectedProducts);
  }

  double getTotal() {
    total.value = 0.0;
    selectedProducts.forEach((product) {
      total.value += (product.quantity! * product.price!);
    });

    return total.value;
  }
}