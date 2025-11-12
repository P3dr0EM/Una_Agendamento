import 'package:flutter/material.dart';
import 'package:una_agendamento/constants.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Esqueceu a senha? Clique aqui!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: corRoxaPrincipal,
                    decoration: TextDecoration.underline,
                  ),
                ),
              );
  }
}