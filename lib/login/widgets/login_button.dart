// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/login/login_controller.dart';

//Contrução de Widget do Botão de Login
class LoginButton extends GetView<LoginController> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                child: ElevatedButton(
                  onPressed: (){
                    controller.logar(); //chama a função de logar da classe LoginController
                    bool email = controller.validateEmail();
                    bool senha = controller.validatePassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 206, 1, 38),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: Text("Logar"),
                ),
              );
  }
}