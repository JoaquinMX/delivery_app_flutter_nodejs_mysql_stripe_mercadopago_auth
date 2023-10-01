import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientOrdersCreatePage extends StatelessWidget {

  ClientOrdersCreateController controller = Get.put(ClientOrdersCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          title: Text(
              "Mi orden",
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
        body: controller.selectedProducts.length > 0
            ? ListView(
          children: controller.selectedProducts.map((Product singleProduct) {
            return _cardProduct(singleProduct);
          }).toList(),
        )
            : NoDataWidget(text: "No hay ningún producto agregado por el momento"),
        bottomNavigationBar: Container(
          color: Color.fromRGBO(245, 245, 245, 1),
          height: 120,
          child: _totalToPay(),
        ),
      ),
    );
  }

  Widget _totalToPay() {
    return Container(
      child: Column(
        children: [
          Divider(
            indent: 30,
            endIndent: 30,
            height: 1,
            color: Colors.black54,
          ),
          SizedBox(
            height: 15,
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15)
              ),
                onPressed: () => controller.goToAddressList(),
                child: Text(
                  "Confirmar Orden: ${controller.getTotal().toStringAsFixed(2)}\$",
                  style: TextStyle(
                    color: Colors.black
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    product.name.length > 20
                        ? product.name.substring(0, 20) + "..."
                        : product.name,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buttonsAddOrRemove(product)
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product)
            ],
          )
        ],
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
        onPressed: () => controller.deleteItem(product),
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        )
    );
  }
  Widget _textPrice(Product product)  {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '${(product.price! * product.quantity!).toStringAsFixed(2)}\$',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      height: 70,
      width: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : AssetImage('asset/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _buttonsAddOrRemove(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => controller.removeItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            ),
            child: Text("-"),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.black12,
          child: Text(product.quantity.toString().length < 2
              ? "${" " + product.quantity!.toString()} "
              : product.quantity.toString()
          ),
        ),
        GestureDetector(
          onTap: () => controller.addItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
            ),
            child: Text("+"),
          ),
        ),
      ],
    );
  }
}
