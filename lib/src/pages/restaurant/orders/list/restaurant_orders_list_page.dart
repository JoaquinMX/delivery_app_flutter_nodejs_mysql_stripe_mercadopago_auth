import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:delivery_app/src/utils/relative_time_util.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOrdersListPage extends StatelessWidget {
  RestaurantOrdersListController controller =
      Get.put(RestaurantOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: controller.status.length,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.amber,
                  unselectedLabelColor: Colors.white70,
                  tabs:
                      List<Widget>.generate(controller.status.length, (index) {
                    return Tab(
                      child: Text(controller.status[index]),
                    );
                  }),
                ),
              ),
            ),
            body: TabBarView(
                children: controller.status.map((String status) {
              return FutureBuilder(
                  future: controller.getOrders(status),
                  builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardOrder(snapshot.data![index]);
                            });
                      }
                      return Center(
                        child: NoDataWidget(text: 'No hay ordenes'),
                      );
                    } else {
                      return Center(
                        child: NoDataWidget(text: 'No hay ordenes'),
                      );
                    }
                  });
            }).toList())),
      ),
    );
  }

  Widget _cardOrder(Order order) {
    return GestureDetector(
      onTap: () => controller.goToOrderDetail(order),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 150,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 30,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.amber,
                  ),
                  child: Center(
                    child: Text(
                      "Orden #${order.id}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pedido: ${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)}',
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cliente: ${order.client.name != null ? "${order.client.name!} ${order.client.lastname!}" : "anonimo"}",
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Entregar en: ${order.address.address}",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
