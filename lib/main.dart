import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:una_agendamento/app/routes/app_pages.dart';
import 'package:una_agendamento/Conexao_bd/conexao.bd.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    );
  }
}
