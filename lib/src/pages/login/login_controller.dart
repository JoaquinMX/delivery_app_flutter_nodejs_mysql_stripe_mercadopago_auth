import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {
      Get.snackbar('Formulario valido', 'Listo para ingresar');

    }
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