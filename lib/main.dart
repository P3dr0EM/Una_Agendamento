import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:una_agendamento/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

//Construção do Main
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
// gustavo do grau 