import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/providers/address_provider.dart';
import 'package:delivery_app/src/providers/orders_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientAddressListController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});
  List<Address> addressList = [];
  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();

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

  void createOrder() async {
    List<Product> products = [];
    Address storageAddress = Address.fromJson(GetStorage().read('address'));
    if (GetStorage().read('shopping_bag') is List<Product>) {
      var result = GetStorage().read('shopping_bag');
      products.addAll(result);
    } else {
      List<dynamic> myList = GetStorage().read('shopping_bag');
      products = Product.fromJsonList(myList);
    }
    Order order = Order(
      idClient: user.id!,
      idAddress: storageAddress.id!,
      products: products,
      lat: storageAddress.lat,
      lng: storageAddress.lng,
      address: storageAddress,
      client: user,
    );

    ResponseApi responseApi = await ordersProvider.create(order);

    if (responseApi.success == true) {
      GetStorage().remove("shopping_bag");
      Get.toNamed("/client/payments/create/");
    }

    Fluttertoast.showToast(
      msg: "Proceso terminado ${responseApi.message ?? ""}",
      toastLength: Toast.LENGTH_LONG,
    );
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
