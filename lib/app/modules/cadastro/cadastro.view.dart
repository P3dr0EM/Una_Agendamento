import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/cadastro_button.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/name_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/ra_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/email_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/password_field.dart';
import 'package:una_agendamento/app/modules/cadastro/widgets/password_confirm_field.dart';

//construção da tela de Login Inicial
class CadastroView extends GetView<CadastroController> {
  const CadastroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra do Top da tela
      appBar: AppBar(backgroundColor: const Color(0xFF5B1C8D)),
      resizeToAvoidBottomInset: true,
      //Construção da página
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30), //espaçamento da barra do top
              Center(
                //Construção da Imagem da Logo
                child: Image.asset(
                  "assets/images/una.login.png",
                  width: double.infinity,
                  height: 150,
                ),
              ),
              SizedBox(height: 100), //espaçamento da Logo
              NameField(), //Chamada do campo de nome
              SizedBox(height: 5), //espaçamento
              EmailField(), //Chamada do campo de e-mail
              SizedBox(height: 5), //espaçamento
              RaField(), //Chamada do campo de RA
              SizedBox(height: 5), //espaçamento
              PasswordField(), //Chamada do campo de senha
              SizedBox(height: 5), //espaçamento
              PasswordConfirmField(), //Chamada do campo de confirmação de senha
              SizedBox(height: 10), //espaçamento
              SizedBox(height: 20), //espaçamento
              CadastroButton(), //Chamada do botão de Login
              SizedBox(height: 30), //espaçamento
            ],
          ),
        ),
      ),
    );
  }
}
