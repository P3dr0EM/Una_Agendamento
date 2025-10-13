// lib/app/modules/login/widgets/google_button_widget.dart

import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Image.asset(
          'assets/icons/Google_Favicon_2025.svg', // Caminho para o seu asset
          height: 24.0,
          width: 24.0,
        ),
        label: const Text(
          'Entrar com o Google',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Fundo branco
          foregroundColor: Colors.black, // Cor do "ripple effect"
          elevation: 1, // Sombra sutil
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.grey.shade300), // Borda cinza clara
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
      ),
    );
  }
}