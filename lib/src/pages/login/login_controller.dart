import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();


    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);
      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data);
        Get.snackbar('Login Exitoso', responseApi.message ?? '');
        goToHomePage();
      }
      else {
        Get.snackbar('Login Fallido', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar un correo electrónico');
      return false;
    }

    if(!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El correo electrónico no existe');
      return false;
    }


    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu contraseña');
      return false;
    }

    return true;
  }
}