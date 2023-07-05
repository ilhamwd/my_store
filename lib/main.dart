import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_store/bindings/product_binding.dart';
import 'package:my_store/routes.dart';
import 'package:my_store/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));

    return GetMaterialApp(
        title: 'Store',
        debugShowCheckedModeBanner: false,
        initialBinding: ProductBinding(),
        getPages: getRoutes,
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 400),
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF4A8CEF)),
            // useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15)))),
        home: const Home());
  }
}
