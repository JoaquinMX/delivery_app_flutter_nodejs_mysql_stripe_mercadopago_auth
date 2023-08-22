import 'package:delivery_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController controller = Get.put(ClientProductsListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ClientProductList'),
            ElevatedButton(
            onPressed: () => controller.signOut(),
            child: Text(
              "Cerrar Sesion",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
