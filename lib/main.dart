import 'package:delivery_app/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Delivery App",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage())
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
            primary: Colors.amber,
            secondary: Colors.amberAccent,
            brightness: Brightness.light,
            onBackground: Colors.grey,
            onPrimary: Colors.grey,
            onSecondary: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
            background: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey,
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
