import 'package:flutter/material.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Agenda de Sessões',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            // Aqui você pode adicionar o calendário e a lista de sessões
          ],
        ),
      ),
    );
  }
}
