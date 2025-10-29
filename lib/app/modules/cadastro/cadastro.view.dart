import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 160, 61, 241)),
      resizeToAvoidBottomInset: true,
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 30), // Espaçamento da barra do topo
              Center(
                child: Image.asset(
                  "assets/images/una.login.png",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 100), // Espaçamento da logo
              const NameField(), // Campo de nome
              const SizedBox(height: 5),
              const CpfField(), // Campo de CPF
              const SizedBox(height: 5),
              const EmailField(), // Campo de e-mail
              const SizedBox(height: 5),
              const PasswordField(), // Campo de senha
              const SizedBox(height: 10),

              // 🔹 DDD e Telefone lado a lado
              Row(
                children: [
                  SizedBox(
                    width: 50, // largura fixa para o DDD
                    child: const DddField(),
                  ),
                  const SizedBox(width: 0),
                  Expanded(
                    child: const TelefoneField(), // Campo do número de telefone
                  ),
                ],
              ),

              const SizedBox(height: 50),
              const CadastroButton(), // Botão de cadastro
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
