import 'package:delivery_app/src/pages/user.dart';
import 'package:delivery_app/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProviders usersProvider = UsersProviders();

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(email, name, lastName, phone, password, confirmPassword)) {
      Get.snackbar('Formulario valido', 'Listo para ingresar');
      User user = User(
          email: email,
          name: name,
          lastname: lastName,
          phone: phone,
          password: password);
      Response response = await usersProvider.create(user);

      print("Response:  ${response.body}");
    }
  }

  bool isValidForm(
      String email,
      String name,
      String lastName,
      String phone,
      String password,
      String confirmPassword) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar un correo electrónico');
      return false;
    }

    if(!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El correo electrónico no existe');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tú nombre');
      return false;
    }
    if (lastName.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tú(s) apellido(s)');
      return false;
    }
    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar un número de teléfono');
      return false;
    }

    if(!GetUtils.isPhoneNumber(phone)) {
      Get.snackbar('Formulario no valido', 'Debes ingresar un número de teléfono válido');
      return false;
    }


    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu contraseña');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes confirmar tu contraseña');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido', 'Las contraseñas no coinciden');
      return false;
    }
    return true;
  }
}