import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';

// Botão de login com Google mostrando estado de carregamento via GetX

class LogarGoogle extends GetView<LoginController> {
  const LogarGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        final loading = controller.isLoading.value;
        return ElevatedButton.icon(
          onPressed: loading ? null : controller.tryToGoogleLogin,
          icon: loading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Image.asset(
                  "assets/icons/g_icon_google.png",
                  width: 20.0,
                  height: 20.0,
                ),
          label: Text(loading ? 'Entrando...' : 'Logar com Google'),
        );
      }),
    );
  }
}
