import 'package:delivery_app/src/pages/client/address/map/client_address_map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  void openGoogleMaps(BuildContext context) async {
    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientAddressMapPage(),
      isDismissible: false,
      enableDrag: false,
    );

    if (refPointMap.isNotEmpty) {
      refPointController.text = refPointMap['address'];
      print("Ref point map ${refPointMap}");
    }
  }
}