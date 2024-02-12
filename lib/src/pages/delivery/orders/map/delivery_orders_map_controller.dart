import 'dart:async';

import 'package:delivery_app/src/environment/environment.dart';
import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class DeliveryOrdersMapController extends GetxController {
  OrdersProvider ordersProvider = OrdersProvider();
  Order order = Order.fromJson(Get.arguments['order']);
  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(25.696974, -100.316156), zoom: 14);

  LatLng? addressLatLng;
  var addressName = "".obs;

  Completer<GoogleMapController> mapController = Completer();
  Position? position;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  BitmapDescriptor? deliveryMarker;
  BitmapDescriptor? homeMarker;

  StreamSubscription? positionSubscribe;

  Set<Polyline> polylines = <Polyline>{}.obs;
  List<LatLng> points = [];

  DeliveryOrdersMapController() {
    createMarkers();
    checkGPS(); // Verify if GPS is active and get permission
  }

  Future setLocationDraggableInfo() async {
    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;

    List<Placemark> address = await placemarkFromCoordinates(lat, lng);

    if (address.isNotEmpty) {
      String street = address[0].thoroughfare ?? "Sin nombre";
      String neighborhood = address[0].subLocality != null
          ? address[0].subLocality != ""
              ? " ${address[0].subLocality!}"
              : ""
          : "";
      String externalNumber = address[0].subThoroughfare != null
          ? address[0].subThoroughfare != ""
              ? " #${address[0].subThoroughfare!}"
              : ""
          : "";
      String city = address[0].locality ?? "Sin nombre";
      String department = address[0].administrativeArea ?? "Sin nombre";

      addressName.value =
          "$street$neighborhood$externalNumber, $city, $department";
      addressLatLng = LatLng(lat, lng);
    }
  }

  void selectRefPoint(BuildContext context) {
    if (addressLatLng != null) {
      Map<String, dynamic> data = {
        "address": addressName.value,
        "lat": addressLatLng!.latitude,
        "lng": addressLatLng!.longitude,
      };

      Navigator.pop(context, data);
    }
  }

  Future<BitmapDescriptor> createMarkerFromAssets(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor =
        await BitmapDescriptor.fromAssetImage(configuration, path);
    return descriptor;
  }

  void addMarker(String markerId, double lat, double lng, String title,
      String content, BitmapDescriptor iconMarker) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: iconMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content),
    );

    markers[id] = marker;
    update();
  }

  void createMarkers() async {
    deliveryMarker =
        await createMarkerFromAssets('assets/img/delivery_little.png');
    homeMarker = await createMarkerFromAssets('assets/img/home.png');
    addMarker(
      'home',
      order.address.lat,
      order.address.lng,
      "Lugar de entrega",
      "",
      homeMarker!,
    );
  }

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled) {
      updateLocation();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();
      }
    }
  }

  Future<void> setPolylines(LatLng from, LatLng to) async {
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        Environment.API_KEY_MAPS, pointFrom, pointTo);

    for (PointLatLng point in result.points) {
      points.add(LatLng(point.latitude, point.longitude));
    }

    Polyline polyline = Polyline(
      polylineId: PolylineId("poly"),
      color: Colors.amber,
      points: points,
      width: 5,
    );

    polylines.add(polyline);
    update();
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition(); // Current Lat y Lng
      saveLocation();
      animateCameraPosition(
          position?.latitude ?? 25.696974, position?.longitude ?? -100.316156);
      addMarker(
        'delivery',
        position?.latitude ?? 25.696974,
        position?.longitude ?? -100.316156,
        "Tu posición",
        "",
        deliveryMarker!,
      );
      LatLng from = LatLng(
        position?.latitude ?? 25.696974,
        position?.longitude ?? -100.316156,
      );
      LatLng to = LatLng(
        order.address.lat,
        order.address.lng,
      );

      setPolylines(from, to);

      LocationSettings locationSettings =
          LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 1);

      positionSubscribe =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((currentPosition) {
        //Posicion en tiempo real
        position = currentPosition;
        animateCameraPosition(position?.latitude ?? 25.696974,
            position?.longitude ?? -100.316156);
        addMarker(
          'delivery',
          position?.latitude ?? 25.696974,
          position?.longitude ?? -100.316156,
          "Tu posición",
          "",
          deliveryMarker!,
        );
      });
    } catch (e) {
      print("Error $e");
    }
  }

  Future animateCameraPosition(double lat, double lng) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 13, bearing: 0)));
  }

  void onMapCreate(GoogleMapController controller) {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    if (mapController.isCompleted) {
      return;
    }
    mapController.complete(controller);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  callNumber() async {
    String number = order.client.phone; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void centerPosition() {
    if (position != null) {
      animateCameraPosition(position!.latitude, position!.longitude);
    }
  }

  void saveLocation() async {
    if (position != null) {
      order.lat = position!.latitude;
      order.lng = position!.longitude;
    }
    await ordersProvider.updateLatLng(order);
  }

  @override
  void onClose() {
    super.onClose();
    positionSubscribe?.cancel();
  }
}
