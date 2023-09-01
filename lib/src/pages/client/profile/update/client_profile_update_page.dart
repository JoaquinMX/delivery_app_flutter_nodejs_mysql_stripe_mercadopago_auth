import 'package:delivery_app/src/pages/client/profile/update/client_profile_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProfileUpdatePage extends StatelessWidget {
  ClientProfileUpdateController controller = Get.put(ClientProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _imageUser(context),
            _buttonBack()
          ],
        )
    );
  }

  Widget _buttonBack() {
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            iconSize: 30,
          ),
        )
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .30,
          left: 50,
          right: 50
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 30
      ),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre',
            prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 30
      ),
      child: TextField(
        controller: controller.lastNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Apellido',
            prefixIcon: Icon(Icons.person_outline)
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 30
      ),
      child: TextField(
        controller: controller.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Teléfono',
            prefixIcon: Icon(Icons.phone)
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 30,
          bottom: 15
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          onPressed: () => controller.updateInfo(context),
          child: Text(
            'Actualizar',
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: GestureDetector(
            onTap: () {controller.showAlertDialog(context);},
            child: GetBuilder<ClientProfileUpdateController>(
              builder: (value) => CircleAvatar(
                backgroundImage: controller.imageFile != null
                    ? FileImage(controller.imageFile!)
                    : controller.user.image != null
                      ? NetworkImage(controller.user.image!)
                      : AssetImage('assets/img/user_profile.png') as ImageProvider,

                radius: 60,
                backgroundColor: Colors.white,
              ),
            )
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(
          top: 40,
          bottom: 30
      ),
      child: Text(
        'Ingresa esta información',
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }
}
