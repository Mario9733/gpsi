import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Session {
  final String symptoms;
  final String diagnosis;
  final String treatment;
  final DateTime nextSessionDate;

  Session({
    required this.symptoms,
    required this.diagnosis,
    required this.treatment,
    required this.nextSessionDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'nextSessionDate': DateFormat('dd/MM/yyyy').format(nextSessionDate),
    };
  }
}
