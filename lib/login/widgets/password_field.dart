import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/login/login_controller.dart';

class PasswordField extends GetView<LoginController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsetsGeometry.only(left: 8, right: 8),
                child: Obx(()=> TextFormField(
                  controller: controller.senhaInput,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(label: const Text("SENHA"),
                  errorText: controller.errorPassword.value),
                  
                ),)
              );
  }
}