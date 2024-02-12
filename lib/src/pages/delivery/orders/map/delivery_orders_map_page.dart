import 'package:delivery_app/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryOrdersMapPage extends StatelessWidget {
  DeliveryOrdersMapController controller =
      Get.put(DeliveryOrdersMapController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<DeliveryOrdersMapController>(
      builder: (value) => Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: size.height * .6,
              child: _googleMaps(),
            ),
            Column(
              children: [
                SafeArea(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonBack(),
                    _iconCenterMyLocation(),
                  ],
                )),
                const Spacer(),
                _cardOrderInfo(context, size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardOrderInfo(BuildContext context, Size size) {
    return Container(
      height: size.height * .42,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          _listTileAddress(
            controller.order.address.neighborhood,
            "Barrio",
            Icons.my_location,
          ),
          _listTileAddress(
            controller.order.address.address,
            "Dirección",
            Icons.location_on,
          ),
          Divider(
            color: Colors.grey,
            endIndent: 30,
            indent: 30,
          ),
          _clientInfo(),
          _buttonAccept(context)
        ],
      ),
    );
  }

  Widget _clientInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        children: [
          _imageClient(),
          SizedBox(
            width: 8,
          ),
          Text(
            "${controller.order.client.name} ${controller.order.client.lastname}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              color: Colors.grey[200],
            ),
            child: IconButton(
              icon: Icon(Icons.phone),
              color: Colors.black,
              onPressed: () => controller.callNumber(),
            ),
          )
        ],
      ),
    );
  }

  Widget _imageClient() {
    return Container(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: controller.order.client.image != null
              ? NetworkImage(controller.order.client.image!)
              : AssetImage('asset/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _listTileAddress(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buttonAccept(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () => controller.selectRefPoint(context),
        child: Text("Entregar Pedido"),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
      ),
    );
  }

  Widget _iconCenterMyLocation() {
    return GestureDetector(
      onTap: () => controller.centerPosition(),
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
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
      markers: Set<Marker>.of(controller.markers.values),
      polylines: controller.polylines,
    );
  }

  Widget _buttonBack() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.white,
        iconSize: 30,
      ),
    );
  }
}
