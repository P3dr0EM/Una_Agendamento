import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/login/login_controller.dart';
import 'package:una_agendamento/login/widgets/checkbox_field.dart';
import 'package:una_agendamento/login/widgets/email_field.dart';
import 'package:una_agendamento/login/widgets/forget_password.dart';
import 'package:una_agendamento/login/widgets/login_button.dart';
import 'package:una_agendamento/login/widgets/password_field.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 206, 1, 38),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  "assets/images/una.login.png",
                  width: double.infinity,
                  height: 150,
                ),
              ),
              SizedBox(height: 100),
              EmailField(),
              SizedBox(height: 30),
              PasswordField(),
              SizedBox(height: 10),
              CheckboxField(),
              SizedBox(height: 20),
              LoginButton(),
              SizedBox(height: 30),
              ForgetPassword()
            ],
          ),
        ),
      ),
    );
  }
}
