// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';

class ConfirmationButtonWidget extends StatelessWidget {
  const ConfirmationButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgendamentoController>();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Obx(() => ElevatedButton(
            onPressed: controller.isConfirmationButtonEnabled
                ? controller.confirmarAgendamento
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5D0890),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(controller.confirmationText),
          )),
    );
  }
}