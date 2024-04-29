import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:gpsi/screens/session_list_screen.dart';
import 'package:gpsi/screens/home_screen.dart'; // Importe sua tela de home aqui

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Text(
              'Agenda de Sessões',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: _buildSessionList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()), // Direciona para a tela home
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Sair', style: TextStyle(color: Colors.indigo, fontSize: 20)),
            ),
            SizedBox(height: 20.0), // Adiciona espaço após o botão "Sair"
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Center(child: Text('Usuário não autenticado'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(currentUser.email!) // Coleção principal com o nome do e-mail do usuário
          .doc('sessoes')
          .collection('sessoes')
          .orderBy('nextSessionDate')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Sem sessões agendadas'));
        }

        final sessions = snapshot.data!.docs;

        return ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            final sessionData = sessions[index].data() as Map<String, dynamic>;
            final patientId = sessionData['patientId'];
            final nextSessionDateData = sessionData['nextSessionDate'];
            final nextSessionTimeHour = sessionData['nextSessionTimeHour'];
            final nextSessionTimeMinute = sessionData['nextSessionTimeMinute'];

            // Verifica se nextSessionTimeHour e nextSessionTimeMinute não são nulos
            if (nextSessionTimeHour == null || nextSessionTimeMinute == null) {
              return ListTile(
                title: Text('Horário da sessão inválido'),
              );
            }

            final nextSessionTime = TimeOfDay(hour: nextSessionTimeHour, minute: nextSessionTimeMinute);
            final formattedNextSessionTime = '${nextSessionTime.hour}:${nextSessionTime.minute.toString().padLeft(2, '0')}';
            final formattedNextSessionDateTime = _formatDateTime(nextSessionDateData);

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection(currentUser.email!).doc('pacientes').collection('pacientes').doc(patientId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(
                    title: Text('Carregando...'),
                  );
                }

                if (snapshot.hasError) {
                  return ListTile(
                    title: Text('Erro ao carregar nome do paciente'),
                  );
                }

                final patientData = snapshot.data?.data() as Map<String, dynamic>?;

                if (patientData == null) {
                  return ListTile(
                    title: Text('Paciente não encontrado'),
                  );
                }

                final patientName = patientData['name'] ?? 'Nome do Paciente Indisponível';

                return ListTile(
                  title: Text(
                    patientName,
                    style: TextStyle(color: Colors.white), // Cor branca para o nome do paciente
                  ),
                  subtitle: Text(
                    'Próxima sessão: $formattedNextSessionDateTime $formattedNextSessionTime',
                    style: TextStyle(color: Colors.white), // Cor branca para a data e hora da sessão
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SessionListScreen(patientId: patientId, patientName: patientName)), // Direciona para a página de sessões do usuário
                      );
                    },
                    child: Text('Sessões'),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String _formatDateTime(dynamic dateTime) {
    if (dateTime is Timestamp) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime.toDate());
      final formattedTime = DateFormat('HH:mm').format(dateTime.toDate());

      // Verifica se a hora é 00:00 e ajusta a exibição
      if (formattedTime == '00:00') {
        return '$formattedDate'; // Retorna apenas a data
      } else {
        return '$formattedDate às $formattedTime'; // Retorna a data e a hora
      }
    } else if (dateTime is String) {
      final parsedDateTime = DateTime.tryParse(dateTime);
      if (parsedDateTime != null) {
        final formattedDate = DateFormat('dd/MM/yyyy').format(parsedDateTime);
        final formattedTime = DateFormat('HH:mm').format(parsedDateTime);

        // Verifica se a hora é 00:00 e ajusta a exibição
        if (formattedTime == '00:00') {
          return '$formattedDate'; // Retorna apenas a data
        } else {
          return '$formattedDate às $formattedTime'; // Retorna a data e a hora
        }
      }
    }
    return 'Data inválida';
  }
}
