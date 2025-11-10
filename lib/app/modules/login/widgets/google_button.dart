import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';

class LogarGoogle extends GetView<LoginController> {
  const LogarGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: controller.logar,
      icon: Image.asset(
        "assets/icons/g_icon_google.png",
        width:  20.0,
        height: 20.0,
      ),
      label: Text('Logar com Google'));
  }
}