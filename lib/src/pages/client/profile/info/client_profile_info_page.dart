import 'package:delivery_app/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ClientProfileInfoPage extends StatelessWidget {

  ClientProfileInfoController controller = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Stack(
            children: [
              _backgroundCover(context),
              _boxForm(context),
              _imageUser(context),
              _buttonSignOut()
            ],
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
            _textName(),
            _textEmail(),
            _textPhone(),
            _buttonUpdate(context),
          ],
        ),
      ),
    );
  }

  Widget _buttonSignOut() {
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10, right: 20),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => controller.signOut(),
            icon: Icon(Icons.power_settings_new),
            color: Colors.white,
            iconSize: 30,
          ),
        )
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
          onPressed: () => controller.goToProfileUpdate(),
          child: Text(
            'Actualizar datos',
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
        child: CircleAvatar(
          backgroundImage: controller.user.value.image != null
              ? NetworkImage(controller.user.value.image!)
              : AssetImage('assets/img/user_profile.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _textName() {
    return ListTile(
      leading: Icon(Icons.person),
      subtitle: Text(
        'Nombre de usuario',
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Colors.black
        ),
      ),
      title: Text(
        '${controller.user.value.name ?? ''} ${controller.user.value.lastname ?? ''}',
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }
  Widget _textEmail() {
    return ListTile(
      leading: Icon(Icons.email),
      subtitle: Text(
        'Email',
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Colors.black
        ),
      ),
      title: Text(
        '${controller.user.value.email ?? ''}',
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }
  Widget _textPhone() {
    return ListTile(
      leading: Icon(Icons.phone),
      subtitle: Text(
        'Teléfono',
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Colors.black
        ),
      ),
      title: Text(
        '${controller.user.value.phone ?? ''}',
        overflow: TextOverflow.fade,
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }
}
