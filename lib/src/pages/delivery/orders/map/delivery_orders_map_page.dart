import 'package:delivery_app/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryOrdersMapPage extends StatelessWidget {
  DeliveryOrdersMapController controller =
      Get.put(DeliveryOrdersMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Ubica tu punto de referencia",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          _googleMaps(),
          _iconMyLocation(),
          _cardAddress(),
          _buttonAccept(context)
        ],
      ),
    );
  }

  Widget _cardAddress() {
    return Obx(
      () => Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Card(
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              controller.addressName.value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonAccept(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        onPressed: () => controller.selectRefPoint(context),
        child: Text("Seleccionar"),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }

  Widget _iconMyLocation() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Image.asset(
          'assets/img/my_location_yellow.png',
          width: 65,
          height: 65,
        ),
      ),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      initialCameraPosition: controller.initialPosition,
      mapType: MapType.normal,
      onMapCreated: controller.onMapCreate,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        controller.initialPosition = position;
      },
      onCameraIdle: () async {
        await controller
            .setLocationDraggableInfo(); // Obtain Lat and Lng of central map position
      },
    );
  }
}
