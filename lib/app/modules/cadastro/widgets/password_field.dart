import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importe Getx para GetView
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

class PasswordField extends GetView<CadastroController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Obx(
        () => TextFormField(
          // Usando TextFormField, que é ideal para validação
          controller: controller.senhaInput,
          obscureText: true,
          keyboardType: TextInputType.text,
          focusNode: controller.senhaFocus,

          // Ação para o último campo deve ser 'done' (Concluído)
          textInputAction: TextInputAction.next,

          onFieldSubmitted: (_) {
            controller.senhaFocus.unfocus();
            FocusScope.of(context).requestFocus(controller.dddFocus);
          },
          decoration: InputDecoration(
            label: const Text("SENHA"),
            errorText: controller.errorSenha.value,
            counterText: '', // Remove o contador de caracteres
          ),
        ),
      ),
    );
  }
}
