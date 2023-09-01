import 'package:delivery_app/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreatePage extends StatelessWidget {

  RestaurantCategoriesCreateController controller = Get.put(RestaurantCategoriesCreateController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _textNewCategory(context),
          ],
        )
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery
          .of(context)
          .size
          .height * .35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * .30,
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
            _textFieldDescription(),
            _buttonCreate(context)
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
            prefixIcon: Icon(Icons.category)
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 30
      ),
      child: TextField(
        controller: controller.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: 'Descripción',
            prefixIcon: Container(
              margin: EdgeInsets.only(
                bottom: 60
              ),
              child: Icon(Icons.description)
            )
        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
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
          onPressed: () => controller.createCategory(),
          child: Text(
            'Actualizar',
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
    );
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 25),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Icon(
                Icons.category,
                size: MediaQuery.of(context).size.height * .16,
              ),
              Text(
                  "Nueva Categoria",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * .08,
                ),
              ),
            ],
          )
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