// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:una_agendamento/constants.dart';

class ServiceBlockWidget extends StatelessWidget {
  final String assetPath;
  final String text;
  final VoidCallback onTap;
  
  // Você pode mudar a cor aqui ou recebê-la como parâmetro
  final Color corFundo = corRoxaSecundaria;

  const ServiceBlockWidget({
    super.key,
    required this.assetPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Widget para dar o efeito de clique (ripple)
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: corFundo,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [ // Sombra sutil (opcional)
            BoxShadow(
              color: corFundo.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o ícone e o texto
          children: [
            // 1. A IMAGEM (ÍCONE)
            Expanded(
              child: Image.asset(
                assetPath,
                color: corRoxaPrincipal,
                fit: BoxFit.contain, 
              ),
            ),
            const SizedBox(height: 8), // Espaço entre ícone e texto
            
            // 2. O TEXTO EM NEGRITO
            Text(
              text,
              textAlign: TextAlign.center, // Garante centralização se o texto quebrar
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2, // Evita que o texto fique muito grande
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}