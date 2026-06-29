import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/bottomnav_controller.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_furiniture_app_mvc/firebase_options.dart';
import 'package:new_furiniture_app_mvc/models/shipping_model.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:new_furiniture_app_mvc/controllers/auth_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/check_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/favourite_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/home_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/login_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/notification_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/payment_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/profile_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/signup_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/snackbar_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/switch_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/theme_provider.dart';
import 'package:new_furiniture_app_mvc/views/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  await Hive.initFlutter();
  Hive.registerAdapter(ShippingModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ShippingModel>('Shipping_box');
  await Hive.openBox<ProductModel>('Products_box');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ShippingProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => SnackProvider()),
        ChangeNotifierProvider(create: (_) => SwitchProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Furniture App',
          themeMode: themeProvider.isLightMode
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const AuthWrapper(),
        );
      },
    );
  }
}
