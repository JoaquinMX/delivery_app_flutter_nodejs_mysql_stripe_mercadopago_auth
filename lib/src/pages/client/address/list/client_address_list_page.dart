import 'package:delivery_app/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientAddressListPage extends StatelessWidget {

  ClientAddressListController controller = Get.put(ClientAddressListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          "Direcciones",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          _iconAddressCreate()
        ],
      ),
    );
  }
  
  Widget _iconAddressCreate() {
    return IconButton(
        onPressed: () => controller.goToAddressCreate(),
        icon: Icon(
            Icons.add,
            color: Colors.black,
        )
    );
  }
}
