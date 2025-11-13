import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Enum para os status do dia
enum DayStatus { available, full, closed, past }

class AgendamentoController extends GetxController {
  // --- ESTADO DO SERVIÇO ---
  final serviceName = 'Serviço'.obs;

  // --- ESTADO DO CALENDÁRIO ---
  final focusedDay = DateTime.now().obs;
  final selectedDay = Rxn<DateTime>(); // Dia selecionado (pode ser nulo)

  // --- ESTADO DOS HORÁRIOS ---
  final availableTimes = <String>[].obs; // Lista de horários disponíveis
  final selectedTime = Rxn<String>(); // Horário selecionado (pode ser nulo)

  // --- DADOS MOCKADOS (Simulação de um banco de dados) ---
  // Simula dias que não funcionam (ex: Domingo)
  final List<int> diasFechados = [DateTime.sunday];
  // Simula dias que estão lotados (ex: dia 25 do mês)
  final List<int> diasLotados = [25];

  // --- COMPUTED (Getters Reativos) ---

  /// Texto reativo para o botão de confirmação
  String get confirmationText {
    if (selectedDay.value == null) {
      return 'Selecione um dia';
    }
    if (selectedTime.value == null) {
      return 'Selecione um horário';
    }
    // Formata a data (ex: 15/11)
    final String diaFormatado = DateFormat('dd/MM').format(selectedDay.value!);
    return 'Confirmar: $diaFormatado às ${selectedTime.value!}';
  }

  /// Verifica se o botão de confirmar deve estar ativo
  bool get isConfirmationButtonEnabled {
    return selectedDay.value != null && selectedTime.value != null;
  }

  @override
  void onInit() {
    super.onInit();
    // Pega o nome do serviço da URL (ex: "dentista")
    String servicoKey = Get.parameters['servico'] ?? 'servico';
    // Converte para "Dentista" (primeira letra maiúscula)
    serviceName.value = servicoKey.capitalizeFirst ?? 'Serviço';
  }

  /// Função chamada pelo TableCalendar ao selecionar um dia
  void onDaySelected(DateTime day, DateTime focused) {
    // Não permite selecionar dias passados
    if (getDayStatus(day) == DayStatus.past) {
      return;
    }

    focusedDay.value = focused;
    // Se clicar no mesmo dia, limpa a seleção
    if (isSameDay(selectedDay.value, day)) {
      selectedDay.value = null;
      selectedTime.value = null;
      availableTimes.clear();
    } else {
      selectedDay.value = day;
      selectedTime.value = null;
      // Carrega os horários para o dia selecionado
      _loadAvailableTimes(day);
    }
  }

  /// Função chamada ao clicar em um botão de horário
  void selectTime(String time) {
    selectedTime.value = time;
  }

  /// Função para simular a busca de horários em um API/Banco de Dados
  void _loadAvailableTimes(DateTime day) {
    // Simulação de carregamento
    availableTimes.clear();

    // Simula horários diferentes para dias diferentes
    if (day.weekday == DateTime.saturday) {
      // Sábado tem menos horários
      availableTimes.assignAll(['09:00', '10:00', '11:00']);
    } else {
      // Dias de semana
      availableTimes.assignAll([
        '09:00',
        '10:00',
        '11:00',
        '14:00',
        '15:00',
        '16:00',
      ]);
    }
  }

  /// Retorna o status de um dia para o builder do calendário
  DayStatus getDayStatus(DateTime day) {
    // Normaliza 'day' para ignorar a hora
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedDay = DateTime(day.year, day.month, day.day);

    if (normalizedDay.isBefore(normalizedToday)) {
      return DayStatus.past;
    }
    if (diasFechados.contains(day.weekday)) {
      return DayStatus.closed;
    }
    if (diasLotados.contains(day.day)) {
      return DayStatus.full;
    }
    return DayStatus.available;
  }

  /// Função do botão de confirmação
  void confirmarAgendamento() {
    Get.back(result: true);// Volta para a Home
  }

  /// Helper para comparar datas ignorando a hora
  bool isSameDay(DateTime? a, DateTime b) {
    if (a == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
