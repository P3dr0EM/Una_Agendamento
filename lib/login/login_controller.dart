import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:una_agendamento/home/home.view.dart';

class LoginController extends GetxController{
    TextEditingController emailInput = TextEditingController();
    TextEditingController senhaInput = TextEditingController();

    //bebug realizado no bando de dados
    static const email = "admin@admin.com";
    static const senha = "admin";

    void logar(){
      switch (emailInput.text) {
        case email:
          checkPassword();
          break;
        case '':
          printError('Insira um email.');
          break;
        default:
          printError('Email Inválido!');
      }
    }

    void checkPassword(){
      switch (senhaInput.text) {
        case senha:
          login();
          break;
        case '':
          printError('Insira sua senha!');
        default:
          printError('Senha Incorreta!');
      }
    }


    void printError(String error){
      // ignore: avoid_print
      print(error);
    }

    void login(){
      Get.to(HomeView());
    }
}