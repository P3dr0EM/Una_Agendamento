// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

//Contrução de Widget do Botão de Login
class CadastroButton extends GetView<CadastroController> {
  const CadastroButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (controller.validateCampos()) {
            // Se passou em todas as validações
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cadastro realizado com sucesso!')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B1C8D),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        ),
        child: const Text("Cadastrar"),
      ),
    );
  }
}
