// ignore_for_file: avoid_print

import 'package:mysql1/mysql1.dart';

/// Função para conectar ao banco e retornar a conexão
Future<MySqlConnection?> connectToDatabase() async {
  try {
    final settings = ConnectionSettings(
      host: '192.168.100.98', // ou IP da máquina com MySQL
      port: 3306, // porta padrão do MySQL
      user: 'root', // usuário do banco
      password: 'Cookies@1234', // senha do banco
      db: 'una_agendamento', // nome do banco
    );

    final conn = await MySqlConnection.connect(settings);
    print('✅ Conectado ao banco com sucesso!');
    return conn;
  } catch (e) {
    print('❌ Erro ao conectar ao banco: $e');
    return null;
  }
}

/// Função para validar login de usuário no banco
Future<bool> validarLogin(String email, String senha) async {
  MySqlConnection? conn;
  try {
    // Usa a função de conexão
    conn = await connectToDatabase();
    if (conn == null) return false;

    // Consulta de login
    Results results = await conn.query(
      'SELECT * FROM usuarios WHERE email = ? AND senha = ?',
      [email, senha],
    );

    // Retorna true se encontrar usuário
    return results.isNotEmpty;
  } catch (e) {
    print("❌ Erro no login: $e");
    return false;
  } finally {
    // Fecha a conexão se estiver aberta
    await conn?.close();
  }
}
