import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:una_agendamento/login/login.view.dart';
import 'package:una_agendamento/login/login_bidings.dart';

void main() {
  runApp(const MyApp());
}

//Construção do Main
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: LoginBidings(),
      debugShowCheckedModeBanner: false,
      home: const LoginView(), //chamada da View principal da tela de Login
    );
  }
}
// gustavo do grau 