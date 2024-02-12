import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RestaurantOrdersDetailContorller extends GetxController {
  UsersProvider usersProvider = UsersProvider();
  List<User> users = <User>[].obs;
  Order order = Order.fromJson(Get.arguments['order']);
  var total = 0.0.obs;
  var idDeliveryUser = ''.obs;

  RestaurantOrdersDetailContorller() {
    getDeliveryUser();
    getTotal();
  }

  void getDeliveryUser() async {
    var result = await usersProvider.findDeliveryUser();
    users.clear();
    users.addAll(result);
  }

  double getTotal() {
    total.value = 0.0;
    order.products.forEach((product) {
      total.value += (product.quantity! * product.price!);
    });
    return total.value;
  }
}
