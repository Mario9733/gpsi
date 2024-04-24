import 'package:flutter/material.dart';

class SessionDetailsScreen extends StatelessWidget {
  final String diagnosis;

  const SessionDetailsScreen({Key? key, required this.diagnosis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Sessão'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Diagnóstico: $diagnosis',
              style: TextStyle(fontSize: 24),
            ),
            // Adicione aqui mais campos para exibir outros detalhes da sessão
          ],
        ),
      ),
    );
  }
}
