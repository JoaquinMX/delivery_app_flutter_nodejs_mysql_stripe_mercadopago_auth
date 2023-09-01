import 'dart:convert';
import 'dart:io';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:delivery_app/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClientProfileUpdateController extends GetxController {
  // Atributos
  User user = User.fromJson(GetStorage().read('user'));
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  ClientProfileInfoController clientProfileInfoController = Get.find();
  ImagePicker picker = ImagePicker();
  File? imageFile;

  //Metodos

  ClientProfileUpdateController() {
    nameController.text = user.name ?? "";
    lastNameController.text = user.lastname ?? "";
    phoneController.text = user.phone ?? "";
  }

  void updateInfo(BuildContext context) async {
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();

    if (isValidForm(name, lastName, phone)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 20, msg: 'Actualizando datos...');
      User myUser = User(
          id: user.id,
          name: name,
          lastname: lastName,
          phone: phone,
          sessionToken: user.sessionToken
      );

      if (imageFile == null) {
        ResponseApi responseApi = await usersProvider.updateWithoutImage(myUser);
        Get.snackbar('Proceso Terminado', responseApi.message ?? '');
        if (responseApi.success == true) {
          GetStorage().write('user',  responseApi.data[0]);
          print(GetStorage().read('user'));
          clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user'));
        }
        progressDialog.close();

      }

      else {
        Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
        stream.listen((res) {
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          Get.snackbar('Proceso terminado', responseApi.message ?? '');
          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data[0]);
            clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user'));
          }
          else  {
            Get.snackbar('Registro Fallido', responseApi.message ?? "");
          }
          progressDialog.close();
        });
      }
      /*
      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);
          Get.snackbar('Login Exitoso', responseApi.message ?? '');
          goToClientProductList();
        }
        else  {
          Get.snackbar('Registro Fallido', responseApi.message ?? "");
        }
      });
      */
      //Response response = await usersProvider.create(user);

    }

  }



  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          "Galeria",
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          "Camara",
          style: TextStyle(
              color: Colors.black
          ),
        )
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Selecciona una opcion"),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }

  bool isValidForm(
        String name,
        String lastName,
        String phone
      ) {


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
    return true;
  }
}