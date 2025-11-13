
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Encontra o controller que já foi inicializado pelo Binding
    final controller = Get.find<AgendamentoController>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // Obx para reconstruir o calendário quando o foco/seleção mudar
        child: Obx(() => TableCalendar(
              locale: 'pt_BR',
              focusedDay: controller.focusedDay.value,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 60)),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) =>
                  controller.isSameDay(controller.selectedDay.value, day),
              onDaySelected: controller.onDaySelected,
              onPageChanged: (focused) => controller.focusedDay.value = focused,
              
              // Adicionamos a correção da rolagem
              availableGestures: AvailableGestures.horizontalSwipe,

              // Constrói os dias customizados
              calendarBuilders: CalendarBuilders(
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
                      child: Text('${day.day}', style: TextStyle(color: corTexto)));
                },
                outsideBuilder: (context, day, focusedDay) {
                  return Center(
                      child: Text('${day.day}',
                          style: TextStyle(color: Colors.grey[300])));
                },
                todayBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF5D0890).withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text('${day.day}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF5D0890),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}