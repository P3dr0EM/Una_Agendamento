import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
                child: Text(
                  "Esqueceu a senha? Clique aqui!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 32, 106),
                    decoration: TextDecoration.underline,
                  ),
                ),
              );
  }
}