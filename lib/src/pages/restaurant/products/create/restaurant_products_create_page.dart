import 'dart:io';

import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsCreatePage extends StatelessWidget {
  RestaurantProductsCreateController controller =
      Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _textNewCategory(context),
      ],
    ));
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
          top: MediaQuery.of(context).size.height * .28, left: 45, right: 45),
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
      ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldDescription(),
            _textFieldPrice(),
            Obx(() => _dropDownCategories(controller.categories)),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GetBuilder<RestaurantProductsCreateController>(
                      builder: (value) =>
                          _cardImage(context, controller.imageFile1, 1)),
                  GetBuilder<RestaurantProductsCreateController>(
                      builder: (value) =>
                          _cardImage(context, controller.imageFile2, 2)),
                  GetBuilder<RestaurantProductsCreateController>(
                      builder: (value) =>
                          _cardImage(context, controller.imageFile3, 3))
                ],
              ),
            ),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre', prefixIcon: Icon(Icons.category)),
      ),
    );
  }

  Widget _textFieldPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Precio', prefixIcon: Icon(Icons.attach_money)),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
            hintText: 'Descripción',
            prefixIcon: Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Icon(Icons.description))),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          onPressed: () => controller.createProduct(context),
          child: Text(
            'Crear Producto',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
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
                Icons.restaurant_menu,
                size: MediaQuery.of(context).size.height * .14,
              ),
              Text(
                "Crear Producto",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * .08,
                ),
              ),
            ],
          )),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        'Ingresa esta información',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  List<DropdownMenuItem<String?>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name ?? ''),
        value: category.id,
      ));
    });

    return list;
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar categoria',
        ),
        items: _dropDownItems(categories),
        value: controller.idCategory.value == ''
            ? null
            : controller.idCategory.value,
        onChanged: (option) {
          print(option);
          controller.idCategory.value = option.toString();
        },
      ),
    );
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
        onTap: () => controller.showAlertDialog(context, numberFile),
        child: Card(
          margin: EdgeInsets.only(left: 5, right: 5),
          elevation: 3,
          child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width * .2,
              child: imageFile != null
                  ? Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: AssetImage('assets/img/cover_image.png')
                          as ImageProvider)),
        ));
  }
}
