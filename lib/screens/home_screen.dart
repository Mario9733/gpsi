import 'package:flutter/material.dart';
import 'package:gpsi/models/patient.dart';
import 'package:gpsi/screens/patient_list_screen.dart';
import 'package:gpsi/screens/agenda_screen.dart';
import 'package:gpsi/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo, // Define a cor de fundo para azul
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 1, // 100% da largura da tela
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            SizedBox(height: 80.0),
             Image.asset(
              'assets/images/2.png',
              width: 200,
              height: 200.0,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Pacientes', style: TextStyle(color: Colors.indigo, fontSize: 20)),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgendaScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Agenda', style: TextStyle(color: Colors.indigo, fontSize: 20)),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Direciona para a tela de login
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Sair', style: TextStyle(color: Colors.indigo, fontSize: 20)),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}