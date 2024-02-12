import 'package:delivery_app/src/models/order.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RestaurantOrdersDetailContorller extends GetxController {
  Order order = Order.fromJson(Get.arguments['order']);
  var total = 0.0.obs;

  RestaurantOrdersDetailContorller() {
    print("Order: ${order.toJson()}");
    getTotal();
  }

  double getTotal() {
    total.value = 0.0;
    order.products.forEach((product) {
      total.value += (product.quantity! * product.price!);
    });
    return total.value;
  }
}
