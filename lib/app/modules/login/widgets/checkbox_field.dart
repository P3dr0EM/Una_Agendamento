import 'package:flutter/material.dart';
import 'package:una_agendamento/constants.dart';

// Classe principal que define o StatefulWidget
class CheckboxField extends StatefulWidget {
  const CheckboxField({super.key});

  @override
  State<CheckboxField> createState() => _TitledCheckboxField();
}

// A classe de Estado
class _TitledCheckboxField extends State<CheckboxField> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsetsGeometry.only(left: 8, right: 8),
      child: CheckboxListTile(
        // O texto que serve como rótulo principal
        title: const Text('Lembrar de mim'),
        // O valor booleano que determina se está marcado
        value: rememberMe,
        // Função chamada quando o valor muda
        onChanged: (bool? value) {
          setState(() {
            rememberMe = value!;
          });
        },
        // Coloca o checkbox à esquerda do texto (padrão é à direita)
        controlAffinity: ListTileControlAffinity.leading,
        // Define a cor do checkbox quando marcado
        activeColor: verde,
      ),
    );
  }
}