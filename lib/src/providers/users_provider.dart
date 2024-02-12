import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/environment/environment.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../models/response_api.dart';

class UsersProvider extends GetConnect {
  String url = Environment.API_URL + "/api/users";
  User? userSession;
  Future<Response> create(User user) async {
    Response response = await post("$url/create", user.toJson(),
        headers: {"Content-Type": "application/json"});
    return response;
  }

  UsersProvider() {
    if (GetStorage().read("user") != null) {
      userSession = User.fromJson(GetStorage().read("user"));
    }
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, 'api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));

    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /**
   * Using GetX
   */
  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });

    Response response = await post('$url/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {
    print("$url/login");
    Response response = await post("$url/login", {
      'email': email,
      'password': password,
    }, headers: {
      "Content-Type": "application/json"
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> updateWithoutImage(User user) async {
    Response response =
        await put("$url/updateWithoutImage", user.toJson(), headers: {
      "Content-Type": "application/json",
      'Authorization': userSession!.sessionToken ?? ''
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la informacion');
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta petición');
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, 'api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = userSession!.sessionToken ?? "";
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));

    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<List<User>> findDeliveryUser() async {
    Response response = await get("$url/findDeliveryUser", headers: {
      "Content-Type": "application/json",
      'Authorization': userSession!.sessionToken ?? ""
    });

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada',
          'Tu usuario no tiene permitido obtener esta información');
      return [];
    }

    List<User> users = User.fromJsonList(response.body);

    return users;
  }
}
