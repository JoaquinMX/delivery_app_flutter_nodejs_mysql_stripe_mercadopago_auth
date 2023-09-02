import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

class ClientProductDetailPage extends StatelessWidget {

  Product product;
  ClientProductsDetailController controller = Get.put(ClientProductsDetailController());

  ClientProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _imageSlideshow(context),
          _textNameProduct(),
          _textPriceProduct(),
          _textDescriptionProduct(),
        ],
      ),
      bottomNavigationBar: Container(
          height: 100,
          child: _buttonsAddToBag()
      ),

    );
  }

  Widget _imageSlideshow(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: <Widget>[
            ImageSlideshow(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .35,
                initialPage: 0,
                indicatorColor: Colors.amber,
                indicatorBackgroundColor: Colors.grey,
                children: [
                  FadeInImage(
                    fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product.image1 != null
                      ? NetworkImage(product.image1!)
                      : AssetImage('assets/img/no-image.png') as ImageProvider,
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product.image2 != null
                      ? NetworkImage(product.image2!)
                      : AssetImage('assets/img/no-image.png') as ImageProvider,
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product.image3 != null
                      ? NetworkImage(product.image3!)
                      : AssetImage('assets/img/no-image.png') as ImageProvider,
                  )
                ]
            )
          ],
        )
    );
  }

  Widget _textNameProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20
      ),
      child: Text(
        product.name ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textDescriptionProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20
      ),
      child: Text(
        product.description ?? '',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _textPriceProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        left: 20,
        right: 20
      ),
      child: Text(
        "${product.price?.toStringAsFixed(2)}\$" ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buttonsAddToBag() {
    return Column(
      children: [
        Divider(height: 2, color: Colors.grey),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {},
                child: Text(
                    " -",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,

                  ),
                ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(38, 37),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25)
                  )
                )
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                    "0",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,

                  ),
                ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(40, 37)
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "+ ",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,

                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(38, 37),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25)
                      )
                  )
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Agregar ${product.price?.toStringAsFixed(2)}\$" ?? '',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,

                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  )
              ),
            ),
          ],
        ),
      ],
    );
  }
}
