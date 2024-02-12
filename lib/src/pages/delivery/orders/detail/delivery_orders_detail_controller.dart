import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/providers/orders_provider.dart';
import 'package:delivery_app/src/providers/users_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DeliveryOrdersDetailController extends GetxController {
  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  Order order = Order.fromJson(Get.arguments['order']);
  var total = 0.0.obs;

  DeliveryOrdersDetailController() {
    getTotal();
  }

  double getTotal() {
    total.value = 0.0;
    order.products.forEach((product) {
      total.value += (product.quantity! * product.price!);
    });
    return total.value;
  }

  void updateOrder() async {
    order.status = "EN CAMINO";
    ResponseApi responseApi = await ordersProvider.updateStatus(order);
    Fluttertoast.showToast(
        msg: responseApi.message ?? "", toastLength: Toast.LENGTH_LONG);
    if (responseApi.success == true) {
      goToOrderMap();
    }
  }

  void goToOrderMap() {
    Get.toNamed("delivery/orders/map", arguments: {'order': order.toJson()});
  }
}
