import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/providers/orders_provider.dart';
import 'package:delivery_app/src/providers/users_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RestaurantOrdersDetailController extends GetxController {
  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;
  Order order = Order.fromJson(Get.arguments['order']);
  var total = 0.0.obs;
  var idDeliveryUser = ''.obs;

  RestaurantOrdersDetailController() {
    getDeliveryUser();
    getTotal();
    idDeliveryUser.value = order.idDelivery ?? "";
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

  void updateOrder() async {
    // Si hay un repartidor asignado
    print(idDeliveryUser.value);
    if (idDeliveryUser.value != "") {
      order.idDelivery = idDeliveryUser.value;
      order.status = "DESPACHADO";
      ResponseApi responseApi = await ordersProvider.updateStatus(order);
      Fluttertoast.showToast(
          msg: responseApi.message ?? "", toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        Get.offNamedUntil("restaurant/home", (route) => false);
      }
    } else {
      Get.snackbar("Peticion denegada", "Se debe asignar un repartidor");
    }
  }
}
