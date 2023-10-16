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

  ClientAddressListController() {
    print("La direccion de sesion ${GetStorage().read('address')}");
  }

  Future<List<Address>> getAddressList() async {
    addressList = await AddressProvider().findByUser(user.id ?? "");

    if (GetStorage().read('address') != null) {
      Address storageAddress = Address.fromJson(GetStorage().read('address'));
      int index = addressList
          .indexWhere((singleAddress) => singleAddress.id == storageAddress.id);
      if (index != -1) {
        radioValue.value = index;
      }
    }

    return addressList;
  }

  void handleRadioValueChange(int value) {
    radioValue.value = value;
    GetStorage().write("address", addressList[value].toJson());
    update();
  }

  void goToAddressCreate() {
    Get.toNamed('/client/address/create');
  }
}
