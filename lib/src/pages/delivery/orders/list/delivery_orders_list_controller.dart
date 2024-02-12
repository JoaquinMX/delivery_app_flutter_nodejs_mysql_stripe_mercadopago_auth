import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/providers/orders_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeliveryOrdersListController extends GetxController {
  List<String> status = ['DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;
  User user = User.fromJson(GetStorage().read("user"));
  OrdersProvider ordersProvider = OrdersProvider();

  Future<List<Order>> getOrders(String status) async {
    final orders =
        await ordersProvider.findByIdDeliveryAndStatus(user.id!, status);
    return orders;
  }

  void goToOrderDetail(Order order) {
    Get.toNamed("/delivery/orders/detail",
        arguments: {'order': order.toJson()});
  }
}
