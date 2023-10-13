import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/providers/address_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientAddressListController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});
  List<Address> addressList = [];
  AddressProvider addressProvider = AddressProvider();

  var radioValue = 0.obs;

  Future<List<Address>> getAddressList() async {
    addressList = await AddressProvider().findByUser(user.id ?? "");
    return addressList;
  }

  void handleRadioValueChange(int value) {
    radioValue.value = value;
  }

  void goToAddressCreate() {
    Get.toNamed('/client/address/create');
  }
}
