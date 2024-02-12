import 'package:delivery_app/src/environment/environment.dart';
import 'package:delivery_app/src/models/order.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrdersProvider extends GetConnect {
  String url = Environment.API_URL + "/api/orders";
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> findByStatus(String status) async {
    Response response = await get("$url/findByStatus/$status", headers: {
      "Content-Type": "application/json",
      'Authorization': userSession.sessionToken ?? ""
    });

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada',
          'Tu usuario no tiene permitido obtener esta información');
      return [];
    }
    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<List<Order>> findByIdDeliveryAndStatus(
      String idDelivery, String status) async {
    Response response =
        await get("$url/findByDeliveryAndStatus/$idDelivery/$status", headers: {
      "Content-Type": "application/json",
      'Authorization': userSession.sessionToken ?? ""
    });

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada',
          'Tu usuario no tiene permitido obtener esta información');
      return [];
    }
    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<ResponseApi> create(Order order) async {
    Response response = await post("$url/create", order.toJson(), headers: {
      "Content-Type": "application/json",
      'Authorization': userSession.sessionToken ?? ""
    });

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateStatus(Order order) async {
    Response response =
        await put("$url/updateStatus", order.toJson(), headers: {
      "Content-Type": "application/json",
      'Authorization': userSession.sessionToken ?? ""
    });

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateLatLng(Order order) async {
    Response response =
        await put("$url/updateLatLng", order.toJson(), headers: {
      "Content-Type": "application/json",
      'Authorization': userSession.sessionToken ?? ""
    });

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
