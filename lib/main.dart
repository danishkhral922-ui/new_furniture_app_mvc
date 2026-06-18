import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/firebase_options.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:new_furiniture_app_mvc/views/auth/auth_wrapper.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_furiniture_app_mvc/models/shipping_model.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/controllers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(ShippingModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ShippingModel>('Shipping_box');
  await Hive.openBox<ProductModel>('Products_box');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppthemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppthemeProvider>(
      builder: (context, themeProvider, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
            ),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[900],
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
            ),
          ),

          themeMode: themeProvider.islightMode
              ? ThemeMode.light
              : ThemeMode.dark,

          home: AuthWrapper(),
        );
      },
    );
  }
}
