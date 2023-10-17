import 'package:delivery_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProfileInfoController extends GetxController {
  var user = User.fromJson(GetStorage().read('user')).obs;

  void signOut() {
    GetStorage().remove('user');
    GetStorage().remove("shopping_bag");
    GetStorage().remove("address");
    Get.offNamedUntil('/', (route) => false);
  }

  void goToProfileUpdate() {
    Get.toNamed('/client/profile/update');
  }

  goToRoles() {
    Get.offNamedUntil('/roles', (route) => false);
  }
}
