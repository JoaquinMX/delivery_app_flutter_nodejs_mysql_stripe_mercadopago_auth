import 'package:delivery_app/src/environment/environment.dart';
import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrdersProvider extends GetConnect {
  String url = Environment.API_URL + "/api/orders";
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  // Future<List<Category>> getAll() async {
  //   Response response = await get("$url/getAll", headers: {
  //     "Content-Type": "application/json",
  //     'Authorization': userSession.sessionToken ?? ""
  //   });
  //
  //   if (response.statusCode == 401) {
  //     Get.snackbar('Petición denegada',
  //         'Tu usuario no tiene permitido obtener esta información');
  //     return [];
  //   }
  //
  //   List<Category> categories = Category.fromJsonList(response.body);
  //
  //   return categories;
  // }

  Future<ResponseApi> create(Order order) async {
    Response response = await post("$url/create", order.toJson(), headers: {
      "Content-Type": "application/json",
      'Authorization': userSession.sessionToken ?? ""
    });

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
