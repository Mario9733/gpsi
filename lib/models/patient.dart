import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Definição do modelo Patient
class Patient {
  final String name;
  final String fatherName;
  final String motherName;
  final String cpf;
  final String dob;
  final String phone;
  final String healthPlan;
  final String bloodType;
  final String address;
  final String email;

  Patient({
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.cpf,
    required this.dob,
    required this.phone,
    required this.healthPlan,
    required this.bloodType,
    required this.address,
    required this.email,
  });

  // Método para converter o objeto Patient em um mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fatherName': fatherName,
      'motherName': motherName,
      'cpf': cpf,
      'dob': dob,
      'phone': phone,
      'healthPlan': healthPlan,
      'bloodType': bloodType,
      'address': address,
      'email': email,
    };
  }
}
