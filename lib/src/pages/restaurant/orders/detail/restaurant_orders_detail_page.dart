import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:delivery_app/src/utils/relative_time_util.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOrderDetailPage extends StatelessWidget {
  RestaurantOrdersDetailContorller controller =
      Get.put(RestaurantOrdersDetailContorller());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Orden #${controller.order.id}"),
      ),
      body: controller.order.products.isNotEmpty
          ? ListView(
              children: controller.order.products.map((Product singleProduct) {
                return _cardProduct(singleProduct);
              }).toList(),
            )
          : NoDataWidget(
              text: "No hay ningún producto agregado por el momento",
            ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(245, 245, 245, 1),
        height: size.height * .45,
        child: Column(
          children: [
            _dataDate(),
            _dataClient(),
            _dataAddress(),
            _totalToPay(),
          ],
        ),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    product.name.length > 25
                        ? product.name.substring(0, 25) + "..."
                        : product.name,
                    style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text("Cantidad: ${product.quantity}")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('asset/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _totalToPay() {
    return Column(
      children: [
        const Divider(
          indent: 30,
          endIndent: 30,
          height: 1,
          color: Colors.black54,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => Container(
                  child: Text(
                    "Total: ${controller.getTotal().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Enviar Orden",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dataClient() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text("Cliente y telefono"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${controller.order.client.name} ${controller.order.client.lastname}",
            ),
            Text(controller.order.client.phone)
          ],
        ),
        trailing: Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text("Dirección de entrega"),
        subtitle: Text(
          "${controller.order.address.address}, ${controller.order.address.neighborhood}",
        ),
        trailing: Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text("Fecha del pedido"),
        subtitle: Text(
          "${RelativeTimeUtil.getRelativeTime(controller.order.timestamp ?? DateTime.now().day)}",
        ),
        trailing: Icon(Icons.timer),
      ),
    );
  }
}
