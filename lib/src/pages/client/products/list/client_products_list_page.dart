import 'dart:io';

import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:delivery_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:delivery_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_app/src/pages/register/register_page.dart';
import 'package:delivery_app/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_app/src/utils/custom_animated_bottom_bar.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController controller = Get.put(ClientProductsListController());
  @override
  Widget build(BuildContext context) {

    return Obx(
      () => DefaultTabController(
        length: controller.categories.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              flexibleSpace: SafeArea(
                child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _textFieldSearch(context),
                    _iconshoppingBag()
                  ],
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.amber,
                unselectedLabelColor: Colors.white70,
                tabs: List<Widget>.generate(controller.categories.length, (index) {
                  return Tab(
                    child: Text(controller.categories[index].name ?? ''),
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
              children: controller.categories.map((Category category) {
                return FutureBuilder(
                  future: controller.getProducts(category.id ?? '1'),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data!.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardProduct(context, snapshot.data![index]);
                            }
                        );
                      }
                      return NoDataWidget(text: 'No hay productos en esta categoria');
                    }
                    else {
                      return NoDataWidget(text: 'No hay productos en esta categoria');
                    }
                  }
                );
          }).toList()
          )
        ),
      ),
    );
  }

  Widget _iconshoppingBag() {
    return Container(
      padding: EdgeInsets.all(8),
      child: IconButton(
        padding: EdgeInsets.all(12),
          onPressed: () => controller.goToOrderCreate(),
          icon: Icon(
              Icons.shopping_bag_outlined,
          )
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .80,
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: 8
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar producto...',
          suffixIcon: Icon(Icons.search, color: Colors.black38,),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.black45
          ),
          filled: true,
          fillColor: Colors.amberAccent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.amber
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.black54
            )
          ),
          contentPadding: EdgeInsets.all(15)
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => controller.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15
            ),
            child: ListTile(
              title: Text(product.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${product.price?.toStringAsFixed(2)}\$" ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              trailing: Container(
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    image: product.image1 != null
                        ? NetworkImage(product.image1!)
                        : AssetImage('asset/img/no-image.png') as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 2,
            color: Colors.grey,
            indent: 75,
            endIndent: 75,
          )
        ],
      ),
    );
  }
}

