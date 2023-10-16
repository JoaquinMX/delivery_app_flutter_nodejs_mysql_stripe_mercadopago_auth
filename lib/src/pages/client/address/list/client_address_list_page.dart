import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientAddressListPage extends StatelessWidget {
  ClientAddressListController controller =
      Get.put(ClientAddressListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Direcciones",
          style: TextStyle(color: Colors.black),
        ),
        actions: [_iconAddressCreate()],
      ),
      body: GetBuilder<ClientAddressListController>(builder: (value) {
        return Stack(
          children: [
            _textSelectAddress(),
            _listAddress(),
          ],
        );
      }),
    );
  }

  Widget _listAddress() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: FutureBuilder(
          future: controller.getAddressList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Address>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return _radioSelectorAddress(snapshot.data![index], index);
                  });
            } else {
              return Center(
                child: NoDataWidget(text: "No hay direcciones"),
              );
            }
          }),
    );
  }

  Widget _radioSelectorAddress(Address address, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio(
                value: index,
                groupValue: controller.radioValue.value,
                onChanged: (value) => controller.handleRadioValueChange(value!),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.address ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    address.neighborhood ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        "Selecciona una dirección",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _iconAddressCreate() {
    return IconButton(
        onPressed: () => controller.goToAddressCreate(),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ));
  }
}
