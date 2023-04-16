import 'package:delivery_app/src/environment/environment.dart';
import 'package:delivery_app/src/pages/user.dart';
import 'package:get/get.dart';

class UsersProviders extends GetConnect {
  String url = Environment.API_URL + "api/users";

  Future<Response> create(User user) async {

    Response response = await post(
      "$url/create",
      user.toJson(),
      headers: {
        "Content-Type":"application/json"
      }
    );
     return response;
  }
}