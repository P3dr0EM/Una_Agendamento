import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';
import 'package:una_agendamento/app/modules/login/widgets/checkbox_field.dart';
import 'package:una_agendamento/app/modules/login/widgets/email_field.dart';
import 'package:una_agendamento/app/modules/login/widgets/forget_password.dart';
import 'package:una_agendamento/app/modules/login/widgets/google_button.dart';
import 'package:una_agendamento/app/modules/login/widgets/login_button.dart';
import 'package:una_agendamento/app/modules/login/widgets/password_field.dart';

//construção da tela de Login Inicial
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra do Top da tela
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 206, 1, 38),
      ),
      resizeToAvoidBottomInset: true,
      //Construção da página
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30), //espaçamento da barra do top
              Center( //Construção da Imagem da Logo
                child: Image.asset(
                  "assets/images/una.login.png",
                  width: double.infinity,
                  height: 150,
                ),
              ),
              SizedBox(height: 100), //espaçamento da Logo
              EmailField(), //Chamada do campo de e-mail
              SizedBox(height: 30), //espaçamento
              PasswordField(), //Chamada do campo de senha
              SizedBox(height: 10), //espaçamento
              CheckboxField(), //Chamada do campo Lembrar de Mim
              SizedBox(height: 20), //espaçamento
              LoginButton(),  //Chamada do botão de Login
              SizedBox(height: 30),
              LogarGoogle(),
              SizedBox(height: 10), //espaçamento
              ForgetPassword(),
              
            ],
          ),
        ),
      ),
    );
  }
}
