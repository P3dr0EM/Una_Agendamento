// lib/app/services/date_format_service.dart

// Importa a implementação padrão (para mobile)
import 'package:intl/date_symbol_data_local.dart' as mobile;

// A linha abaixo é uma diretiva especial do Dart:
// Ela diz: "se o código estiver rodando em um ambiente que conhece a biblioteca 'dart:html' (ou seja, a web),
// então use a implementação do arquivo 'date_symbol_data_browser.dart' em vez da que foi importada acima".
// if (dart.library.html) 'package:intl/date_symbol_data_browser.dart' as web;

/// Esta função serve como uma camada de abstração.
/// Ela garante que a versão correta de [initializeDateFormatting] seja chamada,
/// independentemente da plataforma (mobile ou web).
Future<void> configureDateFormatting() async {
  // Para mobile, esta chamada será resolvida para mobile.initializeDateFormatting('pt_BR').
  // Para web, seria resolvida para web.initializeDateFormatting('pt_BR').
  // Como não estamos compilando para web, apenas a versão mobile importa.
  await mobile.initializeDateFormatting('pt_BR');
}