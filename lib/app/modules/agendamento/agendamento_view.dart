// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'agendamento_controller.dart';

class AgendamentoView extends GetView<AgendamentoController> {
  const AgendamentoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Título reativo com o nome do serviço
          title: Obx(() => Text('Agendar ${controller.serviceName.value}')),
          backgroundColor: const Color(0xFF5D0890), // Cor do app
          centerTitle: true,
        ),
        body: ListView( // ListView para evitar overflow em telas pequenas
          padding: const EdgeInsets.all(16.0),
          children: [
            // 1. O CALENDÁRIO
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // Obx para reconstruir o calendário quando o foco/seleção mudar
                child: Obx(() => _buildTableCalendar()),
              ),
            ),
            const SizedBox(height: 20),
      
            // 2. A ÁREA DE HORÁRIOS
            // Obx para mostrar/esconder a área de horários
            Obx(() => _buildTimeSlotsArea()),
          ],
        ),
        // 3. O BOTÃO DE CONFIRMAÇÃO (Rodapé Fixo)
        bottomNavigationBar: _buildConfirmationButton(),
      ),
    );
  }

  /// Constrói o calendário com estilos customizados
  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'pt_BR',
      focusedDay: controller.focusedDay.value,
      firstDay: DateTime.now(), // Primeiro dia é hoje
      lastDay: DateTime.now().add(const Duration(days: 60)), // Limite de 60 dias
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => controller.isSameDay(controller.selectedDay.value, day),
      onDaySelected: controller.onDaySelected,
      onPageChanged: (focused) => controller.focusedDay.value = focused,
      
      // Constrói os dias customizados
      calendarBuilders: CalendarBuilders(
        // Builder para os dias padrão
        defaultBuilder: (context, day, focusedDay) {
          final status = controller.getDayStatus(day);
          Color? corTexto;

          if (status == DayStatus.closed || status == DayStatus.past) {
            corTexto = Colors.grey[400];
          } else if (status == DayStatus.full) {
            corTexto = Colors.red[300];
          } else {
            corTexto = Colors.black87;
          }
          
          return Center(
            child: Text(
              '${day.day}',
              style: TextStyle(color: corTexto),
            ),
          );
        },
        // Builder para dias fora do mês (para desativar)
        outsideBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              '${day.day}',
              style: TextStyle(color: Colors.grey[300]),
            ),
          );
        },
        // Builder para o dia de hoje
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5D0890).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                '${day.day}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        // Builder para o dia selecionado
        selectedBuilder: (context, day, focusedDay) {
          return Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF5D0890), // Cor principal
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                '${day.day}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Constrói a área de horários disponíveis
  Widget _buildTimeSlotsArea() {
    // Se nenhum dia estiver selecionado, não mostra nada
    if (controller.selectedDay.value == null) {
      return const Center(child: Text('Selecione um dia no calendário.'));
    }
    
    // Se não houver horários, mostra mensagem
    if (controller.availableTimes.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text('Nenhum horário disponível para este dia.'),
      ));
    }

    // Se houver horários, mostra o grid
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Horários disponíveis',
          style: Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // O Wrap permite que os botões quebrem a linha
        Wrap(
          spacing: 12.0, // Espaço horizontal
          runSpacing: 12.0, // Espaço vertical
          children: controller.availableTimes.map((time) {
            // Obx para o estado de seleção de cada botão
            return Obx(() {
              final isSelected = controller.selectedTime.value == time;
              return ChoiceChip(
                label: Text(time),
                selected: isSelected,
                onSelected: (selected) {
                  controller.selectTime(time);
                },
                selectedColor: const Color(0xFF5D0890),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            });
          }).toList(),
        ),
      ],
    );
  }

  /// Constrói o botão de confirmação no rodapé
  Widget _buildConfirmationButton() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Obx(() => ElevatedButton(
            // O botão fica desabilitado se a condição não for atendida
            onPressed: controller.isConfirmationButtonEnabled
                ? controller.confirmarAgendamento
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5D0890),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Texto reativo
            child: Text(controller.confirmationText),
          )),
    );
  }
}