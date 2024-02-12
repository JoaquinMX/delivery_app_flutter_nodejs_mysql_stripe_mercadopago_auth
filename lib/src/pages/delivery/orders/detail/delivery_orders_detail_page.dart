import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/pages/delivery/orders/detail/delivery_orders_detail_controller.dart';
import 'package:delivery_app/src/utils/relative_time_util.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryOrderDetailPage extends StatelessWidget {
  static const kDespachado = "DESPACHADO";
  static const kEnCamino = "EN CAMINO";

  DeliveryOrdersDetailController controller =
      Get.put(DeliveryOrdersDetailController());

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
      bottomNavigationBar: SafeArea(
        child: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: size.height * .40,
          child: Obx(
            () => Column(
              children: [
                _dataDate(),
                _dataClient(),
                _dataAddress(),
                _totalToPay(),
              ],
            ),
          ),
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
                Text(
                  product.name.length > 25
                      ? "${product.name.substring(0, 25)}..."
                      : product.name,
                  style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.bold,
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
    return SizedBox(
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
              Text(
                "Total: ${controller.getTotal().toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              _buttonActionOrder()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonActionOrder() {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
        ),
        onPressed: controller.order.status == kDespachado
            ? () => controller.updateOrder()
            : controller.order.status == kEnCamino
                ? () => controller.goToOrderMap()
                : null,
        child: Text(
          controller.order.status == kDespachado
              ? "Iniciar Entrega"
              : controller.order.status == kEnCamino
                  ? "Ir al mapa"
                  : "Entregado",
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _dataClient() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text("Cliente y telefono"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${controller.order.client.name} ${controller.order.client.lastname}",
            ),
            Text(controller.order.client.phone)
          ],
        ),
        trailing: const Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text("Dirección de entrega"),
        subtitle: Text(
          "${controller.order.address.address}, ${controller.order.address.neighborhood}",
        ),
        trailing: const Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text("Fecha del pedido"),
        subtitle: Text(
          RelativeTimeUtil.getRelativeTime(
              controller.order.timestamp ?? DateTime.now().day),
        ),
        trailing: const Icon(Icons.timer),
      ),
    );
  }
}
