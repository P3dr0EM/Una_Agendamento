// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Certifique-se de que todos esses imports apontam para os arquivos corretos
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/cadastro_button.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/name_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/email_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/password_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/ddd_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/telefone_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/cpf_field.dart';

class CadastroView extends GetView<CadastroController> {
  const CadastroView({super.key});

  static const Color primaryPurple = Color(
    0xFF780BBA,
  ); // Roxo principal do fundo/logo
  static const Color buttonPurple = Color.fromARGB(
    255,
    87,
    35,
    137,
  ); // Roxo do botão
  static const Color fieldBorderColor = Colors.grey; // Cor da borda dos campos
  static const Color fieldLabelColor =
      Colors.black87; // Cor dos rótulos dos campos (NOME, CPF)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryPurple,
      body: SafeArea(
        // Envolvemos a Column em um SingleChildScrollView para evitar overflow
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  "assets/images/una.login.png", // Seu logo
                  width: double.infinity,
                  height: 150, // Altura do logo
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 15),
              Center(
                // O Padding define a margem externa do cartão
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    // Limita a largura máxima do cartão
                    constraints: const BoxConstraints(maxWidth: 450),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      // Arredonda TODOS os 4 cantos
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    // Padding vertical reduzido (diminui a altura do cartão)
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),

                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Ocupa só o espaço do conteúdo
                      // Alinhamento à esquerda para os campos
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TÍTULO CENTRALIZADO
                        const Center(
                          child: Text(
                            "Cadastro",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: primaryPurple,
                            ),
                          ),
                        ),

                        // Espaçamento reduzido após o título
                        const SizedBox(height: 20),

                        // Campos do Formulário
                        const NameField(),
                        // Espaçamento reduzido entre campos
                        const SizedBox(height: 15),

                        const CpfField(),
                        const SizedBox(height: 15),

                        const EmailField(),
                        const SizedBox(height: 15),

                        const PasswordField(),
                        const SizedBox(height: 15),

                        // DDD e Telefone lado a lado
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(width: 80, child: const DddField()),
                            const SizedBox(width: 10),
                            const Expanded(child: TelefoneField()),
                          ],
                        ),

                        // Espaçamento antes do botão
                        const SizedBox(height: 25),
                        const CadastroButton(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              // Espaçamento extra no final para scrollar bem
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
