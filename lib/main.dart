// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:una_agendamento/app/routes/app_pages.dart';
import 'package:una_agendamento/conexao_bd/conexao.bd.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDateFormatting();
  await Firebase.initializeApp();
  // 🔹 Conectar ao banco antes de rodar o app
  final conn = await connectToDatabase();
  if (conn == null) {
    print("❌ Erro ao conectar ao banco de dados!");
  } else {
    print("✅ Banco conectado com sucesso!");
  }

  runApp(const MyApp());
}

// Construção do Main
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

      // 4. Adicione as configurações de localização ao GetMaterialApp
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'), // Adiciona o suporte para Português do Brasil
      ],
      locale: const Locale('pt', 'BR'), // Define como o locale padrão
    );
  }
}
