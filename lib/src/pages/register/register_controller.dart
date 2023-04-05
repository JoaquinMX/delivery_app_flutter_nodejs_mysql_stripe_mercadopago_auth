import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  void register() {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, name, lastName, phone, password, confirmPassword)) {
      Get.snackbar('Formulario valido', 'Listo para ingresar');

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