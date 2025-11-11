import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

//Contrução de Widget do Botão de Login
class CadastroButton extends GetView<CadastroController> {
  const CadastroButton({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Envolva seu botão com um 'Obx'
    // Ele vai "escutar" a variável 'isLoanding'
    return Obx(() {
      return Center(
        child: ElevatedButton(
          // 2. Lógica do 'onPressed'
          // Se 'isLoading' for verdadeiro, o onPressed fica 'null' (desabilitado)
          // Se for falso, ele permite chamar o controller.
          onPressed: controller.isLoading.value
              ? null
              : () {
                  // 3. Chame o método principal
                  // Este método JÁ FAZ a validação e JÁ MOSTRA os Snackbars.
                  controller.cadastrarUsuario();
                },

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5B1C8D),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),

          // 4. Lógica do 'child' (o que aparece dentro do botão)
          // Se 'isLoading' for verdadeiro, mostra um 'loading'
          // Se for falso, mostra o texto "Cadastrar"
          child: controller.isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text("Cadastrar"),
        ),
      );
    });
  }
}
