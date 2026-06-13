import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/firebase_options.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:new_furiniture_app_mvc/views/auth/auth_wrapper.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_furiniture_app_mvc/models/shipping_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(ShippingModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.openBox<ShippingModel>('Shipping_box');
  Hive.openBox<ProductModel>('Product_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColorLight: Colors.white),
      home: AuthWrapper(),
    );
  }
}
