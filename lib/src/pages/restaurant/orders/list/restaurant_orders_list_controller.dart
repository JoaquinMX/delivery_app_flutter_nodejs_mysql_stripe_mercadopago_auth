import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/providers/orders_provider.dart';
import 'package:get/get.dart';

class RestaurantOrdersListController extends GetxController {
  List<String> status = ['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;
  OrdersProvider ordersProvider = OrdersProvider();

  Future<List<Order>> getOrders(String status) async {
    final orders = await ordersProvider.findByStatus(status);
    return orders;
  }

  void goToOrderDetail(Order order) {
    Get.toNamed("/restaurant/orders/detail",
        arguments: {'order': order.toJson()});
  }
}
