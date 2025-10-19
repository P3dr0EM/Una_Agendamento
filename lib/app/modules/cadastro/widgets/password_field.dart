import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

class PasswordField extends GetView<CadastroController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Obx(
        () => TextFormField(
          controller: controller.senhaInput, //chama o controlador de texto
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            label: const Text("SENHA"),
            errorText: controller.errorSenha.value,
          ), //chama o controlador de erro
        ),
      ),
    );
  }
}
