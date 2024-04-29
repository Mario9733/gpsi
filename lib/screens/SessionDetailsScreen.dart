import 'package:flutter/material.dart';

class SessionDetailsScreen extends StatelessWidget {
  final String patientName;
  final String document;

  final String diagnosis;
  final String symptoms;
  final String treatment;

  const SessionDetailsScreen({
    Key? key,
    required this.patientName,
    required this.document,
    required this.diagnosis,
    required this.symptoms,
    required this.treatment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Detalhes da Sessão:',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Text(
              'Paciente:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              patientName,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Data:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              document,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Diagnóstico:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              diagnosis,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Sintomas:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              symptoms,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Tratamento:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              treatment,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Spacer(), // Adicionando espaço flexível
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Voltar para a tela anterior
                },
                child: Text(
                  'Voltar para Sessões',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
