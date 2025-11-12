import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';

class CadastroButtom extends StatelessWidget {
  const CadastroButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centraliza a linha
      children: [
        Text(
          "Não possui uma conta?",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 4), // Pequeno espaço
        
        // O texto clicável
        GestureDetector(
          onTap: () {
            // Ação de navegação
            Get.toNamed(Routes.CADASTRO);
          },
          child: const Text(
            "Cadastre-se",
            style: TextStyle(
              color: Color(0xFF5D0890), // Cor roxa principal do app
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline, // Sublinhado para indicar link
            ),
          ),
        ),
      ],
    );
  }
}