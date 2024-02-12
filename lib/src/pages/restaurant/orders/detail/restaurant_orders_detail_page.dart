import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/models/user.dart';
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
      bottomNavigationBar: SafeArea(
        child: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: size.height * .45,
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
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 30),
          child: const Text(
            "Asignar Repartidor",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.amber,
                fontWeight: FontWeight.bold),
          ),
        ),
        _dropDownDeliveryUsers(controller.users),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  "Total: ${controller.getTotal().toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
          "${RelativeTimeUtil.getRelativeTime(controller.order.timestamp ?? DateTime.now().day)}",
        ),
        trailing: const Icon(Icons.timer),
      ),
    );
  }

  Widget _dropDownDeliveryUsers(List<User> users) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: const Text(
          'Seleccionar repartidor',
        ),
        items: _dropDownItems(users),
        value: controller.idDeliveryUser.value == ''
            ? null
            : controller.idDeliveryUser.value,
        onChanged: (option) {
          controller.idDeliveryUser.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String?>> _dropDownItems(List<User> users) {
    List<DropdownMenuItem<String>> list = [];
    users.forEach((user) {
      list.add(DropdownMenuItem(
        value: user.id,
        child: Row(
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: FadeInImage(
                  image: user.image != null
                      ? NetworkImage(user.image!)
                      : const AssetImage(
                          'assets/img/no-image.png',
                        ) as ImageProvider,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage(
                    'assets/img/no-image.png',
                  ),
                )),
            SizedBox(
              width: 10,
            ),
            Text("${user.name} ${user.lastname}"),
          ],
        ),
      ));
    });

    return list;
  }
}
