import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegreengrocer/src/auth/controller/auth_controller.dart';
import 'package:thegreengrocer/src/auth/pages_routes/app_pages_routes.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  //injecao de dependencia
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Greengrocer',
      theme: ThemeData(
   primarySwatch: Colors.green,
       scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      initialRoute: PagesRoutes.splashRoute, //rota inicial
      getPages: AppPage.pages, //minhas rotas
    );
  }
}

