// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:una_agendamento/app/routes/app_pages.dart';
import 'package:una_agendamento/app/services/data_format_service.dart';
import 'package:una_agendamento/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDateFormatting();
  // Logs para depuração do Firebase: mostra apps registrados e resultado
  print(
    'Firebase apps before init: ${Firebase.apps.map((a) => a.name).toList()}',
  );
  // Evita inicializar o Firebase mais de uma vez (causa: hot-reload/restart
  // ou inicialização duplicada em outros pontos do código).
  if (Firebase.apps.isEmpty) {
    print('Firebase not initialized yet — iniciando Firebase...');
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print(
        'Firebase inicializado com sucesso. Apps: ${Firebase.apps.map((a) => a.name).toList()}',
      );
    } catch (e, s) {
      // Tratar especificamente o caso de app duplicado (algumas integrações
      // ou hot-restart podem provocar esse erro). Não abortamos a execução,
      // apenas logamos e seguimos — assume-se que o Firebase já está pronto.
      if (e is FirebaseException && e.code == 'core/duplicate-app') {
        print('Ignore: Firebase app já existe (duplicate-app). Prosseguindo.');
      } else {
        print('Erro ao inicializar o Firebase: $e');
        print(s);
      }
    }
  } else {
    print(
      'Firebase já estava inicializado. Apps: ${Firebase.apps.map((a) => a.name).toList()}',
    );
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
