import 'package:delivery_app/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientAddressCreatePage extends StatelessWidget {
  ClientAddressCreateController controller =
      Get.put(ClientAddressCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _textNewAddress(context),
        _iconBack()
      ],
    ));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .30, left: 50, right: 50),
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
      ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldAddress(),
            _textFieldNeighborhood(),
            _textFieldRefPoint(context),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller.addressController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Calle', prefixIcon: Icon(Icons.location_on)),
      ),
    );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller.neighborhoodController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Colonia', prefixIcon: Icon(Icons.location_city)),
      ),
    );
  }

  Widget _textFieldRefPoint(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller.refPointController,
        keyboardType: TextInputType.text,
        onTap: () => controller.openGoogleMaps(context),
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
            hintText: 'Referencias', prefixIcon: Icon(Icons.map)),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          onPressed: () {
            controller.createAddress();
          },
          child: Text(
            'Añadir dirección',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
    );
  }

  Widget _textNewAddress(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 25),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Icon(
                Icons.location_on,
                size: MediaQuery.of(context).size.height * .16,
              ),
              Text(
                "Nueva dirección",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * .08,
                ),
              ),
            ],
          )),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'Ingresa tu dirección',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _iconBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 15),
        child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 32,
            )),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
