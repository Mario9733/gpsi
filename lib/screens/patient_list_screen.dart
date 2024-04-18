import 'package:flutter/material.dart';

class PatientListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lista de Pacientes',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de adicionar paciente
              },
              child: Text('Adicionar Paciente'),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar Paciente',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            // Aqui você pode adicionar a lista de pacientes, se desejar
          ],
        ),
      ),
    );
  }
}
