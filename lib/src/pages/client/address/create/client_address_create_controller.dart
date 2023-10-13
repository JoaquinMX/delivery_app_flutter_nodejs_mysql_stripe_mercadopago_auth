import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/pages/client/address/map/client_address_map_page.dart';
import 'package:delivery_app/src/providers/address_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController {
  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  AddressProvider addressProvider = AddressProvider();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  double latRefPoint = 0;
  double lngRefPoint = 0;

  void openGoogleMaps(BuildContext context) async {
    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientAddressMapPage(),
      isDismissible: false,
      enableDrag: false,
    );

    if (refPointMap.isNotEmpty) {
      refPointController.text = refPointMap['address'];
      latRefPoint = refPointMap['lat'];
      lngRefPoint = refPointMap['lng'];
    }
  }

  void createaddress() async {
    String addressName = addressController.text.trim();
    String neighborhoodName = neighborhoodController.text.trim();
    if (isValidForm(addressName, neighborhoodName)) {
      Address address = Address(
        address: addressName,
        neighborhood: neighborhoodName,
        idUser: userSession.id!,
        lat: latRefPoint,
        lng: lngRefPoint,
      );

      ResponseApi responseApi = await addressProvider.create(address);
      Fluttertoast.showToast(
          msg: responseApi.message ?? "", toastLength: Toast.LENGTH_LONG);
      Get.back();
    }
  }

  bool isValidForm(String address, String neighborhood) {
    if (address.isEmpty) {
      Get.snackbar(
          'Formulario no válido', 'Debes ingresar el nombre de la dirección');
      return false;
    }
    if (neighborhood.isEmpty) {
      Get.snackbar(
          'Formulario no válido', 'Debes ingresar el nombre de la colonia');
    }
    if (latRefPoint == 0 || lngRefPoint == 0) {
      Get.snackbar(
          'Formulario no válido', 'Debes seleccionar un punto de referencia');
    }
    return true;
  }
}
