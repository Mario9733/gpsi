import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Session {
  final String symptoms;
  final String diagnosis;
  final String treatment;
  final DateTime nextSessionDate;
  final TimeOfDay nextSessionTime; // Novo campo para armazenar a hora da próxima sessão

  Session({
    required this.symptoms,
    required this.diagnosis,
    required this.treatment,
    required this.nextSessionDate,
    required this.nextSessionTime,
  });

  Map<String, dynamic> toJson() {
    String formattedTime = '${nextSessionTime.hour}:${nextSessionTime.minute.toString().padLeft(2, '0')}'; // Formata a hora no formato HH:mm
    return {
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'nextSessionDate': DateFormat('dd/MM/yyyy').format(nextSessionDate),
      'nextSessionTime': formattedTime, // Adiciona a hora da próxima sessão ao mapa JSON
    };
  }
}
