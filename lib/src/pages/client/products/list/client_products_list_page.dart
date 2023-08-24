import 'dart:io';

import 'package:delivery_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:delivery_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:delivery_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_app/src/pages/register/register_page.dart';
import 'package:delivery_app/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_app/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController controller = Get.put(ClientProductsListController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: SafeArea(child: _bottomBar()),
      body: Obx( () => IndexedStack(
          index: controller.indexTab.value,
          children: [
            RestaurantOrdersListPage(),
            DeliveryOrdersListPage(),
            ClientProfileInfoPage()
          ],
        ),
      )
    );
  }

  Widget _bottomBar() {
    return Obx( () => CustomAnimatedBottomBar(
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Mis pedidos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black

          )
        ],
        containerHeight: 60,
        backgroundColor: Colors.amber,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => controller.changeTab(index),
        selectedIndex: controller.indexTab.value,
      ),
    );
  }
}

