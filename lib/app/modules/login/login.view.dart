import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';
import 'package:una_agendamento/app/modules/login/widgets/cadastrobuttom_widget.dart';
import 'package:una_agendamento/app/modules/login/widgets/checkbox_field.dart';
import 'package:una_agendamento/app/modules/login/widgets/email_field.dart';
import 'package:una_agendamento/app/modules/login/widgets/forget_password.dart';
import 'package:una_agendamento/app/modules/login/widgets/google_button.dart';
import 'package:una_agendamento/app/modules/login/widgets/login_button.dart';
import 'package:una_agendamento/app/modules/login/widgets/password_field.dart';
import 'package:una_agendamento/constants.dart';

//construção da tela de Login Inicial
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  static const Color fieldBorderColor = Colors.grey; // Cor da borda dos campos
  static const Color fieldLabelColor =
      Colors.black87; // Cor dos rótulos dos campos (NOME, CPF)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corRoxaPrincipal,
      body: SafeArea(
        // Envolvemos a Column em um SingleChildScrollView para evitar overflow
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/unaLogo.png", // Seu logo
                  width: double.infinity,
                  height: 300, // Altura do logo
                  fit: BoxFit.cover,
                ),
              ),
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
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    // Padding vertical reduzido (diminui a altura do cartão)
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 30,
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
                            "Bem-Vindo!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: corRoxaPrincipal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const EmailField(),
                        const SizedBox(height: 15),
                        const PasswordField(),
                        const SizedBox(height: 15),
                        const ForgetPassword(),
                        const CheckboxField(),
                        const SizedBox(height: 10),
                        LogarGoogle(),
                        const SizedBox(height: 10),
                        SizedBox(height: 10,),
                        const LoginButton(),
                        SizedBox(height: 10,),
                        CadastroButtom()
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
