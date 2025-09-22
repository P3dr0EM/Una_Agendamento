import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/login/login_controller.dart';

class EmailField extends GetView<LoginController> {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsetsGeometry.only(left: 8, right: 8),
                child: Obx(() => TextField(
                  controller: controller.emailInput,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(label: const Text("EMAIL"),
                  errorText: controller.errorEmail.value,                  
                  ),
                ))
              );
  }
}