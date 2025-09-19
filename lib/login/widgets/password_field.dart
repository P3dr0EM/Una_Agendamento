import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/login/login_controller.dart';

class PasswordField extends GetView<LoginController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsetsGeometry.only(left: 8, right: 8),
                child: TextFormField(
                  controller: controller.senhaInput,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(label: Text("SENHA")),
                ),
              );
  }
}